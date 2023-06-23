unit dlgAutoSchedule;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPickers, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, Vcl.Samples.Spin, Vcl.VirtualImage,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

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
    tpHeatInterval: TTimePicker;
    TimePickerSessionEnds: TTimePicker;
    tpEventInterval: TTimePicker;
    tpEventStart: TTimePicker;
    spinRound: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    BalloonHint1: TBalloonHint;
    ImageCollection1: TImageCollection;
    btnInfo1: TVirtualImage;
    btnInfo2: TVirtualImage;
    procedure btnCancelClick(Sender: TObject);
    procedure btnInfo1Click(Sender: TObject);
    procedure btnInfoMouseLeave(Sender: TObject);
    procedure btnInfo2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure spinRoundChange(Sender: TObject);
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
    function RoundToNearestInterval(time: TTime; interval: integer): TTime;
    function RoundToNearest(value: integer; interval: integer): integer;
  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);
    property SessionID: integer read fSessionID write fSessionID;
  end;

var
  AutoSchedule: TAutoSchedule;

implementation

uses System.IniFiles, SCMUtility, dmSCM, System.DateUtils, System.UITypes,
  System.Math;

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

  t := tpEventStart.time;
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
        interval := tpHeatInterval.time;
        heatcount := FieldByName('HeatCount').AsInteger;
        if heatcount > 0 then
          t := t + (interval * (heatcount - 1)) + tpEventInterval.time +
            TimeOf(FieldByName('MaxSwimTime').AsDateTime)
        else
          t := t + tpEventInterval.time;
        t := RoundToNearestInterval(t, spinRound.value);
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

procedure TAutoSchedule.btnInfo1Click(Sender: TObject);
begin
  BalloonHint1.Title := 'Calculating duration.(1)';
  BalloonHint1.Description := 'For each heat, the slowest swimmer' + sLinebreak
    + 'is used to caculate the heat''s duration +' + sLinebreak +
    'the turn-around time.';
  BalloonHint1.ShowHint(btnInfo1);
  // BalloonHint1.ShowHint(ClientToScreen(Tpoint.Create(btnInfo1.Left,btnInfo1.Top)));
end;

procedure TAutoSchedule.btnInfoMouseLeave(Sender: TObject);
begin
  BalloonHint1.HideHint;
end;

procedure TAutoSchedule.btnInfo2Click(Sender: TObject);
begin
  BalloonHint1.Title := 'Calculating duration.(2)';
  BalloonHint1.Description := 'The time it takes to rally and' +
    sLinebreak + 'mount the blocks + the time for swimmers to' + sLinebreak +
    'leave the pool on completion.';
  BalloonHint1.ShowHint(btnInfo2);
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
  heatcount: integer;
begin
  if (fSessionID = 0) or (fSessionStartTime = 0) then
    exit;
  t := tpEventStart.time;
  TimePickerSessionEnds.time := tpEventStart.time;
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
        heatcount := FieldByName('HeatCount').AsInteger;
        interval := tpHeatInterval.time;
        if heatcount > 0 then
          t := t + (interval * (heatcount - 1)) + tpEventInterval.time +
            +TimeOf(FieldByName('MaxSwimTime').AsDateTime)
        else
          t := t + tpEventInterval.time;
        t := RoundToNearestInterval(t, spinRound.value);
        next;
      end;
    end;

    TimePickerSessionEnds.time := t;
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
    tpEventStart.time := fSessionStartTime
  else
    // Assign the current time ...
    tpEventStart.time := time;
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
  tpHeatInterval.time := iFile.ReadTime('AutoSchedule', 'tp25m',
    EncodeTime(0, 2, 0, 0));
  tpEventInterval.time := iFile.ReadTime('AutoSchedule', 'tpEvInterval',
    EncodeTime(0, 5, 0, 0));
  iFile.free;
end;

function TAutoSchedule.RoundToNearest(value, interval: integer): integer;
var
  remainder: double;
begin
  result := value;
  if interval = 0 then
    exit
  else
    remainder := value / interval;
//    remainder := value mod interval;
  if remainder = 0 then
    exit
    { else
      result := value + interval - remainder }
  else if remainder >= interval / 2.0 then
//  else if remainder >= interval div 2 then
    // round up ....
    result := Round(value + interval - remainder)
  else
    // round down ...
    result := Round(value - remainder);

end;

function TAutoSchedule.RoundToNearestInterval(time: TTime;
  interval: integer): TTime;
var
  roundedMinutes: integer;
  t: TTime;
begin
  roundedMinutes := RoundToNearest(MinuteOf(time), interval);
  t := EncodeTime(HourOf(time), 0, 0, 0);
  result := IncMinute(t, roundedMinutes);
end;

procedure TAutoSchedule.spinRoundChange(Sender: TObject);
begin
  EstimateSessionEnd;
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
  iFile.Writetime('AutoSchedule', 'tp25m', tpHeatInterval.time);
  iFile.Writetime('AutoSchedule', 'tpEvInterval', tpEventInterval.time);
  iFile.free;
end;

end.
