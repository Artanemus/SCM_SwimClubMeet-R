unit dmSCM;

interface

uses
  System.SysUtils, System.Classes,

  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, dmSCMNom;

type
  TSCM = class(TDataModule)
    BooleanField1: TBooleanField;
    BooleanField2: TBooleanField;
    dsContactNum: TDataSource;
    dsEntrant: TDataSource;
    dsEvent: TDataSource;
    dsFNameEllipse: TDataSource;
    dsHeat: TDataSource;
    dsIsQualified: TDataSource;
    dsMember: TDataSource;
    dsNomateEvent: TDataSource;
    dsNominateControlList: TDataSource;
    dsNominateMembers: TDataSource;
    dsNominee: TDataSource;
    dsSession: TDataSource;
    dsSwimClub: TDataSource;
    dsTeam: TDataSource;
    dsTeamEntrant: TDataSource;
    IntegerField1: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    luDisqualifyCode: TDataSource;
    luDistance: TDataSource;
    luEventStatus: TDataSource;
    luEventType: TDataSource;
    luFName: TDataSource;
    luGender: TDataSource;
    luHeatStatus: TDataSource;
    luHeatType: TDataSource;
    luHouse: TDataSource;
    luSessionStatus: TDataSource;
    luStroke: TDataSource;
    luSwimmerCAT: TDataSource;
    qryContactNum: TFDQuery;
    qryCountEventsNotClosed: TFDQuery;
    qryCountHeatsNotClosed: TFDQuery;
    qryEntrant: TFDQuery;
    qryEntrantCATID: TIntegerField;
    qryEntrantCount: TFDQuery;
    qryEntrantDCode: TWideStringField;
    qryEntrantDisqualifyCodeID: TIntegerField;
    qryEntrantEntrantID: TFDAutoIncField;
    qryEntrantFullName: TWideStringField;
    qryEntrantHeatID: TIntegerField;
    qryEntrantIsDisqualified: TBooleanField;
    qryEntrantIsScratched: TBooleanField;
    qryEntrantLane: TIntegerField;
    qryEntrantluSwimmerCAT: TStringField;
    qryEntrantMemberID: TIntegerField;
    qryEntrantPersonalBest: TTimeField;
    qryEntrantTIME: TTimeField;
    qryEntrantTimeToBeat: TTimeField;
    qryEvent: TFDQuery;
    qryEventABREV: TWideStringField;
    qryEventCaption: TWideStringField;
    qryEventClosedDT: TSQLTimeStampField;
    qryEventDistanceID: TIntegerField;
    qryEventEntrantCount: TIntegerField;
    qryEventEventID: TFDAutoIncField;
    qryEventEventNum: TIntegerField;
    qryEventEventStatusID: TIntegerField;
    qryEventEventStr: TWideStringField;
    qryEventluDistance: TStringField;
    qryEventluEventStatus: TStringField;
    qryEventluStroke: TStringField;
    qryEventMeters: TIntegerField;
    qryEventNomineeCount: TIntegerField;
    qryEventScheduleDT: TTimeField;
    qryEventSessionID: TIntegerField;
    qryEventStrokeID: TIntegerField;
    qryFName: TFDQuery;
    qryFNameEllipse: TFDQuery;
    qryGetNextHeat: TFDQuery;
    qryGetPrevHeat: TFDQuery;
    qryHeat: TFDQuery;
    qryHeatClosedDT: TSQLTimeStampField;
    qryHeatCount: TFDQuery;
    qryHeatcStatus: TWideStringField;
    qryHeatEventID: TIntegerField;
    qryHeatHeatID: TFDAutoIncField;
    qryHeatHeatNum: TIntegerField;
    qryHeatHeatStatusID: TIntegerField;
    qryHeatHeatTypeID: TIntegerField;
    qryHeatLaneCount: TFDQuery;
    qryIsQualified: TFDQuery;
    qryIsQualifiedALT: TFDQuery;
    qryIsSafeToDelEvent: TFDQuery;
    qryIsSafeToDelSession: TFDQuery;
    qryMember: TFDQuery;
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
    qryNominee: TFDQuery;
    qryNomineeCount: TFDQuery;
    qryRenumberHeats: TFDQuery;
    qrySCMSystem: TFDQuery;
    qrySession: TFDQuery;
    qrySessionCaption: TWideStringField;
    qrySessionClosedDT: TSQLTimeStampField;
    qrySessionEntrantCount: TFDQuery;
    qrySessionNomineeCount: TFDQuery;
    qrySessionSessionID: TFDAutoIncField;
    qrySessionSessionStart: TSQLTimeStampField;
    qrySessionSessionStatusID: TIntegerField;
    qrySessionStatus: TWideStringField;
    qrySessionSwimClubID: TIntegerField;
    qrySortHeat: TFDQuery;
    qrySortHeat_EmptyLanes: TFDQuery;
    qrySwapEntrants: TFDQuery;
    qrySwimClub: TFDQuery;
    qryTeam: TFDQuery;
    qryTeamEntrant: TFDQuery;
    qryTeamEntrantluStroke: TStringField;
    qryTeamEntrantStrokeID: TIntegerField;
    qryTeamEntrantSwimOrder: TIntegerField;
    qryTeamEntrantTeamEntrantID: TFDAutoIncField;
    qryTeamEntrantTeamID: TIntegerField;
    qryTeamHeatLaneCount: TFDQuery;
    qryTeamTeamID: TFDAutoIncField;
    qryTeamTeamName: TWideStringField;
    qryTeamTeamNameID: TIntegerField;
    qryTestForNominees: TFDQuery;
    scmConnection: TFDConnection;
    tblDisqualifyCode: TFDTable;
    tblDistance: TFDTable;
    tblEventStatus: TFDTable;
    tblEventType: TFDTable;
    tblGender: TFDTable;
    tblHeatStatus: TFDTable;
    tblHeatType: TFDTable;
    tblHouse: TFDTable;
    tblSessionStatus: TFDTable;
    tblStroke: TFDTable;
    tblSwimmerCAT: TFDTable;
    TimeField1: TTimeField;
    TimeField2: TTimeField;
    TimeField3: TTimeField;
    TimeField4: TTimeField;
    TimeField5: TTimeField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    qryEventEventTypeID: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryEntrantAfterScroll(DataSet: TDataSet);
    procedure qryEntrantBeforeInsert(DataSet: TDataSet);
    procedure qryEntrantTIMEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryEntrantTIMESetText(Sender: TField; const Text: string);
    procedure qryEventAfterDelete(DataSet: TDataSet);
    procedure qryEventAfterPost(DataSet: TDataSet);
    procedure qryEventAfterScroll(DataSet: TDataSet);
    procedure qryEventBeforeEdit(DataSet: TDataSet);
    procedure qryEventBeforePost(DataSet: TDataSet);
    procedure qryEventDistanceIDValidate(Sender: TField);
    procedure qryEventEventStatusIDGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryEventNewRecord(DataSet: TDataSet);
    procedure qryEventScheduleDTGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryEventScheduleDTSetText(Sender: TField; const Text: string);
    procedure qryHeatAfterDelete(DataSet: TDataSet);
    procedure qryHeatAfterPost(DataSet: TDataSet);
    procedure qryHeatAfterScroll(DataSet: TDataSet);
    procedure qryHeatNewRecord(DataSet: TDataSet);
    procedure qryMemberQuickPickAfterScroll(DataSet: TDataSet);
    procedure qryNominateMembersAfterScroll(DataSet: TDataSet);
    procedure qrySessionAfterDelete(DataSet: TDataSet);
    procedure qrySessionAfterPost(DataSet: TDataSet);
    procedure qrySessionAfterScroll(DataSet: TDataSet);
    procedure qrySessionBeforePost(DataSet: TDataSet);
    procedure qrySessionNewRecord(DataSet: TDataSet);
    procedure qrySessionSessionStartGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qrySessionSessionStartSetText(Sender: TField; const Text: string);
    procedure scmConnectionAfterDisconnect(Sender: TObject);
  private
    { Private declarations }
    fLastDistanceID: integer;
    fLastStrokeID: integer;
    fSCMActive: Boolean;
    prefGenerateEventDescription: Boolean;
    prefGenerateEventDescStr: string;
    procedure Entrant_ClearLane(aEntrantID: integer);
    procedure Entrant_CreateEmptyLane(aHeatID, aLane: integer);
    function Entrant_EmptyLane(): Boolean;
    procedure ReadPreferences(IniFileName: string);
    procedure TEAM_ClearLane(aTeamID: integer);
    procedure TEAM_CreateEmptyLane(aHeatID, aLane: integer);
    function TEAM_EmptyLane(): Boolean;
  public
    { Public declarations }
    procedure ActivateTable();
    procedure DeActivateTable();
    function EmptyLane(): Boolean;
    // ENTRANT  INDV - INDIVIDUAL LANES (ENTRANTS)
    function Entrant_CountLanes(aHeatID: integer): integer;
    procedure Entrant_Delete(aEntrantID: integer);
    procedure Entrant_DeleteALL(aHeatID: integer);
    procedure Entrant_DeleteALLExclude(aHeatID: integer;
      DoExclude: Boolean = true); // exclude closed or raced heats
    procedure Entrant_DeleteExcessLanes(aHeatID: integer);
    procedure Entrant_DeleteExclude(aEntrantID: integer;
      DoExclude: Boolean = true); // exclude closed or raced heats
    function Entrant_HeatStatusID(aEntrantID: integer): integer;
    procedure Entrant_InsertEmptyLanes(aHeatID: integer);
    function Entrant_Locate(EntrantID: integer): Boolean;
    function Entrant_NextAvailLaneNum(aHeatID, aSeedNumber: integer): integer;
    procedure Entrant_PadWithEmptyLanes(aHeatID: integer);
    procedure Entrant_RenumberLanes(aHeatID: integer);
    function Entrant_Sort(aHeatID: integer): Boolean;
    function Entrant_Strike(): Boolean;
    // EVENTS
    function Event_AllHeatsAreClosed(aEventID: integer): Boolean;
    procedure Event_Delete(aEventID: integer);
    procedure Event_FNameEllipse();
    function Event_GetEntrantCount(aEventID: integer): integer;
    function Event_GetHeatCount(aEventID: integer): integer;
    function Event_GetNomineeCount(aEventID: integer): integer;
    function Event_HasClosedHeats(): Boolean; // current event
    function Event_HasNominee(EventID, MemberID: integer): Boolean;
    function Event_HasNominees(EventID: integer): Boolean;
    function Event_HasRacedHeats(): Boolean; // current event
    function Event_ID(): integer;
    function Event_IsINDV(): Boolean; // current event
    function Event_IsSafeToDelete(aEventID: integer): Boolean;
    function Event_IsTEAM(): Boolean; // current event
    function Event_Locate(aEventID: integer): Boolean; overload;
    function Event_Locate(aDistanceID, aStrokeID: integer): Boolean; overload;
    procedure Event_Renumber(DoLocate: Boolean = true);
    function Event_TypeID(aEventID: integer): integer; // INDV...TEAM
    // HEATS
    procedure Heat_Delete(aHeatID: integer); // delete heat
    procedure Heat_DeleteALL(aEventID: integer); // delete ALL heats in event
    procedure Heat_DeleteALLExclude(aEventID: integer;
      DoExclude: Boolean = true); // exclude closed or raced heats
    function Heat_ID(): integer;
    function Heat_IsClosed(): Boolean; // current heat
    function Heat_IsRaced(): Boolean; // current heat
    function Heat_Locate(aHeatID: integer): Boolean;
    procedure Heat_NewRecord();
    function Heat_NextID(aHeatID: integer): integer; // uses HeatNum
    function Heat_PrevID(aHeatID: integer): integer; // uses HeatNum
    procedure Heat_Renumber(DoLocate: Boolean = true);
    function Heat_StatusID(aHeatID: integer): integer;
    procedure Heat_ToggleStatus(); // current heat
    procedure Heat_UpdateStatusBar();
    function IsFirstRecord(ADataSet: TDataSet): Boolean;
    function IsLastRecord(ADataSet: TDataSet): Boolean;
    // MEMBER
    function Member_IsQualified(aMemberID, aGenderID, aQualifyDistID,
      aStrokeID: integer; IsShortCourse: Boolean): Boolean;
    // NOMINATE
    function Nominate_Locate(MemberID: integer): Boolean;
    function Nominate_LocateEventNum(ADataSet: TDataSet;
      EventNum: integer): Boolean;
    function Nominate_SortMembers(SortState: Boolean): Boolean;
    function Nominate_UpdateControlList(SessionID, MemberID: integer): Boolean;
    // NOMINEE
    procedure Nominee_Delete(aNomineeID, aEventID: integer);
    procedure Nominee_DeleteALL(aEventID: integer);
    function Nominee_InEvent(aNomineeID, aEventID: integer): integer;
    // SWIMCLUBMEET SYSTEM
    function SCM_VerInfoMajor(): integer;
    // SESSION
    function Session_AllEventsAreClosed(aSessionID: integer): Boolean;
    function Session_GetEntrantCount(aSessionID: integer): integer;
    function Session_GetNomineeCount(aSessionID: integer): integer;
    procedure Session_HideLocked(IsChecked: Boolean);
    function Session_ID(): integer;
    function Session_IsLocked: Boolean; // current session
    function Session_IsSafeToDelete(aSessionID: integer): Boolean;
    function Session_Locate(SessionID: integer): Boolean;
    function Session_Start(): TDateTime; overload;
    function Session_Start(SessionID: integer): TDateTime; overload;
    procedure Session_ToggleLockState();
    // SPLIT  (INDV + TEAM)
    procedure Split_DeleteALLSplitTimesINDV(aEntrantID: integer);
    procedure Split_DeleteALLSplitTimesTEAM(aTeamID: integer);
    // SWAP  - ENTRANTS (INDV ONLY)
    function SwapLanes(EntrantIDA, EntrantIDB: integer): Boolean; overload;
    function SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB: integer)
      : Boolean; overload;
    function SwapMoveDown(EntrantDS: TDataSet): Boolean;
    function SwapMoveDownHeat(EntrantDS: TDataSet): Boolean;
    function SwapMoveUp(EntrantDS: TDataSet): Boolean;
    function SwapMoveUpHeat(EntrantDS: TDataSet): Boolean;
    // SWIMCLUB
    function SwimClub_ClubName(): string;
    function SwimClub_ID(): integer;
    function SwimClub_IsShortCourse(): Boolean; // current club
    procedure SwimClub_Locate(SwimClubID: integer);
    function SwimClub_NickName: string;
    function SwimClub_NumberOfLanes(): integer;
    function SwimClub_SessionCount(SwimClubID: integer;
      SDate, EDate: TDateTime): integer;
    function SwimClub_StartOfSwimSeason(): TDateTime; overload;
    function SwimClub_StartOfSwimSeason(SwimClubID: integer)
      : TDateTime; overload;
    // TEAMENTRANT (TEAMS-RELAYS)
    procedure TEAMENTRANT_Delete(aTeamEntrantID: integer);
    procedure TEAMENTRANT_DeleteALL(aTeamID: integer);
    // TEAM LANES (RELAYS)
    function TEAM_CountLanes(aHeatID: integer): integer;
    procedure TEAM_Delete(aTeamID: integer);
    procedure TEAM_DeleteALL(aHeatID: integer);
    procedure TEAM_DeleteALLExclude(aHeatID: integer;
      DoExclude: Boolean = true); // exclude closed or raced heats
    procedure TEAM_DeleteExcessLanes(aHeatID: integer);
    procedure TEAM_DeleteExclude(aTeamID: integer; DoExclude: Boolean);
    // exclude closed or raced heats
    function TEAM_HeatStatusID(aTeamID: integer): integer;
    procedure TEAM_InsertEmptyLanes(aHeatID: integer);
    function TEAM_Locate(TeamID: integer): Boolean;
    function TEAM_NextAvailLaneNum(aHeatID, aSeedNumber: integer): integer;
    procedure TEAM_PadWithEmptyLanes(aHeatID: integer);
    procedure TEAM_RenumberLanes(aHeatID: integer);
    function TEAM_Sort(aHeatID: integer): Boolean;
    function TEAM_Strike(): Boolean;
  published
    property SCMActive: Boolean read fSCMActive write fSCMActive;
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
  System.Variants, System.StrUtils, System.Types, System.Math, Winapi.Windows,
  SCMDefines, vcl.Forms, vcl.StdCtrls, System.UITypes;

