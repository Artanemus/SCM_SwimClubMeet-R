unit frame_INDV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, vcl.Themes, vcl.ActnList, dmSCM, SCMHelpers;

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
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
  private
    fEntrantBgColor: TColor;
    { Private declarations }
    fEntrantEditBoxFocused: TColor;
    fEntrantEditBoxNormal: TColor;
    // ASSERT CONNECTION TO MSSQL DATABASE
    function AssertConnection(): boolean;
    // D R A W   C H E C K   B O X E S .
    procedure DrawCheckBoxes(oGrid: TObject; Rect: TRect; Column: TColumn;
      fontColor: TColor; bgColor: TColor);
  public
    { Public declarations }
    fDoStatusBarUpdate: boolean; // FLAG ACTION - SCM_StatusBar.Enabled
    procedure AfterConstruction; override;
    procedure Enable_GridEllipse();
    // TActionManager:  Sender: TAction
    procedure GridMoveDown(Sender: TObject);
    procedure GridMoveUp(Sender: TObject);
    procedure ToggleDCode(DoEnable: boolean);
  end;

implementation

{$R *.dfm}

uses dlgEntrantPickerCTRL, dlgEntrantPicker, dlgDCodePicker, system.UITypes;

procedure TframeINDV.AfterConstruction;
var
  css: TCustomStyleServices;
  col: TColumn;
begin
  inherited;
  // Special color assignment - used in TDBGrid painting...
  // -------------------------------------------
  css := TStyleManager.Style[TStyleManager.ActiveStyle.Name];
  if Assigned(css) then
  begin
    fEntrantEditBoxFocused := css.GetStyleFontColor(sfEditBoxTextFocused);
    fEntrantEditBoxNormal := css.GetStyleFontColor(sfEditBoxTextNormal);
    fEntrantBgColor := css.GetStyleColor(scGrid);
  end
  else
  begin
    fEntrantEditBoxFocused := clWebTomato;
    fEntrantEditBoxNormal := clWindowText;
    fEntrantBgColor := clAppWorkSpace;
  end;
  {
    When the Columns.State property of the grid is csDefault, grid columns
    are dynamically generated from the visible fields of the dataset and the
    order of columns in the grid matches the order of fields in the dataset.
  }
  Grid.Columns.State := csDefault;
  Grid.Options := Grid.Options + [dgEditing];
  Grid.Options := Grid.Options - [dgAlwaysShowEditor];
  Enable_GridEllipse;
  {
    Small tidy-up on the grid displays.
    Set the drop-downs rowcount.
    Uses developer's TDBGrid Class Helper found in SHARED.
  }
  col := Grid.ColumnByName('luDistance');
  if Assigned(col) then  col.DropDownRows := 12;
  col := Grid.ColumnByName('luStroke');
  if Assigned(col) then  col.DropDownRows := 6;
//  col := Event_Grid.ColumnByName('luEventType');
//  if Assigned(col) then  col.DropDownRows := 3;

end;

function TframeINDV.AssertConnection: boolean;
begin
  result := false;
  // test datamodule construction
  if Assigned(SCM) then
  begin
    // IsActive if TFDConnection::scmConnection && FireDAC tables are active
    if SCM.SCMActive then
      result := true;
  end;
end;

procedure TframeINDV.DrawCheckBoxes(oGrid: TObject; Rect: TRect;
  Column: TColumn; fontColor, bgColor: TColor);
var
  MyRect: TRect;
  oField: TField;
  iPos, iFactor: integer;
  bValue: boolean;
  g: TDBGrid;
  points: Array [0 .. 4] of TPoint;
