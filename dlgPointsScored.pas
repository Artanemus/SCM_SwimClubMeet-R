unit dlgPointsScored;

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
  TPointsScored = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnClose: TButton;
    lblPlace: TLabel;
    lblPoints: TLabel;
    lbl01: TLabel;
    lbl02: TLabel;
    lbl03: TLabel;
    lbl04: TLabel;
    lbl05: TLabel;
    lbl06: TLabel;
    lbl07: TLabel;
    lbl08: TLabel;
    lbl09: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    edtm01: TMaskEdit;
    edtm02: TMaskEdit;
    edtm03: TMaskEdit;
    edtm04: TMaskEdit;
    edtm05: TMaskEdit;
    edtm06: TMaskEdit;
    edtm07: TMaskEdit;
    edtm08: TMaskEdit;
    edtm09: TMaskEdit;
    edtm10: TMaskEdit;
    edtm11: TMaskEdit;
    edtm12: TMaskEdit;
    cmdInsertPlace: TFDCommand;
    cmdDeletePlace: TFDCommand;
    dsScorePoints: TDataSource;
    btnPointsScored: TButton;
    Label10: TLabel;
    tblScorePoints: TFDTable;
    edtm00: TMaskEdit;
    Label6: TLabel;
    Label1: TLabel;
    edtm13: TMaskEdit;
    Label7: TLabel;
    edtm14: TMaskEdit;
    Label8: TLabel;
    edtm15: TMaskEdit;
    Label11: TLabel;
    edtm16: TMaskEdit;
    Label12: TLabel;
    edtm17: TMaskEdit;
    Label13: TLabel;
    edtm18: TMaskEdit;
    Label14: TLabel;
    edtm19: TMaskEdit;
    Label15: TLabel;
    edtm20: TMaskEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtm21: TMaskEdit;
    edtm22: TMaskEdit;
    Label22: TLabel;
    edtm23: TMaskEdit;
    Label23: TLabel;
    edtm24: TMaskEdit;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtm31: TMaskEdit;
    edtm32: TMaskEdit;
    Label28: TLabel;
    edtm25: TMaskEdit;
    Label29: TLabel;
    edtm26: TMaskEdit;
    Label30: TLabel;
    edtm27: TMaskEdit;
    Label31: TLabel;
    edtm28: TMaskEdit;
    Label32: TLabel;
    edtm29: TMaskEdit;
    Label33: TLabel;
    edtm30: TMaskEdit;
    Label34: TLabel;
    Label35: TLabel;
    qryRptHeader: TFDQuery;
    frxDBDSRptHeader: TfrxDBDataset;
    qryPointsScored: TFDQuery;
    frxDSPointsScored: TfrxDBDataset;
    frxPointsScored: TfrxReport;

    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtmOnChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnPointsScoredClick(Sender: TObject);

  private
    { Private declarations }
    fSwimClubID: integer;
    fMaxEDTM: integer;
    IsUnderConstruction: boolean;
    IsModifiedScore: boolean;
    fConnection: TFDConnection;

    function LocatePlacing(place, SwimClubID: integer): boolean;
    procedure WritePreferences(iniFileName: string);
    procedure ReadPreferences(iniFileName: string);
    procedure ReadScores();
    procedure WriteScores();
  public
    { Public declarations }
    property Connection: TFDConnection write FConnection;
    property SwimClubID: integer read FSwimClubID write FSwimClubID;
  end;

var
  PointsScored: TPointsScored;

implementation

{$R *.dfm}

uses SCMUtility, iniFiles;

procedure TPointsScored.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TPointsScored.btnPointsScoredClick(Sender: TObject);
begin
  // note : uses RPTS.qryRptHeader
	if (fSwimClubID <> 0) and Assigned(fConnection) then
  begin
    WriteScores; // update DB Score table ...
    IsModifiedScore := false;
    // ready queries and send to fast reports
    qryRptHeader.Connection := fConnection;
    qryRptHeader.Open();
    qryPointsScored.Connection := fConnection;
    qryPointsScored.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    qryPointsScored.Prepare();
    qryPointsScored.Open();
    if (qryPointsScored.Active) and (qryRptHeader.Active) then
      frxPointsScored.ShowReport;
  end;
end;

procedure TPointsScored.edtmOnChange(Sender: TObject);
begin
  if not IsUnderConstruction then
    IsModifiedScore := true;
end;

procedure TPointsScored.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (IsModifiedScore) then
  begin
    WriteScores; // update DB Score table ...
    IsModifiedScore := false;
  end;
  Action := caFree;
end;


procedure TPointsScored.FormCreate(Sender: TObject);
var
  i: integer;
  s, iniFileName: string;
  comp: TComponent;
