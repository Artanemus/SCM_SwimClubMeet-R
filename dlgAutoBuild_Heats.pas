unit dlgAutoBuild_Heats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TAutoBuild_Heats = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ReadPreferences(IniFileName: string);
    procedure WritePreferences(IniFileName: string);
  public
    { Public declarations }
  end;

var
  AutoBuild_Heats: TAutoBuild_Heats;

implementation

{$R *.dfm}

uses SCMUtility, IniFiles;
{
 With the exception of 'closed' and 'raced' heats, all heats held in the current event
 will be deleted prior to running auto-build.

 Only members nominated for the current event are considered. Nominees held
 in 'closed' or 'raced' heats are excluded from the 'Entrant Pool'.

 Entrants are given lane placements based on 'TimeToBeat'. This algorithm is
 calculated each time an auto-build is executed.

 The fastest heat is always the last heat. Fastest lanes are the two center
 lanes. Slowest, the two outer lanes.
}

procedure TAutoBuild_Heats.FormCreate(Sender: TObject);
var
iniFileName: string;
begin
	iniFileName := GetSCMPreferenceFileName();
	if FileExists(iniFileName) then
		ReadPreferences(iniFileName);
end;

procedure TAutoBuild_Heats.FormDestroy(Sender: TObject);
var
iniFileName: string;
begin
	iniFileName := GetSCMPreferenceFileName();
	if FileExists(iniFileName) then
		WritePreferences(iniFileName);
end;

procedure TAutoBuild_Heats.FormShow(Sender: TObject);
begin
  btnOk.SetFocus;
end;

procedure TAutoBuild_Heats.ReadPreferences(IniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(IniFileName);
  // TTB defaults to (1) .. the entrant's average of top 3 race-times
  prefHeatAlgorithm.ItemIndex :=
    (iFile.ReadInteger('Preferences', 'HeatAlgorithm', 1));
  // default to - get an average race-time of other swimmers
  prefUseDefRaceTime.State := TCheckBoxState(iFile.ReadInteger('Preferences',
    'UseDefRaceTime', integer(cbChecked)));
  // The bottom percent to select from ... default is 50%
  prefRaceTimeTopPercent.Value :=
    (iFile.ReadInteger('Preferences', 'RaceTimeTopPercent', 50));
  // auto-create heats - this option will omit gutter lanes
  prefExcludeOutsideLanes.State :=
    TCheckBoxState(iFile.ReadInteger('Preferences', 'ExcludeOutsideLanes',
    integer(cbUnchecked)));
  prefSeperateGender.State := TCheckBoxState(iFile.ReadInteger('Preferences',
    'SeperateGender', integer(cbUnchecked)));
  prefGroupBy.ItemIndex := iFile.ReadInteger('Preferences', 'GroupBy', 0);
  rgpSeedMethod.ItemIndex := iFile.ReadInteger('Preferences', 'SeedMethod', 0);
  // 2020-11-01 auto-build v2 seed depth for Circle Seed */
  spnSeedDepth.Value := (iFile.ReadInteger('Preferences', 'SeedDepth', 3));
  iFile.Free;
end;

procedure TAutoBuild_Heats.WritePreferences(IniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(IniFileName);
  iFile.WriteInteger('Preferences', 'HeatAlgorithm',
    prefHeatAlgorithm.ItemIndex);
  iFile.WriteInteger('Preferences', 'UseDefRaceTime',
    integer(prefUseDefRaceTime.State));
  iFile.WriteInteger('Preferences', 'RaceTimeTopPercent',
    prefRaceTimeTopPercent.Value);
  iFile.WriteInteger('Preferences', 'ExcludeOutsideLanes',
    integer(prefExcludeOutsideLanes.State));
  iFile.WriteInteger('Preferences', 'SeperateGender',
    integer(prefSeperateGender.State));
  iFile.WriteInteger('Preferences', 'GroupBy', prefGroupBy.ItemIndex);
  iFile.WriteInteger('Preferences', 'SeedMethod', rgpSeedMethod.ItemIndex);
  // 2020-11-01 auto-build v2 seed depth for Circle Seed */
  iFile.WriteInteger('Preferences', 'SeedDepth', (spnSeedDepth.Value));
  iFile.Free;
end;

end.
