unit dmSCM;

interface

uses
  System.SysUtils, System.Classes, Windows, Winapi.Messages,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.VCLUI.Error, FireDAC.Comp.UI, SCMDefines;



type
  TSCM = class(TDataModule)
    dsFNameEllipse: TDataSource;
    dsIsQualified: TDataSource;
    dsNomateEvent: TDataSource;
    dsNominateControlList: TDataSource;
    dsNominateMembers: TDataSource;
    luDisqualifyCode: TDataSource;
    luEventStatus: TDataSource;
    luEventType: TDataSource;
    luFName: TDataSource;
    luGender: TDataSource;
    luHeatStatus: TDataSource;
    luHeatType: TDataSource;
    luHouse: TDataSource;
    luSessionStatus: TDataSource;
    qryCountEventsNotClosed: TFDQuery;
    qryCountHeatsNotClosed: TFDQuery;
    qryFName: TFDQuery;
    qryFNameEllipse: TFDQuery;
    qryGetNextHeat: TFDQuery;
    qryGetPrevHeat: TFDQuery;
    qryIsQualified: TFDQuery;
    qryIsQualifiedALT: TFDQuery;
    qryNominateControlList: TFDQuery;
    qryNominateControlListCaption: TWideStringField;
    qryNominateControlListDistanceID: TIntegerField;
    qryNominateControlListDistStrokeStr: TWideStringField;
    qryNominateControlListEventID: TFDAutoIncField;
    qryNominateControlListEventNum: TIntegerField;
    qryNominateControlListEventStatusID: TIntegerField;
    qryNominateControlListEventTypeID: TIntegerField;
    qryNominateControlListIsNominated: TBooleanField;
    qryNominateControlListIsQualified: TBooleanField;
    qryNominateControlListSessionID: TIntegerField;
    qryNominateControlListStrokeID: TIntegerField;
    qryNominateEvent: TFDQuery;
    qryNominateMembers: TFDQuery;
    qryNominateMembersFName: TWideStringField;
    qryNominateMembersFullName: TWideStringField;
    qryNominateMembersGenderID: TIntegerField;
    qryNominateMembersMemberID: TFDAutoIncField;
    qryRenumberLanes: TFDQuery;
    qrySCMSystem: TFDQuery;
    qrySwapEntrants: TFDQuery;
    qrySwapTeams: TFDQuery;
    scmConnection: TFDConnection;
    tblDisqualifyCode: TFDTable;
    tblEventStatus: TFDTable;
    tblEventType: TFDTable;
    tblGender: TFDTable;
    tblHeatStatus: TFDTable;
    tblHeatType: TFDTable;
		tblHouse: TFDTable;
    tblSessionStatus: TFDTable;
    qryCountTEAMNominee: TFDQuery;
    qryCountINDVNominee: TFDQuery;
    FDErrorDialog: TFDGUIxErrorDialog;
		scmFDManager: TFDManager;
		procedure DataModuleCreate(Sender: TObject);
    procedure qryLaneAfterScroll(DataSet: TDataSet);
    procedure qryLaneTIMEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryLaneTIMESetText(Sender: TField; const Text: string);
		procedure qryEvTypeBeforeInsert(DataSet: TDataSet);
		procedure qryMemberQuickPickAfterScroll(DataSet: TDataSet);
		procedure qryNominateMembersAfterScroll(DataSet: TDataSet);
		procedure qryTeamAfterScroll(DataSet: TDataSet);
		procedure qryTeamLinkAfterScroll(DataSet: TDataSet);
		procedure scmConnectionAfterDisconnect(Sender: TObject);
	private
    fIsNewRecord: boolean;
    fLastDistanceID: integer;
    fLastStrokeID: integer;
    FIsActive: Boolean;
    { Private declarations }
    prefCheckUnNomination: integer;
    prefGenerateEventDescription: Boolean;
		prefGenerateEventDescStr: string;
		fDBModel: integer;
		fDBVersion: integer;
		fDBMajor: integer;
		fDBMinor: integer;

  protected
    // Swimmers have MemberID's. Empty lanes excluded from TOT.
    function ClearLane(aIndvTeamID: integer; aEventType: scmEventType): integer;
    function ClearLanes(aHeatID: integer): integer;
    function ClearSlot(aTeamEntrantID: integer): integer;
    function CountHeatSwimmers(aHeatID: integer): integer;
//    function CountLanes(aHeatID: integer): integer;
    function CountTeamSwimmers(aTeamID: integer): integer;
    function DeleteAllHeats(aEventID: integer): integer;
    function DeleteAllLanes(aHeatID: integer): integer;
		function DeleteAllSplits(aLaneID: integer): integer;
    function DeleteAllTeamEntrants(aTeamID: integer): integer;
    function DeleteEvent(aEventID: integer): integer;
    function DeleteHeat(aHeatID: integer): integer;
		function DeleteLane(aLaneID: integer): integer;
    function DeleteNomination(aMemberID, aEventID: integer): integer;
    function DeleteSession(aSessionID: integer): integer;
		function DeleteSplit(aLaneID: integer): integer;
    function FirstLaneNum(aHeatID: integer): integer;
		function InsertEmptyLane(aHeatID: integer): integer;
    function InsertEmptyLanes(aHeatID: integer): integer;
    function LastLaneNum(aHeatID: integer): integer;
    function LocateLane(aIndvTeamID: integer; aEventType: scmEventType): boolean;
//    function RenumberLanes(aHeatID: integer): integer;
//    function RenumberEvents(aSessionID: integer; DoLocate: Boolean = true): integer;
//    function RenumberHeats(aEventID: integer; DoLocate: Boolean = true): integer;
    function RepairLanes(aHeatID: integer): integer;
		procedure WndProc(var wndMsg: TMessage); virtual;
	public


		// BSA NEW - used by scmLogin...
		procedure ReadConnectionDef(const ConnectionName, ParamName: string; out ParamValue: string);
		procedure WriteConnectionDef(const ConnectionName, ParamName, ParamValue: string);
		function  GetDBVerInfo(): string;


    function PadLanes(aHeatID: integer): integer; // Made public 2024.08.28.

		{ Public declarations }
    procedure ActivateTable();
    procedure DeActivateTable();
    function Entrant_SwapLanes(EntrantIDA, EntrantIDB: integer)
      : Boolean; overload;
    function Entrant_SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB: integer)
      : Boolean; overload;

		// UTILITY
    function IsFirstRecord(ADataSet: TDataSet): Boolean;
    function IsLastRecord(ADataSet: TDataSet): Boolean;
    // MEMBER
    function Member_IsQualified(aMemberID, aGenderID, aQualifyDistID,
      aStrokeID: integer; IsShortCourse: Boolean): Boolean;
    // MOVE - GENERIC LANE FUNCTIONS
    function MoveDownLane(ADataSet: TDataSet): Boolean;
    function MoveDownToNextHeat(ADataSet: TDataSet): Boolean;
    function MoveUpLane(ADataSet: TDataSet): Boolean;
    function MoveUpToPrevHeat(ADataSet: TDataSet): Boolean;
    // NOMINATE
    function CountTEAMNominee(): integer;
    function Nominate_Locate(MemberID: integer): Boolean;
    function Nominate_LocateEventNum(ADataSet: TDataSet;
      EventNum: integer): Boolean;
    function Nominate_SortMembers(SortState: Boolean): Boolean;
    function Nominate_UpdateControlList(SessionID, MemberID: integer): Boolean;
    procedure ReadPreferences(IniFileName: string);
    // SWIMCLUBMEET SYSTEM
    function SCM_VerInfoMajor(): integer;
		// SPLIT
    function Split_HeatStatusID(aSplitID: integer): integer;
    function Split_SessionIsLocked(aSplitID: integer): Boolean;
    // SLOT
    function StrikeSlot(aTeamEntrantID: integer): integer;
    // SWAPLANES - GENERIC LANE FUNCTIONS
    function SwapLanes(IDA, IDB: integer; aEventType: scmEventType): Boolean; overload;
    function SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB: integer)
      : Boolean; overload;

    // TEAM SPLIT
		function TeamSplit_HeatStatusID(aSplitID: integer): integer;
    function TeamSplit_SessionIsLocked(aTeamSplitID: integer): Boolean;
    // TEAM
    function Team_Locate(aTeamID: integer): Boolean;
    // TOGGLE DISQUALIFICATION CODE
    procedure ToggleDCode(ADataSet: TDataSet; DoEnable: Boolean);

		// IsScratched/IsDisqualified alias DCode.
		function GetIsScratchedDCode(): integer;
		function GetIsDisqualifiedDCode(): integer;
		function GetDCodeTypeSCM(): integer; // Disqualification Code
    function UpdateDCodes(): boolean;

  published
    property CheckNomination: integer read prefCheckUnNomination
			write prefCheckUnNomination;
    property IsActive: Boolean read FIsActive write FIsActive;
  end;

