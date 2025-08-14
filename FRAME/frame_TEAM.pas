unit frame_TEAM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Themes, dmSCM, SCMHelpers, SCMDefines,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, Vcl.WinXCtrls, Vcl.Buttons;

type
  TframeTEAM = class(TFrame)
    Grid: TDBGrid;
    GridEntrant: TDBGrid;
    imgcollTEAM: TImageCollection;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    rpnlTeamEntrantTools: TRelativePanel;
    spbtnAddSlot: TSpeedButton;
    spbtnMoveDownSlot: TSpeedButton;
    spbtnMoveUpSlot: TSpeedButton;
    spbtnRemoveSlot: TSpeedButton;
    spbtnTeamEntrantClear: TSpeedButton;
    spbtnTeamEntrantStrike: TSpeedButton;
    Splitter1: TSplitter;
    vimglistTEAM: TVirtualImageList;
    procedure GridCellClick(Column: TColumn);
    procedure GridColEnter(Sender: TObject);
    procedure GridColExit(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridEditButtonClick(Sender: TObject);
    procedure GridEnter(Sender: TObject);
    procedure GridEntrantDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridEntrantEditButtonClick(Sender: TObject);
    procedure GridEntrantEnter(Sender: TObject);
    procedure spbtnAddSlotClick(Sender: TObject);
    procedure spbtnRemoveSlotClick(Sender: TObject);
    procedure spbtnTeamEntrantClearClick(Sender: TObject);
    procedure spbtnTeamEntrantStrikeClick(Sender: TObject);
  private
    fGridBgColor: TColor;
    fEditBoxFocused: TColor;
    fEditBoxNormal: TColor;
    fRacedFontColor: TColor;
    fApplicationBgColor: TColor;
    fEnableSplitTimes: boolean;
    fTeamActiveGrid: Integer;


    // ASSERT CONNECTION TO MSSQL DATABASE
    function AssertConnection(): boolean;
    function TeamEntrantPadSlots(aTeamID: Integer): Integer;
    function TeamEntrantSumTTB(aTeamID: Integer): Integer;
    function UpdateTeamTTB(aTeamID, milliseconds: Integer): Integer;
  public
    fIsScratchedDCode: integer;
    fIsDisqualifiedDCode: integer;
    procedure AfterConstruction; override;
    function ClearLane(): Integer;
    function ClearSlot(): Integer;
    procedure GridMoveDown(Sender: TObject);
    procedure GridMoveUp(Sender: TObject);
    procedure SlotMoveDown(Sender: TObject);
    procedure SlotMoveUp(Sender: TObject);
    function RenumberLanes(): Integer;
    function StrikeLane(): Integer;
    function StrikeSlot(): Integer;
    procedure TeamEntrantScroll();
    procedure TeamScroll();
    procedure ToggleDCode(DoEnable: boolean);

    property TeamActiveGrid: Integer read fTeamActiveGrid;
    property EnableSplitTimes: boolean read fEnableSplitTimes
      write fEnableSplitTimes;
  end;

implementation

{$R *.dfm}

{ TframeTEAM }
uses dlgEntrantPickerCTRL, dlgEntrantPicker, dlgDCodePicker, System.UITypes,
  dlgTeamNameMenu, dmSCMHelper, dlgTeamNamePicker, DateUtils,
  dlgSplitTimeTEAM;

procedure TframeTEAM.AfterConstruction;
var
  css: TCustomStyleServices;
begin
  inherited;
  fTeamActiveGrid := 1;
  fEnableSplitTimes := false;
  // Special color assignment - used in TDBGrid painting...
  // -------------------------------------------
  css := TStyleManager.Style[TStyleManager.ActiveStyle.Name];
  if Assigned(css) then
  begin
    fEditBoxFocused := css.GetStyleFontColor(sfEditBoxTextFocused);
    fEditBoxNormal := css.GetStyleFontColor(sfEditBoxTextNormal);
    fGridBgColor := css.GetStyleColor(scGrid);
    fApplicationBgColor := css.GetStyleColor(scPanel);
    fRacedFontColor := clWebPeachPuff;
  end
  else
  begin
    fEditBoxFocused := clWebTomato;
    fEditBoxNormal := clWindowText;
    fGridBgColor := clAppWorkSpace;
    fApplicationBgColor := clAppWorkSpace;
    fRacedFontColor := clWebPeachPuff;
  end;

  Panel1.BorderWidth := 2;
  Panel3.BorderWidth := 2;

  {
    When the Columns.State property of the grid is csDefault, grid columns
    are dynamically generated from the visible fields of the dataset and the
    order of columns in the grid matches the order of fields in the dataset.
  }
  Grid.Columns.State := csDefault;
  Grid.Options := Grid.Options - [dgAlwaysShowEditor];
  Grid.Options := Grid.Options + [dgEditing];

  GridEntrant.Columns.State := csDefault;
  GridEntrant.Options := GridEntrant.Options - [dgAlwaysShowEditor];
  GridEntrant.Options := GridEntrant.Options + [dgEditing];

  fIsScratchedDCode := 0;
  fIsDisqualifiedDCode := 0;


end;

function TframeTEAM.AssertConnection: boolean;
begin
  result := false;
  if Assigned(SCM) then
  begin
    // IsActive if TFDConnection::scmConnection && FireDAC tables are active
    if SCM.IsActive then result := true;
  end;
end;

function TframeTEAM.ClearLane(): Integer;
var
  aTeamID: Integer;
begin
  result := 0;
  if fTeamActiveGrid = 1 then
  begin
    aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;
    Grid.EditorMode := false;
    result := SCM.IndvTeam_ClearLane(aTeamID, etTeam, true);
    if result > 0 then Grid.DataSource.DataSet.Refresh;
  end
end;

function TframeTEAM.ClearSlot: Integer;
var
  aTeamEntrantID: Integer;
begin
  result := 0;
  aTeamEntrantID := SCM.dsTeamEntrant.DataSet.FieldByName('TeamEntrantID')
    .AsInteger;
  if aTeamEntrantID > 0 then result := SCM.TeamEntrant_Clear(aTeamEntrantID);
end;

procedure TframeTEAM.GridCellClick(Column: TColumn);
begin
  if not Assigned(Column.Field) then exit;

  // --------------------------------------------------------------------
  // H A N D L E   A   C U S T O M   P A I N T E D   C H E C K B O X .
  // --------------------------------------------------------------------
  if (Column.Field.DataType = ftBoolean) then
  begin


    Grid.BeginUpdate;
    Column.Grid.DataSource.DataSet.Edit;
    { toggle DB BIT state}
    Column.Field.value := not Column.Field.AsBoolean;
    { NULL DCODE}
    Column.Grid.DataSource.DataSet.FieldByName('DisqualifyCodeID').Clear;
    { Assign a 'special scm DCODE ' : if registered. }
    if (Column.Field.AsBoolean = true) then
    begin
      // scratched.
      if Column.FieldName = 'IsScratched' then
      begin
        if (fIsScratchedDCode <> 0) then
          Column.Grid.DataSource.DataSet.FieldByName('DisqualifyCodeID')
            .AsInteger := fIsScratchedDCode;
      end;
      // Disqualified.
      if Column.FieldName = 'IsDisqualified' then
      begin
        if (fIsDisqualifiedDCode <> 0) then
          Column.Grid.DataSource.DataSet.FieldByName('DisqualifyCodeID')
            .AsInteger := fIsDisqualifiedDCode;
      end;
    end;
    Column.Grid.DataSource.DataSet.Post;
    Grid.EndUpdate;
  end;

end;

procedure TframeTEAM.GridColEnter(Sender: TObject);
var
  fld: TField;
begin
  {
    ONLY TIME [dgEditing] is DISABLED.
    When moving into a col with custom painted checkboxes, the [dgEditing]
    must be killed. Else, two clicks of the checkbox reveal the inline
    editbox, hiding the cell's custom painted checkbox.
  }
  fld := Grid.SelectedField;
  if Assigned(fld) then
  begin
    if (fld.FieldName = 'RaceTime') or (fld.FieldName = 'DCode') or
      (fld.FieldName = 'TeamName') then
    begin
      Grid.Options := Grid.Options + [dgEditing];
      Grid.EditorMode := true;
    end
    else if (fld.FieldName = 'IsScratched') or (fld.FieldName = 'IsDisqualified')
    then
    begin
      Grid.EditorMode := false;
      Grid.Options := Grid.Options - [dgEditing];
    end;
  end
end;

procedure TframeTEAM.GridColExit(Sender: TObject);
var
  fld: TField;
begin
  // ONLY TIME [dgEditing] is RE-ENABLED.
  fld := Grid.SelectedField;
  if Assigned(fld) then
  begin
    Grid.Options := Grid.Options + [dgEditing];
    Grid.EditorMode := false;
  end
end;

procedure TframeTEAM.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  clFont, clBg: TColor;
  Size: TSize;
  MyRect: TRect;
  aHeatID: Integer;
  YMargin: Integer;

begin
  aHeatID := TDBGrid(Sender).DataSource.DataSet.FieldByName('HeatID').AsInteger;
  if (Column.Field.FieldName = 'TeamName') or (Column.FieldName = 'DCode') then
  begin
    // ASSERT button visible in column
    if (Column.ButtonStyle <> TColumnButtonStyle.cbsEllipsis) then
        Column.ButtonStyle := TColumnButtonStyle.cbsEllipsis;
  end;

  // Required to suppress unnecessary additional paints.
  if (Column.Field.FieldName = 'RaceTime') then
  begin
    if fEnableSplitTimes then
    begin
      if (Column.ButtonStyle <> TColumnButtonStyle.cbsEllipsis) then
          Column.ButtonStyle := TColumnButtonStyle.cbsEllipsis
    end
    else
    begin
      if (Column.ButtonStyle = TColumnButtonStyle.cbsEllipsis) then
          Column.ButtonStyle := TColumnButtonStyle.cbsNone;
    end;
  end;

  // NOTE : DEFAULT DRAWING IS DISABLED ....
  if (Column.Field.FieldName = 'IsScratched') or
    (Column.Field.FieldName = 'IsDisqualified') then
  begin
    if gdFocused in State then clFont := fEditBoxFocused
    else clFont := fEditBoxNormal;
    clBg := fGridBgColor;
    TDBGrid(Sender).DrawCheckBoxes(Grid, Rect, Column, clFont, clBg);
    // draw 'Focused' frame  (for boolean datatype only)
    if gdFocused in State then Grid.Canvas.DrawFocusRect(Rect);
  end
  // Recolor the text if the heat is RACED.
  else if (SCM.Heat_HeatStatusID(aHeatID) = 2) then
  begin
    // CLEAR THE CANVAS
    TDBGrid(Sender).Canvas.Brush.Color := fGridBgColor;
    TDBGrid(Sender).Canvas.Brush.Style := bsSolid;
    TDBGrid(Sender).Canvas.FillRect(Rect);
    // PRINT THE TEXT
    TDBGrid(Sender).Canvas.Font.Color := fRacedFontColor;
    Size := TDBGrid(Sender).Canvas.TextExtent(Column.Field.DisplayText);
    YMargin := Round((Rect.Height - Size.Height) / 2 + 0.5);
    // calculate margins
    MyRect.Top := Rect.Top + YMargin;
    if (Column.Field.FieldName = 'Lane') then
      // center align
        MyRect.Left := Rect.Left + Round((Rect.Width - Size.Width) / 2)
      // right align
    else if (Column.Field.FieldName = 'RaceTime') or
      (Column.Field.FieldName = 'TTB') or
      (Column.Field.FieldName = 'PersonalBest') then
        MyRect.Left := Rect.Left + (Rect.Width - Size.Width - 3)
    else
      // left align
        MyRect.Left := Rect.Left + 3;
    MyRect.Bottom := Rect.Bottom;
    MyRect.Right := Rect.Right;
    TDBGrid(Sender).Canvas.TextRect(MyRect, MyRect.Left, MyRect.Top,
      Column.Field.DisplayText);
    if gdFocused in State then Grid.Canvas.DrawFocusRect(Rect);
  end
  else
  begin
    Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then Grid.Canvas.DrawFocusRect(Rect);
  end;
end;

procedure TframeTEAM.GridEditButtonClick(Sender: TObject);
var
  dlgDCode: TDCodePicker;
  dlgPickTeam: TTeamNamePicker;
  dlgSplitTimeTEAM: TSplitTimeTEAM;
  aTeamID, rows: Integer;
  rtnValue: TModalResult;
  fld: TField;
  aRect: TRect;
  pt: TPoint;
begin
  if not AssertConnection then exit;

  aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;

  // ---------------------------------
  // Disqualification code - DCODE
  fld := TDBGrid(Sender).SelectedField;
  if fld.FieldName = 'DCode' then
  begin
    dlgDCode := TDCodePicker.CreateWithConnection(self, SCM.scmConnection);
    dlgDCode.TeamID := aTeamID;
    rtnValue := dlgDCode.ShowModal;
    dlgDCode.Free;
    if IsPositiveResult(rtnValue) then
    begin
      SCM.dsTeam.DataSet.DisableControls;
      Grid.DataSource.DataSet.Refresh; // NOTE: relocate not required.
      SCM.dsTeam.DataSet.EnableControls;
    end;
  end
  // ---------------------------------
  // Relay TEAMNAME 'name picker'.
  else if fld.FieldName = 'TeamName' then
  begin
    dlgPickTeam := TTeamNamePicker.Create(self);
    dlgPickTeam.Prepare(SCM.scmConnection, aTeamID);
    dlgPickTeam.Position := poDesigned;
    pt := Mouse.CursorPos;
    aRect := TDBGrid(Sender).GetCellRect(pt);
    dlgPickTeam.Left := aRect.Left;
    dlgPickTeam.Top := aRect.Top;
    rtnValue := dlgPickTeam.ShowModal;
    dlgPickTeam.Free;
    if IsPositiveResult(rtnValue) then
    begin
      SCM.dsTeam.DataSet.Refresh; // Repaint the teamname selected.
      if GridEntrant.DataSource.DataSet.IsEmpty or
        (GridEntrant.DataSource.DataSet.RecordCount < 4) then
      begin
        // Pad out missing slots - AUTO CREATE 4xTeamEntrants
        rows := TeamEntrantPadSlots(aTeamID);
        if (rows > 0) then GridEntrant.DataSource.DataSet.Refresh;
      end;
    end;
  end
  else if fld.FieldName = 'RaceTime' then
  begin
    SCM.dsTeam.DataSet.CheckBrowseMode;
    dlgSplitTimeTEAM := TSplitTimeTEAM.CreateWithConnection(self,
      SCM.scmConnection);
    dlgSplitTimeTEAM.TeamID := aTeamID;
    rtnValue := dlgSplitTimeTEAM.ShowModal;
    dlgSplitTimeTEAM.Free;
    if IsPositiveResult(rtnValue) then
    begin
      SCM.dsTeam.DataSet.Refresh; // Repaint the teamname selected.
    end;
  end;
end;

procedure TframeTEAM.GridEnter(Sender: TObject);
begin
  fTeamActiveGrid := 1;
  Panel1.BevelEdges := [beLeft, beTop, beRight, beBottom];
  Panel3.BevelEdges := [];
  if Grid.DataSource.DataSet.FieldByName('TeamNameID').IsNull then
  begin
    rpnlTeamEntrantTools.Visible := false;
    GridEntrant.Visible := false;
  end
  else
  begin
    GridEntrant.Visible := true;
    rpnlTeamEntrantTools.Visible := true;
  end;

  // Ensure that correct editing options are applied on
  // first use. SelectedIndex defaults to the first column,
  // if you tab into the grid or your first click goes to
  // the first column then OnColEnter doesn't fire.
  GridColEnter(Grid);
end;

procedure TframeTEAM.GridEntrantDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  clFont, clBg: TColor;
  Size: TSize;
  MyRect: TRect;
  aHeatID: Integer;
  YMargin: Integer;

begin
  aHeatID := Grid.DataSource.DataSet.FieldByName('HeatID').AsInteger;
  if (Column.Field.FieldName = 'FullName') or (Column.FieldName = 'DCode') then
  begin
    // ASSERT button visible in column
    if (Column.ButtonStyle <> TColumnButtonStyle.cbsEllipsis) then
        Column.ButtonStyle := TColumnButtonStyle.cbsEllipsis;
  end;

  // NOTE : DEFAULT DRAWING IS DISABLED ....
  if (Column.Field.FieldName = 'IsScratched') or
    (Column.Field.FieldName = 'IsDisqualified') then
  begin
    if gdFocused in State then clFont := fEditBoxFocused
    else clFont := fEditBoxNormal;
    clBg := fGridBgColor;
    TDBGrid(Sender).DrawCheckBoxes(TDBGrid(Sender), Rect, Column, clFont, clBg);
    // draw 'Focused' frame  (for boolean datatype only)
    if gdFocused in State then TDBGrid(Sender).Canvas.DrawFocusRect(Rect);
  end
  // Recolor the text if the heat is RACED.
  else if (SCM.Heat_HeatStatusID(aHeatID) = 2) then
  begin
    // CLEAR THE CANVAS
    TDBGrid(Sender).Canvas.Brush.Color := fGridBgColor;
    TDBGrid(Sender).Canvas.Brush.Style := bsSolid;
    TDBGrid(Sender).Canvas.FillRect(Rect);
    // PRINT THE TEXT
    TDBGrid(Sender).Canvas.Font.Color := fRacedFontColor;
    Size := TDBGrid(Sender).Canvas.TextExtent(Column.Field.DisplayText);
    YMargin := Round((Rect.Height - Size.Height) / 2 + 0.5);
    // calculate margins
    MyRect.Top := Rect.Top + YMargin;
    // Right align
    if (Column.Field.FieldName = 'RaceTime') or
      (Column.Field.FieldName = 'TTB') or
      (Column.Field.FieldName = 'PersonalBest') then
        MyRect.Left := Rect.Left + (Rect.Width - Size.Width - 3)
    else
      // left align
        MyRect.Left := Rect.Left + 3;
    MyRect.Bottom := Rect.Bottom;
    MyRect.Right := Rect.Right;
    TDBGrid(Sender).Canvas.TextRect(MyRect, MyRect.Left, MyRect.Top,
      Column.Field.DisplayText);
    if gdFocused in State then TDBGrid(Sender).Canvas.DrawFocusRect(Rect);
  end
  else
  begin
    TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then TDBGrid(Sender).Canvas.DrawFocusRect(Rect);
  end;
end;

procedure TframeTEAM.GridEntrantEditButtonClick(Sender: TObject);
var
  passed: boolean;
  dlg: TEntrantPicker;
  dlgCntrl: TEntrantPickerCTRL;
  dlgDCode: TDCodePicker;
  aTeamEntrantID, aTeamID, Lane, rows: Integer;
  rtnValue: TModalResult;
  fld: TField;
  v: variant;
  CTRLPress: smallint;
  SQL: string;
  TOT: Integer;
begin
  if not AssertConnection then exit;
  rtnValue := mrCancel;
  aTeamEntrantID := 0;


  CTRLPress := (GetKeyState(VK_CONTROL) and 128); // grab the keyboard state
  fld := TDBGrid(Sender).SelectedField; // only using field : 'fullname'

  if SCM.dsTeam.DataSet.Active and not SCM.dsTeam.DataSet.FieldByName('TeamID').IsNull
  then aTeamID := SCM.dsTeam.DataSet.FieldByName('TeamID').AsInteger
  else aTeamID := 0;

  if (fld.FieldName = 'DCode') and (aTeamID <> 0)then
  begin
    if not SCM.dsEntrant.DataSet.FieldByName('MemberID').IsNull then
    begin
      dlgDCode := TDCodePicker.CreateWithConnection(self, SCM.scmConnection);
      dlgDCode.TeamID := aTeamID;
      rtnValue := dlgDCode.ShowModal;
      dlgDCode.Free;
      if IsPositiveResult(rtnValue) then
      begin
        SCM.dsTeam.DataSet.Refresh;
        // SCM.Team_Locate(aTeamID);
      end;
    end;
  end
  // handle the ellipse entrant
  else if (fld.FieldName = 'FullName') and (aTeamID <> 0) then
  begin
    // TEST - CREATE - RELAY TEAM MEMBER
    with SCM.dsTeamEntrant.DataSet do
    begin
      if IsEmpty or FieldByName('TeamEntrantID').IsNull then
      begin
        if IsEmpty then Lane := 1
        else Lane := SCM.TeamEntrant_LastLaneNum(aTeamID) + 1;
        SQL := 'INSERT INTO [SwimClubMeet2].[dbo].[TeamEntrant] ' +
          '( [Lane],[IsDisqualified],[IsScratched],[TeamID]) ' +
          'VALUES ( :ID1,0,0,:ID2)';
        rows := SCM.scmConnection.ExecSQL(SQL, [Lane, aTeamID]);
        if rows > 0 then
        begin
          // return IDENTITY;
          SQL := 'SELECT IDENT_CURRENT(''dbo.TeamEntrant'') AS aID';
          v := SCM.scmConnection.ExecSQLScalar(SQL);
          if not VarIsNull(v) and not VarIsEmpty(v) then
          begin
            aTeamEntrantID := v;
            SCM.TeamEntrant_Locate(aTeamEntrantID);
          end;
        end;
      end
      else aTeamEntrantID := FieldByName('TeamEntrantID').AsInteger;
    end;
    if aTeamEntrantID <> 0 then
    begin
      if (CTRLPress = 128) then
      begin
        dlgCntrl := TEntrantPickerCTRL.Create(self);
        passed := dlgCntrl.Prepare(SCM.scmConnection, aTeamEntrantID, etTeam);
        if passed then rtnValue := dlgCntrl.ShowModal;
        dlgCntrl.Free;
      end
      else
      begin
        dlg := TEntrantPicker.Create(self);
        passed := dlg.Prepare(SCM.scmConnection, aTeamEntrantID, etTeam);
        if passed then rtnValue := dlg.ShowModal;
        dlg.Free;
      end;
      // require a refresh to update members details
      if passed and IsPositiveResult(rtnValue) then
      begin
        // REDRAW THE CHANGES ...
        SCM.dsTeamEntrant.DataSet.Refresh;
        // Update the TTB in Team.
        TOT := TeamEntrantSumTTB(aTeamID);
        UpdateTeamTTB(aTeamID, TOT);
        // Requery SCM.qryEvent to update entrant count.
        PostMessage(TForm(Owner).Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
        // Set flag for statusbar update.
        // PostMessage(TForm(Owner).Handle, SCM_UPDATESTATUSBAR, 0, 0);
      end
    end;
  end;

end;

procedure TframeTEAM.GridEntrantEnter(Sender: TObject);
begin
  fTeamActiveGrid := 2;
  Panel3.BevelEdges := [beLeft, beTop, beRight, beBottom];
  Panel1.BevelEdges := [];
end;

procedure TframeTEAM.GridMoveDown(Sender: TObject);
var
  success: boolean;
  MaxLane: Integer;
  aDataSet: TDataSet;
begin
  aDataSet := Grid.DataSource.DataSet;
  MaxLane := SCM.SwimClub_NumberOfLanes;
  if (aDataSet.FieldByName('Lane').AsInteger = MaxLane) then
  begin
    success := SCM.MoveDownToNextHeat(aDataSet);
    // Move Team to next heat (By default, will position on first entrant.)
    { TODO -oBSA -cGeneral : CHECK that this routine works for Team. }
    SCM.dsHeat.DataSet.Next;
  end
  else success := SCM.MoveDownLane(aDataSet);
  if not success then beep;
end;

procedure TframeTEAM.GridMoveUp(Sender: TObject);
var
  success: boolean;
  aDataSet: TDataSet;
begin
  aDataSet := Grid.DataSource.DataSet;
  if (aDataSet.FieldByName('Lane').AsInteger = 1) then
  begin
    success := SCM.MoveUpToPrevHeat(aDataSet); // Locate Team to 'prior' heat.
    { TODO -oBSA -cGeneral : CHECK that this routine works for Entrant/Team. }
    SCM.dsHeat.DataSet.Prior; // move to the previous heat ....
    aDataSet.Last; // move to last entrant ....
  end
  else
    // Generic move for either Team or TeamEntrant
      success := SCM.MoveUpLane(aDataSet);
  if not success then beep;
end;

function TframeTEAM.RenumberLanes: Integer;
var
  aHeatID: Integer;
begin
  result := 0;
  if fTeamActiveGrid = 1 then
  begin
    aHeatID := Grid.DataSource.DataSet.FieldByName('HeatID').AsInteger;
    result := SCM.Lane_RenumberLanes(aHeatID);
    if Grid.CanFocus then Grid.SetFocus;
  end
  else if fTeamActiveGrid = 2 then
  begin
    // aTeamEntrantID := GridEntrant.DataSource.DataSet.FieldByName
    // ('TeamEntrantID').AsInteger;
  end;
end;

procedure TframeTEAM.SlotMoveDown(Sender: TObject);
var
  aTeamID, TOT: Integer;
begin
  SCM.MoveDownLane(GridEntrant.DataSource.DataSet); // move TeamEntrant
  aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;
  TOT := TeamEntrantSumTTB(aTeamID);
  UpdateTeamTTB(aTeamID, TOT);
  GridEntrant.DataSource.DataSet.Refresh;
  // Grid.DataSource.DataSet.Refresh;
  // SCM.IndvTeam_LocateLane(aTeamID, etTEAM);
end;

procedure TframeTEAM.SlotMoveUp(Sender: TObject);
var
  aTeamID, TOT: Integer;
begin
  SCM.MoveUpLane(GridEntrant.DataSource.DataSet); // move TeamEntrant
  aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;
  TOT := TeamEntrantSumTTB(aTeamID);
  UpdateTeamTTB(aTeamID, TOT);
  GridEntrant.DataSource.DataSet.Refresh;
  // Grid.DataSource.DataSet.Refresh;
  // SCM.IndvTeam_LocateLane(aTeamID, etTEAM);
end;

procedure TframeTEAM.spbtnAddSlotClick(Sender: TObject);
var
  aTeamID, TOT: Integer;
begin
  if not SCM.IsActive then exit;
  if Grid.DataSource.DataSet.IsEmpty or Grid.DataSource.DataSet.FieldByName
    ('TeamNameID').IsNull then exit;

  aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;
  if SCM.TeamEntrant_AddSlot(aTeamID) > 0 then
  begin
    GridEntrant.DataSource.DataSet.Refresh;
    aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;
    TOT := TeamEntrantSumTTB(aTeamID);
    UpdateTeamTTB(aTeamID, TOT);
    Grid.DataSource.DataSet.Refresh;
  end;
end;

procedure TframeTEAM.spbtnRemoveSlotClick(Sender: TObject);
var
  aTeamEntrantID, aTeamID, TOT: Integer;
begin
  if not SCM.IsActive then exit;
  // must have lanes and the active lane must have a team name assigned.
  if Grid.DataSource.DataSet.IsEmpty or Grid.DataSource.DataSet.FieldByName
    ('TeamNameID').IsNull then exit;
  // can't remove a slot if it's filled with a swimmer
  if not GridEntrant.DataSource.DataSet.FieldByName('MemberID').IsNull then
      exit;
  // finalize editing
  GridEntrant.EditorMode := false;
  GridEntrant.DataSource.DataSet.CheckBrowseMode;
  // one slot must remain
  if (GridEntrant.DataSource.DataSet.RecordCount <= 1) then exit;

  aTeamEntrantID := GridEntrant.DataSource.DataSet.FieldByName('TeamEntrantID')
    .AsInteger;
  if (SCM.TeamEntrant_RemoveSlot(aTeamEntrantID) > 0) then
  begin
    aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;
    TOT := TeamEntrantSumTTB(aTeamID);
    UpdateTeamTTB(aTeamID, TOT);
    GridEntrant.DataSource.DataSet.Refresh;
    // Grid.DataSource.DataSet.Refresh;
    // SCM.IndvTeam_LocateLane(aTeamID, etTEAM);
  end;
end;

procedure TframeTEAM.spbtnTeamEntrantClearClick(Sender: TObject);
var
  aTeamEntrantID, aTeamID, TOT: Integer;
begin
  if not SCM.IsActive then exit;
  if Grid.DataSource.DataSet.IsEmpty or Grid.DataSource.DataSet.FieldByName
    ('TeamNameID').IsNull then exit;

  aTeamEntrantID := GridEntrant.DataSource.DataSet.FieldByName('TeamEntrantID')
    .AsInteger;
  if SCM.TeamEntrant_Clear(aTeamEntrantID) > 0 then
  begin
    aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;
    TOT := TeamEntrantSumTTB(aTeamID);
    UpdateTeamTTB(aTeamID, TOT);
    GridEntrant.DataSource.DataSet.Refresh;
    // Requery SCM.qryEvent to update entrant count.
    PostMessage(TForm(Owner).Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
    // Set flag for statusbar update
    // PostMessage(TForm(Owner).Handle, SCM_UPDATESTATUSBAR, 0, 0);
  end;
end;

procedure TframeTEAM.spbtnTeamEntrantStrikeClick(Sender: TObject);
var
  aTeamEntrantID, aTeamID, TOT: Integer;
  rtnValue: Integer;
  Msg: string;
begin
  if not SCM.IsActive then exit;
  if Grid.DataSource.DataSet.IsEmpty or Grid.DataSource.DataSet.FieldByName
    ('TeamNameID').IsNull then exit;

  Msg := 'Do you want to clear the team slot and unnominate the swimmer?';
  rtnValue := MessageDlg(Msg, mtConfirmation, [mbNo, mbYes], 0, mbYes);
  if (rtnValue = mrYes) then
  begin
    aTeamEntrantID := GridEntrant.DataSource.DataSet.FieldByName
      ('TeamEntrantID').AsInteger;
    if SCM.TeamEntrant_Strike(aTeamEntrantID) > 0 then
    begin
      aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;
      TOT := TeamEntrantSumTTB(aTeamID);
      UpdateTeamTTB(aTeamID, TOT);
      GridEntrant.DataSource.DataSet.Refresh;
      // Requery SCM.qryEvent to update entrant count.
      PostMessage(TForm(Owner).Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
      // Set flag for statusbar update
      // PostMessage(TForm(Owner).Handle, SCM_UPDATESTATUSBAR, 0, 0);
    end;
  end;
end;

function TframeTEAM.StrikeLane: Integer;
var
  aTeamID: Integer;
begin
  result := 0;
  if fTeamActiveGrid = 1 then
  begin
    Grid.EditorMode := false;
    // remove nominees and swimmers from the lane
    aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;
    result := SCM.IndvTeam_StrikeLane(aTeamID, etTeam);
    if result > 0 then
    begin
      Grid.DataSource.DataSet.Refresh;
      // SCM.IndvTeam_LocateLane(aTeamID, etTeam);
      if Grid.CanFocus then Grid.SetFocus;
    end;
  end;
end;

function TframeTEAM.StrikeSlot: Integer;
var
  aTeamEntrantID: Integer;
begin
  result := 0;
  aTeamEntrantID := SCM.dsTeamEntrant.DataSet.FieldByName('TeamEntrantID')
    .AsInteger;
  if aTeamEntrantID > 0 then result := SCM.TeamEntrant_Strike(aTeamEntrantID);
end;

function TframeTEAM.TeamEntrantPadSlots(aTeamID: Integer): Integer;
var
  i, missingSlots, rows: Integer;
begin
  result := 0;
  if not SCM.IsActive then exit;
  if aTeamID = 0 then exit;
  // STANDARD: 4 entrant slots per relay team
  missingSlots := 4 - GridEntrant.DataSource.DataSet.RecordCount;
  if missingSlots > 0 then
  begin
    for i := 1 to missingSlots do
    begin
      rows := SCM.TeamEntrant_AddSlot(aTeamID); // rows modified
      result := result + rows; // rows inserted.
    end;
  end;
end;

function TframeTEAM.TeamEntrantSumTTB(aTeamID: Integer): Integer;
var
  SQL: string;
  v: variant;
begin
  // add the TTB of the TeamEntrants
  result := 0;
  SQL := 'SELECT SUM(dbo.SwimTimeToMilliseconds(TTB)) ' +
    'FROM SwimClubMeet2.dbo.TeamEntrant WHERE TeamEntrant.TeamID = :ID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aTeamID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
  begin
    // v/(SecsPerDay*1000.0); // A is the number of milliseconds
    result := v;
  end;

end;

procedure TframeTEAM.TeamEntrantScroll;
var
  fld: TField;
begin
  if GridEntrant.Focused then
  begin
    // After moving row re-engage editing for selected fields.
    fld := GridEntrant.SelectedField;
    if Assigned(fld) then
    begin
      if (fld.FieldName = 'RaceTime') or (fld.FieldName = 'DCode') or
        (fld.FieldName = 'FullName') then GridEntrant.EditorMode := true
      else GridEntrant.EditorMode := false;
    end;

    if SCM.dsTeam.DataSet.FieldByName('TeamNameID').IsNull then
        GridEntrant.Visible := false
    else GridEntrant.Visible := true;
  end;
end;

procedure TframeTEAM.TeamScroll;
var
  fld: TField;
begin
  if Grid.Focused then
  begin
    // After moving row re-engage editing for selected fields.
    fld := Grid.SelectedField;
    if Assigned(fld) then
    begin
      if (fld.FieldName = 'RaceTime') or (fld.FieldName = 'DCode') or
        (fld.FieldName = 'TeamName') then Grid.EditorMode := true
      else Grid.EditorMode := false;
    end;
  end;

  Panel1.BevelEdges := [beLeft, beTop, beRight, beBottom];
  Panel3.BevelEdges := [];

  // If TEAM.Grid isn't focused - TEAM.Panel3 may display as clWebTomatoe
  if Grid.DataSource.DataSet.FieldByName('TeamNameID').IsNull then
  begin
    GridEntrant.Visible := false;
    rpnlTeamEntrantTools.Visible := false;
  end
  else
  begin
    GridEntrant.Visible := true;
    rpnlTeamEntrantTools.Visible := true;
  end;
end;

procedure TframeTEAM.ToggleDCode(DoEnable: boolean);
begin
  SCM.ToggleDCode(Grid.DataSource.DataSet, DoEnable);
end;

function TframeTEAM.UpdateTeamTTB(aTeamID, milliseconds: Integer): Integer;
var
  dt: TDateTime;
  fld: TField;
begin
  SCM.Team_Locate(aTeamID);
  with SCM.dsTeam.DataSet do
  begin
    fld := fields.FindField('TTB');
    if Assigned(fld) and (fld.readonly = true) then fld.readonly := false;
    Edit;
    if milliseconds = 0 then FieldByName('TTB').Clear
    else
    begin
      dt := milliseconds / (24 * 60 * 60 * 1000);
      FieldByName('TTB').AsDateTime := dt;
    end;
    Post;
    if Assigned(fld) then fld.readonly := false;
    result := 1;
  end;
end;

end.