begin
  // ---------------------------------------------------------------------------
  // Draw a very basic checkbox (ticked) - not a nice as TCheckListBox
  // ---------------------------------------------------------------------------

  g := TDBGrid(oGrid);
  // is the cell checked?
  oField := Column.Field;
  if (oField.value = -1) then
    bValue := true
  else
    bValue := false;

  g.Canvas.Pen.Color := fontColor; //
  g.Canvas.Brush.Color := bgColor;
  g.Canvas.Brush.Style := bsSolid;
  g.Canvas.FillRect(Rect);

  // calculate margins
  MyRect.Top := Trunc((Rect.Bottom - Rect.Top - 9) / 2) + Rect.Top;
  MyRect.Left := Trunc((Rect.Right - Rect.Left - 9) / 2) + Rect.Left;
  MyRect.Bottom := MyRect.Top + 8;
  MyRect.Right := MyRect.Left + 8;

  // USES PEN - draw the box (with cell margins)
  points[0].x := MyRect.Left;
  points[0].y := MyRect.Top;
  points[1].x := MyRect.Right;
  points[1].y := MyRect.Top;
  points[2].x := MyRect.Right;
  points[2].y := MyRect.Bottom;
  points[3].x := MyRect.Left;
  points[3].y := MyRect.Bottom;
  points[4].x := MyRect.Left;
  points[4].y := MyRect.Top;

  g.Canvas.Polyline(points);

  iPos := MyRect.Left;
  iFactor := 1;
  // USES PEN - DRAW A TICK - Cross would be nicer?
  if bValue then
  begin
    g.Canvas.MoveTo(iPos + (iFactor * 2), MyRect.Top + 4);
    g.Canvas.LineTo(iPos + (iFactor * 2), MyRect.Top + 7);
    g.Canvas.MoveTo(iPos + (iFactor * 3), MyRect.Top + 5);
    g.Canvas.LineTo(iPos + (iFactor * 3), MyRect.Top + 8);
    g.Canvas.MoveTo(iPos + (iFactor * 4), MyRect.Top + 6);
    g.Canvas.LineTo(iPos + (iFactor * 4), MyRect.Top + 9);
    g.Canvas.MoveTo(iPos + (iFactor * 5), MyRect.Top + 5);
    g.Canvas.LineTo(iPos + (iFactor * 5), MyRect.Top + 8);
    g.Canvas.MoveTo(iPos + (iFactor * 6), MyRect.Top + 4);
    g.Canvas.LineTo(iPos + (iFactor * 6), MyRect.Top + 7);
    g.Canvas.MoveTo(iPos + (iFactor * 7), MyRect.Top + 3);
    g.Canvas.LineTo(iPos + (iFactor * 7), MyRect.Top + 6);
    g.Canvas.MoveTo(iPos + (iFactor * 8), MyRect.Top + 2);
    g.Canvas.LineTo(iPos + (iFactor * 8), MyRect.Top + 5);
  end;

end;

procedure TframeINDV.Enable_GridEllipse;
var
  i: integer;
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
  // --------------------------------------------------------------------
  // H A N D L E   A   C U S T O M   P A I N T E D   C H E C K B O X .
  // --------------------------------------------------------------------
  if Assigned(Column.Field) and (Column.Field.DataType = ftBoolean) then
  begin
    // Editing must be enabled for FUllName, RaceTime and DCode
    // ...BUT if editing is enabled and focus is on CheckBoxes
    // then 'true/false' text appears!
    // The custom paint routine isn't called during editing as the
    // inline editor is made visible and covers the cell.

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

    // --------------------------------------------------------------------
    // FIXED - FINALLY ...
    // BSA 31/07/2023
    // --------------------------------------------------------------------
    // If the user clicks the cell a 2nd time, the inline editor paints.
    // This is system WM_PAINT and cannot be ommitted.
    // UNLESS ...
    // 1.CHANGE OPTIONS. REMOVE editing. (MAGIC - I don't why this works.)
    // 2.NOW EditorMode correctly flags and the final step is to disable it.
    // NOTE: A REPAINT IS NOT NECESSARY as the inline editor is made invisible
    // to reveal the custom painted cell.
    Grid.Options := Grid.Options - [dgEditing];
    if Grid.EditorMode then
      Grid.EditorMode := false;

  end;
end;

procedure TframeINDV.GridColEnter(Sender: TObject);
var
  fld: TField;
begin
  // If the field is boolean, switch OFF Grid editing.
  fld := Grid.SelectedField;
  if Assigned(fld) then
  begin
    if (fld.FieldName = 'RaceTime') or (fld.FieldName = 'DCode') or
      (fld.FieldName = 'FullName') then
      Grid.EditorMode := true
    else
      Grid.EditorMode := false;
  end
end;

procedure TframeINDV.GridColExit(Sender: TObject);
begin
  // Editing must be enabled for FullName, RaceTime and DCode
  // If the field is boolean, switch ON Grid editing.
  // if Assigned(Grid.SelectedField) and
  // (Grid.SelectedField.DataType = ftBoolean) then
  // begin
  // Grid.BeginUpdate;
  // Grid.Options := Grid.Options + [dgEditing, dgAlwaysShowEditor];
  // Grid.EndUpdate;
  // end;