const
	CUSTOMINIFILE = 'SwimClubMeetPref.ini';
  USEDEFAULTINIFILE = true; // NOTE: Always true. 26/09/2022
  SCMCONFIGFILENAME = 'SCMConfig.ini';

var
  SCM: TSCM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses
  System.IOUtils, IniFiles, SCMUtility, System.DateUtils, Dialogs,
  System.Variants, System.StrUtils, System.Types, System.Math,
  vcl.Forms, vcl.StdCtrls, System.UITypes,
  dmCORE, uSwimClub, uSession, uEvent, uHeat, uLane;

procedure TSCM.ReadConnectionDef(const ConnectionName, ParamName: string;
  out ParamValue: string);
var
  ConnectionDef: IFDStanConnectionDef;
begin
  // Check if the connection definition exists
  ConnectionDef := SCM.scmFDManager.ConnectionDefs.ConnectionDefByName(ConnectionName);
  if Assigned(ConnectionDef) then
  begin
    // Read the parameter value
    ParamValue := ConnectionDef.Params.Values[ParamName];
  end
  else
    raise Exception.CreateFmt('Connection definition "%s" not found.', [ConnectionName]);
end;

(*
You do not need to make the TFDManager inactive before updating its
ConnectionDefs. The TFDManager allows you to modify connection definitions
dynamically at runtime without deactivating it.
*)

procedure TSCM.WriteConnectionDef(const ConnectionName, ParamName,
  ParamValue: string);
var
  ConnectionDef: IFDStanConnectionDef;
begin
	// Get the connection definition by name
  ConnectionDef := SCM.scmFDManager.ConnectionDefs.ConnectionDefByName(ConnectionName);

  if Assigned(ConnectionDef) then
  begin
    // Update the parameter
    ConnectionDef.Params.Values[ParamName] := ParamValue;

    // Save the changes to the FDConnectionDefs.ini file
    SCM.scmFDManager.ConnectionDefs.Save;
  end
  else
    raise Exception.CreateFmt('Connection definition "%s" not found.', [ConnectionName]);
end;

function TSCM.GetDBVerInfo: string;
begin
  result := '';
  if scmConnection.Connected then
  begin
    with qrySCMSystem do
    begin
      Connection := scmConnection;
      Open;
      if Active then
      begin
        fDBModel := FieldByName('SCMSystemID').AsInteger;
        fDBVersion := FieldByName('DBVersion').AsInteger;
        fDBMajor := FieldByName('Major').AsInteger;
        fDBMinor := FieldByName('Minor').AsInteger;
        result := IntToStr(fDBModel) + '.' + IntToStr(fDBVersion) + '.' +
          IntToStr(fDBMajor) + '.' + IntToStr(fDBMinor);
      end;
      Close;
    end;
  end;
end;



procedure TSCM.ActivateTable;
begin
  // -----------------------------------------------------------
  // 24/04/2020 Always ASSERT FIsActive state.
  // -----------------------------------------------------------
  FIsActive := false;
  // --------------------------------------------
  // Lookup Tables
  // --------------------------------------------
  //
	if (scmConnection.Connected = false) then
	begin
		try
			scmConnection.Open();
		except
			on E: Exception do
			begin
				MessageDlg(E.Message, TMsgDlgType.mtError, [mbOK], 0);
				exit;
			end;
		end;
	end;

	if (scmConnection.Connected = true) then
	begin
		qrySCMSystem.Open;

		if (FIsActive = false) then
        MessageDlg('During activation of the database module' + slinebreak +
        'not all essential tables opened successfully!', mtWarning, [mbOK], 0);
  end;
end;


function TSCM.ClearLane(aIndvTeamID: integer; aEventType: scmEventType): integer;
var
  tbl: TFDTable;
  SearchOptions: TLocateOptions;
  success: Boolean;
begin
  result := 0;
  if not FIsActive then exit;
  if aIndvTeamID = 0 then exit;
  if aEventType = etUnknown then exit;

  if aEventType = etINDV then
  begin
		CORE.dsLane.DataSet.DisableControls;
    tbl := TFDTable.Create(self);
    tbl.Connection := scmConnection;
    tbl.TableName := 'Entrant';
    tbl.IndexFieldNames := 'EntrantID';
    tbl.Open;
    if (tbl.Active) then
    begin
      SearchOptions := [];
      success := tbl.Locate('EntrantID', aIndvTeamID, SearchOptions);
      if (success) then
      begin
        { TODO -oBSA -cGeneral : TEST - CLEAR SPLIT TIMES }
				DeleteAllSplits(aIndvTeamID);
        tbl.Edit;
        tbl.FieldByName('MemberID').Clear;
        tbl.FieldByName('DisqualifyCodeID').Clear;
        tbl.FieldByName('RaceTime').Clear;
        tbl.FieldByName('TimeToBeat').Clear;
        tbl.FieldByName('PersonalBest').Clear;
        tbl.FieldByName('IsDisqualified').AsBoolean := false;
        tbl.FieldByName('IsScratched').AsBoolean := false;
        tbl.Post;
        result := 1;
      end;
		end;
    tbl.Close;
    tbl.Free;
    CORE.dsLane.DataSet.EnableControls;
  end
  else if aEventType = etTEAM then
  begin
		CORE.dsTeam.DataSet.DisableControls;
    tbl := TFDTable.Create(self);
    tbl.Connection := scmConnection;
    tbl.TableName := 'Team';
    tbl.IndexFieldNames := 'TeamID';
    tbl.Open;
    if (tbl.Active) then
    begin
      SearchOptions := [];
      success := tbl.Locate('TeamID', aIndvTeamID, SearchOptions);
      if (success) then // found record
      begin
        DeleteAllTeamEntrants(aIndvTeamID); // remove Team Entrants.
				DeleteAllSplits(aIndvTeamID); // remove Split times.
				tbl.Edit;
        tbl.FieldByName('TeamNameID').Clear;
        tbl.FieldByName('DisqualifyCodeID').Clear;
        tbl.FieldByName('RaceTime').Clear;
        tbl.FieldByName('TimeToBeat').Clear;
        tbl.FieldByName('IsDisqualified').AsBoolean := false;
        tbl.FieldByName('IsScratched').AsBoolean := false;
        tbl.Post;
        result := 1;
      end;
    end;
    tbl.Close;
    tbl.Free;
    CORE.dsTeam.DataSet.EnableControls;
  end
end;

function TSCM.ClearLanes(aHeatID: integer): integer;
var
  qry: TFDQuery;
  aEventType: scmEventType;
  aIndvTeamID: Integer;
begin
  result := 0;
  if not FIsActive then exit;
  if aHeatID = 0 then exit;

  aEventType := uEvent.GetEventType;
  if aEventType = etUnknown then exit;

  qry := TFDQuery.Create(self);
  if aEventType = etINDV then
  begin
    qry.SQL.Text :=
			'SELECT [Entrant].[EntrantID] AS aID FROM [SwimClubMeet2].[dbo].[Entrant] ' +
      'WHERE MemberID IS NOT NULL AND [Entrant].HeatID = ' +
      IntToStr(aHeatID);
  end
  else if aEventType = etTeam then
  begin
    qry.SQL.Text :=
      'SELECT [Team].[TeamID] AS aID FROM [SwimClubMeet2].[dbo].[Team] ' +
      'WHERE MemberID IS NOT NULL AND [Team].HeatID = ' + IntToStr(aHeatID);
  end;
  qry.IndexFieldNames := 'aID'; // Must use alias.
  qry.Connection := scmConnection;
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aIndvTeamID := qry.FieldByName('aID').AsInteger;
      result := ClearLane(aIndvTeamID, aEventType);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

