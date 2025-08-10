unit uHeat;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, System.VarUtils,
  System.StrUtils,
  vcl.Dialogs, Data.DB,
  dmCORE, dmSCM, SCMdefines,
	FireDAC.Comp.Client;


function Assert: boolean;
function ClearLanes(DoExclude: Boolean = true): integer;
function CountLanes: integer;
function DeleteRecord(DoExclude: Boolean = true): boolean;
function GetHeatID: integer; // SAFE.
function HeatStatusID: integer;
function IsClosed(): Boolean; // current heat
function IsRaced(): Boolean; // current heat
function Locate(aHeatID: integer): Boolean;
function NextID(aHeatID: integer): integer; // uses HeatNum
function PK(): integer; // NO CHECKS. RTNS: Primary key.
function PrevID(aHeatID: integer): integer; // uses HeatNum
function RenumberLanes(DoExclude: Boolean = true): integer;
procedure NewRecord();
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
	uSwimClub, uSession, uEvent, uLane;


constructor T_Heat.Create;
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

destructor T_Heat.Destroy;
begin
  // do cleanup...
  inherited;
end;

function Assert(): boolean;
begin
  result := false;
  if Assigned(CORE) then
    if CORE.qryHeat.Active then
      if not CORE.qryHeat.IsEmpty then
        result := true;
end;

function ClearLanes(DoExclude: Boolean = true): integer;
var
  aHeatStatusID: integer;
begin
  result := 0;
  if not SCM.IsActive then exit;
  if uSession.IsLocked then exit;
  aHeatStatusID := uHeat.HeatStatusID();
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    ;
  end;
end;

function CountLanes: integer;
var
  SQL: string;
  v: variant;
  aEventType: scmEventType;
begin
  result := 0;
  // Count number of lanes ....
  SQL := 'SELECT Count(LaneID) FROM SwimClubMeet2.dbo.Lane WHERE Lane.HeatID = :ID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uHeat.PK]);
  if not VarIsNull(v) or not VarIsEmpty(v) then result := v;
end;

function DeleteRecord(DoExclude: Boolean = true): boolean;
var
  SQL: string;
  done, doRenumber: boolean;
begin
  result := false;
  doRenumber := false;
  // Not permitted to DeleteRecord events if session is locked.
  if uSession.IsLocked() then exit;

  // Can't delete this heat if it's be raced or closed.
  // UNLESS DoExclude is false... (default value is true).

  //  if (uHeat.HeatStatusID() in [2,3]) or (DoExclude) then exit;

  if (uHeat.HeatStatusID() = 1) or (DoExclude = false) then
  begin

    //if (uHeat.HeatStatusID() = 1) or (DoExclude = false) then
    CORE.qryLane.DisableControls;
    try
      // D E L E T E   L A N E S .
      CORE.qryLane.ApplyMaster;  // ASSERT MASTER-DETAILED.
      CORE.qryLane.First;
      while not eof do
      begin
        // D E L E T E   WATCH-TIMES...............................
        CORE.qryWatchTime.DisableControls;
        CORE.qryWatchTime.ApplyMaster; // ASSERT MASTER-DETAILED.
        try
          // Only DeleteRecord nominations if no heats exist.
          SQL := 'Delete FROM SwimClubMeet2.dbo.WatchTime WHERE WatchTime.LaneID = :ID';
          SCM.scmConnection.ExecSQL(SQL, [uLane.PK]);
          CORE.qryWatchTime.ApplyMaster;  // ASSERT MASTER-DETAILED.
        finally
          CORE.qryWatchTime.EnableControls;
        end;
        // D E L E T E   SPLIT-TIMES...............................
        CORE.qrySplitTime.DisableControls;
        CORE.qrySplitTime.ApplyMaster; // ASSERT MASTER-DETAILED.
        try
          // Only DeleteRecord nominations if no heats exist.
          SQL := 'Delete FROM SwimClubMeet2.dbo.SplitTime WHERE SplitTime.LaneID = :ID';
          SCM.scmConnection.ExecSQL(SQL, [uLane.PK]);
          CORE.qrySplitTime.ApplyMaster;  // ASSERT MASTER-DETAILED.
        finally
          CORE.qrySplitTime.EnableControls;
        end;

        // F I N A L L Y   D E L E T E   L A N E .
        done := uLane.DeleteRecord(true);
        if done then
        begin
          doRenumber := true;
          continue;
        end
        else CORE.qryLane.Next;
      end;

      // ASSERT that all heats have been removed within Master-Detail relationship.
      // Can't delete remaining dependants if heats are retained.
      if (CORE.qryLane.IsEmpty) then
      begin
        // F I N A L L Y   DELETE THE HEAT..
        CORE.qryHeat.Delete;
        result := true;
      end
      else
      begin
        if doRenumber then // caller handles renumbering of lanes.
          uHeat.RenumberLanes(false);
      end;

    finally
      // if required, renumbering of heats is handled by caller.
      CORE.qryLane.EnableControls;
    end;
  end;
