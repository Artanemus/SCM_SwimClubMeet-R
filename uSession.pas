unit uSession;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, System.VarUtils,
  System.StrUtils,
  vcl.Dialogs, Data.DB,
  dmCORE, dmSCM, SCMdefines,
  FireDAC.Comp.Client;

{ S E S S I O N .    }
function AllEventsAreClosed: Boolean;
function Assert: Boolean;
function CalcEntrantCount: integer;
function CalcNomineeCount(): integer;
function DeleteSession(DoExclude: Boolean = true): boolean;
function CountEntrants: integer;
function CountEvents: integer;
function CountNominees: integer;
function GetSessionID: integer; // Assert - SAFE.
//function HasClosedOrRacedHeats: Boolean; deprecated;
function HasEvents: Boolean;  deprecated;
function IsEmptyOrLocked: Boolean;
function IsLocked: Boolean;
function Locate(SessionID: integer): Boolean;
function PK(): integer; // NO CHECKS. RTNS: Primary key.
function RenumberEvents(DoLocate: Boolean = true): integer;
function StartDT: TDateTime;
procedure HideLocked(IsChecked: Boolean);
procedure SetEntrantCount();
procedure SetNomineeCount();
procedure SetSortIndex(idx: integer);
procedure ToggleLockState();

type
  T_Session = class
  public
    constructor Create;
    destructor Destroy;
  end;

var
  scmSession: T_Session;

implementation

uses
  uEvent, uHeat, uLane;

constructor T_Session.Create;
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

destructor T_Session.Destroy;
begin
  // do cleanup...
  inherited;
end;

function Assert: Boolean;
begin
  result := false;
  if Assigned(CORE) then
    if CORE.qrySession.Active then
      if not CORE.qrySession.IsEmpty then
        result := true;
end;

function RenumberEvents(DoLocate: Boolean = true): integer;
var
  aEvent: integer;
begin
  if not Assigned(SCM) or not SCM.IsActive then exit;
  if CORE.dsHeat.DataSet.IsEmpty then exit;
  result := 0;
  CORE.qryLane.DisableControls;
  CORE.qryHeat.DisableControls;
  try
    if DoLocate then
      aEvent := uHeat.PK;
    SCM.procRenumberEvents.Params[1].Value := uSession.PK;
    SCM.procRenumberEvents.Prepare;
    SCM.procRenumberEvents.ExecProc;
  finally
    CORE.qryHeat.ApplyMaster;
    if DoLocate then
      uHeat.Locate(aEvent);
    CORE.qryHeat.EnableControls;
    CORE.qryLane.EnableControls;
  end;
end;


  (*
  if CORE.dsEvent.DataSet.IsEmpty then exit;

  ds := CORE.dsEvent.DataSet;
  if DoLocate then aEventID := ds.FieldByName('EventID').AsInteger;

   ds.DisableControls;
   sl := TStringList.Create;
   // Legal, qryEvent has master..child relationship with dsSession.
   sl.Add('USE [SwimClubMeet2] ');
   sl.Add('SELECT [EventID], [EventNum] FROM [dbo].[Event] ');
   sl.Add('WHERE [SessionID] = ' + IntToStr(aSessionID));
   sl.Add(' ORDER BY [EventNum]');
   // Find valid EventNum
 //  qry := TFDQuery.Create(self);
   qry.Connection := SCM.scmConnection;
   qry.SQL := sl;
   qry.UpdateOptions.KeyFields := 'EventID';
   qry.UpdateOptions.UpdateTableName := 'SwimClubMeet2..Event';
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
     if (i>1) then result := i-1;
   end;
   qry.Close;
   qry.Free;
   sl.Free;
   // REQUERY : RELOAD DATA
   ds.Refresh();
   // REQUEUE
   if (DoLocate) then uEvent.Locate(aEventID);
   ds.EnableControls();
   *)


function DeleteSession(DoExclude: Boolean = true): boolean;
var
  SQL: string;
  qry: TFDQuery;
  aEventID, rows: integer;
  done, doRenumber: boolean;
