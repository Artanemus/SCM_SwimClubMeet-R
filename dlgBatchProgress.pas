unit dlgBatchProgress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  SCMDefines, FireDAC.Comp.Client, dmSCM, frxExportPDF,
  FireDAC.Stan.Param;

type
  EPrintStatus = (psUserCancelled, psPrinterError, psOK, psExportError);

  TBatchProgress = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    btnCancel: TButton;
    Panel3: TPanel;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fExportFileName: string;
    DoAbort: boolean;

    function AssertConnection(): boolean;

    function BuildExportFileName(RptType: scmRptType;
      SendToFileType: scmSendToFileType; EventNum, HeatNum: integer): string;

    function BatchPrintMarshall(PrinterOrFolderName: String;
      SendToMode: scmSendToMode; SendToFileType: scmSendToFileType;
      var ErrCount: integer; EventID: integer;
      var PrintStatus: EPrintStatus): boolean;

    function BatchPrintTimeKeeper(PrinterOrFolderName: String;
      SendToMode: scmSendToMode; SendToFileType: scmSendToFileType;
      var ErrCount: integer; HeatID: integer;
      var PrintStatus: EPrintStatus): boolean;

  public
    { Public declarations }

    function BatchPrint(
      // REPORT TYPE - MARSHALL or TIMEKEEPER
      RptType: scmRptType;
      // PRINTER NAME OR FOLDER NAME FOR FILE EXPORT
      PrinterOrFolderName: String;
      // NUMBER OF ERRORS
      var ErrCount: integer;
      // DEFAULT - SEND TO PRINTER
      SendToMode: scmSendToMode = stmSendToPrinter;
      // DEFAULT - NOT APPLICABLE
      SendToFileType: scmSendToFileType = sftNA): boolean;
  end;

var
  BatchProgress: TBatchProgress;

implementation

{$R *.dfm}

uses rptTimeKeeperReportA, rptMarshallReportA, Data.DB, system.UITypes;

{ TBatchProgress }

function TBatchProgress.AssertConnection: boolean;
begin
  result := false;
  if Assigned(SCM) then
    if SCM.SCMActive then
      result := true;
end;

function TBatchProgress.BatchPrint(RptType: scmRptType;
  PrinterOrFolderName: String; var ErrCount: integer; SendToMode: scmSendToMode;
  SendToFileType: scmSendToFileType): boolean;
var
  success: bool;
  ds: TDataSet;
  EventNum, HeatNum, EventID, HeatID: integer;
  rptDetails, s: String;
  PrintStatus: EPrintStatus;
begin

  ErrCount := 0;
  success := false;
  rptDetails := '';
  PrintStatus := psOK;

  // for code readability...
  ds := SCM.dsEvent.DataSet;
  // are there events in this session?
  if (ds.RecordCount > 0) then
  begin
    ProgressBar1.Max := ds.RecordCount;
    ProgressBar1.Min := 0;
    ProgressBar1.Position := 0;
    // iterate over the events ...
    DoAbort := false;
    Panel1.Caption := 'Batch Process Reports. Found ' +
      IntToStr(ProgressBar1.Max) + ' events.';
    if (SendToMode = stmSendToFile) then
      Panel1.Caption := Panel1.Caption + ' Export to file.'
    else
      Panel1.Caption := Panel1.Caption + ' Send to printer.';
  end;

  ds.First;
  while not ds.Eof do
  begin
    EventID := ds.FieldByName('EventID').AsInteger;
    EventNum := ds.FieldByName('EventNum').AsInteger;
    rptDetails := 'Currently processing event# ' + Format('%2.2d', [EventNum]);

    case RptType of

      rtMarshall:
        begin
          if (SendToMode = stmSendToFile) then
          begin
            Label1.Caption := rptDetails;
            fExportFileName := BuildExportFileName(RptType, SendToFileType,
              EventNum, 0);
          end;
          // CALL PROCEDURE - OUTPUT
          success := BatchPrintMarshall(PrinterOrFolderName, SendToMode,
            SendToFileType, ErrCount, EventID, PrintStatus);
        end;

      rtTimeKeeper:
        // Iterate over heats. Are there heats?
        begin
          if not SCM.dsHeat.DataSet.IsEmpty then
          begin
            SCM.dsHeat.DataSet.First;
            while not SCM.dsHeat.DataSet.Eof do
            begin
              HeatID := SCM.dsHeat.DataSet.FieldByName('HeatID').AsInteger;
              HeatNum := SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger;
              // append additional report details
              // maintains string length
              s := rptDetails + ' heat# ' + Format('%2.2d', [HeatNum]);
              if (SendToMode = stmSendToFile) then
              begin
                Label1.Caption := s;
                fExportFileName := BuildExportFileName(RptType, SendToFileType,
                  EventNum, HeatNum);
              end;
              // CALL PROCEDURE - OUTPUT
              success := BatchPrintTimeKeeper(PrinterOrFolderName, SendToMode,
                SendToFileType, ErrCount, HeatID, PrintStatus);
              // ABORT ... ABORT Will Roberson ....
              if (PrintStatus <> psOK) then
                break;
              SCM.dsHeat.DataSet.Next;
            end;
          end;
        end;
    end;

    Label2.Caption := 'Errors: ' + IntToStr(ErrCount);
    // ABORT ... ABORT Will Roberson ....
    if (DoAbort) or (PrintStatus <> psOK) then
      break;
    ProgressBar1.Position := ProgressBar1.Position + 1;
    ds.Next;
  end;
  result := true;
