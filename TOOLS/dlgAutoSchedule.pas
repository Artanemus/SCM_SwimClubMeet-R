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
    btnCancel: TButton;
    btnOk: TButton;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    qryEvent: TFDQuery;
    qrySession: TFDQuery;
    tpHeatInterval: TTimePicker;
    TimePickerSessionEnds: TTimePicker;
    tpEventInterval: TTimePicker;
    tpEventStart: TTimePicker;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure tpChange(Sender: TObject);
  private
    { Private declarations }
    fConnection: TFDConnection;
    fSessionID: integer;
    fSessionStartTime: TTime;
    procedure AutoSchedule_Execute;
    procedure EstimateSessionEnd;
    function GetSessionStartTime(ASessionID: integer): TTime;
    procedure ReadPreferences(IniFileName: string);
    procedure WritePreferences(IniFileName: string);
  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);
    property SessionID: integer read fSessionID write fSessionID;
  end;

var
  AutoSchedule: TAutoSchedule;

implementation

uses System.IniFiles, SCMUtility, dmSCM, System.DateUtils, System.UITypes;

{$R *.dfm}

constructor TAutoSchedule.CreateWithConnection(AOwner: TComponent;
  aConnection: TFDConnection);
begin
  inherited Create(AOwner);
  fConnection := aConnection;
  { TODO -oBSA -cGeneral : LOAD Preferences }
  // load last state ...
end;

{ TSchedulePicker }

procedure TAutoSchedule.AutoSchedule_Execute;
var
  t, interval: TTime;
  meters, heatcount: integer;

begin
  if (fSessionID = 0) or (fSessionStartTime = 0) then
    exit;

  { t := TimeOf(v.AsDateTime);
    d := DateOf(v.AsDateTime);
    if (t <> tpSessionStart.Time) then
    begin
    dt := DateOf(v.AsDateTime) + t;
    s := FormatDateTime('yyyy.mm.dd', dt);
    SQL := 'UPDATE SwimClubMeet.dbo.Session SET [SessionStart] = :STR WHERE SessionID = :ID';
    fConnection.ExecSQL(SQL, [s, fSessionID], [ftString, ftInteger]);
    end; }

  t := tpEventStart.Time;
  interval := 0;
  with qryEvent do
  begin
    Connection := fConnection;
    ParamByName('SESSIONID').AsInteger := fSessionID;
    Prepare;
    Open;
    if Active then
    begin
      while not eof do
      begin
        edit;
        FieldByName('ScheduleDT').AsDateTime := t;
        post;
        interval := tpHeatInterval.Time;
        heatcount := FieldByName('HeatCount').AsInteger;
        if heatcount > 0 then
          t := t + (interval * (heatcount - 1)) + tpEventInterval.Time
        else
          t := t + tpEventInterval.Time;
        next;
      end;
    end;
    qryEvent.Close;
  end;

end;

procedure TAutoSchedule.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TAutoSchedule.btnOkClick(Sender: TObject);
begin
  { TODO -oBSA -cGeneral : SAVE Preferences }
  // save last state ...
  AutoSchedule_Execute;
  ModalResult := mrOK;
end;

procedure TAutoSchedule.EstimateSessionEnd;
var
  t, interval: TTime;
  meters, heatcount: integer;
begin
  if (fSessionID = 0) or (fSessionStartTime = 0) then
    exit;
  t := tpEventStart.Time;
  TimePickerSessionEnds.Time := tpEventStart.Time;
  interval := 0;
  with qryEvent do
  begin
    Connection := fConnection;
    ParamByName('SESSIONID').AsInteger := fSessionID;
    Prepare;
    Open;
    if Active then
    begin
      while not eof do
      begin
        meters := FieldByName('Meters').AsInteger;
        heatcount := FieldByName('HeatCount').AsInteger;
        interval := tpHeatInterval.Time;
        if heatcount > 0 then
          t := t + (interval * (heatcount - 1)) + tpEventInterval.Time
        else
          t := t + tpEventInterval.Time;
        next;
      end;
    end;
    TimePickerSessionEnds.Time := t;
    qryEvent.Close;
  end;

end;

procedure TAutoSchedule.FormCreate(Sender: TObject);
var
  IniFileName: string;
begin
  fSessionID := 0;
  fSessionStartTime := 0;
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
  fSessionStartTime := GetSessionStartTime(fSessionID);
  if fSessionStartTime > 0 then
    // found SCM sessionStart DT
    tpEventStart.Time := TimeOf(fSessionStartTime)
  else
    // Assign the current time ...
    tpEventStart.Time := Time;
    EstimateSessionEnd;
end;

function TAutoSchedule.GetSessionStartTime(ASessionID: integer): TTime;
var
  v: variant;
  SQL: string;
begin
  v := null;
  result := 0;
  if Assigned(fConnection) and (ASessionID > 0) then
  begin
    SQL := 'SELECT SessionStart FROM SwimClubMeet.dbo.Session WHERE SessionID = :ID';
    v := fConnection.ExecSQLScalar(SQL, [ASessionID]);
  end;
  if not VarIsNull(v) then
    result := TimeOf(v.AsDateTime);
end;

procedure TAutoSchedule.ReadPreferences(IniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(IniFileName);
  tpHeatInterval.Time := iFile.ReadTime('AutoSchedule', 'tp25m', EncodeTime(0, 2, 0, 0));
  tpEventInterval.Time := iFile.ReadTime('AutoSchedule', 'tpEvInterval', EncodeTime(0, 5, 0, 0));
  iFile.free;
end;

procedure TAutoSchedule.tpChange(Sender: TObject);
begin
    EstimateSessionEnd;
end;

procedure TAutoSchedule.WritePreferences(IniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(IniFileName);
  iFile.Writetime('AutoSchedule', 'tp25m', tpHeatInterval.Time);
  iFile.Writetime('AutoSchedule', 'tpEvInterval', tpEventInterval.Time);
  iFile.free;
end;

end.
