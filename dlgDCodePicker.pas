unit dlgDCodePicker;

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
    Button3: TButton;
    Panel1: TPanel;
    qryStroke: TFDQuery;
    lvCodes: TListView;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fConnection: TFDConnection;
    fEntrantID: integer;
  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);
    property EntrantID: integer read fEntrantID write fEntrantID;
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
  fConnection := aConnection;
  fEntrantID := 0;

  if Assigned(fConnection) and fConnection.Connected then
  BEGIN
    qryStroke.Connection := fConnection;
    qryDisqualifyCode.Connection := fConnection;
  END;
end;

procedure TDCodePicker.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TDCodePicker.btnOkClick(Sender: TObject);
var
  SQL, ADCodeStr: String;
  CodeID, CodeTypeID: integer;
  IsScratched, IsDisqualified: boolean;
  lvItem: TListItem;
begin
  // ALTERNATIVE index := lvCodes.ItemIndex;
  lvItem := lvCodes.Selected;
  if Assigned(lvItem) then
  begin
    // disqualification label for Entrant_Grid
    ADCodeStr := lvItem.Caption;
    // disqualification code ID
    CodeID := StrToIntDef(lvItem.SubItems[1], 0);
    IsScratched := false;
    IsDisqualified := true;
    SQL := 'UPDATE SwimClubMeet.dbo.Entrant (DisqualifyCodeID, IsScratched, IsDisqualified) ' +
    ' VALUES (:ID1, :ID2, :ID3) WHERE [Entrant].EntrantID = :ID4;';
    // fConnection.ExecSQL(SQL, [CodeID, IsScratched, IsArchived, fEntrantID]);

    ModalResult := mrOk;
    Close;
  end;
end;

procedure TDCodePicker.FormCreate(Sender: TObject);
begin
  lvCodes.Items.Clear;
end;

procedure TDCodePicker.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
  Close;
end;

procedure TDCodePicker.FormShow(Sender: TObject);
var
  lv: TListItem;
  lvg: TListGroup;
  i, j: integer;
begin
  if fEntrantID > 0 then
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
      else
        j := 0;
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
    end;
    lvCodes.Items.EndUpdate;
  end;

end;

end.
