unit dmSCM;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, dmSCMNom, Windows, Winapi.Messages;

type
  TEventType = (etUnknown = 0, etINDV = 1, etTEAM = 2);

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
    dsSplit: TDataSource;
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
    qryEventEventTypeID: TIntegerField;
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
    qryHeatcStatus: TWideStringField;
    qryHeatEventID: TIntegerField;
    qryHeatHeatID: TFDAutoIncField;
    qryHeatHeatNum: TIntegerField;
    qryHeatHeatStatusID: TIntegerField;
    qryHeatHeatTypeID: TIntegerField;
    qryIsQualified: TFDQuery;
    qryIsQualifiedALT: TFDQuery;
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
    qrySortHeatTeam: TFDQuery;
    qrySortHeatTeam_EmptyLanes: TFDQuery;
    qrySortHeat_EmptyLanes: TFDQuery;
    qrySplit: TFDQuery;
    qrySplitEntrantID: TIntegerField;
    qrySplitSplitID: TFDAutoIncField;
    qrySplitSplitTime: TTimeField;
    qrySwapEntrants: TFDQuery;
    qrySwapTeams: TFDQuery;
    qrySwimClub: TFDQuery;
    qryTeam: TFDQuery;
    qryTeamEntrant: TFDQuery;
    qryTeamEntrantluStroke: TStringField;
    qryTeamEntrantStrokeID: TIntegerField;
    qryTeamEntrantSwimOrder: TIntegerField;
    qryTeamEntrantTeamEntrantID: TFDAutoIncField;
    qryTeamEntrantTeamID: TIntegerField;
    qryTeamTeamID: TFDAutoIncField;
    qryTeamTeamName: TWideStringField;
    qryTeamTeamNameID: TIntegerField;
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
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure qryEntrantAfterScroll(DataSet: TDataSet);
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
    procedure qryEvTypeBeforeInsert(DataSet: TDataSet);
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
    procedure qryTeamAfterScroll(DataSet: TDataSet);
    procedure scmConnectionAfterDisconnect(Sender: TObject);
  private
    { Private declarations }
    prefCheckUnNomination: integer;
    fHandle: HWND; // needed to handle SCM_RENUMBERHEATS Message.
    fLastDistanceID: integer;
    fLastStrokeID: integer;
    fSCMActive: Boolean;
    prefGenerateEventDescription: Boolean;
    prefGenerateEventDescStr: string;

  protected
    procedure WndProc(var wndMsg: TMessage); virtual;
    function CountLanes(aHeatID: integer): integer;
    function AssertLanes(aHeatID: integer): integer;
    function InsertEmptyLanes(aHeatID: integer): integer;
    function InsertEmptyLane(aHeatID: integer): integer;
    function RenumberLanes(aHeatID: integer): integer;
    function LastLaneNum(aHeatID: integer): integer;
    function LastLaneID(aHeatID: integer): integer;
    function FirstLaneNum(aHeatID: integer): integer;
    function FirstLaneID(aHeatID: integer): integer;
    function ClearLane(aIndvTeamID: integer; aEventType: TEventType): integer;
    function SortLanes(aHeatID: integer): integer;

  public
    { Public declarations }
    procedure ActivateTable();
    procedure DeActivateTable();
    function EmptyLane(): Boolean;

    // ENTRANT
    procedure Entrant_ClearLaneExclude(aEntrantID: integer;
      DoExclude: Boolean = true);
    function Entrant_DeleteALLExclude(aHeatID: integer;
      DoExclude: Boolean = true): integer;
    function Entrant_DeleteExclude(aEntrantID: integer;
      DoExclude: Boolean = true): integer;
    function Entrant_EmptyLane(): Boolean;
    function Entrant_HeatStatusID(aEntrantID: integer): integer;
    procedure Entrant_InsertEmptyLanes(aHeatID: integer);
    function Entrant_Locate(EntrantID: integer): Boolean;
    function Entrant_NextAvailLaneNum(aHeatID, aSeedNumber: integer): integer;
    procedure Entrant_PadWithEmptyLanes(aHeatID: integer);
    function Entrant_SessionIsLocked(aEntrantID: integer): Boolean;
    function Entrant_Sort(aHeatID: integer): Boolean;
    function Entrant_StrikeLane(): Boolean;
    function Entrant_SwapLanes(EntrantIDA, EntrantIDB: integer)
      : Boolean; overload;
    function Entrant_SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB: integer)
      : Boolean; overload;

    // EVENTS
    function Event_AllHeatsAreClosed(aEventID: integer): Boolean;
    function Event_DeleteExclude(aEventID: integer;
      DoExclude: Boolean = true): integer;
    function Event_EventType(aEventID: integer): TEventType; // RTN TEventType
    function Event_EventTypeID(aEventID: integer): integer; // RTN EventTypeID
    procedure Event_FNameEllipse();
    function Event_GetEntrantCount(aEventID: integer): integer;
    function Event_GetHeatCount(aEventID: integer): integer;
    function Event_GetNomineeCount(aEventID: integer): integer;
    function Event_HasClosedHeats(aEventID: integer): Boolean;
    function Event_HasClosedOrRacedHeats(aEventID: integer): Boolean;
    function Event_HasNominee(EventID, MemberID: integer): Boolean;
    function Event_HasNominees(aEventID: integer): Boolean;
    function Event_HasRacedHeats(aEventID: integer): Boolean;
    function Event_ID(): integer;
    function Event_IsINDV(): Boolean; // current event
    function Event_IsTEAM(): Boolean; // current event
    function Event_Locate(aEventID: integer): Boolean; overload;
    function Event_Locate(aDistanceID, aStrokeID: integer): Boolean; overload;
    procedure Event_Renumber(DoLocate: Boolean = true);
    function Event_SessionIsLocked(aEventID: integer): Boolean;
    {
      H E A T S .
    }
    procedure Heat_DeleteALLExclude(aEventID: integer;
      DoExclude: Boolean = true);
    function Heat_DeleteExclude(aHeatID: integer;
      DoExclude: Boolean = true): Boolean;
    function Heat_EventID(aHeatID: integer): integer;
    function Heat_EventType(aHeatID: integer): TEventType;
    function Heat_EventTypeID(aHeatID: integer): integer;
    function Heat_HasEntrants(aHeatID: integer): Boolean;
    function Heat_HasTeamEntrants(aHeatID: integer): Boolean;
    function Heat_HeatStatusID(aHeatID: integer): integer;
    function Heat_ID(): integer;
    function Heat_IsClosed(): Boolean; // current heat
    function Heat_IsRaced(): Boolean; // current heat
    function Heat_Locate(aHeatID: integer): Boolean;
    procedure Heat_NewRecord();
    function Heat_NextID(aHeatID: integer): integer; // uses HeatNum
    function Heat_PrevID(aHeatID: integer): integer; // uses HeatNum
    procedure Heat_Renumber(DoLocate: Boolean = true);
    function Heat_SessionIsLocked(aHeatID: integer): Boolean;
    procedure Heat_ToggleStatus(); // current heat
    procedure Heat_UpdateStatusBar();
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
    function Nominate_Locate(MemberID: integer): Boolean;
    function Nominate_LocateEventNum(ADataSet: TDataSet;
      EventNum: integer): Boolean;
    function Nominate_SortMembers(SortState: Boolean): Boolean;
    function Nominate_UpdateControlList(SessionID, MemberID: integer): Boolean;
    procedure ReadPreferences(IniFileName: string);
    // SWIMCLUBMEET SYSTEM
    function SCM_VerInfoMajor(): integer;
    // SESSION
    function Session_AllEventsAreClosed(aSessionID: integer): Boolean;
    function Session_DeleteExclude(aSessionID: integer;
      DoExclude: Boolean = true): Boolean;
    function Session_GetEntrantCount(aSessionID: integer): integer;
    function Session_GetNomineeCount(aSessionID: integer): integer;
    function Session_HasClosedOrRacedHeats(aSessionID: integer): Boolean;
    function Session_HasEvents(aSessionID: integer): Boolean;
    procedure Session_HideLocked(IsChecked: Boolean);
    function Session_ID(): integer; // current session
    function Session_IsLocked: Boolean; // current session
    function Session_Locate(SessionID: integer): Boolean;
    function Session_Start(): TDateTime; overload;
    function Session_Start(SessionID: integer): TDateTime; overload;
    procedure Session_ToggleLockState();
    {
      S P L I T .
    }
    procedure Split_DeleteALLExclude(aEntrantID: integer;
      DoExclude: Boolean = true);
    function Split_DeleteExclude(aSplitID: integer;
      DoExclude: Boolean = true): Boolean;
    function Split_HeatStatusID(aSplitID: integer): integer;
    function Split_SessionIsLocked(aSplitID: integer): Boolean;

    {
      S P L I T .
    }
    function StrikeLane(): Boolean;

    // SWAPLANES - GENERIC LANE FUNCTIONS
    function SwapLanes(IDA, IDB, aEventTypeID: integer): Boolean; overload;
    function SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB: integer)
      : Boolean; overload;

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

    // TEAM ENTRANT
    procedure TeamEntrant_DeleteALLExclude(aTeamID: integer;
      DoExclude: Boolean = true);
    function TeamEntrant_DeleteExclude(aTeamEntrantID: integer;
      DoExclude: Boolean = true): Boolean;
    function TeamEntrant_HeatStatusID(aTeamEntrantID: integer): integer;
    function TeamEntrant_MoveDownLane(ADataSet: TDataSet): Boolean;
    function TeamEntrant_MoveUpLane(ADataSet: TDataSet): Boolean;
    function TeamEntrant_SessionIsLocked(aTeamEntrantID: integer): Boolean;

    // TEAM SPLIT
    procedure TeamSplit_DeleteALLExclude(aTeamID: integer;
      DoExclude: Boolean = true);
    function TeamSplit_DeleteExclude(aSplitID: integer;
      DoExclude: Boolean = true): Boolean;
    function TeamSplit_HeatStatusID(aSplitID: integer): integer;
    function TeamSplit_SessionIsLocked(aTeamSplitID: integer): Boolean;
    function Team_ClearLaneExclude(aTeamID: integer;
      DoExclude: Boolean = true): Boolean;
    procedure Team_DeleteALLExclude(aHeatID: integer;
      DoExclude: Boolean = true);

    // TEAM
    procedure Team_DeleteExcessLanes(aHeatID: integer);
    function Team_DeleteExclude(aTeamID: integer;
      DoExclude: Boolean = true): integer;

    function Team_EventID(aTeamID: integer): integer;
    function Team_HasTeamEntrants(aTeamID: integer): Boolean;
    function Team_HeatStatusID(aTeamID: integer): integer;
    function Team_Locate(TeamID: integer): Boolean;
    function Team_NextAvailLaneNum(aHeatID, aSeedNumber: integer): integer;
    function Team_SessionIsLocked(aTeamID: integer): Boolean;
    function Team_Sort(aHeatID: integer): Boolean;
    function Team_StrikeLane(aTeamID: integer): Boolean;
    function Team_StrikeNominees(aTeamID: integer): Boolean;

    // TOGGLE DISQUALIFICATION CODE
    procedure ToggleDCode(ADataSet: TDataSet; DoEnable: Boolean);

  published
    property CheckNomination: integer read prefCheckUnNomination
      write prefCheckUnNomination;
    property Handle: HWND read fHandle;
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
  System.Variants, System.StrUtils, System.Types, System.Math,
  SCMDefines, vcl.Forms, vcl.StdCtrls, System.UITypes;

