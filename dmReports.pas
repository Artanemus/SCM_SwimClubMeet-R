unit dmReports;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass,
  frxDBSet, frxPreview, frxExportBaseDialog, frxExportPDF;
  // dmSCM,

type

  TRtnError = (reNONE, reNoSessions, reSystem, reNotAssigned);
  TScoreMode = (smNOTASSIGNED, smABSEvent, smABSHeat, smRELEvent, smRELHeat);
  TCalcMode = (cmNOTASSIGNED, cmStartOfSeason, cmStartOfSession, cmCustomDT);

  TRPTS = class(TDataModule)
    qryRptHeader: TFDQuery;
    frxDBDSRptHeader: TfrxDBDataset;

    qryMemABS: TFDQuery;
    frxMemABS: TfrxReport;
    frxDSMemABS: TfrxDBDataset;
    qryMemREL: TFDQuery;
    frxDSMemREL: TfrxDBDataset;
    frxMemREL: TfrxReport;

    qryHouseABS: TFDQuery;
    DSHouseABS: TfrxDBDataset;
    frxHouseABS: TfrxReport;
    qryHouseREL: TFDQuery;
    DSHouseREL: TfrxDBDataset;
    frxHouseREL: TfrxReport;
    qrySessABS: TFDQuery;
    DSSessABS: TfrxDBDataset;
    frxSessABS: TfrxReport;
    frxSessREL: TfrxReport;
    qrySessREL: TFDQuery;
    DSSessREL: TfrxDBDataset;
    qryEventABS: TFDQuery;
    DSEventABS: TfrxDBDataset;
    frxEventABS: TfrxReport;
    frxEventREL: TfrxReport;
    qryEventREL: TFDQuery;
    DSEventREL: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxMemABSUno: TfrxReport;
    qryMemABSUno: TFDQuery;
    frxMemRELUno: TfrxReport;
    qryMemRELUno: TFDQuery;
    frxDSMemRELUno: TfrxDBDataset;
    qryGetSessionCount: TFDQuery;
    qryGetStartOfSession: TFDQuery;
    dsGetStartOfSession: TDataSource;
    qryABSREL_A: TFDQuery;
    frxDBABSREL_A: TfrxDBDataset;
    frxABSREL_A: TfrxReport;
    frxABSREL_B: TfrxReport;
    frxDBABSREL_B: TfrxDBDataset;
    qryABSREL_B: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure frxHouseABSBeforePrint(Sender: TfrxReportComponent);
    procedure frxHouseRELBeforePrint(Sender: TfrxReportComponent);
    procedure frxHouseRELHeatBeforePrint(Sender: TfrxReportComponent);
  private
    { Private declarations }
    fIsActive: Boolean;
    fPreview: TfrxPreview;

    fStartOfSwimmingSeason: TDateTime;
    fSessionID: integer;
    fSessionCount: integer;
    fScoreMode: TScoreMode;
    fCalcModeEntrantAge: TCalcMode;
    fCalcModeSessionRange: TCalcMode;
    fSwimClubID: integer;
    fAgeSeedDate: TDateTime;
    fCustomStartDT: TDateTime;
    fCustomEndDT: TDateTime;
    fIncludeLockedSession: Boolean;
    fConnection: TFDConnection;


    procedure setPreviewCntrl(const Value: TfrxPreview);
    procedure setEndlessHeight(report: TfrxReport; IsEndless: Boolean);
    procedure CloseAllQry();
    procedure ReadPreferences(iniFileName: string);
    procedure AssignRangeValues(var DTStart: TDateTime; var DTEnd: TDateTime);
    function GetConnection: TFDConnection;
    procedure SetConnection(const Value: TFDConnection);

    function GetSessionCount(SwimClubID: integer;
      SDate, EDate: TDateTime): integer;
    function GetStartOfSession(SessionID: integer): TDateTime;

  public
    { Public declarations }
    function MemberScores(): TRtnError;
    function HouseScores(): TRtnError;
    function EventScores(): TRtnError;

    // PRINTING AND EXPORTING PDF ETC
    procedure PrintReport(rpt: TfrxReport);
    procedure ExportReportToPDF(rpt: TfrxReport);
    procedure ABSREL_A(SessionID: Integer);
    procedure ABSREL_B(SessionID: Integer);

    property IsActive: Boolean read fIsActive;
    property Preview: TfrxPreview read fPreview write setPreviewCntrl;
