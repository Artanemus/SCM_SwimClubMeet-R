unit uLane;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, System.VarUtils,
  System.StrUtils,
  vcl.Dialogs, Data.DB,
  dmCORE, dmSCM, SCMdefines,
	FireDAC.Comp.Client;

  function Assert(): boolean;
  function ClearLane(DoExclude: Boolean = true): boolean;
	function StrikeLane(DoExclude: Boolean = true): boolean;
  function DeleteRecord(DoExclude: Boolean = true): boolean;
  function GetLaneID(): integer; // SAFE.
  function NewRecord: integer;
  function LastLaneNum: integer;
  function Locate(aLaneID: integer): Boolean;
	function LocateNominee(aNomineeID: integer): boolean;
	function LocateTeam(aTeamID: integer): boolean;
  function PK(): integer; // NO CHECKS. RTNS: Primary key.
  function MoveDownLane(ADataSet: TDataSet): Boolean;
  function MoveUpLane(ADataSet: TDataSet): Boolean;

  function DeleteSplit(aSplitTimeID: integer; DoExclude: Boolean = true): integer;
  function DeleteAllSplits(DoExclude: Boolean = true): integer;
  function DeleteWatch(aSplitTimeID: integer; DoExclude: Boolean = true): integer;
  function DeleteAllWatches(DoExclude: Boolean = true): integer;


type
  T_Lane = class
  public
    constructor Create;
    destructor Destroy;
  end;

var
  scmLane: T_Lane;

implementation

uses
 uSwimClub, uSession, uEvent, uHeat, uTeam;

constructor T_Lane.Create;
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

destructor T_Lane.Destroy;
begin
  // do cleanup...
  inherited;
end;


function Assert: Boolean;
begin
  result := false;
  if Assigned(CORE) then
    if CORE.qryLane.Active then
      if not CORE.qryLane.IsEmpty then
        result := true;
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
  // Can't delete this lane if it's be raced or closed.
  if (uHeat.HeatStatusID() = 1) or (DoExclude = false) then
  begin
    CORE.qryLane.DisableControls;
    try
      // D E L E T E   WATCH-TIMES...............................
      CORE.qryWatchTime.DisableControls;
      CORE.qryWatchTime.ApplyMaster; // ASSERT MASTER-DETAILED.
      try
        // Only DeleteRecord nominations if no heats exist.
        SQL :=
          'Delete FROM SwimClubMeet2.dbo.WatchTime WHERE WatchTime.LaneID = :ID';
        SCM.scmConnection.ExecSQL(SQL, [uLane.PK]);
        CORE.qryWatchTime.ApplyMaster; // ASSERT MASTER-DETAILED.
      finally
        CORE.qryWatchTime.EnableControls;
      end;
      // D E L E T E   SPLIT-TIMES...............................
      CORE.qrySplitTime.DisableControls;
      CORE.qrySplitTime.ApplyMaster; // ASSERT MASTER-DETAILED.
      try
        // Only DeleteRecord nominations if no heats exist.
        SQL :=
          'Delete FROM SwimClubMeet2.dbo.SplitTime WHERE SplitTime.LaneID = :ID';
        SCM.scmConnection.ExecSQL(SQL, [uLane.PK]);
        CORE.qrySplitTime.ApplyMaster; // ASSERT MASTER-DETAILED.
      finally
        CORE.qrySplitTime.EnableControls;
      end;
      // F I N A L L Y   D E L E T E   L A N E .
      try
        CORE.qryLane.Delete;
        result := true;
      except on E: Exception do
          // handle error
      end;
    finally
      // if required, renumbering of heats is handled by caller.
      CORE.qryLane.EnableControls;
    end;
  end;
end;


function GetLaneID(): integer;
begin
  result := 0;
  if uLane.Assert then
      result := CORE.qryLane.FieldByName('LaneID').AsInteger;
end;

