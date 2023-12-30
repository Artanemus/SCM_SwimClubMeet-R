unit rptSessionReportA;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxClass, frxDBSet,
  frxExportPDF, frxExportHTML, frxExportBaseDialog, frxExportXLS, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dmSCM;

type
  TSessionReportA = class(TDataModule)
    frxReport1: TfrxReport;
    qryReport: TFDQuery;
    frxXLSExport1: TfrxXLSExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxPDFExport1: TfrxPDFExport;
    frxDSReport: TfrxDBDataset;
    qryClubInfoRpt: TFDQuery;
    frxClubInfo: TfrxDBDataset;
    qrySessionINDV: TFDQuery;
    frxdsINDV: TfrxDBDataset;
    qrySessionTEAM: TFDQuery;
    frxdsTEAM: TfrxDBDataset;
    frxReportINDV: TfrxReport;
    frxReportTEAM: TfrxReport;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RunReport;
  end;

var
  SessionReportA: TSessionReportA;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TSessionReportA.DataModuleDestroy(Sender: TObject);
begin
  qryReport.Close;
  qrySessionTEAM.Open;
end;

procedure TSessionReportA.DataModuleCreate(Sender: TObject);
begin
  if not Assigned(SCM) then
    raise Exception.Create('SCM data module not assigned.');
end;

procedure TSessionReportA.RunReport;
var
  aSessionID: integer;
begin
  qryReport.Connection := SCM.scmConnection;
  aSessionID := SCM.Session_ID;
  if (aSessionID > 0) then
  begin
    // CLUBINFO, EVENTS, INDV etc.
    qryReport.Close;
    qryReport.ParamByName('SID').AsInteger := aSessionID;
    qryReport.Prepare;
    qryReport.Open;
    // ONLY TEAM EVENTS
    qrySessionTEAM.Close;
    qrySessionTEAM.ParamByName('SID').AsInteger := aSessionID;
    qrySessionTEAM.Prepare;
    qrySessionTEAM.Open;
    if qryReport.Active and qrySessionTEAM.Active then
      frxReport1.ShowReport();
    qryReport.Close;
  end;
end;

end.
