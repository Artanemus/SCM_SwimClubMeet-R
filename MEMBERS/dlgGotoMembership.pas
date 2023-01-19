unit dlgGotoMembership;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.VirtualImage, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TGotoMembership = class(TForm)
    Panel1: TPanel;
    btnGoto: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    lblErrMsg: TLabel;
    Edit1: TEdit;
    VirtualImage1: TVirtualImage;
    ImageCollection1: TImageCollection;
    qAssertMemberID: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGotoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    fMemberID: integer;
    fMembershipNum: integer;
    fSwimClubID: integer;
    fConnection: TFDConnection;
    function AssertMembershipNum(MembershipNum: integer): boolean;

  public
    { Public declarations }
    procedure Prepare(AConnection: TFDConnection; ASwimClubID: integer);
    property MemberID: integer read fMemberID write fMemberID;
    property SwimClubID: integer read fSwimClubID write fSwimClubID;
    property MembershipNum: integer read fMembershipNum write fMembershipNum;
    property Connection: TFDConnection read FConnection write FConnection;
  end;

var
  GotoMembership: TGotoMembership;

implementation

{$R *.dfm}

function TGotoMembership.AssertMembershipNum(MembershipNum: integer): boolean;
begin
  result := false;
  if Assigned(fConnection) then
  begin
    qAssertMemberID.Connection := fConnection;
    qAssertMemberID.Close;
    qAssertMemberID.SQL.Clear;
    qAssertMemberID.SQL.Add
      ('SELECT MemberID, MembershipNum, SwimClubID FROM Member WHERE MembershipNum = '
      + IntToStr(MembershipNum) + ' AND SwimClubID = ' + IntToStr(fSwimClubID));
    try
      qAssertMemberID.Open;
      if (qAssertMemberID.Active) then
      begin
        if qAssertMemberID.RecordCount > 0 then
        begin
          result := true;
          // NOTE: MemberID assign ...
          fMemberID := qAssertMemberID.FieldByName('MemberID').AsInteger;
        end;
      end;
    except
      on E: Exception do
        lblErrMsg.Caption := 'SCM DB access error.';
    end;

  end;
end;

procedure TGotoMembership.btnGotoClick(Sender: TObject);
begin
  if (fMembershipNum = 0) then
  begin
    Beep;
    lblErrMsg.Caption := 'Membership number is invalid.';
    exit;
  end;
  // check if valid membership number
  if AssertMembershipNum(fMembershipNum) then
    ModalResult := mrOk;
end;

procedure TGotoMembership.Edit1Change(Sender: TObject);
begin
var
  i: integer;
begin
  fMemberID := 0;
  if (Length(Edit1.Text) = 0) then
  begin
    lblErrMsg.Caption := '';
    exit;
  end;
  i := StrToIntDef(Edit1.Text, 0);
  if (i = 0) then
  begin
    lblErrMsg.Caption := '';
    exit;
  end;
  if AssertMembershipNum(i) then
  begin
    fMembershipNum := i;
    lblErrMsg.Caption := 'Membership number ..OK.';
    exit;
  end
  else
  begin
    lblErrMsg.Caption := '...?';
    exit;
  end;
end;


end;

procedure TGotoMembership.FormCreate(Sender: TObject);
begin
  fMemberID := 0;
  fMembershipNum := 0;
  fSwimClubID := 0;
  lblErrMsg.Caption := '';
  Edit1.Text := '';
end;

procedure TGotoMembership.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    btnGotoClick(self)
  else
  begin
    if (Key = VK_ESCAPE) then
    begin
      fMemberID := 0;
      fMembershipNum := 0;
      ModalResult := mrCancel;
    end;
  end;
end;

procedure TGotoMembership.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;



procedure TGotoMembership.Prepare(AConnection: TFDConnection;
  ASwimClubID: integer);
begin
  if Assigned(AConnection) then
  begin
    fConnection := AConnection;
    fSwimClubID := ASwimClubID;
  end;
end;

end.