end;

procedure TframeINDV.GridDrawColumnCell(Sender: TObject; const
    Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  clFont, clBg: TColor;
begin
  // NOTE : DEFAULT DRAWING IS DISABLED ....
  if (Column.Field.FieldName = 'IsScratched') or
    (Column.Field.FieldName = 'IsDisqualified') then
  begin
    if gdFocused in State then
      clFont := fEntrantEditBoxFocused
    else
      clFont := fEntrantEditBoxNormal;
    clBg := fEntrantBgColor;
    DrawCheckBoxes(Grid, Rect, Column, clFont, clBg);
    // draw 'Focused' frame  (for boolean datatype only)
    if gdFocused in State then
      Grid.Canvas.DrawFocusRect(Rect);
  end
  else if (Column.Field.FieldName = 'FullName') or (Column.FieldName = 'DCode')
  then
  begin
    // ENABLE the button if not enabled
    if (Column.ButtonStyle <> TColumnButtonStyle.cbsEllipsis) then
      Column.ButtonStyle := TColumnButtonStyle.cbsEllipsis;
    Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then
      Grid.Canvas.DrawFocusRect(Rect);
  end
  else
  begin
    // default drawing DOESN'T draw a themed (yellow) background color
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
  EntrantID: integer;
  rtnValue: TModalResult;
  fld: TField;
begin
  if not AssertConnection then
    exit;
  rtnValue := mrCancel;

  SCM.dsEntrant.DataSet.DisableControls;
  EntrantID := SCM.dsEntrant.DataSet.FieldByName('EntrantID').AsInteger;

  // handle the ellipse button for the disqualification code
  fld := TDBGrid(Sender).SelectedField;
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
        SCM.Entrant_Locate(EntrantID);
      end;
    end;
  end
  // handle the ellipse entrant
  else if fld.FieldName = 'FullName' then
  begin
    if ((GetKeyState(VK_CONTROL) and 128) = 128) then
    begin
      // if (GetKeyState(VK_CONTROL) < 0) then begin
      dlgCntrl := TEntrantPickerCTRL.Create(self);
      passed := dlgCntrl.Prepare(SCM.scmConnection, EntrantID);
      if passed then
        rtnValue := dlgCntrl.ShowModal;
      dlgCntrl.Free;

    end
    else
    begin
      dlg := TEntrantPicker.Create(self);
      passed := dlg.Prepare(SCM.scmConnection, EntrantID);
      if passed then
        rtnValue := dlg.ShowModal;
      dlg.Free;
    end;
    // require a refresh to update members details
    if passed and IsPositiveResult(rtnValue) then
    begin
      SCM.dsEntrant.DataSet.Refresh;
      SCM.Entrant_Locate(EntrantID);
    end;

  end;

  SCM.dsEntrant.DataSet.EnableControls;

  // S T A T U S B A R .
  // Changes to entrants effect totals in statusbar
  fDoStatusBarUpdate := true; // flag set false after SCM_StatusBarExecute.

  {TODO -oBSA -cGeneral : POST MESSAGE TO UPDATE STATUS BAR ON PARENT FORM}

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
  i, j: integer;
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
  if Assigned(Grid.SelectedField) and
    (Grid.SelectedField.DataType = ftBoolean) and (Key = VK_SPACE) then
  begin
    Grid.DataSource.DataSet.Edit;
    Grid.SelectedField.value :=
      not Grid.SelectedField.AsBoolean;
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
        Key := NULL;
      end;
    end;
  end;

end;

procedure TframeINDV.GridMoveDown(Sender: TObject);
var
  success: boolean;
  MaxLane: integer;
begin
  // ...Update traps illegal calls.
  // already at bottom of stack?  Last lane in pool.
  MaxLane := SCM.SwimClub_NumberOfLanes;
  if (Grid.DataSource.DataSet.FieldByName('Lane').AsInteger = MaxLane)
  then
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

procedure TframeINDV.ToggleDCode(DoEnable: boolean);
begin
  SCM.ToggleDCode(Grid.DataSource.DataSet, DoEnable);
end;

end.
