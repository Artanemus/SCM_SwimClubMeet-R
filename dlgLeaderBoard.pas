unit dlgLeaderBoard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.ComCtrls, frxPreview, frxClass, frxDBSet, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.Buttons, frxExportBaseDialog, frxExportPDF,
  dmReports,
  System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan,
  Vcl.WinXCtrls, Vcl.WinXCalendars, Vcl.VirtualImage;

type

  TScoreMode = (smNOTASSIGNED, smABSEvent, smABSHeat, smRELEvent, smRELHeat);
  TCalcMode = (cmNOTASSIGNED, cmStartOfSeason, cmStartOfSession, cmCustomDT);

  TLeaderBoard = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    btnABSREL_A: TButton;
    frxPreview1: TfrxPreview;
    Label4: TLabel;
    Label9: TLabel;
    btnABSREL_B: TButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    VirtualImageList2: TVirtualImageList;
    spbMemberScores: TSpeedButton;
    spbHouseScores: TSpeedButton;
    spbEventScores: TSpeedButton;
    sbtnRefresh: TSpeedButton;
    spbPrintReport: TSpeedButton;
    spbExportPDF: TSpeedButton;
    ActionManager1: TActionManager;
    actnRefresh: TAction;
    actnPrint: TAction;
    actnExportPDF: TAction;
    DBtxtSwimClubCaption: TDBText;
    DBtxtSwimClubNickName: TDBText;
    qryLBHeader: TFDQuery;
    dsLBHeader: TDataSource;
    RelativePanel1: TRelativePanel;
    StatusBar1: TStatusBar;
    lblSessionCaption: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    cbxSession: TComboBox;
    cbxCalcEntrantAge: TComboBox;
    cbxCalcByEvent: TComboBox;
    cbxCalcRange: TComboBox;
    cbxCalcRelative: TComboBox;
    calDateFrom: TCalendarPicker;
    calDateTo: TCalendarPicker;
    calAgeSeedDate: TCalendarPicker;
    qrySession: TFDQuery;
    dsSession: TDataSource;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnPrintSetup: TButton;
    DBtxtStartOfSwimmingSeason: TDBText;
    procedure FormCreate(Sender: TObject);
    procedure actnExportPDFExecute(Sender: TObject);
    procedure actnExportPDFUpdate(Sender: TObject);
    procedure actnPrintExecute(Sender: TObject);
    procedure actnPrintUpdate(Sender: TObject);
    procedure actnRefreshExecute(Sender: TObject);
    procedure actnRefreshUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure spbGenericSPBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxSessionChange(Sender: TObject);
    procedure btnPrintSetupClick(Sender: TObject);
    procedure btnABSREL_AClick(Sender: TObject);
    procedure btnABSREL_BClick(Sender: TObject);

    // procedure FormDestroy(Sender: TObject);
    // procedure btnUpdateClick(Sender: TObject);

  private
    { Private declarations }
    fConnection: TFDConnection;
    fSwimClubID: integer;
    // CORE PARAMS
    fSessionID: integer;
    fScoreMode: TScoreMode;
    fCalcModeEntrantAge: TCalcMode;
    fCalcModeRange: TCalcMode;

    // CONVERT FROM COMPONENT TO ENUM AND VISA-VERSA
    function CnvCBXtoScoreMode(): TScoreMode;
    function CnvEntrantAgetoCalcMode(): TCalcMode;
    function CnvRangetoCalcMode(): TCalcMode;
    procedure CnvScoreModeToCBX(Value: TScoreMode);
    procedure CnvCalcModeToEntrantAge(Value: TCalcMode);
    procedure CnvCalcModeToRange(Value: TCalcMode);

    procedure WritePreferences(iniFileName: string);
    procedure ReadPreferences(iniFileName: string);
    procedure ClearSpeedBtnGroup2;

    procedure BuildSessionComboBox(SwimClubID: integer);
    procedure ClearSessionComboBox();
    procedure SyncCoreParamsToUI;
    procedure SyncUItoCoreParams;

    // TcmbxObj lookup value.
    function GetObjSessionID(): integer;
    function GetObjSessionStart(): TDateTime;
    function GetObjSessionCaption(): string;

  public
    { Public declarations }
    property Connection: TFDConnection write fConnection;
    property SessionID: integer write fSessionID;
  end;

