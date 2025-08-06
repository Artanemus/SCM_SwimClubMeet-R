unit uHeat;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, System.VarUtils,
  System.StrUtils,
  vcl.Dialogs, Data.DB,
  dmSCMcore, dmSCM, SCMdefines,
	FireDAC.Comp.Client;

		{ H E A T .    }
    function Heat_ClearLanes(aHeatID: integer;  DoExclude: Boolean = true): integer;
    function Heat_Delete(aHeatID: integer;  DoExclude: Boolean = true): integer;
    function Heat_DeleteAll(aEventID: integer;  DoExclude: Boolean = true): integer;


function EventID(aHeatID: integer): integer;
function EventType(aHeatID: integer): scmEventType;
function EventTypeID(aHeatID: integer): integer;
function HeatStatusID(aHeatID: integer): integer;
function GetHeatID: integer;
function IsClosed(): Boolean; // current heat
function IsRaced(): Boolean; // current heat
function Locate(aHeatID: integer): Boolean;
function PK(): integer; // NO CHECKS. RTNS: Primary key.
procedure NewRecord();
function NextID(aHeatID: integer): integer; // uses HeatNum
function PrevID(aHeatID: integer): integer; // uses HeatNum
function SessionIsLocked(aHeatID: integer): Boolean;
procedure ToggleStatus(); // current heat

type
  T_Heat = class
  public
    constructor Create;
    destructor Destroy;
  end;

var
  scmHeat: T_Heat;

implementation

uses
	uLane;


constructor T_Heat.Create;
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

destructor T_Heat.Destroy;
begin
  // do cleanup...
  inherited;
end;


function RenumberHeats(aEventID: integer; DoLocate: Boolean = true): integer;
// RENUMBER HEAT NUMBER HeatNum
// ..................................................
var
  qry: TFDQuery;
  i, aHeatID: integer;
  s: String;
begin
  result := 0;
  if not fSCMActive then exit;
  if SCMcore.dsHeat.DataSet.IsEmpty then exit;
  result := 0;
  aHeatID := 0;
  SCMcore.dsHeat.DataSet.DisableControls;
  // used later to cue-to-heat after renumber
  if (DoLocate) then aHeatID := SCMcore.dsHeat.DataSet.FieldByName('HeatID').AsInteger;
  // gather all the heats in the current event
  s := 'SELECT [HeatID], [HeatNum] FROM [dbo].[Heat] ';
  s := s + 'WHERE EventID = :EVENTID ORDER BY [HeatNum]';
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := s;
  qry.UpdateOptions.KeyFields := 'HeatID';
  qry.UpdateOptions.UpdateTableName := 'SwimClubMeet2..Heat';
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
    if (i > 1) then result := i - 1;
  end;
  qry.Close;
  qry.Free;
  // RE-QUERY :: RELOAD DATA.
  SCMcore.dsHeat.DataSet.Refresh;
  // Queue to original selected entrant ...
  if (DoLocate) then Heat_Locate(aHeatID);
	SCMcore.dsHeat.DataSet.EnableControls;
end;



function Heat_ClearLanes(aHeatID: integer;
	DoExclude: Boolean = true): integer;
var
  aHeatStatusID: integer;
begin
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
      ClearLanes(aHeatID);
end;

function Heat_Delete(aHeatID: integer; DoExclude: Boolean): integer;
var
  aHeatStatusID: integer;
begin
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    result := DeleteHeat(aHeatID);
  end;
end;

function Heat_DeleteAll(aEventID: integer;
	DoExclude: Boolean): integer;
var
  aHeatStatusID, aHeatID: integer;
  qry: TFDQuery;
begin
  result := 0;
  if not SCMActive then exit;
  if aEventID = 0 then exit;
  if Event_SessionIsLocked(aEventID) then exit;
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
      aHeatStatusID := Heat_HeatStatusID(aHeatID);
      if (aHeatStatusID = 1) or (DoExclude = false) then
        DeleteHeat(aHeatID);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
end;



