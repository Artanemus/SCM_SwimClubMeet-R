unit uSession;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, System.VarUtils,
  System.StrUtils,
  vcl.Dialogs, Data.DB,
  dmSCMcore, dmSCM, SCMdefines,
	FireDAC.Comp.Client;

{ S E S S I O N .    }

function DeleteSession(aSessionID: integer;  DoExclude: Boolean = true): integer;

function AllEventsAreClosed(aSessionID: integer): Boolean;
function GetEntrantCount(): integer; overload;
function GetEntrantCount(aSessionID: integer): integer; overload;
function GetEventCount(aSessionID: integer): integer;
function GetNomineeCount(): integer; overload;
function GetNomineeCount(aSessionID: integer): integer; overload;
function GetSessionID: integer;
function HasClosedOrRacedHeats(aSessionID: integer): Boolean;
function HasEvents(aSessionID: integer): Boolean;
function IsEmptyLocked(): Boolean; overload;
function IsEmptyLocked(SessionID: integer): Boolean; overload;
function IsLocked(aSessionID: integer): Boolean; overload;
function IsLocked: Boolean; overload; // current session
function Locate(SessionID: integer): Boolean;
function PK(): integer; // NO CHECKS. RTNS: Primary key.
function Start(): TDateTime; overload;
function Start(SessionID: integer): TDateTime; overload;
procedure HideLocked(IsChecked: Boolean);
procedure SetSortIndex(idx: integer);
procedure ToggleLockState();
procedure SetEntrantCount();
procedure SetNomineeCount();


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
  if not SCM.SCMActive then
    raise Exception.Create('Data module SCM tables are offline.');
  if not Assigned(SCMCore) then
    raise Exception.Create('Core data module not assigned.');
  if not SCMCore.CoreActive then
    raise Exception.Create('Core data module tables are offline.');
end;

destructor T_Session.Destroy;
begin
  // do cleanup...
  inherited;
end;



function DeleteSession(aSessionID: integer; DoExclude: Boolean): integer;
var
  SQL: string;
  qry: TFDQuery;
  aEventID, rows: integer;
begin
  // No locked session is ever deleted.
  result := 0;
  if uSession.IsLocked then exit;
  SCMcore.qryEvent.DisableControls;
  SCMcore.qrySession.DisableControls;
  SCMcore.qryEvent.DisableControls;
  SCMcore.qryNominee.DisableControls;
  SCMcore.qryHeat.DisableControls;
  SCMcore.qryLane.DisableControls;
  SCMcore.qryTeam.DisableControls;
  SCMcore.qryTeamLink.DisableControls;
  try
    SCMcore.qryEvent.First;
    while not SCMcore.qryEvent.Eof do
    begin
      { executes :
             Disables controls for detailed tables.
        Deletes detailed tables ... including ...
         delete nominees, delete heats, delete lanes,
         delete teams, delete teamlinks.
        Nulls FK in clears scheduledEvent.
             Enables controls for detailed tables.
         }
      uEvent.DeleteDependants(SCMcore.qryEvent.FieldByName('EventID').AsInteger,
        DoExclude);
      SCMcore.qryEvent.delete;
    end;
    if not SCMcore.qryEvent.IsEmpty then SCMcore.qrySession.Delete;

  finally
    SCMcore.qrySession.ApplyMaster;
    SCMcore.qryEvent.ApplyMaster;
    SCMcore.qryNominee.ApplyMaster;
    SCMcore.qryHeat.ApplyMaster;
    SCMcore.qryLane.ApplyMaster;
    SCMcore.qryTeam.ApplyMaster;
    SCMcore.qryTeamLink.ApplyMaster;
    SCMcore.qryTeamLink.EnableControls;
    SCMcore.qryTeam.EnableControls;
    SCMcore.qryLane.EnableControls;
    SCMcore.qryHeat.EnableControls;
    SCMcore.qryNominee.EnableControls;
    SCMcore.qryEvent.EnableControls;
    SCMcore.qrySession.EnableControls;
    SCMcore.qryEvent.EnableControls;
  end;
end;


function RenumberEvents(aSessionID: integer; DoLocate,	DoExclude: Boolean): integer;
begin
	result := 0;
	if aSessionID = 0 then exit;
	if uSession.IsLocked(aSessionID) then exit;
	result := SCM.RenumberEvents(aSessionID, DoLocate);
end;



function AllEventsAreClosed(aSessionID: integer): Boolean;
var
  i: integer;
