unit dlgSwimClubManage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, dmSCM, Vcl.WinXPanels;

type
  TSwimClubManage = class(TForm)
    qrySwimClub: TFDQuery;
    dsSwimClub: TDataSource;
    btnOk: TButton;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel3: TPanel;
    lbxClubs: TListBox;
    StackPanel1: TStackPanel;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fActiveSwimClub: integer;
    function Locate_SwimClub(aSwimClubID: integer): boolean;
  public
    { Public declarations }
    property ActiveSwimClub: integer read FActiveSwimClub write FActiveSwimClub;
  end;

var
  SwimClubManage: TSwimClubManage;

implementation

{$R *.dfm}

procedure TSwimClubManage.btnOkClick(Sender: TObject);
begin
  fActiveSwimClub := qrySwimClub.FieldByName('SwimClubID').AsInteger;
  ModalResult := mrOk;
end;

procedure TSwimClubManage.FormCreate(Sender: TObject);
begin
  if Assigned(SCM) and SCM.scmConnection.Connected then
    qrySwimClub.Open;
  fActiveSwimClub := 0;
end;

procedure TSwimClubManage.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = vk_Escape then
  begin
    fActiveSwimClub := 0;
    Key := 0;
    ModalResult := mrCancel;
  end;
end;

procedure TSwimClubManage.FormShow(Sender: TObject);
begin
  if qrySwimClub.Active then
  begin
    // fill the listbox with items
    lbxClubs.Items.Clear;
    qrySwimClub.first;
    While not qrySwimClub.eof do
    begin
      lbxClubs.Items.Add(qrySwimClub.FieldByName('Caption').AsString);
      qrySwimClub.next;
    end;

    if (fActiveSwimClub = 0) then qrySwimClub.First
    else Locate_SwimClub(fActiveSwimClub);

    if (fActiveSwimClub = 0) then lbxClubs.ItemIndex := -1
    else
    lbxClubs.ItemIndex := qrySwimClub.FieldByName('SwimClubID').AsInteger - 1;

  end;
end;


function TSwimClubManage.Locate_SwimClub(aSwimClubID: integer): boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if qrySwimClub.Active then
  begin
    SearchOptions := [];
    result := qrySwimClub.Locate('SwimClubID', aSwimClubID, SearchOptions);
  end;
end;

end.
