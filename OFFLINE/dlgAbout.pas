unit dlgAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, ExeInfo, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImage,FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet;

type
  TAbout = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    VirtualImage1: TVirtualImage;
    ImageCollection1: TImageCollection;
    Label10: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Label18: TLabel;
    qrySCMSystem: TFDQuery;
    dsSCMSystem: TDataSource;
    Label19: TLabel;
    VirtualImage2: TVirtualImage;
    VirtualImage3: TVirtualImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure VirtualImage1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fDBConnection: TFDConnection;
    fDBModel, fDBVersion, fDBMajor, fDBMinor: integer;
    function GetDBVerInfo(): Boolean;

  public
    { Public declarations }
    ExeInfo1: TExeInfo;
    property DBConnection: TFDConnection read fDBConnection write fDBConnection;
  end;

var
  About: TAbout;

implementation

{$R *.dfm}
uses
Winapi.ShellAPI;

procedure TAbout.Button1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TAbout.FormCreate(Sender: TObject);
begin
	ExeInfo1 := TExeInfo.Create(self);
  fDBConnection := nil;
end;

procedure TAbout.FormDestroy(Sender: TObject);
begin
	ExeInfo1.Free;
end;

procedure TAbout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    ModalResult := mrCancel;
end;

procedure TAbout.FormShow(Sender: TObject);
begin
	Label5.Caption := ExeInfo1.Comments;
	Label6.Caption := ExeInfo1.FileVersion;
	Label7.Caption := ExeInfo1.ProductName;
	Label8.Caption := ExeInfo1.ProductVersion;
	Label9.Caption := ExeInfo1.LegalCopyright;
  Label11.Caption := '?';
  Label12.Caption := '?';
  Label13.Caption := '?';
  Label14.Caption := '?';

  if Assigned(fDBConnection) then
  begin
    if GetDBVerInfo then
    begin
      Label11.Caption := IntToStr(fDBModel);
      Label12.Caption := IntToStr(fDBVersion);
      Label13.Caption := IntToStr(fDBMajor);
      Label14.Caption := IntToStr(fDBMinor);
    end;
  end;

end;

function TAbout.GetDBVerInfo: Boolean;
begin
  result := false;
  if Assigned(fDBConnection) then
  begin
    with qrySCMSystem do
    begin
      Connection := fDBConnection;
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

procedure TAbout.VirtualImage1Click(Sender: TObject);
var
  SEInfo: TShellExecuteInfo;
	ExecuteFile: String;
//  StartInString, ParamString: string;
begin
  // jump to Ko-fi site.
	ExecuteFile := 'https://ko-fi.com/artanemus';
	SEInfo.cbSize := sizeof(SHELLEXECUTEINFO);
	SEInfo.fMask := 0;
	SEInfo.Wnd := 0;
	SEInfo.lpVerb := nil;
	SEInfo.lpFile := PChar(ExecuteFile);
	SEInfo.lpParameters := nil;
	SEInfo.lpDirectory := nil;
	// SEInfo.nShow = SW_MAXIMIZE;
	SEInfo.nShow := SW_SHOWNORMAL;
	SEInfo.hInstApp := 0;

	if not ShellExecuteEx(@SEInfo) then
  begin
		// ShowMessage('Error!');
  end;
end;

end.
