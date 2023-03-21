unit dlgFindMember;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.VirtualImage, Vcl.BaseImageCollection,
  Vcl.ImageCollection, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait;

type
  TFindMember = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Panel2: TPanel;
    btnGotoMember: TButton;
    DBGrid1: TDBGrid;
    ImageCollection1: TImageCollection;
    VirtualImage1: TVirtualImage;
    lblFound: TLabel;
    qryFindMember: TFDQuery;
    dsFindMember: TDataSource;
    qryFindMemberMemberID: TFDAutoIncField;
    qryFindMemberMembershipNum: TIntegerField;
    qryFindMemberFName: TWideStringField;
    qryFindMemberSwimClubID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGotoMemberClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fMemberID, fSwimClubID: integer;
    fConnection: TFDConnection;
  public
    { Public declarations }
    procedure Prepare(AConnection: TFDConnection; ASwimClubID: integer);
    property MemberID: integer read fMemberID write fMemberID;
  end;

var
  FindMember: TFindMember;

implementation

{$R *.dfm}

procedure TFindMember.btnGotoMemberClick(Sender: TObject);
begin
  if qryFindMember.Active then
    begin
      fMemberID := qryFindMember.FieldByName('MemberID').AsInteger;
      if (fMemberID > 0) then
      begin
        ModalResult := mrOk;
      end;
    end;
end;

procedure TFindMember.DBGrid1DblClick(Sender: TObject);
begin
  btnGotoMemberClick(self);
end;

procedure TFindMember.Edit1Change(Sender: TObject);
var
  LocateSuccess: boolean;
  SearchOptions: TLocateOptions;
  MemberID: integer;
  fs: string;
begin

  LocateSuccess := false;
  if not qryFindMember.Active then
    exit;

  fs := '';
  qryFindMember.DisableControls();

  // LOCATE AND STORE THE CURRENT MEMBERID
  MemberID := qryFindMember.FieldByName('MemberID').AsInteger;

  // ---------------------------------
  // MEMBER'S FULLNAME ....
  // ---------------------------------
  if (Length(Edit1.Text) > 0) then
  begin
    fs := fs + '[FName] LIKE ' + QuotedStr('%' + Edit1.Text + '%');
  end;

  if (fs.IsEmpty()) then
    qryFindMember.Filtered := false
  else
  begin
    qryFindMember.Filter := fs;
    if not(qryFindMember.Filtered) then
      qryFindMember.Filtered := true;
  end;

  // DISPLAY NUMBER OF RECORDS FOUND
  qryFindMember.Last();
  lblFound.Caption := 'Found: ' + IntToStr(qryFindMember.RecordCount);
  // RE_LOCATE TO THE MEMBERID
  if (MemberID <> 0) then
  begin
    SearchOptions := [];
    try
      begin
        LocateSuccess := qryFindMember.Locate('MemberID', MemberID,
          SearchOptions);
      end;
    except
      on E: Exception do
        LocateSuccess := false;
    end;
  end;
  // IF MEMBER NOT FOUND ... BROWSE TO FIRST RECORD.
  if (LocateSuccess = false) then
    qryFindMember.First();

  qryFindMember.EnableControls();
end;

procedure TFindMember.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryFindMember.Close;
end;

procedure TFindMember.FormCreate(Sender: TObject);
begin
  fMemberID := 0;
  fSwimClubID := 0;
  fConnection := nil;
end;

procedure TFindMember.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;


procedure TFindMember.Prepare(AConnection: TFDConnection; ASwimClubID: integer);
begin
  if Assigned(AConnection) then
  begin
    fConnection := AConnection;
    fSwimClubID := ASwimClubID;
    qryFindMember.Connection := AConnection;
    qryFindMember.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    qryFindMember.Open;
  end;
  if qryFindMember.Active then
  begin
    // A s s i g n m e n t   r e q u i r e d  !
    DBGrid1.DataSource := dsFindMember;
    // Results in Edit1Change event!   (Sets up filters and record count.)
    Edit1.Text := '';
  end;
end;



end.
