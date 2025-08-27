unit f_FrameEvent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  System.IOUtils,
  Vcl.ActnList,
  SCMUtility, uDefines,
  dmSCM, dmCORE, dmIMG,
  uSwimClub, uSession, uEvent, uHeat, uLane,
  Data.DB,
  Vcl.Menus, AdvUtil, Vcl.Buttons, Vcl.WinXPanels, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Vcl.ExtCtrls
  ;

type
  TFrameEvent = class(TFrame)
    actnEventReport1: TMenuItem;
    actnEvents_BatchMarshalSheets: TAction;
    actnEvents_BatchTimekeeperSheets: TAction;
    actnEvent_BatchBuildHeats: TAction;
    actnEvent_Delete: TAction;
    actnEvent_Grid: TAction;
    actnEvent_MoveDown: TAction;
    actnEvent_MoveUp: TAction;
    actnEvent_New: TAction;
    actnEvent_Report: TAction;
    actnlistEvent: TActionList;
    DeleteEvent1: TMenuItem;
    gEvent: TDBAdvGrid;
    MoveDown1: TMenuItem;
    MoveUp1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    NewEvent1: TMenuItem;
    oggleGridExpansion1: TMenuItem;
    pnlgEvent: TPanel;
    pnlStack: TStackPanel;
    pumenuEvent: TPopupMenu;
    ShapeEventBar1: TShape;
    ShapeEventBar2: TShape;
    spbtnEventDelete: TSpeedButton;
    spbtnEventDown: TSpeedButton;
    spbtnEventGrid: TSpeedButton;
    spbtnEventNew: TSpeedButton;
    spbtnEventReport: TSpeedButton;
    spbtnEventUp: TSpeedButton;
    actnEvent_RenumberHeats: TAction;
    actnEvent_Schedule: TAction;
    actnEvent_BuildFinals: TAction;
    actnEvent_BuildSemiFinals: TAction;
    actnEvent_BuildQuaterFinals: TAction;
    procedure actnEvents_BatchMarshalSheetsExecute(Sender: TObject);
    procedure actnEvents_BatchTimekeeperSheetsExecute(Sender: TObject);
    procedure actnEvent_BatchBuildHeatsExecute(Sender: TObject);
    procedure actnEvent_BuildFinalsExecute(Sender: TObject);
    procedure actnEvent_BuildQuaterFinalsExecute(Sender: TObject);
    procedure actnEvent_BuildSemiFinalsExecute(Sender: TObject);
    procedure actnEvent_DefaultUpdate(Sender: TObject);
    procedure actnEvent_DeleteExecute(Sender: TObject);
    procedure actnEvent_GridExecute(Sender: TObject);
    procedure actnEvent_MoveUpDownExecute(Sender: TObject);
    procedure actnEvent_NewUpdate(Sender: TObject);
    procedure actnEvent_RenumberHeatsExecute(Sender: TObject);
    procedure actnEvent_ReportExecute(Sender: TObject);
    procedure actnEvent_ScheduleExecute(Sender: TObject);
    procedure gEventKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    function AssertCORE(): boolean;
    procedure BatchReport(Sender: TObject;  RptType: scmRptType);
    procedure Event_BuildSCMEventType(Sender: TObject; EventType: scmEventFinalsType);

    procedure UpdateEventStatus;
  protected
    procedure msgScrollEvent(var Msg: TMessage); message SCM_SCROLL_EVENT;

  end;

implementation

{$R *.dfm}

uses
  dlgSelectPrinter, dlgBatchProgress, dmAutoBuildV2, rptEventReportB,
  rptEventReportA, dlgAutoBuild_Finals, dlgAutoSchedule;

procedure TFrameEvent.actnEvents_BatchMarshalSheetsExecute(Sender: TObject);
begin
  BatchReport(Sender, rptMarshall);
end;

procedure TFrameEvent.actnEvents_BatchTimekeeperSheetsExecute(Sender: TObject);
begin
  BatchReport(Sender, rptTimeKeeper);
end;

procedure TFrameEvent.actnEvent_BatchBuildHeatsExecute(Sender: TObject);
var
  success, passed: boolean;
  errCount: integer;
//  dlg: TAutoBuildPref;
  dmv2: TAutoBuildV2;
  rtnValue: TModalResult;
  aEventType: scmEventType;
begin
  success := false;
  passed := false;
  errCount := 0;
  {TODO -oBSA -cV2 : Moves all this into seperate unit.}
  // TActionUpdate determines access to this routine.
  // DISPLAY AUTO-BUILD CONFIGURATION DIALOGUE
