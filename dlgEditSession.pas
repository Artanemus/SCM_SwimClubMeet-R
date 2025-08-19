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
  dmCORE,
  uDefines, uSwimClub, uSession;

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
  public
    { Public declarations }
  end;

var
  EditSession: TEditSession;

implementation

{$R *.dfm}

uses
  System.DateUtils;

procedure TEditSession.btnCancelClick(Sender: TObject);
begin
    if CORE.qrySession.State = dsEdit then CORE.qrySession.Cancel;
    ModalResult := mrCancel;
end;

procedure TEditSession.btnPostClick(Sender: TObject);
var
  dt: TDateTime;
begin
  with CORE.qrySession do
  begin
   try
    if (State = dsEdit) then
    begin
      dt := DatePicker1.Date + TimePicker1.Time;
      if FieldByName('SessionStart').AsDateTime <> dt then
          FieldByName('SessionStart').AsDateTime := dt;

      if  FieldByName('SessionStatusID').IsNull then    
        FieldByName('SessionStatusID').AsInteger := 1;      
      Post; // finalize the changes...
      ModalResult := mrOk;
    end;
    except
      on E: Exception do
      begin
        // ShowMessage('Error saving session: ' + E.Message);
        CORE.qrySession.Cancel;
      end;
    finally
    end;
  end;
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
    if CORE.qrySession.State = dsEdit then CORE.qrySession.Cancel;
    Key := 0;
    ModalResult := mrCancel;
  end;
end;

procedure TEditSession.FormShow(Sender: TObject);
var
  dt: TDateTime;
begin
  with dsSessionDlg.DataSet do
  begin
    FieldByName('StartDT').IsEmpty then
      dt := Now
    else
      dt := FieldByName('StartDT').AsDateTime;
    DatePicker1.Date := DateOf(dt);
    TimePicker1.Time := TimeOf(dt);
    // - -   e d i t   - -
    if State <> dsEdit then Edit;
    if CanFocus then
      DatePicker1.SetFocus;
  end;
end;

end.
