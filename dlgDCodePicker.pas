unit dlgDCodePicker;
{
  23.08.31 : Routine works with Entrant and Team DataSets.
  Normally I would create an Object list with the DataSet.
  Instead I've used TListView.Items.SubItems to hold the DisqualifyCodeID
  as a String params.
  The caller must assign a valid fEntrantID or fTeamID value,
  prior to executing TDCodePicker.ShowModal.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dmSCM, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TDCodePicker = class(TForm)
    qryDisqualifyCode: TFDQuery;
    btnOk: TButton;
    btnCancel: TButton;
    btnClearCodeExit: TButton;
    Panel1: TPanel;
    qryStroke: TFDQuery;
    lvCodes: TListView;
    procedure btnCancelClick(Sender: TObject);
    procedure btnClearCodeExitClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure lvCodesDblClick(Sender: TObject);
  private
    { Private declarations }
    fConnection: TFDConnection;
    fEntrantID: integer;
    fTeamID: integer;
    fDoINDV: boolean;
  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);
    property EntrantID: integer read fEntrantID write fEntrantID;
    property TeamID: integer read fTeamID write fTeamID;
  end;

var
  DCodePicker: TDCodePicker;

implementation

{$R *.dfm}
{ TDisqualifyCode }

constructor TDCodePicker.CreateWithConnection(AOwner: TComponent;
  aConnection: TFDConnection);
begin
  inherited Create(AOwner);
  // INIT
  fConnection := aConnection;
  fEntrantID := 0;
  fTeamID := 0;
  if Assigned(fConnection) and fConnection.Connected then
  BEGIN
    qryStroke.Connection := fConnection;
    qryDisqualifyCode.Connection := fConnection;
  END;
end;

procedure TDCodePicker.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TDCodePicker.btnClearCodeExitClick(Sender: TObject);
var
  SQL: string;
begin
  // remove disqualification code and exit
  SQL := 'UPDATE SwimClubMeet.dbo.Entrant SET' +
    ' [DisqualifyCodeID] = NULL, [IsScratched] = 0,' +
    ' [IsDisqualified] = 0 WHERE [Entrant].EntrantID = :ID1;';

  fConnection.ExecSQL(SQL, [fEntrantID]);
  ModalResult := mrOk;
end;

procedure TDCodePicker.btnOkClick(Sender: TObject);
var
  SQL: String;
  CodeID: integer;
  IsScratched, IsDisqualified: boolean;
  lvItem: TListItem;
begin
  lvItem := lvCodes.Selected;
  if Assigned(lvItem) then
  begin
    // "Simplified Disqualification Schema" :DEFAULT INIT
    // SCMb - Unspecified disqualification.
    IsScratched := false;
    IsDisqualified := true;
    // disqualification code ID
    CodeID := StrToIntDef(lvItem.SubItems[1], 0);
    // "Simplified Disqualification Schema"
    // SCMa - Swimmer didn't show for event. Scratched
    if CodeID = 53 then
    begin
      IsScratched := true;
      IsDisqualified := false;
    end;
    if fDoINDV then
    begin
      SQL := 'UPDATE SwimClubMeet.dbo.Entrant SET' +
        ' [DisqualifyCodeID] = :ID1, [IsScratched] = :ID2,' +
        ' [IsDisqualified] = :ID3 WHERE [Entrant].EntrantID = :ID4;';
      fConnection.ExecSQL(SQL, [CodeID, IsScratched, IsDisqualified,
        fEntrantID], [ftInteger, ftBoolean, ftBoolean, ftInteger]);
    end
    else
    begin
      SQL := 'UPDATE SwimClubMeet.dbo.Team SET' +
        ' [DisqualifyCodeID] = :ID1, [IsScratched] = :ID2,' +
        ' [IsDisqualified] = :ID3 WHERE [Team].TeamID = :ID4;';
      fConnection.ExecSQL(SQL, [CodeID, IsScratched, IsDisqualified, fTeamID],
        [ftInteger, ftBoolean, ftBoolean, ftInteger]);
    end;
    ModalResult := mrOk;
  end;
end;

procedure TDCodePicker.FormCreate(Sender: TObject);
begin
  // Clear out the DesignTime doodles...
  lvCodes.Items.Clear;
end;

procedure TDCodePicker.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TDCodePicker.FormShow(Sender: TObject);
var
  lv: TListItem;
  lvg: TListGroup;
  i, j: integer;
begin

  if (fEntrantID > 0) then
    fDoINDV := true
  else if (fTeamID > 0) then
    fDoINDV := false
  else
  begin
    ModalResult := mrCancel;
    {
      Well do an abort here, because I've fogotten to assign a valid ID value!
    }
    Abort;
    { Alternative method....
      PostMessage(Self.Handle, WM_CLOSE, 0,0);
      Exit;
    }
  end;

  j := 0;

  if fDoINDV then
  begin
    qryStroke.ParamByName('EntrantID').AsInteger := fEntrantID;
    qryStroke.Prepare;
    qryStroke.Open;
    // init
    lvCodes.Items.BeginUpdate;
    if qryStroke.Active and not qryStroke.IsEmpty then
    begin
      // init Group 1 SWIMMING STROKE
      lvg := lvCodes.Groups.Items[1];
      lvg.Header := UpperCase(qryStroke.FieldByName('Caption').AsString);

      // TRANSPOSE SCM STROKE TO FINA'S STROKE TYPE ID
      i := qryStroke.FieldByName('StrokeID').AsInteger;
      case i of
        1:
          j := 2; // FS
        2:
          j := 4; // BS
        3:
          j := 3; // BK
        4:
          j := 5; // BF
        5:
          j := 6; // IM
      end;
    end;
  end
  else
  begin
    // init Group 1 SWIMMING STROKE
    lvg := lvCodes.Groups.Items[1];
    lvg.Header := 'TEAM RELAYS';
    j := 7; // RELAY
  end;

  // I N I T   L I S T  I T E M S  . . .
  qryDisqualifyCode.ParamByName('DISQUALIFYTYPEID').AsInteger := j;
  qryDisqualifyCode.Prepare;
  qryDisqualifyCode.Open;
  if qryDisqualifyCode.Active then
  BEGIN
    while not qryDisqualifyCode.eof do
    Begin
      // clear items
      lv := lvCodes.Items.Add;
      // Human readable string for the code.
      lv.Caption := qryDisqualifyCode.FieldByName('ABREV').AsString;
      // A description of the disqualification.
      lv.SubItems.Add(qryDisqualifyCode.FieldByName('DCodeStr').AsString);
      //
      lv.SubItems.Add(qryDisqualifyCode.FieldByName('DisqualifyCodeID')
        .AsString);
      // General codes, SCM codes else swimming stroke.
      lv.SubItems.Add(qryDisqualifyCode.FieldByName('DisqualifyTypeID')
        .AsString);

      // SET LISTVIEW GROUPS X 3
      i := qryDisqualifyCode.FieldByName('DisqualifyTypeID').AsInteger;
      case i of
        1: // General
          lv.GroupID := 0;
        2, 3, 4, 5, 6, 7: // strokes FR,BK,BS,BF, IM,RELAY
          lv.GroupID := 1;
        8: // SCM simplified or missing disqualification codes.
          lv.GroupID := 2;
      end;
      qryDisqualifyCode.next;
    End;
  END;

  lvCodes.Items.EndUpdate;

end;

procedure TDCodePicker.lvCodesDblClick(Sender: TObject);
begin
  btnOkClick(Sender);
end;

end.
