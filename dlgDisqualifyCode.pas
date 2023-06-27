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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
        fConnection: TFDConnection;
  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);

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
end;

procedure TDisqualifyCode.FormCreate(Sender: TObject);
begin
  // prepare SQL
  // assign RB
  //
end;

end.
