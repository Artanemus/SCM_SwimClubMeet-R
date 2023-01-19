unit dlgNewsession;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.WinXPickers,
  Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls, SCMDefines;

type
  scmSessionMode = (smEditSession, smNewSession, swNotGiven);

  TNewSession = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    btnCancel: TButton;
    btnPost: TButton;
    DatePicker1: TDatePicker;
    TimePicker1: TTimePicker;
    DBEdit1: TDBEdit;
    qrySessionDlg: TFDQuery;
    dsSessionDlg: TDataSource;
    procedure btnPostClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    fSessionMode: scmSessionMode;
    fSessionID: integer;
    fConnection: TFDConnection;
    function LocateSession(ASessionID: Integer): Boolean;

  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);
    property SessionMode: scmSessionMode read fSessionMode write fSessionMode;
    property SessionID: integer read fSessionID write fSessionID;

  end;

var
  NewSession: TNewSession;

implementation

{$R *.dfm}

uses
  System.DateUtils;


procedure TNewSession.btnCancelClick(Sender: TObject);
begin
    dsSessionDlg.DataSet.Cancel;
    fSessionID := 0;
    ModalResult := mrCancel;
end;

procedure TNewSession.btnPostClick(Sender: TObject);
var
  dt: TDateTime;
begin
with dsSessionDlg.DataSet do begin
  // Finalise the edit. Note NewRecord is assigned by SCM, SessionStatusID = 1;
  if (State = dsEdit) or (State = dsInsert) then
  begin
    dt := DatePicker1.Date + TimePicker1.Time;
    // Manually assign date - only if modified.
    if FieldByName('SessionStart').AsDateTime <> dt then
      FieldByName('SessionStart').AsDateTime := dt;
    FieldByName('SessionStatusID').AsInteger := 1;
    FieldByName('SwimClubID').AsInteger := 1;
    // finalise the changes...
    Post;
  end;
  if (State = dsEdit) then
    fSessionID := FieldByName('SessionID').AsInteger;

  ModalResult := mrOk;
end;
end;

constructor TNewSession.CreateWithConnection(AOwner: TComponent;
  aConnection: TFDConnection);
begin
  inherited Create(AOwner);
  fConnection := aConnection;
end;

procedure TNewSession.FormCreate(Sender: TObject);
begin
  if not Assigned(fConnection) then
    raise Exception.Create('Connection not assigned.');
  qrySessionDlg.Connection := fConnection;
  qrySessionDlg.Open;
  DBEdit1.DataSource := dsSessionDlg;
  DBEdit1.DataField := 'Caption';
  fSessionMode := swNotGiven;
end;

procedure TNewSession.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    dsSessionDlg.DataSet.Cancel;
    Key := 0;
    fSessionID := 0;
    ModalResult := mrCancel;
  end;
end;

procedure TNewSession.FormShow(Sender: TObject);
var
  dt: TDateTime;
begin
  case fSessionMode of
    smEditSession:
      begin
        if not LocateSession(fSessionID) then Close;
        Caption := 'Edit session ...';
        with dsSessionDlg.DataSet do
        begin
          dt := FieldByName('SessionStart').AsDateTime;
          DatePicker1.Date := DateOf(dt);
          TimePicker1.Time := TimeOf(dt);
          // - -   e d i t   - -
          if State <> dsEdit then
            Edit;
        end;
      end;
    smNewSession:
      begin
        Caption := 'Create new session ...';
        // - -   i n s e r t   - -
        dsSessionDlg.DataSet.Insert;
        DatePicker1.Date := Date;
        TimePicker1.Time := Time;
      end;
    swNotGiven:
      Close;
  end;

end;

function TNewSession.LocateSession(ASessionID: Integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not qrySessionDlg.Active then exit;
  SearchOptions := [];
  result := qrySessionDlg.Locate('SessionID', ASessionID, SearchOptions);
end;

end.
