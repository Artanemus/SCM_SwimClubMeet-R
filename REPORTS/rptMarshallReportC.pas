unit rptMarshallReportC;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dmSCM, frxClass, frxDBSet,
  frxPrinter;

type
  TMarshallReportC = class(TDataModule)
    qryMain: TFDQuery;
    frxDBMain: TfrxDBDataset;
    qryTEAM: TFDQuery;
    qryINDV: TFDQuery;
    dsMain: TDataSource;
    frxDBTEAM: TfrxDBDataset;
    frxDBINDV: TfrxDBDataset;
    frxReport1: TfrxReport;
    qryClubInfoRpt: TFDQuery;
    frxClubInfo: TfrxDBDataset;
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
  MarshallReportC: TMarshallReportC;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TMarshallReportC.frxReport1PrintReport(Sender: TObject);
begin
	lastPrinterName :=
		frxPrinters.Printers[frxPrinters.PrinterIndex];
end;

{ TMarshallReportC }

procedure TMarshallReportC.Prepare(AConnection: TFDConnection;
  AEventID: integer);
begin
  qryMain.Connection := AConnection;
  qryMain.ParamByName('EVENTID').AsInteger := AEventID;
  qryMain.Prepare();
  qryMain.Open();
end;

procedure TMarshallReportC.RunReport;
begin
  if qryMain.Active then
  begin
    frxReport1.ShowReport;
    qryMain.Close
  end;
end;

end.
