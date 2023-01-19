unit dlgAutoBuild_Finals;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls, SCMDefines;

type
  TAutoBuild_Finals = class(TForm)
    Panel2: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    lblSeedDepth2: TLabel;
    lblSeedDepth1: TLabel;
    Label2: TLabel;
    prefSeperateGender: TCheckBox;
    prefExcludeOutsideLanes: TCheckBox;
    CheckBox1: TCheckBox;
    rgpSeedMethod: TRadioGroup;
    spnSeedDepth: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
	procedure ReadPreferences(AIniFileName: string);
	procedure WritePreferences(AiniFileName: string);
  public
    { Public declarations }
    TypeOfEvent: scmEventFinalsType;
  end;

var
  AutoBuild_Finals: TAutoBuild_Finals;

implementation

uses system.IniFiles, SCMUtility;

{$R *.dfm}


{ TAutoBuild_Finals }

procedure TAutoBuild_Finals.FormCreate(Sender: TObject);
var
iniFileName: string;
begin
	// read from preference file
	iniFileName := GetSCMPreferenceFileName();
	if FileExists(iniFileName) then
		ReadPreferences(iniFileName);
	TypeOfEvent := ftFinals;
end;

procedure TAutoBuild_Finals.FormShow(Sender: TObject);
var
  s: string;
begin
  s := ' Auto-Build for the current selected event?';
  // Setup controls based on TypeOfFinal;
  case TypeOfEvent of
    ftFinals:
      begin
        rgpSeedMethod.ItemIndex := 0;
        spnSeedDepth.Value := 3;
        Caption := 'Auto Build Finals.';
        Label1.Caption := 'Perform a FINALS' + s;
      end;
    ftSemi:
      begin
        rgpSeedMethod.ItemIndex := 1;
        spnSeedDepth.Value := 2;
        Caption := 'Auto Build Semi-Finals.';
        Label1.Caption := 'Perform a SEMI-FINALS' + s;
      end;
    ftQuarter:
      begin
        rgpSeedMethod.ItemIndex := 1;
        spnSeedDepth.Value := 3;
        Caption := 'Auto Build Quarter-Finals.';
        Label1.Caption := 'Perform a QUARTER-FINALS' + s;
      end;
  end;
  btnOk.SetFocus();
end;

procedure TAutoBuild_Finals.ReadPreferences(AIniFileName: string);
var
iFile: TIniFile;
i: integer;
begin
	iFile := TIniFile.Create(AIniFileName);
  i :=  iFile.ReadInteger('Preferences','ExcludeOutsideLanes_finals', integer(cbUnchecked));
  if (i = integer(cbChecked)) then
    prefExcludeOutsideLanes.Checked := true
  else
    prefExcludeOutsideLanes.Checked := false;
  i := iFile.ReadInteger('Preferences',	'SeperateGender_finals', integer(cbUnchecked));
  if (i = integer(cbChecked)) then
    prefSeperateGender.Checked := true
  else
    prefSeperateGender.Checked := false;
	// 2020-11-01 auto-build v2 seed depth for Circle Seed
	spnSeedDepth.Value := (iFile.ReadInteger('Preferences', 'SeedDepth_finals', 3));
	iFile.Free;
end;

procedure TAutoBuild_Finals.WritePreferences(AIniFileName: string);
var
iFile: TIniFile;
begin
	iFile := TIniFile.Create(AIniFileName);
	iFile.WriteInteger('Preferences', 'ExcludeOutsideLanes_finals',
		integer(prefExcludeOutsideLanes.State));
	iFile.WriteInteger('Preferences', 'SeperateGender_finals',
		integer(prefSeperateGender.State));
	// 2020-11-01 auto-build v2 seed depth for Circle Seed
	iFile.WriteInteger('Preferences', 'SeedDepth_finals',	spnSeedDepth.Value);
	iFile.Free;
end;

end.
