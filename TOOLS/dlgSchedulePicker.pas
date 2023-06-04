unit dlgSchedulePicker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPickers;

type
  TSchedulePicker = class(TForm)
    Panel1: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    TimePicker1: TTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fConnection: TFDConnection;

  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);

  end;

var
  SchedulePicker: TSchedulePicker;

implementation

{$R *.dfm}
{ TSchedulePicker }

procedure TSchedulePicker.btnCancelClick(Sender: TObject);
begin
ModalResult := mrCancel;
end;

procedure TSchedulePicker.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

constructor TSchedulePicker.CreateWithConnection(AOwner: TComponent;
  aConnection: TFDConnection);
begin
  inherited Create(AOwner);
  fConnection := aConnection;
end;

procedure TSchedulePicker.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end;
end;

end.
