unit uEvent;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, System.VarUtils,
  System.StrUtils,
  FireDAC.Comp.Client,
  vcl.Dialogs, Data.DB,
	dmSCMcore, dmSCM, SCMdefines;


function RenumberEvents(aSessionID: integer; DoLocate: Boolean = true;
DoExclude: Boolean = true): integer;


function DeleteDependants(aEventID: integer;  DoExclude: Boolean = true): integer;
function RenumberHeats(aEventID: integer; DoLocate: Boolean = true;
  DoExclude: Boolean = true): integer;


// EVENTS...
function AllHeatsAreClosed(aEventID: integer): Boolean;
procedure FNameEllipse(); // move out of uEvent to frame.
function GetEntrantCount(): integer; overload; // swimmers entered into lanes.
function GetEntrantCount(aEventID: integer): integer; overload;
function GetEventID: integer;
// EVENT TYPE...
// Current event - uses lookup field : luEventTypeID .
function GetEventType(): SCMDefines.scmEventType; overload;
// Calls SCM.scmConnection.ExecSQLScalar.
function GetEventType(aEventID: integer): SCMDefines.scmEventType; overload;
function GetHeatCount(aEventID: integer): integer;
// COUNT... using MSSQL Scalar functions.
function GetNomineeCount(): integer; overload;
  // members who nominated for event..
function GetNomineeCount(aEventID: integer): integer; overload;
function HasClosedHeats(aEventID: integer): Boolean;
function HasClosedOrRacedHeats(aEventID: integer): Boolean;
function HasNominee(EventID, MemberID: integer): Boolean;
function HasNominees(aEventID: integer): Boolean;
function HasRacedHeats(aEventID: integer): Boolean;
function Locate(aEventID: integer): Boolean; overload;
function Locate(aDistanceID, aStrokeID: integer): Boolean; overload;
function PK(): integer; // NO CHECKS. RTNS: Primary key.
function SessionIsLocked(aEventID: integer): Boolean;
function SetEventStatusID(aEventID, aEventStatusID: integer): Boolean;

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
	uHeat, uLane;

constructor T_Event.Create;
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

destructor T_Event.Destroy;
begin
  // do cleanup...
  inherited;
end;

// ----------------------------------------------------------------------



function RenumberEvents(aSessionID: integer; DoLocate: Boolean = true;
DoExclude: Boolean = true): integer;
var
  qry: TFDQuery;
  i, aEventID: integer;
  sl: TStringList;
  ds: TDataSet;
begin
  aEventID := 0;
  Result := 0;

	if SCMcore.dsEvent.DataSet.IsEmpty then exit;

	ds := SCMcore.dsEvent.DataSet;
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
end;

function DeleteDependants(aEventID: integer;	DoExclude: Boolean): integer;
var
  SQL: string;
  aSessionID: integer;
begin
	result := 0;
	if uEvent.SessionIsLocked(aEventID) then exit;
  aSessionID := 0;
  // D E L E T E   H E A T S and remove swimmer data.
  // (including Entrants, Teams, TeamEntrants, Splits, TeamSplits...)
  Heat_DeleteAll(aEventID, DoExclude);
  // ASSERT that all swimmer data has been removed.
	if (uEvent.GetEntrantCount(aEventID) = 0) or (DoExclude = false) then
  begin
    // D E L E T E   N O M I N A T I O N S .
    SQL := 'DELETE FROM dbo.Nominee WHERE Nominee.EventID = :ID';
    SCM.scmConnection.ExecSQL(SQL, [aEventID]);
  end;
  // ASSERT that all heats have been removed.
  if (uEvent.GetHeatCount(aEventID) = 0) or (DoExclude = false) then
  begin
    // FINALLY DELETE EVENT
    SCMcore.dsEvent.DataSet.DisableControls;
    SQL := 'DELETE FROM dbo.Event WHERE Event.EventID = :ID';
    result := SCM.scmConnection.ExecSQL(SQL, [aEventID]);
    SCMcore.dsEvent.DataSet.EnableControls;
    // Renumber events and locate to record.
    RenumberEvents(aSessionID,true);
  end;