type
  TcmbxObj = class(TObject)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    SessionID, SwimClubID: integer;
    SessionStart: TDateTime;
    Caption: string;
  end;

var
  LeaderBoard: TLeaderBoard;

implementation

{$R *.dfm}

uses SCMUtility, iniFiles, UITypes;

// ----------------------------------------------------
// A C T I O N S . . . .
// ----------------------------------------------------
{$REGION 'ACTIONS'}

procedure TLeaderBoard.actnExportPDFExecute(Sender: TObject);
var
  rpt: TfrxReport;
begin
  if Assigned(RPTS) AND Assigned(frxPreview1) then
  begin
    rpt := frxPreview1.Report;
    if Assigned(rpt) then
      RPTS.ExportReportToPDF(rpt); // export to PDF
  end;
end;

procedure TLeaderBoard.actnExportPDFUpdate(Sender: TObject);
begin
  if frxPreview1.Visible then
    TAction(Sender).Enabled := true
  else
    TAction(Sender).Enabled := false;
end;

procedure TLeaderBoard.actnPrintExecute(Sender: TObject);
var
  rpt: TfrxReport;
begin
  if Assigned(RPTS) AND Assigned(frxPreview1) then
  begin
    rpt := frxPreview1.Report;
    RPTS.PrintReport(rpt);
  end;
end;

procedure TLeaderBoard.actnPrintUpdate(Sender: TObject);
begin
  if frxPreview1.Visible then
    TAction(Sender).Enabled := true
  else
    TAction(Sender).Enabled := false;
end;

procedure TLeaderBoard.actnRefreshExecute(Sender: TObject);
var
  rpt: TfrxReport;
begin
  // identify the current report being viewed, re-prepare and preview.
  if Assigned(RPTS) AND Assigned(frxPreview1) then
  begin
    rpt := frxPreview1.Report;
    if Assigned(rpt) then
    begin
      rpt.PrepareReport;
      rpt.ShowPreparedReport;
    end;
  end;
end;

procedure TLeaderBoard.actnRefreshUpdate(Sender: TObject);
begin
  if frxPreview1.Visible then
    TAction(Sender).Enabled := true
  else
    TAction(Sender).Enabled := false;
end;

procedure TLeaderBoard.btnPrintSetupClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TLeaderBoard.btnABSREL_AClick(Sender: TObject);
begin
  // note : uses RPTS.qryRptHeader
  fSessionID := GetObjSessionID;
	if Assigned(RPTS) and (fSessionID > 0) then
    RPTS.ABSREL_A(fSessionID);
end;

procedure TLeaderBoard.btnABSREL_BClick(Sender: TObject);
begin
  // note : uses RPTS.qryRptHeader
  fSessionID := GetObjSessionID;
	if Assigned(RPTS) and (fSessionID > 0) then
    RPTS.ABSREL_B(fSessionID);
end;

{$ENDREGION}

procedure TLeaderBoard.BuildSessionComboBox(SwimClubID: integer);
var
  SessionStartStr: string;
  obj: TcmbxObj;

begin
  if (fSwimClubID > 0) and Assigned(fConnection) then
  begin
    // CALL MS SQLEXPRESS AND PULL SESSIONS
    qrySession.Connection := fConnection;
    qrySession.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    qrySession.Prepare();
    qrySession.Open();
    if qrySession.Active then
    begin
      with qrySession do
      begin
        while not EOF do
        begin
          SessionStartStr := FormatDateTime('dd/mm/yy HH:nn',
            FieldByName('SessionStart').AsDateTime);
          obj := TcmbxObj.create;
          obj.SessionID := FieldByName('SessionID').AsInteger;
          obj.SwimClubID := FieldByName('SwimClubID').AsInteger;
          obj.SessionStart := FieldByName('SessionStart').AsDateTime;
          obj.Caption := FieldByName('Caption').AsString;
          cbxSession.Items.AddObject(SessionStartStr, obj);
          Next;
        end;
      end;
      qrySession.Close();
    end;
  end;