end;

function TBatchProgress.BatchPrintMarshall(PrinterOrFolderName: String;
  SendToMode: scmSendToMode; SendToFileType: scmSendToFileType;
  var ErrCount: integer; EventID: integer;
  var PrintStatus: EPrintStatus): boolean;
var
  rpt: TMarshallReportA;
  frxPDFExport: TfrxPDFExport;
  msg: String;

begin
  ErrCount := 0;
  PrintStatus := psOK;

  rpt := TMarshallReportA.Create(self);
  // note: select printer dialog is enabled (by default)....
  // disable select printer dialog ....
  rpt.frxReport1.PrintOptions.ShowDialog := false;
  // set printer name
  rpt.frxReport1.PrintOptions.Printer := PrinterOrFolderName;
  // iterate over events
  rpt.qryReport.Close();
  rpt.qryReport.ParamByName('EID').AsInteger := EventID;
  rpt.qryReport.Prepare(); // ensures params changes are used
  rpt.qryReport.Open();
  if rpt.qryReport.Active then
  begin
    rpt.frxReport1.PrepareReport;
    case SendToMode of

      stmSendToPrinter:
        if not rpt.frxReport1.Print then
        begin
          if rpt.frxReport1.Errors.Text.IsEmpty then
            PrintStatus := psUserCancelled
          else
          begin
            PrintStatus := psPrinterError;
            ErrCount := ErrCount + 1;
          end;
        end;

      stmSendToFile:
        begin
          case SendToFileType of
            sftPDF:
              begin
                frxPDFExport := TfrxPDFExport.Create(self);
                frxPDFExport.DefaultPath := PrinterOrFolderName;
                frxPDFExport.FileName := fExportFileName;
                frxPDFExport.ShowDialog := false;
                if not rpt.frxReport1.Export(frxPDFExport) then
                begin
                  if rpt.frxReport1.Errors.Text.IsEmpty then
                    PrintStatus := psUserCancelled
                  else
                  begin
                    PrintStatus := psExportError;
                    ErrCount := ErrCount + 1;
                  end;
                end;
                frxPDFExport.free;
              end;
            // not implemented - yet
            sftXLS, sftHTML, sftNA:
              ;
          end;
        end;
    end;

    // BEFORE THE REPORT IS CLOSED ....
    // Handle printer errors
    if (PrintStatus = psPrinterError) then
    begin
      // display error message and exit
      msg := 'The printer reported an error ...\n';
      msg := msg + rpt.frxReport1.Errors.Text + '\n';
      msg := msg + 'Printing will be aborted.\n';
      MessageDlg(msg, mtError, [mbOK], 0);
    end;
    if (PrintStatus = psExportError) then
    begin
      // display error message and exit
      msg := 'An EXPORT error occurred ...\n';
      msg := msg + rpt.frxReport1.Errors.Text + '\n';
      msg := msg + 'Export of report will be aborted.\n';
      MessageDlg(msg, mtError, [mbOK], 0);
    end;

    rpt.qryReport.Close;
    rpt.free;
  end;

  if (ErrCount = 0) then
    result := true
  else
    result := false;
end;

function TBatchProgress.BatchPrintTimeKeeper(PrinterOrFolderName: String;
  SendToMode: scmSendToMode; SendToFileType: scmSendToFileType;
  var ErrCount: integer; HeatID: integer;
  var PrintStatus: EPrintStatus): boolean;
