unit SCMUtility;

interface

{
  All Artanemus applications have there application-specific information and
  settings stored in TIniFiles files.

  The location is given as...
  $APPDATA$\Artanemus\SCM\$PREFFILENAME$.ini

  $APPDATA$ exspands too...
  'C:\Users\USERNAME\AppData\Roaming\'
}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.Win.Registry, shlobj;

function CreateSCMPrefFileName(AFileName: TFileName): boolean;
function DeleteSCMPrefFileName(AFileName: TFileName): boolean;
function GetSCMAppDataDir(): string;
function GetSCM_SharedIniFile(): string;
function GetSCMCommonAppDataDir(): string;
function ExistsSCMConnectionDefs(): boolean; deprecated;
function GetSCMPreferenceFileName(AName: String): string; overload;
function GetSCMPreferenceFileName(): string; overload;
function GetSCMTempDir(): string;
function GetSCMHelpPrefFileName(): string;
function GetSCMDocumentDir(): string;
function GetRegAppPath(appName: string): string;
function GetRegArtanemusAppPath(appName: string): string;
function ScatterLanes(index, NumOfPoolLanes: integer): integer;
function CheckInternetA: Boolean;
function CheckInternetB: Boolean;


const
  PrefFileName = 'SCMPref.ini';
  HelpPrefFileName = 'SCMHelpPref.ini';
  SCMSubFolder = 'Artanemus\SCM\';
  SCMSectionName = 'SCM';

  // D E P R E C A T E D .
  // Static connection definitions are no longer in used.
  // --------------------------------------------------
  SCMConnectionDefsFileName = 'SCMConnectionDefs.ini';
  SCMConnectionDefsName = 'MSSQL_SwimClubMeet';
  // --------------------------------------------------

implementation

uses
  System.Math,
  WinInet, // for interenet
  IdTCPClient;   // for checkinternet

// Winapi.ShLwApi;

function GetSCM_SharedIniFile(): string;
begin
  result := GetSCMAppDataDir + PrefFileName;
end;


// WINDOWS API FUNCTION
function CheckInternetA: Boolean;
var
  origin: Cardinal;
begin
Result := False;
  if InternetGetConnectedState(@origin,0) then
    Result := True;
end;

// POLL GOOGLE
function CheckInternetB: Boolean;
var TCPClient:TIdTCPClient;
begin
  TCPClient := TIdTCPClient.Create(NIL);
  try
    try
      TCPClient.ReadTimeout := 2000;
      TCPClient.ConnectTimeout := 2000;
      TCPClient.Port := 80;
      TCPClient.Host := 'google.com';
      TCPClient.Connect;
      TCPClient.Disconnect;
      Result := true;
    except
      Result := false;
    end;
  finally
    TCPClient.Free;
  end;
end;

function CreateSCMPrefFileName(AFileName: TFileName): boolean;
var
  filehandle: NativeUInt;
begin
  result := false;
  // create the Help Preference file in 'APPDATA'
  filehandle := FileCreate(AFileName);
  // if NOT 'file already exists'
  if not(filehandle = INVALID_HANDLE_VALUE) then
  begin
    FileClose(filehandle); // close.
    result := true;
  end;
end;

function DeleteSCMPrefFileName(AFileName: TFileName): boolean;
begin
  result := false;
  // delete the Help Preference file in 'APPDATA'
  if (FileExists(AFileName)) then
    result := DeleteFile(AFileName);
end;

function GetSCMAppDataDir(): string;
var
  str: string;
begin

  result := '';
  str := GetEnvironmentVariable('APPDATA');
  str := IncludeTrailingPathDelimiter(str);
  // Append product-specific path
  str := str + SCMSubFolder;
  if not DirectoryExists(str) then
  begin
    { *
      ForceDirectories creates a new directory as specified in Dir, which must be
      a fully-qualified pathname. If the directories given in the path do not yet
      exist, ForceDirectories attempts to create them. ForceDirectories returns
      True if it successfully creates all necessary directories, False if it could
      not create a needed directory.
      Note: Do not call ForceDirectories with an empty string. Doing so causes
      ForceDirectories to raise an exception.
      * }
    if not System.SysUtils.ForceDirectories(str) then
      // FAILED! - Use alternative default document directory...
      exit;
  end;
  result := str;
end;

function GetSCMCommonAppDataDir(): string;
var
  str: string;
  szPath: array [0 .. Max_Path] of Char;
begin
  result := '';
  if (SUCCEEDED(SHGetFolderPath(null, CSIDL_COMMON_APPDATA, 0, 0, szPath))) then
  begin
    str := String(szPath);
    str := IncludeTrailingPathDelimiter(str) + SCMSubFolder;
    if not DirectoryExists(str) then
    begin
      if not CreateDir(str) then
        exit;
    end;
  end;
  result := str;
