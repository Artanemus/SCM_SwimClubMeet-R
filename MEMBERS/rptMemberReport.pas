unit rptMemberReport;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxExportMail, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxExportXLS, frxExportPDF,
  frxClass, frxExportBaseDialog, frxExportHTML, frxDBSet, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait;

type
  TMemberReport = class(TDataModule)
    frxReport1: TfrxReport;
    frxDSReport: TfrxDBDataset;
    frxHTMLExport1: TfrxHTMLExport;
    frxPDFExport1: TfrxPDFExport;
    frxXLSExport1: TfrxXLSExport;
    qryReport: TFDQuery;
    frxMailExport1: TfrxMailExport;
    qryMemberContacts: TFDQuery;
    frxDBContacts: TfrxDBDataset;
    FDConnection1: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RunReport(AConnection: TFDConnection; ASwimClubID, AMemberID: integer);
  end;

var
  MemberReport: TMemberReport;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1MemberDetailRpt }

procedure TMemberReport.RunReport(AConnection: TFDConnection;
  ASwimClubID, AMemberID: integer);
begin
  qryMemberContacts.Connection := AConnection;
  qryMemberContacts.Open;
	qryReport.Connection := AConnection;
	qryReport.ParamByName('SWIMCLUBID').AsInteger := aSwimClubID;
	qryReport.ParamByName('MEMBERID').AsInteger := aMemberID;
	qryReport.Prepare;
	qryReport.Open;
	if qryReport.Active then
		frxReport1.ShowReport();
	qryReport.Close;
  qryMemberContacts.Close;
end;

end.