property Connection: TFDConnection read GetConnection write SetConnection;
  end;

var
  RPTS: TRPTS;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TRPTS }

uses
  vcl.Forms, System.IniFiles, System.DateUtils, vcl.Dialogs, SCMUtility,
  System.UITypes;

procedure TRPTS.CloseAllQry;
begin
  // HEADER
  qryRptHeader.Close;
  // MEMBER
  qryMemABS.Close;
  qryMemREL.Close;
  qryMemABSUno.Close;
  // HOUSE
  qryHouseABS.Close;
  qryHouseREL.Close;
  // EVENT - MEMBER
  qryEventABS.Close;
  qryEventREL.Close;
  // SESSION
  qrySessABS.Close;
  qrySessREL.Close;

end;

procedure TRPTS.DataModuleCreate(Sender: TObject);
begin
  // I N I T I A L I Z E   P A R A M S  .
  fIsActive := False;
  fPreview := nil;
  fSwimClubID := 1;
end;

{$REGION '... EVENT SCORES'}

function TRPTS.EventScores: TRtnError;
var
  rpt: TfrxReport;
  qry: TFDQuery;
  DoEvent: Boolean;
  iniFileName, RangeStr, ModeStr, ModeSubStr: String;
  DTStart, DTEnd: TDateTime;
begin
  qry := nil;
  rpt := nil;
  DoEvent := True;
  RangeStr := '';
  ModeStr := '';
  ModeSubStr := '';
  result := TRtnError.reNONE;

  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // reload all of the user settings.
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName)
  else
  begin
    // SCM SYSTEM ERROR : The preference file couldn't be created.
    MessageDlg('An unexpected SCM error occurred.' + sLineBreak +
      'Unable to read the LeaderBoard ini file!' + sLineBreak +
      'The application will terminate!', mtError, [mbOk], 0);
    Exit;
  end;
  // ----------------------------------------------------
  // ASSIGN QUALIFIED RANGE VALUES (ADJUST CEIL/FLOOR)
  // Adjustments are required else ranges are not 'inclusive'
  // ----------------------------------------------------
  AssignRangeValues(DTStart, DTEnd);
  // ----------------------------------------------------
  // SESSION COUNT - UNO reports used count = 1
  // ----------------------------------------------------
  fSessionCount := GetSessionCount(fSwimClubID, DTStart, DTEnd);

  if fSessionCount = 0 then
  begin
    result := TRtnError.reNoSessions;
    Exit;
  end;

  // S T R I N G   A S S I G N M E N T  -  FOR HEADER BAR
  // ----------------------------------------------------
  if fSessionCount = 1 then
  begin
    RangeStr := 'Scores given on session: ' +
      FormatDateTime('dd/mm/yyyy', DTStart);
    ModeSubStr := 'Event Scores';
  end
  else
  begin
    RangeStr := 'Scores given on range: ' + FormatDateTime('dd/mm/yyyy',
      DTStart) + ' - ' + FormatDateTime('dd/mm/yyyy', DTEnd) +
      ' (Session Count: ' + IntToStr(fSessionCount) + ')';
    ModeSubStr := 'Accumulative Event Scores';
  end;
  // Calculation mode string
  if fScoreMode in [smABSEvent, smABSHeat] then
    ModeStr := 'Place given on ABSOLUTE for each '
  else
    ModeStr := 'Place given on RELATIVE TO DIVISION for each ';

  if fScoreMode in [smABSEvent, smRELEvent] then
    ModeStr := ModeStr + 'EVENT'
  else
    ModeStr := ModeStr + 'HEAT';

  // -----------------------------------------------------------
  // R A N G E   -   S I N G L E . . M U L T I    S E S S I O N   . . .
  // -----------------------------------------------------------
  case fScoreMode of
    smNOTASSIGNED:
      begin
        result := TRtnError.reNotAssigned;
        Exit;
      end;
    smABSEvent, smABSHeat:
      begin
        qry := qryEventABS;
        rpt := frxEventABS;
      end;
    smRELEvent, smRELHeat:
      begin
        qry := qryEventREL;
        rpt := frxEventREL;
      end;
  end;

  if Assigned(qry) then
  begin
    if not Assigned(qryRptHeader.Connection) then
      qryRptHeader.Connection := fConnection;
    qryRptHeader.Close;
    qryRptHeader.ParamByName('RANGESTR').AsString := RangeStr;
    qryRptHeader.ParamByName('MODESTR').AsString := ModeStr;
    qryRptHeader.ParamByName('MODESUBSTR').AsString := ModeSubStr;
    qryRptHeader.Prepare;
    qryRptHeader.Open;

    if not Assigned(qry.Connection) then
      qry.Connection := fConnection;
    qry.Close;
    // Floor and ceiling (for dates) set prior to calling here.
    qry.ParamByName('DTSTART').AsDateTime := DTStart;
    qry.ParamByName('DTEND').AsDateTime := DTEnd;
    qry.ParamByName('DOEVENT').AsBoolean := DoEvent;
    qry.ParamByName('DOLOCKEDSESSION').AsBoolean := fIncludeLockedSession;
    if fScoreMode in [smRELEvent, smRELHeat] then
      qry.ParamByName('AGESEEDDATE').AsDateTime := fAgeSeedDate;
    qry.Prepare;
    qry.Open;
    // -----------------------------------------------------------
    // P R E V I E W   T H E   R E P O R T   . . .
    // -----------------------------------------------------------
    if (qry.Active) AND Assigned(fPreview) and Assigned(rpt) then
    begin
      rpt.Preview := fPreview;
      setEndlessHeight(rpt, True);
      if (rpt.PrepareReport(True)) then
        rpt.ShowPreparedReport();
    end
    else
      result := TRtnError.reSystem;
  end;

