unit dmSCMHelper;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils, System.Math,
  System.IniFiles, System.Variants, System.UITypes, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, FireDAC.Comp.Client, FireDAC.Stan.Param,
  Winapi.Windows, SCMUtility, SCMDefines,
  Data.DB, dmSCM;

type
  TSCMHelper = class helper for TSCM
    { S E S S I O N .    }
    function Session_Delete(aSessionID: integer;  DoExclude: Boolean = true): integer;
    function Session_RenumberEvents(aSessionID: integer; DoLocate: Boolean = true;
      DoExclude: Boolean = true): integer;
    { E V E N T .    }
    function Event_Delete(aEventID: integer;  DoExclude: Boolean = true): integer;
    function Event_RenumberHeats(aEventID: integer; DoLocate: Boolean = true;
      DoExclude: Boolean = true): integer;
    { H E A T .    }
    function Heat_ClearLanes(aHeatID: integer;  DoExclude: Boolean = true): integer;
    function Heat_Delete(aHeatID: integer;  DoExclude: Boolean = true): integer;
    function Heat_DeleteAll(aEventID: integer;  DoExclude: Boolean = true): integer;
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
    {
       N O M I N A T I O N S .
       Alternative to dmSCMNom class functions.
    }
    function NOM_ClearLane(aMemberID, aEventID: integer;
      DoExclude: Boolean = true): integer;
    function NOM_DeleteALLExclude(aEventID: integer): integer;
    function NOM_HeatStatusID(aMemberID, aEventID: integer): integer;
    function NOM_IndvTeamID(aMemberID, aEventID: integer): integer;
    function NOM_IsMemberInEvent(aMemberID, aEventID: integer): Boolean;
    function NOM_IsMemberNominated(aMemberID, aEventID: integer): Boolean;
    function NOM_IsNomineeInEvent(aNomineeID: integer): integer;
    function NOM_NominateMember(aMemberID, aEventID: integer;
      DoExclude: Boolean = true): integer;
    function NOM_StrikeLane(aMemberID, aEventID: integer;
      DoExclude: Boolean = true): integer;
    function NOM_UnNominateMember(aMemberID, aEventID: integer;
      DoExclude: Boolean = true): integer;

    {
//      Normalise DistanceID in dbo.Distance
    function NormalizeDistanceID(aDistanceID: integer): integer;
    }

    function Members_Count(): integer;

  end;

implementation

function TSCMHelper.Event_Delete(aEventID: integer;
  DoExclude: Boolean): integer;
var
  SQL: string;
begin
  result := 0;
  if not SCMActive then exit;
  if Event_SessionIsLocked(aEventID) then exit;
  // D E L E T E   H E A T S and remove swimmer data.
  // (including Entrants, Teams, TeamEntrants, Splits, TeamSplits...)
  Heat_DeleteAll(aEventID, DoExclude);
  // ASSERT that all swimmer data has been removed.
  if (Event_GetEntrantCount(aEventID) = 0) or (DoExclude = false) then
  begin
    // D E L E T E   N O M I N A T I O N S .
    SQL := 'DELETE FROM dbo.Nominee WHERE Nominee.EventID = :ID';
    scmConnection.ExecSQL(SQL, [aEventID]);
  end;
  // ASSERT that all heats have been removed.
  if (Event_GetHeatCount(aEventID) = 0) or (DoExclude = false) then
  begin
    // FINALLY DELETE EVENT
    dsEvent.DataSet.DisableControls;
    SQL := 'DELETE FROM dbo.Event WHERE Event.EventID = :ID';
    result := scmConnection.ExecSQL(SQL, [aEventID]);
    dsEvent.DataSet.EnableControls;
  end;
end;

function TSCMHelper.Event_RenumberHeats(aEventID: integer; DoLocate,
  DoExclude: Boolean): integer;
