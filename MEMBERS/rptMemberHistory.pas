unit rptMemberHistory;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxClass, frxDBSet,
  frxExportPDF, frxExportHTML, frxExportBaseDialog, frxExportXLS, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TMemberHistory = class(TDataModule)
    frxReport1: TfrxReport;
    qryReport: TFDQuery;
    frxXLSExport1: TfrxXLSExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxPDFExport1: TfrxPDFExport;
    frxDSReport: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RunReport(AConnection: TFDConnection; ASwimClubID, AMemberID: integer);
  end;

var
  MemberHistory: TMemberHistory;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TMemberHistory.RunReport(AConnection: TFDConnection;
  ASwimClubID, AMemberID: integer);
begin
	qryReport.Connection := AConnection;
	qryReport.ParamByName('SWIMCLUBID').AsInteger := aSwimClubID;
	qryReport.ParamByName('MEMBERID').AsInteger := aMemberID;
	qryReport.Prepare;
	qryReport.Open;
	if qryReport.Active then
		frxReport1.ShowReport();
	qryReport.Close;
end;

end.
