unit frame_INDV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Themes, Vcl.ActnList, dmSCM, SCMHelpers, SCMDefines;

type
  TframeINDV = class(TFrame)
    Grid: TDBGrid;
    procedure GridCellClick(Column: TColumn);
    procedure GridColEnter(Sender: TObject);
    procedure GridColExit(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridEditButtonClick(Sender: TObject);
    procedure GridEnter(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    fGridBgColor: TColor;
    fEntrantEditBoxFocused: TColor;
    fEntrantEditBoxNormal: TColor;
    fRacedFontColor: TColor;
    fEnableSplitTimes: boolean;

    // ASSERT CONNECTION TO MSSQL DATABASE
    function AssertConnection(): boolean;

  public
    { Public declarations }
    fDoStatusBarUpdate: boolean; // FLAG ACTION - SCM_StatusBar.Enabled
    fIsScratchedDCode: integer;
    fIsDisqualifiedDCode: integer;

    procedure AfterConstruction; override;
    procedure Enable_GridEllipse();
    // TActionManager:  Sender: TAction
    procedure GridMoveDown(Sender: TObject);
    procedure GridMoveUp(Sender: TObject);
    procedure ToggleDCode(DoEnable: boolean);
    function ClearLane: integer;
    function StrikeLane(): integer;
    function RenumberLanes(): integer;

    property EnableSplitTimes: boolean read fEnableSplitTimes
      write fEnableSplitTimes;
  end;

implementation

{$R *.dfm}

uses dlgEntrantPickerCTRL, dlgEntrantPicker, dlgDCodePicker, System.UITypes,
  dmSCMHelper, dlgSplitTimeINDV;

procedure TframeINDV.AfterConstruction;
var
  css: TCustomStyleServices;
  col: TColumn;
begin
  inherited;

  fEnableSplitTimes := false;

  // Special color assignment - used in TDBGrid painting...
  // -------------------------------------------
  css := TStyleManager.Style[TStyleManager.ActiveStyle.Name];
  if Assigned(css) then
  begin
    fEntrantEditBoxFocused := css.GetStyleFontColor(sfEditBoxTextFocused);
    fEntrantEditBoxNormal := css.GetStyleFontColor(sfEditBoxTextNormal);
    fGridBgColor := css.GetStyleColor(scGrid);
    fRacedFontColor := clWebPeachPuff;
  end
  else
  begin
    fEntrantEditBoxFocused := clWebTomato;
    fEntrantEditBoxNormal := clWindowText;
    fGridBgColor := clAppWorkSpace;
    fRacedFontColor := clWebPeachPuff;
  end;
  {
    When the Columns.State property of the grid is csDefault, grid columns
    are dynamically generated from the visible fields of the dataset and the
    order of columns in the grid matches the order of fields in the dataset.
  }
  Grid.Columns.State := csDefault;
  Grid.Options := Grid.Options - [dgAlwaysShowEditor];
  Grid.Options := Grid.Options + [dgEditing];
  Enable_GridEllipse;
  {
    Small tidy-up on the grid displays.
    Set the drop-downs rowcount.
    Uses developer's TDBGrid Class Helper found in SHARED.
  }
  col := Grid.ColumnByName('luDistance');
  if Assigned(col) then
    col.DropDownRows := 12;
  col := Grid.ColumnByName('luStroke');
  if Assigned(col) then
    col.DropDownRows := 6;

  fIsScratchedDCode := 0;
  fIsDisqualifiedDCode := 0;

end;

function TframeINDV.AssertConnection: boolean;
begin
  result := false;
  // test datamodule construction
  if Assigned(SCM) then
  begin
    // IsActive if TFDConnection::scmConnection && FireDAC tables are active
    if SCM.IsActive then
      result := true;
  end;
end;

function TframeINDV.ClearLane: integer;
var
aEntrantID: integer;
begin
  aEntrantID := Grid.DataSource.DataSet.FieldByName('EntrantID').AsInteger;
  result := SCM.IndvTeam_ClearLane(aEntrantID, etINDV);
  if result > 0 then
  begin
      Grid.DataSource.DataSet.Refresh;
      SCM.IndvTeam_LocateLane(aEntrantID, etINDV);
  end;
  if Grid.CanFocus then Grid.SetFocus;
end;

procedure TframeINDV.Enable_GridEllipse;
var
  i: Integer;
  col: TColumn;
begin
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    col := Grid.Columns.Items[i];
    // MOD 23.06.27
    if (col.FieldName = 'FullName') or (col.FieldName = 'DCode') then
    begin
      col.ButtonStyle := cbsEllipsis;
      Grid.Repaint;
      break;
    end;
  end;
end;

procedure TframeINDV.GridCellClick(Column: TColumn);
begin
  if not Assigned(Column.Field) then
    exit;
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
      // Scratched.
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

procedure TframeINDV.GridColEnter(Sender: TObject);
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
      (fld.FieldName = 'FullName') then
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

procedure TframeINDV.GridColExit(Sender: TObject);
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

procedure TframeINDV.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  clFont, clBg: TColor;
  Size: TSize;
  YMargin: integer;
  MyRect: TRect;
  aHeatID: integer;
begin
  aHeatID := TDBGrid(Sender).DataSource.DataSet.FieldByName('HeatID').AsInteger;
  if (Column.Field.FieldName = 'FullName') or (Column.FieldName = 'DCode') then
  begin
    // ASSERT button visible in column
    if (Column.ButtonStyle <> TColumnButtonStyle.cbsEllipsis) then
        Column.ButtonStyle := TColumnButtonStyle.cbsEllipsis;
  end;

  // Required to suppress unnecessary additional paints.
  if (Column.Field.FieldName = 'RaceTime') then
  begin
    if fEnableSplitTimes  then
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
    if gdFocused in State then
      clFont := fEntrantEditBoxFocused
    else
      clFont := fEntrantEditBoxNormal;
    clBg := fGridBgColor;
    TDBGrid(Sender).DrawCheckBoxes(Grid, Rect, Column, clFont, clBg);
    // draw 'Focused' frame  (for boolean datatype only)
    if gdFocused in State then
      Grid.Canvas.DrawFocusRect(Rect);
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
      (Column.Field.FieldName = 'TimeToBeat') or
      (Column.Field.FieldName = 'PersonalBest') then
        MyRect.Left := Rect.Left + (Rect.Width - Size.Width - 3)
    else
      // left align
        MyRect.Left := Rect.Left + 3;
    MyRect.Bottom := Rect.Bottom;
    MyRect.Right := Rect.Right;
    TDBGrid(Sender).Canvas.TextRect(myRect, myRect.Left, myRect.Top,
      Column.Field.DisplayText);
    if gdFocused in State then
      Grid.Canvas.DrawFocusRect(Rect);
  end
  else
  begin
    Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then
      Grid.Canvas.DrawFocusRect(Rect);
  end;
end;

procedure TframeINDV.GridEditButtonClick(Sender: TObject);
var
  passed: boolean;
  dlg: TEntrantPicker;
  dlgCntrl: TEntrantPickerCTRL;
  dlgDCode: TDCodePicker;
  dlgSplitTimeINDV: TSplitTimeINDV;
  aEntrantID, aEventID: Integer;
  fld: TField;
  rtnValue: TModalResult;
begin
  if not AssertConnection then
    exit;


  SCM.dsEntrant.DataSet.DisableControls;
  aEntrantID := SCM.dsEntrant.DataSet.FieldByName('EntrantID').AsInteger;

  // handle the ellipse button for the disqualification code
  fld := TDBGrid(Sender).SelectedField;
  if fld.FieldName = 'DCode' then
  begin
    dlgDCode := TDCodePicker.CreateWithConnection(self, SCM.scmConnection);
    dlgDCode.EntrantID := aEntrantID;
    rtnValue := dlgDCode.ShowModal;
    dlgDCode.Free;
    if IsPositiveResult(rtnValue) then
    begin
      SCM.dsEntrant.DataSet.Refresh;
      SCM.IndvTeam_Locatelane(aEntrantID, etINDV);
    end;
  end
  // handle the ellipse entrant
  else if fld.FieldName = 'FullName' then
  begin
    rtnValue := mrCancel;

    if ((GetKeyState(VK_CONTROL) and 128) = 128) then
    begin
      // if (GetKeyState(VK_CONTROL) < 0) then begin
      dlgCntrl := TEntrantPickerCTRL.Create(self);
      passed := dlgCntrl.Prepare(SCM.scmConnection, aEntrantID, etINDV);
      if passed then
        rtnValue := dlgCntrl.ShowModal;
      dlgCntrl.Free;

    end
    else
    begin
      dlg := TEntrantPicker.Create(self);
      passed := dlg.Prepare(SCM.scmConnection, aEntrantID, etINDV);
      if passed then
        rtnValue := dlg.ShowModal;
      dlg.Free;
    end;

    if passed and IsPositiveResult(rtnValue) then
    begin
      // This dbo.Event requery recalculates the EntrantCount
      SCM.dsEvent.DataSet.DisableControls;
      aEventID := SCM.Event_ID;
      SCM.dsEvent.DataSet.Refresh;
      SCM.Event_Locate(aEventID);
      SCM.dsEvent.DataSet.EnableControls;

      SCM.dsEntrant.DataSet.Refresh; // require UI refresh?
      SCM.IndvTeam_LocateLane(aEntrantID, etINDV); // restore record position
    end;

  end
  // enter racetime and split times for the entrant
  else if fld.FieldName = 'RaceTime' then
  begin
    SCM.dsEntrant.DataSet.CheckBrowseMode;
    dlgSplitTimeINDV := TSplitTimeINDV.CreateWithConnection(self, SCM.scmConnection);
    dlgSplitTimeINDV.EntrantID := aEntrantID;
    rtnValue := dlgSplitTimeINDV.ShowModal;
    dlgSplitTimeINDV.Free;
    if IsPositiveResult(rtnValue) then
    begin
      SCM.dsEntrant.DataSet.Refresh; // Repaint the teamname selected.
    end;
  end;

  SCM.dsEntrant.DataSet.EnableControls;

  // S T A T U S B A R .
  // Changes to entrants effect totals in statusbar
  fDoStatusBarUpdate := true; // flag set false after SCM_StatusBarExecute.

  { TODO -oBSA -cGeneral : POST MESSAGE TO UPDATE STATUS BAR ON PARENT FORM }
  {
    SCM_StatusBar.Update; // Asserts enabled state.
    SCM_StatusBar.Execute; // Fire actions
  }

end;

procedure TframeINDV.GridEnter(Sender: TObject);
begin
  // Ensure that correct editing options are applied on
  // first use. SelectedIndex defaults to the first column,
  // if you tab into the grid or your first click goes to
  // the first column then OnColEnter doesn't fire.
  GridColEnter(Grid);
end;

procedure TframeINDV.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Opts: TLocateOptions;
  i, j: Integer;
  success: boolean;
begin
  Opts := [];

  if (Key = VK_UP) and (ssCtrl in Shift) then
  begin
    GridMoveUp(self); // SWAP LANES
    Key := NULL;
    exit;
  end
  else if (Key = VK_UP) then
  begin
    // Move UP to next heat.
    if AssertConnection then
    begin
      // Navigate to prev heats if current location is on the first lane
      if (SCM.dsEntrant.DataSet.FieldByName('Lane').AsInteger = 1) then
      begin
        // Can't move if we are at the top of the heat.
        if (SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger > 1) then
        begin
          // move to prev heat
          i := SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger;
          i := i - 1;
          success := SCM.dsHeat.DataSet.Locate('HeatNum', i, Opts);
          // found previous heat move to last lane
          if (success) then
          begin
            j := SCM.SwimClub_NumberOfLanes;
            SCM.dsEntrant.DataSet.Locate('Lane', j, Opts);
            Key := 0;
          end;
        end;
      end;
    end;
  end;

  if (Key = VK_DOWN) and (ssCtrl in Shift) then
  begin
    GridMoveDown(self); // SWAP LANES?
    Key := 0;
    exit;
  end
  else if (Key = VK_DOWN) then
  begin
    // Move DOWN to next heat ....
    if (AssertConnection) then
    begin
      // Navigate to next heats if current location is on the last lane
      if (SCM.dsEntrant.DataSet.FieldByName('Lane')
        .AsInteger = SCM.SwimClub_NumberOfLanes) then
      begin
        // Can't move if we are at the bottom of the last heat stack.
        if (SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger <
          SCM.dsHeat.DataSet.RecordCount) then
        begin
          // move to next heat
          i := SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger;
          i := i + 1;
          success := SCM.dsHeat.DataSet.Locate('HeatNum', i, Opts);
          // found next heat move to first  lane
          if (success) then
          begin
            SCM.dsEntrant.DataSet.Locate('Lane', 1, Opts);
            Key := 0;
          end;
        end;
      end;
    end;
  end;

  // PAGE UP - navigate to the previous heat. Cue to same lane as org.heat;
  if (Key = VK_PRIOR) and (Shift = []) then
  begin
    // Move up to next heat ....
    if AssertConnection then
    begin
      if (SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger > 1) then
      begin
        // move to prev heat
        i := SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger;
        Dec(i);
        j := SCM.dsEntrant.DataSet.FieldByName('Lane').AsInteger;
        success := SCM.dsHeat.DataSet.Locate('HeatNum', i, Opts);
        if (success) then
        begin
          SCM.dsEntrant.DataSet.Locate('Lane', j, Opts);
          Key := 0;
        end;
      end;
    end;
  end
  // PAGE DOWN - navigate to the next heat. Cue to same lane as org.heat;
  else if (Key = VK_NEXT) and (Shift = []) then
  begin
    // Move DOWN to next heat ....
    if AssertConnection then
    begin
      // Move only if NOT a bottom of heats
      if (SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger <
        SCM.dsHeat.DataSet.RecordCount) then
      begin
        // move to prev heat
        i := SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger;
        Inc(i);
        j := SCM.dsEntrant.DataSet.FieldByName('Lane').AsInteger;
        success := SCM.dsHeat.DataSet.Locate('HeatNum', i, Opts);
        if (success) then
        begin
          SCM.dsEntrant.DataSet.Locate('Lane', j, Opts);
          Key := 0;
        end;
      end;
    end;

  end;

  // TOGGLE THE CHECKBOX WITH THE SPACE KEY.
  if Assigned(Grid.SelectedField) and (Grid.SelectedField.DataType = ftBoolean)
    and (Key = VK_SPACE) then
  begin
    Grid.DataSource.DataSet.Edit;
    Grid.SelectedField.value := not Grid.SelectedField.AsBoolean;
    Grid.DataSource.DataSet.Post;
    Key := 0;
  end;

  // FINALIZE THE EDIT
  if (Key = VK_RETURN) then
  begin
    if AssertConnection then
    begin
      if (SCM.dsEntrant.DataSet.State = dsEdit) then
      begin
        SCM.dsEntrant.DataSet.Post;
        Key := 0;
      end;
    end;
  end;

end;

procedure TframeINDV.GridMoveDown(Sender: TObject);
var
  success: boolean;
  MaxLane: Integer;
begin
  // ...Update traps illegal calls.
  // already at bottom of stack?  Last lane in pool.
  MaxLane := SCM.SwimClub_NumberOfLanes;
  if (Grid.DataSource.DataSet.FieldByName('Lane').AsInteger = MaxLane) then
  begin
    success := SCM.MoveDownToNextHeat(Grid.DataSource.DataSet);
    // move to next heat  (By default, will position on first entrant.)
    SCM.dsHeat.DataSet.Next;
  end
  else
    success := SCM.MoveDownLane(Grid.DataSource.DataSet);
  if not success then
    beep;
end;

procedure TframeINDV.GridMoveUp(Sender: TObject);
var
  success: boolean;
begin
  // ...Update traps illegal calls.
  // already at top of stack? First lane in pool.
  if (Grid.DataSource.DataSet.FieldByName('Lane').AsInteger = 1) then
  begin
    success := SCM.MoveUpToPrevHeat(Grid.DataSource.DataSet);
    // move to the previous heat ....
    SCM.dsHeat.DataSet.Prior;
    // move to last entrant ....
    SCM.dsEntrant.DataSet.Last;
  end
  else
    success := SCM.MoveUpLane(Grid.DataSource.DataSet);
  if not success then
    beep;
end;

function TframeINDV.RenumberLanes: integer;
var
aHeatID: integer;
begin
  aHeatID := Grid.DataSource.DataSet.FieldByName('HeatID').AsInteger;
  result := SCM.Lane_RenumberLanes(aHeatID);
  if Grid.CanFocus then Grid.SetFocus;
end;

function TframeINDV.StrikeLane: integer;
var
aEntrantID: integer;
begin
  Grid.EditorMode := false;
  aEntrantID := Grid.DataSource.DataSet.FieldByName('EntrantID').AsInteger;
  result := SCM.IndvTeam_StrikeLane(aEntrantID, etINDV);
  if result > 0 then
  begin
    Grid.DataSource.DataSet.Refresh;
    SCM.IndvTeam_LocateLane(aEntrantID, etTeam);
    if Grid.CanFocus then Grid.SetFocus;
  end;
end;

procedure TframeINDV.ToggleDCode(DoEnable: boolean);
begin
  SCM.ToggleDCode(Grid.DataSource.DataSet, DoEnable);
end;

end.
