unit dlgMemberClub;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,  System.Generics.Collections, SCMDefines;

type
  TItemData = class
  public
    Value: Integer;
    constructor Create(AValue: Integer);
  end;

  TMemberClub = class(TForm)
    chklstSwimClub: TCheckListBox;
    qrySwimClub: TFDQuery;
    procedure chklstSwimClubClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fSwimClubID: integer;
    fConnection: TFDConnection;

  public
    { Public declarations }
    procedure Prepare(AConnection: TFDConnection; ASwimClubID: integer);
    procedure SendFilterString();
    property SwimClubID: integer read fSwimClubID write fSwimClubID;
  end;

var
  MemberClub: TMemberClub;

implementation

{$R *.dfm}

constructor TItemData.Create(AValue: Integer);
begin
  Value := AValue;
end;

procedure TMemberClub.chklstSwimClubClickCheck(Sender: TObject);
begin
  SendFilterString;
end;

procedure TMemberClub.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  // remove TItemData object associated with each TCheckboxList item.
  for i := 0 to chklstSwimClub.Items.Count - 1 do
    TItemData(chklstSwimClub.Items.Objects[i]).Free;
end;

procedure TMemberClub.FormCreate(Sender: TObject);
begin
  // Clear the list of prototype data
  chklstSwimClub.Items.Clear;
end;

procedure TMemberClub.FormDeactivate(Sender: TObject);
begin
//  WritePreferences; // record filter state
  PostMessage(TForm(Owner).Handle, SCM_FILTERCLUBDEACTIVATED, 0, 0);
end;

procedure TMemberClub.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
//    WritePreferences;
    ModalResult := mrOk;
  end;
end;

procedure TMemberClub.Prepare(AConnection: TFDConnection; ASwimClubID: Integer);
var
  idx: Integer;
  itemdata: TItemData;
  FoundChecked: boolean;
begin
  if Assigned(AConnection) then
  begin
    fConnection := AConnection;
    qrySwimClub.Connection := AConnection;
    qrySwimClub.Open;
  end;
  if qrySwimClub.Active then
  begin
    // A s s i g n m e n t
    While not qrySwimClub.Eof DO
    begin
      itemdata := TItemData.Create(qrySwimClub.FieldByName('SwimClubID')
        .AsInteger);
      idx := chklstSwimClub.Items.Add(qrySwimClub.FieldByName('Caption')
        .AsString);
      chklstSwimClub.Items.Objects[idx] := TObject(itemdata);

      if (ASwimClubID > 0) then // a swimclubID was specified.
      begin
        if (ASwimClubID = itemdata.Value) then
          chklstSwimClub.Checked[idx] := true; // check item.
      end;
      qrySwimClub.next;
    end;
    // final checks.
    // Was a swimclub checked?
    FoundChecked := false;
    for idx := 0 to chklstSwimClub.Items.Count - 1 do
      if chklstSwimClub.Checked[idx] then
      begin
        FoundChecked := true;
        break;
      end;
    // if nothing is checked - then check all
    if not FoundChecked then
    begin
      for idx := 0 to chklstSwimClub.Items.Count - 1 do
        chklstSwimClub.Checked[idx] := true;
    end;
  end;
end;

procedure TMemberClub.SendFilterString();
var
  idx, ID: integer;
  MyFilter: string;
  itemdata: TItemData;
  DoAnd: boolean;
begin

  MyFilter := '';
  DoAnd := false;
  for idx := 0 to chklstSwimClub.Items.Count - 1 do
    if chklstSwimClub.Checked[idx] then
    begin
      itemdata :=  TItemData(chklstSwimClub.Items.Objects[idx]);
      ID := itemdata.value;
      if DoAnd then
        MyFilter := MyFilter + ' AND';
      MyFilter := MyFilter + ' SwimClubID = ' + IntToStr(ID);
      DoAnd := true;
    end;
  SendMessage(TForm(Owner).Handle, SCM_FILTERCLUBUPDATED, 0, LPARAM(PChar(MyFilter)));
end;


end.
