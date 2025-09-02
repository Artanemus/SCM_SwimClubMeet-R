unit uSession;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, System.VarUtils,
  System.StrUtils,
  vcl.Dialogs, Data.DB,
  dmCORE, dmSCM, uDefines,
  FireDAC.Comp.Client;

/// <summary>
///  Only call here if SCM is assigned and connected...
///  ... AND CORE is assigned and IsActive.
/// </summary>
///
function AllEventsAreClosed: Boolean;
function Assert: Boolean;
function CalcEntrantCount: integer;
function CalcNomineeCount(): integer;
function CalcEventCount: integer;
function DeleteSession(DoExclude: Boolean = true): boolean;
function EntrantCount: integer;
function NomineeCount: integer;
function GetSessionID: integer; // Assert - SAFE.
function HasClosedOrRacedHeats: Boolean; deprecated;
function HasEvents: Boolean;  deprecated;
function IsEmptyOrLocked: Boolean;
function IsLocked: Boolean;
function Locate(SessionID: integer): Boolean;
function PK(): integer; // NO CHECKS. RTNS: Primary key.
function RenumberEvents(DoLocate: Boolean = true): integer;
function SessionDT: TDateTime;

procedure DetailTBLs_DisableCNTRLs;
procedure DetailTBLs_ApplyMaster;
procedure DetailTBLs_EnableCNTLs;
procedure SetVisibilityOfLocked(IsVisible: Boolean);
procedure SetEntrantCount();
procedure SetNomineeCount();
procedure SetSessionStatusID(aSessionStatusID: Integer);
//procedure SortSession();
procedure NewSession();
//procedure EditSession();
//procedure ReSyncSession();




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
  uSwimClub, uEvent, uHeat, uLane;

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

function Assert: Boolean;
begin
  result := false;
  if Assigned(CORE) then
    if CORE.qrySession.Active then
      if not CORE.qrySession.IsEmpty then
        result := true;
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

function CalcEventCount: integer;
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

procedure DetailTBLs_DisableCNTRLs;
begin
    CORE.qryEvent.DisableControls;
    CORE.qryHeat.DisableControls;
    CORE.qryLane.DisableControls;
    CORE.qryWatchTime.DisableControls;
    CORE.qrySplitTime.DisableControls;
    CORE.qryTeam.DisableControls;
end;

procedure DetailTBLs_ApplyMaster;
begin
    CORE.qryEvent.ApplyMaster;
    CORE.qryHeat.ApplyMaster;
    CORE.qryLane.ApplyMaster;
    CORE.qryWatchTime.ApplyMaster;
    CORE.qrySplitTime.ApplyMaster;
    CORE.qryTeam.ApplyMaster;
end;

procedure DetailTBLs_EnableCNTLs;
begin
    CORE.qryEvent.EnableControls;
    CORE.qryHeat.EnableControls;
    CORE.qryLane.EnableControls;
    CORE.qryWatchTime.EnableControls;
    CORE.qrySplitTime.EnableControls;
    CORE.qryTeam.EnableControls;
end;

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

function EntrantCount: integer;
begin
  result := CORE.qrySession.FieldByName('EntrantCount').AsInteger;
end;

function GetSessionID: integer;
begin
  result := CORE.qrySession.FieldByName('SessionID').AsInteger;
end;