//  dlg := TAutoBuildPref.Create(self);
//  rtnValue := dlg.ShowModal;
  // closing the form here ensures prefHeatAlgorithm,
  // prefUseDefRaceTime, prefSeedMode and prefRaceTimeTopPercent have been
  // written out to the preference ini file.
//  dlg.Free;
  // user aborted ?
  if not IsPositiveResult(rtnValue) then exit;

  // Auto-build heat class constructor.
  // NOTE: Assigns auto-build configuration params on creation.
  try
    dmv2 := TAutoBuildV2.Create(self);

  except
    on E: Exception do exit;
  end;

  // disable core tables
  CORE.dsEvent.DataSet.DisableControls;
  CORE.dsHeat.DataSet.DisableControls;
  CORE.dsLane.DataSet.DisableControls;
  try
    begin
      CORE.dsEvent.DataSet.First;
      while not Eof do
      // iterate over the events ...
      begin
        // Is the EVENT CLOSED?
        if (CORE.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger = 2) then
        begin
          CORE.dsEvent.DataSet.Next;
          continue;
        end;
        // Is this a TEAM EVENT?
        // 20231008 currently Auto-Build is not available for TEAMS
        aEventType := uEvent.EventType();
        if (aEventType = etTEAM) then
        begin
          CORE.dsEvent.DataSet.Next;
          continue;
        end;
        // 2023.02.16
        // DELETE HEATS ...  For current event. Only open heats are deleted.
        uEvent.DeleteEvent();
        // QUICK TEST - Do we have NOMINEES?
        if not uEvent.HasNominees() then
        begin
          CORE.dsEvent.DataSet.Next;
          continue;
        end;
        // CORE.dsHeat.DataSet must be sent to Auto-Build - else errors.
        // ***************************************************************
        // Verbose OFF for BATCH Auto-Build Heats
        success := dmv2.AutoBuildExecute(false);
        if not success then Inc(errCount);

        CORE.dsEvent.DataSet.Next; // LOOP
      end;
    end;

  finally
      if (errCount = 0) then passed := true;

      // clean-up memory
      dmv2.Free;

      // REFRESH ...
      // NOTE: DataSet.Refresh not used.
      // BSA V2: Move apply master into Auto Build routine
      CORE.qryEvent.ApplyMaster;
      CORE.qryHeat.ApplyMaster;
      CORE.qryLane.ApplyMaster;

    //	CORE.dsEntrant.DataSet.Close;
    //	CORE.dsHeat.DataSet.Close;
    //	CORE.dsEvent.DataSet.Close;
    //	CORE.dsEvent.DataSet.Open;
    //	CORE.dsHeat.DataSet.Open;
    //	CORE.dsEntrant.DataSet.Open;

      // Enable core tables
      CORE.dsEvent.DataSet.EnableControls;
      CORE.dsHeat.DataSet.EnableControls;
      CORE.dsLane.DataSet.EnableControls;

      if passed then
      begin
        // Display success.
        if not success then
            MessageDlg('Batch Build Heats completed but with errors.' + sLineBreak +
            'Check output!', mtInformation, [mbOK], 0)
        else MessageDlg('Batch Build Heats completed without errors.',
            mtInformation, [mbOK], 0);
      end;

  end;


end;

procedure TFrameEvent.actnEvent_BuildFinalsExecute(Sender: TObject);
begin
  Event_BuildSCMEventType(Sender, ftFinals);
end;

procedure TFrameEvent.Event_BuildSCMEventType(Sender: TObject; EventType: scmEventFinalsType);
var
  dm: TAutoBuildV2;
  dlg: TAutoBuild_Finals;
  success: boolean;
  EventID, rtnValue: integer;
begin
  if not AssertCORE then exit;
  dlg := TAutoBuild_Finals.Create(self);
  dlg.TypeOfEvent := EventType;
  rtnValue := dlg.ShowModal;
  dlg.Free;
  if (rtnValue = mrYes) then
  begin
    EventID := CORE.dsEvent.DataSet.FieldByName('EventID').AsInteger;
    dm := TAutoBuildV2(self);
    success := dm.AutoBuildExecuteExt(EventID, EventType);
    dm.Free;
    if (success) then
    begin
      gEvent.BeginUpdate;
      try
        ; // done.
      finally
        gEvent.EndUpdate;
      end;
    end;
  end;
end;

procedure TFrameEvent.actnEvent_BuildQuaterFinalsExecute(Sender: TObject);
begin
  Event_BuildSCMEventType(Sender, ftSemi);
