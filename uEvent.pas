unit uEvent;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, System.VarUtils,
  System.StrUtils,
  FireDAC.Comp.Client,
  vcl.Dialogs, Data.DB,
	dmCORE, dmSCM, SCMdefines;

function DeleteRecord(DoExclude: Boolean = true): boolean;
function DeleteHeats(DoExclude: Boolean = true): boolean;
function RenumberHeats(DoLocate: Boolean = true): integer;
function Assert(): boolean;
function AllHeatsAreClosed: Boolean;
function EventType: SCMDefines.scmEventType; overload;
function GetEntrantCount(): integer; overload; // swimmers entered into lanes.
function GetEventID: integer; // SAFE.
function GetHeatCount: integer;
function GetNomineeCount(): integer; overload; // members wanting to enter event.
function HasClosedHeats: Boolean;
function HasClosedOrRacedHeats: Boolean;
function HasNominee(MemberID: integer): Boolean;
function HasNominees: Boolean;
function HasRacedHeats: Boolean;
function Locate(aEventID: integer): Boolean; overload;
function Locate(aDistanceID, aStrokeID: integer): Boolean; overload;
function PK(): integer; // NO CHECKS. RTNS: Primary key.
function SetEventStatusID(aEventStatusID: integer): Boolean;

procedure FNameEllipse(); // todo: move out of uEvent to frame.


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


(*
  // R E N U M B E R  - - -  H  E  A  T  S  .

  result := 0;
  if CORE.dsHeat.DataSet.IsEmpty then exit;
  CORE.qryLane.DisableControls;
  CORE.qryHeat.DisableControls;
  try
    if DoLocate then
      aHeatID := uHeat.PK;
    CORE.qryHeat.ApplyMaster;
    fld := CORE.qryHeat.Fields.FieldByName('HeatNum');
    readstate := fld.ReadOnly;
    fld.ReadOnly := false;

    CORE.qryHeat.Indexes.IndexByName('indxRenumberHeats').Active := true;
    i := 1;
    try
      while not CORE.qryHeat.eof do
      begin
        CORE.qryHeat.edit;
        CORE.qryHeat.FieldByName('HeatNum').AsInteger := i;
        CORE.qryHeat.post;
        Inc(i);
        CORE.qryHeat.next;
      end;
    finally
      fld.ReadOnly := readstate;
      if (i > 1) then result := i - 1;
    end;
  finally
    CORE.qryHeat.Indexes.IndexByName('mcEvent_DESC').Active := true;
    CORE.qryHeat.ApplyMaster;
    if DoLocate then
      uHeat.Locate(aHeatID);
    CORE.qryHeat.EnableControls;
    CORE.qryLane.EnableControls;
  end;

  *)

  // Using TFDQuery and avoiding using indexes

 (*
  if not Assigned(SCM) or not SCM.IsActive then exit;
  if CORE.dsHeat.DataSet.IsEmpty then exit;
  result := 0;
  CORE.qryLane.DisableControls;
  CORE.qryHeat.DisableControls;
  try
    if DoLocate then
      aHeatID := uHeat.PK;
    CORE.qryHeat.ApplyMaster;
    fld := CORE.qryHeat.Fields.FieldByName('HeatNum');
    readstate := fld.ReadOnly;
    fld.ReadOnly := false;
    SQL := '''
      SELECT Heat.HeatID, Heat.HeatNum
      FROM SwimClubMeeet2.dbo.Heat
      WHERE Heat.EventID = :ID
      ORDER BY (CASE WHEN HeatNum IS NULL THEN 1 ELSE 0 END), HeatNum ASC;
      ''';
    qry := TFDQuery.Create(dmCore.CORE);
    qry.Connection := SCM.scmConnection;
    qry.SQL.Text := SQL;
    qry.UpdateOptions.KeyFields := 'HeatID';
    qry.UpdateOptions.UpdateTableName := 'SwimClubMeet2..Heat';
    qry.ParamByName(':ID').AsInteger := uEvent.PK;
    qry.IndexFieldNames := 'EventID;HeatID;HeatNum';
    qry.Prepare;
    qry.Open;

    if qry.Active then
    begin
      i := 1;
      try
        while not qry.Eof do
        begin
          qry.Edit;
          qry.FieldByName('HeatNum').AsInteger := i;
          qry.Post;
          Inc(i);
          qry.Next;
        end;
      finally
        fld.ReadOnly := readstate;
        if (i > 1) then result := i - 1;

      end;
    end;
    qry.Close;
    qry.Free;

  finally
    CORE.qryHeat.ApplyMaster;
    if DoLocate then
      uHeat.Locate(aHeatID);
    CORE.qryHeat.EnableControls;
    CORE.qryLane.EnableControls;
  end;
*)


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
      done := uHeat.DeleteRecord(true); // retain raced or closed heats.
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