function HasClosedOrRacedHeats: Boolean; deprecated;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not Assigned(SCM) or not SCM.scmConnection.Connected then exit;
  SQL := '''
    SELECT Count(HeatID) FROM  [SwimClubMeet2].[dbo].[Session]
    INNER JOIN [Event] ON [Session].SessionID = [Event].SessionID
    INNER JOIN [Heat] ON [Event].EventID = [Heat].EventID
    WHERE [Heat].HeatStatusID > 1 AND [Session].SessionID = :ID'
    ''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uSession.PK]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function HasEvents: Boolean; deprecated;
begin
  result := not CORE.qryEvent.IsEmpty;
end;

function IsEmptyOrLocked: Boolean;
var
  i: integer;
begin
  result := true;
  i := CORE.qrySession.FieldByName('SessionStatusID').AsInteger;
  if (i <> 2) then result := false;
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

procedure SetEntrantCount;
begin
  var i := uSession.CalcEntrantCount;
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

procedure SetSessionStatusID(aSessionStatusID: Integer);
var
  i: integer;
  fld: TField;
begin
  if aSessionStatusID in [1,2] then // Check out of bounds.
  begin
    with CORE.qrySession do
    begin
      CORE.qrySession.DisableControls;
      fld := CORE.qrySession.FindField('SessionStatusID');
      if Assigned(fld) and fld.ReadOnly = true then
        fld.ReadOnly := false;
      try
        try
          Edit;
          FieldByName('SessionStatusID').AsInteger := i;
          Post;
        except on E: Exception do
            Cancel;
        end;
      finally
        if Assigned(fld) then fld.ReadOnly := true;
        CORE.qrySession.EnableControls;
      end;
    end;
  end;
end;

procedure SetVisibilityOfLocked(IsVisible: Boolean);
/// <param name="IsVisible">
///  true: show both locked and unlocked sessions.
///  false: hides locked sessions.
/// </param>
var
ID: integer;
found: boolean;
begin
  CORE.qryTeam.DisableControls;
  CORE.qryLane.DisableControls;
  CORE.qryHeat.DisableControls;
  CORE.qryNominee.DisableControls;
  CORE.qryEvent.DisableControls;
  CORE.qrySession.DisableControls;
  try
    ID := uSession.PK;
    try
      if IsVisible then
        CORE.qrySession.IndexName := 'indxShowAll'
      else
        CORE.qrySession.IndexName := 'indxHideLocked';
      if not CORE.qrySession.IndexesActive then
        CORE.qrySession.IndexesActive := true;
    except on E: Exception do
      begin
        E.Message := E.Message +sLineBreak+ 'FATAL - Session.IndexName ';
        raise;
      end;
    end;

    // Activate Detailed tables
    CORE.qryEvent.ApplyMaster;
    CORE.qryNominee.ApplyMaster;
    CORE.qryHeat.ApplyMaster;
    CORE.qryLane.ApplyMaster;
    CORE.qryTeam.ApplyMaster;
  finally
    CORE.qrySession.EnableControls;
    CORE.qryEvent.EnableControls;
    CORE.qryNominee.EnableControls;
    CORE.qryHeat.EnableControls;
    CORE.qryLane.EnableControls;
    CORE.qryTeam.EnableControls;
  end;
end;

function SessionDT: TDateTime;
begin
  result := CORE.qrySession.FieldByName('SessionDT').AsDateTime;
end;

procedure NewSession();
/// <remarks>
/// Sorting of session grid handled by active index.
/// </remarks>
var
  fld: TField;
  aSessionNum: integer;
begin
  try
    CORE.qrySplitTime.DisableControls;
    CORE.qryWatchTime.DisableControls;
    CORE.qryLane.DisableControls();
    CORE.qryHeat.DisableControls();
    CORE.qryEvent.DisableControls();
    CORE.qrySession.DisableControls();

   //  CORE.qrySession.IndexesActive := false; // Is this needed??? check.

    try
      CORE.qrySession.Insert;
      { // handled by OnNewRecord in dmCORE.
      CORE.qrySession.FieldByName('SwimClubID').AsInteger := uSwimClub.PK;
      CORE.qrySession.FieldByName('SessionDT').AsDateTime := Now();
      CORE.qrySession.FieldByName('CreatedOn').AsDateTime := Now();
      CORE.qrySession.FieldByName('SessionStatusID').AsInteger := 1; // Open.
      }
      CORE.qrySession.Post;
    except on E: Exception do
        CORE.qryHeat.Cancel;
    end;
  finally
    // SQLExec - ID of new record.
    //    CORE.qrySession.IndexesActive := true; // check.
    // Locate to new record.

    CORE.qrySession.EnableControls();
    CORE.qryEvent.ApplyMaster;
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

function NomineeCount: integer;
begin
  result := CORE.qrySession.FieldByName('NomineeCount').AsInteger;
end;

function PK(): integer;
begin // NO CHECKS. quick and dirty - primary key result.
  result := CORE.qrySession.FieldByName('SessionID').AsInteger;
end;

end.

