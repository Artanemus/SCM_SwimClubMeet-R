unit rptQTMemberReportA;

interface

uses
  System.SysUtils, System.Classes, dmSCM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  frxClass, frxDBSet, frxExportPDF, frxExportHTML, frxExportBaseDialog,
  frxExportXLS, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TQTMemberReportA = class(TDataModule)
    qryReport: TFDQuery;
    frxXLSExport1: TfrxXLSExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxPDFExport1: TfrxPDFExport;
    frxDSReport: TfrxDBDataset;
    frxReport1: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RunReport;
  end;

var
  QTMemberReportA: TQTMemberReportA;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TQTMemberReportA }

procedure TQTMemberReportA.DataModuleCreate(Sender: TObject);
begin
  if not Assigned(SCM) then
    raise Exception.Create('SCM not assigned.');
end;

procedure TQTMemberReportA.RunReport;
begin
	qryReport.Connection := SCM.scmConnection;
  qryReport.ParamByName('CLUBNAME').AsString := SCM.SwimClub_ClubName;
  qryReport.ParamByName('CLUBNICKNAME').AsString := SCM.SwimClub_NickName;
	qryReport.Prepare;
	qryReport.Open;
	if qryReport.Active then
		frxReport1.ShowReport;
	qryReport.Close;
end;

end.