end;

{$ENDREGION}

procedure TRPTS.ExportReportToPDF(rpt: TfrxReport);
begin
  if Assigned(rpt) then
  begin
    // frxSetHeaderVisibility(rpt, true);
    setEndlessHeight(rpt, True);
    rpt.PrepareReport();
    rpt.ReportOptions.Author := 'SwimClubMeet (SCM)';
    rpt.ReportOptions.Description.Clear;
    rpt.ReportOptions.Description.Add('LeaderBoard Data');
    rpt.ReportOptions.Name := 'SCM_LeaderBoard';
    rpt.Export(frxPDFExport1);
    // frxSetHeaderVisibility(rpt, false);
    setEndlessHeight(rpt, True);
    rpt.PrepareReport(); // export to PDF
    rpt.ShowPreparedReport();
  end;
end;

{$REGION '... SESSION SCORES'}
{$ENDREGION}
{$REGION 'frxBeforePrint - HOUSE COLORS'}

procedure TRPTS.frxHouseABSBeforePrint(Sender: TfrxReportComponent);
var
  shape: TfrxShapeView;
begin
  if (Sender.Name = 'Shape2') then
  begin
    shape := TfrxShapeView(Sender);
    shape.Color := DSHouseABS.DataSet.FieldByName('Color').AsInteger;
  end;
end;

procedure TRPTS.frxHouseRELBeforePrint(Sender: TfrxReportComponent);
var
  shape: TfrxShapeView;
begin
  if (Sender.Name = 'Shape2') then
  begin
    shape := TfrxShapeView(Sender);
    shape.Color := DSHouseREL.DataSet.FieldByName('Color').AsInteger;
  end;
end;

procedure TRPTS.frxHouseRELHeatBeforePrint(Sender: TfrxReportComponent);
begin
end;

{$ENDREGION}

function TRPTS.GetConnection: TFDConnection;
begin
  result := fConnection;
end;

function TRPTS.GetSessionCount(SwimClubID: integer; SDate,
  EDate: TDateTime): integer;
