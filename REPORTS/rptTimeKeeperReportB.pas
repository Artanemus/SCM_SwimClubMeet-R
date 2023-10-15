unit rptTimeKeeperReportB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxClass, frxDBSet,
  frxExportPDF, frxExportHTML, frxExportBaseDialog, frxExportXLS, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxPrinter;

type
  TTimeKeeperReportB = class(TDataModule)
    qryReport: TFDQuery;
    frxXLSExport1: TfrxXLSExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxPDFExport1: TfrxPDFExport;
    frxDSReport: TfrxDBDataset;
    frxReport1: TfrxReport;
    qryClubInfoRpt: TFDQuery;
    frxClubInfo: TfrxDBDataset;
    procedure frxReport1PrintReport(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LastPrinterName: string;
    procedure Prepare(AConnection: TFDConnection; AHeatID: integer);
    procedure RunReport;
  end;

var
  TimeKeeperReportB: TTimeKeeperReportB;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TTimeKeeperReportB }

procedure TTimeKeeperReportB.frxReport1PrintReport(Sender: TObject);
begin
	lastPrinterName :=
		frxPrinters.Printers[frxPrinters.PrinterIndex];
end;

procedure TTimeKeeperReportB.Prepare(AConnection: TFDConnection;
  AHeatID: integer);
begin
  qryReport.Connection := AConnection;
  qryReport.ParamByName('HEATID').AsInteger := AHeatID;
  qryReport.Prepare();
  qryReport.Open();
end;

procedure TTimeKeeperReportB.RunReport;
begin
  if qryReport.Active then
  begin
    frxReport1.ShowReport;
    qryReport.Close
  end;

end;

end.
