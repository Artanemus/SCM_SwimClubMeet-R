unit dlgAutoSchedule;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPickers, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet;

type
  TAutoSchedule = class(TForm)
    Panel1: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    Label3: TLabel;
    Label4: TLabel;
    TimePicker2: TTimePicker;
    Label5: TLabel;
    Label6: TLabel;
    TimePicker3: TTimePicker;
    Label7: TLabel;
    Label8: TLabel;
    TimePicker4: TTimePicker;
    Label9: TLabel;
    Label10: TLabel;
    TimePicker5: TTimePicker;
    Label11: TLabel;
    Label12: TLabel;
    TimePicker6: TTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    TimePicker1: TTimePicker;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    TimePicker7: TTimePicker;
    Label17: TLabel;
    tpEventStart: TTimePicker;
    Label19: TLabel;
    TimePicker9: TTimePicker;
    Label20: TLabel;
    Label18: TLabel;
    tpSessionStart: TTimePicker;
    qrySession: TFDQuery;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fConnection: TFDConnection;
    fSessionID: integer;
    fSeedTime: TTime;

    procedure WritePreferences(IniFileName: string);
    procedure ReadPreferences(IniFileName: string);
    procedure AutoSchedule_Execute;
    procedure EstimateSessionEnd;

  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);
    property SeedTime: TTime read fSeedTime write fSeedTime;

  end;

var
  AutoSchedule: TAutoSchedule;

implementation

uses System.IniFiles, SCMUtility, dmSCM, System.DateUtils, System.UITypes;

{$R *.dfm}
{ TSchedulePicker }

procedure TAutoSchedule.AutoSchedule_Execute;
var
  t: TTime;
  dt: TDateTime;
  v: variant;
  s: string;
  SQL: string;
begin
  // if the session start time has changes - update it....
  SQL := 'SELECT SessionStart FROM SwimClubMeet.dbo.Session WHERE SessionID = :ID';
  v := fConnection.ExecSQLScalar(SQL, [fSessionID]);
  if not VarIsNull(v) then
  begin
    t := TimeOf(v.AsDateTime);
    if (t <> tpSessionStart.Time) then
    begin
      dt := DateOf(v.AsDateTime) + t;
      s := FormatDateTime('yyyy.mm.dd', dt);
      SQL := 'UPDATE SwimClubMeet.dbo.Session SET ([SessionStart]) VALUE (:STR) WHERE SessionID = :ID';
      fConnection.ExecSQL(SQL, [s, fSessionID], [ftString, ftInteger]);
    end;
  end;
  // set seed
  // iterover events
  // iter over heats
  // set event SHED + SEED

end;

procedure TAutoSchedule.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TAutoSchedule.btnOkClick(Sender: TObject);
begin
  { TODO -oBSA -cGeneral : SAVE Preferences }
  // save last state ...
  fSeedTime := tpSessionStart.Time;
  ModalResult := mrOK;
end;

constructor TAutoSchedule.CreateWithConnection(AOwner: TComponent;
  aConnection: TFDConnection);
begin
  inherited Create(AOwner);
  fConnection := aConnection;
  fSeedTime := 0;
  { TODO -oBSA -cGeneral : LOAD Preferences }
  // load last state ...
end;

procedure TAutoSchedule.EstimateSessionEnd;
begin
  // estimate a SessionEnd TDateTime
end;

procedure TAutoSchedule.FormCreate(Sender: TObject);
var
  IniFileName: string;
begin
  fSessionID := 0;
  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then
    ReadPreferences(IniFileName);
end;

procedure TAutoSchedule.FormDestroy(Sender: TObject);
var
  IniFileName: string;
begin
  // save the current parameter state if the user pressed OK.
  if IsPositiveResult(ModalResult) then
  begin
    // w r i t e   p r e f e r e n c e s .
    IniFileName := SCMUtility.GetSCMPreferenceFileName();
    if (FileExists(IniFileName)) then
      WritePreferences(IniFileName);
  end;
end;

procedure TAutoSchedule.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end;
end;

procedure TAutoSchedule.FormShow(Sender: TObject);
begin
  if fSeedTime > 0 then
    tpSessionStart.Time := fSeedTime
  else
    tpSessionStart.Time := Time;
  tpEventStart.Time := tpSessionStart.Time;
end;

procedure TAutoSchedule.ReadPreferences(IniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(IniFileName);
  // ATIME := (iFile.ReadTime('AutoSchedule', 'prefNAME', Time));
  iFile.free;
end;

procedure TAutoSchedule.WritePreferences(IniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(IniFileName);
  // iFile.Writetime('AutoSchedule', 'prefNAME', ADateTime);
  iFile.free;
end;

end.
