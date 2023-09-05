unit rptNominateReportB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxExportMail, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxExportXLS, frxExportPDF,
  frxClass, frxExportBaseDialog, frxExportHTML, frxDBSet, dmSCM;

type
  TNominateReportB = class(TDataModule)
    frxReport1: TfrxReport;
    frxDSReport: TfrxDBDataset;
    frxHTMLExport1: TfrxHTMLExport;
    frxPDFExport1: TfrxPDFExport;
    frxXLSExport1: TfrxXLSExport;
    qryReport: TFDQuery;
    frxMailExport1: TfrxMailExport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RunReport;
  end;

var
  NominateReportB: TNominateReportB;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TNominateReportB.DataModuleCreate(Sender: TObject);
begin
	if not Assigned(SCM) then
    raise exception.Create('SCM not assigned.');
end;

procedure TNominateReportB.RunReport;
begin
  qryReport.Connection := SCM.scmConnection;
  qryReport.ParamByName('SESSIONID').AsInteger := SCM.Session_ID;
  qryReport.Prepare;
  qryReport.Open;
  if qryReport.Active then
    frxReport1.ShowReport;
  qryReport.Close;
end;

end.
