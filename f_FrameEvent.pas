unit f_FrameEvent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  System.IOUtils,
  Vcl.ActnList,
  uDefines,
  dmSCM, dmCORE, dmIMG, scmUtility,
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
    procedure actnEvents_BatchMarshalSheetsExecute(Sender: TObject);
    procedure actnEvents_BatchTimekeeperSheetsExecute(Sender: TObject);
    procedure actnEvent_BatchBuildHeatsExecute(Sender: TObject);
    procedure actnEvent_DefaultUpdate(Sender: TObject);
    procedure actnEvent_MoveUpDownExecute(Sender: TObject);
    procedure actnEvent_NewUpdate(Sender: TObject);
  private
    { Private declarations }
    function AssertCORE(): boolean;
    procedure BatchReport(Sender: TObject;  RptType: scmRptType);
  end;

implementation

{$R *.dfm}

uses
  dlgSelectPrinter, dlgBatchProgress, dmAutoBuildV2;

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


end.
