unit dlgAutoBuild_Relay;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, dmSCM;

type
  TAutoBuild_Relay = class(TForm)
    Panel2: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
  private
    { Private declarations }
    prefExcludeOutsideLanes: boolean;
    prefNumOfSwimmersPerTeam: integer;

    function GetPoolLaneCount(): integer;

    procedure ReadPreferences(IniFileName: string);

  public
    { Public declarations }
  end;

var
  AutoBuild_Relay: TAutoBuild_Relay;

implementation

{$R *.dfm}

uses System.IniFiles, SCMUtility;

{ TAutoBuild_Relay }

function TAutoBuild_Relay.GetPoolLaneCount: integer;
var
IniFileName: TFileName;
Lanes: integer;
begin
  result := 0;

  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then
    ReadPreferences(IniFileName);

  // Get number of lanes from dbo.SwimClub.NumOfLanes
  Lanes := SCM.SwimClub_NumberOfLanes;
  if Lanes = 0 then
    Exit;

  // Adjust lanes if excluding outside lanes
  if prefExcludeOutsideLanes then
    Dec(Lanes, 2);

  // Ensure there is at least one lane
  if Lanes < 1 then
    Exit;

  result := Lanes;
end;

procedure TAutoBuild_Relay.ReadPreferences(IniFileName: string);
var
  iFile: TIniFile;
  i: Integer;
begin
  iFile := TIniFile.Create(IniFileName);

  // When true gutter lanes are not used in events.
  prefExcludeOutsideLanes := (iFile.ReadInteger('Preferences',
    'ExcludeOutsideLanes', 0) = 1);
  // Relay teams, by default, have four swimmers.
  prefNumOfSwimmersPerTeam := iFile.ReadInteger('Preferences',
    'NumOfSwimmersPerTeam', 4);

  iFile.free;
end;

end.