begin
  // i n i t   p a r a m s  .
  // -------------------------------------
  PageControl1.TabIndex := 0;
  fSwimClubID := 1;
  IsModifiedScore := false;
  fMaxEDTM := 32; // 3xHeats at 8 per lanes
  // -------------------------------------
  // r e a d   p r e f e r e n c e .
  // -------------------------------------
  iniFileName := SCMUtility.GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName);
  // -------------------------------------
  // 'Zero' values in edtm TMaskEdit
  // -------------------------------------
  IsUnderConstruction := true;
  for i := 0 to fMaxEDTM do
  begin
    s := 'edtm' + Format('%0.2d', [i]);
    comp := FindComponent(s);
    if assigned(comp) then
      (comp as TMaskEdit).editText := '00.0';
  end;
  IsUnderConstruction := false;
  PageControl1.TabIndex := 0;
end;

procedure TPointsScored.FormDestroy(Sender: TObject);
var
  iniFileName: string;
begin
  iniFileName := GetSCMPreferenceFileName();
  if FileExists(iniFileName) then
    WritePreferences(iniFileName);
end;

procedure TPointsScored.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrOk;
end;

procedure TPointsScored.FormShow(Sender: TObject);
begin

  // -------------------------------------
  // C O N N E C T   L O C A L   D A T A S E T S  .
  // -------------------------------------
  if assigned(fConnection) then
  begin
    tblScorePoints.Connection := fConnection;
    cmdInsertPlace.Connection := fConnection;
    cmdDeletePlace.Connection := fConnection;
    // Activate tables/queries contained in this dialogue
    tblScorePoints.Open;
  end;

  IsUnderConstruction := true;
  // -------------------------------------
  // R E A D   S C O R E S .
  // -------------------------------------
  ReadScores;
  IsUnderConstruction := false;
end;

function TPointsScored.LocatePlacing(place, SwimClubID: integer): boolean;
begin
  try
    result := tblScorePoints.Locate('Place;SwimClubID',
      VarArrayOf([place, SwimClubID]), [loPartialKey]);
  except
    on E: Exception do
      result := false;
  end;
end;

procedure TPointsScored.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(iniFileName);
//
  iFile.Free;
end;

procedure TPointsScored.ReadScores;
var
  i: integer;
  s: string;
  comp: TComponent;
  success: boolean;
  scorePoints: double;
begin
  // populate visible edit boxes with data from SwimClubMeet table Score.
  // if data doesn't exist then skip...
  for i := 0 to fMaxEDTM do
  begin
    s := 'edtm' + Format('%0.2d', [i]);
    comp := FindComponent(s);
    if assigned(comp) then
    begin
      if (tblScorePoints.Active) then
      begin
        // locate 'score' for requested place.
        success := LocatePlacing(i, fSwimClubID);
        if (success) then
        begin
          scorePoints := tblScorePoints.FieldByName('Points').AsFloat;
          s := FloatToStrF(scorePoints, ffFixed, 4, 1);
          // pad with leading '0' to conform to editmask....
          if Length(s) > 4 then
          begin
            s := s.SubString((Length(s) - 4), Length(s));
          end;
          if (Length(s) < 4) then
          begin
            s := '0' + s;
          end;
          (comp as TMaskEdit).editText := s;
        end;
      end;
    end;
  end;
end;

procedure TPointsScored.WritePreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(iniFileName);
//
  iFile.Free;
end;

procedure TPointsScored.WriteScores;
var
  i: integer;
  scorePoints: double;
  s: String;
  comp: TComponent;
  edtm: TMaskEdit;
  success: boolean;
begin

  if (IsUnderConstruction = true) then
    exit;

  // update the Score table ...
  for i := 0 to fMaxEDTM do
  begin
    s := 'edtm' + Format('%0.2d', [i]);
    comp := FindComponent(s);
    if assigned(comp) then
    begin
      edtm := comp as TMaskEdit;
      scorePoints := double(StrToFloatDef(edtm.editText, 0));
      if tblScorePoints.Active then
      begin
        success := LocatePlacing(edtm.Tag, fSwimClubID);
        if (success) then
        begin
          tblScorePoints.Edit;
          tblScorePoints.FieldByName('Points').AsFloat := scorePoints;
          tblScorePoints.Post();
        end
        else
        begin
          if (fSwimClubID > 0) then
          begin
            cmdInsertPlace.Close;
            cmdInsertPlace.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
            cmdInsertPlace.ParamByName('POINTS').AsFloat := double(scorePoints);
            cmdInsertPlace.ParamByName('PLACE').AsInteger := edtm.Tag;
            cmdInsertPlace.Prepare;
            cmdInsertPlace.Open; // execute the command
            cmdInsertPlace.Close;
          end;
        end;
      end;
    end;
  end;
  // --------------------------------------
  // c l e a n   D a t a B a s e .
  // delete records greater than Lane-Count
  // --------------------------------------
  if (fSwimClubID > 0) then
  begin
    cmdDeletePlace.Close;
    cmdDeletePlace.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    cmdDeletePlace.ParamByName('PLACE').AsInteger := fMaxEDTM;
    cmdDeletePlace.Prepare();
    cmdDeletePlace.Open(); // execute the command
    cmdDeletePlace.Close();
  end;

  IsModifiedScore := false;

end;

end.