function TSCM.ClearSlot(aTeamEntrantID: integer): integer;
var
SQL: string;
v: variant;
begin
  result := 0;
  if not FIsActive then exit;
  if aTeamEntrantID = 0 then exit;
  SQL := 'UPDATE SwimClubMeet2.dbo.TeamEntrant ' +
  'SET MemberID = NULL, RaceTime = NULL, PersonalBest = NULL, TimeToBeat = NULL,' +
  'IsDisqualified = 0, IsScratched = 0, DisqualifyCodeID = NULL ' +
  'WHERE TeamEntrantID = :ID';
  v := scmConnection.ExecSQL(SQL, [aTeamEntrantID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.CountHeatSwimmers(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: scmEventType;
begin
  result := 0;
  if not FIsActive then exit;
  aEventType := uEvent.GetEventType;
  if aEventType = etUnknown then exit;

  if aEventType = etINDV then
  SQL := 'SELECT COUNT(EntrantID) FROM [SwimClubMeet2].[dbo].[Heat] ' +
    ' INNER JOIN [Entrant] ON [Heat].HeatID = [Entrant].HeatID ' +
    ' WHERE [Heat].HeatID = :ID AND MEMBERID IS NOT NULL;'
  else
    SQL := 'SELECT COUNT(TeamEntrantID) FROM [SwimClubMeet2].[dbo].[Heat] '
    + ' INNER JOIN [Team] ON [Heat].HeatID = [Team].HeatID ' +
    ' INNER JOIN [TeamEntrant] ON [Team].TeamID = [TeamEntrant].TeamID ' +
    ' WHERE [Heat].HeatID = :ID;';

  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;

end;


function TSCM.CountTEAMNominee: integer;
begin
  { Count number of nominees (swimmers) for event.
    Exclude entrants (swimmers) in RACED or CLOSED heats.
    INCLUDE nominees (swimmers) in OPEN heats.
    INCLUDE pooled nominees (swimmers) not assigned a lane to the event.
    }
  result := 0;
  SCM.qryCountTEAMNominee.Close;
  SCM.qryCountTEAMNominee.ParamByName('EVENTID').AsInteger := uEvent.PK;
  SCM.qryCountTEAMNominee.Prepare;
  try
    SCM.qryCountTEAMNominee.Open;
    if SCM.qryCountTEAMNominee.Active then
    begin
      result := SCM.qryCountTEAMNominee.FieldByName('CountNominees').AsInteger;
    end;
  finally
    SCM.qryCountTEAMNominee.Close;
  end;
end;

function TSCM.CountTeamSwimmers(aTeamID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not FIsActive then exit;
  if aTeamID = 0 then exit;
  SQL := 'SELECT COUNT(TeamEntrantID) FROM [SwimClubMeet2].[dbo].[Team] ' +
      'INNER JOIN [TeamEntrant] ON [Team].TeamID = [TeamEntrant].TeamID ' +
      'WHERE TeamID = :ID;';
  v := scmConnection.ExecSQLScalar(SQL, [aTeamID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

procedure TSCM.DataModuleCreate(Sender: TObject);
var
  IniFileName: string;
begin
  FIsActive := false;
  fLastDistanceID := 0;
  fLastStrokeID := 0;
  fIsNewRecord := false;
  prefGenerateEventDescription := false;
  prefGenerateEventDescStr := '';

  if scmConnection.Connected then scmConnection.Close;

  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then ReadPreferences(IniFileName);

end;

procedure TSCM.DeActivateTable;
begin
  FIsActive := false;
  // CORE PARENT..CHILD TABLES
	CORE.qrySplitTime.Close;
  CORE.qryTeamLink.Close;
	CORE.qryTeam.Close;
	CORE.qrySplitTime.Close;
	CORE.qryWatchTime.Close;
	CORE.qryLane.Close;
	CORE.qryLane.Close;
	CORE.qryHeat.Close;
	CORE.qryNominee.Close;
//	CORE.qryDistance.Close;
	CORE.qryEvent.Close;
	CORE.qrySession.Close;

//  qryContactNum.Close;
//  qryMember.Close;

	CORE.qrySwimClub.Close;
  // SUPPORT-LOOKUP TABLES
  tblHouse.Active := false;
  tblSessionStatus.Active := false;
//  tblStroke.Active := false;
//  tblDistance.Active := false;
	tblEventType.Active := false;
  tblEventStatus.Active := false;
  tblGender.Active := false;
  tblHeatType.Active := false;
  tblHeatStatus.Active := false;
	tblDisqualifyCode.Active := false;

	// Paralympic tables used by dbo.member and dbo.event
//	tblParaCode.Active := false;
//	tblParaCodeLink.Active := false;
//	tblParalympicType.Active := false;

qryFName.Active := false;
  qryFNameEllipse.Active := false;
  qryNominateEvent.Active := false;
  qryNominateMembers.Active := false;
  qryNominateControlList.Active := false;
end;

function TSCM.DeleteAllHeats(aEventID: integer): integer;
var
  aHeatID: integer;
  qry: TFDQuery;
begin
  result := 0;
  if not FIsActive then exit;
  if aEventID = 0 then exit;
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := 'SELECT HeatID FROM [SwimClubMeet2].[dbo].[Heat] ' +
    'WHERE EventID = ' + IntToStr(aEventID);
  qry.IndexFieldNames := 'HeatID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aHeatID := qry.FieldByName('HeatID').AsInteger;
      DeleteHeat(aHeatID);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

function TSCM.DeleteAllLanes(aHeatID: integer): integer;
var
  qry: TFDQuery;
  rows, aIndvTeamID: integer;
  aEventType: scmEventType;
begin
  result := 0;
  rows := 0;
  if not FIsActive then exit;
  aEventType := uEvent.GetEventType;
  if aEventType = etUnknown then exit;

  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  if aEventType = etINDV then
  begin
  qry.SQL.Text :=
    'SELECT [Entrant].[EntrantID] AS aID FROM [SwimClubMeet2].[dbo].[Entrant] ' +
    'WHERE [Entrant].HeatID = ' + IntToStr(aHeatID);
  end
  else if aEventType = etTEAM then
  begin
  qry.SQL.Text :=
    'SELECT [Team].[TeamID] AS aID FROM [SwimClubMeet2].[dbo].[Team] ' +
    'WHERE [Team].HeatID = ' + IntToStr(aHeatID);
  end;
  qry.IndexFieldNames := 'aID';
  qry.Prepare;
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aIndvTeamID := qry.FieldByName('aID').AsInteger;
			rows := rows + DeleteLane(aIndvTeamID);
      qry.Next;
    end;
    if rows > 0 then result := rows;
  end;
  qry.Close;
  qry.Free;
end;

function TSCM.DeleteAllSplits(aLaneID: integer): integer;
var
  SQL: string;
begin
  result := 0;
	if not FIsActive then exit;
	CORE.dsSplitTime.DataSet.DisableControls;
	// DELETE SPLIT TIMES
	SQL := 'DELETE FROM [SwimClubMeet2].[dbo].[SplitTime] WHERE [LaneID] = :ID';
	result := scmConnection.ExecSQL(SQL, [aLaneID]);
	CORE.dsSplitTime.DataSet.EnableControls;
end;

function TSCM.DeleteAllTeamEntrants(aTeamID: integer): integer;
var
  SQL: string;
begin
  result := 0;
  if not FIsActive then exit;
	CORE.dsTeamLink.DataSet.DisableControls;
	SQL := 'DELETE FROM [SwimClubMeet2].[dbo].[TeamLink] WHERE [TeamID] = :ID';
  result := scmConnection.ExecSQL(SQL, [aTeamID]);
	CORE.dsTeamLink.DataSet.EnableControls;
end;

function TSCM.DeleteEvent(aEventID: integer): integer;
var
  SQL: string;
begin
  result := 0;
  if not FIsActive then exit;
  // D E L E T E   H E A T S
  // (including Entrants, Teams, TeamEntrants, Splits, TeamSplits)
  DeleteAllHeats(aEventID);
    // D E L E T E   N O M I N A T I O N S .
  SQL := 'DELETE FROM dbo.Nominee WHERE Nominee.EventID = :ID';
  scmConnection.ExecSQL(SQL, [aEventID]);
  // FINALLY DELETE EVENT
	CORE.dsEvent.DataSet.DisableControls;
  SQL := 'DELETE FROM dbo.Event WHERE Event.EventID = :ID';
  result := scmConnection.ExecSQL(SQL, [aEventID]);
	CORE.dsEvent.DataSet.EnableControls;
end;

function TSCM.DeleteHeat(aHeatID: integer): integer;
var
  SQL: string;
begin
  result := 0;
  if not FIsActive then exit;
  DeleteAllLanes(aHeatID);
	CORE.dsHeat.DataSet.DisableControls();
  SQL := 'DELETE FROM [SwimClubMeet2].[dbo].[Heat] WHERE HeatID = :ID';
  result := scmConnection.ExecSQL(SQL, [aHeatID]);
	CORE.dsHeat.DataSet.EnableControls();
end;

function TSCM.DeleteLane(aLaneID: integer): integer;
var
  SQL: string;
begin
  result := 0;
  if not FIsActive then exit;
	begin
		// DELETE SPLIT TIMES.
		DeleteAllSplits(aLaneID);
		// DELETE WATCH TIMES.
		// DeleteAllWatchTimes(aLaneID);
		// DELETE TEAM MEMBERS
		// DeleteAllTeamMembers(aLaneID);
		// DELETE TEAM.
		CORE.dsTeam.DataSet.DisableControls;
		SQL := 'DELETE FROM [SwimClubMeet2].[dbo].[Team] WHERE [TeamID] = :ID';
		result := scmConnection.ExecSQL(SQL, [aLaneID]);
		CORE.dsTeam.DataSet.EnableControls;
		// FINALLY DELETE LANE.
		CORE.dsLane.DataSet.DisableControls;
		SQL := 'DELETE FROM [SwimClubMeet2].[dbo].[Lane] WHERE [LaneID] = :ID';
		result := scmConnection.ExecSQL(SQL, [aLaneID]);
		CORE.dsLane.DataSet.EnableControls;


	end;
end;

function TSCM.DeleteNomination(aMemberID, aEventID: integer): integer;
var
  SQL: string;
  rows: integer;
begin
  result := 0;
  if not IsActive then exit;
  // FINALLY DELETE Nomination..
	CORE.dsNominee.DataSet.DisableControls;
  SQL := 'DELETE FROM SwimClubMeet2.[dbo].[Nominee] ' +
    'WHERE MemberID = :MemberID AND EventID = :EventID;';
  rows := scmConnection.ExecSQL(SQL, [aMemberID, aEventID]);
	CORE.dsNominee.DataSet.EnableControls;
  if (rows > 0) then result := rows;
end;

function TSCM.DeleteSession(aSessionID: integer): integer;
var
  SQL: string;
  qry: TFDQuery;
  aEventID: integer;
begin
  result := 0;
  if not FIsActive then exit;
  // iter over events
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := 'SELECT [Event].[EventID] FROM [SwimClubMeet2].[dbo].[Event] '
    + 'WHERE [Event].SessionID = ' + IntToStr(aSessionID);
  qry.IndexFieldNames := 'EventID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aEventID := qry.FieldByName('EventID').AsInteger;
      // delete nominees, heats, entrants, teams, team entrants, splits, etc
      DeleteEvent(aEventID);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
  // finally delete the session
	CORE.dsSession.DataSet.DisableControls;
  SQL := 'DELETE FROM [SwimClubMeet2].[dbo].[Session] WHERE [SessionID] = :ID';
  result := scmConnection.ExecSQL(SQL, [aSessionID]);
	CORE.dsSession.DataSet.EnableControls;
end;

function TSCM.DeleteSplit(aLaneID: integer): integer;
var
	SQL: string;
	v: variant;
begin
	result := 0;
	if not FIsActive then exit;
	CORE.dsSplitTime.DataSet.DisableControls;
	SQL := 'DELETE FROM dbo.SplitTime WHERE Split.LaneID = :ID';
	v := scmConnection.ExecSQL(SQL, [aLaneID]);
	CORE.dsSplitTime.DataSet.EnableControls;
	if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.Entrant_SwapLanes(EntrantIDA, EntrantIDB: integer): Boolean;
begin
  result := false;
  if (EntrantIDA = EntrantIDB) then exit;
  if (EntrantIDA = 0) OR (EntrantIDB = 0) then exit;
  qrySwapEntrants.Connection := scmConnection;
  qrySwapEntrants.ParamByName('ENTRANTIDA').AsInteger := EntrantIDA;
  qrySwapEntrants.ParamByName('ENTRANTIDB').AsInteger := EntrantIDB;
  qrySwapEntrants.Prepare;
  // does not return a cursor - hence execute (UPDATE).
  qrySwapEntrants.Execute();
  result := true;
end;

function TSCM.Entrant_SwapLanes(HeatIDA, LaneA, HeatIDB,
  LaneB: integer): Boolean;
var
  EntrantIDA, EntrantIDB: integer;
  SQL: string;
begin
  result := false;
  if not FIsActive then exit;
  { TODO -oBSA -cGeneral : Create swap lane function }
  SQL := 'SELECT TOP 1 [EntrantID] FROM [SwimClubMeet2].[dbo].[Entrant] ' +
    'WHERE HeatID = :HEAT AND Lane = :LANE';
  EntrantIDA := scmConnection.ExecSQLScalar(SQL, [HeatIDA, LaneA]);
  EntrantIDB := scmConnection.ExecSQLScalar(SQL, [HeatIDB, LaneB]);
  Entrant_SwapLanes(EntrantIDA, EntrantIDB);
  result := true;
end;


function TSCM.FirstLaneNum(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: scmEventType;
begin
  result := 0;
  if not FIsActive then exit;
  if aHeatID = 0 then exit;
  aEventType := uEvent.GetEventType;
	if aEventType = etINDV then
      SQL := 'SELECT MIN(Lane) FROM SwimClubMeet2.dbo.Entrant ' +
      'Entrant.HeatID = :ID'
  else if aEventType = etTEAM then
      SQL := 'SELECT MIN(Lane) FROM SwimClubMeet2.dbo.Team ' +
      'Team.HeatID = :ID'
  else exit;
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.GetIsDisqualifiedDCode: integer;
var
s: string;
v: variant;
begin
  {-- SCM Special
    [DisqualifyCodeID], [Caption], [ABREV], [DisqualifyTypeID]
    (54, N'Unspecified disqualification. (Simplified method.)',N'ScmB',7)}
  result := 0;
  if not FIsActive then exit;
  s := 'SELECT [DisqualifyCodeID] FROM [dbo].[DisqualifyCode] ' +
    'WHERE [ABREV] = N''ScmB'' ';
  v := SCM.scmConnection.ExecSQLScalar(s);
  if not VarIsNull(v) and not VarIsEmpty(v) then result := v;
end;


function TSCM.GetDCodeTypeSCM(): integer;
var
  s: string;
  v: variant;
begin
  { -- SCM Special
    [DisqualifyCodeID], [Caption], [ABREV], [DisqualifyTypeID]
    (53, N'Swimmer didn''t show for event. Scratched',N'ScmA',7) }
  result := 0;
  if not FIsActive then exit;
  s := ' SELECT [DisqualifyTypeID] FROM [dbo].[DisqualifyType] ' +
    'WHERE [Caption] = N''SCM'' ';
  v := SCM.scmConnection.ExecSQLScalar(s);
  if not VarIsNull(v) and not VarIsEmpty(v) then result := v;
end;

function TSCM.GetIsScratchedDCode: integer;
var
  s: string;
  v: variant;
begin
  { -- SCM Special
    [DisqualifyCodeID], [Caption], [ABREV], [DisqualifyTypeID]
    (53, N'Swimmer didn''t show for event. Scratched',N'ScmA',7) }
  result := 0;
  if not FIsActive then exit;
  s := ' SELECT [DisqualifyCodeID] FROM [dbo].[DisqualifyCode] ' +
    'WHERE [ABREV] = N''ScmA'' ';
  v := SCM.scmConnection.ExecSQLScalar(s);
  if not VarIsNull(v) and not VarIsEmpty(v) then result := v;
end;

function TSCM.InsertEmptyLane(aHeatID: integer): integer;
var
  aLaneNum: integer;
  tbl: TFDTable;
  aEventType: scmEventType;
begin
    result := 0;
    if not FIsActive then exit;
    if aHeatID = 0 then exit;

    aEventType := uEvent.GetEventType;
		if (aEventType = etUnknown) then exit;

		if (CountLanes(aHeatID) >= CORE.qrySwimClub.FieldByName('NumOfLanes').AsInteger) then exit;

    aLaneNum := LastLaneNum(aHeatID) + 1;
    tbl := TFDTable.Create(self);
    tbl.Connection := scmConnection;
    if aEventType = etINDV then
    begin
      if not FIsActive then exit;
      tbl.TableName := 'Entrant';
      tbl.IndexFieldNames := 'EntrantID';
    end
    else if aEventType = etTEAM then
    begin
      tbl.TableName := 'Team';
      tbl.IndexFieldNames := 'TeamID';
    end;
    tbl.Open;
    if (tbl.Active) then
    begin
      if aEventType = etINDV then CORE.dsLane.DataSet.DisableControls
      else CORE.dsTeam.DataSet.DisableControls;

      tbl.Insert;
      tbl.FieldByName('HeatID').AsInteger := aHeatID;
      tbl.FieldByName('Lane').AsInteger := aLaneNum;
      tbl.FieldByName('IsDisqualified').AsBoolean := false;
      tbl.FieldByName('IsScratched').AsBoolean := false;
      tbl.Post;
      result := 1;
      if aEventType = etINDV then CORE.dsLane.DataSet.EnableControls
      else CORE.dsTeam.DataSet.EnableControls;
    end;
    tbl.Close;
    tbl.Free;
end;

function TSCM.InsertEmptyLanes(aHeatID: integer): integer;
var
  lanes, NumOfLanes, i: integer;
begin
  result := 0;
  if not FIsActive then exit;
  if aHeatID = 0 then exit;
  Lanes := CountLanes(aHeatID);
  NumOfLanes := uSwimClub.NumberOfLanes;
  if ( Lanes < NumOfLanes) then
  begin
    for i := 1 to (NumOfLanes - Lanes) do
    begin
      InsertEmptyLane(aHeatID);
      result := result + 1;
    end;
  end;
  if (Lanes > NumOfLanes) then
    raise Exception.Create('System ERROR: Too many lanes in heat.');
end;

function TSCM.IsFirstRecord(ADataSet: TDataSet): Boolean;
var
  bm: TBookMark;
begin
  result := true;
  if not(FIsActive) then exit;
  if (ADataSet.IsEmpty) then exit;
  result := ADataSet.Bof;
  if not(result) then
  begin
    ADataSet.DisableControls;
    try
      bm := ADataSet.Bookmark;
      try
        ADataSet.Prior;
        result := ADataSet.Bof;
      finally
        ADataSet.Bookmark := bm;
      end;
    finally
      ADataSet.EnableControls;
    end;
  end;
end;

function TSCM.IsLastRecord(ADataSet: TDataSet): Boolean;
var
  bm: TBookMark;
begin
  result := true;
  if not(FIsActive) then exit;
  if (ADataSet.IsEmpty) then exit;
  result := ADataSet.Eof;
  if not(result) then
  begin
    ADataSet.DisableControls;
    try
      bm := ADataSet.Bookmark;
      try
        ADataSet.Next();
        result := ADataSet.Eof;

      finally
        ADataSet.Bookmark := bm;
      end;
    finally
      ADataSet.EnableControls;
    end;
  end;
end;

function TSCM.LastLaneNum(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: scmEventType;
begin
  result := 0;
  if not FIsActive then exit;
  if aHeatID = 0 then exit;
  aEventType := uEvent.GetEventType;
  if aEventType = etINDV then
      SQL := 'SELECT MAX(Lane) FROM SwimClubMeet2.dbo.Entrant ' +
      'WHERE Entrant.HeatID = :ID'
  else if aEventType = etTEAM then
      SQL := 'SELECT MAX(Lane) FROM SwimClubMeet2.dbo.Team ' +
      'WHERE Team.HeatID = :ID'
  else exit;
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.LocateLane(aIndvTeamID: integer; aEventType: scmEventType): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not FIsActive then exit;
  if aIndvTeamID = 0 then exit;
  if aEventType = etUnknown then exit;

  SearchOptions := [];
  if aEventType = etINDV then
  begin
    if CORE.dsLane.DataSet.Active and not CORE.dsLane.DataSet.IsEmpty then
        result := CORE.dsLane.DataSet.Locate('EntrantID', aIndvTeamID,
        SearchOptions);
  end
  else
  begin
    if CORE.dsTeam.DataSet.Active and not CORE.dsTeam.DataSet.IsEmpty then
        result := CORE.dsTeam.DataSet.Locate('TeamID', aIndvTeamID, SearchOptions);
  end;
end;

function TSCM.Member_IsQualified(aMemberID, aGenderID, aQualifyDistID,
  aStrokeID: integer; IsShortCourse: Boolean): Boolean;
begin
  result := false;
  if not FIsActive then exit;
  qryIsQualifiedALT.Close;
  qryIsQualifiedALT.ParamByName('MEMBERID').AsInteger := aMemberID;
  qryIsQualifiedALT.ParamByName('GENDERID').AsInteger := aGenderID;
  qryIsQualifiedALT.ParamByName('QUALIFYDISTID').AsInteger := aQualifyDistID;
  qryIsQualifiedALT.ParamByName('STROKEID').AsInteger := aStrokeID;
  qryIsQualifiedALT.ParamByName('ISSHORTCOURSE').AsBoolean := IsShortCourse;
  qryIsQualifiedALT.Prepare;
  qryIsQualifiedALT.Open;
  if (qryIsQualifiedALT.Active) then
  begin
    // returns TOP (1)
    if not qryIsQualifiedALT.IsEmpty then
    begin
      if (qryIsQualifiedALT.FieldByName('RaceTime').AsDateTime <=
        qryIsQualifiedALT.FieldByName('TrialTime').AsDateTime) then
          result := true;
    end;
  end;
  qryIsQualifiedALT.Close;
end;

function TSCM.MoveDownLane(ADataSet: TDataSet): Boolean;
var
  bm: TBookMark;
  enA, enB: integer;
  fld: TField;
begin
  result := false;
  if not IsLastRecord(ADataSet) then
  begin
    try
      begin;
        ADataSet.DisableControls;
        // E n a b l e   r e a d   o n   f i e l d .
        fld := ADataSet.FindField('Lane');
        if Assigned(fld) then fld.ReadOnly := false;
        // bookmark current entrant and store lane number.
        bm := ADataSet.Bookmark;
        enA := ADataSet.FieldByName('Lane').AsInteger;
        enB := 0;
        try
          begin
            // peek at prior entrant
            ADataSet.Next;
            enB := ADataSet.FieldByName('Lane').AsInteger;
            ADataSet.Edit;
            // swap lane number
            ADataSet.FieldByName('Lane').AsInteger := enA;
            ADataSet.Post;
            result := true;
          end
        finally
          // restore current entrant
          ADataSet.Bookmark := bm;
          ADataSet.Edit;
          // swap lane number
          ADataSet.FieldByName('Lane').AsInteger := enB;
          ADataSet.Post;
        end;
        // D i s a b l e   r e a d   o n   f i e l d .
        if Assigned(fld) then fld.ReadOnly := true;
      end
    finally
      // resort lanes
      ADataSet.Refresh;
      // endable entrant grid control
      ADataSet.EnableControls;
    end;
  end
end;

function TSCM.MoveDownToNextHeat(ADataSet: TDataSet): Boolean;
var
  HeatIDA, LaneA, HeatIDB, LaneB: integer;
begin
  result := false;
  try
    ADataSet.DisableControls;
    HeatIDA := ADataSet.FieldByName('HeatID').AsInteger;
    LaneA := ADataSet.FieldByName('Lane').AsInteger;
    HeatIDB := uHeat.NextID(HeatIDA);
    LaneB := 1;
    if (HeatIDB > 0) then
    begin
      Entrant_SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB);
      result := true;
    end;
  finally
    // resort lanes
    ADataSet.Refresh;
    // endable entrant grid control
    ADataSet.EnableControls;
  end;
end;

function TSCM.MoveUpLane(ADataSet: TDataSet): Boolean;
var
  bm: TBookMark;
  enA, enB: integer;
  fld: TField;
begin
  result := false;
  enB := 0;
  if not IsFirstRecord(ADataSet) then
  begin
    try
      begin;
        ADataSet.DisableControls;
        // E n a b l e   r e a d   o n   f i e l d .
        fld := ADataSet.FindField('Lane');
        if Assigned(fld) then fld.ReadOnly := false;
        // bookmark current entrant and store lane number.
        bm := ADataSet.Bookmark;
        enA := ADataSet.FieldByName('Lane').AsInteger;
        try
          begin
            // peek at prior entrant
            ADataSet.Prior;
            enB := ADataSet.FieldByName('Lane').AsInteger;
            ADataSet.Edit;
            // swap lane number
            ADataSet.FieldByName('Lane').AsInteger := enA;
            ADataSet.Post;
            result := true;
          end
        finally
          // restore current entrant
          ADataSet.Bookmark := bm;
          ADataSet.Edit;
          // swap lane number
          ADataSet.FieldByName('Lane').AsInteger := enB;
          ADataSet.Post;
        end;
        // D i s a b l e   r e a d   o n   f i e l d .
        if Assigned(fld) then fld.ReadOnly := true;
      end
    finally
      // resort lanes
      ADataSet.Refresh;
      // endable entrant grid control
      ADataSet.EnableControls;
    end;
  end

end;

function TSCM.MoveUpToPrevHeat(ADataSet: TDataSet): Boolean;
var
  HeatIDA, LaneA, HeatIDB, LaneB: integer;
begin
  result := false;
  try
    ADataSet.DisableControls;
    HeatIDA := ADataSet.FieldByName('HeatID').AsInteger;
    LaneA := ADataSet.FieldByName('Lane').AsInteger;
    HeatIDB := uHeat.PrevID(HeatIDA);
    LaneB := uSwimClub.NumberOfLanes;
    if (HeatIDB > 0) then
    begin
      SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB);
      result := true;
    end;
  finally
    // resort lanes
    ADataSet.Refresh;
    // endable entrant grid control
    ADataSet.EnableControls;
  end;
end;

function TSCM.Nominate_Locate(MemberID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not FIsActive then exit;
  if (MemberID > 0) then
  begin
    SearchOptions := [];
    with dsNominateMembers.DataSet AS TFDQuery do
    begin
      if (Active) then
      begin
        indexName := 'idxMemberID';
        result := dsNominateMembers.DataSet.Locate('MemberID', MemberID,
          SearchOptions);
      end;
    end;
  end;
end;

function TSCM.Nominate_LocateEventNum(ADataSet: TDataSet;
  EventNum: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not FIsActive then exit;
  if (EventNum > 0) then
  begin
    SearchOptions := [];
    if (ADataSet.Active) then
        result := ADataSet.Locate('EventNum', EventNum, SearchOptions);
  end;
end;

function TSCM.Nominate_SortMembers(SortState: Boolean): Boolean;
var
  MemberID: integer;
begin
  // returns true after successful sort and cue-to selected member.
  result := false;
  MemberID := 0;
  if not FIsActive then exit;
  if dsNominateMembers.DataSet.IsEmpty then exit;
  with dsNominateMembers.DataSet as TFDQuery do
  begin
    DisableControls;
    if (Active) then
      // Store the current selected member.
      // Note: can't use bookmarks as the DB is re-queried.
      // Query re-builds FName string. LASTNAME:FIRSTNAME or FIRSTNAME:LASTNAME
        MemberID := FieldByName('MemberID').AsInteger;
    Close;
    ParamByName('SESSIONSTART').AsDateTime := uSession.StartDT;
    ParamByName('TOGGLE').AsBoolean := SortState;
    Prepare;
    Open;
    if (Active) then
    begin
      if (MemberID > 0) then
        // Note: locate memner on idxMemberID.
          result := Nominate_Locate(MemberID);
    end;
    indexName := 'idxFName'; // Sort on FName.
    EnableControls;
  end;
end;

function TSCM.Nominate_UpdateControlList(SessionID, MemberID: integer): Boolean;
begin
  result := false;
  if not FIsActive then exit;
  qryNominateControlList.DisableControls;
  qryNominateControlList.Close;
  qryNominateControlList.ParamByName('MEMBERID').AsInteger := MemberID;
  qryNominateControlList.ParamByName('SESSIONID').AsInteger := SessionID;
  qryIsQualifiedALT.Prepare;
  qryIsQualifiedALT.Open;
  if (qryIsQualifiedALT.Active) then
  begin
    result := true;
  end;
  qryNominateControlList.EnableControls;
end;

function TSCM.PadLanes(aHeatID: integer): integer;
var
  NumOfLanes, Lanes: integer;
begin
  { Lane_Pad
    Fills the heat with empty lanes up too 'SwimClub_NumberOfLanes'.
    RTN - Number of rows (lanes) created.
  }
  result := 0;
  if not FIsActive then exit;
  if aHeatID = 0 then exit;
  Lanes := CountLanes(aHeatID);
  // number of lanes in club pool.
  NumOfLanes := uSwimClub.NumberOfLanes;
  if Lanes < NumOfLanes then // need more lanes
    result := InsertEmptyLanes(aHeatID);
end;

procedure TSCM.qryLaneAfterScroll(DataSet: TDataSet);
begin
  if Owner is TForm then
      PostMessage(TForm(Owner).Handle, SCM_ENTRANTSCROLL, 0, 0);
end;

procedure TSCM.qryLaneTIMEGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
var
  Hour, Min, Sec, MSec: word;
begin
  // CALLED BY TimeToBeat AND PersonalBest (Read Only fields)
  // this FIXES display format issues.
  DecodeTime(Sender.AsDateTime, Hour, Min, Sec, MSec);
  // DisplayText is true if the field's value is to be used for display only;
  // false if the string is to be used for editing the field's value.
  // "%" [index ":"] ["-"] [width] ["." prec] type
  if DisplayText then
  begin
    if (Min > 0) then Text := Format('%0:2u:%1:2.2u.%2:3.3u', [Min, Sec, MSec])
    else if ((Min = 0) and (Sec > 0)) then
        Text := Format('%1:2u.%2:3.3u', [Min, Sec, MSec])

    else if ((Min = 0) and (Sec = 0)) then Text := '';
  end
  else Text := Format('%0:2.2u:%1:2.2u.%2:3.3u', [Min, Sec, MSec]);
end;

procedure TSCM.qryLaneTIMESetText(Sender: TField; const Text: string);
var
  Min, Sec, MSec: word;
  s: string;
  dt: TDateTime;
  i: integer;
  failed: Boolean;
begin
  s := Text;
  failed := false;

  // Take the user input that was entered into the time mask and replace
  // spaces with '0'. Resulting in a valid TTime string.
  // UnicodeString is '1-based'
  for i := 1 to Length(s) do
  begin
    if (s[i] = ' ') then s[i] := '0';
  end;

  // SubString is '0-based'
  Min := StrToIntDef(s.SubString(0, 2), 0);
  Sec := StrToIntDef(s.SubString(3, 2), 0);
  MSec := StrToIntDef(s.SubString(6, 3), 0);
  try
    begin
      dt := EncodeTime(0, Min, Sec, MSec);
      Sender.AsDateTime := dt;
    end;
  except
    failed := true;
  end;

  if failed then Sender.Clear; // Sets the value of the field to NULL

end;

procedure TSCM.qryEvTypeBeforeInsert(DataSet: TDataSet);
begin
  // lanes are created when new heat is called
  // .. user cannnot enter new lanes from here...
  Abort();
end;

procedure TSCM.qryMemberQuickPickAfterScroll(DataSet: TDataSet);
begin
  if Owner is TForm then
      PostMessage(TForm(Owner).Handle, SCM_NOMINATESCROLL, 0, 0);
end;

procedure TSCM.qryNominateMembersAfterScroll(DataSet: TDataSet);
begin
  if Owner is TForm then
      PostMessage(TForm(Owner).Handle, SCM_NOMINATESCROLL, 0, 0);
end;

procedure TSCM.qryTeamAfterScroll(DataSet: TDataSet);
begin
  // Update DISPLAY state of the main form's TEAM frame
  if Owner is TForm then PostMessage(TForm(Owner).Handle, SCM_TEAMSCROLL, 0, 0);
end;

procedure TSCM.qryTeamLinkAfterScroll(DataSet: TDataSet);
begin
	// Update DISPLAY state of the main form's TEAM ENTRANT frame
	if Owner is TForm then
      PostMessage(TForm(Owner).Handle, SCM_TEAMENTRANTSCROLL, 0, 0);
end;


procedure TSCM.ReadPreferences(IniFileName: string);
var
  iFile: TIniFile;
  i, iUnChecked, iChecked: integer;
begin
  iFile := TIniFile.Create(IniFileName);
  iUnChecked := integer(TCheckBoxState.cbUnchecked);
  iChecked := integer(TCheckBoxState.cbChecked);

  // Generate event descriptions
  i := iFile.ReadInteger('Preferences', 'GenerateEventDescription', iUnChecked);
  if (i = iChecked) then prefGenerateEventDescription := true
  else prefGenerateEventDescription := false;
  prefGenerateEventDescStr := iFile.ReadString('Preferences',
    'GenerateEventDescStr', ' - Individual, all genders, all ages.');

  // Generate event TEAM descriptions
//  i := iFile.ReadInteger('Preferences', 'GenerateTEAMDescription', iUnChecked);
//  if (i = iChecked) then prefGenerateTEAMDescription := true
//  else prefGenerateTEAMDescription := false;
//  prefGenerateTEAMDescStr := iFile.ReadString('Preferences',
//    'GenerateTEAMDescStr', ' - Individual, all genders, all ages.');


  i := iFile.ReadInteger('Preferences', 'CheckUnNomination', iUnChecked);
  prefCheckUnNomination := i;

  iFile.Free;
end;



function TSCM.RepairLanes(aHeatID: integer): integer;
var
  SQL: string;
  qry: TFDQuery;
  aEventType: scmEventType;
  i, lane, NumOfPoolLanes, aIndvTeamID: integer;
begin
  result := 0;
  i := 0;
  if not FIsActive then exit;
  if aHeatID = 0 then exit;

  { Scatter non-null IndvTeamID records. (ie. swimmers or relays }
  aEventType := uEvent.GetEventType;
  if (aEventType = etUnknown) then exit;

  { Sort order is fastest to slowest.
    Time not given or empty lane are always last. }
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;

  if (aEventType = etINDV) then
  {
    CASE:
    2 -- DEFINITION OF A EMPTY LANE (may even include erronous TTB!)
    1 -- INDV/TEAM without a TTB calculation.
    0 -- INDV/TEAM with TTB.
    Note: Sort order is ASC. Wit: INDV/TEAM with times
  }
  begin
    SQL := 'SELECT Entrant.TimeToBeat, CASE ' +
      'WHEN (Entrant.MemberID IS NULL) THEN 2 ' +
      'WHEN (CAST(CAST(Entrant.TimeToBeat AS DATETIME) AS FLOAT) = 0) THEN 1 ' +
      'ELSE 0 END AS mySort, Entrant.Lane, Entrant.EntrantID ' +
      'FROM Entrant WHERE Entrant.HeatID = :HEATID ' +
      'ORDER BY mySort, TimeToBeat ';
      qry.SQL.Text := SQL;
      qry.UpdateOptions.KeyFields := 'EntrantID';
      qry.UpdateOptions.UpdateTableName := 'SwimClubMeet2..Entrant';
  end
  else
  begin
    SQL := 'SELECT Team.TimeToBeat, CASE ' +
      'WHEN (Team.TeamNameID IS NULL) THEN 2 ' +
      'WHEN (CAST(CAST(Team.TimeToBeat AS DATETIME) AS FLOAT) = 0) THEN 1 ' +
      'ELSE 0 END AS mySort, Team.Lane, Team.TeamID ' +
      'FROM Team WHERE Team.HeatID = :HEATID ' +
      'ORDER BY mySort, TimeToBeat ';
      qry.SQL.Text := SQL;
      qry.UpdateOptions.KeyFields := 'TeamID';
      qry.UpdateOptions.UpdateTableName := 'SwimClubMeet2..Entrant';
  end;

  NumOfPoolLanes := uSwimClub.NumberOfLanes;

  { Do a lane count and pad if needed. }
  PadLanes(aHeatID);

  if (aEventType = etINDV) then CORE.dsLane.DataSet.DisableControls
  else CORE.dsTeam.DataSet.DisableControls;

  qry.IndexFieldNames := 'mySort;TimeToBeat';
  qry.ParamByName('HEATID').AsInteger := aHeatID;
  qry.Prepare;
  qry.Open;
  if qry.Active then
  begin
    i := 0; // NOTE: ScatterLanes is based 0
    while not qry.Eof do
    begin
      if (i < NumOfPoolLanes) then
      begin
        lane := SCMUtility.ScatterLanes(i, NumOfPoolLanes);
        qry.Edit;
        qry.FieldByName('Lane').AsInteger := lane;
        qry.Post;
      end
      else
      begin
        // Too many lanes in heat!
        if (aEventType = etINDV) then
        aIndvTeamID := qry.FieldByName('EntrantID').AsInteger
          else
        aIndvTeamID := qry.FieldByName('TeamID').AsInteger;
        {
          Remove erronous lane. Session must not be locked.
          Removes entrant\team splits and TeamEntrants (if found).
        }
				DeleteLane(uLane.PK);
      end;
      i := i + 1;
      qry.Next;
    end;
	end;
  qry.Close;
  qry.Free;

  if (aEventType = etINDV) then CORE.dsLane.DataSet.EnableControls
  else CORE.dsTeam.DataSet.EnableControls;
  result := i;
end;

procedure TSCM.scmConnectionAfterDisconnect(Sender: TObject);
begin
  FIsActive := false;
end;

function TSCM.SCM_VerInfoMajor: integer;
begin
  result := 0;
  if scmConnection.Connected then
  begin
    qrySCMSystem.Connection := scmConnection;
    qrySCMSystem.Open;
    if qrySCMSystem.Active then
        result := qrySCMSystem.FieldByName('Major').AsInteger;
    qrySCMSystem.Close;
  end;
end;

function TSCM.Split_HeatStatusID(aSplitID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not FIsActive then exit;
  if aSplitID > 0 then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet2].[dbo].[Heat] ' +
      'INNER JOIN Entrant ON [Heat].[HeatID] = Entrant.HeatID ' +
      'INNER JOIN Split ON [Entrant].[EntrantID] = [Split].[EntrantID] ' +
      'WHERE [Split].[SplitID] = :ID;';
    v := scmConnection.ExecSQLScalar(SQL, [aSplitID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;
end;

function TSCM.Split_SessionIsLocked(aSplitID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not FIsActive then exit;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet2].[dbo].[Session] ' +
    'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
    'INNER JOIN [Heat] ON [Event].[EventID] = [Heat].[EventID] '
    + 'INNER JOIN [Entrant] ON [Heat].[HeatID] = [Entrant].[HeatID] '
    + 'INNER JOIN [Split] ON [Entrnat].[EntrantID] = [Split].[EntrantID] ' +
    'WHERE [Split].[SplitID] = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aSplitID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
end;

function TSCM.StrikeSlot(aTeamEntrantID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventID, aMemberID: integer;
begin
  result := 0;
  if not FIsActive then exit;
  if aTeamEntrantID = 0 then exit;
  // FIND the MemberID
  SQL := 'SELECT MemberID FROM SwimClubMeet2.dbo.TeamEntrant ' +
  'WHERE TeamEntrantID = :ID';
  v := scmConnection.ExecSQLscalar(SQL, [aTeamEntrantID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
  begin
    aMemberID := v;
    // FIND the EventID
    SQL := 'SELECT [Heat].EventID FROM SwimClubMeet2.dbo.TeamEntrant ' +
    'INNER JOIN Team ON TeamEntrant.TeamID = Team.TeamID ' +
    'INNER JOIN Heat ON Team.HeatID = Heat.HeatID ' +
    'WHERE TeamEntrantID = :ID';
    v := scmConnection.ExecSQLscalar(SQL, [aTeamEntrantID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
    begin
      aEventID := v;
      // CLEAR TEAMENTRANT
      ClearSlot(aTeamEntrantID);
      // REMOVE NOMINATION
      result := DeleteNomination(aMemberID, aEventID);
    end;
  end;
end;

function TSCM.SwapLanes(IDA, IDB: integer; aEventType: scmEventType): Boolean;
begin
  result := false;
  if (IDA = IDB) then exit;
  if (IDA = 0) OR (IDB = 0) then exit;
  if aEventType = scmEventType.etINDV then
  begin
    qrySwapEntrants.Connection := scmConnection;
    qrySwapEntrants.ParamByName('ENTRANTIDA').AsInteger := IDA;
    qrySwapEntrants.ParamByName('ENTRANTIDB').AsInteger := IDB;
    qrySwapEntrants.Prepare;
    // does not return a cursor - hence execute (UPDATE).
    qrySwapEntrants.Execute();
  end
  else if aEventType = scmEventType.etTEAM then
  begin
    qrySwapTeams.Connection := scmConnection;
    qrySwapTeams.ParamByName('TEAMIDA').AsInteger := IDA;
    qrySwapTeams.ParamByName('TEAMIDB').AsInteger := IDB;
    qrySwapTeams.Prepare;
    // does not return a cursor - hence execute (UPDATE).
    qrySwapEntrants.Execute();
  end
  else exit;
  result := true;
end;

function TSCM.SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB: integer): Boolean;
var
  IDA, IDB: integer;
  EventType: scmEventType;
  SQL: string;
begin
  result := false;
  if not FIsActive then exit;
  EventType := uEvent.GetEventType;
  { TODO -oBSA -cGeneral : Create swap lane function }
  if EventType =  scmEventType.etINDV then // INDV
      SQL := 'SELECT TOP 1 [EntrantID] FROM [SwimClubMeet2].[dbo].[Entrant] ' +
      ' WHERE HeatID = :HEAT AND Lane = :LANE'
  else if EventType = scmEventType.etTEAM then
      SQL := 'SELECT TOP 1 [TeamID] FROM [SwimClubMeet2].[dbo].[Team] ' +
      ' WHERE HeatID = :HEAT AND Lane = :LANE'
  else exit;
  IDA := scmConnection.ExecSQLScalar(SQL, [HeatIDA, LaneA]);
  IDB := scmConnection.ExecSQLScalar(SQL, [HeatIDB, LaneB]);
  SwapLanes(IDA, IDB, EventType);
  result := true;
end;


function TSCM.TeamSplit_HeatStatusID(aSplitID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not FIsActive then exit;
  if aSplitID > 0 then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet2].[dbo].[Heat] ' +
      'INNER JOIN Team ON [Heat].[HeatID] = Team.HeatID ' +
      'INNER JOIN TeamSplit ON [Team].[TeamID] = [TeamSplit].[TeamID] ' +
      'WHERE [TeamSplit].[TeamSplitID] = :ID;';
    v := scmConnection.ExecSQLScalar(SQL, [aSplitID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;
end;

function TSCM.TeamSplit_SessionIsLocked(aTeamSplitID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not FIsActive then exit;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet2].[dbo].[Session] ' +
    'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
    'INNER JOIN [Heat] ON [Event].[EventID] = [Heat].[EventID] '
    + 'INNER JOIN [Team] ON [Heat].[HeatID] = [Team].[HeatID] ' +
    'INNER JOIN [TeamSplit] ON [Team].[TeamID] = [TeamSplit].[TeamID] ' +
    'WHERE [TeamSplit].[TeamSplitID] = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aTeamSplitID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
end;

function TSCM.Team_Locate(aTeamID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not FIsActive then exit;
  if (aTeamID = 0) then exit;
  SearchOptions := [];
  if CORE.dsTeam.DataSet.Active then
			result := CORE.dsTeam.DataSet.Locate('TeamID', aTeamID, SearchOptions);
end;

procedure TSCM.ToggleDCode(ADataSet: TDataSet; DoEnable: Boolean);
var
  fld: TField;
begin
  // Toggle FINA codes of simple scratch/disqualified
  with ADataSet do
  begin
    DisableControls;
    {
      When the Columns.State property of the grid is csDefault, grid columns
      are dynamically generated from the visible fields of the dataset and the
      order of columns in the grid matches the order of fields in the dataset.
    }
    if DoEnable then
    begin
      fld := Fields.FindField('IsDisqualified');
      if Assigned(fld) then fld.Visible := false;
      fld := Fields.FindField('IsScratched');
      if Assigned(fld) then fld.Visible := false;
      fld := Fields.FindField('DCode');
      if Assigned(fld) then fld.Visible := true;
    end
    else
    begin
      fld := Fields.FindField('IsDisqualified');
      if Assigned(fld) then fld.Visible := true;
      fld := Fields.FindField('IsScratched');
      if Assigned(fld) then fld.Visible := true;
      fld := Fields.FindField('DCode');
      if Assigned(fld) then fld.Visible := false;
    end;
    EnableControls;
  end;
end;

function TSCM.UpdateDCodes: boolean;
var
s: string;
v: variant;
i: integer;
begin
  result := false;
  if not FIsActive then exit;

  {TEST for DCODE TYPE 8}
  i := GetDCodeTypeSCM(); // Missing SCM SPECIAL DCODE. Record Number 8.
  if (i = 0) then
  begin
    s :=
      'SET IDENTITY_INSERT  [dbo].[DisqualifyType] ON;' +
      'INSERT INTO DisqualifyType ' +
      '( [DisqualifyTypeID], [Caption], [StrokeID]  ) ' +
      'VALUES ' +
      '(8, N''SCM'',NULL); ' +
      'SET IDENTITY_INSERT  [dbo].[DisqualifyType] OFF; ';
    v := SCM.scmConnection.ExecSQL(s);

    result := true;
  end;
  if (i = 0) then   // ASSERT STROKE ID's. DEFAULT SYSTEM RECORDS.
  begin
    s := // Freestyle
      'UPDATE [dbo].[DisqualifyType] SET ' +
      '[StrokeID] = 1 ' +
      'WHERE [DisqualifyTypeID] = 2 ';
    v := SCM.scmConnection.ExecSQL(s);
    s := // BackStroke
      'UPDATE [dbo].[DisqualifyType] SET ' +
      '[StrokeID] = 2 ' +
      'WHERE [DisqualifyTypeID] = 3 ';
    v := SCM.scmConnection.ExecSQL(s);
    s := // BreastStroke
      'UPDATE [dbo].[DisqualifyType] SET ' +
      '[StrokeID] = 3 ' +
      'WHERE [DisqualifyTypeID] = 4 ';
    v := SCM.scmConnection.ExecSQL(s);
    s := // INDV Butterfly
      'UPDATE [dbo].[DisqualifyType] SET ' +
      '[StrokeID] = 4 ' +
      'WHERE [DisqualifyTypeID] = 5 ';
    v := SCM.scmConnection.ExecSQL(s);
    s := // INDV medley
      'UPDATE [dbo].[DisqualifyType] SET ' +
      '[StrokeID] = 5 ' +
      'WHERE [DisqualifyTypeID] = 6 ';
    v := SCM.scmConnection.ExecSQL(s);
  end;

  { TEST for DCODES ... ScmA}
  i := GetIsScratchedDCode();
  if (i = 0) then // didn't find DCODE.
  begin
    s :=
      'INSERT INTO DisqualifyCode ' +
      '( [Caption], [ABREV], [DisqualifyTypeID] ) ' +
      'VALUES ' +
      '(N''Swimmer did not show for event. Scratched'', N''ScmA'', 8);';
    v := SCM.scmConnection.ExecSQL(s);
    result := true;
  end;
  i := GetIsDisqualifiedDCode();
  if (i = 0) then // didn't find DCODE.
  begin
    s :=
      'INSERT INTO DisqualifyCode ' +
      '( [Caption], [ABREV], [DisqualifyTypeID] ) ' +
      'VALUES ' +
      '(N''Unspecified disqualification.. (Simplified method.)'', N''ScmB'', 8);';
    v := SCM.scmConnection.ExecSQL(s);
    result := true;
  end;
end;

procedure TSCM.WndProc(var wndMsg: TMessage);
begin
{
    case wndMsg.Msg of
      SCM_RENUMBERHEATS:
        begin
          // go renumber the heats table....
          RenumberHeats(false);
        end;
    end;
}
end;










end.