begin
  result := 0;
  if Assigned(fConnection) then
  begin
  qryGetSessionCount.Connection := fConnection;
  qryGetSessionCount.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
  qryGetSessionCount.ParamByName('SDATE').AsDateTime := SDate;
  qryGetSessionCount.ParamByName('EDATE').AsDateTime := EDate;
  qryGetSessionCount.Prepare;
  qryGetSessionCount.Open;
  if qryGetSessionCount.Active then
  begin
    if not qryGetSessionCount.IsEmpty then
    begin
      result := qryGetSessionCount.FieldByName('SessionCount').AsInteger;
    end;
  end;end;
end;

function TRPTS.GetStartOfSession(SessionID: integer): TDateTime;
begin
  result := Date;
  qryGetStartOfSession.Connection := fConnection;
  qryGetStartOfSession.ParamByName('SESSIONID').AsInteger := SessionID;
  qryGetStartOfSession.Prepare;
  qryGetStartOfSession.Open;
  if qryGetStartOfSession.Active then
  begin
    if not qryGetStartOfSession.IsEmpty then
    begin
      result := qryGetStartOfSession.FieldByName('SessionStart').AsDateTime;
    end;
  end;
end;

{$REGION '... HOUSE SCORES'}

function TRPTS.HouseScores(): TRtnError;
var
  rpt: TfrxReport;
  qry: TFDQuery;
  DoEvent: Boolean;
  iniFileName, RangeStr, ModeStr, ModeSubStr: String;
  DTStart, DTEnd: TDateTime;
begin
  qry := nil;
  rpt := nil;
  DoEvent := True;
  RangeStr := '';
  ModeStr := '';
  ModeSubStr := '';
  result := TRtnError.reNONE;

  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // reload all of the user settings.
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName)
  else
  begin
    // SCM SYSTEM ERROR : The preference file couldn't be created.
    MessageDlg('An unexpected SCM error occurred.' + sLineBreak +
      'Unable to read the LeaderBoard ini file!' + sLineBreak +
      'The application will terminate!', mtError, [mbOk], 0);
    Exit;
  end;
  // ----------------------------------------------------
  // ASSIGN QUALIFIED RANGE VALUES (ADJUST CEIL/FLOOR)
  // Adjustments are required else ranges are not 'inclusive'
  // ----------------------------------------------------
  AssignRangeValues(DTStart, DTEnd);
  // ----------------------------------------------------
  // SESSION COUNT - UNO reports used count = 1
  // ----------------------------------------------------
  fSessionCount := GetSessionCount(fSwimClubID, DTStart, DTEnd);

  if fSessionCount = 0 then
  begin
    result := TRtnError.reNoSessions;
    Exit;
  end;

  // S T R I N G   A S S I G N M E N T  -  FOR HEADER BAR
  // ----------------------------------------------------
  if fSessionCount = 1 then
  begin
    RangeStr := 'Scores given on session: ' +
      FormatDateTime('dd/mm/yyyy', DTStart);
    ModeSubStr := 'Accumulative House Scores';
  end
  else
  begin
    RangeStr := 'Scores given on range: ' + FormatDateTime('dd/mm/yyyy',
      DTStart) + ' - ' + FormatDateTime('dd/mm/yyyy', DTEnd) +
      ' (Session Count: ' + IntToStr(fSessionCount) + ')';
    ModeSubStr := 'Accumulative House Scores';
  end;
  // Calculation mode string
  if fScoreMode in [smABSEvent, smABSHeat] then
    ModeStr := 'Place given on ABSOLUTE for each '
  else
    ModeStr := 'Place given on RELATIVE TO DIVISION for each ';

  if fScoreMode in [smABSEvent, smRELEvent] then
    ModeStr := ModeStr + 'EVENT'
  else
    ModeStr := ModeStr + 'HEAT';

  // -----------------------------------------------------------
  // R A N G E   -   S I N G L E . . M U L T I    S E S S I O N   . . .
  // -----------------------------------------------------------
  case fScoreMode of
    smNOTASSIGNED:
      begin
        result := TRtnError.reNotAssigned;
        Exit;
      end;
    smABSEvent, smABSHeat:
      begin
        qry := qryHouseABS;
        rpt := frxHouseABS;
      end;
    smRELEvent, smRELHeat:
      begin
        qry := qryHouseREL;
        rpt := frxHouseREL;
      end;
  end;

  if Assigned(qry) then
  begin
    if not Assigned(qryRptHeader.Connection) then
      qryRptHeader.Connection := fConnection;
    qryRptHeader.Close;
    qryRptHeader.ParamByName('RANGESTR').AsString := RangeStr;
    qryRptHeader.ParamByName('MODESTR').AsString := ModeStr;
    qryRptHeader.ParamByName('MODESUBSTR').AsString := ModeSubStr;
    qryRptHeader.Prepare;
    qryRptHeader.Open;

    if not Assigned(qry.Connection) then
      qry.Connection := fConnection;
    qry.Close;
    // Floor and ceiling (for dates) set prior to calling here.
    qry.ParamByName('DTSTART').AsDateTime := DTStart;
    qry.ParamByName('DTEND').AsDateTime := DTEnd;
    qry.ParamByName('DOEVENT').AsBoolean := DoEvent;
    qry.ParamByName('DOLOCKEDSESSION').AsBoolean := fIncludeLockedSession;
    if fScoreMode in [smRELEvent, smRELHeat] then
      qry.ParamByName('AGESEEDDATE').AsDateTime := fAgeSeedDate;
    qry.Prepare;
    qry.Open;
    // -----------------------------------------------------------
    // P R E V I E W   T H E   R E P O R T   . . .
    // -----------------------------------------------------------
    if (qry.Active) AND Assigned(fPreview) and Assigned(rpt) then
    begin
      rpt.Preview := fPreview;
      setEndlessHeight(rpt, True);
      if (rpt.PrepareReport(True)) then
        rpt.ShowPreparedReport();
    end
    else
      result := TRtnError.reSystem;
  end;

