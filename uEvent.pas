unit uEvent;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, System.VarUtils,
  System.StrUtils,
  FireDAC.Comp.Client,
  vcl.Dialogs, Data.DB,
	dmCORE, dmSCM, SCMdefines;

function AllHeatsAreClosed: Boolean;
function Assert(): boolean;
function CalcEntrantCount: integer;
function CalcNomineeCount: integer;
function EntrantCount: integer;
function NomineeCount: integer;
function HeatCount: integer;
function DeleteEvent(DoExclude: Boolean = true): boolean;
function DeleteHeats(DoExclude: Boolean = true): boolean;
function EventType: SCMDefines.scmEventType;
function GetEventID: integer; // Assert - make SAFE.
function HasClosedHeats: Boolean;
function HasClosedOrRacedHeats: Boolean;
function HasNominee(MemberID: integer): Boolean;
function HasNominees: Boolean;
function HasRacedHeats: Boolean;
function LastEventNum: integer;
function Locate(aDistanceID, aStrokeID: integer): Boolean; overload;
function Locate(aEventID: integer): Boolean; overload;
function PK(): integer; // NO CHECKS. RTNS: Primary key.
function RenumberHeats(DoLocate: Boolean = true): integer;

procedure SetEventStatusID(aEventStatusID: integer);
procedure SetEntrantCount();
procedure SetNomineeCount();
procedure FNameEllipse(); // todo: move out of uEvent to frame.
procedure NewEvent();


type
  T_Event = class
  public
    constructor Create;
    destructor Destroy;
  end;

var
  scmEvent: T_Event;

implementation

uses
	uSession, uHeat, uLane;

constructor T_Event.Create;
begin
  inherited;
  if not Assigned(SCM) then
    raise Exception.Create('Data module SCM not assigned.');
  if not SCM.IsActive then
    raise Exception.Create('Data module SCM tables are offline.');
  if not Assigned(CORE) then
    raise Exception.Create('Core data module not assigned.');
  if not CORE.IsActive then
    raise Exception.Create('Core data module tables are offline.');
end;

destructor T_Event.Destroy;
begin
  // do cleanup...
  inherited;
end;

// ----------------------------------------------------------------------

function Assert(): boolean;
begin
  result := false;
  if Assigned(CORE) then
    if CORE.qryEvent.Active then
      if not CORE.qryEvent.IsEmpty then
        result := true;
end;

function RenumberHeats(DoLocate: Boolean = true):     integer;
var
  aHeatID: integer;
begin
  if not Assigned(SCM) or not SCM.IsActive then exit;
  if CORE.dsHeat.DataSet.IsEmpty then exit;
  result := 0;
  CORE.qryLane.DisableControls;
  CORE.qryHeat.DisableControls;
  try
    if DoLocate then
      aHeatID := uHeat.PK;
    SCM.procRenumberHeats.Params[1].Value := uEvent.PK;
    SCM.procRenumberHeats.Prepare;
    SCM.procRenumberHeats.ExecProc;
  finally
    CORE.qryHeat.ApplyMaster;
    if DoLocate then
      uHeat.Locate(aHeatID);
    CORE.qryHeat.EnableControls;
    CORE.qryLane.EnableControls;
  end;
end;

function DeleteHeats(DoExclude: Boolean = true): boolean;
var
  SQL: string;
  done: boolean;
begin
  result := false;
  // Not permitted to delete anything if session is locked.
  if uSession.IsLocked() then exit;
  CORE.qryHeat.DisableControls;
  try
    CORE.qryHeat.ApplyMaster; // ASSERT MASTER-DETAILED.
    CORE.qryHeat.First;
    while not eof do
    begin
      // Deletes watch-times and split-times and finally the lane.
      done := uHeat.DeleteHeat(true); // retain raced or closed heats.
      if done then
      begin
        result := true;
        continue;
      end
      else
        CORE.qryHeat.Next;
    end;
  finally
    // if required, renumbering of heats is handled by caller.
    CORE.qryHeat.EnableControls;
  end;
end;

function DeleteEvent(DoExclude: Boolean = true): boolean;
var
  SQL: string;
  done, doRenumber: boolean;
begin
	result := false;
  doRenumber := false;
  // Not permitted to delete the current event if session is locked.
  if CORE.qrySession.FieldByName('SessionStatusID').AsInteger = 2 then exit;

  CORE.qryHeat.DisableControls;
  try
    // D E L E T E   H E A T S
    doRenumber := uEvent.DeleteHeats(true); // exclude raced or closed heats
    // Can't delete remaining dependants if heats are retained.
    if (CORE.qryHeat.IsEmpty) then
    begin
      // Clear Scheduled Events.
      SQL := 'UPDATE SwimClubMeet2.dbo.ScheduleEvent SET EventID = NULL WHERE EventID = :ID';
      SCM.scmConnection.ExecSQL(SQL, [uEvent.PK]);

      // D E L E T E   N O M I N A T I O N S .
      CORE.qryNominee.DisableControls;
      CORE.qryNominee.ApplyMaster; // ASSERT MASTER-DETAILED.
      try
        // Only DeleteEvent nominations if no heats exist.
        SQL := 'Delete FROM SwimClubMeet2.dbo.Nominee WHERE Nominee.EventID = :ID';
        SCM.scmConnection.ExecSQL(SQL, [uEvent.PK]);
        CORE.qryNominee.ApplyMaster;  // ASSERT MASTER-DETAILED.
      finally
        CORE.qryNominee.EnableControls;
      end;
      // F I N A L L Y   DELETE THE EVENT..
      CORE.qryEvent.Delete;
      result := true;
    end;

  finally
    if doRenumber then
      uEvent.RenumberHeats(false); // don't relocate
    // Renumbering of EVENTS is handled by caller.
    CORE.qryHeat.EnableControls;
  end;
