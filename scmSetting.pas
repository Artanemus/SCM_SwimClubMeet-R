unit scmSetting;

interface

uses
  system.IOUtils,
  system.SysUtils, system.Types, system.UITypes, system.Classes,
  system.Variants, VCL.Controls,
	XsuperObject;

type

  TPrgSetting = Class
  private
    { private declarations }

  protected
    { protected declarations }
  public
		{ public declarations }


		constructor Create();
		function GetDefaultSettingsFilename(): string;
		function GetSettingsFolder(): string;
		procedure LoadFromFile(AFileName: string = '');
		procedure SaveToFile(AFileName: string = '');

		{ published declarations }
	end;

	const
		CONNECTIONTIMEOUT = 20;  // default is 0 - infinate...

var
	Settings: TPrgSetting;

implementation

const JSONFILENAME = 'SwimClubMeet.json';
const SUBFOLDER = 'Artanemus\SCM\SwimClubMeet';

constructor TPrgSetting.Create();
begin
	{
	ForceDirectories creates a new directory as specified in Dir,
	which must be a fully-qualified path name. If the directories given in
	the path do not yet exist, ForceDirectories attempts to create them
	}
	ForceDirectories(Settings.GetSettingsFolder());
end;

function TPrgSetting.GetDefaultSettingsFilename(): string;
begin
	result := TPath.Combine(GetSettingsFolder(), JSONFILENAME);
end;

function TPrgSetting.GetSettingsFolder(): string;
begin

//  result := TPath.Combine(TPath.GetHomePath(), 'MyProg');
//  result := ExtractFilePath(ParamStr(0));

{$IFDEF MACOS}
	Result := TPath.Combine(TPath.GetLibraryPath(), SUBFOLDER);
{$ELSE}
  // GETHOMEPATH = C:Users\<username>\AppData\Roaming (WINDOWS)
  // Should also work on ANDROID.
	Result := TPath.Combine(TPath.GetHomePath(), SUBFOLDER);
{$ENDIF}

end;

procedure TPrgSetting.LoadFromFile(AFileName: string = '');
var
  Json: string;
begin
  if AFileName = '' then
    AFileName := GetDefaultSettingsFilename();

  if not FileExists(AFileName) then
    exit;

  Json := TFile.ReadAllText(AFileName, TEncoding.UTF8);
  AssignFromJSON(Json); // magic method from XSuperObject's helper
end;

procedure TPrgSetting.SaveToFile(AFileName: string = '');
var
  Json: string;
begin
  if AFileName = '' then
    AFileName := GetDefaultSettingsFilename();

  Json := AsJSON(True); // magic method from XSuperObject's helper too
  TFile.WriteAllText(AFileName, Json, TEncoding.UTF8);
end;




end.