end;

{$ENDREGION}
{$REGION '... MEMBER SCORE'}

function TRPTS.MemberScores(): TRtnError;
var
  rpt: TfrxReport;
  qry: TFDQuery;
  DoEvent: Boolean;
  iniFileName, RangeStr, ModeStr, ModeSubStr: String;
  DTStart, DTEnd: TDateTime;
begin
  qry := nil;
  rpt := nil;
  DoEvent := True;
  RangeStr := '';
  ModeStr := '';
  ModeSubStr := '';

  result := TRtnError.reNONE;

  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // reload all of the user settings.
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName)
  else
  begin
    // SCM SYSTEM ERROR : The preference file couldn't be created.
    MessageDlg('An unexpected SCM error occurred.' + sLineBreak +
      'Unable to read the LeaderBoard ini file!' + sLineBreak +
      'The application will terminate!', mtError, [mbOk], 0);
    Exit;
  end;
  // ----------------------------------------------------
  // ASSIGN QUALIFIED RANGE VALUES (ADJUST CEIL/FLOOR)
  // Adjustments are required else ranges are not 'inclusive'
  // ----------------------------------------------------
  AssignRangeValues(DTStart, DTEnd);
  // ----------------------------------------------------
  // SESSION COUNT - UNO reports used count = 1
  // ----------------------------------------------------
  fSessionCount := GetSessionCount(fSwimClubID, DTStart, DTEnd);

  if fSessionCount = 0 then
  begin
    result := TRtnError.reNoSessions;
    Exit;
  end;

  // S T R I N G   A S S I G N M E N T  -  FOR HEADER BAR
  // ----------------------------------------------------
  if fSessionCount = 1 then
  begin
    RangeStr := 'Scores given on session: ' +
      FormatDateTime('dd/mm/yyyy', DTStart);
    ModeSubStr := 'Stroke-Distance.Place.Score.Racetime';
  end
  else
  begin
    RangeStr := 'Scores given on range: ' + FormatDateTime('dd/mm/yyyy',
      DTStart) + ' - ' + FormatDateTime('dd/mm/yyyy', DTEnd) +
      ' (Session Count: ' + IntToStr(fSessionCount) + ')';
    ModeSubStr := 'Stroke-Distance.SubTotal';
  end;
  // Calculation mode string
  if fScoreMode in [smABSEvent, smABSHeat] then
    ModeStr := 'Place given on ABSOLUTE for each '
  else
    ModeStr := 'Place given on RELATIVE TO DIVISION for each ';

  if fScoreMode in [smABSEvent, smRELEvent] then
    ModeStr := ModeStr + 'EVENT'
  else
    ModeStr := ModeStr + 'HEAT';

  // -----------------------------------------------------------
  // R A N G E   -   S I N G L E   S E S S I O N   . . .
  // these reports have additional details (race-times, place, score)
  // R A N G E   -   M U L T I   S E S S I O N   . . .
  // -----------------------------------------------------------
  case fScoreMode of
    smNOTASSIGNED:
      begin
        result := TRtnError.reNotAssigned;
        Exit;
      end;
    smABSEvent:
      begin
        if fSessionCount = 1 then
        begin
          qry := qryMemABSUno;
          rpt := frxMemABSUno;
        end
        else
        begin
          qry := qryMemABS;
          rpt := frxMemABS;
        end;
      end;
    smABSHeat:
      begin
        if fSessionCount = 1 then
        begin
          qry := qryMemABSUno;
          DoEvent := False; // switch to heat
          rpt := frxMemABSUno;
        end
        else
        begin
          qry := qryMemABS;
          DoEvent := False; // switch to heat
          rpt := frxMemABS;
        end;
      end;
    smRELEvent:
      begin
        if fSessionCount = 1 then
        begin
          qry := qryMemRELUno;
          rpt := frxMemRELUno;;
        end
        else
        begin
          qry := qryMemREL;
          rpt := frxMemREL;
        end;
      end;
    smRELHeat:
      begin
        if fSessionCount = 1 then
        begin
          qry := qryMemRELUno;
          DoEvent := False; // switch to heat
          rpt := frxMemRELUno;
        end
        else
        begin
          qry := qryMemREL;
          DoEvent := False; // switch to heat
          rpt := frxMemREL;
        end;
      end;
  end;

  if Assigned(qry) then
  begin
    if not Assigned(qryRptHeader.Connection) then
      qryRptHeader.Connection := fConnection;
    qryRptHeader.Close;
    qryRptHeader.ParamByName('RANGESTR').AsString := RangeStr;
    qryRptHeader.ParamByName('MODESTR').AsString := ModeStr;
    qryRptHeader.ParamByName('MODESUBSTR').AsString := ModeSubStr;
    qryRptHeader.Prepare;
    qryRptHeader.Open;

    if not Assigned(qry.Connection) then
      qry.Connection := fConnection;
    qry.Close;
    // Floor and ceiling (for dates) set prior to calling here.
    qry.ParamByName('DTSTART').AsDateTime := DTStart;
    qry.ParamByName('DTEND').AsDateTime := DTEnd;
    qry.ParamByName('DOEVENT').AsBoolean := DoEvent;
    qry.ParamByName('DOLOCKEDSESSION').AsBoolean := fIncludeLockedSession;
    if fScoreMode in [smRELEvent, smRELHeat] then
      qry.ParamByName('AGESEEDDATE').AsDateTime := fAgeSeedDate;
    qry.Prepare;
    qry.Open;
    // -----------------------------------------------------------
    // P R E V I E W   T H E   R E P O R T   . . .
    // -----------------------------------------------------------
    if (qry.Active) AND Assigned(fPreview) and Assigned(rpt) then
    begin
      rpt.Preview := fPreview;
      setEndlessHeight(rpt, True);
      if (rpt.PrepareReport(True)) then
        rpt.ShowPreparedReport();
    end
    else
      result := TRtnError.reSystem;
  end;