end;

function AllHeatsAreClosed: Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if uEvent.HeatCount() = 0 then exit; // NO HEATS.
  SQL := 'SELECT COUNT(HeatStatusID) FROM SwimClubMeet2.dbo.Heat ' +
  'WHERE (EventID = :GetEventID ) AND (HeatStatusID < 3)';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) then
    if v = 0 then result := true;
end;

procedure FNameEllipse;
var
  ds: TFDQuery;
begin
  ds := (SCM.dsFNameEllipse.DataSet as TFDQuery);
  // re-assign parameters ...
  // TODO: reassigning params without close or prepare?
  ds.ParamByName('SESSIONID').AsInteger :=
  CORE.qrySession.FieldByName('SessionID').AsInteger;
  ds.ParamByName('EVENTID').AsInteger := CORE.qryEvent.FieldByName('EventID')
  .AsInteger;
  ds.ParamByName('DISTANCEID').AsInteger := CORE.qryEvent.FieldByName
  ('DistanceID').AsInteger;
  ds.ParamByName('STROKEID').AsInteger := CORE.qryEvent.FieldByName
  ('StrokeID').AsInteger;
  if (ds.Active) then ds.Refresh();
end;

function CalcEntrantCount: integer;
var
  v: variant;
  SQL: string;
begin
  result := 0;
  if not Assigned(SCM) or not SCM.scmConnection.Connected then exit;
  SQL := 'SELECT SwimClubMeet2.dbo.EntrantCount(:ID);';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsClear(v) and (v > 0) then result := v;
end;

procedure SetEntrantCount();
begin
  var i := uEvent.CalcEntrantCount;
  try
    CORE.qryEvent.DisableControls;
    if CORE.qryEvent.FieldByName('EntrantCount').AsInteger <> i then
    begin
      try
        CORE.qryEvent.Edit;
        CORE.qryEvent.FieldByName('EntrantCount').AsInteger := i;
        CORE.qryEvent.Post;
      except on E: Exception do
          CORE.qryEvent.Cancel;
      end;
    end;
  finally
    CORE.qryEvent.EnableControls;
  end;
end;

function EntrantCount: integer;
begin
  result := CORE.qryEvent.FieldByName('EntrantCount').AsInteger;
end;

function CalcNomineeCount: integer;
var
  v: variant;
  SQL: string;
begin
  result := 0;
  if not Assigned(SCM) or not SCM.scmConnection.Connected then exit;
  SQL := 'SELECT SwimClubMeet2.dbo.NomineeCount(:GetEventID);';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsClear(v) then result := v;
end;

procedure SetNomineeCount();
begin
  var i := uEvent.CalcNomineeCount;
  try
    CORE.qryEvent.DisableControls;
    try
      CORE.qryEvent.Edit;
      CORE.qryEvent.FieldByName('NomineeCount').AsInteger := i;
      CORE.qryEvent.Post;
    except on E: Exception do
        CORE.qryEvent.Cancel;
    end;
  finally
    CORE.qryEvent.EnableControls;
  end;
end;

function NomineeCount: integer;
begin
  result := CORE.qryEvent.FieldByName('NomineeCount').AsInteger;
end;

function GetEventID: integer;
begin
  result := 0;
  if uEvent.Assert then  // Assert - make safe.
    result := CORE.qryLane.FieldByName('EventID').AsInteger;
end;

function EventType: SCMDefines.scmEventType;
var
  v: variant;
begin
  result := SCMDefines.scmEventType.etUnknown; // Default.
  if CORE.qryEvent.IsEmpty then exit; // Table is empty.
  v := CORE.qryEvent.FieldByName('luEventTypeID').AsVariant;
  if VarIsNull(v) or VarIsEmpty(v) or (v = 0) then exit;
  case v of
    1: result := SCMDefines.scmEventType.etINDV;
    2: result := SCMDefines.scmEventType.etTEAM;
  end;
end;