{ TSCM }

function TSCM.ClearLane(aIndvTeamID: integer; aEventType: TEventType): integer;
var
  tbl: TFDTable;
  SearchOptions: TLocateOptions;
  success: Boolean;
begin
  result := 0;
  if aEventType = etINDV then
  begin
    dsEntrant.DataSet.DisableControls;
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
        Split_DeleteALLExclude(aIndvTeamID, false);
        result := 1;
      end;
    end;
    tbl.Close;
    tbl.Free;
    dsEntrant.DataSet.EnableControls;
  end
  else if aEventType = etTEAM then
  begin
    dsTeam.DataSet.DisableControls;
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
        tbl.Edit;
        tbl.FieldByName('TeamNameID').Clear;
        tbl.FieldByName('DisqualifyCodeID').Clear;
        tbl.FieldByName('RaceTime').Clear;
        tbl.FieldByName('TimeToBeat').Clear;
        tbl.FieldByName('IsDisqualified').AsBoolean := false;
        tbl.FieldByName('IsScratched').AsBoolean := false;
        tbl.Post;
        TeamEntrant_DeleteALLExclude(aIndvTeamID, false); // remove Entrants.
        TeamSplit_DeleteALLExclude(aIndvTeamID, false); // remove Split times.
        result := 1;
      end;
    end;
    tbl.Close;
    tbl.Free;
    dsTeam.DataSet.EnableControls;
  end
end;

function TSCM.CountLanes(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: TEventType;
begin
  result := 0;
  if not fSCMActive then exit;
  if aHeatID = 0 then exit;

  aEventType := Heat_EventType(aHeatID);
  if aEventType = etINDV then
  begin
    // Count number of lanes ....
    SQL := 'SELECT Count(EntrantID) FROM SwimClubMeet.dbo.Entrant ' +
      'WHERE Entrant.HeatID = :HEATID';
  end
  else if aEventType = etTEAM then
  begin
    // Count number of lanes ....
    SQL := 'SELECT Count(TeamID) FROM SwimClubMeet.dbo.Team ' +
      'WHERE Team.HeatID = :HEATID';
  end
  else exit;

  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) or not VarIsEmpty(v) then result := v;
end;

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
  fHandle := AllocateHWnd(WndProc); // need to handle SCM_

  prefGenerateEventDescription := false;;
  prefGenerateEventDescStr := '';
  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then ReadPreferences(IniFileName);
end;

procedure TSCM.DataModuleDestroy(Sender: TObject);
begin
  DeallocateHWND(fHandle);
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
var
  aTeamID: integer;

begin
  if SCM.Event_IsINDV then result := Entrant_EmptyLane // USES NOM ...
  else
  begin
    result := false;
    with dsTeam.DataSet do
    begin
      if FieldByName('TeamNameID').IsNull then exit;
      CheckBrowseMode; // post any changes
      aTeamID := FieldByName('TeamID').AsInteger;
      // if TeamID > 0 and record has TeamNameID then
      // NULLs fields in dbo.Team and removes entrants and team split times.
      Team_ClearLaneExclude(aTeamID);
    end;
  end;
end;

procedure TSCM.Entrant_ClearLaneExclude(aEntrantID: integer;
  DoExclude: Boolean = true);
var
  aHeatStatusID: integer;
begin
  if not fSCMActive then exit;
  if (aEntrantID = 0) then exit;
  if Entrant_SessionIsLocked(aEntrantID) then exit;
  aHeatStatusID := Entrant_HeatStatusID(aEntrantID);
  if not(aHeatStatusID > 1) or (DoExclude = false) then
  begin
    ClearLane(aEntrantID, etINDV);
  end;
end;

function TSCM.Entrant_DeleteALLExclude(aHeatID: integer;
  DoExclude: Boolean = true): integer;
var
  qry: TFDQuery;
  rows, aEntrantID: integer;
begin
  result := 0;
  rows := 0;
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text :=
    'SELECT [Entrant].[EntrantID] FROM [SwimClubMeet].[dbo].[Entrant] ' +
    'WHERE [Entrant].HeatID = ' + IntToStr(aHeatID);
  qry.IndexFieldNames := 'EntrantID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aEntrantID := qry.FieldByName('EntrantID').AsInteger;
      rows := rows + Entrant_DeleteExclude(aEntrantID, DoExclude);
      qry.Next;
    end;
    if rows > 0 then result := rows;
  end;
  qry.Close;
  qry.Free;

end;

function TSCM.Entrant_DeleteExclude(aEntrantID: integer;
  DoExclude: Boolean = true): integer;
var
  SQL: string;
  aHeatStatusID: integer;