end;

procedure TFrameEvent.actnEvent_BuildSemiFinalsExecute(Sender: TObject);
begin
  Event_BuildSCMEventType(Sender, ftQuarter);
end;

procedure TFrameEvent.actnEvent_DefaultUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertCORE then
    if not uSession.IsEmptyOrLocked then
      if not CORE.qryEvent.IsEmpty then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TFrameEvent.actnEvent_DeleteExecute(Sender: TObject);
var
  rtnValue, aEventID: integer;
  SQL: String;
  HasClosedHeats, HasRacedHeats: boolean;
begin
	aEventID := uEvent.PK;
	HasClosedHeats :=uEvent.HasClosedHeats();
  HasRacedHeats := uEvent.HasRacedHeats();
  if HasClosedHeats then
	begin

		SQL := 'Unable to delete the event ';

    SQL := SQL + CORE.dsEvent.DataSet.FieldByName('ShortCaption').AsString +
      sLineBreak;
    SQL := SQL + 'as the event includes ''closed'' heats.';
    MessageDlg(SQL, mtError, [mbOK], 0, mbOK);
    exit;
  end;
  // 1 .  C o n f i r m   d e l e t i o n (RACED HEATS) .
  // --------------------------------------------------------
  if HasRacedHeats then
  begin
    rtnValue := MessageDlg('WARNING: This event contains RACED heats.' +
      sLineBreak +
      'Racetimes and entrant data will be lost if you delete this event.' +
      sLineBreak + 'Do you wish to delete the event?', mtWarning,
      [mbYes, mbNo], 0, mbNo);
    // DON'T USE (results == mrNo) as it doesn't account for VK_ESCAPE.
    // mrCancel=2 mrNo=7 mrYes=6
    if (rtnValue <> mrYes) then exit;
  end;

  // 2 .  C o n f i r m   d e l e t i o n .
	// --------------------------------------------------------
  SQL := 'Delete event?';
	SQL := SQL + CORE.dsEvent.DataSet.FieldByName('ShortCaption').AsString +
    sLineBreak;
  if (HasRacedHeats) then
      SQL := SQL + 'Including all (open or raced) heats, entrant and nomination data?'
  else SQL := SQL + 'Including all open heats, entrant and nomination data?';
  rtnValue := MessageDlg(SQL, mtConfirmation, [mbYes, mbNo], 0, mbYes);

  if (rtnValue = mrYes) then
  begin
    gEvent.BeginUpdate;
		uEvent.DeleteEvent();
		CORE.qryEvent.EnableControls;
    gEvent.EndUpdate;
//    PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 1, 0);
  end;

end;

procedure TFrameEvent.actnEvent_GridExecute(Sender: TObject);
var
  fld: TField;
begin
  // TActionUpdate determines if this routine can be accessed
  with (Sender as TAction) do
  begin
    // T O G G L E .
    Checked := not Checked;
    if Checked then
    begin
      ImageIndex := 1;
      { frmMAIN hides f_FrameSession.
        f_FrameEvent expands to fill the width of the frmMain's tabsheet1.
        pnlSessionLeft.Visible := false;
      }
    end
    else
    begin
      ImageIndex := 0;
      // frmMAIN restores the visibility of f_FrameSession.
    end;

    // makes visible the event caption field used to enter event details
    try
      gEvent.BeginUpdate;
      CORE.qryEvent.DisableControls;
      // e v e n t   d e s c r i p t i o n ...
      fld := CORE.qryEvent.FindField('Caption');
      if Assigned(fld) then fld.Visible := Checked;

      // e v e n t   s c h e d u l e  t i m e ...
      fld := CORE.qryEvent.FindField('ScheduleDT');
      if Assigned(fld) then fld.Visible := Checked;

      // INDV or RELAY event type ....
      // fld := CORE.qryEvent.FindField('luEventType');
      // if Assigned(fld) then
      // fld.Visible := Checked;

      // Fields that are always visible in either grid display mode.
      // n o m i n a t i o n s  ...
      fld := CORE.qryEvent.FindField('NomineeCount');
      if Assigned(fld) then
      begin
        if Checked then fld.DisplayLabel := 'Nominees'
        else fld.DisplayLabel := 'Nom#';
      end;
      // e n t r a n t s ...
      fld := CORE.qryEvent.FindField('EntrantCount');
      if Assigned(fld) then
      begin
        if Checked then fld.DisplayLabel := 'Entrants'
        else fld.DisplayLabel := ' Ent#';
      end;

    finally
      CORE.qryEvent.EnableControls;
      gEvent.EndUpdate;
    end;
  end;