begin
  result := 0;
  if not SCMActive then exit;
  if aEventID = 0 then exit;
  if Event_SessionIsLocked(aEventID) then exit;
  result := RenumberHeats(aEventID, DoLocate);
end;

function TSCMHelper.Heat_ClearLanes(aHeatID: integer;
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

function TSCMHelper.Heat_Delete(aHeatID: integer; DoExclude: Boolean): integer;
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

function TSCMHelper.Heat_DeleteAll(aEventID: integer;
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
  qry.SQL.Text := 'SELECT HeatID FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
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
    SQL := 'SELECT HeatID FROM [SwimClubMeet].[dbo].Entrant ' +
      'WHERE [Entrant].[EntrantID] = :ID;'
  else
    SQL := 'SELECT HeatID FROM [SwimClubMeet].[dbo].Team ' +
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
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
      'INNER JOIN Entrant ON [HeatIndividual].[HeatID] = Entrant.HeatID ' +
      'WHERE [Entrant].[EntrantID] = :ID;';
    v := scmConnection.ExecSQLScalar(SQL, [aIndvTeamID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;
  if (aEventType = etTEAM) then
  begin
    SQL := 'SELECT HeatStatusID FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
      'INNER JOIN Team ON [HeatIndividual].[HeatID] = Team.HeatID ' +
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
      SQL := 'SELECT MemberID FROM SwimClubMeet.dbo.Entrant ' +
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
      SQL := 'SELECT MemberID, TeamEntrantID FROM SwimClubMeet.dbo.Team ' +
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

function TSCMHelper.Members_Count: integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not SCMActive then exit;
  SQL := 'SELECT Count(MemberID) FROM SwimClubMeet.dbo.Member';
  v := SCM.scmConnection.ExecSQLScalar(SQL);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCMHelper.NOM_ClearLane(aMemberID, aEventID: integer;
  DoExclude: Boolean): integer;
var
  aHeatStatusID, aIndvTeamID: integer;
  aEventType: scmEventType;
begin
  result := 0;
  if not SCMActive then exit;
  if Event_SessionIsLocked(aEventID) then exit;
  aEventType := GetEventType(aEventID);
  aIndvTeamID := NOM_IndvTeamID(aMemberID, aEventID);
  // Member wasn't given a lane. Nothing to clear.
  if aIndvTeamID = 0 then exit;
  // RTNs zero if no heats or the nominee wasn't given a lane.
  aHeatStatusID := NOM_HeatStatusID(aMemberID, aEventID);
  // The nominee was given a lane. Heat is 'open' or force delete.
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    Self.ClearLane(aIndvTeamID, aEventType);// Remove swimmer from lane.
    result := 1;
  end;
end;

function TSCMHelper.NOM_DeleteALLExclude(aEventID: integer): integer;
var
  qry: TFDQuery;
  rows, aMemberID: integer;
begin
  result := 0;
  if not SCMActive then exit;
  rows := 0;
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text :=
    'SELECT [Nominee].[MemberID]  FROM [SwimClubMeet].[dbo].[Nominee] ' +
    'WHERE [Nominee].EventID = ' + IntToStr(aEventID);
  qry.IndexFieldNames := 'NomineeID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aMemberID := qry.FieldByName('aMemberID').AsInteger;
      rows := rows + Self.DeleteNomination(aMemberID, aEventID);
      qry.Next;
    end;
    if rows > 0 then result := rows;
  end;
  qry.Close;
  qry.Free;
end;


function TSCMHelper.NOM_HeatStatusID(aMemberID, aEventID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: scmEventType;
begin
  result := 0;
  if not SCMActive then exit;
  aEventType := GetEventType(aEventID);
  if (aEventType = etINDV) then
  begin
    SQL := 'SELECT [HeatIndividual].[HeatStatusID] FROM [SwimClubMeet].[dbo].[Nominee] '
      + 'INNER JOIN Event ON [Nominee].EventID = Event.EventID ' +
      'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.EventID ' +
      'INNER JOIN Entrant ON [HeatIndividual].HeatID = Entrant.HeatID ' +
      'WHERE Entrant.MemberID = :ID1 AND [Event].EventID = :ID2';
    v := scmConnection.ExecSQLScalar(SQL, [aMemberID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
    begin
      result := v;
    end;
  end
  else if (aEventType = etTEAM) then
  begin
    SQL := 'SELECT [HeatIndividual].[HeatStatusID] FROM [SwimClubMeet].[dbo].[Nominee] '
      + 'INNER JOIN Event ON [Nominee].EventID = Event.EventID ' +
      'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.EventID ' +
      'INNER JOIN Team ON HeatIndividual.HeatID = Team.HeatID ' +
      'INNER JOIN TeamEntrant ON [Team].TeamID = TeamEntrant.TeamID ' +
      'WHERE TeamEntrant.MemberID = :ID1 AND [Event].EventID = :ID2';
    v := scmConnection.ExecSQLScalar(SQL, [aMemberID, aEventID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;

end;

function TSCMHelper.NOM_IndvTeamID(aMemberID, aEventID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: scmEventType;
begin
  result := 0;
  if not SCMActive then exit;
  aEventType := GetEventType(aEventID);
  if (aEventType = etINDV) then
  begin
    SQL := 'SELECT TOP 1 Entrant.EntrantID FROM [SwimClubMeet].[dbo].[Event] ' +
      'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.EventID ' +
      'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID ' +
      'WHERE [Event].EventID = :EventID AND (Entrant.MemberID = :MemberID)';
    v := scmConnection.ExecSQLScalar(SQL, [aEventID, aMemberID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
    begin
      result := v;
      exit;
    end;
  end
  else if (aEventType = etTEAM) then
  begin
    SQL := 'SELECT TOP 1 TeamEntrant.TeamEntrantID FROM [SwimClubMeet].[dbo].[Event] '
      + 'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.EventID '
      + 'INNER JOIN Team ON HeatIndividual.HeatID = Team.HeatID ' +
      'INNER JOIN TeamEntrant ON Team.TeamID = TeamEntrant.TeamID ' +
      'WHERE [Event].EventID = :EventID AND (TeamEntrant.MemberID = :MemberID)';
    v := scmConnection.ExecSQLScalar(SQL, [aEventID, aMemberID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;
end;

function TSCMHelper.NOM_IsMemberInEvent(aMemberID, aEventID: integer): Boolean;
begin
  result := false;
  if (NOM_IndvTeamID(aMemberID, aEventID) > 0) then result := true;
end;

function TSCMHelper.NOM_IsMemberNominated(aMemberID, aEventID: integer)
  : Boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if not SCMActive then exit;
  SQL := 'SELECT Nominee.NomineeID FROM SwimClubMeet.dbo.Nominee ' +
    'WHERE Nominee.MemberID = :MEMBERID AND Nominee.EventID = :EVENTID;';
  v := scmConnection.ExecSQLScalar(SQL, [aMemberID, aEventID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := true;
end;

function TSCMHelper.NOM_IsNomineeInEvent(aNomineeID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: scmEventType;
begin
  result := 0; // return EntrantID. Zero indicate 'not in event'.
  SQL := 'SELECT EventID FROM [SwimClubMeet].[dbo].[Nominee] '+
        ' WHERE Nominee.NomineeID = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aNomineeID]);
  if VarIsNull(v) or VarIsEmpty(v) or (v = 0) then exit;

  aEventType := GetEventType(v);
  if aEventType = etINDV then
  begin
    SQL := 'SELECT EntrantID FROM [SwimClubMeet].[dbo].[Nominee] ' +
      'INNER JOIN [Event] ON [Event].EventID = Nominee.EventID ' +
      'INNER JOIN HeatIndividual ON HeatIndividual.EventID = [Event].EventID ' +
      'INNER JOIN Entrant ON Entrant.HeatID = HeatIndividual.HeatID ' +
      'WHERE Nominee.NomineeID = :NomineeID ' +
      'AND Nominee.MemberID = Entrant.MemberID;';
  end
  else if aEventType = etTEAM then
  begin
    SQL := 'SELECT EntrantID FROM [SwimClubMeet].[dbo].[Nominee] ' +
      'INNER JOIN [Event] ON [Event].EventID = Nominee.EventID ' +
      'INNER JOIN HeatIndividual ON HeatIndividual.EventID = [Event].EventID ' +
      'INNER JOIN Team ON Team.HeatID = HeatIndividual.HeatID ' +
      'INNER JOIN TeamEntrant ON Team.TeamID = TeamEntrant.TeamID ' +
      'WHERE Nominee.NomineeID = :NomineeID ' +
      'AND Nominee.MemberID = Entrant.MemberID;';
  end
  else exit;

  v := scmConnection.ExecSQLScalar(SQL, [aNomineeID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCMHelper.NOM_NominateMember(aMemberID, aEventID: integer;
  DoExclude: Boolean = true): integer;
var
  aHeatStatusID: integer;
  SQL: string;
begin
  result := 0;
  if not SCMActive then exit;
  if Event_SessionIsLocked(aEventID) then exit;
  if NOM_IsMemberNominated(aMemberID, aEventID) then exit;
  // RTNs zero if no heats or the nominee wasn't given a lane.
  aHeatStatusID := NOM_HeatStatusID(aMemberID, aEventID);
  // The nominee was given a lane. Heat is 'open' or force delete.
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    SQL := 'INSERT INTO [SwimClubMeet].[dbo].[Nominee] ' +
      '([AutoBuildFlag],[TTB],[PB],[MemberID],[EventID],[SeedTime]) ' +
      'VALUES (0,NULL,NULL,:MemberID,:EventID,NULL)';
    result := scmConnection.ExecSQL(SQL, [aMemberID, aEventID]);
  end;
end;

function TSCMHelper.NOM_StrikeLane(aMemberID, aEventID: integer;
  DoExclude: Boolean): integer;
begin
  //
  result := Self.DeleteNomination(aMemberID, aEventID);
end;

function TSCMHelper.NOM_UnNominateMember(aMemberID, aEventID: integer;
  DoExclude: Boolean = true): integer;
var
  rows, aHeatStatusID, aIndvTeamID: integer;
  response: TModalResult;
begin
  result := 0;
  if not SCMActive then exit;
  if Event_SessionIsLocked(aEventID) then exit;
  if not NOM_IsMemberNominated(aMemberID, aEventID) then exit;
  // RTNs zero if no heats or the nominee wasn't given a lane.
  aHeatStatusID := NOM_HeatStatusID(aMemberID, aEventID);
  if not DoExclude then
  begin
    // The heat is locked - exit procedure
    if (aHeatStatusID <> 1) then
    begin
      MessageDlg('The member is nominated and has been given a lane.' +
        sLineBreak + 'The assigned heat has been set to raced or closed.' +
        sLineBreak + 'The member can''t be un-nominated.',
        TMsgDlgType.mtInformation, [mbOK], 0);
      exit;
    end;
    // preference setting - the user the option to abort procedure
    if (CheckNomination = integer(cbChecked)) then
    begin
      response := MessageDlg
        ('The member is nominated and has been given a lane.' + sLineBreak +
        'Remove the nomination AND empty the lane?', mtWarning,
        [mbYes, mbNo], 0, mbNo);
      if (response = mrNo) then exit;
    end;
  end;
  // The nominee was given a lane. Heat is 'open' or force delete.
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    {
      CLEAR TEAM AND TeamEntrants
    }
    aIndvTeamID := NOM_IndvTeamID(aMemberID, aEventID);
    IndvTeam_ClearLane(aIndvTeamID, etTeam, false);
    {
      REMOVE NOMINEE...
    }
    rows := Self.DeleteNomination(aMemberID, aEventID);
    // Entrant/TeamEntrant grid on form will need refresh.
    if (rows > 0) and (Owner is TForm) then
        PostMessage(TForm(Owner).Handle, SCM_LANEWASCLEANED, 0, 0);
    result := rows;
  end;

end;

{
function TSCMHelper.NormalizeDistanceID(aDistanceID: integer): integer;
var
  tbl: TFDTable;
  SearchOptions: TLocateOptions;
  foundit: Boolean;
  meters, aEventTypeID: integer;
begin
  result := 0; // Flags - failed to normalize.
  if not SCMActive then exit;
  tbl := TFDTable.Create(self);
  tbl.TableName := 'SwimClubMeet..Distance';
  tbl.Connection := scmConnection;
  tbl.IndexFieldNames := 'DistanceID';
  tbl.UpdateOptions.ReadOnly := true;
  tbl.Open;
  if tbl.Active then
  Begin
    // locate the
    foundit := tbl.Locate('DistanceID', aDistanceID, SearchOptions);
    if foundit then
    begin
      meters := tbl.FieldByName('Meters').AsInteger;
      aEventTypeID := tbl.FieldByName('EventTypeID').AsInteger;
      if aEventTypeID = 1 then // INDV EVENT
          result := aDistanceID
      else if aEventTypeID = 2 then // TEAM EVENT
      Begin
        // Total meters divided by number of swimmers.
        // It's ASSUMED that relays have 4 swimmer (Olympic Standard).
        meters := (meters div 4);
        // XReference : The distance swum by each swimmer in the relay.
        // Result is the ID of a INDV event.
        foundit := tbl.Locate('Meters; EventTypeID', VarArrayOf([meters, 1]),
          SearchOptions);
        // This normalized distance is required/used by scalar
        // functions dbo.TTB and dbo.PB
        if foundit then result := tbl.FieldByName('DistanceID').AsInteger;
      End;
    end;
  End;
  tbl.Close;
  tbl.Free;
end;
}

function TSCMHelper.Session_Delete(aSessionID: integer;
  DoExclude: Boolean): integer;
var
  SQL: string;
  qry: TFDQuery;
  aEventID, rows: integer;
begin
  // No locked session is ever deleted.
  result := 0;
  if Session_IsLocked then exit;
  // iter over events - delete nominations,heats,entrant/relays,splits,etc....
  qry := TFDQuery.Create(self);
  qry.Connection := scmConnection;
  qry.SQL.Text := 'SELECT [Event].[EventID] FROM [SwimClubMeet].[dbo].[Event] '
    + 'WHERE [Event].SessionID = ' + IntToStr(aSessionID);
  qry.IndexFieldNames := 'EventID';
  qry.Open;
  if qry.Active then
  begin
    while not qry.Eof do
    begin
      aEventID := qry.FieldByName('EventID').AsInteger;
      // delete nominees, heats, entrants, teams, team entrants, splits, etc
      Event_Delete(aEventID, DoExclude);
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
  // finally delete the session
  if not Session_HasEvents(aSessionID) or (DoExclude = false) then
  begin
    dsSession.DataSet.DisableControls;
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[Session] WHERE [SessionID] = :ID';
    rows := scmConnection.ExecSQL(SQL, [aSessionID]);
    result := rows;
    dsSession.DataSet.EnableControls;
  end;
end;

function TSCMHelper.Session_RenumberEvents(aSessionID: integer; DoLocate,
  DoExclude: Boolean): integer;
begin
  result := 0;
  if not SCMActive then exit;
  if aSessionID = 0 then exit;
  if Session_IsLocked(aSessionID) then exit;
  result := RenumberEvents(aSessionID, DoLocate);
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

end.
