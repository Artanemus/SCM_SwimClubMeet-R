unit frmDisqualificationCodes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxPreview, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  // NOTE: Component TfrxGradientView requires frxGradientRTTI
  frxDBSet, frxExportBaseDialog, frxExportPDF, frxGradientRTTI,
  Vcl.ExtCtrls, dmSCM, Vcl.StdCtrls
  ;

type
  TDisqualificationCodes = class(TForm)
    frxPreview1: TfrxPreview;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    qryDisqualifyCode: TFDQuery;
    frxPDFExport1: TfrxPDFExport;
    Panel1: TPanel;
    btnPrintPDF: TButton;
    btnClose: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure btnPrintPDFClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fConnection: TFDConnection;
  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      AConnection: TFDConnection);
  end;

var
  DisqualificationCodes: TDisqualificationCodes;

implementation

{$R *.dfm}

{ TForm1 }

procedure TDisqualificationCodes.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TDisqualificationCodes.btnPrintPDFClick(Sender: TObject);
begin
  frxReport1.PrepareReport;
  frxreport1.Export(frxPDFExport1);
end;

constructor TDisqualificationCodes.CreateWithConnection(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  inherited Create(AOwner);
  qryDisqualifyCode.Connection := AConnection;
  qryDisqualifyCode.Open;
  if qryDisqualifyCode.Active then
    frxReport1.ShowReport;
end;

procedure TDisqualificationCodes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryDisqualifyCode.Close;
end;

procedure TDisqualificationCodes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TDisqualificationCodes.FormShow(Sender: TObject);
begin
  if btnClose.CanFocus then
    btnClose.SetFocus;
end;

end.