end;

{$ENDREGION}

procedure TRPTS.PrintReport(rpt: TfrxReport);
begin
  if Assigned(rpt) then
  begin
    // SetHeaderVisibility(rpt, true);
    // SetFooterVisibility(rpt, true);
    if (rpt.Name = 'frxHouseABS') or (rpt.Name = 'frxHouseREL') then
      setEndlessHeight(rpt, True)
    else
      setEndlessHeight(rpt, False);
    rpt.PrepareReport();
    rpt.Print();
    // frxSetHeaderVisibility(rpt, false);
    // frxSetFooterVisibility(rpt, false);
    if (rpt.Name = 'frxHouseABS') or (rpt.Name = 'frxHouseREL') then
      setEndlessHeight(rpt, True)
    else
      setEndlessHeight(rpt, False);
    rpt.PrepareReport();
    rpt.ShowPreparedReport();
  end;

end;

procedure TRPTS.ABSREL_A(SessionID: Integer);
begin
  // note : uses RPTS.qryRptHeader
	if (SessionID > 0) then
  begin
    if not Assigned(qryRptHeader.Connection) then
      qryRptHeader.Connection := fConnection;
    if not  qryRptHeader. Active then
      qryRptHeader.Open;

    qryABSREL_A.Connection := fConnection;
    qryABSREL_A.ParamByName('SESSIONID').AsInteger := SessionID;
    qryABSREL_A.Prepare();
    qryABSREL_A.Open();
    if qryABSREL_A.Active then
    begin
      frxABSREL_A.PrepareReport();
      frxABSREL_A.ShowPreparedReport();
