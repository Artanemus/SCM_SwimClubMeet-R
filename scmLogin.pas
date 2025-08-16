unit scmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, Vcl.Imaging.pngimage, Vcl.WinXCtrls, Vcl.StdCtrls,
	{ scmSetting, uDefines, SCMSimpleConnect,}
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  Vcl.VirtualImage, dmSCM, dmIMG;

type
  TLogin = class(TForm)
    lblServer: TLabel;
    lblUserName: TLabel;
    lblPassword: TLabel;
    lblStatusMsg: TLabel;
    chkbOSAuthent: TCheckBox;
    edtPassword: TEdit;
    edtServer: TEdit;
    edtUser_Name: TEdit;
    pnlSideBar: TPanel;
    imgDTBanner: TImage;
    Panel2: TPanel;
    btnDisconnect: TButton;
    btnConnect: TButton;
    RelativePanel1: TRelativePanel;
    pnlBody: TPanel;
    btnDone: TButton;
    lblConnectionInfo: TLabel;
    vimgVisibility: TVirtualImage;

    procedure btnDisconnectClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDoneClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vimgVisibilityClick(Sender: TObject);
  private
    procedure ReadLoginParams();
    procedure SetConnectionInfo;
    procedure WriteLoginParams();

  public
    { Public declarations }

  published
  end;

var
  Login: TLogin;

implementation

{$R *.dfm}

uses exeinfo, System.IniFiles, frmMain, SCMUtility;


procedure TLogin.btnDisconnectClick(Sender: TObject);
begin
  lblStatusMsg.Caption := '';
  if Assigned(SCM.scmConnection) then
  begin
    if (SCM.scmConnection.Connected) then
    begin
      SCM.scmConnection.Close;
    end;
  end;

  if (SCM.scmConnection.Connected) then
  begin
    btnDisconnect.Visible := true;
    btnConnect.Visible := false;
  end
  else
  begin
    lblStatusMsg.Caption := 'Disconnected from DB server.';
    lblConnectionInfo. Caption := '';
    btnDisconnect.Visible := false;
    btnConnect.Visible := true;
  end;
end;

procedure TLogin.btnConnectClick(Sender: TObject);
begin
  if Assigned(SCM.scmConnection) then
  begin
    if (SCM.scmConnection.Connected) then
      SCM.scmConnection.Close;
    lblStatusMsg.Caption := 'Attempting to connect.';
    // Assert the default OLE DB provider login timeout. 10 seconds.
    SCM.WriteConnectionDef('MSSQL_SwimClubMeet', 'LoginTimeout', '10');
    btnDisconnect.Visible := false;
    btnConnect.Visible := false;
    WriteLoginParams();
    SCM.scmConnection.Open;
    if (SCM.scmConnection.Connected) then
    begin
      lblStatusMsg.Caption := 'Connected to DB server.';
      btnDisconnect.Visible := true;
      btnConnect.Visible := false;
      SetConnectionInfo;
    end
    else
    begin
      lblStatusMsg.Caption := 'Could not connect.';
      lblConnectionInfo. Caption := '';
      btnDisconnect.Visible := false;
      btnConnect.Visible := true;
    end;
  end;
end;

procedure TLogin.btnDoneClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TLogin.FormCreate(Sender: TObject);
begin
  lblStatusMsg.Caption := '';
  lblConnectionInfo.Caption := '';
  // by default always hide password.
  edtPassword.PasswordChar := '*';
  vimgVisibility.imageName := 'VisibilityOff';

  ReadLoginParams;
  if Assigned(SCM.scmConnection) then
  begin
    if (SCM.scmConnection.Connected) then
    begin
      lblStatusMsg.Caption := 'Connected to DB server.';
      btnDisconnect.Visible := true;
      btnConnect.Visible := false;
    end
    else
    begin
      lblStatusMsg.Caption := 'Could not connect.';
      btnDisconnect.Visible := false;
      btnConnect.Visible := true;
    end;
  end;
end;

procedure TLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    ModalResult := mrAbort;
end;

procedure TLogin.FormShow(Sender: TObject);
var
ParamValue: string;
begin
  lblStatusMsg.Caption := '';
  lblConnectionInfo.Caption := '';

  if Assigned(SCM.scmConnection) then
  begin
    // Form Caption. (reads TFDManager params).
    SCM.ReadConnectionDef('MSSQL_SwimClubMeet', 'DataBase', ParamValue);
    Caption := 'Connected to the ' + ParamValue + ' Database Server ...';
    // Status Message Caption.
    if SCM.scmConnection.Connected then
    begin
      lblStatusMsg.Caption := 'Connected to DB server.';
      SetConnectionInfo; // Machine, Server, SCM DB version.
      btnDisconnect.Visible := true;
      btnConnect.Visible := false;
    end
    else
    begin
      lblStatusMsg.Caption := 'Not connected.';
      btnDisconnect.Visible := false;
      btnConnect.Visible := true;
    end;
  end;
  btnDone.SetFocus;
end;

procedure TLogin.ReadLoginParams();
var
  iFile: TIniFile;
  iniFileName, UseOsAuthentication: string;
