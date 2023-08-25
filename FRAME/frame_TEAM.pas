unit frame_TEAM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, vcl.Themes, dmSCM;

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
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol:
        Integer; Column: TColumn; State: TGridDrawState);
    procedure GridEditButtonClick(Sender: TObject);
    procedure GridEnter(Sender: TObject);
    procedure GridEntrantEditButtonClick(Sender: TObject);
    procedure GridEntrantEnter(Sender: TObject);
  private
    fTeamEditBoxFocused: TColor;
    fTeamEditBoxNormal: TColor;
    fTeamBgColor: TColor;
    fTeamFontColor: TColor;
    fTeamActiveGrid: integer;
    // D R A W   C H E C K   B O X E S .
    procedure DrawCheckBoxes(oGrid: TObject; Rect: TRect; Column: TColumn;
      fontColor: TColor; bgColor: TColor);
    // ASSERT CONNECTION TO MSSQL DATABASE
    function AssertConnection(): boolean;

  public
    fDoStatusBarUpdate: boolean; // FLAG ACTION - SCM_StatusBar.Enabled
    procedure AfterConstruction; override;
    procedure Enable_GridEllipse();
    // TActionManager:  Sender: TAction
    procedure GridMoveDown(Sender: TObject);
    procedure GridMoveUp(Sender: TObject);

  end;

implementation

{$R *.dfm}

{ TframeTEAM }
uses dlgEntrantPickerCTRL, dlgEntrantPicker, dlgDCodePicker, system.UITypes,
  dlgTeamNameMenu;

procedure TframeTEAM.AfterConstruction;
var
  css: TCustomStyleServices;
begin
  inherited;
  fTeamActiveGrid := 0;
  Panel1.Color := clWebTomato;
  Panel2.Color := clWebTomato;
  Panel1.BorderWidth := 0;
  Panel2.BorderWidth := 0;

  // Special color assignment - used in TDBGrid painting...
  // -------------------------------------------
  css := TStyleManager.Style[TStyleManager.ActiveStyle.Name];
  if Assigned(css) then
  begin
    fTeamEditBoxFocused := css.GetStyleFontColor(sfEditBoxTextFocused);
    fTeamEditBoxNormal := css.GetStyleFontColor(sfEditBoxTextNormal);
    fTeamBgColor := css.GetStyleColor(scGrid);
    fTeamFontColor := css.GetStyleFontColor(sfWindowTextNormal);
  end
  else
  begin
    fTeamEditBoxFocused := clWebTomato;
    fTeamEditBoxNormal := clWindowText;
    fTeamBgColor := clAppWorkSpace;
    fTeamFontColor := clWindowText;
  end;
end;

function TframeTEAM.AssertConnection: boolean;
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

