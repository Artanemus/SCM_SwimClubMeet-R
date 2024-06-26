
unit SCMExeInfo;

interface


uses
  Windows, Messages, SysUtils, Classes, Forms, Graphics, Controls, Dialogs,
  TypInfo;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 3; // Minor version nr.
  REL_VER = 3; // Release nr.
  BLD_VER = 0; // Build nr.


type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  TExeInfo = class(TComponent)
  private
    { Private declarations }
    FCompanyName      : String;
    FFileDescription  : String;
    FFileVersion      : String;
    FInternalName     : String;
    FLegalCopyright   : String;
    FLegalTradeMark   : String;
    FOriginalFileName : String;
    FProductName      : String;
    FProductVersion   : String;
    FComments         : String;
    FComputerName     : String;
    FOsName           : String;
    FWindowsDir       : String;
    FSystemDir        : String;
    FTempDir          : String;
    FFileFlags        : integer;
    FFileOS           : integer;
    FFileType         : integer;
    FFileCreation     : TDateTime;
    FMyDocumentsDir: string;
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    function GetFileVersionInt: integer;
    function GetMyDocumentsDir: string;
  protected
    { Protected declarations }
    function GetVersionNr: Integer; virtual;
    procedure GetVersionInfo; virtual;
    function GetComputerName : String; virtual;
    //procedure SetComputerName(AName : String); virtual;
    function GetWinDir : String;
    function GetSysDir : String;
    function GetTempDir : String;
    function GetVersionPart(idx: integer): integer;
  public
    { Public declarations }
    procedure GetVersionInfoOfApp(const AAppName:String); 
    constructor Create(AOwner: TComponent); override;
    property FileFlags        : integer read FFileFlags;
    property FileOS           : integer read FFileOS;
    property FileType         : integer read FFileType;
    property FileCreation     : TDateTime read FFileCreation;
    function GetOperatingSystem : string; virtual;
    function MajorVersion: integer;
    function MinorVersion: integer;
    function ReleaseNumber: integer;
    function BuildNumber: integer;
    property FileVersionInt: integer read GetFileVersionInt;
  published
    { Published declarations }
    property CompanyName      : string read FCompanyName write FCompanyName stored false;
    property FileDescription  : string read FFileDescription write FFileDescription stored false;
    property FileVersion      : string read FFileVersion write FFileVersion stored false;
    property InternalName     : string read FInternalName write FInternalName stored false;
    property LegalCopyright   : string read FLegalCopyright write FLegalCopyright stored false;
    property LegalTradeMark   : string read FLegalTradeMark write FLegalTradeMark stored false;
    property OriginalFileName : string read FOriginalFileName write FOriginalFileName stored false;
    property ProductName      : string read FProductName write FProductName stored false;
    property ProductVersion   : string read FProductVersion write FProductVersion stored false;
    property Comments         : string read FComments write FComments stored false;
    property ComputerName     : string read GetComputerName stored false;
    property OSName           : string read GetOperatingSystem write FOSName stored false;
    property WindowsDir       : string read GetWinDir write FWindowsDir stored false;
    property SystemDir        : string read GetSysDir write FSystemDir stored false;
    property TempDir          : string read GetTempDir write FTempDir stored false;
    property MyDocumentsDir   : string read GetMyDocumentsDir write FMyDocumentsDir stored false;
    property Version          : string read GetVersion write SetVersion;
  end;


implementation

uses
  StrUtils, ShlObj;


function TExeInfo.BuildNumber: integer;
begin
  Result := GetVersionPart(3);
end;

constructor TExeInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCompanyName      := 'Updated at run-time';
  FFileDescription  := 'Updated at run-time';
  FFileVersion      := 'Updated at run-time';
  FInternalName     := 'Updated at run-time';
  FLegalCopyright   := 'Updated at run-time';
  FLegalTradeMark   := 'Updated at run-time';
  FOriginalFileName := 'Updated at run-time';
  FProductName      := 'Updated at run-time';
  FProductVersion   := 'Updated at run-time';
  FComments         := 'Updated at run-time';
  FComputerName     := '';

  if not (csDesigning in ComponentState) then
    Begin
      GetVersionInfo;
      FComputerName := GetComputerName;
    End;
end;

procedure TExeInfo.GetVersionInfoOfApp(const AAppName: string);
type
  PTransBuffer = ^TTransBuffer;
  TTransBuffer = array[1..4] of smallint;