{ TSCM }

procedure TSCM.ActivateTable;
begin
  // -----------------------------------------------------------
  // 24/04/2020 Always ASSERT fSCMActive state.
  // -----------------------------------------------------------
  fSCMActive := false;
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
    tblHouse.Active := true;
    tblSessionStatus.Active := true;
    tblStroke.Active := true;
    tblDistance.Active := true;
    tblEventType.Active := true;
    tblEventStatus.Active := true;
    tblGender.Active := true;
    tblHeatType.Active := true;
    tblHeatStatus.Active := true;
    tblDisqualifyCode.Active := true;
    tblSwimmerCAT.Active := true;

    qrySwimClub.Close;
    qrySwimClub.ParamByName('SWIMCLUBID').AsInteger := 1;
    qrySwimClub.Prepare;
    qrySwimClub.Open;
    if (qrySwimClub.Active) then
    begin
      qrySession.Open;
      if (qrySession.Active) then
      begin
        qryMember.Open;
        if (qryMember.Active) then
        begin
          // contact numbers - non critical
          qryContactNum.Open;
          (*
            if (GetVerInfoMajor < 6) and (GetVerInfoMinor < 2) then
            begin
            // need to remove field-name ScheduleDT
            fld := qryEvent.Fields.FindField('ScheduleDT');
            if Assigned(fld) then qryEvent.Fields.Remove(fld);
            end;
          *)
          qryEvent.Open; // EVENT
          if (qryEvent.Active) then
          begin
            // DEPENDANTS OF EVENT
            qryNominee.Open;
            qryHeat.Open;
            if (qryHeat.Active) and (qryNominee.Active) then
            begin
              qryTeam.Open;
              qryTeamEntrant.Open;
              qryEntrant.Open;
              if (qryEntrant.Active) then
              begin
                fSCMActive := true;
              end;
            end;
          end;
        end;
      end;
    end;

    qryNominateEvent.Active := true;
    qryNominateMembers.Active := true;
    qryFName.Active := true;
    qryFNameEllipse.Active := true;
    qryNominateMembers.Active := true;
    qryNominateControlList.Active := true;
    // ---------------------------------------------
    // NOMINATE
    // ---------------------------------------------
    if (fSCMActive = false) then
      MessageDlg('During activation of the database module' + slinebreak +
        'not all essential tables opened successfully!', mtWarning, [mbOK], 0);
  end;
end;

procedure TSCM.DataModuleCreate(Sender: TObject);
var
  IniFileName: string;
begin
  fSCMActive := false;
  fLastDistanceID := 0;
  fLastStrokeID := 0;
  prefGenerateEventDescription := false;;
  prefGenerateEventDescStr := '';
  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then
    ReadPreferences(IniFileName);
end;

procedure TSCM.DeActivateTable;
begin
  fSCMActive := false;
  // CORE PARENT..CHILD TABLES
  qryTeamEntrant.Close;
  qryTeam.Close;
  qryEntrant.Close;
  qryHeat.Close;
  qryNominee.Close;
  qryEvent.Close;
  qrySession.Close;
  qryContactNum.Close;
  qryMember.Close;
  qrySwimClub.Close;
  // SUPPORT-LOOKUP TABLES
  tblSessionStatus.Active := false;
  tblStroke.Active := false;
  tblDistance.Active := false;
  tblEventType.Active := false;
  tblEventStatus.Active := false;
  tblGender.Active := false;
  tblHeatType.Active := false;
  tblHeatStatus.Active := false;
  qryFName.Active := false;
  qryFNameEllipse.Active := false;
  tblHouse.Active := false;
  qryNominateEvent.Active := false;
  qryNominateMembers.Active := false;
end;

function TSCM.EmptyLane: Boolean;
begin
  if SCM.Event_IsINDV then
    result := Entrant_EmptyLane
  else
    result := TEAM_EmptyLane;
end;

procedure TSCM.Entrant_ClearLane(aEntrantID: integer);
var
  SearchOptions: TLocateOptions;
  tbl: TFDTable;
  success: Boolean;
begin
  if not fSCMActive then
    exit;
  if (aEntrantID = 0) then
    exit;
  tbl := TFDTable.Create(self);
  tbl.Connection := scmConnection;
  tbl.TableName := 'Entrant';
  tbl.IndexFieldNames := 'EntrantID';
  tbl.Open;
  if (tbl.Active) then
  begin
    SearchOptions := [];
    success := tbl.Locate('EntrantID', aEntrantID, SearchOptions);
    if (success) then
    begin
      tbl.Edit;
      tbl.FieldByName('MemberID').Clear;
      tbl.FieldByName('DisqualifyCodeID').Clear;
      tbl.FieldByName('RaceTime').Clear;
      tbl.FieldByName('TimeToBeat').Clear;
      tbl.FieldByName('PersonalBest').Clear;
      tbl.FieldByName('IsDisqualified').AsBoolean := false;
      tbl.FieldByName('IsScratched').AsBoolean := false;
      tbl.Post;
      { TODO -oBSA -cGeneral : TEST - CLEAR SPLIT TIMES }
      Split_DeleteALLSplitTimesINDV(aEntrantID);
    end;
  end;
  tbl.Close;
  tbl.Free;
end;

function TSCM.Entrant_CountLanes(aHeatID: integer): integer;
begin
  { TODO -oBSA -cGeneral : original C++ code init result as -1 }
  result := 0;
  if not fSCMActive then
    exit;
  qryHeatLaneCount.Close;
  qryHeatLaneCount.ParamByName('HeatID').AsInteger := aHeatID;
  qryHeatLaneCount.Prepare;
  qryHeatLaneCount.Open;
  if (qryHeatLaneCount.Active) then
    if not qryHeatLaneCount.IsEmpty then
      result := qryHeatLaneCount.FieldByName('Count_Lane').AsInteger;
  qryHeatLaneCount.Close;
end;

procedure TSCM.Entrant_CreateEmptyLane(aHeatID, aLane: integer);
var
  tbl: TFDTable;
begin
  if not fSCMActive then
    exit;
  tbl := TFDTable.Create(self);
  tbl.Connection := scmConnection;
  tbl.TableName := 'Entrant';
  tbl.IndexFieldNames := 'EntrantID';
  tbl.Open;
  if (tbl.Active) then
  begin
    tbl.Insert;
    tbl.FieldByName('HeatID').AsInteger := aHeatID;
    tbl.FieldByName('Lane').AsInteger := aLane;
    tbl.FieldByName('IsDisqualified').AsBoolean := false;
    tbl.FieldByName('IsScratched').AsBoolean := false;
    tbl.Post;
  end;
  tbl.Close;
  tbl.Free;
end;

procedure TSCM.Entrant_Delete(aEntrantID: integer);
begin
  Entrant_DeleteExclude(aEntrantID, false); // Ignore HeatStatusID
end;

procedure TSCM.Entrant_DeleteALL(aHeatID: integer);
begin
  Entrant_DeleteALLExclude(aHeatID, false);
end;

procedure TSCM.Entrant_DeleteALLExclude(aHeatID: integer;
  DoExclude: Boolean = true);
var
  SQL: string;
  qry: TFDQuery;
  aEntrantID: integer;
begin
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text :=
    'SELECT [Entrant].[EntrantID], [HeatIndividual].[HeatStatusID] ' +
    'FROM [SwimClubMeet].[dbo].[Entrant] ' +
    'INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.HeatID ' +
    'WHERE [Entrant].HeatID = ' + IntToStr(aHeatID);
  qry.IndexFieldNames := 'EntrantID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aEntrantID := qry.FieldByName('EntrantID').AsInteger;
      if (qry.FieldByName('HeatStatusID').AsInteger = 1) or (DoExclude = false)
      then
        Entrant_DeleteExclude(aEntrantID, DoExclude);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

procedure TSCM.Entrant_DeleteExcessLanes(aHeatID: integer);
var
  NumOfLanes, i: integer;
begin
  if not fSCMActive then
    exit;
  // create empty lanes
  NumOfLanes := SwimClub_NumberOfLanes;
  with dsEntrant.DataSet do
  begin
    // TODO: Store current EntrantID for later locate
    // (or let caller deal with it?)
    DisableControls;
    First;
    i := 1;
    while not Eof do
    begin
      i := i + 1;
      Next;
      if (i > NumOfLanes) then
        break;
    end;
    if i > NumOfLanes then
    begin
      // Resynchronizes the dataset to make the next undeleted record active.
      // If the record deleted was the last record in the dataset, then the
      // previous record becomes the current record.
      while not dsEntrant.DataSet.Eof do
      begin
        Entrant_EmptyLane; // nomination remains alive.
        dsEntrant.DataSet.Delete;
      end;
    end;
    EnableControls;
  end;
end;

procedure TSCM.Entrant_DeleteExclude(aEntrantID: integer; DoExclude: Boolean);
var
  SQL: string;
  qry: TFDQuery;
  HeatStatusID: integer;
begin
  HeatStatusID := Entrant_HeatStatusID(aEntrantID);
  if (HeatStatusID = 1) or (DoExclude = false) then
  begin
    dsEntrant.DataSet.DisableControls;
    // DELETE SPLIT TIMES
    Split_DeleteALLSplitTimesINDV(aEntrantID);
    // FINALLY DELETE ENTRANT RECORDS
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[Entrant] WHERE [EntrantID] = :ID';
    scmConnection.ExecSQL(SQL, [aEntrantID]);
    dsEntrant.DataSet.EnableControls;
  end;
end;

function TSCM.Entrant_EmptyLane: Boolean;
var
  EntrantID: integer;
  nom: TSCMNom;
begin
  result := false;
  with dsEntrant.DataSet do
  begin
    DisableControls;
    CheckBrowseMode; // post any changes
    EntrantID := FieldByName('EntrantID').AsVariant;
    nom := TSCMNom.CreateWithConnection(self, scmConnection);
    if Assigned(nom) then
    begin
      nom.EmptyLane(EntrantID);
      result := true;
    end;
    nom.Free;
    { TODO -oBSA -cGeneral : nomination has been cleared - what about entrant lane? }
    // Entrant_ClearLane(EntrantID);
    { TODO -oBSA -cGeneral : Requires a refresh of the entrant table ? }
    Refresh;
    // cue-to ID
    Entrant_Locate(EntrantID);
    EnableControls;
  end;
end;

function TSCM.Entrant_HeatStatusID(aEntrantID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if aEntrantID > 0 then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet].[dbo].[Entrant] ' +
      'INNER JOIN HeatIndividual ON [Entrant].[HeatID] = ' +
      '[HeatIndividual].[HeatID] WHERE [Entrant].[EntrantID] = :ID;';
    v := scmConnection.ExecSQLScalar(SQL, [aEntrantID]);
    if not VarIsEmpty(v) or not VarIsNull(v) then
      result := v;
  end;
