unit dlgSwimClubSwitch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, dmSCM,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls;

type
  TSwimClubSwitch = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnCancel: TButton;
    btnSwimClubSwitch: TButton;
    qrySwimClub: TFDQuery;
    dsSwimClub: TDataSource;
    lblSwimClubSelection: TLabel;
    DBComboBox1: TDBLookupComboBox;
    tblSwimClub: TFDTable;
    dsluSwimClub: TDataSource;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSwimClubSwitchClick(Sender: TObject);
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
  SwimClubSwitch: TSwimClubSwitch;

implementation

{$R *.dfm}

procedure TSwimClubSwitch.btnCancelClick(Sender: TObject);
begin
    fActiveSwimClub := 0;
    ModalResult := mrCancel;
end;

procedure TSwimClubSwitch.btnSwimClubSwitchClick(Sender: TObject);
begin
  fActiveSwimClub := qrySwimClub.FieldByName('SwimClubID').AsInteger;
  ModalResult := mrOk;
end;

procedure TSwimClubSwitch.FormCreate(Sender: TObject);
begin
  if Assigned(SCM) and SCM.scmConnection.Connected then
  begin
    tblSwimClub.Open;
    qrySwimClub.Open;
  end;
  fActiveSwimClub := 0;
end;

procedure TSwimClubSwitch.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = vk_Escape then
  begin
    fActiveSwimClub := 0;
    Key := 0;
    ModalResult := mrCancel;
  end;
end;

procedure TSwimClubSwitch.FormShow(Sender: TObject);
begin
  if qrySwimClub.Active then
  begin
    if (fActiveSwimClub = 0) then qrySwimClub.First
    else Locate_SwimClub(fActiveSwimClub);
  end;
end;

function TSwimClubSwitch.Locate_SwimClub(aSwimClubID: integer): boolean;
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
