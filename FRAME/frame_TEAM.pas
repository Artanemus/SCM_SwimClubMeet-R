unit frame_TEAM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Themes, dmSCM, SCMHelpers, SCMDefines;

type
  TframeTEAM = class(TFrame)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Grid: TDBGrid;
    GridEntrant: TDBGrid;
    procedure GridCellClick(Column: TColumn);
    procedure GridColEnter(Sender: TObject);
    procedure GridColExit(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridEditButtonClick(Sender: TObject);
    procedure GridEnter(Sender: TObject);
    procedure GridEntrantEditButtonClick(Sender: TObject);
    procedure GridEntrantEnter(Sender: TObject);
  private
    fTeamEditBoxFocused: TColor;
    fTeamEditBoxNormal: TColor;
    fTeamBgColor: TColor;
    fTeamFontColor: TColor;
    fTeamActiveGrid: Integer;
    fFrameBgColor: TColor;
    // ASSERT CONNECTION TO MSSQL DATABASE
    function AssertConnection(): boolean;

  public
    fDoStatusBarUpdate: boolean; // FLAG ACTION - SCM_StatusBar.Enabled
    procedure AfterConstruction; override;
    procedure Enable_GridEllipse();
    procedure Enable_GridEntrantEllipse();
    // TActionManager:  Sender: TAction
    procedure GridMoveDown(Sender: TObject);
    procedure GridMoveUp(Sender: TObject);
    procedure ToggleDCode(DoEnable: boolean);
    function ClearLane(): Integer;
    function StrikeLane(): Integer;
    function RenumberLanes(): Integer;

  end;

implementation

{$R *.dfm}

{ TframeTEAM }
uses dlgEntrantPickerCTRL, dlgEntrantPicker, dlgDCodePicker, System.UITypes,
  dlgTeamNameMenu, dmSCMHelper, dlgTeamNamePicker;

procedure TframeTEAM.AfterConstruction;
var
  css: TCustomStyleServices;
begin
  inherited;
  fTeamActiveGrid := 1;
  // Special color assignment - used in TDBGrid painting...
  // -------------------------------------------
  css := TStyleManager.Style[TStyleManager.ActiveStyle.Name];
  if Assigned(css) then
  begin
    fTeamEditBoxFocused := css.GetStyleFontColor(sfEditBoxTextFocused);
    fTeamEditBoxNormal := css.GetStyleFontColor(sfEditBoxTextNormal);
    fTeamBgColor := css.GetStyleColor(scGrid);
    fTeamFontColor := css.GetStyleFontColor(sfWindowTextNormal);
    fFrameBgColor := css.GetStyleColor(scWindow);
  end
  else
  begin
    fTeamEditBoxFocused := clWebTomato;
    fTeamEditBoxNormal := clWindowText;
    fTeamBgColor := clAppWorkSpace;
    fFrameBgColor := clAppWorkSpace;
    fTeamFontColor := clWindowText;
  end;

  Panel1.Color := clWebTomato;
  Panel2.Color := fFrameBgColor;
  Panel1.BorderWidth := 1;
  Panel2.BorderWidth := 1;

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

  Enable_GridEllipse;
  Enable_GridEntrantEllipse;

end;

function TframeTEAM.AssertConnection: boolean;
begin
  result := false;
  // test datamodule construction
  if Assigned(SCM) then
  begin
    // IsActive if TFDConnection::scmConnection && FireDAC tables are active
    if SCM.SCMActive then result := true;
  end;
end;

function TframeTEAM.ClearLane(): Integer;
var
  aTeamID, aTeamEntrantID: Integer;
begin
  result := 0;
  if fTeamActiveGrid = 1  then
  begin
    aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;
    result := SCM.IndvTeam_ClearLane(aTeamID, etTeam, true);
    if result > 0 then
    begin
      Grid.DataSource.DataSet.Refresh;
      SCM.IndvTeam_LocateLane(aTeamID, etTeam);
    end;
  end
  else if fTeamActiveGrid = 2 then
  begin
    aTeamEntrantID := GridEntrant.DataSource.DataSet.FieldByName
      ('TeamEntrantID').AsInteger;
    result := SCM.TeamEntrant_Clear(aTeamEntrantID);
  end;
end;

procedure TframeTEAM.Enable_GridEllipse;
var
  i: Integer;
  col: TColumn;
begin
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    col := Grid.Columns.Items[i];
    // MOD 23.06.27
    if (col.FieldName = 'TeamName') or (col.FieldName = 'RaceTime') or
      (col.FieldName = 'DCode') then
    begin
      col.ButtonStyle := cbsEllipsis;
      Grid.Repaint;
      break;
    end;
  end;
end;

procedure TframeTEAM.Enable_GridEntrantEllipse;
var
  i: Integer;
  col: TColumn;
begin
  for i := 0 to GridEntrant.Columns.Count - 1 do
  begin
    col := GridEntrant.Columns.Items[i];
    // MOD 23.06.27  - 23.08.31
    if (col.FieldName = 'FullName') then
    begin
      col.ButtonStyle := cbsEllipsis;
      GridEntrant.Repaint;
      break;
    end;
  end;
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
    Column.Field.value := not Column.Field.AsBoolean;
    if Column.Field.AsBoolean = false then
        Column.Grid.DataSource.DataSet.FieldByName('DisqualifyCodeID').Clear
    else
    begin
      if Column.FieldName = 'IsScratched' then
          Column.Grid.DataSource.DataSet.FieldByName('DisqualifyCodeID')
          .AsInteger := 53
      else if Column.FieldName = 'IsDisqualified' then
          Column.Grid.DataSource.DataSet.FieldByName('DisqualifyCodeID')
          .AsInteger := 54;
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
  s: variant;
  Size: TSize;
  topMargin: Integer;
  MyRect: TRect;
begin
  // NOTE : DEFAULT DRAWING IS DISABLED ....
  if (Column.Field.FieldName = 'IsScratched') or
    (Column.Field.FieldName = 'IsDisqualified') then
  begin
    if gdFocused in State then clFont := fTeamEditBoxFocused
    else clFont := fTeamEditBoxNormal;
    clBg := fTeamBgColor;
    TDBGrid(Sender).DrawCheckBoxes(Grid, Rect, Column, clFont, clBg);
    // draw 'Focused' frame  (for boolean datatype only)
    if gdFocused in State then Grid.Canvas.DrawFocusRect(Rect);
  end
  else if (Column.FieldName = 'DCode') then
  begin
    // ENABLE the button if not enabled
    if (Column.ButtonStyle <> TColumnButtonStyle.cbsEllipsis) then
        Column.ButtonStyle := TColumnButtonStyle.cbsEllipsis;
    Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then Grid.Canvas.DrawFocusRect(Rect);
  end
  else if (Column.Field.FieldName = 'TeamName') then
  begin
    // ENABLE the button if not enabled
    if (Column.ButtonStyle <> TColumnButtonStyle.cbsEllipsis) then
        Column.ButtonStyle := TColumnButtonStyle.cbsEllipsis;
    s := Grid.DataSource.DataSet.FieldByName('TeamName').AsString;
    if Length(s) = 0 then
        Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State)
    else
    begin
      // Display the team's custom name given by the user.
      // CLEAR THE CANVAS
      Grid.Canvas.Brush.Color := fTeamBgColor;
      Grid.Canvas.Brush.Style := bsSolid;
      Grid.Canvas.FillRect(Rect);
      // CALC EXTENT
      Grid.Canvas.Font.Color := fTeamFontColor;
      Size := Grid.Canvas.TextExtent(s);
      topMargin := Round((Rect.Height - Size.Height) / 2);
      // CALC MARGINS
      MyRect.Top := Rect.Top + topMargin;
      MyRect.Left := Rect.Left + topMargin;
      MyRect.Bottom := Rect.Bottom;
      MyRect.Right := Rect.Right;
      // PRINT THE TEXT
      Grid.Canvas.TextRect(Rect, Rect.Left, Rect.Top, s);
    end;

    if gdFocused in State then Grid.Canvas.DrawFocusRect(Rect);
  end
  else
  begin
    // default drawing DOESN'T draw a themed (yellow) background color
    Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then Grid.Canvas.DrawFocusRect(Rect);
  end;
