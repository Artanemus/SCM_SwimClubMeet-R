unit dlgSelectPrinter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSelectPrinter = class(TForm)
    Panel1: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    rbtnSendToPrinter: TRadioButton;
    rbtnSendToPDF: TRadioButton;
    lboxPrinters: TListBox;
    rgrpCollation: TRadioGroup;
    edtFolder: TEdit;
    btnBrowseForFolder: TButton;
    Panel2: TPanel;
  private
    { Private declarations }
    FPrinterName: String ;

  public
    { Public declarations }
    property PrinterName: string read FPrinterName write FPrinterName;
  end;

var
  SelectPrinter: TSelectPrinter;

implementation

{$R *.dfm}

end.