end;

procedure TFrameEvent.actnEvent_MoveUpDownExecute(Sender: TObject);
var
  aEventID, recA, recB: integer;
  fld: TField;
  recPos: TRecordPos;
begin
  if not AssertCORE then exit;
  recPos := SCMUtility.GetRecordPosition(CORE.qryEvent);
  if recPos = rpMiddle then
  begin
    gEvent.BeginUpdate;
    CORE.qryEvent.DisableControls();
    CORE.qryEvent.CheckBrowseMode;
    fld := CORE.qryEvent.FindField('EventNum');
    if Assigned(fld) and fld.ReadOnly then fld.ReadOnly := false;
    try
      aEventID := uEvent.PK;
      recA := CORE.qryEvent.FieldByName('EventNum').AsInteger;
      recB := 0;
      try
        if TAction.UnitName.Contains('Down') then
          CORE.qryEvent.Next()
        else if TAction.UnitName.Contains('Up')  then
          CORE.qryEvent.Prior()
        else exit;

        recB := CORE.qryEvent.FieldByName('EventNum').AsInteger;
        CORE.qryEvent.Edit();
        CORE.qryEvent.FieldByName('EventNum').AsInteger := recA;
        CORE.qryEvent.Post();
        recA := 0;
        if uEvent.Locate(aEventID) then
        begin
          CORE.qryEvent.Edit();
          CORE.qryEvent.FieldByName('EventNum').AsInteger := recB;
          CORE.qryEvent.Post();
        end;
      except on E: Exception do
        begin
          CORE.qryEvent.Cancel;
          { if recA = 0 then  uEvent.RenumberLanes(true); }
          exit;
        end;
      end;
    finally
      if Assigned(fld) then fld.ReadOnly := true;
      CORE.qryEvent.EnableControls();
      gEvent.EndUpdate;
    end;
  end;
end;

procedure TFrameEvent.actnEvent_NewUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertCORE then
    if not uSession.IsEmptyOrLocked then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TFrameEvent.actnEvent_RenumberHeatsExecute(Sender: TObject);
begin
  uEvent.RenumberHeats();
end;

procedure TFrameEvent.actnEvent_ReportExecute(Sender: TObject);
var
  rptA: TEventReportA;
  rptB: TEventReportB;
begin
  CORE.qryEvent.CheckBrowseMode; // finalize any editing within table
  try
    begin
      if ((GetKeyState(VK_CONTROL) and 128) = 128) then
      begin
        rptB := TEventReportB.Create(self);
        rptB.RunReport;
        rptB.Free;
      end
      else
      begin
        rptA := TEventReportA.Create(self);
        rptA.RunReport;
        rptA.Free;
      end;
    end;
  except
    on E: Exception do ShowMessage('Error opening report.');
  end;
end;

procedure TFrameEvent.actnEvent_ScheduleExecute(Sender: TObject);
var
  dlg: TAutoSchedule;
  EventID: integer;
  rtnValue: TModalResult;
begin
  if not AssertCORE then exit;
  CORE.dsEvent.DataSet.DisableControls;
	EventID := uEvent.PK;
  dlg := TAutoSchedule.CreateWithConnection(self, SCM.scmConnection);
	dlg.SessionID := uSession.PK;
  rtnValue := dlg.ShowModal;
  dlg.Free;
  if IsPositiveResult(rtnValue) then
  begin
    CORE.dsEvent.DataSet.Refresh;
		uEvent.Locate(EventID);
  end;
  CORE.dsEvent.DataSet.EnableControls;
end;

function TFrameEvent.AssertCORE: boolean;
begin
  result := false;
  if Assigned(CORE) and CORE.IsActive then
    result := true;
end;

procedure TFrameEvent.BatchReport(Sender: TObject; RptType: scmRptType);
var
  success: boolean;
  dlg: TSelectPrinter;
  bp: TBatchProgress;
  PrinterOrFolderName, s: String;
  SendToMode: scmSendToMode;
  SendToFileType: scmSendToFileType;
  errCount: integer;
