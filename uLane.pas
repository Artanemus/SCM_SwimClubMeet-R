unit uLane;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, System.VarUtils,
  System.StrUtils,
  vcl.Dialogs, Data.DB,
  dmSCMcore, dmSCM, SCMdefines,
	FireDAC.Comp.Client;

		{
			I n d v T e a m .  (Determines either dbo.Entrant OR dbo.TEAM tables.)
		}
		function IndvTeam_ClearLane(aIndvTeamID: integer; aEventType: scmEventType;
			DoExclude: Boolean = true): integer;
		function IndvTeam_ID(): integer; //current EntrantID or TeamID
		function IndvTeam_HeatID(aIndvTeamID: integer;
			aEventType: scmEventType): integer;
		function IndvTeam_HeatStatusID(aIndvTeamID: integer; aEventType: scmEventType;
			DoExclude: Boolean = true): integer;
		function IndvTeam_StrikeLane(aIndvTeamID: integer; aEventType: scmEventType;
			DoExclude: Boolean = true): integer;
		function IndvTeam_DeleteLane(aIndvTeamID: integer; aEventType: scmEventType;
			DoExclude: Boolean = true): integer;
		function IndvTeam_DeleteSplit(aSplitID: integer; aEventType: scmEventType;
			DoExclude: Boolean = true): integer;
		function IndvTeam_DeleteAllSplits(aIndvTeamID: integer;
			aEventType: scmEventType; DoExclude: Boolean = true): integer;
		function IndvTeam_LocateLane(aIndvTeamID: integer;
			aEventType: scmEventType): Boolean;
		{ L A N E S .  05.09.2023     }
		function Lane_ClearGutters(aHeatID: integer;
			DoExclude: Boolean = true): integer;
		function Lane_InsertLane(aHeatID: integer;
			DoExclude: Boolean = true): integer;
		function Lane_PadLanes(aHeatID: integer; DoExclude: Boolean = true)
			: integer;
		function Lane_RenumberLanes(aHeatID: integer;
			DoExclude: Boolean = true): integer;
		function Lane_SortLanes(aHeatID: integer;
			DoExclude: Boolean = true): integer;
		function Lane_TrimLanes(aHeatID: integer;
			DoExclude: Boolean = true): integer;

		{ T E A M E N T R A N T . }
		function TeamEntrant_Clear(aTeamEntrantID: integer;
			DoExclude: Boolean = true): integer;
		function TeamEntrant_Strike(aTeamEntrantID: integer;
			DoExclude: Boolean = true): integer;


function AddLane(LaneID: integer): integer;
function HeatStatusID(LaneID: integer): integer;
function LastLaneNum(LaneID: integer): integer;
function Locate(LaneID: integer): Boolean;
function PK(): integer; // NO CHECKS. RTNS: Primary key.
function MoveDownLane(ADataSet: TDataSet): Boolean;
function MoveUpLane(ADataSet: TDataSet): Boolean;
function RemoveLane(LaneID: integer): integer;
function SessionIsLocked(LaneID: integer): Boolean;

type
  T_Lane = class
  public
    constructor Create;
    destructor Destroy;
  end;

var
  scmLane: T_Lane;

implementation

constructor T_Lane.Create;
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

destructor T_Lane.Destroy;
begin
  // do cleanup...
  inherited;
end;


function TSCMHelper.TeamEntrant_Clear(aTeamEntrantID: integer;
	DoExclude: Boolean): integer;
var
  aHeatStatusID: integer;