function ClearLane(DoExclude: Boolean = true): boolean;
begin
  result := false;
  if uSession.IsLocked() then exit;
  if (uHeat.HeatStatusID() = 1) or (DoExclude = false) then
  begin
    try
      CORE.qryLane.DisableControls;
      try
        CORE.qryLane.Edit;
        CORE.qryLane.FieldByName('TeamID').Clear;
        CORE.qryLane.FieldByName('NomineeID').Clear;
        CORE.qryLane.Post;
        result := true;
      except on E: Exception do
        CORE.qryLane.Cancel;
      end;
    finally
      CORE.qryLane.EnableControls;
    end;
  end;
end;

function StrikeLane(DoExclude: Boolean = true): boolean;
var
  SQL: string;
  recCount, aTeamID, aNomineeID: integer;
begin
  result := false;
  if uSession.IsLocked() then exit;
  if (uHeat.HeatStatusID() = 1) or (DoExclude = false) then
  begin
    // dbo.Lane.TeamID must be cleared before the teamlink can be removed.
    // dbo.Lane.NomineeID must be cleared before nominee can be removed.
    aTeamID := CORE.qryLane.FieldByName('TeamID').AsInteger; // store param
    aNomineeID := CORE.qryLane.FieldByName('NomineeID').AsInteger; // store param
    uLane.ClearLane(DoExclude); // NULL fields TeamID and NomineeID.
    if aNomineeID <> 0 then
    begin // delete nomination record.
      SQL := '''
        DELETE FROM SwimClubMeet2.dbo.Nominee
        WHERE NomineeID = :ID1 AND EventID = :ID2';
        ''';
      recCount := SCM.scmConnection.ExecSQL( SQL,[aNomineeID, uEvent.PK()] );
    end;
    if aTeamID <> 0 then // Deletes dbo.teamlink and removes nominee from dbo.Nominee.
      uTeam.StrikeTeam(aTeamID, DoExclude);
  end;
end;

function DeleteAllSplits(DoExclude: Boolean = true): integer;
var
SQL: string;
begin
  result := 0;
  if Assigned(SCM) and SCM.scmConnection.Connected then
  begin
    if uSession.IsLocked() then exit;
    if (uHeat.HeatStatusID() = 1) or (DoExclude = false) then
    begin
      CORE.qryLane.ApplyMaster;
      try
        CORE.qryLane.DisableControls;
        SQL := '''
          DELETE FROM SwimClubMeet2.dbo.SplitTimes
          WHERE [SplitTimes].[LaneID] = :ID;
          ''';
        SCM.scmConnection.ExecSQL(SQL, [uLane.PK()]);
      finally
        CORE.qryLane.EnableControls;
      end;
    end;
  end;
end;

function DeleteSplit(aSplitTimeID: integer; DoExclude: Boolean = true): integer;
var
SQL: string;
begin
  result := 0;
  if Assigned(SCM) and SCM.scmConnection.Connected then
  begin
    if uSession.IsLocked() then exit;
    if (uHeat.HeatStatusID() = 1) or (DoExclude = false) then
    begin
      CORE.qrySplitTime.ApplyMaster;
      try
        CORE.qrySplitTime.DisableControls;
        SQL := '''
          DELETE FROM SwimClubMeet2.dbo.SplitTimes
          WHERE [SplitTimes].[SplitTimeID] = :ID AND [SplitTimes].[LaneID] = :ID;
          ''';
        result := SCM.scmConnection.ExecSQL(SQL, VarArrayOf([aSplitTimeID, uLane.PK()]));
      finally
        CORE.qrySplitTime.EnableControls;
      end;
    end;
  end;
end;

function NewRecord: integer;
var
  aLaneNum: integer;
  SQL: string;
