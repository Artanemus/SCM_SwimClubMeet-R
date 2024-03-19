unit rptMemberChart;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxClass, frxDBSet,
  frxExportPDF, frxExportHTML, frxExportBaseDialog, frxExportXLS, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, VclTee.DBChart, dmSCM
  , System.Types;

type
  TMemberChart = class(TDataModule)
    frxReport1: TfrxReport;
    qryReport: TFDQuery;
    frxXLSExport1: TfrxXLSExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxPDFExport1: TfrxPDFExport;
    frxDSReport: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    { Private declarations }
    fDBChart: TDBChart;
    fDistanceStr: string;
    fStrokeStr: string;
  public
    { Public declarations }
    procedure RunReport(aMemberID: integer; aDBChart: TDBChart;
	                  aDistanceStr, aStrokeStr: string);
  end;

var
  MemberChart: TMemberChart;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TMemberChart.DataModuleCreate(Sender: TObject);
begin
	// Assert connection
	if Assigned (SCM) then
		qryReport.Connection := SCM.scmConnection;
	fDBChart := nil;
end;

procedure TMemberChart.frxReport1BeforePrint(Sender: TfrxReportComponent);
var
  myRect: TRect;
begin

  if Assigned(fDBChart) then
  begin
    if (Sender.Name = 'Picture1') then
    begin
      myRect := Rect(0, 0, Round(TfrxPictureView(Sender).Width),
        Round(TfrxPictureView(Sender).Height));
      TfrxPictureView(Sender).Picture.Assign
        (fDBChart.TeeCreateMetafile(False, myRect));
      TfrxPictureView(Sender).Picture.Assign
        (fDBChart.TeeCreateMetafile(False, myRect));
    end;
{
      if (Sender.Name = 'memDistance') then
      begin
        TfrxMemoView(Sender).Memo.Clear();
        TfrxMemoView(Sender).Memo.Add('Distance: ' + fDistanceStr);
      end;
      if (Sender.Name = 'memStroke') then
      begin
        TfrxMemoView(Sender).Memo.Clear();
        TfrxMemoView(Sender).Memo.Add('Stroke: ' + fStrokeStr);
      end;
}
  end;
end;

procedure TMemberChart.RunReport(aMemberID: integer; aDBChart: TDBChart;
  aDistanceStr, aStrokeStr: string);
begin

	fDBChart := aDBChart;
	fDistanceStr := aDistanceStr;
	fStrokeStr := aStrokeStr;

	if (qryReport.Active) then	qryReport.Close();
	qryReport.ParamByName('MEMEBERID').AsInteger := aMemberID;
	qryReport.Prepare();
	qryReport.Open();
	if (qryReport.Active) then
		frxReport1.ShowReport();

	qryReport.Close();

end;

end.