end;

procedure TframeTEAM.GridEditButtonClick(Sender: TObject);
var
  dlgDCode: TDCodePicker;
  dlgPickTeam: TTeamNamePicker;
  TeamID: Integer;
  rtnValue: TModalResult;
  fld: TField;
  aRect: TRect;
  pt: TPoint;
begin
  if not AssertConnection then exit;

  // if SCM.dsTeam.DataSet.FieldByName('TeamNameID').IsNull then
  // exit;

  SCM.dsTeam.DataSet.DisableControls;
  TeamID := SCM.dsTeam.DataSet.FieldByName('TeamID').AsInteger;

  // handle the ellipse button for the disqualification code
  { TODO -oBSA -cGeneral : DCode Team Specific }
  fld := TDBGrid(Sender).SelectedField;
  if fld.FieldName = 'DCode' then
  begin
    dlgDCode := TDCodePicker.CreateWithConnection(self, SCM.scmConnection);
    dlgDCode.TeamID := TeamID;
    rtnValue := dlgDCode.ShowModal;
    dlgDCode.Free;
    if IsPositiveResult(rtnValue) then
    begin
      SCM.dsTeam.DataSet.Refresh;
      SCM.IndvTeam_LocateLane(TeamID, etTEAM);
    end;
  end
  // handle the ellipse entrant
  else if fld.FieldName = 'TeamName' then
    // ASSIGN A RELAY TEAM TO THIS EMPTY LANE....
    if (SCM.dsTeam.DataSet.FieldByName('TeamNameID').IsNull) then
    begin
      begin
        // display the relay team 'name picker'.
        dlgPickTeam := TTeamNamePicker.Create(self);
        dlgPickTeam.Prepare(SCM.scmConnection, TeamID);
        dlgPickTeam.Position := poDesigned;
        pt := Mouse.CursorPos;
        aRect := TDBGrid(Sender).GetCellRect(pt);
        dlgPickTeam.Left := aRect.Left;
        dlgPickTeam.Top := aRect.Top;
        rtnValue := dlgPickTeam.ShowModal;
        dlgPickTeam.Free;
        // require a refresh to update members details
        if IsPositiveResult(rtnValue) then
        begin
          SCM.dsTeam.DataSet.Refresh;
          SCM.IndvTeam_LocateLane(TeamID, etTEAM);
          // reveal TeamEntrant GRID
        end;
      end;
    end
    else beep;

  SCM.dsTeam.DataSet.EnableControls;
  // S T A T U S B A R .
  fDoStatusBarUpdate := true;
