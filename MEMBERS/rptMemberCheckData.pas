unit rptMemberCheckData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass, frxDBSet, frxExportXLS,
  frxExportBaseDialog, frxExportCSV, frxExportPDF;

type
  TMemberCheckData = class(TDataModule)
    qryDataCheck: TFDQuery;
    frxDBDataCheck: TfrxDBDataset;
    frxReport1: TfrxReport;
    frxCSVExport1: TfrxCSVExport;
    frxXLSExport1: TfrxXLSExport;
    frxPDFExport1: TfrxPDFExport;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RunReport(AConnection: TFDConnection; ASwimClubID: integer);
  end;

var
  MemberCheckData: TMemberCheckData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TMemberCheckData.RunReport(AConnection: TFDConnection;
  ASwimClubID: integer);
begin
	qryDataCheck.Connection := AConnection;
  qryDataCheck.ParamByName('SWIMCLUBID').AsInteger := aSwimClubID;
	qryDataCheck.Prepare;
	qryDataCheck.Open;
	if qryDataCheck.Active then
		frxReport1.ShowReport();
	qryDataCheck.Close;
end;

end.
