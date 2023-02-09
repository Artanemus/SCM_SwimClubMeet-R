unit rptMemberDetail;

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
  TMemberDetail = class(TDataModule)
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
    qryPB: TFDQuery;
    qryPBEventStr: TWideStringField;
    qryPBPB: TTimeField;
    qryPBMemberID: TFDAutoIncField;
    qryPBDistanceID: TFDAutoIncField;
    qryPBStrokeID: TFDAutoIncField;
    frxDBPB: TfrxDBDataset;
    qryPBIsQualified: TBooleanField;
    qryHistory: TFDQuery;
    frxDBHistory: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RunReport(AConnection: TFDConnection; ASwimClubID, AMemberID: integer);
  end;

var
  MemberDetail: TMemberDetail;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1MemberDetailRpt }

procedure TMemberDetail.RunReport(AConnection: TFDConnection;
  ASwimClubID, AMemberID: integer);
begin
	qryReport.Connection := AConnection;
	qryReport.ParamByName('SWIMCLUBID').AsInteger := aSwimClubID;
	qryReport.ParamByName('MEMBERID').AsInteger := aMemberID;
	qryReport.Prepare;
	qryReport.Open;
  qryMemberContacts.Connection := AConnection;
	qryMemberContacts.ParamByName('SWIMCLUBID').AsInteger := aSwimClubID;
	qryMemberContacts.ParamByName('MEMBERID').AsInteger := aMemberID;
	qryMemberContacts.Prepare;
  qryMemberContacts.Open;
  qryPB.Connection := AConnection;
	qryPB.ParamByName('MEMBERID').AsInteger := aMemberID;
	qryPB.Prepare;
  qryPB.Open;
	qryHistory.Connection := AConnection;
	qryHistory.ParamByName('SWIMCLUBID').AsInteger := aSwimClubID;
	qryHistory.ParamByName('MEMBERID').AsInteger := aMemberID;
	qryHistory.Prepare;
	qryHistory.Open;
	if qryReport.Active then
		frxReport1.ShowReport();
	qryReport.Close;
  qryMemberContacts.Close;
  qryPB.Close;
  qryHistory.Close;
end;

end.