end;

procedure TLeaderBoard.cbxSessionChange(Sender: TObject);
var
  obj: TcmbxObj;
begin
  if cbxSession.ItemIndex = -1 then
  begin
    fSessionID := 0;
  end
  else
  begin
    obj := TcmbxObj(cbxSession.Items.Objects[cbxSession.ItemIndex]);
    if Assigned(obj) then
    begin
      fSessionID := obj.SessionID;
      lblSessionCaption.Caption := obj.Caption;
    end;
  end;
end;

procedure TLeaderBoard.ClearSessionComboBox;
var
  i: integer;
begin
  for i := 0 to cbxSession.Items.Count - 1 do
  begin
    if Assigned(cbxSession.Items.Objects[i]) then
    begin
      FreeAndNil(cbxSession.Items.Objects[i]);
    end;
  end;
end;

procedure TLeaderBoard.SyncCoreParamsToUI;
var
  obj: TcmbxObj;
begin
  // ----------------------------------------------------
  // S Y N C   C O R E   P A R A M S   T O   U I .
  // ----------------------------------------------------
  fScoreMode := CnvCBXtoScoreMode;
  fCalcModeEntrantAge := CnvEntrantAgetoCalcMode;
  fCalcModeRange := CnvRangetoCalcMode;
  fSessionID := 0;
  if cbxSession.ItemIndex <> -1 then
  begin
    obj := TcmbxObj(cbxSession.Items.Objects[cbxSession.ItemIndex]);
    if Assigned(obj) then
    begin
      fSessionID := obj.SessionID;
    end;
  end;
end;

procedure TLeaderBoard.SyncUItoCoreParams;
var
  i: integer;
  obj: TcmbxObj;
begin
  // ----------------------------------------------------
  // S Y N C   U I   T O  C O R E   P A R A M S .
  // ----------------------------------------------------
  CnvScoreModeToCBX(fScoreMode);
  CnvCalcModeToEntrantAge(fCalcModeEntrantAge);
  CnvCalcModeToRange(fCalcModeRange);
  for i := 0 to cbxSession.Items.Count - 1 do
  begin
    obj := TcmbxObj(cbxSession.Items.Objects[i]);
    if obj.SessionID = fSessionID then
    begin
      // assigning itemindex doesn't call cbxSession.OnChange
      cbxSession.ItemIndex := i;
      // REQUIRED ...
      lblSessionCaption.Caption := obj.Caption;
      break;
    end;
  end;
end;

procedure TLeaderBoard.ClearSpeedBtnGroup2;
var
  idx: integer;
  cmp: TComponent;
begin
  for idx := 0 to ComponentCount - 1 do
  begin
    cmp := Components[idx];
    if cmp.ClassName = 'TSpeedButton' then
    begin
      if TSpeedButton(cmp).GroupIndex = 2 then
      begin
        if TSpeedButton(cmp).Down then
          TSpeedButton(cmp).Down := false;
      end;
    end;
  end;
end;

procedure TLeaderBoard.CnvScoreModeToCBX(Value: TScoreMode);
begin
  // ABS 0 ; EVENT 1
  case Value of
    smABSEvent:
      begin
        cbxCalcByEvent.ItemIndex := 1;
        cbxCalcRelative.ItemIndex := 0
      end;
    smRELEvent:
      begin
        cbxCalcByEvent.ItemIndex := 1;
        cbxCalcRelative.ItemIndex := 1;
      end;
    smRELHeat:
      begin
        cbxCalcByEvent.ItemIndex := 0;
        cbxCalcRelative.ItemIndex := 1;
      end;
    smABSHeat:
      begin
        cbxCalcByEvent.ItemIndex := 0;
        cbxCalcRelative.ItemIndex := 0;
      end;
  else
    begin
      cbxCalcByEvent.ItemIndex := -1;
      cbxCalcRelative.ItemIndex := -1;
    end;

  end;
