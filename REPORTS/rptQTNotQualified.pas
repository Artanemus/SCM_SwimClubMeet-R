unit rptQTNotQualified;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxClass, frxDBSet,
  frxExportPDF, frxExportHTML, frxExportBaseDialog, frxExportXLS, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dmSCM;

type
  TQTNotQualified = class(TDataModule)
    frxReport1: TfrxReport;
    qryReport: TFDQuery;
    frxXLSExport1: TfrxXLSExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxPDFExport1: TfrxPDFExport;
    frxDSReport: TfrxDBDataset;
    frxDBReportHeader: TfrxDBDataset;
    qryReportHeader: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RunReport;

  end;

var
  QTNotQualified: TQTNotQualified;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TQTNotQualified.DataModuleCreate(Sender: TObject);
begin
  if not Assigned(SCM) then
    raise Exception.Create('SCM not assigned.');
end;

procedure TQTNotQualified.RunReport;
begin
	qryReportHeader.Connection := SCM.scmConnection;
  qryReportHeader.ParamByName('SWIMCLUBID').AsInteger := SCM.SwimClub_ID;
	qryReportHeader.Prepare;
	qryReportHeader.Open;
	qryReport.Connection := SCM.scmConnection;
  qryReport.ParamByName('SESSIONID').AsInteger := SCM.Session_ID;
	qryReport.Prepare;
	qryReport.Open;
	if qryReportHeader.Active and qryReport.Active then
		frxReport1.ShowReport;
	qryReportHeader.Close;
	qryReport.Close;
end;

end.