begin
  result := false;
  doRenumber := false;
  if not uSession.Assert then exit;
  if uSession.IsLocked then exit; // No locked session is ever deleted.

  CORE.qrySession.DisableControls;
  CORE.qryEvent.DisableControls;
  CORE.qryNominee.DisableControls;
  CORE.qryHeat.DisableControls;
  CORE.qryLane.DisableControls;
  CORE.qryTeam.DisableControls;
  CORE.qryTeamLink.DisableControls;

  try
    CORE.qryEvent.ApplyMaster; // assert sync to master.
    if CORE.qryEvent.IsEmpty then exit;

    CORE.qryEvent.First;
    while not CORE.qryEvent.Eof do
    begin
      {
      Disables controls for detailed tables.
      Deletes detailed tables ... including ...
          nominees, heats, lanes, teams, teamlinks.
      Nulls FK in clears scheduledEvent.
      Enables controls for detailed tables.
      }
      done := uEvent.DeleteEvent(DoExclude); // DeleteSession current Event + Dependants
      if done then
      begin
        doRenumber := true;
        continue;
      end
      else
        CORE.qryEvent.next;
    end;

    // ASSERT that all events have been removed within Master-Detail relationship.
    // Can't delete remaining dependants if eventsare retained.
    if CORE.qryEvent.IsEmpty then
    begin
          // Clear Scheduled Sessions.
      SQL := 'UPDATE SwimClubMeet2.dbo.ScheduleSession SET SessionID = NULL WHERE SessionID = :ID';
      SCM.scmConnection.ExecSQL(SQL, [uSession.PK]);
      // F I N A L L Y  Delete THE SESSION.
      CORE.qrySession.Delete;
    end;

  finally
    if doRenumber then
      uSession.RenumberEvents(false); // don't relocate
    // ASSERT MASTER-DETAIL STATE.
    CORE.qrySession.ApplyMaster;
    CORE.qryEvent.ApplyMaster;
    CORE.qryNominee.ApplyMaster;
    CORE.qryHeat.ApplyMaster;
    CORE.qryLane.ApplyMaster;
    CORE.qryTeam.ApplyMaster;
    CORE.qryTeamLink.ApplyMaster;

    // Enable all controls.
    CORE.qryTeamLink.EnableControls;
    CORE.qryTeam.EnableControls;
    CORE.qryLane.EnableControls;
    CORE.qryHeat.EnableControls;
    CORE.qryNominee.EnableControls;
    CORE.qryEvent.EnableControls;
    CORE.qrySession.EnableControls;
    CORE.qryEvent.EnableControls;
  end;
end;

function AllEventsAreClosed: Boolean;
var
  i: integer;
  SQL: string;
  v: variant;
begin
  result := false;
  if not Assigned(SCM) or not SCM.scmConnection.Connected then exit;
  SQL := '''
    SELECT COUNT(EventID)
    FROM [SwimClubMeet2].[dbo].[Event]
    WHERE [Event].EventStatusID IN [0,1,2] AND [Event].SessionID = :ID;
    ''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uSession.PK]);
  if VarIsClear(v) and (v = 0) then result := true;
end;

function CountEntrants: integer;
begin
  result := CORE.qrySession.FieldByName('EntrantCount').AsInteger;
end;

function CalcEntrantCount(): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not Assigned(SCM) or not SCM.scmConnection.Connected then exit;
  SQL := 'SELECT SwimClubMeet2.dbo.SessionEntrantCount(:ID);';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uSession.PK]);
  if not VarIsClear(v) and (v > 0) then
    result := v;
end;

procedure SetEntrantCount;
begin
  var i := CalcEntrantCount;
  try
    CORE.qrySession.DisableControls;
    if CORE.qrySession.FieldByName('EntrantCount').AsInteger <> i then
    begin
      try
        CORE.qrySession.Edit;
        CORE.qrySession.FieldByName('EntrantCount').AsInteger := i;
        CORE.qrySession.Post;
      except on E: Exception do
          CORE.qrySession.Cancel;
      end;
    end;
  finally
    CORE.qrySession.EnableControls;
  end;
end;

function CountEvents: integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not Assigned(SCM) or not SCM.scmConnection.Connected then exit;
  SQL := '''
		SELECT COUNT(EventID) FROM [SwimClubMeet2].[dbo].[Session]
		INNER JOIN [Event] ON [Session].SessionID = [Event].SessionID
		WHERE [Session].SessionID = :ID;
		''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uSession.PK]);
  if not VarIsClear(v) and (v > 0) then result := v;
end;

function CalcNomineeCount(): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not Assigned(SCM) or not SCM.scmConnection.Connected then exit;
  SQL := 'SELECT SwimClubMeet2.dbo.SessionNomineeCount(:ID1);';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uSession.PK]);
  if not VarIsClear(v) and (v > 0) then result := v;
end;

