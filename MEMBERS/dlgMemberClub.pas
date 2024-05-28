unit dlgMemberClub;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,  System.Generics.Collections;

type
  TMemberClub = class(TForm)
    chklstSwimClub: TCheckListBox;
    Panel1: TPanel;
    btnOk: TButton;
    qrySwimClub: TFDQuery;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fSwimClubID: integer;
    fConnection: TFDConnection;
    FListOfCheckedSwimClubID: TList<Integer>; // for current member.

  public
    { Public declarations }
    procedure Prepare(AConnection: TFDConnection; IDList: TList<Integer>; CheckAll: boolean);
    property SwimClubID: integer read fSwimClubID write fSwimClubID;


  end;

var
  MemberClub: TMemberClub;

implementation

{$R *.dfm}

procedure TMemberClub.FormDestroy(Sender: TObject);
begin
  FListOfCheckedSwimClubID.Free;
end;

procedure TMemberClub.FormCreate(Sender: TObject);
begin
  // Clear the list of prototype data
  chklstSwimClub.Items.Clear;
  FListOfCheckedSwimClubID := TList<Integer>.Create;
end;

procedure TMemberClub.Prepare(AConnection: TFDConnection; IDList: TList<Integer>; CheckAll: boolean);
var
idx, ASwimClubID: integer;
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
      idx := chklstSwimClub.Items.Add(qrySwimClub.FieldByName('Caption').AsString);
      ASwimClubID := qrySwimClub.FieldByName('SwimClubID').AsInteger;
      if IDList.Contains(ASwimClubID) then
        chklstSwimClub.Checked[idx] := true;
      qrySwimClub.next;
    end;
  end;
end;

end.
