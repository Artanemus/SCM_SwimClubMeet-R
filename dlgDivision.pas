unit dlgDivision;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.ComCtrls, frxPreview, frxClass, frxDBSet;

type
  TDivision = class(TForm)
    Panel2: TPanel;
    btnClose: TButton;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    DBGrid1: TDBGrid;
    Label5: TLabel;
    qryDivision: TFDQuery;
    qryDivisionScoreDivisionID: TFDAutoIncField;
    qryDivisionSwimClubID: TIntegerField;
    qryDivisionAgeFrom: TIntegerField;
    qryDivisionAgeTo: TIntegerField;
    qryDivisionGenderID: TIntegerField;
    dsDivision: TDataSource;
    qryDivisionluGender: TStringField;
    qryDivisionCaption: TWideStringField;
    btnDivMembers: TButton;
    Label10: TLabel;
    DBNavigator1: TDBNavigator;
    tblGender: TFDTable;
    luGender: TDataSource;
    frxDivMembers: TfrxReport;
    frxDSDivMembers: TfrxDBDataset;
    qryDivMembers: TFDQuery;
    qryRptHeader: TFDQuery;
    frxDBDSRptHeader: TfrxDBDataset;

    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnDivMembersClick(Sender: TObject);

  private
    { Private declarations }
    fSwimClubID: integer;
    fConnection: TFDConnection;
    fStartOfSwimSeason: TDateTime;

    procedure WritePreferences(iniFileName: string);
    procedure ReadPreferences(iniFileName: string);
  public
    { Public declarations }
    property Connection: TFDConnection write FConnection;
    property StartOfSwimSeason: TDateTime write fStartOfSwimSeason;
  end;

var
  Division: TDivision;

implementation

{$R *.dfm}

uses SCMUtility, iniFiles;

procedure TDivision.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TDivision.btnDivMembersClick(Sender: TObject);
begin
  // note : uses RPTS.qryRptHeader
	if (fStartOfSwimSeason <> 0) and Assigned(fConnection) then
  begin
    qryRptHeader.Connection := fConnection;
    qryRptHeader.Open();
    qryDivMembers.Connection := fConnection;
    qryDivMembers.ParamByName('SEEDDATE').AsDateTime := fStartOfSwimSeason;
    qryDivMembers.Prepare();
    qryDivMembers.Open();
    if (qryDivMembers.Active) and (qryRptHeader.Active) then
      frxDivMembers.ShowReport;
  end;
end;

procedure TDivision.FormCreate(Sender: TObject);
var
  iniFileName: string;
begin
  // i n i t   p a r a m s  .
  // -------------------------------------
  PageControl1.TabIndex := 0;
  fSwimClubID := 1;
  fStartOfSwimSeason := 0;
  // -------------------------------------
  // r e a d   p r e f e r e n c e .
  // -------------------------------------
  iniFileName := Scmutility.GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName);
  PageControl1.TabIndex := 0;
end;

procedure TDivision.FormDestroy(Sender: TObject);
var
  iniFileName: string;
begin
  iniFileName := GetSCMPreferenceFileName();
  if FileExists(iniFileName) then
    WritePreferences(iniFileName);
end;

procedure TDivision.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrOk;
end;

procedure TDivision.FormShow(Sender: TObject);
begin
  // -------------------------------------
  // C O N N E C T   L O C A L   D A T A S E T S  .
  // -------------------------------------
  if assigned(fConnection) then
  begin
    qryDivision.Connection := fConnection;
    tblGender.Connection := fConnection;
    // Activate tables/queries contained in this dialogue
    tblGender.Open;
    qryDivision.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    qryDivision.Prepare;
    qryDivision.Open();
  end;
end;


procedure TDivision.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(iniFileName);
//
  iFile.Free;
end;


procedure TDivision.WritePreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(iniFileName);
//
  iFile.Free;
end;


end.