end;

procedure TLeaderBoard.CnvCalcModeToEntrantAge(Value: TCalcMode);
begin
  case Value of
    cmNOTASSIGNED:
      cbxCalcEntrantAge.ItemIndex := -1;
    cmStartOfSeason:
      cbxCalcEntrantAge.ItemIndex := 0;
    cmStartOfSession:
      cbxCalcEntrantAge.ItemIndex := 1;
    cmCustomDT:
      cbxCalcEntrantAge.ItemIndex := 2;
  else
    cbxCalcEntrantAge.ItemIndex := -1;
  end;
end;

procedure TLeaderBoard.CnvCalcModeToRange(Value: TCalcMode);
begin
  case Value of
    cmNOTASSIGNED:
      cbxCalcRange.ItemIndex := -1;
    cmStartOfSeason:
      cbxCalcRange.ItemIndex := 0;
    cmStartOfSession:
      cbxCalcRange.ItemIndex := 1;
    cmCustomDT:
      cbxCalcRange.ItemIndex := 2;
  else
    cbxCalcRange.ItemIndex := -1
  end;
end;

function TLeaderBoard.CnvCBXtoScoreMode: TScoreMode;
begin
  // enum ScoreMode {ABSEvent, ABSHeat, RELEvent, RELHeat, smERROR};
  // ABS 0 ; EVENT 1
  result := smNOTASSIGNED;
  if (cbxCalcByEvent.ItemIndex = 1) and (cbxCalcRelative.ItemIndex = 0) then
    result := smABSEvent;
  if (cbxCalcByEvent.ItemIndex = 0) and (cbxCalcRelative.ItemIndex = 0) then
    result := smABSHeat;
  if (cbxCalcByEvent.ItemIndex = 1) and (cbxCalcRelative.ItemIndex = 1) then
    result := smRELEvent;
  if (cbxCalcByEvent.ItemIndex = 0) and (cbxCalcRelative.ItemIndex = 1) then
    result := smRELHeat;
end;

function TLeaderBoard.CnvEntrantAgetoCalcMode: TCalcMode;
begin
  case cbxCalcEntrantAge.ItemIndex of
    0:
      result := cmStartOfSeason;
    1:
      result := cmStartOfSession;
    2:
      result := cmCustomDT;
  else
    result := cmNOTASSIGNED
  end;
end;

function TLeaderBoard.CnvRangetoCalcMode: TCalcMode;
begin
  case cbxCalcRange.ItemIndex of
    0:
      result := cmStartOfSeason;
    1:
      result := cmStartOfSession;
    2:
      result := cmCustomDT;
  else
    result := cmNOTASSIGNED
  end;

end;

procedure TLeaderBoard.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
  i: integer;
begin
  iFile := TIniFile.create(iniFileName);
  // --------------------------------------
  // C O R E   P A R A M S .
  // --------------------------------------
  // Determines what seed-date is used to calculate the age of entrants.
  i := iFile.ReadInteger('LeaderBoard', 'CalcModeEntrantAge',
    integer(TCalcMode(cmNOTASSIGNED)));
  if (i >= Ord(Low(TCalcMode))) and (i <= Ord(High(TCalcMode))) then
    fCalcModeEntrantAge := TCalcMode(i)
  else
    fCalcModeEntrantAge := cmNOTASSIGNED;
  // Determines what range used to calculate the scores.
  // ie. the swimming season (start of sesaon to  selected session - inclusive)
  // or ... selected session.
  i := iFile.ReadInteger('LeaderBoard', 'CalcModeSessionRange',
    integer(TCalcMode(cmNOTASSIGNED)));
  if (i >= Ord(Low(TCalcMode))) and (i <= Ord(High(TCalcMode))) then
    fCalcModeRange := TCalcMode(i)
  else
    fCalcModeRange := cmNOTASSIGNED;
  // Determines the method for scoring ... ABSOLUTE, RELATIVE - EVENT, HEAT
  i := iFile.ReadInteger('LeaderBoard', 'ScoreMode',
    integer(TScoreMode(smNOTASSIGNED)));
  if (i >= Ord(Low(TScoreMode))) and (i <= Ord(High(TScoreMode))) then
    fScoreMode := TScoreMode(i)
  else
    fScoreMode := smNOTASSIGNED;
  fSessionID := iFile.ReadInteger('LeaderBoard', 'SessionID', 0);

  // CUSTOM DATE RANGES
  calDateFrom.Date := iFile.ReadDate('LeaderBoard', 'DateFrom', Date);
  calDateTo.Date := iFile.ReadDate('LeaderBoard', 'DateTo', Date);
  calAgeSeedDate.Date := iFile.ReadDate('LeaderBoard', 'AgeSeedDate', Date);

  iFile.Free;