//        frxABSREL_A.ShowReport;
    end;
  end;
end;

procedure TRPTS.ABSREL_B(SessionID: Integer);
begin
  // note : uses RPTS.qryRptHeader
	if (SessionID > 0) then
  begin
    if not Assigned(qryRptHeader.Connection) then
      qryRptHeader.Connection := fConnection;
    if not  qryRptHeader. Active then
      qryRptHeader.Open;

    qryABSREL_B.Connection := fConnection;
    qryABSREL_B.ParamByName('SESSIONID').AsInteger := SessionID;
    qryABSREL_B.Prepare();
    qryABSREL_B.Open();
    if (qryABSREL_B.Active) then
      frxABSREL_B.ShowReport;
  end;
end;

procedure TRPTS.AssignRangeValues(var DTStart: TDateTime; var DTEnd: TDateTime);
begin
  DTStart := 0;
  DTEnd := 0;
  // CALCULATE THE RANGE   ADJUST - FLOOR/CEILING
  if Assigned(fConnection) then
  begin
    case fCalcModeSessionRange of
      cmNOTASSIGNED:
        ;
      cmStartOfSeason:
        begin
          DTStart := DateOf(fStartOfSwimmingSeason);
          DTEnd := DateOf(GetStartOfSession(fSessionID));
        end;
      cmStartOfSession:
        begin
          DTStart := GetStartOfSession(fSessionID);
          DTEnd := RecodeHour(DTStart, HourOf(DTStart) + 1);
        end;
      cmCustomDT:
        begin
          DTStart := DateOf(fCustomStartDT);
          DTEnd := DateOf(fCustomEndDT) + 1; // Midnight of the next day...
        end;
    end;
  end;
end;

procedure TRPTS.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
  i: integer;
