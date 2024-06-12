unit dlgMemberClub;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.CheckLst,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, SCMDefines, Vcl.DBCtrls;

type
  TItemData = class
  public
    Value: Integer;
    constructor Create(AValue: Integer);
  end;

  TMemberClub = class(TForm)
    btnOk: TButton;
    chklstSwimClub: TCheckListBox;
    dsSwimClub: TDataSource;
    Panel1: TPanel;
    qrySwimClub: TFDQuery;
    procedure btnOkClick(Sender: TObject);
    procedure chklstSwimClubClickCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    fSwimClubID: Integer;
  public
    procedure Prepare(AConnection: TFDConnection; ASwimClubID: Integer);
    property SwimClubID: Integer read fSwimClubID write fSwimClubID;
  end;

var
  MemberClub: TMemberClub;

implementation

{$R *.dfm}

constructor TItemData.Create(AValue: Integer);
begin
  Value := AValue;
end;

procedure TMemberClub.btnOkClick(Sender: TObject);
var
  idx: Integer;
  itemdata: TItemData;
begin
  fSwimClubID := 0;
  for idx := 0 to chklstSwimClub.Count - 1 do
  begin
    if chklstSwimClub.Checked[idx] then
    begin
      itemdata := TItemData(chklstSwimClub.Items.Objects[idx]);
      fSwimClubID := itemdata.Value;
      break;
    end;
  end;
  if fSwimClubID > 0 then
    ModalResult := mrOK
  else
    ModalResult := mrCancel;

end;

procedure TMemberClub.chklstSwimClubClickCheck(Sender: TObject);
var
  idx, I: Integer;
begin
  // update state of fListOfClubIDs;
  idx := TCheckListBox(Sender).ItemIndex; // current item.
  if chklstSwimClub.Checked[idx] then
  begin
    // clear any other checked items
    for I := 0 to TCheckListBox(Sender).Count - 1 do
      if I <> idx then
        TCheckListBox(Sender).Checked[I] := false;
  end;
end;

procedure TMemberClub.FormCreate(Sender: TObject);
begin
  chklstSwimClub.Items.Clear; // Clear the list of prototype data
  fSwimClubID := 0;
end;

procedure TMemberClub.FormDestroy(Sender: TObject);
var
  itemdata: TItemData;
  idx: integer;
begin
  for idx := 0 to chklstSwimClub.Count - 1 do
  begin
    itemdata := TItemData(chklstSwimClub.Items.Objects[idx]);
    itemdata.Free;
  end;
end;

procedure TMemberClub.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
  end;
end;

procedure TMemberClub.Prepare(AConnection: TFDConnection;  ASwimClubID: Integer);
var
  idx: Integer;
  itemdata: TItemData;
begin
  if not Assigned(AConnection) then exit;
  qrySwimClub.Connection := AConnection;
  qrySwimClub.Open;
  if qrySwimClub.Active then
  begin
    // BUILD THE LIST ITEMS AND OBJECTS FOR THE CHECKBOXLIST.
    // Check the current active swimming club.
    While not qrySwimClub.Eof DO
    begin
      itemdata := TItemData.Create(qrySwimClub.FieldByName('SwimClubID')
        .AsInteger);
      idx := chklstSwimClub.Items.Add(qrySwimClub.FieldByName('Caption')
        .AsString);
      chklstSwimClub.Items.Objects[idx] := TObject(itemdata);
      if itemdata.Value = ASwimClubID then
        chklstSwimClub.Checked[idx] := true
      else
        chklstSwimClub.Checked[idx] := false;
      qrySwimClub.next;
    end;
  end;
end;

end.