end;

// ---------------------------------------------------------------------------
// D E P R E C A T E D .
// ---------------------------------------------------------------------------
function ExistsSCMConnectionDefs(): boolean;
  deprecated 'SCM static connection definitions are no longer in used.';
var
  str: string;
  szPath: array [0 .. Max_Path] of Char;
begin
  result := false;
  if (SUCCEEDED(SHGetFolderPath(null, CSIDL_COMMON_APPDATA, 0, 0, szPath))) then
  begin
    str := String(szPath);
    str := IncludeTrailingPathDelimiter(str) + SCMSubFolder +
      SCMConnectionDefsFileName;;
    if FileExists(str) then
      result := true;
  end;
end;
// ---------------------------------------------------------------------------

function GetSCMPreferenceFileName(AName: String): string;
var
  str: string;
  success: boolean;
begin
  result := '';
  str := GetSCMAppDataDir;
  if str.IsEmpty then
    exit;
  str := str + AName;
  if not FileExists(str) then
  begin
    success := CreateSCMPrefFileName(str);
    if not success then
      exit;
  end;
  result := str;
end;

function GetSCMPreferenceFileName(): string;
begin
  result := GetSCMPreferenceFileName(PrefFileName);
end;

function GetSCMTempDir(): string;
var
  str: string;
begin
  result := '';
  str := GetEnvironmentVariable('TMP');
  str := IncludeTrailingPathDelimiter(str);
  if not DirectoryExists(str) then
  begin
    if not CreateDir(str) then
      exit;
  end;
  result := str;
end;

function GetSCMHelpPrefFileName(): string;
begin
  result := GetSCMPreferenceFileName(HelpPrefFileName);
end;

function GetSCMDocumentDir(): string;
begin
  result := GetEnvironmentVariable('HOMEPATH');
  result := IncludeTrailingPathDelimiter(result);
  result := result + 'SCM\';
end;

function GetRegAppPath(appName: string): string;
var
  reg: TRegistry;
  KeyName: string;
begin
  KeyName := '\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\';
  result := '';
  reg := TRegistry.Create(KEY_READ);
  try
    begin
      reg.RootKey := HKEY_LOCAL_MACHINE;
      if reg.KeyExists(KeyName) then
      begin
        reg.OpenKey(KeyName, false);
        result := reg.ReadString('Path');
      end;
    end;
  finally
    reg.Free;
  end;
end;

function GetRegArtanemusAppPath(appName: string): string;
var
  reg: TRegistry;
  KeyName: string;
begin
  KeyName := '\Software\\Artanemus\';
  result := '';
  KeyName := KeyName + appName + '\';
  result := '';
  reg := TRegistry.Create(KEY_READ);
  try
    begin
      reg.RootKey := HKEY_CURRENT_USER;
      reg.OpenKey(KeyName, false);
      result := reg.ReadString('Path');
    end;
  finally
    reg.Free;
  end;
end;

// -----------------------------------------------------------
// SHARED FUNCTION
// Called by dmSCM and dmAutoBuildV2
// -----------------------------------------------------------
function ScatterLanes(index, NumOfPoolLanes: integer): integer;
var
  Lanes: Array of integer;
  i: integer;
  IsEven: boolean;
begin
  result := 0;
  // NumOfPoolLanes must be greater than 1
  if (NumOfPoolLanes < 2) then
    exit;
  // index passed is base 0
  // test for out-of-bounds
  if ((index + 1) > NumOfPoolLanes) then
    exit;
  SetLength(Lanes, NumOfPoolLanes);
  // seed number for first array value
  // Find the center lane. For 'odd' number of pool lanes - round up;
  Lanes[0] := Ceil(double(NumOfPoolLanes) / 2.0);
  // build the
  for i := 1 to NumOfPoolLanes - 1 do
  begin
    // start the iterate at index 1
    // reference previous value in list with base 0
    if (((i + 1) MOD 2) = 0) then
      IsEven := true
    else
      IsEven := false;
    if IsEven then
      Lanes[i] := (i) + (Lanes[(i - 1)])
    else
      Lanes[i] := (Lanes[(i - 1)]) - (i);
  end;
  // pull the entrants lane number.
  result := Lanes[index];

  {
    You don't need to call SetLength at the end.
    A dynamic-array field like 'Lanes' gets released automatically when
    the object is destroyed.
  }
  // free the array.   ALT Lanes := nil;
  // SetLength(Lanes, 0);
end;

end.