begin
  fIncludeLockedSession := False;
  iFile := TIniFile.Create(iniFileName);
  // Determines what seed-date is used to calculate the age of entrants.
  i := iFile.ReadInteger('LeaderBoard', 'CalcModeEntrantAge',
    integer(TCalcMode(cmNOTASSIGNED)));
  if (i >= Ord(Low(TCalcMode))) and (i <= Ord(High(TCalcMode))) then
    fCalcModeEntrantAge := TCalcMode(i)
  else
    fCalcModeEntrantAge := cmNOTASSIGNED;
  // Determines what range used to gather up sessions.
  // ie. the swimming season (start of sesaon to  selected session - inclusive)
  // or ... selected session.
  i := iFile.ReadInteger('LeaderBoard', 'CalcModeSessionRange',
    integer(TCalcMode(cmNOTASSIGNED)));
  if (i >= Ord(Low(TCalcMode))) and (i <= Ord(High(TCalcMode))) then
    fCalcModeSessionRange := TCalcMode(i)
  else
    fCalcModeSessionRange := cmNOTASSIGNED;
  // Determines the method for scoring ... ABSOLUTE, RELATIVE - EVENT, HEAT
  i := iFile.ReadInteger('LeaderBoard', 'ScoreMode',
    integer(TScoreMode(smNOTASSIGNED)));
  if (i >= Ord(Low(TScoreMode))) and (i <= Ord(High(TScoreMode))) then
    fScoreMode := TScoreMode(i)
  else
    fScoreMode := smNOTASSIGNED;
  // Current selected session
  fSessionID := iFile.ReadInteger('LeaderBoard', 'SessionID', 0);
  // Custom seed-date used to determine the age of the member.
  fAgeSeedDate := iFile.ReadDate('LeaderBoard', 'AgeSeedDate', Date);
  // Select swimming sessions based on custom range.
  fCustomStartDT := iFile.ReadDate('LeaderBoard', 'DateFrom', 0);
  fCustomEndDT := iFile.ReadDate('LeaderBoard', 'DateTo', 0);

  // Miscellaneous options
  fIncludeLockedSession := iFile.ReadBool('LeaderBoard',
    'IncludeLockedSessions', False);

  iFile.Free;
end;

procedure TRPTS.SetConnection(const Value: TFDConnection);
begin
  fConnection := Value;
  // C O N N E C T .
  if Assigned(fConnection) then
  begin
    qryRptHeader.Connection := fConnection;
    qryRptHeader.Open;
    if qryRptHeader.Active then
      fIsActive := True;
    // MEMBER
    qryMemABS.Connection := fConnection;
    qryMemREL.Connection := fConnection;
    qryMemABSUno.Connection :=fConnection;
    qryMemRELUno.Connection := fConnection;
    // HOUSE
    qryHouseABS.Connection := fConnection;
    qryHouseREL.Connection := fConnection;
    // EVENT
    qryEventABS.Connection := fConnection;
    qryEventREL.Connection := fConnection;
    // CURRENT SESSION ONLY - USED BY AUTO-UPDATE
    qrySessABS.Connection := fConnection;
    qrySessREL.Connection := fConnection;
  end;

end;

procedure TRPTS.setEndlessHeight(report: TfrxReport; IsEndless: Boolean);
var
  page: TfrxReportPage;
begin
  page := TfrxReportPage(report.Pages[1]);
  page.EndlessHeight := IsEndless;
end;

procedure TRPTS.setPreviewCntrl(const Value: TfrxPreview);
begin
  fPreview := Value;
end;


// {region FRX ... SET FUNCTIONS}
// ---------------------------------------------------------------------------
// F R X . . .  F A S T   R E P O R T
// ---------------------------------------------------------------------------
//
// void TLeaderBoard::frxSetRowCount(TfrxReport* aReport)
// TfrxComponent* frxObj;
// frxObj = aReport->FindObject("MasterData1");
// if (frxObj != NULL) {
// if (LBOptions->spinedtRowCount->Value > 0)
// reinterpret_cast<TfrxMasterData*>(frxObj)->RowCount =
// LBOptions->spinedtRowCount->Value;
// else
// reinterpret_cast<TfrxMasterData*>(frxObj)->RowCount = 0;
//
// void TLeaderBoard::frxSetFooterVisibility(TfrxReport* report, bool IsVisible)
// TfrxComponent *frxComp;
// frxComp = report->FindObject("PageFooter1");
// if (frxComp != NULL)
// reinterpret_cast<TfrxPageFooter*>(frxComp)->Visible = IsVisible;
// }
//
// void TLeaderBoard::frxSetHeaderVisibility(TfrxReport* report, bool IsVisible)
// TfrxComponent *frxComp;
// frxComp = report->FindObject("PageHeader1");
// if (frxComp != NULL)
// reinterpret_cast<TfrxPageHeader*>(frxComp)->Visible = IsVisible;
//
// ---------------------------------------------------------------------------
// {end_region}

{ *
  DATA BASE VARIABLE....

  IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = 3) ,'EVENT','HEAT')

  INLINE ...
  // <IIF( [MemABS."GenderID"] = 1, 'XXX', 'YYYY')>

  * }

end.