begin
  result := false;
  if not SCM.SCMActive then exit;
  SCM.qryCountEventsNotClosed.Close;
  SCM.qryCountEventsNotClosed.ParamByName('SESSIONID').AsInteger := aSessionID;
  SCM.qryCountEventsNotClosed.Prepare;
  SCM.qryCountHeatsNotClosed.Open;
  if (SCM.qryCountEventsNotClosed.Active) then
  begin
    i := SCM.qryCountEventsNotClosed.FieldByName('CountStatus').AsInteger;
    if (i = 0) then result := true;
  end;
  SCM.qryCountEventsNotClosed.Close;
end;

function GetEntrantCount(): integer;
begin
	result := SCMcore.qrySession.FieldByName('EntrantCount').AsInteger;
end;

procedure SetEntrantCount();
var
	SQL: string;
	v: variant;
	PK: integer;
begin
	PK := SCMcore.qrySession.FieldByName('SessionID').AsInteger;
	SQL := 'SELECT SwimClubMeet.dbo.SessionEntrantCount(:ID);';
	v := SCM.scmConnection.ExecSQLScalar(SQL, [PK]);
	if VarIsClear(v) or (v > 0) then v := 0;
	try
	SCMcore.qrySession.DisableControls;
		try
			SCMcore.qrySession.Edit;
			SCMcore.qrySession.FieldByName('EntrantCount').AsInteger := v;
			SCMcore.qrySession.Post;
		except on E: Exception do
			SCMcore.qrySession.Cancel;
		end;
	finally
		SCMcore.qrySession.EnableControls;
	end;
end;

function GetEntrantCount(aSessionID: integer): integer;
var
	SQL: string;
	v: variant;