begin
  result := 0;
  if not SCMActive then exit;
  if aTeamEntrantID = 0 then exit;
  if TeamEntrant_SessionIsLocked(aTeamEntrantID) then exit;
  aHeatStatusID := TeamEntrant_HeatStatusID(aTeamEntrantID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    result := ClearSlot(aTeamEntrantID);
  end;
end;

function TSCMHelper.TeamEntrant_Strike(aTeamEntrantID: integer;
	DoExclude: Boolean): integer;
var
  aHeatStatusID: integer;
begin
  result := 0;
  if not SCMActive then exit;
  if aTeamEntrantID = 0 then exit;
  if TeamEntrant_SessionIsLocked(aTeamEntrantID) then exit;
  aHeatStatusID := TeamEntrant_HeatStatusID(aTeamEntrantID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    result := StrikeSlot(aTeamEntrantID);
  end;
end;


function TSCMHelper.IndvTeam_ClearLane(aIndvTeamID: integer; aEventType: scmEventType;
	DoExclude: Boolean = true): integer;
var
  aHeatID, aHeatStatusID: integer;
begin
  result := 0;
  if not SCMActive then exit;
  if aIndvTeamID = 0 then exit;
  aHeatID := IndvTeam_HeatID(aIndvTeamID,aEventType);
  if (aHeatID = 0) then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    result := Self.ClearLane(aIndvTeamID, aEventType);
  end;
end;

function TSCMHelper.IndvTeam_DeleteAllSplits(aIndvTeamID: integer;
	aEventType: scmEventType; DoExclude: Boolean): integer;
var
  aHeatID,aHeatStatusID: integer;
begin
  result := 0;
  if aIndvTeamID = 0 then exit;
  aHeatID := IndvTeam_HeatID(aIndvTeamID,aEventType);
  if (aHeatID = 0) then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    result := DeleteAllSplits(aIndvTeamID, aEventType);
  end;
end;

function TSCMHelper.IndvTeam_DeleteLane(aIndvTeamID: integer;
	aEventType: scmEventType; DoExclude: Boolean): integer;
var
  aHeatID, aHeatStatusID: integer;
begin
  result := 0;
  if not SCMActive then exit;
  if aIndvTeamID = 0 then exit;
  aHeatID := IndvTeam_HeatID(aIndvTeamID,aEventType);
  if (aHeatID = 0) then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    result := DeleteLane(aIndvTeamID, aEventType);
  end;
end;

function TSCMHelper.IndvTeam_DeleteSplit(aSplitID: integer;
	aEventType: scmEventType; DoExclude: Boolean = true): integer;
var
  aHeatStatusID: integer;
begin
  result := 0;
  if not SCMActive then exit;
  if aSplitID = 0 then exit;
  if (aEventType = etUnknown) then exit;

  if (aEventType = etINDV) then
    if Split_SessionIsLocked(aSplitID) then exit;
  if (aEventType = etTEAM) then
    if TeamSplit_SessionIsLocked(aSplitID) then exit;

  aHeatStatusID := Split_HeatStatusID(aSplitID);
  if not(aHeatStatusID > 1) or (DoExclude = false) then
    result := DeleteSplit(aSplitID, aEventType);
end;

function TSCMHelper.IndvTeam_HeatID(aIndvTeamID: integer;
			aEventType: scmEventType): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not SCMActive then exit;
  if (aEventType = etUnknown) then exit;

  if (aEventType = etINDV) then
    SQL := 'SELECT HeatID FROM [SwimClubMeet2].[dbo].Entrant ' +
      'WHERE [Entrant].[EntrantID] = :ID;'
  else
    SQL := 'SELECT HeatID FROM [SwimClubMeet2].[dbo].Team ' +
      'WHERE [Team].[TeamID] = :ID;';
  v := scmConnection.ExecSQLScalar(SQL, [aIndvTeamID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCMHelper.IndvTeam_HeatStatusID(aIndvTeamID: integer;
			aEventType: scmEventType;DoExclude: Boolean = true): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not SCMActive then exit;
  if (aEventType = etINDV) then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet2].[dbo].[Heat] ' +
      'INNER JOIN Entrant ON [Heat].[HeatID] = Entrant.HeatID ' +
      'WHERE [Entrant].[EntrantID] = :ID;';
    v := scmConnection.ExecSQLScalar(SQL, [aIndvTeamID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;
  if (aEventType = etTEAM) then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet2].[dbo].[Heat] ' +
      'INNER JOIN Team ON [Heat].[HeatID] = Team.HeatID ' +
      'INNER JOIN TeamEntrant ON [Team].[TeamID] = [TeamEntrant].[TeamID] ' +
      'WHERE [TeamEntrant].[TeamEntrantID] = :ID;';
    v := scmConnection.ExecSQLScalar(SQL, [aIndvTeamID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;
end;

function TSCMHelper.IndvTeam_ID: integer;
var
  aHeatID: integer;
  aEventType: scmEventType;
begin
  result := 0;
  if not SCMActive then exit;
  if dsHeat.DataSet.Active and not dsHeat.DataSet.IsEmpty then
  begin
    aHeatID := dsHeat.DataSet.FieldByName('HeatID').AsInteger;
    aEventType := Heat_EventType(aHeatID);
    if (aEventType = etINDV) and dsEntrant.DataSet.Active and
      not dsEntrant.DataSet.IsEmpty then
        result := dsEntrant.DataSet.FieldByName('EntrantID').AsInteger
    else if (aEventType = etTEAM) and dsTeam.DataSet.Active and
      not dsTeam.DataSet.IsEmpty then
        result := dsTeam.DataSet.FieldByName('TeamID').AsInteger;
  end;
end;

function TSCMHelper.IndvTeam_LocateLane(aIndvTeamID: integer;
	aEventType: scmEventType): Boolean;
begin
  result := LocateLane(aIndvTeamID,aEventType);
end;

function TSCMHelper.IndvTeam_StrikeLane(aIndvTeamID: integer; aEventType: scmEventType;
	DoExclude: Boolean = true): integer;
var
  aHeatID, aHeatStatusID, aEventID, aMemberID, aTeamEntrantID, rows: integer;
  SQL: string;
  v: variant;
  qry: TFDQuery;
begin
  result := 0;
  rows := 0;
  if not SCMActive then exit;
  if aIndvTeamID = 0 then exit;
  aHeatID := IndvTeam_HeatID(aIndvTeamID, aEventType);
  if (aHeatID=0) then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    { Clear NOMINEES...   }
    aEventID := Heat_EventID(aHeatID);
    if aEventType = etINDV then
    begin
      SQL := 'SELECT MemberID FROM SwimClubMeet2.dbo.Entrant ' +
        'WHERE Entrant.HeatID = :ID1 AND Entrant.EntrantID = :ID2';
      v := scmConnection.ExecSQLScalar(SQL, [aHeatID, aIndvTeamID]);
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
      begin
        {  CLEAR LANE (+entrant)   EntrantID ALIAS aIndvTeamID  }
        ClearLane(aIndvTeamID, etIndv);
        {  CLEAR Nominee  }
        result := Self.DeleteNomination(v, aEventID);
      end;
    end
    else if aEventType = etTEAM then
    begin
      {  collate entrant's records for the given team  }
      SQL := 'SELECT MemberID, TeamEntrantID FROM SwimClubMeet2.dbo.Team ' +
        'INNER JOIN TeamEntrant ON Team.TeamID = TeamEntrant.TeamID ' +
        'WHERE Team.HeatID = :ID1 AND Team.TeamID = :ID2';
      // iterate on team-entrant.
      qry := TFDQuery.Create(self);
      qry.Connection := scmConnection;
      qry.SQL.Text := SQL;
      qry.IndexFieldNames := 'MemberID';
      qry.ParamByName('ID1').AsInteger := aHeatID;
      qry.ParamByName('ID2').AsInteger := aIndvTeamID;
      qry.Prepare;
      qry.Open;
      if qry.Active then
      begin
        while not qry.Eof do
        begin
          {  DELETE TEAM ENTRANT }
           aTeamEntrantID := qry.FieldByName('TeamEntrantID').AsInteger;
           Self.ClearSlot(aTeamEntrantID);
          {  DELETE the members NOMINATION (if a member's ID exists) }
          if not qry.FieldByName('MemberID').IsNull then
          begin
            aMemberID := qry.FieldByName('MemberID').AsInteger;
            rows := rows + Self.DeleteNomination(aMemberID, aEventID);
          end;
          qry.Next;
        end;
        {  CLEAR LANE (+Team) TeamID ALIAS aIndvTeamID }
        Self.ClearLane(aIndvTeamID, aEventType);
        if rows > 0 then result := rows;
      end;
      qry.Close;
      qry.Free;
    end
    else exit;
  end;
end;

function TSCMHelper.Lane_ClearGutters(aHeatID: integer;
	DoExclude: Boolean = true): integer;
begin
  result := 0;
  { Lane_ClearGutters
    Only clears gutters if enabled in preferences.
  }
  {TODO -oBSA -cGeneral : CLEAR GUTTERS}
end;

function TSCMHelper.Lane_InsertLane(aHeatID: integer;
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
  begin
    result := InsertEmptyLane(aHeatID);
  end;
end;

function TSCMHelper.Lane_PadLanes(aHeatID: integer;
	DoExclude: Boolean = true): integer;
var
  aHeatStatusID: integer;
begin
  { Lane_Pad
    Fills the heat with empty lanes up too 'SwimClub_NumberOfLanes'.
    RTN - Number of rows created.
    Note: Doesn't renumber heat.
  }
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    result := RenumberLanes(aHeatID);
  end;
end;

function TSCMHelper.Lane_RenumberLanes(aHeatID: integer;
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
    result := RenumberLanes(aHeatID); // note: protected method.
end;

function TSCMHelper.Lane_SortLanes(aHeatID: integer;
	DoExclude: Boolean): integer;
begin
  result := 0;
  {TODO -obsa -cGeneral : CODE SORT LANES}
end;

function TSCMHelper.Lane_TrimLanes(aHeatID: integer;
	DoExclude: Boolean = true): integer;
var
  NumOfLanes, Lanes, i, aHeatStatusID: integer;
begin
  { Lane_Trim
    Removes excess lanes.
    If the excess contains a swimmer, the routine clears the lane.
    Nominations remain.
  }
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    NumOfLanes := SwimClub_NumberOfLanes; // number of lanes in club pool.
    Lanes := CountLanes(aHeatID);
    if Lanes > NumOfLanes then
    begin
      // too many lanes ... clear swimmer then trim.
      for i := 1 to (Lanes - NumOfLanes) do
      begin
{TODO -oBSA -cGeneral : TRIM LANES}
      end;
    end;
  end;
end;


function AddLane(LaneID: integer): integer;
var
  lane: integer;
  SQL: string;
begin
  result := 0;
  if not SCM.SCMActive then exit;
  if LaneID = 0 then exit;
  Lane := LastLaneNum(LaneID) + 1;
  SQL := 'INSERT INTO [SwimClubMeet2].[dbo].[Lane] ' +
  '( [Lane],[IsDisqualified],[IsScratched],[TeamID]) ' +
  'VALUES ( :ID1,0,0,:ID2)';
  result := SCM.scmConnection.ExecSQL(SQL, [Lane, LaneID]);
end;

function HeatStatusID(LaneID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not SCM.SCMActive then exit;
  if LaneID > 0 then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet2].[dbo].[Heat] ' +
    'INNER JOIN Team ON [Heat].[HeatID] = Team.HeatID ' +
    'INNER JOIN Lane ON [Team].[TeamID] = [Lane].[TeamID] ' +
    'WHERE [Lane].[LaneID] = :ID;';
    v := SCM.scmConnection.ExecSQLScalar(SQL, [LaneID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;
end;

function LastLaneNum(LaneID: integer): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not SCM.SCMActive then exit;
  if LaneID = 0 then exit;
  SQL := 'SELECT MAX(Lane) FROM SwimClubMeet2.dbo.Lane ' +
  'WHERE Lane.LaneID = :ID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [LaneID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function Locate(LaneID: integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not SCM.SCMActive then exit;
  if LaneID = 0 then exit;
  SearchOptions := [];
  if SCMcore.dsLane.DataSet.Active then
    result := SCMcore.qryLane.Locate('LaneID', LaneID,
      SearchOptions);
end;

function PK(): integer;
begin // NO CHECKS. quick and dirty - primary key result.
  result := SCMcore.qryLane.FieldByName('LaneID').AsInteger;
end;

function MoveDownLane(ADataSet: TDataSet): Boolean;
begin
  result := SCM.MoveDownLane(ADataSet);
end;

function MoveUpLane(ADataSet: TDataSet): Boolean;
begin
  result := SCM.MoveUpLane(ADataSet);
end;

function RemoveLane(LaneID: integer): integer;
var
  SQL: string;
begin
  result := 0;
  if not SCM.SCMActive then exit;
  if LaneID = 0 then exit;
  SQL := 'DELETE FROM SwimClubMeet2.dbo.Lane ' +
  'WHERE LaneID = :ID';
  result := SCM.scmConnection.ExecSQL(SQL, [LaneID]);
end;

function SessionIsLocked(LaneID: integer): Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not SCM.SCMActive then exit;
  SQL := 'SELECT SessionStatusID FROM [SwimClubMeet2].[dbo].[Session] ' +
  'INNER JOIN [Event] ON [Session].[SessionID] = [Event].[SessionID] ' +
  'INNER JOIN [Heat] ON [Event].[EventID] = [Heat].[EventID] '
  + 'INNER JOIN [Team] ON [Heat].[HeatID] = [Team].[HeatID] ' +
  'INNER JOIN [Lane] ON [Team].[TeamID] = [Team].[TeamID] ' +
  'WHERE [Lane].[LaneID] = :ID';
  v := SCM.scmConnection.ExecSQLScalar(SQL, [LaneID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v = 2) then result := true;
end;

end.