procedure TframeTEAM.DrawCheckBoxes(oGrid: TObject; Rect: TRect;
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

procedure TframeTEAM.Enable_GridEllipse;
var
  i: integer;
  col: TColumn;
begin
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    col := Grid.Columns.Items[i];
    // MOD 23.06.27
    if (col.FieldName = 'TeamName') then
    begin
      col.ButtonStyle := cbsEllipsis;
      Grid.Repaint;
      break;
    end;
  end;
end;

procedure TframeTEAM.GridCellClick(Column: TColumn);
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

procedure TframeTEAM.GridColEnter(Sender: TObject);
var
  fld: TField;
begin
  // If the field is boolean, switch OFF Grid editing.
  fld := Grid.SelectedField;
  if Assigned(fld) then
  begin
    if (fld.FieldName = 'RaceTime') or (fld.FieldName = 'DCode') or
      (fld.FieldName = 'TeamName') then
      Grid.EditorMode := true
    else
      Grid.EditorMode := false;
  end
end;

procedure TframeTEAM.GridColExit(Sender: TObject);
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

procedure TframeTEAM.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  clFont, clBg: TColor;
  s: variant;
  Size: TSize;
  topMargin: integer;
  MyRect: TRect;
begin
  // NOTE : DEFAULT DRAWING IS DISABLED ....
  if (Column.Field.FieldName = 'IsScratched') or
    (Column.Field.FieldName = 'IsDisqualified') then
  begin
    if gdFocused in State then
      clFont := fTeamEditBoxFocused
    else
      clFont := fTeamEditBoxNormal;
    clBg := fTeamBgColor;
    DrawCheckBoxes(Grid, Rect, Column, clFont, clBg);
    // draw 'Focused' frame  (for boolean datatype only)
    if gdFocused in State then
      Grid.Canvas.DrawFocusRect(Rect);
  end
  else if (Column.FieldName = 'DCode')
  then
  begin
    // ENABLE the button if not enabled
    if (Column.ButtonStyle <> TColumnButtonStyle.cbsEllipsis) then
      Column.ButtonStyle := TColumnButtonStyle.cbsEllipsis;
    Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then
      Grid.Canvas.DrawFocusRect(Rect);
  end
  else if (Column.Field.FieldName = 'FullName')
  then
  begin
    // ENABLE the button if not enabled
    if (Column.ButtonStyle <> TColumnButtonStyle.cbsEllipsis) then
      Column.ButtonStyle := TColumnButtonStyle.cbsEllipsis;
    s := Grid.DataSource.DataSet.FieldByName('Caption').AsString;
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

procedure TframeTEAM.GridEditButtonClick(Sender: TObject);
var
  dlgDCode: TDCodePicker;
  dlgTeamName: TTeamNameMenu;
  v: variant;
  TeamID, TeamNameID: integer;
  rtnValue: TModalResult;
  fld: TField;
begin
  if not AssertConnection then
    exit;
  rtnValue := mrCancel;

  SCM.dsTeam.DataSet.DisableControls;
  TeamID := SCM.dsTeam.DataSet.FieldByName('TeamID').AsInteger;
  v := SCM.dsTeam.DataSet.FieldByName('TeamNameID').AsVariant;
  if varIsNull(v) or varIsempty(v) then TeamNameID := 0 else TeamNameID := v;

  // handle the ellipse button for the disqualification code
  {TODO -oBSA -cGeneral : DCode Team Specific}
  fld := TDBGrid(Sender).SelectedField;
  if fld.FieldName = 'DCode' then
  begin
    if (TeamNameID <> 0) then
    begin
      dlgDCode := TDCodePicker.CreateWithConnection(self, SCM.scmConnection);
      {TODO -oBSA -cGeneral : Flag DCodePicker to switch to relay mode.}
      {      dlgDCode.TeamID := TeamID;}
      rtnValue := dlgDCode.ShowModal;
      dlgDCode.Free;
      if IsPositiveResult(rtnValue) then
      begin
        SCM.dsTeam.DataSet.Refresh;
        SCM.Team_Locate(TeamID);
      end;
    end;
  end
  // handle the ellipse entrant
  else if fld.FieldName = 'TeamName' then
  begin
    dlgTeamName := TTeamNameMenu.Create(self);
    dlgTeamName.Prepare(SCM.scmConnection, TeamID);
    rtnValue := dlgTeamName.ShowModal;
    dlgTeamName.Free;
    // require a refresh to update members details
    if IsPositiveResult(rtnValue) then
    begin
      SCM.dsTeam.DataSet.Refresh;
      SCM.Team_Locate(TeamID);
    end;

  end;
  SCM.dsTeam.DataSet.EnableControls;
  // S T A T U S B A R .
  fDoStatusBarUpdate := true;
end;

procedure TframeTEAM.GridEnter(Sender: TObject);
begin
  fTeamActiveGrid := 1;
  Panel2.BorderWidth := 0;
  Panel1.BorderWidth := 2;
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
  {TODO -oBSA -cGeneral : DCode Team Specific}
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

procedure TframeTEAM.GridEntrantEnter(Sender: TObject);
begin
  fTeamActiveGrid := 2;
  Panel2.BorderWidth := 2;
  Panel1.BorderWidth := 0;
end;

procedure TframeTEAM.GridMoveDown(Sender: TObject);
var
  success: boolean;
  MaxLane: integer;
begin
  // ...Update traps illegal calls.
  // already at bottom of stack?  Last lane in pool.
  {TODO -oBSA -cGeneral : Swap methods needed for team}
  MaxLane := SCM.SwimClub_NumberOfLanes;
  if (Grid.DataSource.DataSet.FieldByName('Lane').AsInteger = MaxLane)
  then
  begin
    success := SCM.SwapMoveDownHeat(Grid.DataSource.DataSet);
    // move to next heat  (By default, will position on first entrant.)
    SCM.dsHeat.DataSet.Next;
  end
  else
    success := SCM.SwapMoveDown(Grid.DataSource.DataSet);
  if not success then
    beep;
end;

procedure TframeTEAM.GridMoveUp(Sender: TObject);
var
  success: boolean;
begin
  // ...Update traps illegal calls.
  // already at top of stack? First lane in pool.
  {TODO -oBSA -cGeneral : Swap methods needed for team}
  if (Grid.DataSource.DataSet.FieldByName('Lane').AsInteger = 1) then
  begin
    success := SCM.SwapMoveUpHeat(Grid.DataSource.DataSet);
    // move to the previous heat ....
    SCM.dsHeat.DataSet.Prior;
    // move to last entrant ....
    SCM.dsTeam.DataSet.Last;
  end
  else
    success := SCM.SwapMoveUp(Grid.DataSource.DataSet);
  if not success then
    beep;
end;

end.
