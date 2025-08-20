unit dlgEditSession;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.WinXPickers,
  Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls, 
  dmCORE, dmIMG,
  uDefines, uSwimClub, uSession, Vcl.ComCtrls;

type
  scmSessionMode = (smEditSession, smNewSession, swNotGiven);

  TEditSession = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    btnCancel: TButton;
    btnPost: TButton;
    timePickerSess: TTimePicker;
    DBEdit1: TDBEdit;
    btnToday: TButton;
    btnDate: TButton;
    datePickerSess: TDatePicker;
    btnNow: TButton;
    btnPlus: TButton;
    btnMinus: TButton;
    procedure btnPostClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDateClick(Sender: TObject);
    procedure btnMinusClick(Sender: TObject);
    procedure btnNowClick(Sender: TObject);
    procedure btnPlusClick(Sender: TObject);
    procedure btnTodayClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditSession: TEditSession;

implementation

{$R *.dfm}

uses
  System.DateUtils, dlgDatePicker;

procedure TEditSession.btnCancelClick(Sender: TObject);
begin
    if CORE.qrySession.State = dsEdit then CORE.qrySession.Cancel;
    ModalResult := mrCancel;
end;

procedure TEditSession.btnDateClick(Sender: TObject);
var
  dlg: TDOBPicker;
  Rect: TRect;
  rtn: TModalResult;
begin
  dlg := TDOBPicker.Create(Self);
  dlg.Caption := 'Pick session date ...';
  dlg.Position := poDesigned;
  Rect := btnDate.ClientToScreen(btnDate.ClientRect);
  dlg.Left := Rect.Left;
  dlg.Top := Rect.Bottom + 1;
  dlg.CalendarView1.Date := datePickerSess.Date;
  rtn := dlg.ShowModal;
  if IsPositiveResult(rtn) then
    datePickerSess.Date := dlg.CalendarView1.Date;
  dlg.Free;
end;

procedure TEditSession.btnMinusClick(Sender: TObject);
begin
  TDateTime(timePickerSess.time).IncMinute(-15);
end;

procedure TEditSession.btnNowClick(Sender: TObject);
begin
  TDateTime(timePickerSess.Time).SetTime(Now().GetHour(), 0, 0, 0);
end;

procedure TEditSession.btnPlusClick(Sender: TObject);
begin
  TDateTime(timePickerSess.time).IncMinute(15);
end;

procedure TEditSession.btnPostClick(Sender: TObject);
var
  dt: TDateTime;
begin
    // Assert edit mode.
    // (changing dbo.Session.caption may have triggered edit state.)
    if CORE.qrySession.State <> dsEdit then CORE.qrySession.Edit;
    try
      if (CORE.qrySession.State = dsEdit) then
      begin
        dt := datePickerSess.Date + timePickerSess.Time;
        if CORE.qrySession.FieldByName('SessionStart').AsDateTime <> dt then
          CORE.qrySession.FieldByName('SessionStart').AsDateTime := dt;

        if CORE.qrySession.FieldByName('SessionStatusID').IsNull then
          CORE.qrySession.FieldByName('SessionStatusID').AsInteger := 1;

        CORE.qrySession.Post; // finalize the changes...
        ModalResult := mrOk;
      end;
    except on E: Exception do
      // ShowMessage('Error saving session: ' + E.Message);
      CORE.qrySession.Cancel;
    end;
end;

procedure TEditSession.btnTodayClick(Sender: TObject);
begin
  datePickerSess.Date := Date.Today;
end;

procedure TEditSession.FormCreate(Sender: TObject);
begin
  if not Assigned(CORE) then
    raise Exception.Create('Not connected to SwimClubMeet.');
  if not CORE.qrySession.IsEmpty then
    CORE.qrySession.Cancel;
end;

procedure TEditSession.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    // cancel all edits ...
    if CORE.qrySession.State = dsEdit then CORE.qrySession.Cancel;
    Key := 0;
    ModalResult := mrCancel;
  end;
end;

procedure TEditSession.FormShow(Sender: TObject);
var
  dt: TDateTime;
begin
    if CORE.qrySession.FieldByName('StartDT').IsNull then
      dt := Now
    else
      dt := CORE.qrySession.FieldByName('StartDT').AsDateTime;

    datePickerSess.Date := DateOf(dt);
    timePickerSess.Time := TimeOf(dt);
    if CanFocus then datePickerSess.SetFocus;
end;

end.