end;

procedure TframeTEAM.GridEnter(Sender: TObject);
begin
  fTeamActiveGrid := 1;
  Panel2.Color := fFrameBgColor;
  Panel1.Color := clWebTomato;

  // TOGGLE VISIBILITY OF THE TEAMENTRANT GRID
  if Grid.DataSource.DataSet.FieldByName('TeamNameID').IsNull then
      GridEntrant.Visible := false
  else GridEntrant.Visible := true;

  // Ensure that correct editing options are applied on
  // first use. SelectedIndex defaults to the first column,
  // if you tab into the grid or your first click goes to
  // the first column then OnColEnter doesn't fire.
  GridColEnter(Grid);
end;

procedure TframeTEAM.GridEntrantEditButtonClick(Sender: TObject);
var
  passed: boolean;
  dlg: TEntrantPicker;
  dlgCntrl: TEntrantPickerCTRL;
//  dlgDCode: TDCodePicker;
  TeamEntrantID: Integer;
  rtnValue: TModalResult;
  fld: TField;
begin
  if not AssertConnection then exit;
  if (SCM.CurrEventType <> etTEAM) then exit;

  rtnValue := mrCancel;
  SCM.dsTeamEntrant.DataSet.DisableControls;
  TeamEntrantID := SCM.dsTeamEntrant.DataSet.FieldByName('TeamEntrantID').AsInteger;

  // handle the ellipse button for the disqualification code
  { TODO -oBSA -cGeneral : DCode Team Specific }
  fld := TDBGrid(Sender).SelectedField;
  {
  if fld.FieldName = 'DCode' then
  begin
    if not SCM.dsEntrant.DataSet.FieldByName('MemberID').IsNull then
    begin
      dlgDCode := TDCodePicker.CreateWithConnection(self, SCM.scmConnection);
      dlgDCode.EntrantID := EntrantID;
      rtnValue := dlgDCode.ShowModal;
      dlgDCode.Free;
      if IsPositiveResult(rtnValue) then
      begin
        SCM.dsEntrant.DataSet.Refresh;
        SCM.TeamEntrant_Locate(EntrantID);
      end;
    end;
  end
  }
  // handle the ellipse entrant
  if fld.FieldName = 'FullName' then
  begin
    if ((GetKeyState(VK_CONTROL) and 128) = 128) then
    begin
      // if (GetKeyState(VK_CONTROL) < 0) then begin
      dlgCntrl := TEntrantPickerCTRL.Create(self);
      passed := dlgCntrl.Prepare(SCM.scmConnection, TeamEntrantID, etTEAM);
      if passed then rtnValue := dlgCntrl.ShowModal;
      dlgCntrl.Free;
    end
    else
    begin
      dlg := TEntrantPicker.Create(self);
      passed := dlg.Prepare(SCM.scmConnection, TeamEntrantID, etTEAM);
      if passed then rtnValue := dlg.ShowModal;
      dlg.Free;
    end;
    // require a refresh to update members details
    if passed and IsPositiveResult(rtnValue) then
    begin
      SCM.dsEntrant.DataSet.Refresh;
      SCM.TeamEntrant_Locate(TeamEntrantID);
    end;

  end;


  SCM.dsTeamEntrant.DataSet.EnableControls;

  // S T A T U S B A R .
  // Changes to entrants effect totals in statusbar
  fDoStatusBarUpdate := true; // flag set false after SCM_StatusBarExecute.

  { TODO -oBSA -cGeneral : POST MESSAGE TO UPDATE STATUS BAR ON PARENT FORM }

  {
    SCM_StatusBar.Update; // Asserts enabled state.
    SCM_StatusBar.Execute; // Fire actions
  }