begin
	result := 0;
	if not SCM.SCMActive then exit;
	if aSessionID = 0 then exit;
	SQL := '''
		SELECT EntrantCount
		FROM SwimClubMeet2.dbo.Session
		WHERE Session.SessionID = :ID;
		''';
	v := SCM.scmConnection.ExecSQLScalar(SQL, [aSessionID]);
	if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function GetEventCount(aSessionID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not SCM.SCMActive then exit;
	SQL := '''
		SELECT COUNT(EventID) FROM [SwimClubMeet2].[dbo].[Session]
		INNER JOIN [Event] ON [Session].SessionID = [Event].SessionID
		WHERE [Session].SessionID = :ID;
		''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aSessionID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

procedure SetNomineeCount();
var
	SQL: string;
	v: variant;
	PK: integer;
begin
	PK := SCMcore.qrySession.FieldByName('SessionID').AsInteger;
	SQL := 'SELECT SwimClubMeet.dbo.SessionNomineeCount(:ID1);';
	v := SCM.scmConnection.ExecSQLScalar(SQL, [PK]);
	if VarIsClear(v) or (v > 0) then v := 0;
	try
	SCMcore.qrySession.DisableControls;
		try
			SCMcore.qrySession.Edit;
			SCMcore.qrySession.FieldByName('NomineeCount').AsInteger := v;
			SCMcore.qrySession.Post;
		except on E: Exception do
			SCMcore.qrySession.Cancel;
		end;
	finally
		SCMcore.qrySession.EnableControls;
	end;
end;

function GetNomineeCount(): integer;
begin
	result := SCMcore.qrySession.FieldByName('NomineeCount').AsInteger;
end;

function GetNomineeCount(aSessionID: integer): integer;
var
	SQL: string;
  v: variant;
begin
  result := 0;
  if not SCM.SCMActive then exit;
  if aSessionID = 0 then exit;
	SQL := '''
		SELECT NomineeCount
		FROM SwimClubMeet2.dbo.Session
		WHERE Session.SessionID = :ID1;
		''';
	v := SCM.scmConnection.ExecSQLScalar(SQL, [aSessionID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function GetSessionID: integer;
begin
  result := 0;
  if SCM.SCMActive and SCMcore.dsSession.DataSet.Active then
    if not SCMcore.dsSession.DataSet.IsEmpty then
      result := SCMcore.dsSession.DataSet.FieldByName('SessionID').AsInteger;
end;

function HasClosedOrRacedHeats(aSessionID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not SCM.SCMActive then exit;
  if aSessionID = 0 then exit;
  SQL := 'SELECT Count(HeatID) FROM  [SwimClubMeet2].[dbo].[Session] ' +
  'INNER JOIN [Event] ON [Session].SessionID = [Event].SessionID ' +
  'INNER JOIN [Heat] ON [Event].EventID = [Heat].EventID '
  + 'WHERE [Heat].HeatStatusID > 1 AND [Session].SessionID = :GetSessionID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aSessionID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function HasEvents(aSessionID: integer): Boolean;
var
  i: integer;
begin
  result := false;
  i := GetEventCount(aSessionID);
  if (i > 0) then result := true;
end;

procedure HideLocked(IsChecked: Boolean);
begin
  if (SCM.SCMActive) then
  begin
    SCMcore.qryLane.DisableControls;
    SCMcore.qryHeat.DisableControls;
    SCMcore.qryNominee.DisableControls;
    SCMcore.qryEvent.DisableControls;
    SCMcore.qrySession.DisableControls;
    SCMcore.qrySession.Close;
    SCMcore.qrySession.ParamByName('TOGGLE').AsBoolean := IsChecked;
    SCMcore.qrySession.Prepare;
    SCMcore.qrySession.Open;
    SCMcore.qrySession.EnableControls;
    SCMcore.qryEvent.EnableControls;
    SCMcore.qryNominee.EnableControls;
    SCMcore.qryHeat.EnableControls;
    SCMcore.qryLane.EnableControls;
  end;
end;

function IsLocked: Boolean;
begin
  result := true;
  if not SCM.SCMActive then exit;
  if SCMcore.dsSession.DataSet.Active then
    if not SCMcore.dsSession.DataSet.IsEmpty then
      if (SCMcore.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger <>
        2) then
        result := false;
end;

function IsLocked(aSessionID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := true;
  if not SCM.SCMActive then exit;
  if (aSessionID = 0) then exit;
  SQL := 'SELECT SessionStatusID FROM SwimClubMeet2.dbo.Session ' +
  'WHERE SessionID = :aID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aSessionID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v <> 2) then result := false;
end;

function Locate(SessionID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not SCM.SCMActive then exit;
  if (SessionID = 0) then exit;
  SearchOptions := [];
  if SCMcore.dsSession.DataSet.Active then
    result := SCMcore.dsSession.DataSet.Locate('SessionID', SessionID,
      SearchOptions);
end;

function PK(): integer;
begin // NO CHECKS. quick and dirty - primary key result.
  result := SCMcore.qrySession.FieldByName('SessionID').AsInteger;
end;

function IsEmptyLocked(): Boolean;
var
  b: boolean;
begin
  result := true;
  b := false;
  try
    if SCMcore.qrySession.IsEmpty then b := true;
    if SCMcore.qrySession.FieldByName('SessionStatusID').AsInteger = 2 then
      b := true;
  finally
    result := b;
  end;
end;

function IsEmptyLocked(SessionID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if SessionID = 0 then exit;
  SQL := '''
		SELECT SessionStatusID
		FROM [SwimClubMeet2].[dbo].[Session]
		WHERE [SessionID] = :ID';
		''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [SessionID]);
  if not VarIsClear(v) and (v = 2) then result := true;
end;

procedure SetSortIndex(idx: integer);
begin
  //  qrySession.Index
  SCMcore.qrySession.IndexesActive := false;
  case idx of
    1:
      begin
        SCMcore.qrySession.IndexesActive := true;
        SCMcore.qrySession.IndexName := 'idxStartDateDESC';
      end;
    2:
      begin
        SCMcore.qrySession.IndexesActive := true;
        SCMcore.qrySession.IndexName := 'idxStartDateASC';
      end
  else
    begin
      SCMcore.qrySession.IndexFieldNames := 'SwimClubID';
    end;
  end;
end;

function Start: TDateTime;
begin
  result := 0;
  if SCM.SCMActive and SCMcore.dsSession.DataSet.Active then
    if not SCMcore.dsSession.DataSet.IsEmpty then
      result :=
        SCMcore.dsSession.DataSet.FieldByName('SessionStart').AsDateTime;
end;

function Start(SessionID: integer): TDateTime;
var
  SQL: string;
  v: variant;
begin
  result := Date;
  if not SCM.SCMActive then exit;
  if SessionID = 0 then exit;
  SQL := 'SELECT SessionStart FROM SwimClubMeet2.dbo.Session ' +
  'WHERE SessionID = :aID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [SessionID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and not (v = 0) then result := v;
end;

procedure ToggleLockState;
var
  i: integer;
begin
  if not SCM.SCMActive then exit;
  with SCMcore.dsSession.DataSet do
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

end.

