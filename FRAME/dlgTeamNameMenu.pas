unit dlgTeamNameMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client;

type
  TTeamNameMenu = class(TForm)
    btnCreateNewTeam: TButton;
    btnRenameTeam: TButton;
    btnClearTeam: TButton;
    btnStrikeTeam: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnCreateNewTeamClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fTeamID: integer;
    fTeamNameID: integer;
    fConnection: TFDConnection;
    function NextTeamNameSuffix(): char;
  public
    { Public declarations }
    procedure Prepare(AConnection: TFDConnection;
  ATeamID: integer);
    property TeamID: integer read fTeamID write fTeamID;
    property TeamNameID: integer read fTeamNameID write fTeamNameID;

  end;

var
  TeamNameMenu: TTeamNameMenu;

implementation

{$R *.dfm}

procedure TTeamNameMenu.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TTeamNameMenu.btnCreateNewTeamClick(Sender: TObject);
var
  SQL, suffix, s: string;
  rows: integer;
  v: variant;
  C: char;
begin
  fTeamID := 0;
  C := NextTeamNameSuffix;
  // calc next letter
  if C = #0 then
  begin
    ModalResult := mrCancel;
    exit;
  end;

  suffix := string(C);
  s := 'Team ' + suffix;
  // insert a teamname record
  SQL := 'INSERT INTO SwimClubMeet.dbo.TeamName ' +
    '([CaptionShort],[ABREV]) VALUES (:ID1, :ID2)';
  rows := fConnection.ExecSQL(SQL, [s, suffix]);
  if rows > 0 then
  begin
    // return the TeamID;
    SQL := 'SELECT IDENT_CURRENT(''dbo.TeamName'') AS ID';
    v := fConnection.ExecSQLScalar(SQL);
    if not VarIsNull(v) and not VarIsEmpty(v) then
      fTeamID := v;
  end;

  if fTeamID = 0 then
    ModalResult := mrCancel
  else
    ModalResult := mrOk;
end;

procedure TTeamNameMenu.FormCreate(Sender: TObject);
begin
  btnCreateNewTeam.Enabled := true;
  btnRenameTeam.Enabled := false;
  btnClearTeam.Enabled := false;
  btnStrikeTeam.Enabled := false;
  fConnection := nil;
  fTeamID := 0;
  fTeamNameID := 0;
end;

procedure TTeamNameMenu.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TTeamNameMenu.FormShow(Sender: TObject);
begin
  if not Assigned(fConnection) then ModalResult := mrCancel; // close;

  if fTeamNameID <> 0 then
  begin
    btnCreateNewTeam.Enabled := false;
    btnRenameTeam.Enabled := true;
    btnClearTeam.Enabled := true;
    btnStrikeTeam.Enabled := true;
  end;
end;

function TTeamNameMenu.NextTeamNameSuffix: char;
var
s1, SQL: string;
C: Char;
v: variant;
begin
  result := #0;
  s1 := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  for C in s1 do
  begin
    SQL := 'SELECT Count(TeamNameID) FROM SwimClubMeet.dbo.TeamName WHERE [ABREV] = :ID';
    v := fConnection.ExecSQLScalar(SQL, [string(C)]);
    if v = 0 then
    begin
      result := C;
    break;
    end;
  end;
end;

procedure TTeamNameMenu.Prepare(AConnection: TFDConnection;
  ATeamID: integer);
var
SQL: string;
v: variant;
begin
  fTeamID := 0;
  fTeamNameID := 0;
  if Assigned(AConnection) then
  begin
    fConnection := AConnection;
    fTeamID := ATeamID;
    SQL := 'SELECT TeamNameID FROM SwimClubMeet.dbo.Team WHERE Team.TeamID = :ID';
    v := fConnection.ExecSQLScalar(SQL, [fTeamID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
      fTeamNameID := v;
  end;
end;

end.
