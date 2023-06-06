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
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fConnection: TFDConnection;
    fSeedTime: TTime;

  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);
    property SeedTime: TTime read fSeedTime write fSeedTime;

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
  fSeedTime := TimePicker1.Time;
  ModalResult := mrOK;
end;

constructor TSchedulePicker.CreateWithConnection(AOwner: TComponent;
  aConnection: TFDConnection);
begin
  inherited Create(AOwner);
  fConnection := aConnection;
  fSeedTime := 0;
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

procedure TSchedulePicker.FormShow(Sender: TObject);
begin
  if fSeedTime > 0 then
    TimePicker1.Time := fSeedTime
  else
    TimePicker1.Time := Time;
end;

end.