begin
  // NOTE: if renumbering is needed, this must be done by caller.
  result := 0;
  aLaneNum := LastLaneNum();
  if aLaneNum < uSwimClub.NumberOfLanes then
  begin
    Inc(aLaneNum);
    try
      CORE.qryLane.DisableControls;
      try
        CORE.qryLane.Insert;
        CORE.qryLane.FieldByName('HeatID').AsInteger := uHeat.PK();
        CORE.qryLane.FieldByName('LaneNum').AsInteger := aLaneNum;
        CORE.qryLane.FieldByName('IsDisqualified').AsBoolean := false;
        CORE.qryLane.FieldByName('IsScratched').AsBoolean := false;
        CORE.qryLane.FieldByName('TeamID').Clear;
        CORE.qryLane.FieldByName('NomineeID').Clear;
        CORE.qryLane.Post;
      except on E: Exception do
        CORE.qryLane.Cancel;
      end;
    finally
      CORE.qryLane.EnableControls;
    end;
  end;
end;

function LastLaneNum: integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not Assigned(SCM) and SCM.IsActive then exit;
  SQL := 'SELECT MAX(Lane) FROM SwimClubMeet2.dbo.Lane ' +
  'WHERE Lane.LaneID = :ID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [uLane.PK()]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function Locate(aLaneID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  SearchOptions := [];
  if Assigned(CORE) and CORE.dsLane.DataSet.Active then
  begin
    CORE.qryWatchTime.DisableControls;
    CORE.qrySplitTime.DisableControls;
    CORE.qryLane.DisableControls;
    try
      result := CORE.qryLane.Locate('LaneID', aLaneID, SearchOptions);
      if result then 
      begin
        CORE.qryWatchTime.ApplyMaster;
        CORE.qrySplitTime.ApplyMaster;
      end;
    finally
      CORE.qryLane.EnableControls;
      CORE.qrySplitTime.EnableControls;
      CORE.qryWatchTime.EnableControls;
    end;   
  end;
end;

function LocateNominee(aNomineeID: integer): boolean;
var
  SearchOptions: TLocateOptions;
  found: boolean;
  SQL: string;
  v: variant;
begin
  result := false;
  SearchOptions := [];
  if Assigned(CORE) and CORE.dsLane.DataSet.Active then
  begin
    CORE.qryWatchTime.DisableControls;
    CORE.qrySplitTime.DisableControls;
    CORE.qryLane.DisableControls;
    try
      result := CORE.qryLane.Locate('NomineeID', aNomineeID, SearchOptions);
      if result then
      begin
        CORE.qryWatchTime.ApplyMaster;
        CORE.qrySplitTime.ApplyMaster;
      end;
    finally
      CORE.qryLane.EnableControls;
      CORE.qrySplitTime.EnableControls;
      CORE.qryWatchTime.EnableControls;
    end;
  end;
end;

function LocateTeam(aTeamID: integer): boolean;
var
  SearchOptions: TLocateOptions;
  found: boolean;
  SQL: string;
  v: variant;
begin
  result := false;
  SearchOptions := [];
  if Assigned(CORE) and CORE.dsLane.DataSet.Active then
  begin
    CORE.qryWatchTime.DisableControls;
    CORE.qrySplitTime.DisableControls;
    CORE.qryLane.DisableControls;
    try
      result := CORE.qryLane.Locate('TeamID', aTeamID, SearchOptions);
      if result then
      begin
        CORE.qryWatchTime.ApplyMaster;
        CORE.qrySplitTime.ApplyMaster;
      end;
    finally
      CORE.qryLane.EnableControls;
      CORE.qrySplitTime.EnableControls;
      CORE.qryWatchTime.EnableControls;
    end;
  end;
end;

function PK(): integer;
begin // NO CHECKS. quick and dirty - primary key result.
  result := CORE.qryLane.FieldByName('LaneID').AsInteger;
end;

function MoveDownLane(ADataSet: TDataSet): Boolean;
begin
  result := SCM.MoveDownLane(ADataSet);
end;

function MoveUpLane(ADataSet: TDataSet): Boolean;
begin
  result := SCM.MoveUpLane(ADataSet);
end;





end.

