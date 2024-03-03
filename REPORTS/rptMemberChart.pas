unit rptMemberChart;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxClass, frxDBSet,
  frxExportPDF, frxExportHTML, frxExportBaseDialog, frxExportXLS, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, VclTee.DBChart;

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
(*
	(void)Sender;
	// As SCM is a TEMPORY connection - ASSERT assignment for FireDAC.
	if (SCM != nullptr) {
		qryReport->Connection = SCM->scmConnection;
	}
	fDBChart = nullptr;
*)
end;

procedure TMemberChart.frxReport1BeforePrint(Sender: TfrxReportComponent);
begin
(*
	if (fDBChart != nullptr) {
		if (Sender->Name == "Picture1") {

			reinterpret_cast<TfrxPictureView*>(Sender)->Picture->Assign(

				fDBChart->TeeCreateMetafile(False,
				Rect(0, 0, int(Sender->Width), int(Sender->Height))));
		}
		if (Sender->Name == "memDistance") {
			reinterpret_cast<TfrxMemoView*>(Sender)->Memo->Clear();
			reinterpret_cast<TfrxMemoView*>(Sender)->Memo->Add
				("Distance: " + fDistanceStr);
		}
		if (Sender->Name == "memStroke") {
			reinterpret_cast<TfrxMemoView*>(Sender)->Memo->Clear();
			reinterpret_cast<TfrxMemoView*>(Sender)->Memo->Add
				("Stroke: " + fStrokeStr);
		}
	}
*)
end;

procedure TMemberChart.RunReport(aMemberID: integer; aDBChart: TDBChart;
  aDistanceStr, aStrokeStr: string);
begin
(*
	fDBChart = aDBChart;
	fDistanceStr = aDistanceStr;
	fStrokeStr = aStrokeStr;

	if (qryReport->Active)
		qryReport->Close();
	qryReport->ParamByName("MEMEBERID")->AsInteger = aMemberID;
	// changes to params will set Prepared to false
	qryReport->Prepare();
	qryReport->Open();
	if (qryReport->Active) {
		// this is no longer required ...
		// qryReport->Refresh();
		frxReport1->ShowReport();
	}
	qryReport->Close();
*)
end;

end.