end;

function RenumberHeats(aEventID: integer; DoLocate,
	DoExclude: Boolean): integer;
begin
  result := 0;
	if uEvent.PK = 0 then exit;
	if uEvent.SessionIsLocked(aEventID) then exit;
	result := uHeat.RenumberHeats(aEventID, DoLocate);
end;



function AllHeatsAreClosed(aEventID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if aEventID = 0 then exit;
  if GetHeatCount(aEventID) = 0 then exit; // NO HEATS.
  SQL := 'SELECT COUNT(HeatStatusID) FROM SwimClubMeet2.dbo.Heat ' +
  'WHERE (EventID = :GetEventID ) AND (HeatStatusID < 3)';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aEventID]);
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
  SCMcore.qrySession.FieldByName('SessionID').AsInteger;
  ds.ParamByName('EVENTID').AsInteger := SCMcore.qryEvent.FieldByName('EventID')
  .AsInteger;
  ds.ParamByName('DISTANCEID').AsInteger := SCMcore.qryEvent.FieldByName
  ('DistanceID').AsInteger;
  ds.ParamByName('STROKEID').AsInteger := SCMcore.qryEvent.FieldByName
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
  if SCMcore.qryEvent.IsEmpty then exit;
  EventID := SCMcore.qryEvent.FieldByName('EventID').AsInteger;
  if EventID = 0 then exit;
  SQL := 'SELECT SwimClubMeet2.dbo.EntrantCount(:GetEventID);';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [EventID]);
  if not VarIsClear(v) then result := v;
end;