end;

procedure TSCM.Entrant_InsertEmptyLanes(aHeatID: integer);
var
  i, LanesToBuild: integer;
begin
  // CALLED BY : qryHeat AfterInsert ...
  // New heats, do not have any lanes assigned to them.
  // BUILD POOL LANES in entrant table.
  if not fSCMActive then
    exit;
  LanesToBuild := SwimClub_NumberOfLanes;
  dsEntrant.DataSet.DisableControls;
  for i := 1 to LanesToBuild do
    Entrant_CreateEmptyLane(aHeatID, i);
  dsEntrant.DataSet.EnableControls;
end;

function TSCM.Entrant_Locate(EntrantID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then
    exit;
  if (EntrantID = 0) then
    exit;
  SearchOptions := [];
  if dsEntrant.DataSet.Active then
    result := dsEntrant.DataSet.Locate('EntrantID', EntrantID, SearchOptions);
end;

function TSCM.Entrant_NextAvailLaneNum(aHeatID, aSeedNumber: integer): integer;
var
  i, rtnValue: integer;
  NumOfLanes: integer;
  SQL: string;
begin
  result := 0;
  NumOfLanes := dsSwimClub.DataSet.FieldByName('NumOfLanes').AsInteger;
  if aSeedNumber <= NumOfLanes then
  begin
    for i := aSeedNumber to NumOfLanes do
    begin
      SQL := 'SELECT Lane FROM SwimClubMeet.dbo.Entrant WHERE Lane = ' +
        IntToStr(i) + ' AND HeatID = ' + IntToStr(aHeatID);
      // returns variant. NULL or nil values equate to 0
      rtnValue := scmConnection.ExecSQLScalar(SQL);
      // lane number not found.
      if (rtnValue <> i) then
      begin
        result := i;
        exit;
      end;
    end;
  end;
  // No in range lane numbers found - find the max, then add 1.
  if (result = 0) then
  begin
    SQL := 'SELECT MAX(Lane) AS Lane FROM SwimClubMeet.dbo.Entrant WHERE HeatID = '
      + IntToStr(aHeatID);
    rtnValue := scmConnection.ExecSQLScalar(SQL);
    result := rtnValue + 1;
  end;
end;

procedure TSCM.Entrant_PadWithEmptyLanes(aHeatID: integer);
var
  NumOfLanes, CountLanesInHeat, i, j, LanesToBuild: integer;
begin
  if not fSCMActive then
    exit;
  j := 1;
  // create empty lanes
  NumOfLanes := SwimClub_NumberOfLanes;
  CountLanesInHeat := Entrant_CountLanes(aHeatID);

  if (CountLanesInHeat > NumOfLanes) then
  begin
    // message - too many lanes.
    // Store curr EntrantID
    dsEntrant.DataSet.DisableControls;
    dsEntrant.DataSet.First;
    i := 1;
    while not dsEntrant.DataSet.Eof do
    begin
      i := i + 1;
      dsEntrant.DataSet.Next;
      if (i > NumOfLanes) then
        break;
    end;
    if i > NumOfLanes then
    begin
      // Resynchronizes the dataset to make the next undeleted record active.
      // If the record deleted was the last record in the dataset, then the
      // previous record becomes the current record.
      while not dsEntrant.DataSet.Eof do
      begin
        Entrant_EmptyLane;
        dsEntrant.DataSet.Delete;
      end;
    end;

    dsEntrant.DataSet.EnableControls;
  end;

  if (CountLanesInHeat < NumOfLanes) then
  begin
    dsEntrant.DataSet.DisableControls;
    // test for correct number of lanes ...
    LanesToBuild := NumOfLanes - CountLanesInHeat;
    for i := 1 to LanesToBuild do
    begin
      j := Entrant_NextAvailLaneNum(aHeatID, j);
      Entrant_CreateEmptyLane(aHeatID, j);
    end;
    dsEntrant.DataSet.EnableControls;
  end;
end;

procedure TSCM.Entrant_RenumberLanes(aHeatID: integer);
var
  i: integer;
  s: String;
  qry: TFDQuery;
begin
  if not fSCMActive then
    exit;
  s := 'SELECT [EntrantID], [Lane] FROM [dbo].[Entrant] ';
  s := s + 'WHERE HeatID = ' + IntToStr(aHeatID) + ' ORDER BY [Lane]';
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := s;
  qry.IndexFieldNames := 'EntrantID';
  qry.UpdateOptions.KeyFields := 'EntrantID';
  qry.UpdateOptions.UpdateTableName := 'SwimClubMeet..Entrant';
  qry.Open;
  if qry.Active then
  begin
    i := 1;
    // RENUMBER ENTRANT LANES
    while not qry.Eof do
    begin
      qry.Edit;
      qry.FieldByName('Lane').AsInteger := i;
      qry.Post;
      i := i + 1;
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

function TSCM.Entrant_Sort(aHeatID: integer): Boolean;
var
  s: string;
  i, lane, NumOfLanes: integer;
  DoDelete: Boolean;
begin
  { TODO -oBSa -cGeneral : Check entrant sort is working. }
  result := false;
  if not fSCMActive then
    exit;
  i := 0;
  DoDelete := false;
  NumOfLanes := SwimClub_NumberOfLanes;
  if (NumOfLanes = 0) then
    exit;

  dsEntrant.DataSet.DisableControls;

  // STEP 1 :
  // ASSIGN LANES TO ENTRANTS ....
  // ------------------------------------------------------------------
  qrySortHeat.Close;
  qrySortHeat.ParamByName('HEATID').AsInteger := aHeatID;
  qrySortHeat.Prepare;
  qrySortHeat.Open;
  if (qrySortHeat.Active) then
  begin
    qrySortHeat.Last;
    // TRAP - TOO MANY ENTRANTS - LET USER DECIDE WHO TO REMOVE ....
    if (qrySortHeat.RecordCount > NumOfLanes) then
    begin
      qrySortHeat.Close;
      MessageDlg('The number of entrants exceeds the number of lanes.' +
        slinebreak +
        'Clear entrants (Empty Lanes) and then re-perform the "Sort"', mtError,
        [mbOK], 0);
      dsEntrant.DataSet.EnableControls;
      exit;
    end;
    qrySortHeat.First;
    i := 0; // NOTE: ScatterLanes is based 0
    while not qrySortHeat.Eof do
    begin
      lane := SCMUtility.ScatterLanes(i, NumOfLanes);
      qrySortHeat.Edit;
      qrySortHeat.FieldByName('Lane').AsInteger := lane;
      qrySortHeat.Post;
      i := i + 1;
      qrySortHeat.Next;
    end;
  end;
  qrySortHeat.Close;

  // STEP 2 :
  // ASSIGN REMAINING LANES NUMBERS TO EMPTY LANES ....
  // ------------------------------------------------------------------
  qrySortHeat_EmptyLanes.Close;
  qrySortHeat_EmptyLanes.ParamByName('HEATID').AsInteger := aHeatID;
  qrySortHeat_EmptyLanes.Prepare;
  qrySortHeat_EmptyLanes.Open;
  if (qrySortHeat_EmptyLanes.Active) then
  begin
    while not qrySortHeat_EmptyLanes.Eof do
    begin
      if (i < NumOfLanes) then
      begin
        lane := SCMUtility.ScatterLanes(i, NumOfLanes);
        qrySortHeat_EmptyLanes.Edit;
        qrySortHeat_EmptyLanes.FieldByName('Lane').AsInteger := lane;
        qrySortHeat_EmptyLanes.Post;
      end
      else
      begin
        // TOO-MANY EMPTY LANES
        qrySortHeat_EmptyLanes.Edit;
        qrySortHeat_EmptyLanes.FieldByName('Lane').Clear;
        qrySortHeat_EmptyLanes.Post;
        DoDelete := true;
      end;
      qrySortHeat_EmptyLanes.Next;
      i := i + 1;
    end;
  end;
  qrySortHeat_EmptyLanes.Close;

  // STEP 3 :
  // IF NUMOFLANES IS EXCEEDED - REMOVE THEM....
  // ------------------------------------------------------------------
  qrySortHeat_EmptyLanes.Close;
  if (DoDelete) then
  begin
    s := 'DELETE FROM Entrant WHERE [HeatID] := ';
    s := s + IntToStr(aHeatID) + ' AND [Lane] IS NULL';
    scmConnection.ExecSQL(s);
  end;

  result := true;
  dsEntrant.DataSet.EnableControls;
end;

function TSCM.Entrant_Strike: Boolean;
var
  EntrantID: integer;
  nom: TSCMNom;
begin
  result := false;
  with dsEntrant.DataSet do
  begin
    CheckBrowseMode; // post any changes
    EntrantID := FieldByName('EntrantID').AsInteger;
    if (EntrantID > 0) then
    begin
      nom := TSCMNom.CreateWithConnection(self, scmConnection);
      if Assigned(nom) then
      begin
        DisableControls;
        nom.StrikeExecute(EntrantID, dsEntrant.DataSet);
        result := true;
        { TODO -oBSA -cGeneral : Refresh required? }
        Refresh;
        EnableControls;
      end;
      nom.Free;
    end;
  end;
end;

function TSCM.Event_AllHeatsAreClosed(aEventID: integer): Boolean;
var
  i: integer;
begin
  result := false;
  if not fSCMActive then
    exit;
  qryCountHeatsNotClosed.Close;
  qryCountHeatsNotClosed.ParamByName('EVENTID').AsInteger := aEventID;
  qryCountHeatsNotClosed.Prepare;
  qryCountHeatsNotClosed.Open;
  if (qryCountHeatsNotClosed.Active) then
  begin
    i := qryCountHeatsNotClosed.FieldByName('CountStatus').AsInteger;
    if (i = 0) then
      result := true;
  end;
  qryCountHeatsNotClosed.Close;
end;

procedure TSCM.Event_Delete(aEventID: integer);
var
  SQL: string;

begin
  if not fSCMActive then
    exit;
  // --------------------------------------------------------
  // D E L E T E   E V E N T .
  // --------------------------------------------------------
  dsEvent.DataSet.DisableControls;
  case Event_TypeID(aEventID) of
    0, 1:
      begin
        Heat_DeleteALL(aEventID); // DELETE HEATS ---> ENTRANTS --> SPLIT
        Nominee_DeleteALL(aEventID); // DELETE NOMINATIONS
      end;
    2:
      begin
        // DELETE TEAMENTRANTS --> DELETE TEAMSPLITS
        // DELETE TEAMS
        // DELETE TEAMHEATS
      end;
  end;
  // DELETE EVENT
  SQL := 'DELETE FROM dbo.Event WHERE Event.EventID = :ID';
  scmConnection.ExecSQL(SQL, [aEventID]);
  dsEvent.DataSet.EnableControls;
end;

procedure TSCM.Event_FNameEllipse;
var
  ds: TFDQuery;
begin
  ds := (dsFNameEllipse.DataSet as TFDQuery);
  // re-assign parameters ...
  // TODO: reassigning params without close or prepare?
  ds.ParamByName('SESSIONID').AsInteger := Session_ID();
  ds.ParamByName('EVENTID').AsInteger := dsEvent.DataSet.FieldByName('EventID')
    .AsInteger;
  ds.ParamByName('DISTANCEID').AsInteger := dsEvent.DataSet.FieldByName
    ('DistanceID').AsInteger;
  ds.ParamByName('STROKEID').AsInteger := dsEvent.DataSet.FieldByName
    ('StrokeID').AsInteger;
  if (ds.Active) then
    ds.Refresh();
end;

function TSCM.Event_GetEntrantCount(aEventID: integer): integer;
begin
  result := 0;
  if fSCMActive then
  begin
    if (aEventID > 0) then
    begin
      qryEntrantCount.Close;
      qryEntrantCount.ParamByName('EVENTID').AsInteger := aEventID;
      qryEntrantCount.Prepare;
      qryEntrantCount.Open;
      if qryEntrantCount.Active then
      begin
        if not qryEntrantCount.IsEmpty then
        begin
          result := qryEntrantCount.FieldByName('EntrantCount').AsInteger;
        end;
      end;
      qryEntrantCount.Close();
    end;
  end;
end;

function TSCM.Event_GetHeatCount(aEventID: integer): integer;
begin
  result := 0;
  if fSCMActive then
  begin
    if (aEventID > 0) then
    begin
      qryHeatCount.Close;
      qryHeatCount.ParamByName('EID').AsInteger := aEventID;
      qryHeatCount.Prepare;
      qryHeatCount.Open;
      if (qryHeatCount.Active) then
      begin
        if not qryHeatCount.IsEmpty then
        begin
          result := qryHeatCount.FieldByName('Count_HeatID').AsInteger;
        end;
      end;
      qryHeatCount.Close;
    end;
  end;
end;

function TSCM.Event_GetNomineeCount(aEventID: integer): integer;
begin
  result := 0;
  if not fSCMActive then
    exit;
  qryNomineeCount.Close;
  qryNomineeCount.ParamByName('EVENTID').AsInteger := aEventID;
  qryNomineeCount.Prepare;
  qryNomineeCount.Open;
  if (qryNomineeCount.Active) then
  begin
    if not qryNomineeCount.IsEmpty then
      result := qryNomineeCount.FieldByName('NomineeCount').AsInteger;
  end;
  qryNomineeCount.Close;
end;

function TSCM.Event_HasClosedHeats(): Boolean;
var
  bm: TBookMark;
begin
  result := false;
  if not fSCMActive then
    exit;
  // l o o k   f o r   c l o s e d   h e a t s  .
  // --------------------------------------------------------
  with dsHeat.DataSet do
  begin
    try
      bm := Bookmark;
      DisableControls;
      First;
      while not Eof do
      begin
        if (FieldByName('HeatStatusID').AsInteger = 3) then
        begin
          result := true;
          break;
        end;
        Next;
      end;
    finally
      GotoBookmark(bm);
      EnableControls;
    end;
  end;
end;

function TSCM.Event_HasNominee(EventID, MemberID: integer): Boolean;
var
  qry: TFDQuery;
begin
  result := false;
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := 'SELECT * FROM Nominee WHERE [MemberID] = ' +
    IntToStr(MemberID) + ' AND [EventID] = ' + IntToStr(EventID);
  qry.Open;
  if qry.Active then
    if (qry.RecordCount > 0) then
      result := true;
  qry.Close;
end;

function TSCM.Event_HasNominees(EventID: integer): Boolean;
begin
  result := false;
  if not fSCMActive then
    exit;
  // TEST for nominees
  qryTestForNominees.Close;
  qryTestForNominees.ParamByName('EVENTID').AsInteger := EventID;
  qryTestForNominees.Prepare;
  qryTestForNominees.Open;
  if (qryTestForNominees.Active) then
  begin
    if not qryTestForNominees.IsEmpty then
      result := true;
  end;
  qryTestForNominees.Close;
end;

function TSCM.Event_HasRacedHeats(): Boolean;
var
  bm: TBookMark;
begin
  result := false;
  if not fSCMActive then
    exit;
  // l o o k   f o r   r a c e d   h e a t s  .
  // --------------------------------------------------------
  with dsHeat.DataSet do
  begin
    try
      bm := Bookmark;
      DisableControls;
      First;
      while not Eof do
      begin
        if (FieldByName('HeatStatusID').AsInteger = 2) then
        begin
          result := true;
          break;
        end;
        Next;
      end;
    finally
      GotoBookmark(bm);
      EnableControls;
    end;
  end;
end;

function TSCM.Event_ID: integer;
begin
  result := 0;
  if fSCMActive and dsEvent.DataSet.Active then
    if not dsEvent.DataSet.IsEmpty then
      result := dsEvent.DataSet.FieldByName('EventID').AsInteger;
end;

function TSCM.Event_IsINDV: Boolean;
var
i: integer;
begin
  result := true;
  if fSCMActive and dsEvent.DataSet.Active then
    if not dsEvent.DataSet.IsEmpty then
    begin
      i := dsEvent.DataSet.FieldByName('EventTypeID').AsInteger;
      if (i > 1) then
        result := false;
    end;
end;

function TSCM.Event_IsSafeToDelete(aEventID: integer): Boolean;
begin
  result := false;
  if (fSCMActive) then
  begin
    if (aEventID > 0) then
    begin
      qryIsSafeToDelEvent.Close;
      qryIsSafeToDelEvent.ParamByName('EVENTID').AsInteger := aEventID;
      qryIsSafeToDelEvent.Prepare;
      qryIsSafeToDelEvent.Open;
      if qryIsSafeToDelEvent.Active then
      begin
        // empty indicates no status above 1
        if qryIsSafeToDelEvent.IsEmpty then
          result := true;
      end;
      qryIsSafeToDelEvent.Close;
    end;
  end;
end;

function TSCM.Event_IsTEAM: Boolean;
begin
  result := not Event_IsINDV;
end;

function TSCM.Event_Locate(aEventID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then
    exit;
  if (aEventID = 0) then
    exit;
  SearchOptions := [];
  if dsEvent.DataSet.Active then
    result := dsEvent.DataSet.Locate('EventID', aEventID, SearchOptions);
end;

function TSCM.Event_Locate(aDistanceID, aStrokeID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then
    exit;
  SearchOptions := [];
  if dsEvent.DataSet.Active then
    result := dsEvent.DataSet.Locate('DistanceID;StrokeID',
      VarArrayOf([aDistanceID, aStrokeID]), SearchOptions);
end;

procedure TSCM.Event_Renumber(DoLocate: Boolean);
var
  qry: TFDQuery;
  i, aEventID: integer;
  sl: TStringList;
  ds: TDataSet;
begin
  aEventID := 0;

  if not fSCMActive then
    exit;
  if dsEvent.DataSet.IsEmpty then
    exit;

  ds := dsEvent.DataSet;
  if DoLocate then
    aEventID := ds.FieldByName('EventID').AsInteger;

  ds.DisableControls;
  sl := TStringList.Create;
  // Legal, qryEvent has master..child relationship with dsSession.
  sl.Add('USE [SwimClubMeet] ');
  sl.Add('SELECT [EventID], [EventNum] FROM [dbo].[Event] ');
  sl.Add('WHERE [SessionID] = ' + IntToStr(Session_ID()));
  sl.Add(' ORDER BY [EventNum]');
  // Find valid EventNum
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL := sl;
  qry.UpdateOptions.KeyFields := 'EventID';
  qry.UpdateOptions.UpdateTableName := 'SwimClubMeet..Event';
  qry.Open;
  if (qry.Active) then
  begin
    i := 1;
    // Clean up list after each new record - renumber event number
    while not qry.Eof do
    begin
      qry.Edit;
      qry.FieldByName('EventNum').AsInteger := i;
      qry.Post;
      i := i + 1;
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
  sl.Free;
  // REQUERY : RELOAD DATA
  ds.Refresh();
  // REQUEUE
  if (DoLocate) then
    Event_Locate(aEventID);
  ds.EnableControls();
end;

function TSCM.Event_TypeID(aEventID: integer): integer;
var
v: variant;
SQL: string;
begin
  result := 0;
  if fSCMActive and dsEvent.DataSet.Active then
    if not dsEvent.DataSet.IsEmpty then
    begin
      SQL := 'SELECT [EventTypeID] FROM [SwimClubMeet].[dbo].[Event] WHERE EventID = :ID';
      v := scmConnection.ExecSQLScalar(SQL, [aEventID]);
      if not VarIsEmpty(v) or VarIsNull(v) then
        result := v;
    end;
end;

procedure TSCM.Heat_Delete(aHeatID: integer);
var
  SQL: string;
begin
  if not fSCMActive then
    exit;
  dsHeat.DataSet.DisableControls();
  Entrant_DeleteALL(aHeatID);
  SQL := 'DELETE FROM [SwimClubMeet].[dbo].[HeatIndividual] WHERE HeatID = :ID';
  scmConnection.ExecSQL(SQL, [aHeatID]);
  Heat_Renumber();
  dsHeat.DataSet.EnableControls();

end;

procedure TSCM.Heat_DeleteALL(aEventID: integer);
var
  SQL: string;
  aHeatID: integer;
  qry: TFDQuery;
begin
  Heat_DeleteALLExclude(aEventID, false);
end;

procedure TSCM.Heat_DeleteALLExclude(aEventID: integer;
  DoExclude: Boolean = true);
var
  SQL: string;
  aHeatID: integer;
  qry: TFDQuery;

begin
  // 21.07.23
  if not fSCMActive then
    exit;
  dsHeat.DataSet.DisableControls;
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text :=
    'SELECT * FROM [SwimClubMeet].[dbo].[HeatIndividual] WHERE EventID = ' +
    IntToStr(aEventID);
  qry.IndexFieldNames := 'HeatID';
  qry.Open;
  if qry.Active then
  begin
    qry.First;
    while not qry.Eof do
    begin
      aHeatID := qry.FieldByName('HeatID').AsInteger;
      // TEST STATUS: Only opened heats are deleted. Unless DoExclude = false.
      // Heat Status of unknown (nil or 0)?
      if (qry.FieldByName('HeatStatusID').AsInteger = 1) or not(DoExclude) then
      begin
        // delete ALL entrant data including split times.
        Entrant_DeleteALL(aHeatID);
        qry.Delete; // moves to next record
        continue;
      end;
      qry.Next; // record not deleted - move next record.
    end;
  end;
  qry.Close;
  qry.Free;
  { TODO -oBSA -cGeneral : look at heat renumbering
    - consider using AutoBuildV2 method - RenumberHeats(EventID)
    as this qry ensures null is last in list. }
  // tidy up. ;
  Heat_Renumber();
  dsHeat.DataSet.EnableControls();

end;

function TSCM.Heat_ID: integer;
begin
  result := 0;
  if fSCMActive and dsHeat.DataSet.Active then
    if not dsHeat.DataSet.IsEmpty then
      result := dsHeat.DataSet.FieldByName('HeatID').AsInteger;
end;

function TSCM.Heat_IsClosed: Boolean;
var
  HeatStatusID: integer;
begin
  result := false;
  HeatStatusID := dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger;
  if (HeatStatusID = 3) or (HeatStatusID = 0) then
    result := true;
end;

function TSCM.Heat_IsRaced: Boolean;
var
  HeatStatusID: integer;
begin
  result := false;
  HeatStatusID := dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger;
  if (HeatStatusID = 2) then
    result := true;
end;

function TSCM.Heat_Locate(aHeatID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then
    exit;
  if (aHeatID = 0) then
    exit;
  SearchOptions := [];
  if dsHeat.DataSet.Active then
    result := dsHeat.DataSet.Locate('HeatID', aHeatID, SearchOptions);
end;

procedure TSCM.Heat_NewRecord;
var
  fld: TField;
begin
  // can't make heats if there is no events ....
  if dsEvent.DataSet.IsEmpty then
    exit;
  // 3.10.2020
  with dsHeat.DataSet do
  begin
    DisableControls();
    fld := qryHeat.FindField('HeatNum');
    if Assigned(fld) then
      fld.ReadOnly := false;
    // creating a heat results in empty lanes being spawned
    // and HeatNum calculated, HeatType initialized, etc
    Insert;
    Post;
    // renumber also preforms dataset refresh and locates to new heat
    Heat_Renumber();
    // 3.10.2020
    if Assigned(fld) then
      fld.ReadOnly := true;
    EnableControls();
  end;
end;

function TSCM.Heat_NextID(aHeatID: integer): integer;
begin
  result := 0;
  // get the next heat in the event  (uses HeatNum)
  qryGetNextHeat.Connection := scmConnection;
  qryGetNextHeat.ParamByName('HEATID').AsInteger := aHeatID;
  qryGetNextHeat.Prepare;
  qryGetNextHeat.Open;
  if qryGetNextHeat.Active and (qryGetNextHeat.RecordCount > 0) then
    result := qryGetNextHeat.FieldByName('HeatID').AsInteger;
end;

function TSCM.Heat_PrevID(aHeatID: integer): integer;
begin
  result := 0;
  // get the previuos heat in the event  (uses HeatNum)
  qryGetPrevHeat.Connection := scmConnection;
  qryGetPrevHeat.ParamByName('HEATID').AsInteger := aHeatID;
  qryGetPrevHeat.Prepare;
  qryGetPrevHeat.Open;
  if qryGetPrevHeat.Active and (qryGetPrevHeat.RecordCount > 0) then
    result := qryGetPrevHeat.FieldByName('HeatID').AsInteger;
end;

procedure TSCM.Heat_Renumber(DoLocate: Boolean);
// RENUMBER HEAT NUMBER HeatNum
// ..................................................
var
  qry: TFDQuery;
  i, aHeatID, aEventID: integer;
  s: String;
begin
  if not fSCMActive then
    exit;
  if dsHeat.DataSet.IsEmpty then
    exit;
  aHeatID := 0;
  dsHeat.DataSet.DisableControls;
  // master-child relationship  EventID-HeatID
  aEventID := dsHeat.DataSet.FieldByName('EventID').AsInteger;
  // used later to cue-to-heat after renumber
  if (DoLocate) then
    aHeatID := dsHeat.DataSet.FieldByName('HeatID').AsInteger;
  // gather all the heats in the current event
  s := 'SELECT [HeatID], [HeatNum] FROM [dbo].[HeatIndividual] ';
  s := s + 'WHERE EventID = :EVENTID ORDER BY [HeatID]';
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := s;
  qry.UpdateOptions.KeyFields := 'HeatID';
  qry.UpdateOptions.UpdateTableName := 'SwimClubMeet..HeatIndividual';
  qry.ParamByName('EVENTID').AsInteger := aEventID;
  qry.IndexFieldNames := 'HeatNum';
  qry.Prepare;
  qry.Open;
  if qry.Active then
  begin
    i := 1;
    // Clean up list after each new record - renumber event number
    while not qry.Eof do
    begin
      qry.Edit;
      qry.FieldByName('HeatNum').AsInteger := i;
      qry.Post;
      i := i + 1;
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
  // RE-QUERY :: RELOAD DATA.
  dsHeat.DataSet.Refresh;
  // Queue to original selected entrant ...
  if (DoLocate) then
    Heat_Locate(aHeatID);
  dsHeat.DataSet.EnableControls;
end;

function TSCM.Heat_StatusID(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not scmConnection.Connected then
    exit;
  if (aHeatID > 0) then
  begin
    SQL := 'SELECT [HeatStatusID] FROM [SwimClubMeet].[dbo].[HeatIndividual] WHERE HeatID = :ID;';
    v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
    if not VarIsEmpty(v) or VarIsNull(v) then
      result := v;
  end;
end;

procedure TSCM.Heat_ToggleStatus;
var
  bm: TBookMark;
  i: integer;
begin
  with dsHeat.DataSet do
  begin
    DisableControls;
    CheckBrowseMode;
    bm := GetBookmark;
    i := FieldByName('HeatStatusID').AsInteger;
    Edit;
    case i of
      1:
        // toggle to RACED ...
        FieldByName('HeatStatusID').AsInteger := 2;
      2:
        begin
          // toggle to CLOSED ...
          FieldByName('HeatStatusID').AsInteger := 3;
          // 22.09.2020 TimeStamp
          FieldByName('ClosedDT').AsDateTime := Now;
        end;
    else
      // toggle to OPEN ...
      FieldByName('HeatStatusID').AsInteger := 1;
    end;
    Post;
    Refresh;
    try
      GotoBookmark(bm);
    finally
      EnableControls;
    end;
  end;
end;

procedure TSCM.Heat_UpdateStatusBar;
begin

end;

function TSCM.IsFirstRecord(ADataSet: TDataSet): Boolean;
var
  bm: TBookMark;
begin
  result := true;
  if not(fSCMActive) then
    exit;
  if (ADataSet.IsEmpty) then
    exit;
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
  if not(fSCMActive) then
    exit;
  if (ADataSet.IsEmpty) then
    exit;
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

function TSCM.Member_IsQualified(aMemberID, aGenderID, aQualifyDistID,
  aStrokeID: integer; IsShortCourse: Boolean): Boolean;
begin
  result := false;
  if not fSCMActive then
    exit;
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

function TSCM.Nominate_Locate(MemberID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then
    exit;
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
  if not fSCMActive then
    exit;
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
  if not fSCMActive then
    exit;
  if dsNominateMembers.DataSet.IsEmpty then
    exit;
  with dsNominateMembers.DataSet as TFDQuery do
  begin
    DisableControls;
    if (Active) then
      // Store the current selected member.
      // Note: can't use bookmarks as the DB is re-queried.
      // Query re-builds FName string. LASTNAME:FIRSTNAME or FIRSTNAME:LASTNAME
      MemberID := FieldByName('MemberID').AsInteger;
    Close;
    ParamByName('SESSIONSTART').AsDateTime := Session_Start;
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
  if not fSCMActive then
    exit;
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

procedure TSCM.Nominee_Delete(aNomineeID, aEventID: integer);
var
  SQL: string;
  aEntrantID: integer;
begin
  dsNominee.DataSet.DisableControls;
  // can't delete a nominee without deleting the entrant.
  aEntrantID := Nominee_InEvent(aNomineeID, aEventID);
  if (aEntrantID <> 0) then
    Entrant_Delete(aEntrantID); // delete the entrant from race.
  SQL := 'DELETE FROM [SwimClubMeet].[dbo].[Nominee] WHERE [NomineeID] = :ID';
  scmConnection.ExecSQL(SQL, [aNomineeID]);
  dsNominee.DataSet.EnableControls;
end;

procedure TSCM.Nominee_DeleteALL(aEventID: integer);
var
  SQL: string;
  v: variant;
  aNomineeID, aEntrantID: integer;
  qry: TFDQuery;
begin
  dsNominee.DataSet.DisableControls;
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text :=
    'SELECT * FROM [SwimClubMeet].[dbo].[Nominee] WHERE EventID = ' +
    IntToStr(aEventID);
  qry.IndexFieldNames := 'NomineeID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aNomineeID := qry.FieldByName('NomineeID').AsInteger;
      // DELETE THE ENTRANT RECORD
      aEntrantID := Nominee_InEvent(aNomineeID, aEventID);
      if (aEntrantID <> 0) then
        Entrant_Delete(aEntrantID);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;

  // FINALLY DELETE ALL NOMINEE RECORDS
  SQL := 'DELETE FROM [SwimClubMeet].[dbo].[Nominee] WHERE Nominee.EventID = :ID';
  scmConnection.ExecSQL(SQL, [aEventID]);
  dsNominee.DataSet.EnableControls;
end;

function TSCM.Nominee_InEvent(aNomineeID, aEventID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0; // return EntrantID. Zero indicate 'not in event'.
  SQL := 'SELECT EntrantID FROM [SwimClubMeet].[dbo].[Nominee] ' +
    'INNER JOIN [Event] ON [Event].EventID = Nominee.EventID ' +
    'INNER JOIN HeatIndividual ON HeatIndividual.EventID = [Event].EventID ' +
    'INNER JOIN Entrant ON Entrant.HeatID = HeatIndividual.HeatID ' +
    'WHERE Nominee.NomineeID = :NomineeID AND [Event].EventID = :EventID; ';
  v := scmConnection.ExecSQLScalar(SQL, [aNomineeID, aEventID]);
  if not VarIsNull(v) then
    result := v;
end;

procedure TSCM.qryEntrantAfterScroll(DataSet: TDataSet);
begin
  if Owner is TForm then
    PostMessage(TForm(Owner).Handle, SCM_ENTRANTSCROLL, 0, 0);
end;

procedure TSCM.qryEntrantBeforeInsert(DataSet: TDataSet);
begin
  // lanes are created when new heat is called
  // .. user cannnot enter new lanes from here...
  Abort();
end;

procedure TSCM.qryEntrantTIMEGetText(Sender: TField; var Text: string;
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
    if (Min > 0) then
      Text := Format('%0:2u:%1:2.2u.%2:3.3u', [Min, Sec, MSec])
    else if ((Min = 0) and (Sec > 0)) then
      Text := Format('%1:2u.%2:3.3u', [Min, Sec, MSec])

    else if ((Min = 0) and (Sec = 0)) then
      Text := '';
  end
  else
    Text := Format('%0:2.2u:%1:2.2u.%2:3.3u', [Min, Sec, MSec]);
end;

procedure TSCM.qryEntrantTIMESetText(Sender: TField; const Text: string);
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
    if (s[i] = ' ') then
      s[i] := '0';
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

  if failed then
    Sender.Clear; // Sets the value of the field to NULL

end;

procedure TSCM.qryEventAfterDelete(DataSet: TDataSet);
begin
  // renumber events
  Event_Renumber();
end;

procedure TSCM.qryEventAfterPost(DataSet: TDataSet);
var
  i, v: integer;
  fld: TField;
begin
  v := DataSet.FieldByName('EventNum').AsInteger;
  if (v = 0) then
  begin
    i := DataSet.RecordCount;
    fld := DataSet.FindField('EventNum');
    if Assigned(fld) then
      fld.ReadOnly := false;
    DataSet.Edit;
    DataSet.FieldByName('EventNum').AsInteger := i;
    DataSet.Post;
    if Assigned(fld) then
      fld.ReadOnly := true;
  end;

  if Owner is TForm then
    PostMessage(TForm(Owner).Handle, SCM_UPDATEINDVTEAM, 0, 0);

end;

procedure TSCM.qryEventAfterScroll(DataSet: TDataSet);
begin
  { TODO -oBSA -cGeneral : Originally Main.Handle }
  if Owner is TForm then
    PostMessage(TForm(Owner).Handle, SCM_EVENTSCROLL, 0, 0);
end;

procedure TSCM.qryEventBeforeEdit(DataSet: TDataSet);
begin
  // this is used later in the qryEvent BeforePost to determine if
  // the Nominations should be cleared
  fLastDistanceID := DataSet.FieldByName('DistanceID').AsInteger;
  fLastStrokeID := DataSet.FieldByName('StrokeID').AsInteger;;
end;

procedure TSCM.qryEventBeforePost(DataSet: TDataSet);
var
  i, entrantCount, DistanceID, StrokeID: integer;
begin

  if not fSCMActive then
    exit;
  DistanceID := DataSet.FieldByName('DistanceID').AsInteger;
  StrokeID := DataSet.FieldByName('StrokeID').AsInteger;

  if ((DistanceID <> fLastDistanceID) or (StrokeID <> fLastStrokeID)) then
  begin
    i := DataSet.FieldByName('EventID').AsInteger;
    entrantCount := Event_GetEntrantCount(i);
    if (entrantCount > 0) then
    begin
      // display warning message
      MessageDlg('If an Event''s distance or stroke is changed' + slinebreak +
        'then the nominees attached to that event also reflect' + slinebreak +
        'those changes.', mtWarning, [mbOK], 0);
    end;
  end;

  if (DataSet.FieldByName('Caption').IsNull) then
  begin
    // err trap?
    { TODO -oBSA -cGeneral : Needs to code a update preference routine.
      This would be called each time the user uses dlgPreferences.
      (via the main form.) }
    if (prefGenerateEventDescription) then
    begin
      if not prefGenerateEventDescStr.IsEmpty then
      begin
        DataSet.FieldByName('Caption').AsString := prefGenerateEventDescStr;
      end;
    end;
  end;
end;

procedure TSCM.qryEventDistanceIDValidate(Sender: TField);
var
v1, v2, v3: variant;
i: integer;
SQL: string;
begin
  // INDV or TEAM
  SQL := 'SELECT EventTypeID FROM SwimClubMeet.dbo.Distance WHERE [DistanceID] = :ID';
  v1 := scmConnection.ExecSQLScalar(SQL, [Sender.CurValue]);
  v2 := scmConnection.ExecSQLScalar(SQL, [Sender.Value]);
  if v1 <> v2 then // switching event type ...
  begin
    // test for Heats
    SQL := 'SELECT Count(HeatID) FROM SwimClubMeet.dbo.HeatIndividual WHERE [EventID] = :ID';
    i := Event_ID;
    v3 := scmConnection.ExecSQLScalar(SQL, [i]);
    if (v3 <> 0) then
    begin
      Raise Exception.Create('When an event has heats it cannot be switched between INDV and RELAY');
    end;
  end;
end;

procedure TSCM.qryEventEventStatusIDGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  // column should only show a tick ...
  // TODO: disable selection of the column.
  Text := '';
end;

procedure TSCM.qryEventNewRecord(DataSet: TDataSet);
var
  fld: TField;
begin
  // 13.10.2020 qryEvent.EventStatusID is READ ONLY
  fld := DataSet.FindField('EventStatusID');
  if Assigned(fld) then
    fld.ReadOnly := false;

  DataSet.Edit;
  DataSet.FieldByName('EventStatusID').AsInteger := 1;
  DataSet.Post;

  if Assigned(fld) then
    fld.ReadOnly := true;
end;

procedure TSCM.qryEventScheduleDTGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.IsNull then
  Text := ''
  else
  Text := FormatDateTime('hh:nn', Sender.AsDateTime);
end;

procedure TSCM.qryEventScheduleDTSetText(Sender: TField; const Text: string);
var
dt: TDateTime;
fs: TFormatSettings;
s: string;
begin
  if Length(Text) = 0 then
  begin
    Sender.Clear;
    exit;
  end;

  s := ReplaceText(Text, ' ', '0');  // tidy-up : replace editmask spaces
  fs := TFormatSettings.Create;  // class record - free not required.
  if TryStrToTime(s, dt, fs) then
  begin
    Sender.AsDateTime := dt; // NOTE: Only time portion is used by DB.
  end;

end;

procedure TSCM.qryHeatAfterDelete(DataSet: TDataSet);
begin
  Heat_Renumber();
end;

procedure TSCM.qryHeatAfterPost(DataSet: TDataSet);
var
  HeatID, EntrantID, NumOfLanes, i: integer;
  aEventTypeID: integer;
begin
  // AFTER every post to heats ...
  // THIS ROUTINE ASSERTS CORRECT NUMBER OF LANES
  HeatID := DataSet.FieldByName('HeatID').AsInteger;
  if (HeatID = 0) then
    exit;

  NumOfLanes := SwimClub_NumberOfLanes;
  // Type INDV or TEAM
  aEventTypeID := dsEvent.DataSet.FieldByName('EventTypeID').AsInteger;

  case aEventTypeID of
    0, 1:
      begin
        i := Entrant_CountLanes(HeatID); // current number of pool lanes
        if (i = 0) then
        begin
          // new heats don't have lanes.
          Entrant_InsertEmptyLanes(HeatID);
          dsEntrant.DataSet.Refresh; // required
        end
        else
        begin
          EntrantID := dsEntrant.DataSet.FieldByName('EntrantID').AsInteger;
          if (i < NumOfLanes) then
            Entrant_PadWithEmptyLanes(HeatID)
          else if (i > NumOfLanes) then
            Entrant_DeleteExcessLanes(HeatID);
          dsEntrant.DataSet.Refresh; // required
          Entrant_Locate(EntrantID);
        end;
      end;
    2:
      begin
        i := TEAM_CountLanes(HeatID); // TEAMS
        if (i = 0) then
        begin

        end;
      end;
  end;

end;

procedure TSCM.qryHeatAfterScroll(DataSet: TDataSet);
begin
  // REQUIRED 30/7/2023
  // This is needed to update the entrant grid's 'enabled' state.
  PostMessage(TForm(Owner).Handle, SCM_HEATSCROLL, 0, 0);
end;

procedure TSCM.qryHeatNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('HeatStatusID').AsInteger := 1; // Open
  DataSet.FieldByName('HeatNum').AsInteger := DataSet.RecordCount + 1;
  DataSet.FieldByName('HeatTypeID').AsInteger := 1;
  // Heat, quarter, semi, final
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

procedure TSCM.qrySessionAfterDelete(DataSet: TDataSet);
begin
  if Owner is TForm then
    PostMessage(TForm(Owner).Handle, SCM_EVENTASSERTSTATE, 0, 0);

end;

procedure TSCM.qrySessionAfterPost(DataSet: TDataSet);
begin
  // if the session table is empty ... then the events GUI is invisible
  // after any post (or insert) assert that events is visible
  //
  if Owner is TForm then
    PostMessage(TForm(Owner).Handle, SCM_EVENTASSERTSTATE, 0, 0);
end;

procedure TSCM.qrySessionAfterScroll(DataSet: TDataSet);
begin
  { TODO -oBSA -cGeneral : WIN API Messaging }
  if Owner is TForm then
    PostMessage(TForm(Owner).Handle, SCM_SESSIONSCROLL, 0, 0);
end;

procedure TSCM.qrySessionBeforePost(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('SessionStatusID').IsNull) then
    DataSet.FieldByName('SessionStatusID').AsInteger := 1;
end;

procedure TSCM.qrySessionNewRecord(DataSet: TDataSet);
begin
  (*
    The main difference between AfterInsert and NewRecord is that all changes
    you do in NewRecord don't set the modified flag for the dataset, so you can
    set your default values and before posting the record you can still check
    for the modified property to see if the user has actually changed the data.
  *)
  DataSet.FieldByName('SessionStart').AsDateTime := Now;
  DataSet.FieldByName('SessionStatusID').AsInteger := 1;
end;

procedure TSCM.qrySessionSessionStartGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
var
  FS: TFormatSettings;
  s: string;
  i, i2: integer;
  MonthPreceeds: Boolean;
begin
  // Furnish the locale format settings record
  FS := TFormatSettings.Create();
  s := FS.ShortDateFormat;
  // AMERICAN or WORLD month-day order ...
  i := Pos('D', UpperCase(s));
  i2 := Pos('M', UpperCase(s));
  MonthPreceeds := false;
  if (i2 < i) then
    MonthPreceeds := true;
  // DisplayText is true if the field's value is to be used for display only;
  // false if the string is to be used for editing the field's value.
  if (DisplayText) then
    // The format as set by the LOCALE
    // Numerous display possibilities YY/MM/DD hh:mm ttt or mm/dd/yyyy etc ....
    Text := FormatDateTime(FS.ShortDateFormat + ' ' + FS.ShortTimeFormat,
      Sender.AsDateTime, FS)
  else
    // FORMAT 'STRICT' - USED WHEN EDITING .....
    // Using FS ensures correct values are pulled ....
    if (MonthPreceeds) then
      Text := FormatDateTime('MM/dd/yy HH:nn', Sender.AsDateTime, FS)
    else
      Text := FormatDateTime('dd/MM/yy HH:nn', Sender.AsDateTime, FS);
end;

procedure TSCM.qrySessionSessionStartSetText(Sender: TField;
  const Text: string);
var
  year, month, day, Hour, Min, txt: string;
  sa: TStringDynArray;
  dt: TDateTime;
  i, i2: integer;
  MonthPreceeds: Boolean;
  FS: TFormatSettings;

begin
  MonthPreceeds := false;
  FS := FS.Create();
  i := Pos('D', UpperCase(FS.ShortDateFormat));
  i2 := Pos('M', UpperCase(FS.ShortDateFormat));
  if (i2 < i) then
    MonthPreceeds := true;

  // Text excludes literal character used in editmask!
  txt := Text;
  // Insert missing literal characters - required to get SlitString running
  if (Length(txt) = 14) then
  begin
    if (txt[1] = ' ') then
      txt[1] := '0';
    if (txt[2] = ' ') then
      txt[2] := '0';
    if (txt[4] = ' ') then
      txt[4] := '0';
    if (txt[5] = ' ') then
      txt[5] := '0';
    if (txt[7] = ' ') then
      txt[7] := '0';
    if (txt[8] = ' ') then
      txt[8] := '0';
    if (txt[9] = ' ') then
      txt[9] := '_';
    if (txt[10] = ' ') then
      txt[10] := '0';
    if (txt[11] = ' ') then
      txt[11] := '0';
    if (txt[13] = ' ') then
      txt[13] := '0';
    if (txt[14] = ' ') then
      txt[14] := '0';
  end
  // Error trap - probably unnessary - hence no error message
  else
    exit;
  // may not be required ...
  txt := txt.Trim;
  // strips out datetime elements ready for encoding
  sa := SplitString(txt, '/_:');
  if (High(sa) = 4) then
  begin
    // AMERICAN "mm/dd/yy"
    if (MonthPreceeds) then
    begin
      month := sa[0];
      day := sa[1];
    end
    // WORLD "dd/mm/yy"
    else
    begin
      day := sa[0];
      month := sa[1];
    end;
    year := sa[2];
    Hour := sa[3];
    Min := sa[4];
  end
  // Another error trap - most probably unnessary
  else
    exit;

  // encoding two digit years may be illegal
  if (StrToIntDef(year, 0) = 0) then
    // fixes users input of '00'
    year := IntToStr(YearOf(Today()))
  else
    year := '20' + year;

  try
    begin
      dt := EncodeDateTime(StrToIntDef(year, 0), StrToIntDef(month, 0),
        StrToIntDef(day, 0), StrToIntDef(Hour, 0), StrToIntDef(Min, 0), 0, 0);
      Sender.AsDateTime := dt;
    end
  except
    on E: Exception do
      MessageDlg('Illegal session date.', mtError, [mbOK], 0, mbOK);
  end;

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
  if (i = iChecked) then
    prefGenerateEventDescription := true
  else
    prefGenerateEventDescription := false;
  prefGenerateEventDescStr := iFile.ReadString('Preferences',
    'GenerateEventDescStr', ' - Individual, all genders, all ages.');
  iFile.Free;
end;

(*
  function TSCM.ScatterLanes(index, NumOfPoolLanes: integer): integer;
  // ---------------------------------------------------------------------------
  // the scatter algorithm no longer requires even pool-lane count
  // the scatter algorithm will process all pool-lane counts > 1.
  // ---------------------------------------------------------------------------
  var
  Lanes: Array of integer;
  IsEven: Boolean;
  i: integer;
  begin
  result := 0;
  // NumOfPoolLanes must be 2 or greater
  if (NumOfPoolLanes < 2) then
  exit;
  // index passed is base 0
  // test for out-of-bounds
  if ((index + 1) > NumOfPoolLanes) then
  exit;
  SetLength(Lanes, NumOfPoolLanes);
  // seed number for first array value
  // Find the center lane. For 'odd' number of pool lanes - round up;
  Lanes[0] := Ceil(double(NumOfPoolLanes) / 2.0);
  // build the data for the array
  for i := 1 to NumOfPoolLanes - 1 do
  begin
  // start the iterate at index 1
  // reference previous value in list with base 0
  if (((i + 1) MOD 2) = 0) then
  IsEven := true
  else
  IsEven := false;
  if (IsEven) then
  Lanes[i] := (i) + (Lanes[(i - 1)])
  else
  Lanes[i] := (Lanes[(i - 1)]) - (i);
  end;
  // pull the entrants lane number.
  result := Lanes[index];
  // this frees the array.
  Lanes := nil;
  end;

*)

procedure TSCM.scmConnectionAfterDisconnect(Sender: TObject);
begin
  fSCMActive := false;
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

function TSCM.Session_AllEventsAreClosed(aSessionID: integer): Boolean;
var
  i: integer;
begin
  result := false;
  if not fSCMActive then
    exit;
  qryCountEventsNotClosed.Close;
  qryCountEventsNotClosed.ParamByName('SESSIONID').AsInteger := aSessionID;
  qryCountEventsNotClosed.Prepare;
  qryCountHeatsNotClosed.Open;
  if (qryCountEventsNotClosed.Active) then
  begin
    i := qryCountEventsNotClosed.FieldByName('CountStatus').AsInteger;
    if (i = 0) then
      result := true;
  end;
  qryCountEventsNotClosed.Close;
end;

function TSCM.Session_GetEntrantCount(aSessionID: integer): integer;
begin
  result := 0;
  if not fSCMActive then
    exit;
  if (aSessionID > 0) then
  begin
    qrySessionEntrantCount.Close;
    qrySessionEntrantCount.ParamByName('SESSIONID').AsInteger := aSessionID;
    qrySessionEntrantCount.Prepare;
    qrySessionEntrantCount.Open;
    if qrySessionEntrantCount.Active then
    begin
      if not qrySessionEntrantCount.IsEmpty then
      begin
        result := qrySessionEntrantCount.FieldByName('SessionEntrantCount')
          .AsInteger;
      end;
    end;
    qrySessionEntrantCount.Close;
  end;
end;

function TSCM.Session_GetNomineeCount(aSessionID: integer): integer;
begin
  result := 0;
  if not fSCMActive then
    exit;
  if (aSessionID > 0) then
  begin
    qrySessionNomineeCount.Close;
    qrySessionNomineeCount.ParamByName('SESSIONID').AsInteger := aSessionID;
    qrySessionNomineeCount.Prepare;
    qrySessionNomineeCount.Open;
    if (qrySessionNomineeCount.Active) then
    begin
      if not(qrySessionNomineeCount.IsEmpty) then
        result := qrySessionNomineeCount.FieldByName('SessionNomineeCount')
          .AsInteger;
    end;
    qrySessionNomineeCount.Close;
  end;

end;

procedure TSCM.Session_HideLocked(IsChecked: Boolean);
begin
  if (fSCMActive) then
  begin
    qrySession.Close;
    qrySession.ParamByName('TOGGLE').AsBoolean := IsChecked;
    qrySession.Prepare;
    qrySession.Open;
    qryEvent.Refresh;
    qryHeat.Refresh;
    qryEntrant.Refresh;
    qryNominee.Refresh;
  end;
end;

function TSCM.Session_ID: integer;
begin
  result := 0;
  if fSCMActive and dsSession.DataSet.Active then
    if not dsSession.DataSet.IsEmpty then
      result := dsSession.DataSet.FieldByName('SessionID').AsInteger;
end;

function TSCM.Session_IsLocked: Boolean;
begin
  result := false;
  if dsSession.DataSet.Active then
    if not dsSession.DataSet.IsEmpty then
      if (dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 2) then
        result := true;
end;

function TSCM.Session_IsSafeToDelete(aSessionID: integer): Boolean;
begin
  result := false;
  if (fSCMActive) then
  begin
    if (aSessionID > 0) then
    begin
      qryIsSafeToDelSession.Close;
      qryIsSafeToDelSession.ParamByName('SESSIONID').AsInteger := aSessionID;
      qryIsSafeToDelSession.Prepare;
      qryIsSafeToDelSession.Open;
      if (qryIsSafeToDelSession.Active) then
      begin
        // empty indicates no status above 1
        if qryIsSafeToDelSession.IsEmpty then
        begin
          result := true;
        end;
      end;
      qryIsSafeToDelSession.Close;
    end;
  end;
end;

function TSCM.Session_Locate(SessionID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then
    exit;
  if (SessionID = 0) then
    exit;
  SearchOptions := [];
  if dsSession.DataSet.Active then
    result := dsSession.DataSet.Locate('SessionID', SessionID, SearchOptions);
end;

function TSCM.Session_Start: TDateTime;
begin
  result := 0;
  if fSCMActive and dsSession.DataSet.Active then
    if not dsSession.DataSet.IsEmpty then
      result := dsSession.DataSet.FieldByName('SessionStart').AsDateTime;
end;

function TSCM.Session_Start(SessionID: integer): TDateTime;
begin
  result := Date;
  // if qryGetStartOfSession.Active then
  // qryGetStartOfSession.Close;
  // qryGetStartOfSession.ParamByName('SESSIONID').AsInteger := SessionID;
  // qryGetStartOfSession.Prepare;
  // qryGetStartOfSession.Open;
  // if qryGetStartOfSession.Active then
  // begin
  // if not qryGetStartOfSession.IsEmpty then
  // begin
  // result := qryGetStartOfSession.FieldByName('SessionStart').AsDateTime;
  // end;
  // end;
end;

procedure TSCM.Session_ToggleLockState;
var
  i: integer;
begin
  if not fSCMActive then
    exit;
  with dsSession.DataSet do
  begin
    DisableControls;
    i := FieldByName('SessionStatusID').AsInteger;
    // TOGGLE STATUS
    if i = 1 then
      i := 2
    else
      i := 1;
    Edit;
    FieldByName('SessionStatusID').AsInteger := i;
    Post;
    Refresh;
    EnableControls;
  end;
end;

procedure TSCM.Split_DeleteALLSplitTimesINDV(aEntrantID: integer);
var
  SQL: string;
begin
  if not fSCMActive then
    exit;
  { TODO -oBSA -cGeneral : Add qrySplitINDV - master-detail... }
  // dsSplitINDV.DataSet.DisableControls;
  // DELETE SPLIT DATA FOR ENTRANT
  SQL := 'DELETE FROM dbo.Split WHERE Split.EntrantID = :ID';
  scmConnection.ExecSQL(SQL, [aEntrantID]);
  // dsSplitINDV.DataSet.EnableControls;
end;

procedure TSCM.Split_DeleteALLSplitTimesTEAM(aTeamID: integer);
var
  SQL: string;
begin
  if not fSCMActive then
    exit;
  { TODO -oBSA -cGeneral : Add qrySplitTEAM - master-detail... }
  // dsSplitTEAM.DataSet.DisableControls;
  // DELETE SPLIT DATA FOR TEAM ENTRANT  (RELAYS)
  SQL := 'DELETE FROM dbo.TeamSplit WHERE Split.TeamID = :ID';
  scmConnection.ExecSQL(SQL, [aTeamID]);
  // dsSplitTEAM.DataSet.EnableControls;
end;

function TSCM.SwapLanes(EntrantIDA, EntrantIDB: integer): Boolean;
begin
  result := false;
  if (EntrantIDA = EntrantIDB) then
    exit;
  if (EntrantIDA = 0) OR (EntrantIDB = 0) then
    exit;
  qrySwapEntrants.Connection := scmConnection;
  qrySwapEntrants.ParamByName('ENTRANTIDA').AsInteger := EntrantIDA;
  qrySwapEntrants.ParamByName('ENTRANTIDB').AsInteger := EntrantIDB;
  qrySwapEntrants.Prepare;
  // does not return a cursor - hence execute (UPDATE).
  qrySwapEntrants.Execute();
  result := true;
end;

function TSCM.SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB: integer): Boolean;
var
  EntrantIDA, EntrantIDB: integer;
  SQL: string;
begin
  result := false;
  if not fSCMActive then
    exit;
  { TODO -oBSA -cGeneral : Create swap lane function }
  SQL := 'SELECT TOP 1 [EntrantID] FROM [SwimClubMeet].[dbo].[Entrant] WHERE HeatID = :HEAT AND Lane = :LANE';
  EntrantIDA := scmConnection.ExecSQLScalar(SQL, [HeatIDA, LaneA]);
  EntrantIDB := scmConnection.ExecSQLScalar(SQL, [HeatIDB, LaneB]);
  SwapLanes(EntrantIDA, EntrantIDB);
  result := true;
end;

function TSCM.SwapMoveDown(EntrantDS: TDataSet): Boolean;
var
  bm: TBookMark;
  enA, enB: integer;
  fld: TField;
begin
  result := false;
  if not IsLastRecord(EntrantDS) then
  begin
    try
      begin;
        EntrantDS.DisableControls;
        // E n a b l e   r e a d   o n   f i e l d .
        fld := qryEntrant.FindField('Lane');
        if Assigned(fld) then
          fld.ReadOnly := false;
        // bookmark current entrant and store lane number.
        bm := EntrantDS.Bookmark;
        enA := EntrantDS.FieldByName('Lane').AsInteger;
        enB := 0;
        try
          begin
            // peek at prior entrant
            EntrantDS.Next;
            enB := EntrantDS.FieldByName('Lane').AsInteger;
            EntrantDS.Edit;
            // swap lane number
            EntrantDS.FieldByName('Lane').AsInteger := enA;
            EntrantDS.Post;
            result := true;
          end
        finally
          // restore current entrant
          EntrantDS.Bookmark := bm;
          EntrantDS.Edit;
          // swap lane number
          EntrantDS.FieldByName('Lane').AsInteger := enB;
          EntrantDS.Post;
        end;
        // D i s a b l e   r e a d   o n   f i e l d .
        if Assigned(fld) then
          fld.ReadOnly := true;
      end
    finally
      // resort lanes
      EntrantDS.Refresh;
      // endable entrant grid control
      EntrantDS.EnableControls;
    end;
  end
end;

function TSCM.SwapMoveDownHeat(EntrantDS: TDataSet): Boolean;
var
  HeatIDA, LaneA, HeatIDB, LaneB: integer;
begin
  result := false;
  try
    EntrantDS.DisableControls;
    HeatIDA := EntrantDS.FieldByName('HeatID').AsInteger;
    LaneA := EntrantDS.FieldByName('Lane').AsInteger;
    HeatIDB := Heat_NextID(HeatIDA);
    LaneB := 1;
    if (HeatIDB > 0) { and not Heat_IsClosed(HeatIDB) } then
    begin
      SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB);
      result := true;
    end;
  finally
    // resort lanes
    EntrantDS.Refresh;
    // endable entrant grid control
    EntrantDS.EnableControls;
  end;
end;

function TSCM.SwapMoveUp(EntrantDS: TDataSet): Boolean;
var
  bm: TBookMark;
  enA, enB: integer;
  fld: TField;
begin
  result := false;
  enB := 0;
  if not IsFirstRecord(EntrantDS) then
  begin
    try
      begin;
        EntrantDS.DisableControls;
        // E n a b l e   r e a d   o n   f i e l d .
        fld := qryEntrant.FindField('Lane');
        if Assigned(fld) then
          fld.ReadOnly := false;
        // bookmark current entrant and store lane number.
        bm := EntrantDS.Bookmark;
        enA := EntrantDS.FieldByName('Lane').AsInteger;
        try
          begin
            // peek at prior entrant
            EntrantDS.Prior;
            enB := EntrantDS.FieldByName('Lane').AsInteger;
            EntrantDS.Edit;
            // swap lane number
            EntrantDS.FieldByName('Lane').AsInteger := enA;
            EntrantDS.Post;
            result := true;
          end
        finally
          // restore current entrant
          EntrantDS.Bookmark := bm;
          EntrantDS.Edit;
          // swap lane number
          EntrantDS.FieldByName('Lane').AsInteger := enB;
          EntrantDS.Post;
        end;
        // D i s a b l e   r e a d   o n   f i e l d .
        if Assigned(fld) then
          fld.ReadOnly := true;
      end
    finally
      // resort lanes
      EntrantDS.Refresh;
      // endable entrant grid control
      EntrantDS.EnableControls;
    end;
  end
end;

function TSCM.SwapMoveUpHeat(EntrantDS: TDataSet): Boolean;
var
  HeatIDA, LaneA, HeatIDB, LaneB: integer;
begin
  result := false;
  try
    EntrantDS.DisableControls;
    HeatIDA := EntrantDS.FieldByName('HeatID').AsInteger;
    LaneA := EntrantDS.FieldByName('Lane').AsInteger;
    HeatIDB := Heat_PrevID(HeatIDA);
    LaneB := SwimClub_NumberOfLanes;
    if (HeatIDB > 0) { and not Heat_IsClosed(HeatIDB) } then
    begin
      SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB);
      result := true;
    end;
  finally
    // resort lanes
    EntrantDS.Refresh;
    // endable entrant grid control
    EntrantDS.EnableControls;
  end;
end;

function TSCM.SwimClub_ClubName: string;
begin
  result := '';
  if dsSwimClub.DataSet.Active then
    if not dsSwimClub.DataSet.IsEmpty then
      result := dsSwimClub.DataSet.FieldByName('Caption').AsString;
end;

function TSCM.SwimClub_ID: integer;
begin
  result := 0;
  if fSCMActive and dsSwimClub.DataSet.Active then
    if not dsSwimClub.DataSet.IsEmpty then
      result := dsSwimClub.DataSet.FieldByName('SwimClubID').AsInteger;
end;

function TSCM.SwimClub_IsShortCourse: Boolean;
var
  i: integer;
begin
  result := true;
  if dsSwimClub.DataSet.Active then
  begin
    if not dsSwimClub.DataSet.IsEmpty then
    begin
      i := dsSwimClub.DataSet.FieldByName('LenOfPool').AsInteger;
      if (i >= 50) then
        result := false;
    end;
  end;
end;

procedure TSCM.SwimClub_Locate(SwimClubID: integer);
begin
  if not fSCMActive then
    exit;
  qrySwimClub.DisableControls;
  qrySwimClub.Close;
  if SwimClubID <> 0 then
  begin
    qrySwimClub.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
    qrySwimClub.Prepare;
    qrySwimClub.Open;
  end;
  qrySwimClub.EnableControls;
end;

function TSCM.SwimClub_NickName: string;
begin
  result := '';
  if dsSwimClub.DataSet.Active then
    if not dsSwimClub.DataSet.IsEmpty then
      result := dsSwimClub.DataSet.FieldByName('NickName').AsString;
end;

function TSCM.SwimClub_NumberOfLanes: integer;
var
  i: integer;
begin
  // how many lanes in the swim club's pool?
  result := 0;
  if (fSCMActive) then
  begin
    i := dsSwimClub.DataSet.FieldByName('NumOfLanes').AsInteger;
    if (i = 0) or (i > 99) then
    begin
      MessageDlg('Unkown number of swimming lanes. (Expected 1..99).' +
        slinebreak + 'Check your ''Preferences'' setup.', TMsgDlgType.mtError,
        [mbOK], 0);
    end
    else
      result := i;
  end;
end;

function TSCM.SwimClub_SessionCount(SwimClubID: integer;
  SDate, EDate: TDateTime): integer;
begin
  result := 0;
  // if qryGetSessionCount.Active then
  // qryGetSessionCount.Close;
  // qryGetSessionCount.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
  // qryGetSessionCount.ParamByName('SDATE').AsDateTime := SDate;
  // qryGetSessionCount.ParamByName('EDATE').AsDateTime := EDate;
  // qryGetSessionCount.Prepare;
  // qryGetSessionCount.Open;
  // if qryGetSessionCount.Active then
  // begin
  // if not qryGetSessionCount.IsEmpty then
  // begin
  // result := qryGetSessionCount.FieldByName('SessionCount').AsInteger;
  // end;
  // end;
end;

function TSCM.SwimClub_StartOfSwimSeason: TDateTime;
begin
  result := 0;
  if fSCMActive and dsSwimClub.DataSet.Active then
    if not dsSwimClub.DataSet.IsEmpty then
      result := dsSwimClub.DataSet.FieldByName('StartOfSwimSeason').AsDateTime;
end;

function TSCM.SwimClub_StartOfSwimSeason(SwimClubID: integer): TDateTime;
var
  dt: TDateTime;
begin
  result := Date();
  if SwimClubID > 0 then
  begin
    if qrySwimClub.Active then
      qrySwimClub.Close;
    qrySwimClub.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
    qrySwimClub.Prepare;
    qrySwimClub.Open;
    if qrySwimClub.Active then
    begin
      if not qrySwimClub.IsEmpty then
      begin
        dt := qrySwimClub.FieldByName('StartOfSwimSeason').AsDateTime;
        // If ANow and AThen are two and a half years apart,
        // calling WithinPastYears with AYears set to 2 returns True.
        if WithinPastYears(result, dt, 1) then
          result := dt;
      end;
    end;
  end;
end;

procedure TSCM.TEAMENTRANT_Delete(aTeamEntrantID: integer);
var
  SQL: string;
begin
    dsTeamEntrant.DataSet.DisableControls;
    { DELETE SPLIT TIMES
    Not implemented for team entrants. Refer to TeamSplit
    //    Split_DeleteALLSplitTimesTEAMENTRANT(aTeamEntrantID);
    }
    // DELETE THE ENTRANT FROM THE TEAM
    // Note: State of heat (raced/closed) not considered.
    // Note: Does not remove nomination to Event.
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[TeamEntrant] WHERE [TeamEntrantID] = :ID';
    scmConnection.ExecSQL(SQL, [aTeamEntrantID]);
    dsTeamEntrant.DataSet.EnableControls;
end;

procedure TSCM.TEAMENTRANT_DeleteALL(aTeamID: integer);
var
  SQL: string;
begin
    dsTeamEntrant.DataSet.DisableControls;
    { DELETE SPLIT TIMES
    Not implemented for team entrants. Refer to TeamSplit
    //    Split_DeleteALLSplitTimesTEAMENTRANT(aTeamEntrantID);
    }
    // DELETE ALL TEAM-ENTRANTS FROM TEAM
    // Note: State of heat (raced/closed) not considered.
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[TeamEntrant] WHERE [TeamID] = :ID';
    scmConnection.ExecSQL(SQL, [aTeamID]);
    dsTeamEntrant.DataSet.EnableControls;
end;

procedure TSCM.TEAM_ClearLane(aTeamID: integer);
var
  SearchOptions: TLocateOptions;
  tbl: TFDTable;
  success: Boolean;
begin
  if not fSCMActive then
    exit;
  if (aTeamID = 0) then
    exit;
  tbl := TFDTable.Create(self);
  tbl.Connection := scmConnection;
  tbl.TableName := 'Team';
  tbl.IndexFieldNames := 'TeamID';
  tbl.Open;
  if (tbl.Active) then
  begin
    SearchOptions := [];
    success := tbl.Locate('TeamID', aTeamID, SearchOptions);
    if (success) then
    begin
      tbl.Edit;
      tbl.FieldByName('RelayID').Clear;
      tbl.FieldByName('DisqualifyCodeID').Clear;
      tbl.FieldByName('RaceTime').Clear;
      tbl.FieldByName('TimeToBeat').Clear;
      tbl.FieldByName('PersonalBest').Clear;
      tbl.FieldByName('IsDisqualified').AsBoolean := false;
      tbl.FieldByName('IsScratched').AsBoolean := false;
      tbl.Post;

      TEAMENTRANT_DeleteALL(aTeamID);
      Split_DeleteALLSplitTimesTEAM(aTeamID);
    end;
  end;
  tbl.Close;
  tbl.Free;
end;

function TSCM.TEAM_CountLanes(aHeatID: integer): integer;
begin
  { TODO -oBSA -cGeneral : original C++ code init result as -1 }
  result := 0;
  if not fSCMActive then
    exit;
  qryTeamHeatLaneCount.Close;
  qryTeamHeatLaneCount.ParamByName('HeatID').AsInteger := aHeatID;
  qryTeamHeatLaneCount.Prepare;
  qryTeamHeatLaneCount.Open;
  if (qryTeamHeatLaneCount.Active) then
    if not qryTeamHeatLaneCount.IsEmpty then
      result := qryTeamHeatLaneCount.FieldByName('Count_Lane').AsInteger;
  qryTeamHeatLaneCount.Close;
end;

procedure TSCM.TEAM_CreateEmptyLane(aHeatID, aLane: integer);
var
  tbl: TFDTable;
begin
  if not fSCMActive then
    exit;
  tbl := TFDTable.Create(self);
  tbl.Connection := scmConnection;
  tbl.TableName := 'Team';
  tbl.IndexFieldNames := 'TeamID';
  tbl.Open;
  if (tbl.Active) then
  begin
    tbl.Insert;
    tbl.FieldByName('HeatID').AsInteger := aHeatID;
    tbl.FieldByName('Lane').AsInteger := aLane;
    tbl.FieldByName('IsDisqualified').AsBoolean := false;
    tbl.FieldByName('IsScratched').AsBoolean := false;
    tbl.Post;
  end;
  tbl.Close;
  tbl.Free;
end;

procedure TSCM.TEAM_Delete(aTeamID: integer);
begin
  TEAM_DeleteExclude(aTeamID, false); // Even if team is in race or closed heat.
end;

procedure TSCM.TEAM_DeleteALL(aHeatID: integer);
begin
  TEAM_DeleteALLExclude(aHeatID, false); // Including teams in race or closed heat.
end;

procedure TSCM.TEAM_DeleteALLExclude(aHeatID: integer; DoExclude: Boolean);
var
  SQL: string;
  qry: TFDQuery;
  aTeamID: integer;
begin
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := 'SELECT [Team].[TeamID], [HeatIndividual].[HeatStatusID] ' +
    'FROM [SwimClubMeet].[dbo].[Team] ' +
    'INNER JOIN HeatIndividual ON Team.HeatID = HeatIndividual.HeatID ' +
    'WHERE [Team].HeatID = ' + IntToStr(aHeatID);
  qry.IndexFieldNames := 'TeamID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aTeamID := qry.FieldByName('TeamID').AsInteger;
      if (qry.FieldByName('HeatStatusID').AsInteger = 1) or (DoExclude = false)
      then
      begin
        TEAM_DeleteExclude(aTeamID, false); // Also performs - Delete TeamSplit/TeamEntrant.
      end;
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

procedure TSCM.TEAM_DeleteExcessLanes(aHeatID: integer);
var
  NumOfLanes, i: integer;
begin
  if not fSCMActive then
    exit;
  // create empty lanes
  NumOfLanes := SwimClub_NumberOfLanes;
  with dsTeam.DataSet do
  begin
    // TODO: Store current TeamID for later locate
    // (or let caller deal with it?)
    DisableControls;
    First;
    i := 1;
    while not Eof do
    begin
      i := i + 1;
      Next;
      if (i > NumOfLanes) then
        break;
    end;
    if i > NumOfLanes then
    begin
      // Resynchronizes the dataset to make the next undeleted record active.
      // If the record deleted was the last record in the dataset, then the
      // previous record becomes the current record.
      while not Eof do
      begin
        TEAM_EmptyLane; // nomination remains alive.
        Delete;
      end;
    end;
    EnableControls;
  end;
end;

procedure TSCM.TEAM_DeleteExclude(aTeamID: integer; DoExclude: Boolean);
var
  SQL: string;
  qry: TFDQuery;
  HeatStatusID: integer;
begin
  HeatStatusID := TEAM_HeatStatusID(aTeamID);
  if (HeatStatusID = 1) or (DoExclude = false) then
  begin
    dsTeam.DataSet.DisableControls;
    // DELETE SPLIT TIMES
    Split_DeleteALLSplitTimesTEAM(aTeamID);
    // DELETE TEAM-ENTRANTS FROM RELAY
    TEAMENTRANT_DeleteALL(aTeamID);
    // FINALLY DELETE TEAM RECORD
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[Team] WHERE [TeamID] = :ID';
    scmConnection.ExecSQL(SQL, [aTeamID]);
    dsTeam.DataSet.EnableControls;
  end;
end;

function TSCM.TEAM_EmptyLane: Boolean;
var
  TeamID: integer;
  nom: TSCMNom;
begin
  result := false;
  with dsTeam.DataSet do
  begin
    DisableControls;
    CheckBrowseMode; // post any changes
    TeamID := FieldByName('TeamID').AsVariant;

    { TODO -oBSA -cGeneral : WIP - Team EmptyLane }
    {
      nom := TSCMNom.CreateWithConnection(self, scmConnection);
      if Assigned(nom) then
      begin
      nom.EmptyLane(TeamID);
      result := true;
      end;
      nom.Free;
    }

    Refresh;
    // cue-to ID
    TEAM_Locate(TeamID);
    EnableControls;
  end;

end;

function TSCM.TEAM_HeatStatusID(aTeamID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if aTeamID > 0 then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet].[dbo].[Team] ' +
      'INNER JOIN HeatIndividual ON [Team].[HeatID] = ' +
      '[HeatIndividual].[HeatID] WHERE [Team].[TeamID] = :ID;';
    v := scmConnection.ExecSQLScalar(SQL, [aTeamID]);
    if not VarIsEmpty(v) or not VarIsNull(v) then
      result := v;
  end;
end;

procedure TSCM.TEAM_InsertEmptyLanes(aHeatID: integer);
var
  i, LanesToBuild: integer;
begin
  // CALLED BY : qryHeat AfterInsert ...
  // New heats, do not have any lanes assigned to them.
  // BUILD POOL LANES in entrant table.
  if not fSCMActive then
    exit;
  LanesToBuild := SwimClub_NumberOfLanes;
  dsTeam.DataSet.DisableControls;
  for i := 1 to LanesToBuild do
    TEAM_CreateEmptyLane(aHeatID, i);
  dsTeam.DataSet.EnableControls;
end;

function TSCM.TEAM_Locate(TeamID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then
    exit;
  if (TeamID = 0) then
    exit;
  SearchOptions := [];
  if dsTeam.DataSet.Active then
    result := dsTeam.DataSet.Locate('TeamID', TeamID, SearchOptions);
end;

function TSCM.TEAM_NextAvailLaneNum(aHeatID, aSeedNumber: integer): integer;
var
  i, rtnValue: integer;
  NumOfLanes: integer;
  SQL: string;
begin
  result := 0;
  NumOfLanes := dsSwimClub.DataSet.FieldByName('NumOfLanes').AsInteger;
  if aSeedNumber <= NumOfLanes then
  begin
    for i := aSeedNumber to NumOfLanes do
    begin
      SQL := 'SELECT Lane FROM SwimClubMeet.dbo.Team WHERE Lane = ' +
        IntToStr(i) + ' AND HeatID = ' + IntToStr(aHeatID);
      // returns variant. NULL or nil values equate to 0
      rtnValue := scmConnection.ExecSQLScalar(SQL);
      // lane number not found.
      if (rtnValue <> i) then
      begin
        result := i;
        exit;
      end;
    end;
  end;
  // No in range lane numbers found - find the max, then add 1.
  if (result = 0) then
  begin
    SQL := 'SELECT MAX(Lane) AS Lane FROM SwimClubMeet.dbo.Team WHERE HeatID = '
      + IntToStr(aHeatID);
    rtnValue := scmConnection.ExecSQLScalar(SQL);
    result := rtnValue + 1;
  end;
end;

procedure TSCM.TEAM_PadWithEmptyLanes(aHeatID: integer);
var
  NumOfLanes, CountLanesInHeat, i, j, LanesToBuild: integer;
begin
  if not fSCMActive then
    exit;
  j := 1;
  // create empty lanes
  NumOfLanes := SwimClub_NumberOfLanes;
  CountLanesInHeat := TEAM_CountLanes(aHeatID);

  if (CountLanesInHeat > NumOfLanes) then
  begin
    // message - too many lanes.
    // Store curr EntrantID
    dsTeam.DataSet.DisableControls;
    dsTeam.DataSet.First;
    i := 1;
    while not dsTeam.DataSet.Eof do
    begin
      i := i + 1;
      dsTeam.DataSet.Next;
      if (i > NumOfLanes) then
        break;
    end;
    if i > NumOfLanes then
    begin
      // Resynchronizes the dataset to make the next undeleted record active.
      // If the record deleted was the last record in the dataset, then the
      // previous record becomes the current record.
      while not dsTeam.DataSet.Eof do
      begin
        TEAM_EmptyLane;
        dsTeam.DataSet.Delete;
      end;
    end;
    dsTeam.DataSet.EnableControls;
  end;

  if (CountLanesInHeat < NumOfLanes) then
  begin
    dsTeam.DataSet.DisableControls;
    // test for correct number of lanes ...
    LanesToBuild := NumOfLanes - CountLanesInHeat;
    for i := 1 to LanesToBuild do
    begin
      j := TEAM_NextAvailLaneNum(aHeatID, j);
      TEAM_CreateEmptyLane(aHeatID, j);
    end;
    dsTeam.DataSet.EnableControls;
  end;
end;

procedure TSCM.TEAM_RenumberLanes(aHeatID: integer);
var
  i: integer;
  s: String;
  qry: TFDQuery;
begin
  if not fSCMActive then
    exit;
  s := 'SELECT [TeamID], [Lane] FROM [dbo].[Team] ';
  s := s + 'WHERE HeatID = ' + IntToStr(aHeatID) + ' ORDER BY [Lane]';
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := s;
  qry.IndexFieldNames := 'TeamID';
  qry.UpdateOptions.KeyFields := 'TeamID';
  qry.UpdateOptions.UpdateTableName := 'SwimClubMeet..Team';
  qry.Open;
  if qry.Active then
  begin
    i := 1;
    // RENUMBER ENTRANT LANES
    while not qry.Eof do
    begin
      qry.Edit;
      qry.FieldByName('Lane').AsInteger := i;
      qry.Post;
      i := i + 1;
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

function TSCM.TEAM_Sort(aHeatID: integer): Boolean;
begin

end;

function TSCM.TEAM_Strike: Boolean;
var
  TeamID: integer;
  nom: TSCMNom;
begin
  result := false;
  with dsTeam.DataSet do
  begin
    CheckBrowseMode; // post any changes
    TeamID := FieldByName('TeamID').AsInteger;
    if (TeamID > 0) then
    begin
    {
      nom := TSCMNom.CreateWithConnection(self, scmConnection);
      if Assigned(nom) then
      begin
        DisableControls;
        nom.StrikeExecute(TeamID, dsTeam.DataSet);
        result := true;
        Refresh;
        EnableControls;
      end;
      nom.Free;
    }
    end;
  end;
end;

{
  function TSCM.DeleteAllEntrants(ADataSet: TDataSet): Boolean;

  var
  strSQL: string;
  begin
  result := false;
  // Automatically posts or cancels data changes when
  // the active record changes.
  ADataSet.CheckBrowseMode();
  if ADataSet.IsEmpty then
  exit;
  // ITERATE OVER ENTRANTS
  ADataSet.First;
  while not ADataSet.Eof do
  begin
  // Delete data in table split where EntrantID.
  strSQL := 'DELETE FROM dbo.Split WHERE Split.EntrantID = ' +
  IntToStr(ADataSet.FieldByName('EntrantID').AsInteger);
  scmConnection.ExecSQL(strSQL);
  // Deletes the active record and positions the dataset on the next record.
  ADataSet.Delete;
  end;
  result := true;
  end;



  function TSCM.Event_DeleteAll(ADataSet: TDataSet; SafeMode: Boolean): Boolean;
  var
  fld: TField;
  begin
  result := false;
  // Automatically posts or cancels data changes.
  ADataSet.CheckBrowseMode();
  if ADataSet.IsEmpty then
  exit;
  // ITERATE OVER EVENTS
  ADataSet.First;
  while not ADataSet.Eof do
  begin
  if (SafeMode) then
  begin
  // SKIP EVENT (if CLOSED OR RACED)
  if (ADataSet.FieldByName('EventStatusID').AsInteger <> 1) then
  begin
  ADataSet.Next();
  continue;
  end;
  end
  else
  begin
  // CHANGE STATE, ELSE MAY PREVENT DELETION
  fld := ADataSet.FindField('EventStatusID');
  if Assigned(fld) then
  begin
  fld.ReadOnly := false;
  ADataSet.Edit;
  ADataSet.FieldByName('EventStatusID').AsInteger := 1;
  ADataSet.Post;
  end;
  end;
  // DELETE ALL HEATS - note: safemode is off
  DeleteAllHeatIndividuals(qryHeat, false);
  // Deletes the active record (wit. the event)
  // ... and positions the dataset on the next record.
  ADataSet.Delete();
  end;
  result := true;

  end;

  function TSCM.DeleteAllHeatIndividuals(ADataSet: TDataSet;
  SafeMode: Boolean): Boolean;
  var
  fld: TField;
  begin
  result := false;
  // Automatically posts or cancels data changes.
  ADataSet.CheckBrowseMode();
  if ADataSet.IsEmpty then
  exit;
  // ITERATE OVER HEATS
  ADataSet.First;
  while not ADataSet.Eof do
  begin
  if (SafeMode) then
  begin
  // SKIP HEAT (if CLOSED OR RACED)
  if (ADataSet.FieldByName('HeatStatusID').AsInteger <> 1) then
  begin
  ADataSet.Next();
  continue;
  end;
  end
  else
  begin
  // CHANGE STATE, ELSE MAY PREVENT DELETION
  fld := ADataSet.FindField('HeatStatusID');
  if Assigned(fld) then
  begin
  fld.ReadOnly := false;
  ADataSet.Edit;
  ADataSet.FieldByName('HeatStatusID').AsInteger := 1;
  ADataSet.Post;
  end;
  end;
  // DELETE ALL ENTRANTS (and split-times info)
  DeleteAllEntrants(qryEntrant);
  // Deletes the active record (wit: the heat)
  // ... and positions the dataset on the next record.
  ADataSet.Delete();
  end;
  // pointless to renumber if ALL the heats were deleted
  if (SafeMode) then
  Heat_Renumber;
  result := true;
  end;
}

end.
