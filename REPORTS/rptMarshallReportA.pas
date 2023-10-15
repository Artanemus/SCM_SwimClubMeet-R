unit rptMarshallReportA;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxClass, frxDBSet,
  frxExportPDF, frxExportHTML, frxExportBaseDialog, frxExportXLS, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxPrinter;

type
  TMarshallReportA = class(TDataModule)
    frxReport1: TfrxReport;
    qryReport: TFDQuery;
    frxXLSExport1: TfrxXLSExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxPDFExport1: TfrxPDFExport;
    frxSessionReport: TfrxDBDataset;
    qryClubInfoRpt: TFDQuery;
    frxClubInfo: TfrxDBDataset;
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure frxReport1PrintReport(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LastPrinterName: string;
    procedure Prepare(AConnection: TFDConnection; AEventID: integer);
    procedure RunReport;

  end;

var
  MarshallReportA: TMarshallReportA;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TMarshallReportA.frxReport1BeforePrint(Sender: TfrxReportComponent);
begin
//  PageHeaderTeamName.visible := false;
end;

{ TMarshallReportA }

procedure TMarshallReportA.frxReport1PrintReport(Sender: TObject);
begin
	lastPrinterName :=
		frxPrinters.Printers[frxPrinters.PrinterIndex];
end;

procedure TMarshallReportA.Prepare(AConnection: TFDConnection;
  AEventID: integer);
begin
  qryReport.Connection := AConnection;
  qryReport.ParamByName('EVENTID').AsInteger := AEventID;
  qryReport.Prepare();
  qryReport.Open();
end;

procedure TMarshallReportA.RunReport;
begin
  if qryReport.Active then
  begin
    frxReport1.ShowReport;
    qryReport.Close
  end;
end;

end.
