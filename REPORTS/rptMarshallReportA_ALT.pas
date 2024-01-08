unit rptMarshallReportA_ALT;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxClass, frxDBSet,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxExportPDF,
  frxExportHTML, frxExportBaseDialog, frxExportXLS, frxPrinter, dmSCM;

type
  TMarshallReportA_ALT = class(TDataModule)
    qryClubInfo: TFDQuery;
    frxClubInfo: TfrxDBDataset;
    qrySession: TFDQuery;
    qryEvent: TFDQuery;
    dsSession: TDataSource;
    dsEvent: TDataSource;
    dsHeat: TDataSource;
    qryHeat: TFDQuery;
    frxdsSession: TfrxDBDataset;
    frxdsEvent: TfrxDBDataset;
    frxdsHeat: TfrxDBDataset;
    qryEntrant: TFDQuery;
    dsEntrant: TDataSource;
    frxdsEntrant: TfrxDBDataset;
    qryTEAM: TFDQuery;
    dsTEAM: TDataSource;
    frxdsTEAM: TfrxDBDataset;
    qryTeamEntrant: TFDQuery;
    dsTeamEntrant: TDataSource;
    frxdsTeamEntrant: TfrxDBDataset;
    frxReport: TfrxReport;
    frxXLSExport1: TfrxXLSExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxPDFExport1: TfrxPDFExport;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure frxReportPrintReport(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LastPrinterName: string;
    procedure RunReport;

  end;

var
  MarshallReportA_ALT: TMarshallReportA_ALT;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TMarshallReportA_ALT.DataModuleDestroy(Sender: TObject);
begin
    qryClubInfo.Close;
    qrySession.Close;
    qryEvent.Close;
    qryHeat.Close;
    qryEntrant.Close;
    qryTEAM.Close;
    qryTeamEntrant.Close;
end;

procedure TMarshallReportA_ALT.DataModuleCreate(Sender: TObject);
begin
  if not Assigned(SCM) then
    raise Exception.Create('SCM data module not assigned.');
end;

procedure TMarshallReportA_ALT.frxReportPrintReport(Sender: TObject);
begin
	lastPrinterName :=
		frxPrinters.Printers[frxPrinters.PrinterIndex];
end;


procedure TMarshallReportA_ALT.RunReport;
var
  aSessionID: integer;
  aSessionStart: TDateTime;
  aSwimClubID: integer;
begin

  qryClubInfo.Connection := SCM.scmConnection;
  qrySession.Connection := SCM.scmConnection;
  qryEvent.Connection := SCM.scmConnection;
  qryHeat.Connection := SCM.scmConnection;
  qryEntrant.Connection := SCM.scmConnection;
  qryTEAM.Connection := SCM.scmConnection;
  qryTeamEntrant.Connection := SCM.scmConnection;

  aSessionID := SCM.Session_ID;
  aSessionStart := SCM.Session_Start;
  aSwimClubID := SCM.SwimClub_ID;

  if (aSessionID > 0) then
  begin
    // HEADER BANNER DATA
    qryClubInfo.Close;
    qryClubInfo.ParamByName('SWIMCLUBID').AsInteger := aSwimClubID;
    qryClubInfo.Prepare;
    qryClubInfo.Open;

    // SESSION REPORT
    qrySession.Close;
    qrySession.ParamByName('SESSIONID').AsInteger := aSessionID;
    qrySession.Prepare;
    qrySession.Open;

    qryEvent.Open;
    qryHeat.Open;

    // CALCULATE AGE
    qryEntrant.Close;
    qryEntrant.ParamByName('SESSIONDATE').AsDateTime := aSessionStart;
    qryEntrant.Prepare;
    qryEntrant.Open;

    qryTEAM.Open;

    // CALCULATE AGE
    qryTeamEntrant.Close;
    qryTeamEntrant.ParamByName('SESSIONDATE').AsDateTime := aSessionStart;
    qryTeamEntrant.Prepare;
    qryTeamEntrant.Open;

    if qrySession.Active then
      frxReport.ShowReport();

    qryClubInfo.Close;
    qrySession.Close;
    qryEvent.Close;
    qryHeat.Close;
    qryEntrant.Close;
    qryTEAM.Close;
    qryTeamEntrant.Close;

  end;
end;

end.