function DeleteRecord(DoExclude: Boolean = true): boolean;
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
        // Only DeleteRecord nominations if no heats exist.
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
  if uEvent.GetHeatCount() = 0 then exit; // NO HEATS.
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

function GetEntrantCount: integer;
var
  v: variant;
  SQL: string;
  EventID: integer;
begin
  result := 0;
  if CORE.qryEvent.IsEmpty then exit;
  EventID := CORE.qryEvent.FieldByName('EventID').AsInteger;
  if EventID = 0 then exit;
  SQL := 'SELECT SwimClubMeet2.dbo.EntrantCount(:GetEventID);';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [EventID]);
  if not VarIsClear(v) then result := v;
end;

function GetEventID: integer;
begin
  result := 0;
  if uEvent.Assert then
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

function GetHeatCount: integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  SQL := 'SELECT Count(Heat.HeatID) FROM SwimClubMeet2.dbo.[Event] ' +
  'INNER JOIN Heat ON [Event].EventID = Heat.EventID ' +
  'WHERE Event.EventID = :EventID;';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function GetNomineeCount: integer;
var
  v: variant;
  SQL: string;
  EventID: integer;
begin
  result := 0;
  if CORE.qryEvent.IsEmpty then exit;
  EventID := CORE.qryEvent.FieldByName('EventID').AsInteger;
  if EventID = 0 then exit;
  SQL := 'SELECT SwimClubMeet2.dbo.NomineeCount(:GetEventID);';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [EventID]);
  if not VarIsClear(v) then result := v;
end;

function HasClosedHeats: Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  // count the closed heats.
  SQL := 'SELECT Count([Heat].[HeatID]) FROM [SwimClubMeet2].[dbo].[Event] '
  + 'INNER JOIN Heat ON Event.EventID = Heat.EventID ' +
  'WHERE Event.EventID = :GetEventID AND (Heat.HeatStatusID = 3) ';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function HasClosedOrRacedHeats: Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  SQL := ' SELECT Count([Heat].[HeatID]) FROM [SwimClubMeet2].[dbo].[Event] '
  + 'INNER JOIN Heat ON Event.EventID = Heat.EventID ' +
  'WHERE Event.EventID = :GetEventID AND (Heat.HeatStatusID > 1) ';
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
		WHERE [MemberID] = :ID1 AND [EventID] = :ID2
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
  SQL := 'SELECT COUNT(NomineeID) FROM SwimClubMeet2.dbo.Nominee ' +
  'WHERE Nominee.EventID = :GetEventID AND MemberID IS NOT NULL; ';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function HasRacedHeats: Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false; // DEFAULT - no raced heats
  // count the raced heats.
  SQL := 'SELECT Count([Heat].[HeatID]) FROM [SwimClubMeet2].[dbo].[Event] '
  + 'INNER JOIN Heat ON Event.EventID = Heat.EventID ' +
  'WHERE Event.EventID = :GetEventID AND (Heat.HeatStatusID = 2) ';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uEvent.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
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

function SessionIsLocked(aEventID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet2].[dbo].[Session] ' +
  'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
  'WHERE [Event].[EventID] = :GetEventID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
end;

function SetEventStatusID(aEventStatusID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if uSession.IsLocked() then exit;
  if (aEventStatusID <> 1) or (aEventStatusID <> 2) then exit;
  SQL := 'UPDATE SwimClubMeet2.dbo.Event SET [Event].[EventStatusID] = :ID1 ' +
  'WHERE [Event].[EventID] = :ID2';
  v := SCM.scmConnection.ExecSQL(SQL, [aEventStatusID, uEvent.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) then
    if (v > 0) then result := true;
end;

end.

