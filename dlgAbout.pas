unit dlgAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, ExeInfo, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImage;

type
  TAbout = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
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
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure VirtualImage1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    ExeInfo1: TExeInfo;
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
		// ShowMessage('Error starting FDAdministrator!');
  end;
end;

end.