end;

procedure TframeTEAM.GridEntrantEnter(Sender: TObject);
begin
  fTeamActiveGrid := 2;
  Panel1.Color := fFrameBgColor;
  Panel2.Color := clWebTomato;
end;

procedure TframeTEAM.GridMoveDown(Sender: TObject);
var
  success: boolean;
  MaxLane: Integer;
  aDataSet: TDataSet;
begin
  if fTeamActiveGrid = 1 then aDataSet := Grid.DataSource.DataSet
  else if fTeamActiveGrid = 2 then aDataSet := GridEntrant.DataSource.DataSet
  else exit;

  MaxLane := SCM.SwimClub_NumberOfLanes;
  success := false;
  if (aDataSet.FieldByName('Lane').AsInteger = MaxLane) then
  begin
    if fTeamActiveGrid = 1 then
    begin
      success := SCM.MoveDownToNextHeat(aDataSet);
      // Move Team to next heat (By default, will position on first entrant.)
      { TODO -oBSA -cGeneral : CHECK that this routine works for Entrant/Team. }
      SCM.dsHeat.DataSet.Next;
    end;
  end
  else
    // Generic move for either Team or TeamEntrant
      success := SCM.MoveDownLane(aDataSet);
  if not success then beep;
end;

procedure TframeTEAM.GridMoveUp(Sender: TObject);
var
  success: boolean;
  aDataSet: TDataSet;
begin
  if fTeamActiveGrid = 1 then aDataSet := Grid.DataSource.DataSet
  else if fTeamActiveGrid = 2 then aDataSet := GridEntrant.DataSource.DataSet
  else exit;
  success := false;
  if (aDataSet.FieldByName('Lane').AsInteger = 1) then
  begin
    if fTeamActiveGrid = 1 then
    begin
      success := SCM.MoveUpToPrevHeat(aDataSet); // Locate Team to 'prior' heat.
      { TODO -oBSA -cGeneral : CHECK that this routine works for Entrant/Team. }
      SCM.dsHeat.DataSet.Prior; // move to the previous heat ....
      aDataSet.Last; // move to last entrant ....
    end;
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

function TframeTEAM.StrikeLane: Integer;
var
  aTeamID, aTeamEntrantID: Integer;
begin
  result := 0;
  if fTeamActiveGrid = 1 then
  begin
    aTeamID := Grid.DataSource.DataSet.FieldByName('TeamID').AsInteger;
    result := SCM.IndvTeam_StrikeLane(aTeamID, etINDV);
    if Grid.CanFocus then Grid.SetFocus;
  end
  else if fTeamActiveGrid = 2 then
  begin
    aTeamEntrantID := GridEntrant.DataSource.DataSet.FieldByName
      ('TeamEntrantID').AsInteger;
    result := SCM.TeamEntrant_Strike(aTeamEntrantID);
  end;
end;

procedure TframeTEAM.ToggleDCode(DoEnable: boolean);
begin
  SCM.ToggleDCode(Grid.DataSource.DataSet, DoEnable);
end;

end.