function EventID(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if aHeatID = 0 then exit;
  SQL := 'SELECT EventID FROM SwimClubMeet2.dbo.Heat ' +
  'WHERE HeatID = :GetHeatID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) or not VarIsEmpty(v) then result := v;

end;

function EventType(aHeatID: integer): scmEventType;
begin
  case EventTypeID(aHeatID) of
    1: result := etINDV;
    2: result := etTEAM;
  else
    result := etUnknown;
  end;
end;

function EventTypeID(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  SQL := 'SELECT EventTypeID FROM  [SwimClubMeet2].[dbo].[Heat] ' +
  'INNER JOIN [Event] ON [Heat].[EventID] = [Event].[EventID] ' +
  'INNER JOIN [Distance] ON [Event].[DistanceID] = [Distance].[DistanceID] ' +
  'WHERE [Heat].HeatID = :GetHeatID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) or not VarIsEmpty(v) or (v > 0) then result := v;
end;

function HeatStatusID(aHeatID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  SQL := 'SELECT [HeatStatusID] FROM [SwimClubMeet2].[dbo].[Heat] ' +
  ' WHERE [Heat].HeatID = :GetHeatID;';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function GetHeatID: integer;
begin
  result := 0;
  if SCM.SCMActive and SCMcore.dsHeat.DataSet.Active then
    if not SCMcore.dsHeat.DataSet.IsEmpty then
      result := SCMcore.dsHeat.DataSet.FieldByName('HeatID').AsInteger;
end;

function IsClosed: Boolean;
var
  HeatStatusID: integer;
begin
  result := false;
  HeatStatusID := SCMcore.dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger;
  if (HeatStatusID = 3) or (HeatStatusID = 0) then result := true;
end;

function IsRaced: Boolean;
var
  HeatStatusID: integer;
begin
  result := false;
  HeatStatusID := SCMcore.dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger;
  if (HeatStatusID = 2) then result := true;
end;

function Locate(aHeatID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if (aHeatID = 0) then exit;
  SearchOptions := [];
  if SCMcore.dsHeat.DataSet.Active then
    result := SCMcore.dsHeat.DataSet.Locate('HeatID', aHeatID, SearchOptions);
end;

function PK(): integer;
begin // NO CHECKS. quick and dirty - primary key result.
  result := SCMcore.qryHeat.FieldByName('HeatID').AsInteger;
end;

procedure NewRecord;
var
  fld: TField;
begin
  if SCMcore.dsEvent.DataSet.IsEmpty then exit;
  // 3.10.2020
  with SCMcore.dsHeat.DataSet do
  begin
    DisableControls();
    fld := SCMcore.qryHeat.FindField('HeatNum');
    if Assigned(fld) then fld.ReadOnly := false;
    // creating a heat results in empty lanes being spawned
    // and HeatNum calculated, HeatType initialized, etc
    Insert;
    Post;
    // 3.10.2020
    if Assigned(fld) then fld.ReadOnly := true;
    EnableControls();
    // Then in qryHeatNewRecord TMessage SCM_RENUMBERHEATS
  end;
end;

function NextID(aHeatID: integer): integer;
begin
  result := 0;
  // get the next heat in the event  (uses HeatNum)
  SCM.qryGetNextHeat.Connection := SCM.scmConnection;
  SCM.qryGetNextHeat.ParamByName('HEATID').AsInteger := aHeatID;
  SCM.qryGetNextHeat.Prepare;
  SCM.qryGetNextHeat.Open;
  if SCM.qryGetNextHeat.Active and (SCM.qryGetNextHeat.RecordCount > 0) then
    result := SCM.qryGetNextHeat.FieldByName('HeatID').AsInteger;
end;

function PrevID(aHeatID: integer): integer;
begin
  result := 0;
  // get the previuos heat in the event  (uses HeatNum)
  SCM.qryGetPrevHeat.Connection := SCM.scmConnection;
  SCM.qryGetPrevHeat.ParamByName('HEATID').AsInteger := aHeatID;
  SCM.qryGetPrevHeat.Prepare;
  SCM.qryGetPrevHeat.Open;
  if SCM.qryGetPrevHeat.Active and (SCM.qryGetPrevHeat.RecordCount > 0) then
    result := SCM.qryGetPrevHeat.FieldByName('HeatID').AsInteger;
end;

function SessionIsLocked(aHeatID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet2].[dbo].[Session] ' +
  'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
  'INNER JOIN [Heat] ON [Event].[EventID] = [Heat].[EventID] '
  + 'WHERE [Heat].[HeatID] = :GetHeatID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [aHeatID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
end;

procedure ToggleStatus;
var
  //  bm: TBookMark;
  i, aHeatID: integer;
begin
  with SCMcore.dsHeat.DataSet do
  begin
    DisableControls;
    CheckBrowseMode;
    aHeatID := GetHeatID;
    //    bm := GetBookmark;
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
          FieldByName('CloseDT').AsDateTime := Now;
        end;
    else
      // toggle to OPEN ...
      FieldByName('HeatStatusID').AsInteger := 1;
    end;
    Post;
    Refresh;
    try
      uHeat.Locate(aHeatID);
      //      GotoBookmark(bm);
    finally
      EnableControls;
    end;
  end;
end;

end.