end;

function GetHeatID: integer;
begin
  result := 0;
  if uHeat.Assert then
      result := CORE.qryLane.FieldByName('HeatID').AsInteger;
end;

function HeatStatusID: integer;
begin
  result := 0;
  if uSession.Assert then
    result := CORE.qryHeat.FieldByName('HeatStatusID').AsInteger;
end;

function IsClosed: Boolean;
var
  HeatStatusID: integer;
begin
  result := false;
  HeatStatusID := CORE.qryHeat.FieldByName('HeatStatusID').AsInteger;
  if (HeatStatusID = 3) or (HeatStatusID = 0) then result := true;
end;

function IsRaced: Boolean;
var
  HeatStatusID: integer;
begin
  result := false;
  HeatStatusID := CORE.qryHeat.FieldByName('HeatStatusID').AsInteger;
  if (HeatStatusID = 2) then result := true;
end;

function Locate(aHeatID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if (aHeatID = 0) then exit;
  SearchOptions := [];
  if Assigned(CORE) and CORE.qryHeat.Active then
    result := CORE.qryHeat.Locate('HeatID', aHeatID, SearchOptions);
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

function PK(): integer;
begin // NO CHECKS. quick and dirty - primary key result.
  result := CORE.qryHeat.FieldByName('HeatID').AsInteger;
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

function RenumberLanes(DoExclude: Boolean = true): integer;
var
  SQL: string;
  qry: TFDQuery;
  aEventType: scmEventType;
  i, lane, NumOfPoolLanes: integer;
begin
(*
  result := 0;
  i := 0;
  if not SCM.IsActive then exit;
  if aHeatID = 0 then exit;
  aEventType := Heat_EventType(aHeatID);
  if (aEventType = etUnknown) then exit;

  {If lane count is erroneous run repair routine instead.}
  if uLane.CountLanes(aHeatID) <> uSwimClub.NumberOfLanes then
  begin
    result := uLane.RepairLanes(aHeatID);
    exit;
  end;

  qry := TFDQuery.Create(self);
  qry.Connection := SCM.scmConnection;

  { See notes in RepairLanes for an explaination on SQL }
  if (aEventType = etINDV) then
  begin
    SQL := 'SELECT Entrant.TimeToBeat, CASE ' +
      'WHEN (Entrant.MemberID IS NULL) THEN 2 ' +
      'WHEN (CAST(CAST(Entrant.TimeToBeat AS DATETIME) AS FLOAT) = 0) THEN 1 ' +
      'ELSE 0 END AS mySort, Entrant.Lane, Entrant.EntrantID ' +
      'FROM Entrant WHERE Entrant.HeatID = :HEATID ' +
      'ORDER BY mySort, TimeToBeat ';
      qry.SQL.Text := SQL;
      qry.UpdateOptions.KeyFields := 'EntrantID';
      qry.UpdateOptions.UpdateTableName := 'SwimClubMeet2..Entrant';
  end
  else
  begin
    SQL := 'SELECT Team.TimeToBeat, CASE ' +
      'WHEN (Team.TeamNameID IS NULL) THEN 2 ' +
      'WHEN (CAST(CAST(Team.TimeToBeat AS DATETIME) AS FLOAT) = 0) THEN 1 ' +
      'ELSE 0 END AS mySort, Team.Lane, Team.TeamID ' +
      'FROM Team WHERE Team.HeatID = :HEATID ' +
      'ORDER BY mySort, TimeToBeat ';
      qry.SQL.Text := SQL;
      qry.UpdateOptions.KeyFields := 'TeamID';
      qry.UpdateOptions.UpdateTableName := 'SwimClubMeet2..Team';
  end;

  NumOfPoolLanes := SwimClub_NumberOfLanes;

  if (aEventType = etINDV) then CORE.dsLane.DataSet.DisableControls
  else CORE.dsTeam.DataSet.DisableControls;

  qry.IndexFieldNames := 'mySort;TimeToBeat';
  qry.ParamByName('HEATID').AsInteger := aHeatID;
  qry.Prepare;
  qry.Open;
  if qry.Active then
  begin
    i := 0; // NOTE: ScatterLanes is based 0
    while not qry.Eof do
    begin
      lane := SCMUtility.ScatterLanes(i, NumOfPoolLanes);
      qry.Edit;
      qry.FieldByName('Lane').AsInteger := lane;
      qry.Post;
      i := i + 1;
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;

  if (aEventType = etINDV) then CORE.dsLane.DataSet.EnableControls
  else CORE.dsTeam.DataSet.EnableControls;
*)
  result := i;
end;

procedure NewRecord;
var
  fld: TField;
begin
  if CORE.dsEvent.DataSet.IsEmpty then exit;
  // 3.10.2020
  with CORE.qryHeat do
  begin
    DisableControls();
    fld := CORE.qryHeat.FindField('HeatNum');
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

procedure ToggleStatus;
var
  //  bm: TBookMark;
  i, aHeatID: integer;
begin
  with CORE.qryHeat do
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