begin
  result := 0;
  if not fSCMActive then exit;
  if Entrant_SessionIsLocked(aEntrantID) then exit;
  aHeatStatusID := Entrant_HeatStatusID(aEntrantID);
  // Unassigned heat status accepted as 'Open'
  if not(aHeatStatusID > 1) or (DoExclude = false) then
  begin
    dsEntrant.DataSet.DisableControls;
    // DELETE SPLIT TIMES
    Split_DeleteALLExclude(aEntrantID, DoExclude);
    // FINALLY DELETE ENTRANT RECORDS
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[Entrant] WHERE [EntrantID] = :ID';
    result := scmConnection.ExecSQL(SQL, [aEntrantID]);
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
  if not fSCMActive then exit;
  if aEntrantID > 0 then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
      'INNER JOIN Entrant ON [HeatIndividual].[HeatID] = Entrant.HeatID ' +
      'WHERE [Entrant].[EntrantID] = :ID;';
    v := scmConnection.ExecSQLScalar(SQL, [aEntrantID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;
end;

procedure TSCM.Entrant_InsertEmptyLanes(aHeatID: integer);
var
  i, LanesToBuild: integer;
begin
  // CALLED BY : qryHeat AfterInsert ...
  // New heats, do not have any lanes assigned to them.
  // BUILD POOL LANES in entrant table.
  if not fSCMActive then exit;
  LanesToBuild := SwimClub_NumberOfLanes;
  dsEntrant.DataSet.DisableControls;
  for i := 1 to LanesToBuild do InsertEmptyLane(aHeatID);
  dsEntrant.DataSet.EnableControls;
end;

function TSCM.Entrant_Locate(EntrantID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then exit;
  if (EntrantID = 0) then exit;
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
  NumOfLanes, CountLanesInHeat, i, LanesToBuild: integer;
begin
  if not fSCMActive then exit;
  // create empty lanes
  NumOfLanes := SwimClub_NumberOfLanes;
  CountLanesInHeat := CountLanes(aHeatID);

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
      if (i > NumOfLanes) then break;
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
      InsertEmptyLane(aHeatID);
    end;
    dsEntrant.DataSet.EnableControls;
  end;
end;

function TSCM.Entrant_SessionIsLocked(aEntrantID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not fSCMActive then exit;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet].[dbo].[Session] ' +
    'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
    'INNER JOIN [HeatIndividual] ON [Event].[EventID] = [HeatIndividual].[EventID] '
    + 'INNER JOIN [Entrant] ON [HeatIndividual].[HeatID] = [Entrant].[HeatID] '
    + 'WHERE [Entrant].[EntrantID] = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aEntrantID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
end;

function TSCM.Entrant_Sort(aHeatID: integer): Boolean;
var
  s: string;
  i, lane, NumOfLanes: integer;
  DoDelete: Boolean;
begin
  { TODO -oBSa -cGeneral : Check entrant sort is working. }
  result := false;
  if not fSCMActive then exit;
  i := 0;
  DoDelete := false;
  NumOfLanes := SwimClub_NumberOfLanes;
  if (NumOfLanes = 0) then exit;

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
    s := 'DELETE FROM Entrant WHERE [HeatID] = :ID AND [Lane] IS NULL';
    scmConnection.ExecSQL(s, [aHeatID]);
  end;

  result := true;
  dsEntrant.DataSet.EnableControls;
end;

function TSCM.Entrant_StrikeLane: Boolean;
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
  if not fSCMActive then exit;
  { TODO -oBSA -cGeneral : Create swap lane function }
  SQL := 'SELECT TOP 1 [EntrantID] FROM [SwimClubMeet].[dbo].[Entrant] WHERE HeatID = :HEAT AND Lane = :LANE';
  EntrantIDA := scmConnection.ExecSQLScalar(SQL, [HeatIDA, LaneA]);
  EntrantIDB := scmConnection.ExecSQLScalar(SQL, [HeatIDB, LaneB]);
  Entrant_SwapLanes(EntrantIDA, EntrantIDB);
  result := true;
end;

function TSCM.Event_AllHeatsAreClosed(aEventID: integer): Boolean;
var
  i: integer;
begin
  result := false;
  if not fSCMActive then exit;
  qryCountHeatsNotClosed.Close;
  qryCountHeatsNotClosed.ParamByName('EVENTID').AsInteger := aEventID;
  qryCountHeatsNotClosed.Prepare;
  qryCountHeatsNotClosed.Open;
  if (qryCountHeatsNotClosed.Active) then
  begin
    i := qryCountHeatsNotClosed.FieldByName('CountStatus').AsInteger;
    if (i = 0) then result := true;
  end;
  qryCountHeatsNotClosed.Close;
end;

function TSCM.Event_DeleteExclude(aEventID: integer;
  DoExclude: Boolean = true): integer;
var
  SQL: string;
begin
  result := 0;
  if not fSCMActive then exit;
  if Event_SessionIsLocked(aEventID) then exit;
  // D E L E T E   H E A T S and remove swimmer data.
  // (including Entrants, Teams, TeamEntrants, Splits, TeamSplits...)
  Heat_DeleteALLExclude(aEventID, DoExclude);

  // Assert that all swimmer data has been removed.
  if (Event_GetEntrantCount(aEventID) = 0) or (DoExclude = false) then
  begin
    // D E L E T E   N O M I N A T I O N S .
    SQL := 'DELETE FROM dbo.Nominee WHERE Nominee.EventID = :ID';
    scmConnection.ExecSQL(SQL, [aEventID]);
  end;
  // Assert that all heats have been removed.
  if (Event_GetHeatCount(aEventID) = 0) or (DoExclude = false) then
  begin
    // FINALLY DELETE EVENT
    dsEvent.DataSet.DisableControls;
    SQL := 'DELETE FROM dbo.Event WHERE Event.EventID = :ID';
    result := scmConnection.ExecSQL(SQL, [aEventID]);
    dsEvent.DataSet.EnableControls;
  end;
end;

function TSCM.Event_EventType(aEventID: integer): TEventType;
begin
  case Event_EventTypeID(aEventID) of
    1: result := etINDV;
    2: result := etTEAM;
  else result := etUnknown;
  end;
end;

function TSCM.Event_EventTypeID(aEventID: integer): integer;
var
  v: variant;
  SQL: string;
begin
  result := 0;
  if fSCMActive and dsEvent.DataSet.Active then
    if not dsEvent.DataSet.IsEmpty then
    // v := dsEvent.DataSet.FieldByName('DistanceID').AsVariant;
    // if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0)  then
    begin
      SQL := 'SELECT [EventTypeID] FROM [SwimClubMeet].[dbo].[Event] ' +
        'INNER JOIN Distance ON [Event].DistanceID = Distance.DistanceID ' +
        'WHERE EventID = :ID';
      v := scmConnection.ExecSQLScalar(SQL, [aEventID]);
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
    end;
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
  if (ds.Active) then ds.Refresh();
end;

function TSCM.Event_GetEntrantCount(aEventID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not fSCMActive then exit;
  if aEventID = 0 then exit;
  // scalar function to count Swimmers (inc. Entrants + TeamEntrants)
  SQL := 'SELECT dbo.EntrantCount(:ID1) ' +
    'FROM SwimClubMeet.dbo.Event WHERE Event.EventID = :ID2';
  v := scmConnection.ExecSQLScalar(SQL, [aEventID, aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.Event_GetHeatCount(aEventID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not fSCMActive then exit;
  if aEventID = 0 then exit;
  SQL := 'SELECT Count(HeatIndividual.HeatID) FROM SwimClubMeet.dbo.[Event] ' +
    'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.EventID ' +
    'WHERE Event.EventID = :EventID;';
  v := scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.Event_GetNomineeCount(aEventID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not fSCMActive then exit;
  if aEventID = 0 then exit;
  // scalar function to count Nominees
  SQL := 'SELECT dbo.NomineeCount(:ID1) FROM SwimClubMeet.dbo.[Event] ' +
    'WHERE Event.EventID = :ID2';
  v := scmConnection.ExecSQLScalar(SQL, [aEventID, aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.Event_HasClosedHeats(aEventID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false; // DEFAULT - no closed heats
  if not fSCMActive then exit;
  // count the closed heats.
  SQL := 'SELECT Count([HeatIndividual].[HeatID]) FROM [SwimClubMeet].[dbo].[Event] '
    + 'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.EventID ' +
    'WHERE Event.EventID = :ID AND (HeatIndividual.HeatStatusID = 3) ';
  v := scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function TSCM.Event_HasClosedOrRacedHeats(aEventID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false; // DEFAULT - not safe
  if not fSCMActive then exit;
  // count the heats closed or raced.
  SQL := ' SELECT Count([HeatIndividual].[HeatID]) FROM [SwimClubMeet].[dbo].[Event] '
    + 'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.EventID ' +
    'WHERE Event.EventID = :ID AND (HeatIndividual.HeatStatusID > 1) ';
  v := scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
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
    if (qry.RecordCount > 0) then result := true;
  qry.Close;
end;

function TSCM.Event_HasNominees(aEventID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not fSCMActive then exit;
  SQL := 'SELECT COUNT(NomineeID) FROM SwimClubMeet.dbo.Nominee ' +
    'WHERE Nominee.EventID = :ID AND MemberID IS NOT NULL; ';
  v := scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function TSCM.Event_HasRacedHeats(aEventID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false; // DEFAULT - no raced heats
  if not fSCMActive then exit;
  // count the raced heats.
  SQL := 'SELECT Count([HeatIndividual].[HeatID]) FROM [SwimClubMeet].[dbo].[Event] '
    + 'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.EventID ' +
    'WHERE Event.EventID = :ID AND (HeatIndividual.HeatStatusID = 2) ';
  v := scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
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
      if (i > 1) then result := false;
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
  if not fSCMActive then exit;
  if (aEventID = 0) then exit;
  SearchOptions := [];
  if dsEvent.DataSet.Active then
      result := dsEvent.DataSet.Locate('EventID', aEventID, SearchOptions);
end;

function TSCM.Event_Locate(aDistanceID, aStrokeID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then exit;
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

  if not fSCMActive then exit;
  if dsEvent.DataSet.IsEmpty then exit;

  ds := dsEvent.DataSet;
  if DoLocate then aEventID := ds.FieldByName('EventID').AsInteger;

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
  if (DoLocate) then Event_Locate(aEventID);
  ds.EnableControls();
end;

function TSCM.Event_SessionIsLocked(aEventID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not fSCMActive then exit;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet].[dbo].[Session] ' +
    'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
    'WHERE [Event].[EventID] = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
end;

procedure TSCM.Heat_DeleteALLExclude(aEventID: integer;
  DoExclude: Boolean = true);
var
  aHeatID: integer;
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := 'SELECT HeatID FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
    'WHERE EventID = ' + IntToStr(aEventID);
  qry.IndexFieldNames := 'HeatID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aHeatID := qry.FieldByName('HeatID').AsInteger;
      Heat_DeleteExclude(aHeatID, DoExclude);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

function TSCM.Heat_DeleteExclude(aHeatID: integer;
  DoExclude: Boolean = true): Boolean;
var
  SQL: string;
  aHeatStatusID, rows: integer;
  DoDelete: Boolean;
begin
  result := false;
  if not fSCMActive then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    {
      NOTE: Deleting both INDV and TEAM linked to the heat is OK.
      The heat will be 'Open' but that doesn't exclude entrants from
      having 'RaceTimes' and 'SplitTimes'. (Handled by TAction in frmMain.)
    }
    Entrant_DeleteALLExclude(aHeatID, DoExclude); // Entrants+Split data
    Team_DeleteALLExclude(aHeatID, DoExclude); // Team+TeamEntrants+Split data
    DoDelete := false;
    { TODO -oBSA -cGeneral : Following checks are redundant. }
    case Heat_EventTypeID(aHeatID) of
      1: // INDV
        if not Heat_HasEntrants(aHeatID) then DoDelete := true;
      2: // TEAM
        if not Heat_HasTeamEntrants(aHeatID) then DoDelete := true;
    end;
    if DoDelete then
    begin
      dsHeat.DataSet.DisableControls();
      SQL := 'DELETE FROM [SwimClubMeet].[dbo].[HeatIndividual] WHERE HeatID = :ID';
      rows := scmConnection.ExecSQL(SQL, [aHeatID]);
      if (rows = 1) then result := true;
      dsHeat.DataSet.EnableControls();
      PostMessage(fHandle, SCM_RENUMBERHEATS, 0, 0); // Heat_Renumber();
    end;
  end;
end;

function TSCM.Heat_EventID(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  SQL := 'SELECT EventID FROM SwimClubMeet.dbo.HeatIndividual ' +
    'WHERE HeatID := :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) or not VarIsEmpty(v) then result := v;

end;

function TSCM.Heat_EventType(aHeatID: integer): TEventType;
begin
  case Heat_EventTypeID(aHeatID) of
    1: result := etINDV;
    2: result := etTEAM;
  else result := etUnknown;
  end;
end;

function TSCM.Heat_EventTypeID(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not fSCMActive then exit;
  SQL := 'SELECT EventTypeID FROM  [SwimClubMeet].[dbo].[HeatIndividual] ' +
    'INNER JOIN [Event] ON [HeatIndividual].[EventID] = [Event].[EventID] ' +
    'INNER JOIN [Distance] ON [Event].[DistanceID] = [Distance].[DistanceID] ' +
    'WHERE [HeatIndividual].HeatID = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) or not VarIsEmpty(v) or (v > 0) then result := v;
end;

function TSCM.Heat_HasEntrants(aHeatID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not fSCMActive then exit;
  SQL := 'SELECT COUNT(EntrantID) FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
    ' INNER JOIN [Entrant] ON [HeatIndividual].HeatID = [Entrant].HeatID ' +
    ' WHERE [HeatIndividual].HeatID = :ID;';
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function TSCM.Heat_HasTeamEntrants(aHeatID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not fSCMActive then exit;
  SQL := 'SELECT COUNT(TeamEntrantID) FROM [SwimClubMeet].[dbo].[HeatIndividual] '
    + ' INNER JOIN [Team] ON [HeatIndividual].HeatID = [Team].HeatID ' +
    ' INNER JOIN [TeamEntrant] ON [Team].TeamID = [TeamEntrant].TeamID ' +
    ' WHERE [HeatIndividual].HeatID = :ID;';
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function TSCM.Heat_HeatStatusID(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not fSCMActive then exit;
  SQL := 'SELECT [HeatStatusID] FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
    ' WHERE [HeatIndividual].HeatID = :ID;';
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
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
  if (HeatStatusID = 3) or (HeatStatusID = 0) then result := true;
end;

function TSCM.Heat_IsRaced: Boolean;
var
  HeatStatusID: integer;
begin
  result := false;
  HeatStatusID := dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger;
  if (HeatStatusID = 2) then result := true;
end;

function TSCM.Heat_Locate(aHeatID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then exit;
  if (aHeatID = 0) then exit;
  SearchOptions := [];
  if dsHeat.DataSet.Active then
      result := dsHeat.DataSet.Locate('HeatID', aHeatID, SearchOptions);
end;

procedure TSCM.Heat_NewRecord;
var
  fld: TField;
begin
  // can't make heats if there is no events ....
  if dsEvent.DataSet.IsEmpty then exit;
  // 3.10.2020
  with dsHeat.DataSet do
  begin
    DisableControls();
    fld := qryHeat.FindField('HeatNum');
    if Assigned(fld) then fld.ReadOnly := false;
    // creating a heat results in empty lanes being spawned
    // and HeatNum calculated, HeatType initialized, etc
    Insert;
    Post;
    // renumber also preforms dataset refresh and locates to new heat
    Heat_Renumber();
    // 3.10.2020
    if Assigned(fld) then fld.ReadOnly := true;
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
  if not fSCMActive then exit;
  if dsHeat.DataSet.IsEmpty then exit;
  aHeatID := 0;
  dsHeat.DataSet.DisableControls;
  // master-child relationship  EventID-HeatID
  aEventID := dsHeat.DataSet.FieldByName('EventID').AsInteger;
  // used later to cue-to-heat after renumber
  if (DoLocate) then aHeatID := dsHeat.DataSet.FieldByName('HeatID').AsInteger;
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
  if (DoLocate) then Heat_Locate(aHeatID);
  dsHeat.DataSet.EnableControls;
end;

function TSCM.Heat_SessionIsLocked(aHeatID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not fSCMActive then exit;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet].[dbo].[Session] ' +
    'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
    'INNER JOIN [HeatIndividual] ON [Event].[EventID] = [HeatIndividual].[EventID] '
    + 'WHERE [HeatIndividual].[HeatID] = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
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

function TSCM.InsertEmptyLane(aHeatID: integer): integer;
var
  aLaneNum: integer;
  tbl: TFDTable;
  aEventType: TEventType;
begin
    result := 0;
    if not fSCMActive then exit;
    if aHeatID = 0 then exit;

    aEventType := Heat_EventType(aHeatID);
    if (aEventType <> etINDV) or (aEventType <> etTEAM) then exit;
    if (CountLanes(aHeatID) >= SwimClub_NumberOfLanes()) then exit;

    aLaneNum := LastLaneNum(aHeatID) + 1;
    tbl := TFDTable.Create(self);
    tbl.Connection := scmConnection;
    if aEventType = etINDV then
    begin
      if not SCMActive then exit;
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
      if aEventType = etINDV then dsEntrant.DataSet.DisableControls
      else dsTeam.DataSet.DisableControls;

      tbl.Insert;
      tbl.FieldByName('HeatID').AsInteger := aHeatID;
      tbl.FieldByName('Lane').AsInteger := aLaneNum;
      tbl.FieldByName('IsDisqualified').AsBoolean := false;
      tbl.FieldByName('IsScratched').AsBoolean := false;
      tbl.Post;
      result := 1;
      if aEventType = etINDV then dsEntrant.DataSet.EnableControls
      else dsTeam.DataSet.EnableControls;
    end;
    tbl.Close;
    tbl.Free;
end;

function TSCM.InsertEmptyLanes(aHeatID: integer): integer;
var
  lanes, NumOfLanes, i: integer;
begin
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  Lanes := CountLanes(aHeatID);
  NumOfLanes := SwimClub_NumberOfLanes;
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
  RenumberLanes(aHeatID);
end;

function TSCM.IsFirstRecord(ADataSet: TDataSet): Boolean;
var
  bm: TBookMark;
begin
  result := true;
  if not(fSCMActive) then exit;
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
  if not(fSCMActive) then exit;
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
  aEventType: TEventType;
begin
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  aEventType := Heat_EventType(aHeatID);
  if aEventType = etINDV then
      SQL := 'SELECT MAX(Lane) FROM SwimClubMeet.dbo.Entrant ' +
      'Entrant.HeatID = :ID'
  else if aEventType = etTEAM then
      SQL := 'SELECT MAX(Lane) FROM SwimClubMeet.dbo.Team ' +
      'Team.HeatID = :ID'
  else exit;
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.LastLaneID(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: TEventType;
begin
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  aEventType := Heat_EventType(aHeatID);
  if aEventType = etINDV then
      SQL := 'SELECT MAX(EntrantID) FROM SwimClubMeet.dbo.Entrant ' +
      'Entrant.HeatID = :ID'
  else if aEventType = etTEAM then
      SQL := 'SELECT MAX(TeamID) FROM SwimClubMeet.dbo.Team ' +
      'Team.HeatID = :ID'
  else exit;
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.Member_IsQualified(aMemberID, aGenderID, aQualifyDistID,
  aStrokeID: integer; IsShortCourse: Boolean): Boolean;
begin
  result := false;
  if not fSCMActive then exit;
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
    HeatIDB := Heat_NextID(HeatIDA);
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
    HeatIDB := Heat_PrevID(HeatIDA);
    LaneB := SwimClub_NumberOfLanes;
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
  if not fSCMActive then exit;
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
  if not fSCMActive then exit;
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
  if not fSCMActive then exit;
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
  if not fSCMActive then exit;
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

procedure TSCM.qryEntrantAfterScroll(DataSet: TDataSet);
begin
  if Owner is TForm then
      PostMessage(TForm(Owner).Handle, SCM_ENTRANTSCROLL, 0, 0);
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
    if (Min > 0) then Text := Format('%0:2u:%1:2.2u.%2:3.3u', [Min, Sec, MSec])
    else if ((Min = 0) and (Sec > 0)) then
        Text := Format('%1:2u.%2:3.3u', [Min, Sec, MSec])

    else if ((Min = 0) and (Sec = 0)) then Text := '';
  end
  else Text := Format('%0:2.2u:%1:2.2u.%2:3.3u', [Min, Sec, MSec]);
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
    if Assigned(fld) then fld.ReadOnly := false;
    DataSet.Edit;
    DataSet.FieldByName('EventNum').AsInteger := i;
    DataSet.Post;
    if Assigned(fld) then fld.ReadOnly := true;
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

  if not fSCMActive then exit;
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
  // Check unknown (typically occurs on 'new event')
  if VarIsNull(Sender.CurValue) or VarIsEmpty(Sender.CurValue) then exit;

  // INDV or TEAM
  SQL := 'SELECT EventTypeID FROM SwimClubMeet.dbo.Distance WHERE [DistanceID] = :ID';
  v1 := scmConnection.ExecSQLScalar(SQL, [Sender.CurValue], [ftInteger]);
  v2 := scmConnection.ExecSQLScalar(SQL, [Sender.Value], [ftInteger]);
  if v1 <> v2 then // switching event type ...
  begin
    // test for Heats
    SQL := 'SELECT Count(HeatID) FROM SwimClubMeet.dbo.HeatIndividual WHERE [EventID] = :ID';
    i := Event_ID;
    v3 := scmConnection.ExecSQLScalar(SQL, [i]);
    if (v3 <> 0) then
    begin
      Raise Exception.Create
        ('When an event has heats it cannot be switched between INDV and RELAY');
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
  if Assigned(fld) then fld.ReadOnly := false;

  DataSet.Edit;
  DataSet.FieldByName('EventStatusID').AsInteger := 1;
  DataSet.Post;

  if Assigned(fld) then fld.ReadOnly := true;
end;

procedure TSCM.qryEventScheduleDTGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.IsNull then Text := ''
  else Text := FormatDateTime('hh:nn', Sender.AsDateTime);
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

  s := ReplaceText(Text, ' ', '0'); // tidy-up : replace editmask spaces
  fs := TFormatSettings.Create; // class record - free not required.
  if TryStrToTime(s, dt, fs) then
  begin
    Sender.AsDateTime := dt; // NOTE: Only time portion is used by DB.
  end;

end;

procedure TSCM.qryEvTypeBeforeInsert(DataSet: TDataSet);
begin
  // lanes are created when new heat is called
  // .. user cannnot enter new lanes from here...
  Abort();
end;

procedure TSCM.qryHeatAfterDelete(DataSet: TDataSet);
begin
  Heat_Renumber();
end;

procedure TSCM.qryHeatAfterPost(DataSet: TDataSet);
var
  aHeatID, NumOfLanes, i: integer;
begin
  aHeatID := DataSet.FieldByName('HeatID').AsInteger;
  if (aHeatID = 0) then exit;

  NumOfLanes := SwimClub_NumberOfLanes;
  i := CountLanes(aHeatID);
  // AFTER every post to heats ...
  // THIS ROUTINE ASSERTS CORRECT NUMBER OF LANES
  if (i <> NumOfLanes) then
  begin
    AssertLanes(aHeatID);
    dsEntrant.DataSet.Refresh; // required
//    Entrant_Locate(EntrantID);
  end;

end;

function TSCM.FirstLaneID(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: TEventType;
begin
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  aEventType := Heat_EventType(aHeatID);
  if aEventType = etINDV then
      SQL := 'SELECT MIN(EntrantID) FROM SwimClubMeet.dbo.Entrant ' +
      'Entrant.HeatID = :ID'
  else if aEventType = etTEAM then
      SQL := 'SELECT MIN(TeamID) FROM SwimClubMeet.dbo.Team ' +
      'Team.HeatID = :ID'
  else exit;
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.FirstLaneNum(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: TEventType;
begin
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  aEventType := Heat_EventType(aHeatID);
  if aEventType = etINDV then
      SQL := 'SELECT MIN(Lane) FROM SwimClubMeet.dbo.Entrant ' +
      'Entrant.HeatID = :ID'
  else if aEventType = etTEAM then
      SQL := 'SELECT MIN(Lane) FROM SwimClubMeet.dbo.Team ' +
      'Team.HeatID = :ID'
  else exit;
  v := scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.AssertLanes(aHeatID: integer): integer;
begin
  result := 0;
  if not fSCMActive then exit;
  {TODO -oBSA -cGeneral : CODE ASSERTLANES - PAD TRIM RENUMBER}
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
  fs: TFormatSettings;
  s: string;
  i, i2: integer;
  MonthPreceeds: Boolean;
begin
  // Furnish the locale format settings record
  fs := TFormatSettings.Create();
  s := fs.ShortDateFormat;
  // AMERICAN or WORLD month-day order ...
  i := Pos('D', UpperCase(s));
  i2 := Pos('M', UpperCase(s));
  MonthPreceeds := false;
  if (i2 < i) then MonthPreceeds := true;
  // DisplayText is true if the field's value is to be used for display only;
  // false if the string is to be used for editing the field's value.
  if (DisplayText) then
    // The format as set by the LOCALE
    // Numerous display possibilities YY/MM/DD hh:mm ttt or mm/dd/yyyy etc ....
      Text := FormatDateTime(fs.ShortDateFormat + ' ' + fs.ShortTimeFormat,
      Sender.AsDateTime, fs)
  else
    // FORMAT 'STRICT' - USED WHEN EDITING .....
    // Using FS ensures correct values are pulled ....
    if (MonthPreceeds) then
        Text := FormatDateTime('MM/dd/yy HH:nn', Sender.AsDateTime, fs)
    else Text := FormatDateTime('dd/MM/yy HH:nn', Sender.AsDateTime, fs);
end;

procedure TSCM.qrySessionSessionStartSetText(Sender: TField;
  const Text: string);
var
  year, month, day, Hour, Min, txt: string;
  sa: TStringDynArray;
  dt: TDateTime;
  i, i2: integer;
  MonthPreceeds: Boolean;
  fs: TFormatSettings;

begin
  MonthPreceeds := false;
  fs := fs.Create();
  i := Pos('D', UpperCase(fs.ShortDateFormat));
  i2 := Pos('M', UpperCase(fs.ShortDateFormat));
  if (i2 < i) then MonthPreceeds := true;

  // Text excludes literal character used in editmask!
  txt := Text;
  // Insert missing literal characters - required to get SlitString running
  if (Length(txt) = 14) then
  begin
    if (txt[1] = ' ') then txt[1] := '0';
    if (txt[2] = ' ') then txt[2] := '0';
    if (txt[4] = ' ') then txt[4] := '0';
    if (txt[5] = ' ') then txt[5] := '0';
    if (txt[7] = ' ') then txt[7] := '0';
    if (txt[8] = ' ') then txt[8] := '0';
    if (txt[9] = ' ') then txt[9] := '_';
    if (txt[10] = ' ') then txt[10] := '0';
    if (txt[11] = ' ') then txt[11] := '0';
    if (txt[13] = ' ') then txt[13] := '0';
    if (txt[14] = ' ') then txt[14] := '0';
  end
  // Error trap - probably unnessary - hence no error message
  else exit;
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
  else exit;

  // encoding two digit years may be illegal
  if (StrToIntDef(year, 0) = 0) then
    // fixes users input of '00'
      year := IntToStr(YearOf(Today()))
  else year := '20' + year;

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

procedure TSCM.qryTeamAfterScroll(DataSet: TDataSet);
begin
  if Owner is TForm then PostMessage(TForm(Owner).Handle, SCM_TEAMSCROLL, 0, 0);
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

  i := iFile.ReadInteger('Preferences', 'CheckUnNomination', iUnChecked);
  prefCheckUnNomination := i;

  iFile.Free;
end;

function TSCM.RenumberLanes(aHeatID: integer): integer;
var
  i: integer;
  SQL: String;
  qry: TFDQuery;
  aEventType: TEventType;
begin
  result := 0;
  i := 1; // RENUMBER ENTRANT LANES
  if not fSCMActive then exit;
  if aHeatID = 0 then exit;
  aEventType := Heat_EventType(aHeatID);

  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  if aEventType = etINDV then
  begin
    SQL := 'SELECT [EntrantID], [Lane] FROM [dbo].[Entrant] ' +
      'WHERE HeatID = ' + IntToStr(aHeatID) + ' ORDER BY [Lane]';
    qry.IndexFieldNames := 'EntrantID';
    qry.UpdateOptions.KeyFields := 'EntrantID';
    qry.UpdateOptions.UpdateTableName := 'SwimClubMeet..Entrant';
  end
  else if aEventType = etTEAM then
  begin
    SQL := 'SELECT [TeamID], [Lane] FROM [dbo].[Team] ' + 'WHERE HeatID = ' +
      IntToStr(aHeatID) + ' ORDER BY [Lane]';
    qry.IndexFieldNames := 'TeamID';
    qry.UpdateOptions.KeyFields := 'TeamID';
    qry.UpdateOptions.UpdateTableName := 'SwimClubMeet..Team';
  end
  else exit;

  qry.SQL.Text := SQL;
  qry.Open;
  if qry.Active then
  begin
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
  result := i;
end;

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
  if not fSCMActive then exit;
  qryCountEventsNotClosed.Close;
  qryCountEventsNotClosed.ParamByName('SESSIONID').AsInteger := aSessionID;
  qryCountEventsNotClosed.Prepare;
  qryCountHeatsNotClosed.Open;
  if (qryCountEventsNotClosed.Active) then
  begin
    i := qryCountEventsNotClosed.FieldByName('CountStatus').AsInteger;
    if (i = 0) then result := true;
  end;
  qryCountEventsNotClosed.Close;
end;

function TSCM.Session_DeleteExclude(aSessionID: integer;
  DoExclude: Boolean = true): Boolean;
var
  SQL: string;
  qry: TFDQuery;
  aEventID, rows: integer;
begin
  // No locked session is ever deleted.
  result := false;
  if Session_IsLocked then exit;
  // iter over events - delete nominations,heats,entrant/relays,splits,etc....
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := 'SELECT [Event].[EventID] FROM [SwimClubMeet].[dbo].[Event] '
    + 'WHERE [Event].SessionID = ' + IntToStr(aSessionID);
  qry.IndexFieldNames := 'EventID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aEventID := qry.FieldByName('EventID').AsInteger;
      // delete nominees, heats, entrants, teams, team entrants, splits, etc
      Event_DeleteExclude(aEventID, DoExclude);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
  // finally delete the session
  if not Session_HasEvents(aSessionID) or (DoExclude = false) then
  begin
    dsSession.DataSet.DisableControls;
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[Session] WHERE [SessionID] = :ID';
    rows := scmConnection.ExecSQL(SQL, [aSessionID]);
    if (rows = 1) then result := true;
    dsSession.DataSet.EnableControls;
  end;
end;

function TSCM.Session_GetEntrantCount(aSessionID: integer): integer;
begin
  result := 0;
  if not fSCMActive then exit;
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
  if not fSCMActive then exit;
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

function TSCM.Session_HasClosedOrRacedHeats(aSessionID: integer): Boolean;
var
  qry: TFDQuery;
begin
  result := false;
  if not fSCMActive then exit;
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := 'SELECT [Event].EventID FROM  [SwimClubMeet].[dbo].[Session] '
    + ' INNER JOIN [Event] ON [Session].SessionID = [Event].SessionID ' +
    ' WHERE [Session].SessionID = ' + IntToStr(aSessionID);
  qry.IndexFieldNames := 'EventID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      if Event_HasClosedOrRacedHeats(qry.FieldByName('EventID').AsInteger) then
      begin
        result := true;
        break;
      end;
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

function TSCM.Session_HasEvents(aSessionID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not fSCMActive then exit;
  SQL := 'SELECT COUNT(EventID) FROM [SwimClubMeet].[dbo].[Session] ' +
    ' INNER JOIN [Event] ON [Session].SessionID = [Event].SessionID ' +
    ' WHERE [Session].SessionID = :ID;';
  v := scmConnection.ExecSQLScalar(SQL, [aSessionID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
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

function TSCM.Session_Locate(SessionID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then exit;
  if (SessionID = 0) then exit;
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
  if not fSCMActive then exit;
  with dsSession.DataSet do
  begin
    DisableControls;
    i := FieldByName('SessionStatusID').AsInteger;
    // TOGGLE STATUS
    if i = 1 then i := 2
    else i := 1;
    Edit;
    FieldByName('SessionStatusID').AsInteger := i;
    Post;
    Refresh;
    EnableControls;
  end;
end;

function TSCM.SortLanes(aHeatID: integer): integer;
var
SQL: string;
qry: TFDQuery;
aEventType: TEventType;
i, lane, NumOfLanes: integer;
begin
  result := 0; i := 0;
  if not fSCMActive then exit;
  if aHeatID = 0 then exit;
  {PART 1: scatter non-null IndvTeamID records. (ie. swimmers or relays}
  aEventType := Heat_EventType(aHeatID);
  {Sort order is fastest to slowest to time not given.}
  if (aEventType = etINDV) then
  begin
  SQL := 'SELECT Entrant.TimeToBeat, CASE WHEN ' +
      '(CAST(CAST(Entrant.TimeToBeat AS DATETIME) AS FLOAT) = 0) ' +
      'THEN 1 ELSE 0 END AS SORTORDER, Entrant.Lane ' +
      'FROM Entrant WHERE Entrant.MemberID IS NOT NULL AND ' +
      'Entrant.HeatID = :HEATID ORDER BY SORTORDER, TimeToBeat ';
  end
  else if (aEventType = etINDV) then
  begin
  SQL := 'SELECT Team.TimeToBeat, CASE WHEN ' +
      '(CAST(CAST(Team.TimeToBeat AS DATETIME) AS FLOAT) = 0) ' +
      'THEN 1 ELSE 0 END AS SORTORDER, Team.Lane' +
      'FROM Team WHERE Team.TeamNameID IS NOT NULL AND ' +
      'Team.HeatID = :HEATID ORDER BY SORTORDER, TimeToBeat ';
  end
  else exit;

  if (aEventType = etINDV) then dsEntrant.DataSet.DisableControls
  else dsTeam.DataSet.DisableControls;

  NumOfLanes := SwimClub_NumberOfLanes;
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.IndexFieldNames := 'SORTORDER;TimeToBeat';
  qry.ParamByName('HEATID').AsInteger := aHeatID;
  qry.Prepare;
  qry.Open;
  if qry.Active then
  begin
    i := 0; // NOTE: ScatterLanes is based 0
    while not qry.Eof do
    begin
      lane := SCMUtility.ScatterLanes(i, NumOfLanes);
      qry.Edit;
      qry.FieldByName('Lane').AsInteger := lane;
      qry.Post;
      i := i + 1;
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;

  {PART 2: Scatter lane number to the remaining empty lanes.}
  if (aEventType = etINDV) then
  begin
    SQL := 'SELECT Entrant.EntrantID, Entrant.Lane FROM Entrant ' +
        'WHERE Entrant.MemberID IS NULL AND Entrant.HeatID = :HEATID ';
  end
  else if (aEventType = etINDV) then
  begin
    SQL := 'SELECT Team.TeamID, Team.Lane FROM Team ' +
      'WHERE Team.TeamNameID IS NULL AND Team.HeatID = :HEATID ';
  end;
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.ParamByName('HEATID').AsInteger := aHeatID;
  if (aEventType = etINDV) then qry.IndexFieldNames := 'EntrantID'
  else qry.IndexFieldNames := 'TeamID';
  qry.Prepare;
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      if (i < NumOfLanes) then
      begin
        lane := SCMUtility.ScatterLanes(i, NumOfLanes);
        qry.Edit;
        qry.FieldByName('Lane').AsInteger := lane;
        qry.Post;
        i := i + 1;
        qry.Next;
      end
      else
      {
        Here we assign null to these erronous lanes in preparation
        to delete them.
      }
      begin
        qrySortHeat_EmptyLanes.Edit;
        qrySortHeat_EmptyLanes.FieldByName('Lane').Clear;
        qrySortHeat_EmptyLanes.Post;
      end;
    end;
  end;
  qry.Close;
  qry.Free;

  {
    PART 3: If the pool's numoflanes is exceeded - remove them.
    Note: it's assumed that these lanes don't have split data.
  }
  if (aEventType = etINDV) then
  SQL := 'DELETE FROM Entrant WHERE [HeatID] = :ID AND [Lane] IS NULL'
  else
  SQL := 'DELETE FROM Team WHERE [HeatID] = :ID AND [Lane] IS NULL';
  scmConnection.ExecSQL(SQL, [aHeatID]);

  if (aEventType = etINDV) then dsEntrant.DataSet.EnableControls
  else dsTeam.DataSet.EnableControls;
  result := i;
end;

procedure TSCM.Split_DeleteALLExclude(aEntrantID: integer; DoExclude: Boolean);
var
  qry: TFDQuery;
  aSplitID: integer;
begin
  if not fSCMActive then exit;
  if Entrant_SessionIsLocked(aEntrantID) then exit;
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.IndexFieldNames := 'EntrantID';
  qry.SQL.Text := 'SELECT [Split].[SplitID] FROM [SwimClubMeet].[dbo].[Split] '
    + 'WHERE [Split].EntrantID = :ID';
  qry.ParamByName('ID').AsInteger := aEntrantID;
  qry.Prepare;
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aSplitID := qry.FieldByName('SplitID').AsInteger;
      Split_DeleteExclude(aSplitID, DoExclude);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

function TSCM.Split_DeleteExclude(aSplitID: integer;
  DoExclude: Boolean = true): Boolean;
var
  SQL: string;
  aHeatStatusID, rows: integer;
begin
  result := false;
  if not fSCMActive then exit;
  if Split_SessionIsLocked(aSplitID) then exit;
  aHeatStatusID := Split_HeatStatusID(aSplitID);
  // Unassigned heat status accepted as 'Open'
  if not(aHeatStatusID > 1) or (DoExclude = false) then
  begin
    dsSplit.DataSet.DisableControls;
    // FINALLY DELETE SPLIT RECORD
    SQL := 'DELETE FROM dbo.Split WHERE Split.SplitID = :ID';
    rows := scmConnection.ExecSQL(SQL, [aSplitID]);
    if (rows = 1) then result := true;
    dsSplit.DataSet.EnableControls;
  end;
end;

function TSCM.Split_HeatStatusID(aSplitID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not fSCMActive then exit;
  if aSplitID > 0 then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
      'INNER JOIN Entrant ON [HeatIndividual].[HeatID] = Entrant.HeatID ' +
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
  if not fSCMActive then exit;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet].[dbo].[Session] ' +
    'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
    'INNER JOIN [HeatIndividual] ON [Event].[EventID] = [HeatIndividual].[EventID] '
    + 'INNER JOIN [Entrant] ON [HeatIndividual].[HeatID] = [Entrant].[HeatID] '
    + 'INNER JOIN [Split] ON [Entrnat].[EntrantID] = [Split].[EntrantID] ' +
    'WHERE [Split].[SplitID] = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aSplitID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
end;

function TSCM.StrikeLane: Boolean;
var
  aTeamID: integer;
begin
  if SCM.Event_IsINDV then result := Entrant_StrikeLane
  else
  begin
    aTeamID := dsTeam.DataSet.FieldByName('TeamID').AsInteger;
    result := Team_StrikeLane(aTeamID);
  end;
end;

function TSCM.SwapLanes(IDA, IDB, aEventTypeID: integer): Boolean;
begin
  result := false;
  if (IDA = IDB) then exit;
  if (IDA = 0) OR (IDB = 0) then exit;
  if aEventTypeID = 1 then
  begin
    qrySwapEntrants.Connection := scmConnection;
    qrySwapEntrants.ParamByName('ENTRANTIDA').AsInteger := IDA;
    qrySwapEntrants.ParamByName('ENTRANTIDB').AsInteger := IDB;
    qrySwapEntrants.Prepare;
    // does not return a cursor - hence execute (UPDATE).
    qrySwapEntrants.Execute();
  end
  else if aEventTypeID = 2 then
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
  IDA, IDB, aEventTypeID: integer;
  SQL: string;
begin
  result := false;
  if not fSCMActive then exit;
  aEventTypeID := Heat_EventTypeID(HeatIDA);
  { TODO -oBSA -cGeneral : Create swap lane function }
  if aEventTypeID = 1 then // INDV
      SQL := 'SELECT TOP 1 [EntrantID] FROM [SwimClubMeet].[dbo].[Entrant] ' +
      ' WHERE HeatID = :HEAT AND Lane = :LANE'
  else if aEventTypeID = 2 then
      SQL := 'SELECT TOP 1 [TeamID] FROM [SwimClubMeet].[dbo].[Team] ' +
      ' WHERE HeatID = :HEAT AND Lane = :LANE'
  else exit;
  IDA := scmConnection.ExecSQLScalar(SQL, [HeatIDA, LaneA]);
  IDB := scmConnection.ExecSQLScalar(SQL, [HeatIDB, LaneB]);
  SwapLanes(IDA, IDB, aEventTypeID);
  result := true;
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
      if (i >= 50) then result := false;
    end;
  end;
end;

procedure TSCM.SwimClub_Locate(SwimClubID: integer);
begin
  if not fSCMActive then exit;
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
    else result := i;
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
        result := dsSwimClub.DataSet.FieldByName('StartOfSwimSeason')
        .AsDateTime;
end;

function TSCM.SwimClub_StartOfSwimSeason(SwimClubID: integer): TDateTime;
var
  dt: TDateTime;
begin
  result := Date();
  if SwimClubID > 0 then
  begin
    if qrySwimClub.Active then qrySwimClub.Close;
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
        if WithinPastYears(result, dt, 1) then result := dt;
      end;
    end;
  end;
end;

procedure TSCM.TeamEntrant_DeleteALLExclude(aTeamID: integer;
  DoExclude: Boolean);
var
  qry: TFDQuery;
  aTeamEntrantID: integer;
begin
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := 'SELECT [TeamEntrant].[TeamEntrantID] ' +
    'FROM [SwimClubMeet].[dbo].[TeamEntrant] ' +
    'INNER JOIN [Team] ON [Team].[TeamID] = [TeamEntrantID].[TeamID] ' +
    'WHERE [TeamEntrant].[TeamID] = ' + IntToStr(aTeamID);
  qry.IndexFieldNames := 'TeamEntrantID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aTeamEntrantID := qry.FieldByName('TeamEntrantID').AsInteger;
      Entrant_DeleteExclude(aTeamEntrantID, DoExclude);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

function TSCM.TeamEntrant_DeleteExclude(aTeamEntrantID: integer;
  DoExclude: Boolean): Boolean;
var
  SQL: string;
  aHeatStatusID, rows: integer;
begin
  result := false;
  if not fSCMActive then exit;
  if TeamEntrant_SessionIsLocked(aTeamEntrantID) then exit;
  aHeatStatusID := TeamEntrant_HeatStatusID(aTeamEntrantID);
  if not(aHeatStatusID > 1) or (DoExclude = false) then
  begin
    // DELETE TEAM ENTRANT RECORD
    dsTeamEntrant.DataSet.DisableControls;
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[TeamEntrant] WHERE [TeamEntrantID] = :ID';
    rows := scmConnection.ExecSQL(SQL, [aTeamEntrantID]);
    if (rows = 1) then result := true;
    dsTeamEntrant.DataSet.EnableControls;
  end;
end;

function TSCM.TeamEntrant_HeatStatusID(aTeamEntrantID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not fSCMActive then exit;
  if aTeamEntrantID > 0 then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
      'INNER JOIN Team ON [HeatIndividual].[HeatID] = Team.HeatID ' +
      'INNER JOIN TeamEntrant ON [Team].[TeamID] = [TeamEntrant].[TeamID] ' +
      'WHERE [TeamEntrant].[TeamEntrantID] = :ID;';
    v := scmConnection.ExecSQLScalar(SQL, [aTeamEntrantID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;
end;

function TSCM.TeamEntrant_MoveDownLane(ADataSet: TDataSet): Boolean;
begin
  result := MoveDownLane(ADataSet);
end;

function TSCM.TeamEntrant_MoveUpLane(ADataSet: TDataSet): Boolean;
begin
  result := MoveUpLane(ADataSet);
end;

function TSCM.TeamEntrant_SessionIsLocked(aTeamEntrantID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not fSCMActive then exit;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet].[dbo].[Session] ' +
    'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
    'INNER JOIN [HeatIndividual] ON [Event].[EventID] = [HeatIndividual].[EventID] '
    + 'INNER JOIN [Team] ON [HeatIndividual].[HeatID] = [Team].[HeatID] ' +
    'INNER JOIN [TeamEntrant] ON [Team].[TeamID] = [Team].[TeamID] ' +
    'WHERE [TeamEntrant].[TeamEntrantID] = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aTeamEntrantID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
end;

procedure TSCM.TeamSplit_DeleteALLExclude(aTeamID: integer; DoExclude: Boolean);
var
  qry: TFDQuery;
  aTeamSplitID: integer;
begin
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := 'SELECT [TeamSplit].[TeamSplitID] ' +
    'FROM [SwimClubMeet].[dbo].[TeamSplit] ' + 'WHERE [Team].[TeamID] = ' +
    IntToStr(aTeamID);
  qry.IndexFieldNames := 'TeamEntrantID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aTeamSplitID := qry.FieldByName('TeamSplitID').AsInteger;
      TeamSplit_DeleteExclude(aTeamSplitID, DoExclude);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

function TSCM.TeamSplit_DeleteExclude(aSplitID: integer;
  DoExclude: Boolean = true): Boolean;
var
  SQL: string;
  aHeatStatusID, rows: integer;
begin
  result := false;
  if not fSCMActive then exit;
  if TeamSplit_SessionIsLocked(aSplitID) then exit;
  aHeatStatusID := TeamSplit_HeatStatusID(aSplitID);
  if not(aHeatStatusID > 1) or (DoExclude = false) then
  begin
    // DELETE TEAM ENTRANT RECORD
    dsTeamEntrant.DataSet.DisableControls;
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[TeamSplit] WHERE [TeamSplitID] = :ID';
    rows := scmConnection.ExecSQL(SQL, [aSplitID]);
    if (rows = 1) then result := true;
    dsTeamEntrant.DataSet.EnableControls;
  end;
end;

function TSCM.TeamSplit_HeatStatusID(aSplitID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not fSCMActive then exit;
  if aSplitID > 0 then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
      'INNER JOIN Team ON [HeatIndividual].[HeatID] = Team.HeatID ' +
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
  if not fSCMActive then exit;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet].[dbo].[Session] ' +
    'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
    'INNER JOIN [HeatIndividual] ON [Event].[EventID] = [HeatIndividual].[EventID] '
    + 'INNER JOIN [Team] ON [HeatIndividual].[HeatID] = [Team].[HeatID] ' +
    'INNER JOIN [TeamSplit] ON [Team].[TeamID] = [TeamSplit].[TeamID] ' +
    'WHERE [TeamSplit].[TeamSplitID] = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aTeamSplitID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
end;

function TSCM.Team_ClearLaneExclude(aTeamID: integer;
  DoExclude: Boolean = true): Boolean;
var
  aHeatStatusID: integer;
begin
  result := false;
  if not fSCMActive then exit;
  if Team_SessionIsLocked(aTeamID) then exit;
  if (aTeamID = 0) then exit;
  aHeatStatusID := Team_HeatStatusID(aTeamID);
  if not(aHeatStatusID > 1) or (DoExclude = false) then
  begin
    ClearLane(aTeamID, etTeam);
  end;
end;

procedure TSCM.Team_DeleteALLExclude(aHeatID: integer; DoExclude: Boolean);
var
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
        Team_DeleteExclude(aTeamID, false);
        // Also performs - Delete TeamSplit/TeamEntrant.
      end;
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;

procedure TSCM.Team_DeleteExcessLanes(aHeatID: integer);
var
  aTeamID, NumOfLanes, i: integer;
begin
  if not fSCMActive then exit;
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
      if (i > NumOfLanes) then break;
    end;
    if i > NumOfLanes then
    begin
      // Resynchronizes the dataset to make the next undeleted record active.
      // If the record deleted was the last record in the dataset, then the
      // previous record becomes the current record.
      while not Eof do
      begin
        aTeamID := dsTeam.DataSet.FieldByName('TeamID').AsInteger;
        Team_ClearLaneExclude(aTeamID, true); // nomination remains alive.
        Delete;
      end;
    end;
    EnableControls;
  end;
end;

function TSCM.Team_DeleteExclude(aTeamID: integer;
  DoExclude: Boolean = true): integer;
var
  SQL: string;
  HeatStatusID: integer;
begin
  result := 0;
  HeatStatusID := Team_HeatStatusID(aTeamID);
  if (HeatStatusID = 1) or (DoExclude = false) then
  begin
    // DELETE TEAM-ENTRANTS FROM RELAY
    TeamEntrant_DeleteALLExclude(aTeamID, DoExclude);
    { if 'closed or raced heats' or DoExclude state results
      in team entrants not being deleted then the team mustn't be removed. }
    if not Team_HasTeamEntrants(aTeamID) or DoExclude then
    begin
      // DELETE Split records for relay team.
      TeamSplit_DeleteALLExclude(aTeamID, DoExclude);
      // DELETE TEAM RECORD
      dsTeam.DataSet.DisableControls;
      SQL := 'DELETE FROM [SwimClubMeet].[dbo].[Team] WHERE [TeamID] = :ID';
      result := scmConnection.ExecSQL(SQL, [aTeamID]);
      dsTeam.DataSet.EnableControls;
    end;
  end;
end;

function TSCM.Team_EventID(aTeamID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not fSCMActive then exit;
  if (aTeamID = 0) then exit;
  SQL := 'SELECT [HeatIndivual].EventID FROM [SwimClubMeet].[dbo].[Team] ' +
    'INNER JOIN [HeatIndivual] ON [Team].HeatID = [HeatIndivual].HeatID ' +
    'WHERE TeamID = :ID;';
  v := scmConnection.ExecSQLScalar(SQL, [aTeamID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCM.Team_HasTeamEntrants(aTeamID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not fSCMActive then exit;
  SQL := 'SELECT COUNT(TeamEntrantID) FROM [SwimClubMeet].[dbo].[Team] ' +
    'INNER JOIN [TeamEntrant] ON [Team].TeamID = [TeamEntrant].TeamID ' +
    'WHERE TeamID = :ID;';
  v := scmConnection.ExecSQLScalar(SQL, [aTeamID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function TSCM.Team_HeatStatusID(aTeamID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not fSCMActive then exit;
  if aTeamID > 0 then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
      'INNER JOIN Team ON [HeatIndividual].[HeatID] = Team.HeatID ' +
      'WHERE [Team].[TeamID] = :ID;';
    v := scmConnection.ExecSQLScalar(SQL, [aTeamID]);
    if not VarIsEmpty(v) and not VarIsNull(v) and (v > 0) then result := v;
  end;
end;

function TSCM.Team_Locate(TeamID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not fSCMActive then exit;
  if (TeamID = 0) then exit;
  SearchOptions := [];
  if dsTeam.DataSet.Active then
      result := dsTeam.DataSet.Locate('TeamID', TeamID, SearchOptions);
end;

function TSCM.Team_NextAvailLaneNum(aHeatID, aSeedNumber: integer): integer;
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

function TSCM.Team_SessionIsLocked(aTeamID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not fSCMActive then exit;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet].[dbo].[Session] ' +
    'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
    'INNER JOIN [HeatIndividual] ON [Event].[EventID] = [HeatIndividual].[EventID] '
    + 'INNER JOIN [Team] ON [HeatIndividual].[HeatID] = [Team].[HeatID] ' +
    'WHERE [Team].[TeamID] = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aTeamID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
end;

function TSCM.Team_Sort(aHeatID: integer): Boolean;
var
  qry: TFDQuery;
  i, lane, NumOfLanes: integer;
  DoDelete: Boolean;
begin
  { TODO -oBSa -cGeneral : Check entrant sort is working. }
  result := false;
  if not fSCMActive then exit;
  i := 0;
  DoDelete := false;
  NumOfLanes := SwimClub_NumberOfLanes;
  if (NumOfLanes = 0) then exit;

  // STEP 1 :
  // ASSIGN LANES TO ENTRANTS ....
  // ------------------------------------------------------------------
  qrySortHeatTeam.Close;
  qrySortHeatTeam.ParamByName('HEATID').AsInteger := aHeatID;
  qrySortHeatTeam.Prepare;
  qrySortHeatTeam.Open;
  if (qrySortHeatTeam.Active) then
  begin
    qrySortHeatTeam.Last;
    // TRAP - TOO MANY ENTRANTS - LET USER DECIDE WHO TO REMOVE ....
    if (qrySortHeatTeam.RecordCount > NumOfLanes) then
    begin
      qrySortHeatTeam.Close;
      MessageDlg('The number of entrants exceeds the number of lanes.' +
        slinebreak +
        'Clear entrants (Empty Lanes) and then re-perform the "Sort"', mtError,
        [mbOK], 0);
      dsTeam.DataSet.EnableControls;
      exit;
    end;
    qrySortHeatTeam.First;
    i := 0; // NOTE: ScatterLanes is based 0
    while not qrySortHeatTeam.Eof do
    begin
      lane := SCMUtility.ScatterLanes(i, NumOfLanes);
      qrySortHeatTeam.Edit;
      qrySortHeatTeam.FieldByName('Lane').AsInteger := lane;
      qrySortHeatTeam.Post;
      i := i + 1;
      qrySortHeatTeam.Next;
    end;
  end;
  qrySortHeatTeam.Close;

  // STEP 2 :
  // ASSIGN REMAINING LANES NUMBERS TO EMPTY LANES ....
  // ------------------------------------------------------------------
  qrySortHeatTeam_EmptyLanes.Close;
  qrySortHeatTeam_EmptyLanes.ParamByName('HEATID').AsInteger := aHeatID;
  qrySortHeatTeam_EmptyLanes.Prepare;
  qrySortHeatTeam_EmptyLanes.Open;
  if (qrySortHeatTeam_EmptyLanes.Active) then
  begin
    while not qrySortHeatTeam_EmptyLanes.Eof do
    begin
      if (i < NumOfLanes) then
      begin
        lane := SCMUtility.ScatterLanes(i, NumOfLanes);
        qrySortHeatTeam_EmptyLanes.Edit;
        qrySortHeatTeam_EmptyLanes.FieldByName('Lane').AsInteger := lane;
        qrySortHeatTeam_EmptyLanes.Post;
      end
      else
      begin
        // TOO-MANY EMPTY LANES
        qrySortHeatTeam_EmptyLanes.Edit;
        qrySortHeatTeam_EmptyLanes.FieldByName('Lane').Clear;
        qrySortHeatTeam_EmptyLanes.Post;
        DoDelete := true;
      end;
      qrySortHeatTeam_EmptyLanes.Next;
      i := i + 1;
    end;
  end;
  qrySortHeatTeam_EmptyLanes.Close;

  // STEP 3 :
  // IF NUMOFLANES IS EXCEEDED - REMOVE THEM....
  // ------------------------------------------------------------------
  qrySortHeatTeam_EmptyLanes.Close;
  if (DoDelete) then
  begin
    qry := TFDQuery.Create(self);
    qry.Connection := scmConnection;
    qry.SQL.Text := 'SELECT TeamID FROM Team WHERE [Lane] IS NULL';
    qry.IndexFieldNames := 'TeamID';
    qry.Open;
    if qry.Active then
    begin
      while not qry.Eof do
      begin
        // .... do not exclude closed or raced.
        Team_DeleteExclude(qry.FieldByName('TeamID').AsInteger, false);
        qry.Next;
      end;
    end;
    qry.Close;
    qry.Free;
  end;

  result := true;
end;

function TSCM.Team_StrikeLane(aTeamID: integer): Boolean;
begin
  result := false;
  dsTeam.DataSet.CheckBrowseMode; // post any changes
  Team_StrikeNominees(aTeamID);
  // Null specific dbo.Team fields + remove entrants and team split times.
  // Handles TeamID equals zero and TeamNameID is empty ...
  Team_ClearLaneExclude(aTeamID);
end;

function TSCM.Team_StrikeNominees(aTeamID: integer): Boolean;
begin
  result := false;
  {TODO -oBSA -cGeneral : STRIKE NOMINEES TEAM/ENTRANT}
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

procedure TSCM.WndProc(var wndMsg: TMessage);
begin
  case wndMsg.Msg of
    SCM_RENUMBERHEATS:
      begin
        // go renumber the heats table....
        Heat_Renumber(false);
      end;
  end;
end;

end.
