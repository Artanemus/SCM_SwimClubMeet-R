unit dlgDBVersionInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.VirtualImage,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TDBVersionInfo = class(TForm)
    qrySCMSystem: TFDQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnClose: TButton;
    ImageCollection1: TImageCollection;
    VirtualImage1: TVirtualImage;
    dsSCMSystem: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    fConnection: TFDConnection;
    fDBVersion, fDBMajor, fDBMinor: integer;
    function GetDBVerInfo(): Boolean;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AConnection: TFDConnection);
      reintroduce; overload;
    property Connection: TFDConnection read FConnection write FConnection;

  end;

var
  DBVersionInfo: TDBVersionInfo;

implementation

{$R *.dfm}

{ TDBVersionInfo }

procedure TDBVersionInfo.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

constructor TDBVersionInfo.Create(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  inherited Create(AOwner);
  if Assigned(AConnection) then
    FConnection := AConnection
  else
    FConnection := nil;
end;

procedure TDBVersionInfo.FormCreate(Sender: TObject);
begin
  if Assigned(FConnection) then
  begin
    // test if qrySwimClub is running 1.6 or greater
    if GetDBVerInfo then
    begin
      // Version control v1,1,5,0 - v1,1,5,1
      if (fDBMajor = 5) AND ((fDBMinor = 0) or (fDBMinor = 1)) then
      begin
        Label1.Caption := '1';
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

procedure TDBVersionInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    ModalResult := mrClose;
end;

function TDBVersionInfo.GetDBVerInfo: Boolean;
begin
  result := false;
  if Assigned(FConnection) then
  begin
    qrySCMSystem.Connection := FConnection;
    qrySCMSystem.Open;
    if qrySCMSystem.Active then
    begin
      fDBVersion := qrySCMSystem.FieldByName('DBVersion').AsInteger;
      fDBMajor := qrySCMSystem.FieldByName('Major').AsInteger;
      fDBMinor := qrySCMSystem.FieldByName('Minor').AsInteger;
      result := true;
    end;
    qrySCMSystem.Close;
  end;
end;

end.
