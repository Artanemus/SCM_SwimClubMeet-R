unit uSettings;

interface
uses
  system.IOUtils,
  system.SysUtils, system.Types, system.UITypes, system.Classes,
  system.Variants, VCL.Controls,
  XsuperObject;

type

  TAppSetting = Class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    LoginTimeOut: integer;
    DoLoginOnBoot: boolean;

    constructor Create();
    function GetDefaultSettingsFilename(): string;
    function GetSettingsFolder(): string;
    procedure LoadFromFile(AFileName: string = '');
    procedure SaveToFile(AFileName: string = '');
  end;

  const
    CONNECTIONTIMEOUT = 20;  // default is 0 - infinate...

var
  Settings: TAppSetting;

implementation

constructor TAppSetting.Create();
begin
  LoginTimeOut := CONNECTIONTIMEOUT;
  DoLoginOnBoot := false;
  ForceDirectories(Settings.GetSettingsFolder());
end;

function TAppSetting.GetDefaultSettingsFilename(): string;
begin
  result := TPath.Combine(GetSettingsFolder(), 'scmSettings.json');
end;

function TAppSetting.GetSettingsFolder(): string;
begin
//  result := TPath.Combine(TPath.GetHomePath(), 'MyProg');
//  result := ExtractFilePath(ParamStr(0));
{$IFDEF MACOS}
  Result := TPath.Combine(TPath.GetLibraryPath(), 'Artanemus\SWimClubMeet');
{$ELSE}
  // GETHOMEPATH = C:Users\<username>\AppData\Roaming (WINDOWS)
  // Should also work on ANDROID.
  Result := TPath.Combine(TPath.GetHomePath(), 'Artanemus\SCM\SwimClubMeet');
{$ENDIF}

end;

procedure TAppSetting.LoadFromFile(AFileName: string = '');
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

procedure TAppSetting.SaveToFile(AFileName: string = '');
var
  Json: string;
begin
  if AFileName = '' then
    AFileName := GetDefaultSettingsFilename();
  Json := AsJSON(True); // magic method from XSuperObject's helper too
  TFile.WriteAllText(AFileName, Json, TEncoding.UTF8);
end;




end.
