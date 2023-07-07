unit dmSCM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, dmSCMNom;

type
  TSCM = class(TDataModule)
    scmConnection: TFDConnection;
    dsSwimClub: TDataSource;
    dsSession: TDataSource;
    dsEvent: TDataSource;
    tblStroke: TFDTable;
    tblGender: TFDTable;
    tblDistance: TFDTable;
    luStroke: TDataSource;
    luGender: TDataSource;
    luDistance: TDataSource;
    tblEventType: TFDTable;
    luEventType: TDataSource;
    dsHeat: TDataSource;
    tblHeatType: TFDTable;
    luHeatType: TDataSource;
    dsMember: TDataSource;
    tblEventStatus: TFDTable;
    luEventStatus: TDataSource;
    qryNominateEvent: TFDQuery;
    dsNomateEvent: TDataSource;
    luHeatStatus: TDataSource;
    luSessionStatus: TDataSource;
    tblSessionStatus: TFDTable;
    tblHeatStatus: TFDTable;
    qryEntrant: TFDQuery;
    qryEntrantHeatID: TIntegerField;
    qryEntrantEntrantID: TFDAutoIncField;
    qryEntrantMemberID: TIntegerField;
    qryEntrantLane: TIntegerField;
    qryEntrantFullName: TWideStringField;
    qryEntrantTIME: TTimeField;
    qryEntrantTimeToBeat: TTimeField;
    qryEntrantPersonalBest: TTimeField;
    qryEntrantIsScratched: TBooleanField;
    qryEntrantIsDisqualified: TBooleanField;
    dsEntrant: TDataSource;
    qrySession: TFDQuery;
    qrySessionSessionID: TFDAutoIncField;
    qrySessionSwimClubID: TIntegerField;
    qrySessionSessionStatusID: TIntegerField;
    qrySessionSessionStart: TSQLTimeStampField;
    qrySessionStatus: TWideStringField;
    qrySessionCaption: TWideStringField;
    qrySessionClosedDT: TSQLTimeStampField;
    qryEntrantCount: TFDQuery;
    qryHeatCount: TFDQuery;
    qryFName: TFDQuery;
    qrySCMSystem: TFDQuery;
    luFName: TDataSource;
    qryEvent: TFDQuery;
    qryEventEventID: TFDAutoIncField;
    qryEventSessionID: TIntegerField;
    qryEventEventTypeID: TIntegerField;
    qryEventStrokeID: TIntegerField;
    qryEventDistanceID: TIntegerField;
    qryEventEventNum: TIntegerField;
    qryEventluDistance: TStringField;
    qryEventluStroke: TStringField;
    qryEventCaption: TWideStringField;
    qryEventEventStatusID: TIntegerField;
    qryEventluEventStatus: TStringField;
    qryEventNomineeCount: TIntegerField;
    qryEventEntrantCount: TIntegerField;
    qryEventluEventType: TStringField;
    qryEventClosedDT: TSQLTimeStampField;
    qryEventEventStr: TWideStringField;
    qryFNameEllipse: TFDQuery;
    dsFNameEllipse: TDataSource;
    qryHeatLaneCount: TFDQuery;
    qryMember: TFDQuery;
    qrySortHeat: TFDQuery;
    qrySortHeat_EmptyLanes: TFDQuery;
    qryContactNum: TFDQuery;
    dsContactNum: TDataSource;
    qryNominee: TFDQuery;
    dsNominee: TDataSource;
    qryNomineeCount: TFDQuery;
    qryIsSafeToDelEvent: TFDQuery;
    qryIsSafeToDelSession: TFDQuery;
    qrySessionNomineeCount: TFDQuery;
    qrySessionEntrantCount: TFDQuery;
    qryCountHeatsNotClosed: TFDQuery;
    qryCountEventsNotClosed: TFDQuery;
    dsIsQualified: TDataSource;
    luHouse: TDataSource;
    tblHouse: TFDTable;
    qryNominateMembers: TFDQuery;
    qryNominateMembersMemberID: TFDAutoIncField;
    qryNominateMembersFName: TWideStringField;
    qryNominateMembersGenderID: TIntegerField;
    dsNominateMembers: TDataSource;
    qryIsQualified: TFDQuery;
    qryHeat: TFDQuery;
    qryHeatHeatID: TFDAutoIncField;
    qryHeatEventID: TIntegerField;
    qryHeatHeatTypeID: TIntegerField;
    qryHeatHeatStatusID: TIntegerField;
    qryHeatHeatNum: TIntegerField;
    qryHeatcStatus: TWideStringField;
    qryHeatClosedDT: TSQLTimeStampField;
    qryIsQualifiedALT: TFDQuery;
    qryTestForNominees: TFDQuery;
    qryRenumberHeats: TFDQuery;
    qrySwimClub: TFDQuery;
    qrySwapEntrants: TFDQuery;
    qryGetNextHeat: TFDQuery;
    qryGetPrevHeat: TFDQuery;
    qryNominateMembersFullName: TWideStringField;
    qryNominateControlList: TFDQuery;
    dsNominateControlList: TDataSource;
    qryNominateControlListEventID: TFDAutoIncField;
    qryNominateControlListEventNum: TIntegerField;
    qryNominateControlListSessionID: TIntegerField;
    qryNominateControlListEventTypeID: TIntegerField;
    qryNominateControlListStrokeID: TIntegerField;
    qryNominateControlListDistanceID: TIntegerField;
    qryNominateControlListEventStatusID: TIntegerField;
    qryNominateControlListCaption: TWideStringField;
    qryNominateControlListIsNominated: TBooleanField;
    qryNominateControlListIsQualified: TBooleanField;
    qryNominateControlListDistStrokeStr: TWideStringField;
    qryEventMeters: TIntegerField;
    qryEventScheduleDT: TTimeField;
    qryEntrantDisqualifyCodeID: TIntegerField;
    tblDisqualifyCode: TFDTable;
    luDisqualifyCode: TDataSource;
    qryEntrantDCode: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrySessionAfterScroll(DataSet: TDataSet);
    procedure qrySessionBeforePost(DataSet: TDataSet);
    procedure qryEventAfterPost(DataSet: TDataSet);
    procedure qryEventNewRecord(DataSet: TDataSet);
    procedure qryEventAfterScroll(DataSet: TDataSet);
    procedure qryHeatAfterScroll(DataSet: TDataSet);
    procedure qryHeatNewRecord(DataSet: TDataSet);
    procedure qryEntrantTIMEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryEntrantTIMESetText(Sender: TField; const Text: string);
    procedure qrySessionSessionStartGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qrySessionSessionStartSetText(Sender: TField; const Text: string);
    procedure qryHeatAfterPost(DataSet: TDataSet);
    procedure qryEntrantBeforeInsert(DataSet: TDataSet);
    procedure qryEventAfterDelete(DataSet: TDataSet);
    procedure qryHeatAfterDelete(DataSet: TDataSet);
    procedure qrySessionNewRecord(DataSet: TDataSet);
    procedure qrySessionAfterPost(DataSet: TDataSet);
    procedure qrySessionAfterDelete(DataSet: TDataSet);
    procedure scmConnectionAfterDisconnect(Sender: TObject);
    procedure qryEventBeforePost(DataSet: TDataSet);
    procedure qryEventBeforeEdit(DataSet: TDataSet);
    procedure qryEntrantAfterScroll(DataSet: TDataSet);
    procedure qryEventEventStatusIDGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryMemberQuickPickAfterScroll(DataSet: TDataSet);
    procedure qryNominateMembersAfterScroll(DataSet: TDataSet);
    procedure qryEventScheduleDTGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryEventScheduleDTSetText(Sender: TField; const Text: string);

  private
    { Private declarations }
    fLastDistanceID: integer;
    fLastStrokeID: integer;
    fSCMActive: Boolean;
    prefGenerateEventDescription: Boolean;
    prefGenerateEventDescStr: string;

    procedure Entrant_ClearLane(aEntrantID: integer);
    procedure Entrant_CreateEmptyLane(aHeatID, aLane: integer);
    procedure ReadPreferences(IniFileName: string);

  public
    { Public declarations }
    procedure ActivateTable();
    procedure DeActivateTable();

    // UTILITY TOOLS
    function IsFirstRecord(ADataSet: TDataSet): Boolean;
    function IsLastRecord(ADataSet: TDataSet): Boolean;

    // DELETE
    // SAFEMODE - delete only if status of heat is OPEN.
    function DeleteAllHeatIndividuals(ADataSet: TDataSet;
      SafeMode: Boolean = true): Boolean;
    function DeleteAllEntrants(ADataSet: TDataSet): Boolean;
    function DeleteAllEvents(ADataSet: TDataSet;
      SafeMode: Boolean = true): Boolean;

    // SCMSystem
    function GetVerInfoMajor(): integer;

    // SWIMCLUB
    procedure SwimClub_Locate(SwimClubID: integer);
    function GetNumberOfLanes(): integer;
    function GetStartOfSwimSeason(): TDateTime; overload;
    function GetStartOfSwimSeason(SwimClubID: integer): TDateTime; overload;
    function GetSwimClubID(): integer;
    function GetClubName(): string;
    function GetClubNickName: string;
    function IsShortCourse(): Boolean; // current club

    // SESSION
    function Session_Locate(SessionID: integer): Boolean;
    function GetSessionStart(): TDateTime; overload;
    function GetSessionStart(SessionID: integer): TDateTime; overload;
    function GetSessionID(): integer;
    function GetSessionCount(SwimClubID: integer;
      SDate, EDate: TDateTime): integer;
    function IsLockedSession: Boolean;

    // current session
    function IsSafeToDeleteSession(aSessionID: integer): Boolean;
    function IsAllEventsClosed(aSessionID: integer): Boolean;
    function Session_GetEntrantCount(aSessionID: integer): integer;
    function Session_GetNomineeCount(aSessionID: integer): integer;
    procedure Session_HideLocked(IsChecked: Boolean);
    procedure Session_ToggleLockState();

    // EVENTS
    function Event_Locate(aEventID: integer): Boolean; overload;
    function GetEventID(): integer;
    function IsSafeToDeleteEvent(aEventID: integer): Boolean;
    function IsAllHeatsClosed(aEventID: integer): Boolean;
    function HasClosedHeats(): Boolean; // current event
    function HasRacedHeats(): Boolean; // current event
    function Event_Locate(aDistanceID, aStrokeID: integer): Boolean; overload;
    function Event_GetEntrantCount(aEventID: integer): integer;
    function Event_GetHeatCount(aEventID: integer): integer;
    function Event_GetNomineeCount(aEventID: integer): integer;
    procedure Event_Renumber(DoLocate: Boolean = true);
    procedure Event_FNameEllipse();
    procedure Event_Delete(); // current Event

    // HEATS
    function Heat_Locate(aHeatID: integer): Boolean;
    function IsClosedHeat(): Boolean; overload; // current heat
    function IsClosedHeat(aHeatID: integer): Boolean; overload;
    function IsLockedHeat(): Boolean; // uses diff logic IsClosedHeat. Pref
    function IsRacedHeat(): Boolean;
    function GetHeatID(): integer;
    function GetNextHeatID(aHeatID: integer): integer; // uses HeatNum
    function GetPrevHeatID(aHeatID: integer): integer; // uses HeatNum
    procedure Heat_Renumber(DoLocate: Boolean = true);
    procedure Heat_UpdateStatusBar();
    procedure Heat_NewRecord();
    procedure Heat_Delete(); // current heat
    procedure Heat_DeleteALL(aEventID: integer); // for current event
    procedure Heat_ToggleStatus(); // current heat

    // ENTRANT
    function Entrant_Locate(EntrantID: integer): Boolean;
    function Entrant_CountLanes(aHeatID: integer): integer;
    function Entrant_Sort(aHeatID: integer): Boolean;
    function SwapLanes(HeatIDA, LaneA, HeatIDB, LaneB: integer)
      : Boolean; overload;
    function SwapLanes(EntrantIDA, EntrantIDB: integer): Boolean; overload;
    function SwapMoveUp(EntrantDS: TDataSet): Boolean;
    function SwapMoveDown(EntrantDS: TDataSet): Boolean;
    function SwapMoveUpHeat(EntrantDS: TDataSet): Boolean;
    function SwapMoveDownHeat(EntrantDS: TDataSet): Boolean;
    function Entrant_Strike(): Boolean;
    function Entrant_EmptyLane(): Boolean;
    function Entrant_NextAvailLaneNum(aHeatID, aSeedNumber: integer): integer;
    procedure Entrant_RenumberLanes(aHeatID: integer);
    procedure Entrant_PadWithEmptyLanes(aHeatID: integer);
    procedure Entrant_InsertEmptyLanes(aHeatID: integer);
    procedure Entrant_DeleteExcessLanes(aHeatID: integer);

    // NOMINATE
    function Nominate_Locate(MemberID: integer): Boolean;
    function Nominate_LocateEventNum(ADataSet: TDataSet;
      EventNum: integer): Boolean;
    function HasNominees(EventID: integer): Boolean;
    function HasNominee(EventID, MemberID: integer): Boolean;
    function Nominate_SortMembers(SortState: Boolean): Boolean;
    function Nominate_UpdateControlList(SessionID, MemberID: integer): Boolean;

    // MEMBER
    function Member_IsQualified(aMemberID, aGenderID, aQualifyDistID,
      aStrokeID: integer; IsShortCourse: Boolean): Boolean;

    // UTILITY
    // DEPRECIATED: 2023.02.21 - NOW SHARED CODE FOUND IN SCMUtility
    // function ScatterLanes(index, NumOfPoolLanes: integer): integer;

    // CONNECTION
    // procedure SimpleLoadSettingString(ASection, AName: string; var AValue: string);
    // procedure SimpleMakeTemporyFDConnection(Server, User, Password: string;
    // OsAuthent: boolean);
    // procedure SimpleSaveSettingString(ASection, AName, AValue: string);

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
      MessageDlg('During activation of the SCM DataBase' + slinebreak +
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

function TSCM.DeleteAllEntrants(ADataSet: TDataSet): Boolean;
{
  -- =============================================
  -- Author:		Ben Ambrose
  -- Create date: 14/03/2022 - Updated: 07/12/2022
  -- Description:
  Delete ALL ENTRANTS (and SPLIT DATA)
  Doesn't effect Nominations.
  -- =============================================
}
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

function TSCM.DeleteAllEvents(ADataSet: TDataSet; SafeMode: Boolean): Boolean;
{
  -- =============================================
  -- Author:		Ben Ambrose
  -- Create date: 2/04/2022 - Updated: 07/12/2022
  -- Description:
  Delete ALL Events (for the CURRENT SELECTED Session.)
  SafeMode - Only OPEN events can be deleted.  (Default = true)
  -- =============================================
}
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
      tbl.FieldByName('RaceTime').Clear;
      tbl.FieldByName('TimeToBeat').Clear;
      tbl.FieldByName('PersonalBest').Clear;
      tbl.FieldByName('IsDisqualified').AsBoolean := false;
      tbl.FieldByName('IsScratched').AsBoolean := false;
      tbl.Post;
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

procedure TSCM.Entrant_DeleteExcessLanes(aHeatID: integer);
var
  NumOfLanes, i: integer;
begin
  if not fSCMActive then
    exit;
  // create empty lanes
  NumOfLanes := GetNumberOfLanes;
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

procedure TSCM.Entrant_InsertEmptyLanes(aHeatID: integer);
var
  i, LanesToBuild: integer;
begin
  // CALLED BY : qryHeat AfterInsert ...
  // New heats, do not have any lanes assigned to them.
  // BUILD POOL LANES in entrant table.
  if not fSCMActive then
    exit;
  LanesToBuild := GetNumberOfLanes;
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
  NumOfLanes := GetNumberOfLanes;
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
  NumOfLanes := GetNumberOfLanes;
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

procedure TSCM.Event_Delete();
var
  SQL: string;
begin
  if not fSCMActive then
    exit;
  // --------------------------------------------------------
  // D E L E T E   C U R R E N T  E V E N T .
  // --------------------------------------------------------
  dsEvent.DataSet.DisableControls;
  dsHeat.DataSet.DisableControls;
  dsEntrant.DataSet.DisableControls;
  dsNominee.DataSet.DisableControls;

  // DELETE ENTRANTS
  with dsHeat.DataSet do
  begin
    if not IsEmpty then
    begin
      First;
      while not Eof do
      begin
        SQL := 'DELETE FROM dbo.Entrant WHERE Entrant.HeatID = ' +
          IntToStr(dsHeat.DataSet.FieldByName('HeatID').AsInteger);
        scmConnection.ExecSQL(SQL);
        Next;
      end;
    end;
  end;

  // DELETE HEATS
  SQL := 'DELETE FROM dbo.HeatIndividual WHERE HeatIndividual.EventID = ' +
    IntToStr(dsEvent.DataSet.FieldByName('EventID').AsInteger);
  scmConnection.ExecSQL(SQL);

  // DELETE NOMINATIONS
  SQL := 'DELETE FROM dbo.Nominee WHERE Nominee.EventID = ' +
    IntToStr(dsEvent.DataSet.FieldByName('EventID').AsInteger);
  scmConnection.ExecSQL(SQL);

  // DELETE EVENT
  dsEvent.DataSet.Delete;

  dsNominee.DataSet.EnableControls;
  dsEntrant.DataSet.EnableControls;
  dsHeat.DataSet.EnableControls;
  dsEvent.DataSet.EnableControls;

end;

procedure TSCM.Event_FNameEllipse;
var
  ds: TFDQuery;
begin
  ds := (dsFNameEllipse.DataSet as TFDQuery);
  // re-assign parameters ...
  // TODO: reassigning params without close or prepare?
  ds.ParamByName('SESSIONID').AsInteger := GetSessionID();
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

function TSCM.IsAllEventsClosed(aSessionID: integer): Boolean;
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
  sl.Add('WHERE [SessionID] = ' + IntToStr(GetSessionID()));
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

function TSCM.GetClubName: string;
begin
  result := '';
  if dsSwimClub.DataSet.Active then
    if not dsSwimClub.DataSet.IsEmpty then
      result := dsSwimClub.DataSet.FieldByName('Caption').AsString;
end;

function TSCM.GetClubNickName: string;
begin
  result := '';
  if dsSwimClub.DataSet.Active then
    if not dsSwimClub.DataSet.IsEmpty then
      result := dsSwimClub.DataSet.FieldByName('NickName').AsString;
end;

function TSCM.GetEventID: integer;
begin
  result := 0;
  if fSCMActive and dsEvent.DataSet.Active then
    if not dsEvent.DataSet.IsEmpty then
      result := dsEvent.DataSet.FieldByName('EventID').AsInteger;
end;

function TSCM.GetHeatID: integer;
begin
  result := 0;
  if fSCMActive and dsHeat.DataSet.Active then
    if not dsHeat.DataSet.IsEmpty then
      result := dsHeat.DataSet.FieldByName('HeatID').AsInteger;
end;

function TSCM.GetNextHeatID(aHeatID: integer): integer;
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

function TSCM.GetNumberOfLanes: integer;
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

function TSCM.GetPrevHeatID(aHeatID: integer): integer;
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

function TSCM.GetSessionCount(SwimClubID: integer;
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

function TSCM.GetSessionID: integer;
begin
  result := 0;
  if fSCMActive and dsSession.DataSet.Active then
    if not dsSession.DataSet.IsEmpty then
      result := dsSession.DataSet.FieldByName('SessionID').AsInteger;
end;

function TSCM.GetSessionStart: TDateTime;
begin
  result := 0;
  if fSCMActive and dsSession.DataSet.Active then
    if not dsSession.DataSet.IsEmpty then
      result := dsSession.DataSet.FieldByName('SessionStart').AsDateTime;
end;

function TSCM.GetSessionStart(SessionID: integer): TDateTime;
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

function TSCM.GetStartOfSwimSeason(SwimClubID: integer): TDateTime;
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

function TSCM.GetStartOfSwimSeason: TDateTime;
begin
  result := 0;
  if fSCMActive and dsSwimClub.DataSet.Active then
    if not dsSwimClub.DataSet.IsEmpty then
      result := dsSwimClub.DataSet.FieldByName('StartOfSwimSeason').AsDateTime;
end;

function TSCM.GetSwimClubID: integer;
begin
  result := 0;
  if fSCMActive and dsSwimClub.DataSet.Active then
    if not dsSwimClub.DataSet.IsEmpty then
      result := dsSwimClub.DataSet.FieldByName('SwimClubID').AsInteger;
end;

function TSCM.GetVerInfoMajor: integer;
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

function TSCM.HasClosedHeats(): Boolean;
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

function TSCM.HasRacedHeats(): Boolean;
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

procedure TSCM.Heat_Delete;
var
  SQL: string;
begin
  if not fSCMActive then
    exit;
  dsEntrant.DataSet.DisableControls();
  dsHeat.DataSet.DisableControls();
  SQL := 'DELETE FROM dbo.Entrant WHERE Entrant.HeatID = ' +
    IntToStr(dsHeat.DataSet.FieldByName('HeatID').AsInteger);
  scmConnection.ExecSQL(SQL);
  dsHeat.DataSet.Delete();
  Heat_Renumber();
  dsHeat.DataSet.EnableControls();
  dsEntrant.DataSet.EnableControls();
end;

procedure TSCM.Heat_DeleteALL(aEventID: integer);
var
  SQL: string;
  id: integer;
  qry: TFDQuery;
begin
  // 11.10.2020
  if not fSCMActive then
    exit;
  dsEntrant.DataSet.DisableControls;
  dsHeat.DataSet.DisableControls;
  dsEvent.DataSet.DisableControls;

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
      id := qry.FieldByName('HeatID').AsInteger;
      // only opened heats are deleted
      if (qry.FieldByName('HeatStatusID').AsInteger < 2) then
      begin
        // delete entrant data
        SQL := 'DELETE FROM dbo.Entrant WHERE Entrant.HeatID = ' + IntToStr(id);
        scmConnection.ExecSQL(SQL);
        qry.Delete; // after delete moves to next record
      end
      else
        qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;

  // tidy up.
  Heat_Renumber();
  // Display
  dsHeat.DataSet.EnableControls();
  dsEntrant.DataSet.EnableControls();
  dsEvent.DataSet.EnableControls;
end;

function TSCM.IsAllHeatsClosed(aEventID: integer): Boolean;
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
  s := s + 'WHERE EventID = :EVENTID ORDER BY [HeatNum]';
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

function TSCM.IsShortCourse: Boolean;
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

function TSCM.IsClosedHeat(aHeatID: integer): Boolean;
var
  i: integer;
begin
  result := false;
  if not scmConnection.Connected then
    exit;
  i := scmConnection.ExecSQLScalar
    ('SELECT [HeatStatusID] FROM [SwimClubMeet].[dbo].[HeatIndividual] WHERE HeatID = '
    + IntToStr(aHeatID));
  if (i = 3) then
    result := true;
end;

function TSCM.IsClosedHeat: Boolean;
var
  HeatStatusID: integer;
begin
  result := false;
  if not scmConnection.Connected then
    exit;
  if not dsHeat.DataSet.Active then
    exit;
  if dsHeat.DataSet.IsEmpty then
    exit;
  HeatStatusID := dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger;
  if (HeatStatusID = 3) then
    result := true;
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

function TSCM.IsLockedHeat: Boolean;
var
  HeatStatusID: integer;
begin
  // Uses different logic to IsClosedHeat.
  // By default, heat is assumed to be LOCKED.
  // HEAT STATUS NOT 3
  // This routine asserts the state of heat dataset (connection, active and
  // not isempty) and if all checks pass, returns the record status.
  result := true;
  if not scmConnection.Connected then
    exit;
  if not dsHeat.DataSet.Active then
    exit;
  if dsHeat.DataSet.IsEmpty then
    exit;
  HeatStatusID := dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger;
  if (HeatStatusID <> 3) then
    result := false;
end;

function TSCM.IsLockedSession: Boolean;
begin
  result := false;
  if dsSession.DataSet.Active then
    if not dsSession.DataSet.IsEmpty then
      if (dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 2) then
        result := true;
end;

function TSCM.IsRacedHeat: Boolean;
var
  HeatStatusID: integer;
begin
  result := false;
  if not scmConnection.Connected then
    exit;
  if not dsHeat.DataSet.Active then
    exit;
  if dsHeat.DataSet.IsEmpty then
    exit;
  HeatStatusID := dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger;
  if (HeatStatusID = 2) then
    result := true;
end;

function TSCM.IsSafeToDeleteEvent(aEventID: integer): Boolean;
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

function TSCM.IsSafeToDeleteSession(aSessionID: integer): Boolean;
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
    ParamByName('SESSIONSTART').AsDateTime := GetSessionStart;
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
  DataSet.FieldByName('EventTypeID').AsInteger := 1;
  DataSet.Post;

  if Assigned(fld) then
    fld.ReadOnly := true;
end;

procedure TSCM.qryEventScheduleDTGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := FormatDateTime('hh:nn', Sender.AsDateTime);
end;

procedure TSCM.qryHeatAfterDelete(DataSet: TDataSet);
begin
  Heat_Renumber();
end;

procedure TSCM.qryHeatAfterPost(DataSet: TDataSet);
var
  HeatID, EntrantID, NumOfLanes, i: integer;
begin
  // AFTER every post to heats ...
  // THIS ROUTINE ASSERTS CORRECT NUMBER OF LANES
  HeatID := DataSet.FieldByName('HeatID').AsInteger;
  NumOfLanes := GetNumberOfLanes;

  if (HeatID > 0) then
  begin
    i := Entrant_CountLanes(HeatID); // current number of pool lanes
    if (i = 0) then
    begin
      // new heats don't have lanes.
      Entrant_InsertEmptyLanes(HeatID);
      SCM.dsEntrant.DataSet.Refresh; // required
    end
    else
    begin
      EntrantID := dsEntrant.DataSet.FieldByName('EntrantID').AsInteger;
      if (i < NumOfLanes) then
        Entrant_PadWithEmptyLanes(HeatID)
      else if (i > NumOfLanes) then
        Entrant_DeleteExcessLanes(HeatID);
      SCM.dsEntrant.DataSet.Refresh; // required
      SCM.Entrant_Locate(EntrantID);
    end;
  end;

end;

procedure TSCM.qryHeatAfterScroll(DataSet: TDataSet);
begin
  { TODO -oBSA -cGeneral : DEFAULTS should have been defined on new record! }
  // if (DataSet.FieldByName('HeatTypeID').IsNull) then
  // DataSet.FieldByName('HeatTypeID').AsInteger := 1;
  // if (DataSet.FieldByName('HeatStatusID').IsNull) then
  // DataSet.FieldByName('HeatStatusID').AsInteger := 1;
end;

procedure TSCM.qryHeatNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('HeatStatusID').AsInteger := 1; // Open
  DataSet.FieldByName('HeatTypeID').AsInteger := 1; // Individual (not Team)
  DataSet.FieldByName('HeatNum').AsInteger := DataSet.RecordCount + 1;
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

{
  procedure TSCM.SimpleLoadSettingString(ASection, AName: string; var AValue: string);
  var
  ini: TIniFile;
  begin
  if USEDEFAULTINIFILE then
  ini := TIniFile.Create(SCMUtility.GetSCM_SharedIniFile)
  else
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim + CUSTOMINIFILE);
  try
  AValue := ini.ReadString(ASection, Aname, '');
  finally
  ini.free;
  end;
  end;

  procedure TSCM.SimpleMakeTemporyFDConnection(Server, User, Password: string;
  OsAuthent: boolean);
  var
  AValue, ASection, AName: string;
  begin
  if (scmConnection.Connected) then
  begin
  scmConnection.Close();
  end;

  scmConnection.Params.Add('Server=' + Server);
  scmConnection.Params.Add('DriverID=MSSQL');
  scmConnection.Params.Add('Database=SwimClubMeet');
  scmConnection.Params.Add('User_name=' + User);
  scmConnection.Params.Add('Password=' + Password);
  if (OsAuthent) then
  AValue := 'Yes'
  else
  AValue := 'No';
  scmConnection.Params.Add('OSAuthent=' + AValue);
  scmConnection.Params.Add('Mars=yes');
  scmConnection.Params.Add('MetaDefSchema=dbo');
  scmConnection.Params.Add('ExtendedMetadata=False');
  scmConnection.Params.Add('ApplicationName=scmTimeKeeper');
  scmConnection.Connected := true;

  // ON SUCCESS - Save connection details.
  if (scmConnection.Connected) then
  begin
  ASection := 'MSSQL_SwimClubMeet';
  AName := 'Server';
  SimpleSaveSettingString(ASection, AName, Server);
  AName := 'User';
  SimpleSaveSettingString(ASection, AName, User);
  AName := 'Password';
  SimpleSaveSettingString(ASection, AName, Password);
  AName := 'OSAuthent';
  SimpleSaveSettingString(ASection, AName, AValue);
  end
  end;

  procedure TSCM.SimpleSaveSettingString(ASection, AName, AValue: string);
  var
  ini: TIniFile;
  begin
  // C:\Users\<#USERNAME#>\AppData\Roaming\Artanemus\SCM\
  if USEDEFAULTINIFILE then
  ini := TIniFile.Create(SCMUtility.GetSCM_SharedIniFile)
  else
  ini := TIniFile.Create(SCMUtility.GetSCMAppDataDir + CUSTOMINIFILE);
  try
  ini.WriteString(ASection, AName, AValue);
  finally
  ini.free;
  end;
  end;

}

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
    HeatIDB := GetNextHeatID(HeatIDA);
    LaneB := 1;
    if (HeatIDB > 0) and not IsClosedHeat(HeatIDB) then
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
    HeatIDB := GetPrevHeatID(HeatIDA);
    LaneB := GetNumberOfLanes;
    if (HeatIDB > 0) and not IsClosedHeat(HeatIDB) then
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

function TSCM.HasNominee(EventID, MemberID: integer): Boolean;
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

function TSCM.HasNominees(EventID: integer): Boolean;
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

procedure TSCM.qryEventScheduleDTSetText(Sender: TField; const Text: string);
begin
  if Pos(' ', Text) > 0 then
    Sender.AsDateTime := StrToTime(ReplaceText(Text,' ', '0' ))
  else
    Sender.AsDateTime := StrToTime(Text);
end;

end.