var
  rpt: TTimeKeeperReportA;
  frxPDFExport: TfrxPDFExport;
  msg: String;
begin

  ErrCount := 0;
  PrintStatus := psOK;

  rpt := TTimeKeeperReportA.Create(self);
  // note: select printer dialog is enabled (by default)....
  // disable select printer dialog ....
  rpt.frxReport1.PrintOptions.ShowDialog := false;
  // set printer name
  rpt.frxReport1.PrintOptions.Printer := PrinterOrFolderName;
  // iterate over heats
  rpt.qryReport.Close;
  rpt.qryReport.ParamByName('HID').AsInteger := HeatID;
  rpt.qryReport.Prepare; // ensures params changes are used
  rpt.qryReport.Open;
  if rpt.qryReport.Active then
  begin
    rpt.frxReport1.PrepareReport;
    case SendToMode of
      stmSendToPrinter:
        if not rpt.frxReport1.Print then
        begin
          if rpt.frxReport1.Errors.Text.IsEmpty then
            PrintStatus := psUserCancelled
          else
          begin
            PrintStatus := psPrinterError;
            ErrCount := ErrCount + 1;
          end;
        end;
      stmSendToFile:
        begin
          case SendToFileType of
            sftPDF:
              begin
                frxPDFExport := TfrxPDFExport.Create(self);
                frxPDFExport.DefaultPath := PrinterOrFolderName;
                frxPDFExport.FileName := fExportFileName;
                frxPDFExport.ShowDialog := false;
                if not rpt.frxReport1.Export(frxPDFExport) then
                begin
                  if rpt.frxReport1.Errors.Text.IsEmpty then
                    PrintStatus := psUserCancelled
                  else
                  begin
                    PrintStatus := psExportError;
                    ErrCount := ErrCount + 1;
                  end;
                end;
                frxPDFExport.free;
              end;
            // not implemented - yet
            sftXLS, sftHTML, sftNA:
              ;
          end;
        end;

    end;

    // BEFORE THE REPORT IS CLOSED ....
    // Handle printer errors
    if (PrintStatus = psPrinterError) then
    begin
      // display error message and exit
      msg := 'The printer reported an error ...\n';
      msg := msg + rpt.frxReport1.Errors.Text + '\n';
      msg := msg + 'Printing will be aborted.\n';
      MessageDlg(msg, mtError, [mbOK], 0);
    end;
    if (PrintStatus = psExportError) then
    begin
      // display error message and exit
      msg := 'An EXPORT error occurred ...\n';
      msg := msg + rpt.frxReport1.Errors.Text + '\n';
      msg := msg + 'Export of report will be aborted.\n';
      MessageDlg(msg, mtError, [mbOK], 0);
    end;

    rpt.qryReport.Close;
    rpt.free;

  end;

  if (ErrCount = 0) then
    result := true
  else
    result := false;
end;

procedure TBatchProgress.btnCancelClick(Sender: TObject);
begin
  DoAbort := true;
end;

function TBatchProgress.BuildExportFileName(RptType: scmRptType;
  SendToFileType: scmSendToFileType; EventNum, HeatNum: integer): string;
var
  dt: TDateTime;
  s, fn: string;
begin
  dt := SCM.GetSessionStart;
  // SESSION DATE
  DateTimeToString(s, 'yyyymmdd', dt);
  fn := s;
  // EVENT NUMBER
  fn := fn + '-' + Format('%2.2d', [EventNum]);
  // HEAT NUMBER
  // re-assign value
  if (RptType = rtTimeKeeper) then
    fn := fn + '-' + Format('%2.2d', [HeatNum]);
  // FILETYPE EXTENSION
  case SendToFileType of
    sftPDF:
      fn := fn + '.PDF';
    sftXLS:
      fn := fn + '.XLS';
    sftHTML:
      fn := fn + '.HTML';
    sftNA:
      ;
  end;
  // PREFIX WITH REPORT TYPE
  if (RptType = rtMarshall) then
    fn := 'Marshall-' + fn
  else if (RptType = rtTimeKeeper) then
    fn := 'TimeKeeper-' + fn;
  result := fn;
end;

procedure TBatchProgress.FormCreate(Sender: TObject);
begin
  DoAbort := false;
  Panel1.Caption := 'Batch Process Reports.';
end;

end.