begin
  errCount := 0;
  // TActionUpdate determines if this routine is accessed.
  // Sessions, Event 'not IsEmpty' passed test.
  // Select printer for reports.
  // OR
  // Select folder (and ..TODO: collation) for PDF export.
  dlg := TSelectPrinter.Create(self);

  if (RptType = scmRptType.rptTimeKeeper) then
      dlg.Panel2.Caption := 'Batch Print Timekeeper Reports'
  else dlg.Panel2.Caption := 'Batch Print Marshall Reports';
  if IsAbortResult(dlg.ShowModal) then exit;

  if dlg.rbtnSendToPrinter.Checked then
  begin
    SendToMode := stmSendToPrinter;
    SendToFileType := sftNA;
    PrinterOrFolderName := dlg.printerName;
  end
  else
  begin
    SendToMode := stmSendToFile;
    SendToFileType := sftPDF;
    PrinterOrFolderName := dlg.edtFolder.Text;
  end;
  dlg.Free;

  if PrinterOrFolderName.IsEmpty then
  begin
    if (SendToMode = stmSendToFile) then s := 'ERROR: No folder-name given.'
    else s := 'ERROR: No printer selected.';
    MessageDlg(s, mtError, [mbOK], 0);
    exit;
  end;

  if (SendToMode = stmSendToFile) then
  begin
    // FINAL CHECKS ON FOLDER PARAM.
    // append delimeter
    PrinterOrFolderName := IncludeTrailingPathDelimiter(PrinterOrFolderName);
    // Does the folder exists
    if not TDirectory.Exists(PrinterOrFolderName) then
    begin;
      MessageDlg('ERROR: Output folder doesn''t exist.', mtError, [mbOK], 0);
      exit;
    end;
  end;
  // *************************************************
  // F I N A L L Y   B A T C H   P R I N T ....
  // *************************************************
  // disable core tables
  CORE.dsSession.DataSet.DisableControls;
  CORE.dsEvent.DataSet.DisableControls;
  CORE.dsHeat.DataSet.DisableControls;
  bp := TBatchProgress.Create(self);
  bp.Show;
  // allow time for the dlg to be fully painted?
  Application.ProcessMessages;
  // Dlg tasked to print/export reports.
  // BatchPrint(
  // REPORT TYPE - MARSHALL or TIMEKEEPER,
  // PRINTER-NAME OR FOLDER-NAME FOR FILE EXPORT,
  // NUMBER OF ERRORS (REFERENCE PARAM),
  // SEND TO PRINTER (DEFAULT) OR EXPORT TO FILE
  // FILE TYPE TO EXPORT PDF, XLS, HTML, NA (DEFAULT)
  success := bp.BatchPrint(RptType, PrinterOrFolderName, errCount, SendToMode,
    SendToFileType);
  bp.Free;
  // restore state
  CORE.dsSession.DataSet.EnableControls;
  CORE.dsEvent.DataSet.EnableControls;
  CORE.dsHeat.DataSet.EnableControls;
  if (success) then
  begin
    MessageDlg('Batch Print completed without errors.', mtInformation,
      [mbOK], 0);
  end
  else MessageDlg('Batch Print done but with errors(' + IntToStr(errCount) +
      ').' + sLineBreak + 'Check!', mtWarning, [mbOK], 0);
end;

procedure TFrameEvent.gEventKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
var
  dg: TDBAdvGrid;
  c: char;
  i: integer;
begin
  if (Key = VK_UP) and (ssCtrl in Shift) then
  begin
    {
      Typically, applications do not call the ExecuteAction method. Instead,
      the action indicated by the Action parameter calls ExecuteAction in response
      to a user command. It is possible, however, to call ExecuteAction to
      generate an OnExecute event even though no client control has been triggered.

      ExecuteAction invokes the OnExecute event handler for the action list.
      It returns True if the event handler handles the action, False otherwise.
    }
    actnlistEvent.ExecuteAction(actnEvent_MoveUp);
    Key := NULL;
    exit;
  end;
  if (Key = VK_DOWN) and (ssCtrl in Shift) then
  begin
    actnlistEvent.ExecuteAction(actnEvent_MoveDown);
    Key := NULL;
    exit;
  end;

  {
    "1"	"FreeStyle"
    "2"	"BreastStroke"
    "3"	"BackStroke"
    "4"	"ButterFly"
    "5"	"Medley"

    "1"	"25m"	"25"
    "2"	"50m"	"50"
    "3"	"100m"	"100"
    "4"	"200m"	"200"
    "5"	"400m"	"400"
    "6"	"1000m"	"1000"
  }

