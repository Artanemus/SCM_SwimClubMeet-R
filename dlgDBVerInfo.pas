unit dlgDBVerInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.VirtualImage,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.ExtCtrls;

type
  TDBVerInfo = class(TForm)
    qrySCMSystem: TFDQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnClose: TButton;
    dsSCMSystem: TDataSource;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    fConnection: TFDConnection;
    fDBModel, fDBVersion, fDBMajor, fDBMinor: integer;
    function GetDBVerInfo(): Boolean;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AConnection: TFDConnection);
      reintroduce; overload;
    property Connection: TFDConnection read FConnection write FConnection;

  end;

var
  DBVerInfo: TDBVerInfo;

implementation

{$R *.dfm}

{ TDBVersionInfo }

procedure TDBVerInfo.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

constructor TDBVerInfo.Create(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  inherited Create(AOwner);
  if Assigned(AConnection) then
    FConnection := AConnection
  else
    FConnection := nil;
end;

procedure TDBVerInfo.FormCreate(Sender: TObject);
begin
  if Assigned(FConnection) then
  begin
    // test if qrySwimClub is running 1.6 or greater
    if GetDBVerInfo then
    begin
      // Version control v1,1,5,0 - v1,1,5,1
      if (fDBMajor = 5) AND ((fDBMinor = 0) or (fDBMinor = 1)) then
      begin
        Label1.Caption := IntToStr(fDBModel);
        Label2.Caption := IntToStr(fDBVersion);
        Label3.Caption := IntToStr(fDBMajor);
        Label4.Caption := IntToStr(fDBMinor);
      end
      // Version control v1,1,6,0
      else
        ; // TODO
    end;

  end;
end;

procedure TDBVerInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    ModalResult := mrClose;
end;

function TDBVerInfo.GetDBVerInfo: Boolean;
begin
  result := false;
  if Assigned(fConnection) then
  begin
    with qrySCMSystem do
    begin
      Connection := fConnection;
      Open;
      if Active then
      begin
        fDBModel := FieldByName('SCMSystemID').AsInteger;
        fDBVersion := FieldByName('DBVersion').AsInteger;
        fDBMajor := FieldByName('Major').AsInteger;
        fDBMinor := FieldByName('Minor').AsInteger;
        result := true;
      end;
      Close;
    end;
  end;
end;

end.