end;

procedure TLeaderBoard.spbGenericSPBtnClick(Sender: TObject);
var
  ERR: TRtnError;
  iniFileName: string;
begin
  ERR := TRtnError.reNONE;
  if Assigned(RPTS) then
  begin
    if TSpeedButton(Sender).Down then
    // Enable RPTS preview and display report.
    begin
      RPTS.Preview := frxPreview1;
      if Assigned(fConnection) and Assigned(RPTS) then
      begin
        // -----------------------------------------------
        // write preference - used by reports
        // -----------------------------------------------
        SyncCoreParamsToUI;
        iniFileName := GetSCMPreferenceFileName();
        if FileExists(iniFileName) then
          WritePreferences(iniFileName);
        // -----------------------------------------------
        // C A L L   R E P O R T .
        // -----------------------------------------------
        case TSpeedButton(Sender).Tag of
          1: // MEMBER'S TOTALSCORE, Distance-Stroke.SubTotal
            ERR := RPTS.MemberScores;
          2: // EVENTS
            ERR := RPTS.EventScores;
          3: // ACCUMALATIVE HOUSE SCORES
            ERR := RPTS.HouseScores;
        end;
        case ERR of
          reNONE:
            ;
          reNoSessions:
            MessageDlg('No session found for the given range.',
              TMsgDlgType.mtInformation, [mbOk], 0);
          reSystem:
            MessageDlg('Unknown report display error.',
              TMsgDlgType.mtInformation, [mbOk], 0);
          reNotAssigned:
            MessageDlg('Missing preference, option not assigned.',
              TMsgDlgType.mtInformation, [mbOk], 0);
        end;
      end;
      // was an error found?
      if ERR <> TRtnError.reNONE then
      begin
        frxPreview1.Visible := false;
        ClearSpeedBtnGroup2;
      end
      else
        frxPreview1.Visible := true;
    end
    else
    // Disable RPTS preview and hide.
    begin
      frxPreview1.Visible := false;
      ClearSpeedBtnGroup2;
    end;
  end;
end;

procedure TLeaderBoard.FormCreate(Sender: TObject);
var
  iniFileName: string;
begin
  // ----------------------------------------------------
  // C R E A T E   D A T A M O D U L E   R P T S .
  // ----------------------------------------------------
  RPTS := TRPTS.create(Self);
  if not Assigned(RPTS) then
  begin
    MessageDlg('The FastReport data module couldn''t be created!', mtError,
      [mbOk], 0);
    Application.Terminate;
    Exit;
  end;
  // ----------------------------------------------------
  // I N I T I A L I Z E   P A R A M S .
  // ----------------------------------------------------
  Application.ShowHint := true; // Enable hints.
  fSwimClubID := 1; // Always 1
  fConnection := nil; // route to SCM.scmConnection
  fSessionID := 0; // current selected session.
  RPTS.Preview := nil; // FastReports preview component.
  // INIT CORE PARAMS
  fScoreMode := smNOTASSIGNED;
  fCalcModeEntrantAge := cmNOTASSIGNED;
  fCalcModeRange := cmNOTASSIGNED;
  // INIT UI PARAMS
  cbxSession.ItemIndex := -1;
  lblSessionCaption.Caption := '';
  frxPreview1.Visible := false;
  StatusBar1.Panels[0].Text := ''; // Msg.Errors

  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // r e a d   c o r e   p a r a m s .
  // ----------------------------------------------------
  iniFileName := Scmutility.GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName);
  PageControl1.TabIndex := 0;