procedure SetNomineeCount();
begin
  var i := uSession.CalcNomineeCount;
  try
    CORE.qrySession.DisableControls;
    try
      CORE.qrySession.Edit;
      CORE.qrySession.FieldByName('NomineeCount').AsInteger := i;
      CORE.qrySession.Post;
    except on E: Exception do
        CORE.qrySession.Cancel;
    end;
  finally
    CORE.qrySession.EnableControls;
  end;
end;

function CountNominees: integer;
begin
  result := CORE.qrySession.FieldByName('NomineeCount').AsInteger;
end;

function GetSessionID: integer;
begin
  result := CORE.qrySession.FieldByName('SessionID').AsInteger;
end;

(*
function HasClosedOrRacedHeats: Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not Assigned(SCM) or not SCM.scmConnection.Connected then exit;
  SQL := 'SELECT Count(HeatID) FROM  [SwimClubMeet2].[dbo].[Session] ' +
  'INNER JOIN [Event] ON [Session].SessionID = [Event].SessionID ' +
  'INNER JOIN [Heat] ON [Event].EventID = [Heat].EventID '
  + 'WHERE [Heat].HeatStatusID > 1 AND [Session].SessionID = :GetSessionID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uSession.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;
*)

function HasEvents: Boolean; deprecated;
begin
  result := not CORE.qryEvent.IsEmpty;
end;

procedure HideLocked(IsChecked: Boolean);
var
ID: integer;
found: boolean;
begin
  CORE.qryTeamLink.DisableControls;
  CORE.qryTeam.DisableControls;
  CORE.qryLane.DisableControls;
  CORE.qryHeat.DisableControls;
  CORE.qryNominee.DisableControls;
  CORE.qryEvent.DisableControls;
  CORE.qrySession.DisableControls;
  try
    ID := uSession.PK;
    CORE.qrySession.Close;
    CORE.qrySession.ParamByName('TOGGLE').AsBoolean := IsChecked;
    CORE.qrySession.Prepare;
    CORE.qrySession.Open;

    found := uSession.Locate(ID);

    // ASSERT MASTER-DETAIL STATE.
    CORE.qryEvent.ApplyMaster;
    if found then ; // locate to event?.

    CORE.qryNominee.ApplyMaster;
    CORE.qryHeat.ApplyMaster;
    CORE.qryLane.ApplyMaster;
    CORE.qryTeam.ApplyMaster;
    CORE.qryTeamLink.ApplyMaster;
  finally
    CORE.qrySession.EnableControls;
    CORE.qryEvent.EnableControls;
    CORE.qryNominee.EnableControls;
    CORE.qryHeat.EnableControls;
    CORE.qryLane.EnableControls;
    CORE.qryTeam.EnableControls;
    CORE.qryTeamLink.EnableControls;
  end;
end;

function IsLocked: Boolean;
begin
  result := true;
  if (CORE.qrySession.FieldByName('SessionStatusID').AsInteger <> 2)
    then result := false;
end;

function Locate(SessionID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  SearchOptions := [];
  result := CORE.qrySession.Locate('SessionID', SessionID,
    SearchOptions);
end;

function PK(): integer;
begin // NO CHECKS. quick and dirty - primary key result.
  result := CORE.qrySession.FieldByName('SessionID').AsInteger;
end;

function IsEmptyOrLocked: Boolean;
var
  i: integer;
begin
  result := true;
  i := CORE.qrySession.FieldByName('SessionStatusID').AsInteger;
  if (i <> 2) then result := false;
end;

procedure SetSortIndex(idx: integer);
begin
  //  qrySession.Index
  CORE.qrySession.IndexesActive := false;
  case idx of
    1:
      begin
        CORE.qrySession.IndexesActive := true;
        CORE.qrySession.IndexName := 'idxStartDateDESC';
      end;
    2:
      begin
        CORE.qrySession.IndexesActive := true;
        CORE.qrySession.IndexName := 'idxStartDateASC';
      end
  else
    begin
      CORE.qrySession.IndexFieldNames := 'SwimClubID';
    end;
  end;
end;

function StartDT: TDateTime;
begin
  result := CORE.qrySession.FieldByName('StartDT').AsDateTime;
end;

procedure ToggleLockState;
var
  i: integer;
begin
  with CORE.qrySession do
  begin
    CORE.qrySession.DisableControls;
    try
      i := FieldByName('SessionStatusID').AsInteger;
      if i = 1 then i := 2 else i := 1; // TOGGLE STATUS
      try
        Edit;
        FieldByName('SessionStatusID').AsInteger := i;
        Post;
      except on E: Exception do
          Cancel;
      end;
    finally
      CORE.qrySession.EnableControls;
    end;
  end;
end;

end.

