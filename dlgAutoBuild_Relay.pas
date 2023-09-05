unit dlgAutoBuild_Relay;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TAutoBuild_Relay = class(TForm)
    Panel2: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AutoBuild_Relay: TAutoBuild_Relay;

implementation

{$R *.dfm}

end.