end;

procedure TLeaderBoard.FormDestroy(Sender: TObject);
var
  iniFileName: string;
begin
  SyncCoreParamsToUI;
  iniFileName := GetSCMPreferenceFileName();
  if FileExists(iniFileName) then
    WritePreferences(iniFileName);

  // Clear the Session ComboBox of objects associated with but
  // not owned in the 'Items' TStrings param.
  ClearSessionComboBox;

  // de-activate RPTS (FastReport)
  if Assigned(RPTS) then
  begin
    FreeAndNil(RPTS);
  end;
end;

procedure TLeaderBoard.FormShow(Sender: TObject);
begin
  if not Assigned(fConnection) then
  begin
    StatusBar1.Panels[0].Text := 'Error : SCM connection route not given.';
    Exit;
  end;
  // Set prop.connection + activate report tables and queries
  RPTS.Connection := fConnection;
  // Build a list swimming sessions
  BuildSessionComboBox(fSwimClubID);
  // ----------------------------------------------------
  // S Y N C   U I   T O  C O R E   P A R A M S .
  // ----------------------------------------------------
  SyncUItoCoreParams;
  // ----------------------------------------------------
  // D I S P L A Y   H E A D E R   I N F O .
  // ----------------------------------------------------
  qryLBHeader.Connection := fConnection;
  qryLBHeader.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
  qryLBHeader.Prepare;
  qryLBHeader.Open;
  if qryLBHeader.Active then
  begin
    DBtxtSwimClubCaption.DataSource := dsLBHeader;
    DBtxtSwimClubNickName.DataSource := dsLBHeader;
    DBtxtStartOfSwimmingSeason.DataSource := dsLBHeader;
  end;
end;

function TLeaderBoard.GetObjSessionCaption: string;
var
  obj: TObject;
begin
  result := ''; // default.empty
  if cbxSession.ItemIndex <> -1 then
  begin
    obj := cbxSession.Items.Objects[cbxSession.ItemIndex];
    if Assigned(obj) then
      result := TcmbxObj(obj).Caption;
  end;
end;

function TLeaderBoard.GetObjSessionID: integer;
var
  obj: TObject;
begin
  result := 0; // default.0
  if cbxSession.ItemIndex <> -1 then
  begin
    obj := cbxSession.Items.Objects[cbxSession.ItemIndex];
    if Assigned(obj) then
      result := TcmbxObj(obj).SessionID;
  end;
end;

function TLeaderBoard.GetObjSessionStart: TDateTime;
var
  obj: TObject;
begin
  result := 0; // default.1899-12-30
  if cbxSession.ItemIndex <> -1 then
  begin
    obj := cbxSession.Items.Objects[cbxSession.ItemIndex];
    if Assigned(obj) then
      result := TcmbxObj(obj).SessionStart;
  end;
end;

procedure TLeaderBoard.WritePreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.create(iniFileName);
  // CORE PARAMS
  iFile.WriteInteger('LeaderBoard', 'CalcModeEntrantAge',
    integer(fCalcModeEntrantAge));
  iFile.WriteInteger('LeaderBoard', 'CalcModeSessionRange',
    integer(fCalcModeRange));
  iFile.WriteInteger('LeaderBoard', 'ScoreMode', integer(fScoreMode));
  iFile.WriteInteger('LeaderBoard', 'SessionID', fSessionID);
  // CUSTOM DATE RANGES
  iFile.WriteDate('LeaderBoard', 'DateFrom', calDateFrom.Date);
  iFile.WriteDate('LeaderBoard', 'DateTo', calDateTo.Date);
  iFile.WriteDate('LeaderBoard', 'AgeSeedDate', calAgeSeedDate.Date);

  iFile.Free;
end;

end.
