unit dlgABRelay;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, dmSCM,
  dmSCMHelper, SCMDefines, Vcl.Imaging.jpeg, Vcl.Samples.Spin,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImage,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList;

type
  TABRelay = class(TForm)
    Panel2: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    pnlHeader: TPanel;
    Label1: TLabel;
    Image1: TImage;
    pnlPrefences: TPanel;
    lblMemberMissingData: TLabel;
    lblPercent: TLabel;
    prefHeatAlgorithm: TRadioGroup;
    prefUseDefRaceTime: TCheckBox;
    prefRaceTimeTopPercent: TSpinEdit;
    prefExcludeOutsideLanes: TCheckBox;
    prefSeperateGender: TCheckBox;
    prefDoHouseRelays: TCheckBox;
    prefNumOfSwimmersPerTeam: TSpinEdit;
    lblSwimmersPerTeam: TLabel;
    prefVerbose: TCheckBox;
    prefTrimPartialTeams: TCheckBox;
    bhintABRelay: TBalloonHint;
    imgcolABRelay: TImageCollection;
    vimgHint1: TVirtualImage;
    vimgHint2: TVirtualImage;
    vimgHint3: TVirtualImage;
    rgrpAlgorithm: TRadioGroup;
    spnAcceptableMargin: TSpinEdit;
    lblAcceptableMargin: TLabel;
    vimgPackMethod: TVirtualImage;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure vimgHint1Click(Sender: TObject);
    procedure vimgHintMouseLeave(Sender: TObject);
    procedure vimgHint2Click(Sender: TObject);
    procedure vimgHint3Click(Sender: TObject);
    procedure vimgPackMethodClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadPreferences(IniFileName: string);
    procedure WritePreferences(IniFileName: string);
  public
    { Public declarations }
  end;

var
  ABRelay: TABRelay;

implementation

{$R *.dfm}

uses System.IniFiles, SCMUtility;

procedure TABRelay.FormDestroy(Sender: TObject);
var
iniFileName: string;
begin
	iniFileName := GetSCMPreferenceFileName();
	if FileExists(iniFileName) then
		WritePreferences(iniFileName);
end;

procedure TABRelay.FormCreate(Sender: TObject);
var
  IniFileName: TFileName;
begin
  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then
    ReadPreferences(IniFileName);
end;

procedure TABRelay.FormShow(Sender: TObject);
begin
  btnOk.SetFocus;
end;

{ TAutoBuild_Relay }

procedure TABRelay.ReadPreferences(IniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(IniFileName);

  // 2024-08-26 AUTO-BUILD RELAYS.
  // Pack Method.
  rgrpAlgorithm.ItemIndex :=
    (iFile.ReadInteger('Preferences', 'PackAlgorithm', 0));

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

//  prefGroupBy.ItemIndex := iFile.ReadInteger('Preferences', 'GroupBy', 0);
//  rgpSeedMethod.ItemIndex := iFile.ReadInteger('Preferences', 'SeedMethod', 0);

  // 2020-11-01 auto-build v2 seed depth for Circle Seed */
//  spnSeedDepth.Value := (iFile.ReadInteger('Preferences', 'SeedDepth', 3));

  // 2024-10-3 auto-build relays acceptable margin for refined algorithm */
  spnAcceptableMargin.Value := (iFile.ReadInteger('Preferences', 'AcceptableMargin', 20));

  // 2024-09-10
  // Relay teams, by default, have four swimmers.
  prefNumOfSwimmersPerTeam.Value := iFile.ReadInteger('Preferences',
    'NumOfSwimmersPerTeam', 4);

  iFile.Free;
end;

procedure TABRelay.vimgHint1Click(Sender: TObject);
begin
  bhintABRelay.Title := 'Verbose.';
  bhintABRelay.Description := '''
  If a problem is encounted when trying to Auto-Build,
  then an error message will be displayed, prior to aborting.
  ''';
  bhintABRelay.ShowHint(vimgHint1);
end;

procedure TABRelay.vimgHintMouseLeave(Sender: TObject);
begin
  bhintABRelay.HideHint;
end;

procedure TABRelay.vimgHint2Click(Sender: TObject);
begin
  bhintABRelay.Title := 'Insuffient swimmers in team.';
  bhintABRelay.Description := '''
  If a team doesn't have a full complement of swimmers,
  that team will be removed.
  ''';
  bhintABRelay.ShowHint(vimgHint2);
end;

procedure TABRelay.vimgHint3Click(Sender: TObject);
begin
  bhintABRelay.Title := 'Group by Club-House .';
  bhintABRelay.Description := '''
  Relay teams will only be allowed swimmers that share
  the same House ...as designated in the member's profile.
  ''';
  bhintABRelay.ShowHint(vimgHint3);

end;

procedure TABRelay.vimgPackMethodClick(Sender: TObject);
begin
  bhintABRelay.Title := 'Pack Method';
  bhintABRelay.Description := '''
  The Basic pack method is ideal when members' race times vary widely. It uses this broad range to build teams.
  The Refined method should be used when members' Time-To-Beat (TTB) values are closely grouped together.
  The Acceptable margin sets a threshold for team member selection; default is 20%, adjustable from 10% to 60%. Lower margins are recommended for groups with less variation in TTB.
  The Genetic Algorithm takes longer and may yield unpredictable results but often outperforms other methods by simulating natural selection principles to optimize team composition.
  ''';
  bhintABRelay.ShowHint(vimgPackMethod);
end;


procedure TABRelay.WritePreferences(IniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(IniFileName);

  // 2024-08-26 AUTO-BUILD RELAYS.
  // Pack Method.
  iFile.WriteInteger('Preferences', 'PackAlgorithm',
    rgrpAlgorithm.ItemIndex);

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
//  iFile.WriteInteger('Preferences', 'GroupBy', prefGroupBy.ItemIndex);
//  iFile.WriteInteger('Preferences', 'SeedMethod', rgpSeedMethod.ItemIndex);

  // 2020-11-01 auto-build v2 seed depth for Circle Seed */
//  iFile.WriteInteger('Preferences', 'SeedDepth', (spnSeedDepth.Value));

  // 2024-10-3 auto-build relays acceptable margin for refined algorithm */
  iFile.WriteInteger('Preferences', 'AcceptableMargin', (spnAcceptableMargin.Value));


  // 2024-09-10
  // Relay teams, by default, have four swimmers.
  iFile.WriteInteger('Preferences', 'NumOfSwimmersPerTeam',
    (prefNumOfSwimmersPerTeam.Value));
  iFile.Free;
end;



end.
