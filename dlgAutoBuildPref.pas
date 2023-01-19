unit dlgAutoBuildPref;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TAutoBuildPref = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Image1: TImage;
    Panel2: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    Panel3: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    lblSeedDepth1: TLabel;
    prefHeatAlgorithm: TRadioGroup;
    prefUseDefRaceTime: TCheckBox;
    prefRaceTimeTopPercent: TSpinEdit;
    prefExcludeOutsideLanes: TCheckBox;
    prefSeperateGender: TCheckBox;
    prefGroupBy: TRadioGroup;
    rgpSeedMethod: TRadioGroup;
    spnSeedDepth: TSpinEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AutoBuildPref: TAutoBuildPref;

implementation

{$R *.dfm}

end.
