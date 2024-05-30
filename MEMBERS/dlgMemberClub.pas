unit dlgMemberClub;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, SCMDefines;

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
    fListOfClubIDs: TList<Integer>;
  public
    { Public declarations }
    procedure Prepare(AConnection: TFDConnection;  var ListOfClubIDs: TList<Integer> );
    procedure SendFilterClubMessage();
    property SwimClubID: integer read fSwimClubID write fSwimClubID;
    property ListOfClubIDs: TList<Integer> read fListOfClubIDs;
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
var
idx, I, ASwimClubID: integer;
itemdata: TItemData;
IsChecked: boolean;
begin
  // update state of fListOfClubIDs;
  idx :=  TCheckListBox(Sender).ItemIndex;  // current item.
  itemdata :=  TItemData(chklstSwimClub.Items.Objects[idx]); // TObject.
  ASwimClubID := itemdata.Value; // dbo.tblSwimClub.SwimClubID.
  IsChecked := chklstSwimClub.Checked[idx];
  if IsChecked AND not fListOfClubIDs.Contains(ASwimClubID) then
    fListOfClubIDs.Add(ASwimClubID);
  if not IsChecked AND fListOfClubIDs.Contains(ASwimClubID)  then
  begin
    I := fListOfClubIDs.IndexOf(ASwimClubID);
    fListOfClubIDs.Delete(I);
  end;

  SendFilterClubMessage;
end;

procedure TMemberClub.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  // remove TItemData object associated with each TCheckboxList item.
  for i := 0 to chklstSwimClub.Items.Count - 1 do
    TItemData(chklstSwimClub.Items.Objects[i]).Free;
  fListOfClubIDs.Free;
end;

procedure TMemberClub.FormCreate(Sender: TObject);
begin
  chklstSwimClub.Items.Clear; // Clear the list of prototype data
  fListOfClubIDs := TList<Integer>.Create;
end;

procedure TMemberClub.FormDeactivate(Sender: TObject);
begin
  PostMessage(TForm(Owner).Handle, SCM_FILTERCLUBDEACTIVATED, 0, 0);
end;

procedure TMemberClub.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrOk;
  end;
end;

procedure TMemberClub.Prepare(AConnection: TFDConnection; var ListOfClubIDs: TList<Integer> );
var
  idx: Integer;
  itemdata: TItemData;
begin
  // CLONE last checked state...
  fListOfClubIDs.Clear;
  fListOfClubIDs.AddRange(ListOfClubIDs);

  if Assigned(AConnection) then
  begin
    fConnection := AConnection;
    qrySwimClub.Connection := AConnection;
    qrySwimClub.Open;
  end;
  if qrySwimClub.Active then
  begin
    // BUILD THE LIST ITEMS AND OBJECTS FOR THE CHECKBOXLIST
    While not qrySwimClub.Eof DO
    begin
      itemdata := TItemData.Create(qrySwimClub.FieldByName('SwimClubID')
        .AsInteger);
      idx := chklstSwimClub.Items.Add(qrySwimClub.FieldByName('Caption')
        .AsString);
      chklstSwimClub.Items.Objects[idx] := TObject(itemdata);
      // CHECK ITEMS ...
      // checkboxlist.item 'checked' if the collection.contains -->
      //  checkboxlist.object.value ... SwimClubID.
      if (fListOfClubIDs.Contains(itemdata.Value) ) then
        chklstSwimClub.Checked[idx] := true; // check item.
      qrySwimClub.next;
    end;
  end;
end;

procedure TMemberClub.SendFilterClubMessage();
begin
  SendMessage(TForm(Owner).Handle, SCM_FILTERCLUBUPDATED, 0, 0);
end;


end.