function HeatCount: integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  SQL := '''
    SELECT Count(Heat.HeatID) FROM SwimClubMeet2.dbo.[Event]
    INNER JOIN Heat ON [Event].EventID = Heat.EventID
    WHERE Event.EventID = :ID;
    ''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function HasClosedHeats: Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  // count the closed heats.
  SQL := '''
    SELECT Count([Heat].[HeatID]) FROM [SwimClubMeet2].[dbo].[Event]
    INNER JOIN Heat ON Event.EventID = Heat.EventID
    WHERE Event.EventID = :ID AND (Heat.HeatStatusID = 3);
    ''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function HasClosedOrRacedHeats: Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  SQL := '''
    SELECT Count([Heat].[HeatID]) FROM [SwimClubMeet2].[dbo].[Event]
    INNER JOIN Heat ON Event.EventID = Heat.EventID
    WHERE Event.EventID = :ID AND (Heat.HeatStatusID > 1);
    ''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function HasNominee(MemberID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  SQL := '''
		SELECT COUNT(Nominee.NomineeID) FROM SwimClubMeet2.dbo.Nominee
		WHERE [MemberID] = :ID1 AND [EventID] = :ID2;
		''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [MemberID, uEvent.PK]);
  if not VarIsClear(v) then
    if (v > 0) then result := true;
end;

function HasNominees: Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  SQL := '''
    SELECT COUNT(NomineeID) FROM SwimClubMeet2.dbo.Nominee
    WHERE Nominee.EventID = :ID AND MemberID IS NOT NULL;
    ''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function HasRacedHeats: Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  SQL := '''
    SELECT Count([Heat].[HeatID]) FROM [SwimClubMeet2].[dbo].[Event]
    INNER JOIN Heat ON Event.EventID = Heat.EventID
    WHERE Event.EventID = :ID AND (Heat.HeatStatusID = 2);
    ''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function LastEventNum: integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not Assigned(SCM) and SCM.IsActive then exit;
  SQL := '''
    SELECT MAX(EventNum) FROM SwimClubMeet2.dbo.Event
    WHERE Event.SessionID = :ID;
    ''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uSession.PK()]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function Locate(aEventID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if (aEventID = 0) then exit;
  SearchOptions := [];
  if Assigned(CORE) and CORE.qryEvent.Active then
    result := CORE.qryEvent.Locate('EventID', aEventID,
      SearchOptions);
end;

procedure NewEvent();
var
  fld: TField;
  aEventNum: integer;
begin
  if CORE.qrySession.IsEmpty then exit;
  try
    aEventNum := uEvent.LastEventNum();
    Inc(aEventNum);
    CORE.qrySplitTime.DisableControls;
    CORE.qryWatchTime.DisableControls;
    CORE.qryLane.DisableControls();
    CORE.qryHeat.DisableControls();
    CORE.qryEvent.DisableControls();
    fld := CORE.qryEvent.FindField('EventStatusID');
    if Assigned(fld) then fld.ReadOnly := false;
    try
      CORE.qryEvent.Insert;
      CORE.qryEvent.FieldByName('SessionID').AsInteger := uSession.PK;
      CORE.qryEvent.FieldByName('EventNum').AsInteger := aEventNum;
      CORE.qryEvent.FieldByName('RoundID').AsInteger := 1; // Preliminary.
      CORE.qryEvent.FieldByName('EventStatusID').AsInteger := 1; // Open.
      CORE.qryEvent.Post;
    except on E: Exception do
        CORE.qryHeat.Cancel;
    end;
  finally
    if Assigned(fld) then fld.ReadOnly := true;
    CORE.qryEvent.EnableControls();
    CORE.qryHeat.ApplyMaster;
    CORE.qryHeat.EnableControls();
    CORE.qryLane.ApplyMaster;
    CORE.qryLane.EnableControls();
    CORE.qrySplitTime.ApplyMaster;
    CORE.qryWatchTime.ApplyMaster;
    CORE.qrySplitTime.EnableControls;
    CORE.qryWatchTime.EnableControls;
  end;
end;

function Locate(aDistanceID, aStrokeID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  SearchOptions := [];
  if CORE.qryEvent.Active then
    result := CORE.qryEvent.Locate('DistanceID;StrokeID',
      VarArrayOf([aDistanceID, aStrokeID]), SearchOptions);
end;

function PK(): integer;
begin // NO CHECKS. quick and dirty - primary key result.
  result := CORE.qryEvent.FieldByName('EventID').AsInteger;
end;

procedure SetEventStatusID(aEventStatusID: integer);
var
fld: TField;
begin
  if uSession.IsLocked() then exit;
  if CORE.qryEvent.IsEmpty then exit;
  try
    fld := CORE.qryEvent.FindField('EventStatusID');
    if Assigned(fld) then fld.ReadOnly := false;
    CORE.qryEvent.DisableControls;
    try
      CORE.qryEvent.Edit;
      CORE.qryEvent.FieldByName('EventStatusID').AsInteger := aEventStatusID;
      CORE.qryEvent.Post;
    except on E: Exception do
        CORE.qryEvent.Cancel;
    end;
  finally
    if Assigned(fld) then fld.ReadOnly := true;
    CORE.qryEvent.EnableControls;
  end;
end;

end.

