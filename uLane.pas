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
  function GetLaneID(): integer; // SAFE.
  function InsertLane: integer;
  function HeatStatusID(LaneID: integer): integer;
  function LastLaneNum: integer;
  function Locate(LaneID: Integer): Boolean;
  function PK(): integer; // NO CHECKS. RTNS: Primary key.
  function MoveDownLane(ADataSet: TDataSet): Boolean;
  function MoveUpLane(ADataSet: TDataSet): Boolean;
  function RemoveLane(LaneID: integer): integer;
  function SessionIsLocked(LaneID: integer): Boolean;
  function DeleteRecord(DoExclude: Boolean = true): boolean;
		{
			I n d v T e a m .  (Determines either dbo.Entrant OR dbo.TEAM tables.)
		}
    function ClearLane(DoExclude: Boolean = true): integer;
    function TeamPK: integer;
		function IndvTeam_HeatID(aIndvTeamID: integer;	aEventType: scmEventType): integer;
		function IndvTeam_HeatStatusID(aIndvTeamID: integer; aEventType: scmEventType;
			DoExclude: Boolean = true): integer;
		function IndvTeam_StrikeLane(aIndvTeamID: integer; aEventType: scmEventType;
			DoExclude: Boolean = true): integer;
		function IndvTeam_DeleteLane(aIndvTeamID: integer; aEventType: scmEventType;
			DoExclude: Boolean = true): integer;
		function IndvTeam_DeleteSplit(aSplitID: integer; aEventType: scmEventType;
			DoExclude: Boolean = true): integer;
    function DeleteAllSplits(DoExclude: Boolean = true): integer;
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
    function ClearTeamLink(aNomineeID: Integer; DoExclude: Boolean = true): boolean;
    function StrikeTeamLink(aNomineeID: Integer; DoExclude: Boolean = true):
        integer;



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
 uSwimClub, uSession, uEvent, uHeat;

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

function GetLaneID(): integer;
begin
  result := 0;
  if uLane.Assert then
      result := CORE.qryLane.FieldByName('LaneID').AsInteger;
end;


function ClearTeamLink(aNomineeID: Integer; DoExclude: Boolean = true): boolean;
var
  found: boolean;
  SearchOptions: TLocateOptions;
begin
  result := false;
  SearchOptions := [];
  if uSession.IsLocked() then exit;
  if (uHeat.HeatStatusID() = 1) or (DoExclude = false) then
  begin
    found := CORE.qryTeamLink.Locate('TeamID;NomineeID', VarArrayOf([uLane.PK(), aNomineeID]), SearchOptions);
    if found  then
    begin
      CORE.qryTeamLink.Delete;// remove teamlink..
      result := true;
    end;
  end;
end;

function StrikeTeamLink(aNomineeID: Integer; DoExclude: Boolean = true):
    integer;
var
  found: boolean;
  SearchOptions: TLocateOptions;
begin
  result := 0;
  SearchOptions := [];
  if uSession.IsLocked() then exit;
  if (uHeat.HeatStatusID() = 1) or (DoExclude = false) then
  begin
    if ClearTeamLink(aNomineeID, true) then
    begin
      if CORE.qryNominee.Locate('NomineeID', aNomineeID, SearchOptions) then
      begin
        CORE.qryNominee.Delete; // remove nominee.
      end;
    end;
  end;
end;


function ClearLane(DoExclude: Boolean = true): integer;
begin
  result := 0;
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
      except on E: Exception do CORE.qryLane.Cancel;
      end;

    finally
      CORE.qryLane.EnableControls;
    end;
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

function IndvTeam_DeleteLane(aIndvTeamID: integer;
	aEventType: scmEventType; DoExclude: Boolean): integer;
var
  aHeatID, aHeatStatusID: integer;
begin
  result := 0;
  if uSession.IsLocked() then exit;
  if (uHeat.HeatStatusID = 1) or (DoExclude = false) then
  begin
    // Delete Lane
  end;
end;

function IndvTeam_DeleteSplit(aSplitID: integer;
	aEventType: scmEventType; DoExclude: Boolean = true): integer;
var
  aHeatStatusID: integer;
begin
  result := 0;
  if not SCM.IsActive then exit;
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
  if not SCM.IsActive then exit;
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



function TeamPK: integer;
begin
  result := CORE.qryLane.FieldByName('TeamID').AsInteger;
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
  if not SCM.IsActive then exit;
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

function Lane_ClearGutters(aHeatID: integer;
	DoExclude: Boolean = true): integer;
begin
  result := 0;
  { Lane_ClearGutters
    Only clears gutters if enabled in preferences.
  }
  {TODO -oBSA -cGeneral : CLEAR GUTTERS}
end;

function Lane_InsertLane(aHeatID: integer;
	DoExclude: Boolean = true): integer;
var
  aHeatStatusID: integer;
begin
  result := 0;
  if not SCM.IsActive then exit;
  if aHeatID = 0 then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    result := InsertEmptyLane(aHeatID);
  end;
end;

function Lane_PadLanes(aHeatID: integer;
	DoExclude: Boolean = true): integer;
var
  aHeatStatusID: integer;
begin
  // NOTE: if renumbering is needed, this must be done by caller.
  result := 0;
  if not Assigned(CORE) or not CORE.IsActive then exit;
  if uSession.IsLocked() then exit;
  if (uHeat.HeatStatusID = 1) or (DoExclude = false) then
  begin // Add required lanes.
  end;
end;

function Lane_TrimLanes(aHeatID: integer;
  DoExclude: Boolean = true): integer;
var
  NumOfLanes, Lanes, i, aHeatStatusID: integer;
begin
  // NOTE: if renumbering is needed, this must be done by caller.
  result := 0;
  if not Assigned(CORE) or not CORE.IsActive then exit;
  if uSession.IsLocked() then exit;
  if (uHeat.HeatStatusID = 1) or (DoExclude = false) then
  begin // Remove excess lanes.
    NumOfLanes := uSwimClub.NumberOfLanes; // number of lanes in club pool.
    Lanes := CountLanes();
    if Lanes > NumOfLanes then
    begin
      CORE.qryLane.DisableControls;

      try
        CORE.qryLane.First;
        // pass 1: look for empty swimming lanes.
        while not CORE.qryLane.eof do
        begin
          if CORE.qryLane.FieldByName('TeamID').IsNull and
          CORE.qryLane.FieldByName('NomineeID').IsNull then
          begin
            if uLane.DeleteRecord(true) then // candidate for delete.
            begin
              Dec(Lanes);
              if Lanes <= NumOfLanes then
                break
              else
                continue;
            end
            else
              CORE.qryLane.next;
          end
          else
            CORE.qryLane.next;
        end;

        if Lanes > NumOfLanes then
        begin
          // pass 2: trim from end...
        end;


      finally
        CORE.qryLane.EnableControls;
      end;


    end;
  end;
end;


function InsertLane: integer;
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

function Locate(LaneID: Integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  SearchOptions := [];
  if Assigned(CORE) and CORE.dsLane.DataSet.Active then
    result := CORE.qryLane.Locate('LaneID', LaneID, SearchOptions);
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

