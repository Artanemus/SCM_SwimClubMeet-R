unit dlgDisqualifyCode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dmSCM, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TDisqualifyCode = class(TForm)
    qryDisqualifyCode: TFDQuery;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel1: TPanel;
    qryStroke: TFDQuery;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
        fConnection: TFDConnection;
        fEntrantID: integer;
  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);
    property EntrantID: integer read FEntrantID write FEntrantID;
  end;

var
  DisqualifyCode: TDisqualifyCode;

implementation

{$R *.dfm}

{ TDisqualifyCode }

constructor TDisqualifyCode.CreateWithConnection(AOwner: TComponent;
  aConnection: TFDConnection);
begin
  inherited Create(AOwner);
  fConnection := aConnection;
  fEntrantID := 0;

  if Assigned(fConnection) and fConnection.Connected then
  BEGIN
    qryStroke.Connection := fConnection;
    qryDisqualifyCode.Connection := fConnection;
  END;
end;

procedure TDisqualifyCode.FormCreate(Sender: TObject);
begin
  // prepare SQL
  // assign RB
  //
  if fEntrantID > 0 then
  begin
    qryStroke.ParamByName('EntrantID').AsInteger := fEntrantID;
    qryStroke.Prepare;
  end;


end;

end.