begin
  // scmFDManager SHOULD point to this connection definition file...
  // %AppData%\Artanemus\scm\FDConnectionDefs.ini
  iniFileName := SCM.scmFDManager.ActualConnectionDefFileName;
  if not FileExists(iniFileName) then exit;
  iFile := TIniFile.Create(iniFileName);
  edtServer.Text := iFile.ReadString('MSSQL_SwimClubMeet', 'Server', 'localHost\SQLEXPRESS');
  edtUser_Name.Text := iFile.ReadString('MSSQL_SwimClubMeet', 'User_Name', '');
  edtPassword.Text := iFile.ReadString('MSSQL_SwimClubMeet', 'Password', '');
  UseOsAuthentication := iFile.ReadString('MSSQL_SwimClubMeet', 'OSAuthent', 'Yes');
  UseOsAuthentication := LowerCase(UseOsAuthentication);
  if UseOsAuthentication.Contains('yes') or UseOsAuthentication.Contains('true') then
    chkbOSAuthent.Checked := true else chkbOSAuthent.Checked := false;
  iFile.Free;
end;

procedure TLogin.SetConnectionInfo;
var
  VersionInfo: string;
  HostMachine: string;
begin
  HostMachine := '';
  if Assigned(SCM.scmConnection) then
  begin
    if SCM.scmConnection.Connected then
    begin
      // Display some information on the connection.
      with  lblConnectionInfo do
      begin

{$IFDEF DEBUG}
        // Security issues. (wit: demostrating code).
        Caption := 'FireDAC''s Connection Definition :' + sLineBreak;
        Caption := Caption + '%APPDATA%\ARTANEMUS\SCM\FDConnectionDefs.ini' + sLineBreak + sLineBreak;
        VersionInfo := SCM.scmConnection.ExecSQLScalar(
    'SELECT CAST(SERVERPROPERTY(''ProductVersion'') AS VARCHAR(50)) + '' - '' ' +
    '+ CAST(SERVERPROPERTY(''ProductLevel'') AS VARCHAR(50)) + '' - '' ' +
    '+ CAST(SERVERPROPERTY(''Edition'') AS VARCHAR(50)) AS VersionInfo');
        Caption := Caption + 'Server version: ' + VersionInfo + sLineBreak;
        Caption := Caption + 'Host Machine: ARTANEMUS-LORE'  + sLineBreak;
        Caption := Caption + 'SCM database version: ' + SCM.GetDBVerInfo;
{$ELSE}
        Caption := 'FireDAC''s Connection Definition :' + sLineBreak;
        Caption := Caption + SCM.scmFDManager.ConnectionDefFileName + sLineBreak + sLineBreak;
        VersionInfo := SCM.scmConnection.ExecSQLScalar(
    'SELECT CAST(SERVERPROPERTY(''ProductVersion'') AS VARCHAR(50)) + '' - '' ' +
    '+ CAST(SERVERPROPERTY(''ProductLevel'') AS VARCHAR(50)) + '' - '' ' +
    '+ CAST(SERVERPROPERTY(''Edition'') AS VARCHAR(50)) AS VersionInfo');
        Caption := Caption + 'Server version: ' + VersionInfo + sLineBreak;
        HostMachine := SCM.scmConnection.ExecSQLScalar(
    'SELECT CAST(SERVERPROPERTY(''MachineName'') AS VARCHAR(50)) AS MachineName;');
        Caption := Caption + 'Host Machine: ' + HostMachine + sLineBreak;
        Caption := Caption + 'SCM database version: ' + SCM.GetDBVerInfo;
{$ENDIF}
      end;

    end
    else
      lblConnectionInfo.Caption := '';
  end;
end;

procedure TLogin.vimgVisibilityClick(Sender: TObject);
begin
  // toggle image
  if vimgVisibility.imageName = 'VisibilityOff' then
    vimgVisibility.imageName := 'VisibilityOn'
  else
    vimgVisibility.imageName := 'VisibilityOff';

  if vimgVisibility.imageName = 'VisibilityOn' then
    edtPassword.PasswordChar := #0
  else
    edtPassword.PasswordChar := '*';

end;

procedure TLogin.WriteLoginParams();
var
  iFile: TIniFile;
  iniFileName: string;
begin
  iniFileName := SCM.scmFDManager.ActualConnectionDefFileName;
  if not FileExists(iniFileName) then exit;
  iFile := TIniFile.Create(iniFileName);
  if chkbOSAuthent.Checked then
    iFile.WriteString('MSSQL_SwimClubMeet', 'OSAuthent', 'Yes')
  else
    iFile.WriteString('MSSQL_SwimClubMeet', 'OSAuthent', 'No');
  iFile.WriteString('MSSQL_SwimClubMeet', 'Password', edtPassword.Text);
  iFile.WriteString('MSSQL_SwimClubMeet', 'User_Name', edtUser_Name.Text);
  iFile.WriteString('MSSQL_SwimClubMeet', 'Server', edtServer.Text);
  iFile.Free;
end;

end.