function GetEntrantCount(aEventID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if aEventID = 0 then exit;
  // scalar function to count Swimmers (inc. Entrants + TeamEntrants)
  SQL := 'SELECT dbo.EntrantCount(:ID1) ' +
  'FROM SwimClubMeet2.dbo.Event WHERE Event.EventID = :ID2';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aEventID, aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function GetEventID: integer;
begin
  result := 0;
  if SCM.SCMActive and SCMcore.dsEvent.DataSet.Active then
    if not SCMcore.dsEvent.DataSet.IsEmpty then
      result := SCMcore.dsEvent.DataSet.FieldByName('EventID').AsInteger;
end;

function GetEventType(): SCMDefines.scmEventType;
var
  v: variant;
begin
  result := SCMDefines.scmEventType.etUnknown; // Default.
  if SCMcore.qryEvent.IsEmpty then exit; // Table is empty.
  v := SCMcore.qryEvent.FieldByName('luEventTypeID').AsVariant;
  if VarIsNull(v) or VarIsEmpty(v) or (v = 0) then exit;
  case v of
    1: result := SCMDefines.scmEventType.etINDV;
    2: result := SCMDefines.scmEventType.etTEAM;
  end;
end;

function GetEventType(aEventID: integer): SCMDefines.scmEventType;
var
  v: variant;
  SQL: string;
begin
  result := SCMDefines.etUnknown;
  if SCM.SCMActive and SCMcore.dsEvent.DataSet.Active then
  begin
    if not SCMcore.dsEvent.DataSet.IsEmpty then
    begin
      SQL := '''
				SELECT [Distance].[EventTypeID] FROM [SwimClubMeet2].[dbo].[Event]
				INNER JOIN [Distance] ON [Event].[DistanceID] = [Distance].[DistanceID]
				WHERE EventID = :GetEventID;
				''';
      v := SCM.scmConnection.ExecSQLScalar(SQL, [aEventID]);
      if VarIsNull(v) or VarIsEmpty(v) or (v = 0) then exit;
    end;
    case v of
      1: result := SCMDefines.etINDV;
      2: result := SCMDefines.etTEAM;
    end;
  end;
end;

function GetHeatCount(aEventID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if aEventID = 0 then exit;
  SQL := 'SELECT Count(Heat.HeatID) FROM SwimClubMeet2.dbo.[Event] ' +
  'INNER JOIN Heat ON [Event].EventID = Heat.EventID ' +
  'WHERE Event.EventID = :EventID;';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function GetNomineeCount: integer;
var
  v: variant;
  SQL: string;
  EventID: integer;
begin
  result := 0;
  if SCMcore.qryEvent.IsEmpty then exit;
  EventID := SCMcore.qryEvent.FieldByName('EventID').AsInteger;
  if EventID = 0 then exit;
  SQL := 'SELECT SwimClubMeet2.dbo.NomineeCount(:GetEventID);';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [EventID]);
  if not VarIsClear(v) then result := v;
end;

function GetNomineeCount(aEventID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not SCM.SCMActive then exit;
  if aEventID = 0 then exit;
  // scalar function to count Nominees
  SQL := 'SELECT dbo.NomineeCount(:ID1) FROM SwimClubMeet2.dbo.[Event] ' +
  'WHERE Event.EventID = :ID2';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aEventID, aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function HasClosedHeats(aEventID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  // count the closed heats.
  SQL := 'SELECT Count([Heat].[HeatID]) FROM [SwimClubMeet2].[dbo].[Event] '
  + 'INNER JOIN Heat ON Event.EventID = Heat.EventID ' +
  'WHERE Event.EventID = :GetEventID AND (Heat.HeatStatusID = 3) ';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function HasClosedOrRacedHeats(aEventID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if GetHeatCount(aEventID) = 0 then exit;
  SQL := ' SELECT Count([Heat].[HeatID]) FROM [SwimClubMeet2].[dbo].[Event] '
  + 'INNER JOIN Heat ON Event.EventID = Heat.EventID ' +
  'WHERE Event.EventID = :GetEventID AND (Heat.HeatStatusID > 1) ';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function HasNominee(EventID, MemberID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;

  SQL := '''
		SELECT COUNT(Nominee.NomineeID) FROM SwimClubMeet2.dbo.Nominee
		WHERE [MemberID] = :ID1 AND [EventID] = :ID2
		''';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [MemberID, EventID]);
  if not VarIsClear(v) then
    if (v > 0) then result := true;
end;

function HasNominees(aEventID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  SQL := 'SELECT COUNT(NomineeID) FROM SwimClubMeet2.dbo.Nominee ' +
  'WHERE Nominee.EventID = :GetEventID AND MemberID IS NOT NULL; ';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function HasRacedHeats(aEventID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false; // DEFAULT - no raced heats
  // count the raced heats.
  SQL := 'SELECT Count([Heat].[HeatID]) FROM [SwimClubMeet2].[dbo].[Event] '
  + 'INNER JOIN Heat ON Event.EventID = Heat.EventID ' +
  'WHERE Event.EventID = :GetEventID AND (Heat.HeatStatusID = 2) ';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function Locate(aEventID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if (aEventID = 0) then exit;
  SearchOptions := [];
  if SCMcore.dsEvent.DataSet.Active then
    result := SCMcore.dsEvent.DataSet.Locate('EventID', aEventID,
      SearchOptions);
end;

function Locate(aDistanceID, aStrokeID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  SearchOptions := [];
  if SCMcore.dsEvent.DataSet.Active then
    result := SCMcore.dsEvent.DataSet.Locate('DistanceID;StrokeID',
      VarArrayOf([aDistanceID, aStrokeID]), SearchOptions);
end;

function PK(): integer;
begin // NO CHECKS. quick and dirty - primary key result.
  result := SCMcore.qryEvent.FieldByName('EventID').AsInteger;
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

function SetEventStatusID(aEventID, aEventStatusID: integer)
: Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if aEventID = 0 then exit;
  if SessionIsLocked(aEventID) then exit;
  if (aEventStatusID <> 1) or (aEventStatusID <> 2) then exit;
  SQL := 'UPDATE SwimClubMeet2.dbo.Event SET [Event].[EventStatusID] = :ID1 ' +
  'WHERE [Event].[EventID] = :ID2';
  v := SCM.scmConnection.ExecSQL(SQL, [aEventStatusID, aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) then
    if (v > 0) then result := true;
end;

end.

