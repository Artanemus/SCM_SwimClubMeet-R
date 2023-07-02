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
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList;

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
    spinRoundUp: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    BalloonHint1: TBalloonHint;
    ImageCollection1: TImageCollection;
    btnInfo1: TVirtualImage;
    btnInfo2: TVirtualImage;
    VirtualImageList1: TVirtualImageList;
    btnSessionStartTime: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnInfo1Click(Sender: TObject);
    procedure btnInfoMouseLeave(Sender: TObject);
    procedure btnInfo2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnSessionStartTimeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure spinRoundUpChange(Sender: TObject);
    procedure tpChange(Sender: TObject);
  private
    { Private declarations }
    fConnection: TFDConnection;
    fSessionID: integer;
    fSessionStartTime: TTime;
    fEnableRoundUp: boolean;
    fRoundUpOnly: boolean;
    procedure AutoSchedule_Execute(DoEdit: boolean = false);
    procedure EstimateSessionEnd;
    function GetSessionStartTime(ASessionID: integer): TTime;
    procedure ReadPreferences(IniFileName: string);
    procedure WritePreferences(IniFileName: string);
    function RoundUpNearestInterval(time: TTime; interval: integer): TTime;
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

procedure TAutoSchedule.AutoSchedule_Execute(DoEdit: boolean = false);
var
  t, interval: TTime;
  heatcount: integer;
begin
  if (fSessionID = 0) or (fSessionStartTime = 0) then
    exit;
  t := tpEventStart.time;
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
        if DoEdit then
        begin
          edit;
          // if (spinRoundUp.Value > 0) then
          // t := RoundToNearestInterval(t, spinRoundUp.value);
          FieldByName('ScheduleDT').AsDateTime := t;
          post;
        end;
        interval := tpHeatInterval.time;
        heatcount := FieldByName('HeatCount').AsInteger;
        if heatcount > 0 then
          t := t + (interval * (heatcount - 1)) + tpEventInterval.time +
            FieldByName('TOTEvSwimTime').AsDateTime
        else
          t := t + tpEventInterval.time;
        if fEnableRoundUp then
          t := RoundUpNearestInterval(t, spinRoundUp.value);
        next;
      end;
    end;
    TimePickerSessionEnds.time := t;
    qryEvent.Close;
  end;
end;

procedure TAutoSchedule.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TAutoSchedule.btnInfo1Click(Sender: TObject);
begin
  BalloonHint1.Title := 'Calculating a heat''s duration.';
  BalloonHint1.Description := 'The running time for each heat is calculated on' +
    sLinebreak +              'the slowest swimmer''s TTB. Then the time entered'
    + sLinebreak +            'here is added. (ie. The time needed to exit the'
    + sLinebreak +            'poll and rally the next swimmers.)';
  BalloonHint1.ShowHint(btnInfo1);
  // BalloonHint1.ShowHint(ClientToScreen(Tpoint.Create(btnInfo1.Left,btnInfo1.Top)));
end;

procedure TAutoSchedule.btnInfoMouseLeave(Sender: TObject);
begin
  BalloonHint1.HideHint;
end;

procedure TAutoSchedule.btnInfo2Click(Sender: TObject);
begin
  BalloonHint1.Title := 'Calculating interval.';
  BalloonHint1.Description := 'That extra time needed between events' +
    sLinebreak + 'to relocate the timekeepers and collect data.';
  BalloonHint1.ShowHint(btnInfo2);
end;

procedure TAutoSchedule.btnOkClick(Sender: TObject);
begin
  { TODO -oBSA -cGeneral : SAVE Preferences }
  // save last state ...
  AutoSchedule_Execute(true);
  ModalResult := mrOK;
end;

procedure TAutoSchedule.btnSessionStartTimeClick(Sender: TObject);
begin
  if (fSessionID = 0) or (fSessionStartTime = 0) then
    exit;
  tpEventStart.time := fSessionStartTime;
end;

procedure TAutoSchedule.EstimateSessionEnd;
begin
  AutoSchedule_Execute(false);
end;

procedure TAutoSchedule.FormCreate(Sender: TObject);
var
  IniFileName: string;
begin
  fSessionID := 0;
  fSessionStartTime := 0;
  fEnableRoundUp := false;
  fRoundUpOnly := true;
  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then
    ReadPreferences(IniFileName);
  // Set control visibility for round up event to nearest.
  spinRoundUp.Visible := fEnableRoundUp;
  Label1.Visible := fEnableRoundUp;
  Label2.Visible := fEnableRoundUp;

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
  if (fSessionStartTime > 0) and (tpEventStart.time < fSessionStartTime) then
    tpEventStart.time := fSessionStartTime;
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
  tpEventStart.time := iFile.ReadTime('AutoSchedule', 'EventStart',
    EncodeTime(18, 30, 0, 0));
  tpHeatInterval.time := iFile.ReadTime('AutoSchedule', 'HeatInterval',
    EncodeTime(0, 2, 0, 0));
  tpEventInterval.time := iFile.ReadTime('AutoSchedule', 'EventInterval',
    EncodeTime(0, 5, 0, 0));
  spinRoundUp.value := iFile.ReadInteger('AutoSchedule', 'RoundUpToNearest', 5);
  fEnableRoundUp := iFile.ReadBool('AutoSchedule', 'EnableRoundUp', false);
  iFile.free;
end;

function TAutoSchedule.RoundToNearest(value, interval: integer): integer;
var
  remainder: integer;
begin
  result := value;

  // x mod y where y = 0 results in an exception.
  if interval = 0 then
    exit;
  if value < interval then
  // x mod y where x < y result in x.
  begin
    result := interval;
    exit;
  end;
  remainder := value mod interval;
  if remainder = 0 then
    result := value
    // special switch to force round up only. On by default;
  else if fRoundUpOnly then
    result := value + interval - remainder
  else if remainder >= interval div 2 then
    // R O U N D   U P
    result := value + interval - remainder
  else
    // R O U N D   D O W N
    result := value - remainder;

end;

function TAutoSchedule.RoundUpNearestInterval(time: TTime;
  interval: integer): TTime;
var
  roundedMinutes: integer;
  t: TTime;
begin
  roundedMinutes := RoundToNearest(MinuteOf(time), interval);
  t := EncodeTime(HourOf(time), 0, 0, 0);
  result := IncMinute(t, roundedMinutes);
end;

procedure TAutoSchedule.spinRoundUpChange(Sender: TObject);
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
  iFile.Writetime('AutoSchedule', 'EventStart', tpEventStart.time);
  iFile.Writetime('AutoSchedule', 'HeatInterval', tpHeatInterval.time);
  iFile.Writetime('AutoSchedule', 'EventInterval', tpEventInterval.time);
  iFile.WriteInteger('AutoSchedule', 'RoundUpToNearest', spinRoundUp.value);
  iFile.WriteBool('AutoSchedule', 'EnableRoundUp', fEnableRoundUp);
  iFile.free;
end;

end.