var
  iAppSize, iLenOfValue : DWord;
  pcBuf,pcValue         : PChar;
  VerSize               : DWord;
  pTrans                : PTransBuffer;
  TransStr              : string;
  sAppName              : String;
  fvip                  : pointer;
  ft                    : TFileTime;
  st                    : TSystemTime;
begin
  sAppName := AAppName;
  // get version information values
  iAppSize:= GetFileVersionInfoSize(PChar(sAppName),// pointer to filename string
                                    iAppSize);      // pointer to variable to receive zero
   // if GetFileVersionInfoSize is successful
  if (iAppSize > 0) then
    begin
      pcBuf := AllocMem(iAppSize);

      GetFileVersionInfo(PChar(sAppName),              // pointer to filename string
                         0,                            // ignored
                         iAppSize,                     // size of buffer
                         pcBuf);                       // pointer to buffer to receive file-version info.


      VerQueryValue(pcBuf, '\', fvip, iLenOfValue);

      FFileFlags := TVSFixedFileInfo(fvip^).dwFileFlags and TVSFixedFileInfo (fvip^).dwFileFlagsMask;
      FFileOS := TVSFixedFileInfo(fvip^).dwFileOS;
      FFileType := TVSFixedFileInfo(fvip^).dwFileType;

      ft.dwLowDateTime := TVSFixedFileInfo(fvip^).dwFileDateLS;
      ft.dwHighDateTime := TVSFixedFileInfo(fvip^).dwFileDateMS;

      if (ft.dwLowDateTime <> 0) or (ft.dwHighDateTime <> 0) then
      begin
        FileTimeToSystemTime(ft,st);
        FFileCreation := SystemTimeToDateTime(st);
      end
      else
      begin
        FileAge(Application.ExeName, FFileCreation);
      end;

      VerQueryValue(pcBuf, PChar('\VarFileInfo\Translation'),
              pointer(ptrans), verSize);
      TransStr:= IntToHex(ptrans^[1], 4) + IntToHex(ptrans^[2], 4);

      if VerQueryValue(pcBuf,PChar('StringFileInfo\' + TransStr + '\' +
           'CompanyName'), Pointer(pcValue),iLenOfValue) then
            FCompanyName := pcValue
      Else  FCompanyName := '';
      if VerQueryValue(pcBuf,PChar('StringFileInfo\' + TransStr + '\' +
           'FileDescription'), Pointer(pcValue),iLenOfValue) then
            FFileDescription := pcValue
      Else  FFileDescription := '';
      if VerQueryValue(pcBuf,PChar('StringFileInfo\' + TransStr + '\' +
           'FileVersion'), Pointer(pcValue),iLenOfValue) then
            FFileVersion := pcValue
      Else  FFileVersion := '';
      if VerQueryValue(pcBuf,PChar('StringFileInfo\' + TransStr + '\' +
           'InternalName'), Pointer(pcValue),iLenOfValue) then
            FInternalName := pcValue
      Else  FInternalName := '';
      if VerQueryValue(pcBuf,PChar('StringFileInfo\' + TransStr + '\' +
           'LegalCopyright'), Pointer(pcValue),iLenOfValue) then
            FLegalCopyright := pcValue
      Else  FLegalCopyright := '';
      if VerQueryValue(pcBuf,PChar('StringFileInfo\' + TransStr + '\' +
           'LegalTradeMarks'), Pointer(pcValue),iLenOfValue) then
            FLegalTradeMark := pcValue
      Else  FLegalTradeMark := '';
      if VerQueryValue(pcBuf,PChar('StringFileInfo\' + TransStr + '\' +
           'OriginalFileName'), Pointer(pcValue),iLenOfValue) then
            FOriginalFileName := pcValue
      Else  FOriginalFileName := '';
      if VerQueryValue(pcBuf,PChar('StringFileInfo\' + TransStr + '\' +
           'ProductName'), Pointer(pcValue),iLenOfValue) then
            FProductName := pcValue
      Else  FProductName := '';
      if VerQueryValue(pcBuf,PChar('StringFileInfo\' + TransStr + '\' +
           'ProductVersion'), Pointer(pcValue),iLenOfValue) then
            FProductVersion := pcValue
      Else  FProductVersion := '';
      if VerQueryValue(pcBuf,PChar('StringFileInfo\' + TransStr + '\' +
           'Comments'), Pointer(pcValue),iLenOfValue) then
            FComments := pcValue
      Else  FComments := '';
      FreeMem(pcBuf,iAppSize);
    end;
end;

procedure TExeInfo.GetVersionInfo;            
begin
  GetVersionInfoOfApp(Application.ExeName);
end;

function TExeInfo.GetComputerName : String;
var
   pcComputer : PChar;
   dwCSize    : DWORD;
begin
   dwCSize := MAX_COMPUTERNAME_LENGTH + 1;
   GetMem( pcComputer, dwCSize * 2); // allocate memory for the string
   try
      if Windows.GetComputerName( pcComputer, dwCSize ) then
         GetComputerName := StrPas(pcComputer);
   finally
      FreeMem( pcComputer ); // now free the memory allocated for the string
   end;
end;

function TExeInfo.GetFileVersionInt: integer;
var
  sl: TStringList;
  verstr: string;
  i: integer;
begin
  Result := -1;

  if FileVersion = '' then
    Exit;

  verstr := StringReplace(FileVersion,'.','.',[rfReplaceAll]);

  sl := TStringList.Create;

  try
    sl.CommaText := verstr;

    verstr := '';
    for i := 0 to sl.Count - 1 do
    begin
      while (length(sl[i]) < 2) do
        sl[i] := '0' + sl[i];

      sl[i] := copy(sl[i],1,2);

      verstr := verstr + sl[i];
    end;
  finally
    sl.Free;
  end;

  Result := StrToInt(verstr);
end;

function TExeInfo.GetMyDocumentsDir: string;
var
  r: Bool;
  path: array[0..Max_Path] of Char;
begin
  r := ShGetSpecialFolderPath(0, path, CSIDL_Personal, False) ;
  if not r then
    raise Exception.Create('Could not find MyDocuments folder location.') ;
  Result := Path;
end;

function TExeInfo.GetOperatingSystem : string;
const
  SM_SERVERR2 = 89;
  VER_NT_WORKSTATION = $0000001;
type
  pfnRtlGetVersion = function(var RTL_OSVERSIONINFOEXW): DWORD; stdcall;
type
  TOSVersionInfoEx = record
    dwOSVersionInfoSize:DWORD;
    dwMajorVersion:DWORD;
    dwMinorVersion:DWORD;
    dwBuildNumber:DWORD;
    dwPlatformId:DWORD;
    szCSDVersion: array[0..127] of Char;
    wServicePackMajor:WORD;
    wServicePackMinor:WORD;
    wSuiteMask:WORD;
    wProductType:BYTE;
    wReserved:BYTE;
  End;

var
  osVerInfo: TOSVersionInfoEx;
  majorVer, minorVer: Cardinal;
  ver: RTL_OSVERSIONINFOEXW;
  RtlGetVersion: pfnRtlGetVersion;


  procedure GetUnmanistedVersion(var majv,minv: cardinal);
  begin
    @RtlGetVersion := GetProcAddress(GetModuleHandle('ntdll.dll'), 'RtlGetVersion');
    if Assigned(RtlGetVersion) then
    begin
      ZeroMemory(@ver, SizeOf(ver));
      ver.dwOSVersionInfoSize := SizeOf(ver);

      if RtlGetVersion(ver) = 0 then
      begin
        majv := ver.dwMajorVersion;
        minv := ver.dwMinorVersion;
      end;
    end;
  end;

begin
  Result := 'Unknown';
  { set operating system type flag }
  osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
  if GetVersionEx(Windows.POSVersionInfo(@osVerInfo)^) then
  begin
    majorVer := osVerInfo.dwMajorVersion;
    minorVer := osVerInfo.dwMinorVersion;

    case osVerInfo.dwPlatformId of
      VER_PLATFORM_WIN32_NT: { Windows NT/2000 }
        begin
          if majorVer <= 4 then
            Result := 'Windows NT'
          else if (majorVer = 5) and (minorVer = 0) then
            Result := 'Windows 2000'
          else if (majorVer = 5) and (minorVer = 1) then
            Result := 'Windows XP'
          else if (majorVer = 5) and (minorVer = 2) then
            Result := 'Windows 2003'
          else if (majorVer = 6) and (minorVer = 0) then
          begin
            Result := 'Windows Vista';

            if osVerInfo.wProductType = VER_NT_WORKSTATION then
              Result := 'Windows Vista'
            else
              Result := 'Windows Server 2008';
          end
          else if (majorVer = 6) and (minorVer = 1) then
          begin
            if osVerInfo.wProductType = VER_NT_WORKSTATION then
               Result := 'Windows 7'
            else
               Result := 'Windows Server 2008R2';
          end
          else if (majorVer = 6) and (minorVer = 2) then
          begin
            GetUnmanistedVersion(majorVer, minorVer);

            if (majorVer = 6) and (minorVer = 2) then
            begin
              if osVerInfo.wProductType = VER_NT_WORKSTATION then
                Result := 'Windows 8'
              else
                Result := 'Windows Server 2012'
            end;

            if (majorVer = 6) and (minorVer = 3) then
            begin
              if osVerInfo.wProductType = VER_NT_WORKSTATION then
                Result := 'Windows 8.1'
              else
                Result := 'Windows Server 2012R2'
            end;

            if (majorVer = 10) and (minorVer = 0) then
            begin
              if osVerInfo.wProductType = VER_NT_WORKSTATION then
                Result := 'Windows 10'
              else
                Result := 'Windows Server 2016'
            end;

          end
          else if (majorVer = 6) and (minorVer = 3) then
          begin
            if osVerInfo.wProductType = VER_NT_WORKSTATION then
              Result := 'Windows 8.1'
            else
              Result := 'Windows Server 2012R2'
          end
          else if (majorVer = 6) and (minorVer = 4) then
          begin
            if osVerInfo.wProductType = VER_NT_WORKSTATION then
              Result := 'Windows 10'
            else
              Result := 'Windows Server 2016'
          end
          else
            Result := 'Unknown';
        end;
      VER_PLATFORM_WIN32_WINDOWS:  { Windows 9x/ME }
        begin
          if (majorVer = 4) and (minorVer = 0) then
            Result := 'Windows 95'
          else if (majorVer = 4) and (minorVer = 10) then
          begin
            if osVerInfo.szCSDVersion[1] = 'A' then
              Result := 'Windows 98 SE'
            else
              Result := 'Windows 98';
          end
          else if (majorVer = 4) and (minorVer = 90) then
            Result := 'Windows ME'
          else
            Result := 'Unknown';
        end;
      else
        Result := 'Unknown';
    end;
  end
  else
    Result := 'Unknown';
end;

function TExeInfo.GetWinDir : String;
//Returns the windows directory
var
   pcWindowsDirectory : PChar;
   dwWDSize           : DWORD;
begin
   dwWDSize := MAX_PATH + 1;
   GetMem( pcWindowsDirectory, dwWDSize * 2); // allocate memory for the string
   try
      if Windows.GetWindowsDirectory( pcWindowsDirectory, dwWDSize ) <> 0 then
         Result := StrPas(pcWindowsDirectory) + '\';
   finally
      FreeMem( pcWindowsDirectory ); // now free the memory allocated for the string
   end;
end;

function TExeInfo.MajorVersion: integer;
begin
  Result := GetVersionPart(0);
end;

function TExeInfo.MinorVersion: integer;
begin
  Result := GetVersionPart(1);
end;

function TExeInfo.ReleaseNumber: integer;
begin
  Result := GetVersionPart(2);
end;

function TExeInfo.GetSysDir : String;
//Returns system directory
var
   pcSystemDirectory : PChar;
   dwSDSize          : DWORD;
begin
   dwSDSize := MAX_PATH + 1;
   GetMem( pcSystemDirectory, dwSDSize * 2); // allocate memory for the string
   try
      if Windows.GetSystemDirectory( pcSystemDirectory, dwSDSize ) <> 0 then
         Result := StrPas(pcSystemDirectory) + '\';
   finally
      FreeMem( pcSystemDirectory ); // now free the memory allocated for the string
   end;
end;

function TExeInfo.GetTempDir : String;
//Returns temp directory
var
   pcTempDirectory : PChar;
   dwSDSize          : DWORD;
begin
   dwSDSize := MAX_PATH + 1;
   GetMem( pcTempDirectory, dwSDSize * 2); // allocate memory for the string
   try
      if Windows.GetTempPath( dwSDSize, pcTempDirectory ) <> 0 then
         Result := pcTempDirectory;
   finally
      FreeMem( pcTempDirectory ); // now free the memory allocated for the string
   end;
end;



function TExeInfo.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TExeInfo.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

function TExeInfo.GetVersionPart(idx: integer): integer;
var
  sl: TStringList;
  verstr: string;
begin
  Result := -1;

  if FileVersion = '' then
    Exit;

  verstr := StringReplace(FileVersion,'.',',',[rfReplaceAll]);

  sl := TStringList.Create;
  try
    sl.CommaText := verstr;

    if idx < sl.Count then
      Result := StrToInt(sl.Strings[idx]);
  finally
    sl.Free;
  end;
end;

procedure TExeInfo.SetVersion(const Value: string);
begin

end;

end.