//  if (Key in [F,B,R,A,U,M]) then
//  begin
//
//  end;

  // Speecial 'speed' keys to set stroke or distance'
  dg := TDBAdvGrid(Sender);
  if (dg.SelectedField.FieldName = 'luStroke') then
  begin
    c := upcase(char(Key));
    case (c) of
      'F': i := 1;
      'B', 'R': i := 2;
      'A': i := 3;
      'U': i := 4;
      'M': i := 5;
    else i := 0;
    end;

    if (i > 0) then
    begin
      CORE.dsEvent.DataSet.DisableControls;
      CORE.dsEvent.DataSet.Edit;
      CORE.dsEvent.DataSet.FieldByName('StrokeID').AsInteger := i;
      CORE.dsEvent.DataSet.Post;
      CORE.dsEvent.DataSet.EnableControls;
      Key := 0;
    end;
  end
  else if (dg.SelectedField.FieldName = 'luDistance') then
  begin
    case char(Key) of
      '2': i := 1; // 25m
      '5': i := 2; // 50m
      '1': i := 3; // 100m
      '0': i := 4; // 200m
      '4': i := 5; // 400m
      // 1000m - there is no shortcut
    else i := 0;
    end;
    if (i > 0) then
    begin
      CORE.dsEvent.DataSet.DisableControls;
      CORE.dsEvent.DataSet.Edit;
      CORE.dsEvent.DataSet.FieldByName('DistanceID').AsInteger := i;
      CORE.dsEvent.DataSet.Post;
      CORE.dsEvent.DataSet.EnableControls;
      Key := 0;
    end;
  end;

end;


procedure TFrameEvent.msgScrollEvent(var Msg: TMessage);
begin
  if not AssertCORE then exit;
  // perform UI changes to gEvent.
end;

procedure TFrameEvent.UpdateEventStatus;
var
  AllClosed: boolean;
  i: integer;
begin
  if not AssertCORE then exit;
  if CORE.qryEvent.IsEmpty then exit;
  try
    gEvent.BeginUpdate;
    AllClosed := uEvent.AllHeatsAreClosed();
    if AllClosed then i := 2 else i := 1;
    uEvent.SetEventStatusID(i);
  finally
    gEvent.EndUpdate;
  end;
end;


{
procedure TMain.Event_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: integer; Column: TColumn; State: TGridDrawState);
var
  oField: TField;
begin
  if (Column.Field.FieldName = 'EventStatusID') then
  begin
    oField := Column.Field;
    if (oField.value = '2') then
      // draw a tick if all the heats have been raced...
        DrawEventStatus(Event_Grid, Rect, Column)
    else
      // 17.10.2020 - leave the column blank ...
        Event_Grid.Canvas.FillRect(Rect);
  end;
end;

 procedure TMain.EnableEvent_GridEllipse;
 var
 i: integer;
 col: TColumn;
 begin
 for i := 0 to Event_Grid.Columns.Count - 1 do
 begin
 col := Event_Grid.Columns.Items[i];
 if (col.FieldName = 'ScheduleDT') then
 begin
 // editing in the this cell isn't allowed - use ellipse button.
 col.ButtonStyle := cbsEllipsis;
 Event_Grid.Repaint;
 break;
 end;
 end;
 end;

}

(*

procedure TMain.Refresh_Event(DoBookmark: boolean = true;
  DoRenumber: boolean = false);
var
  v: variant;
begin
  if not AssertConnection then exit;
  with CORE.dsEvent.DataSet do
  begin
    DisableControls;
    if Active and not IsEmpty then
    begin
      v := FieldByName('EventID').AsVariant;
    end;
    Close;
    Open;
    if Active then
    begin
      if DoRenumber then
      begin
				uSession.RenumberEvents(false); // don't relocate
        Refresh;
			end;
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
          uEvent.Locate(v);
    end;
    EnableControls;
  end;
end;

procedure TMain.DrawEventStatus(oGrid: TObject; Rect: TRect; Column: TColumn);
var
  MyRect: TRect;
  iPos, iFactor: integer;
  g: TDBGrid;
begin
  g := TDBGrid(oGrid);
  // clear the cell with the current OS brush color?
  g.Canvas.FillRect(Rect);
  // calculate margins
  MyRect.Top := Round((Rect.Bottom - Rect.Top - 11) / 2) + Rect.Top;
  MyRect.Left := Round((Rect.Right - Rect.Left - 11) / 2) + Rect.Left;
  MyRect.Bottom := MyRect.Top + 10;
  MyRect.Right := MyRect.Left + 10;

  iPos := MyRect.Left;
  iFactor := 1;
  // DRAW A TICK
  g.Canvas.Pen.Color := clWebTomato;
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


*)

end.
