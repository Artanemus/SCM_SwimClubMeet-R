unit dmSCMHelper;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils, System.Math,
  System.IniFiles, System.Variants, System.UITypes, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, FireDAC.Comp.Client, Winapi.Windows, SCMUtility, SCMDefines, dmSCM;

type
  TSCMHelper = class helper for TSCM
    {
      H E A T .
    }
    function Heat_ClearALLLanes(aHeatID: integer;  DoExclude: Boolean = true): integer;
    {
      I n d v T e a m .
      RTNs MemberID in ENTRANT OR TEAMENTRANT tables.
    }
    function IndvTeam_ClearLane(aIndvTeamID: integer; aEventType: TEventType;
      DoExclude: Boolean = true): integer;
    function IndvTeam_HeatID(aIndvTeamID: integer; aEventType: TEventType): integer;
    function IndvTeam_HeatStatusID(aIndvTeamID: integer; aEventType: TEventType;
      DoExclude: Boolean = true): integer;
    function IndvTeam_StrikeLane(aIndvTeamID: integer; aEventType: TEventType;
      DoExclude: Boolean = true): integer;
    function Lane_ClearGutters(aHeatID: integer; DoExclude: Boolean = true): integer;
    {
      G E N E R I C     F U N C T I O N S .
      Finds the TEventType of the heat'
      Lanes is specific to TEAM or ENTRANT tables.
      Lane references lane number. (dbo.Entrant.lane or dbo.Team.lane)
      LaneID references EntrantID or TeamID,
      Swimmers is specific to MemberID in ENTRANT OR TEAMENTRANT tables
    }

    {
      L A N E S .  05.09.2023
      Operates on dbo.Entrant (INDV) OR dbo.Team (TEAM).
      Must be SCMActive be true.
      Session must be un-locked.
      Checks TEventType.
    }
    function Lane_InsertLane(aHeatID: integer; DoExclude: Boolean = true): integer;
    function Lane_PadLanes(aHeatID: integer; DoExclude: Boolean = true): integer;
    function Lane_RenumberLanes(aHeatID: integer; DoExclude: Boolean = true)
      : integer;
    function Lane_SortLanes(aHeatID: integer; DoExclude: Boolean = true): integer;
    function Lane_TrimLanes(aHeatID: integer; DoExclude: Boolean = true): integer;
    {
       N O M I N A T I O N S .
       Alternative to dmSCMNom class functions.
    }
    function NOM_ClearLane(aMemberID, aEventID: integer;
      DoExclude: Boolean = true): integer;
    function NOM_DeleteALLExclude(aEventID: integer;
      DoExclude: Boolean = true): integer;
    function NOM_DeleteExclude(aMemberID, aEventID: integer;
      DoExclude: Boolean = true): integer;
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
  end;

implementation

function TSCMHelper.Heat_ClearALLLanes(aHeatID: integer;
  DoExclude: Boolean = true): integer;
var
  qry: TFDQuery;
  aHeatStatusID, aMemberID, aEventID: integer;
  aEventType: TEventType;
begin
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    aEventType := Heat_EventType(aHeatID);
    qry := TFDQuery.Create(self);
    if aEventType = etINDV then
    begin
      qry.SQL.Text :=
        'SELECT [Entrant].[MemberID] FROM [SwimClubMeet].[dbo].[Entrant] ' +
        'WHERE MemberID IS NOT NULL AND [Entrant].HeatID = ' +
        IntToStr(aHeatID);
      qry.IndexFieldNames := 'EntrantID';
    end
    else if aEventType = etTeam then
    begin
      qry.SQL.Text :=
        'SELECT [TeamEntrant].[MemberID] FROM [SwimClubMeet].[dbo].[Team] ' +
        'INNER JOIN TeamEntrant ON Team.TeamID = TeamEntrant.TeamID ' +
        'WHERE MemberID IS NOT NULL AND [Team].HeatID = ' + IntToStr(aHeatID);
      qry.IndexFieldNames := 'Team;TeamEntrantID';
    end;

    if (aEventType = etINDV) or (aEventType = etTeam) then
    begin
      aEventID := Heat_EventID(aHeatID);
      qry.Connection := scmConnection;
      qry.Open;
      if qry.Active then
      begin
        while not qry.Eof do
        begin
          aMemberID := qry.FieldByName('MemberID').AsInteger;
          result := NOM_ClearLane(aMemberID, aEventID, false);
          qry.Next;
        end;
      end;
      qry.Close;
    end;
    qry.Free;
  end;
end;

function TSCMHelper.IndvTeam_ClearLane(aIndvTeamID: integer; aEventType: TEventType;
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
    ClearLane(aIndvTeamID, aEventType);
  end;
end;

function TSCMHelper.IndvTeam_HeatID(aIndvTeamID: integer;
      aEventType: TEventType): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not SCMActive then exit;
  if (aEventType <> etINDV) or (aEventType <> etTEAM) then exit;

  if (aEventType = etINDV) then
  begin
    SQL := 'SELECT HeatID FROM [SwimClubMeet].[dbo].Entrant ' +
      'WHERE [Entrant].[EntrantID] = :ID;';
  end;
  if (aEventType = etTEAM) then
  begin
    SQL := 'SELECT HeatID FROM [SwimClubMeet].[dbo].Team ' +
      'WHERE [Team].[TeamID] = :ID;';
  end;
  v := scmConnection.ExecSQLScalar(SQL, [aIndvTeamID]);
  if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
end;

function TSCMHelper.IndvTeam_HeatStatusID(aIndvTeamID: integer;
      aEventType: TEventType;DoExclude: Boolean = true): integer;
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

function TSCMHelper.IndvTeam_StrikeLane(aIndvTeamID: integer; aEventType: TEventType;
  DoExclude: Boolean = true): integer;
var
  aHeatID, aHeatStatusID, aEventID: integer;
  SQL: string;
  v: variant;
begin
  result := 0;
  if not SCMActive then exit;
  if aIndvTeamID = 0 then exit;
  aHeatID := IndvTeam_HeatID(aIndvTeamID, aEventType);
  if (aHeatID=0) then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    if aEventType = etINDV then
    begin
      SQL := 'SELECT MemberID FROM SwimClubMeet.dbo.Entrant ' +
        'WHERE Entrant.HeatID = :ID1 AND Entrant.EntrantID = :ID2'
    end
    else if aEventType = etTEAM then
    begin
      SQL := 'SELECT MemberID FROM SwimClubMeet.dbo.Team ' +
        'INNER JOIN TeamEntrant ON Team.TeamID = TeamEntrant.TeamID ' +
        'WHERE Team.HeatID = :ID1 AND TeamEntrant.TeamEntrantID = :ID2'
    end
    else exit;
    v := scmConnection.ExecSQLScalar(SQL, [aHeatID, aIndvTeamID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
    begin
      aEventID := Heat_EventID(aHeatID);
      result := NOM_StrikeLane(v, aEventID, false);
    end;

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
  NumOfLanes, Lanes, i, aHeatStatusID: integer;
begin
  { Lane_Pad
    Fills the heat with empty lanes up too 'SwimClub_NumberOfLanes'.
    RTN - Number of rows created.
  }
  result := 0;
  if not SCMActive then exit;
  if aHeatID = 0 then exit;
  if Heat_SessionIsLocked(aHeatID) then exit;
  aHeatStatusID := Heat_HeatStatusID(aHeatID);
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    Lanes := CountLanes(aHeatID);
    // number of lanes in club pool.
    NumOfLanes := SwimClub_NumberOfLanes;
    if Lanes < NumOfLanes then // need more lanes
    begin
      for i := 1 to (NumOfLanes - Lanes) do Lane_InsertLane(aHeatID);
    end;
    Lane_RenumberLanes(aHeatID);
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

function TSCMHelper.NOM_ClearLane(aMemberID, aEventID: integer;
  DoExclude: Boolean): integer;
var
  aHeatStatusID, aIndvTeamID: integer;
  aEventType: TEventType;
begin
  result := 0;
  if not SCMActive then exit;
  if Event_SessionIsLocked(aEventID) then exit;
  aEventType := Event_EventType(aEventID);
  aIndvTeamID := NOM_IndvTeamID(aMemberID, aEventID);
  // Member wasn't given a lane. Nothing to clear.
  if aIndvTeamID = 0 then exit;
  // RTNs zero if no heats or the nominee wasn't given a lane.
  aHeatStatusID := NOM_HeatStatusID(aMemberID, aEventID);
  // The nominee was given a lane. Heat is 'open' or force delete.
  if (aHeatStatusID = 1) or (DoExclude = false) then
  begin
    ClearLane(aIndvTeamID, aEventType);// Remove swimmer from lane.
    result := 1;
  end;
end;

function TSCMHelper.NOM_DeleteALLExclude(aEventID: integer;
  DoExclude: Boolean): integer;
var
  qry: TFDQuery;
  rows, aMemberID: integer;
begin
  result := 0;
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
      rows := rows + NOM_DeleteExclude(aMemberID, aEventID, DoExclude);
      qry.Next;
    end;
    if rows > 0 then result := rows;
  end;
  qry.Close;
  qry.Free;
end;

function TSCMHelper.NOM_DeleteExclude(aMemberID, aEventID: integer;
  DoExclude: Boolean = true): integer;
var
  SQL: string;
  rows: integer;
begin
  result := 0;
  rows := 0;
  if not SCMActive then exit;
  if Event_SessionIsLocked(aEventID) then exit;
  // If the nominee was given a lane - remove swimmer from lane.
  NOM_ClearLane(aMemberID, aEventID, DoExclude);
  // Assert that the member hasn't been assigned a lane.
  if not(NOM_IsMemberInEvent(aMemberID, aEventID)) or not DoExclude then
  begin
    // FINALLY DELETE Nomination..
    SQL := 'DELETE FROM SwimClubMeet.[dbo].[Nominee] ' +
      'WHERE MemberID = :MemberID AND EventID = :EventID;';
    rows := scmConnection.ExecSQL(SQL, [aMemberID, aEventID]);
    if (rows > 0) then result := rows;
  end;
end;

function TSCMHelper.NOM_HeatStatusID(aMemberID, aEventID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: TEventType;
begin
  result := 0;
  if not SCMActive then exit;
  aEventType := Event_EventType(aEventID);
  if (aEventType = etINDV) then
  begin
    SQL := 'SELECT [Event].[EventID] ' + 'FROM [SwimClubMeet].[dbo].[Nominee] '
      + 'INNER JOIN Event ON [Nominee].EventID = Event.EventID ' +
      'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.EventID ' +
      'INNER JOIN Entrant ON [HeatIndividual].HeatID = Entrant.HeatID ' +
      'WHERE Entrant.MemberID = :aMemberID';
    v := scmConnection.ExecSQLScalar(SQL, [aMemberID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
    begin
      result := v;
    end;
  end
  else if (aEventType = etTEAM) then
  begin
    SQL := 'SELECT [Event].[EventID] ' + 'FROM [SwimClubMeet].[dbo].[Nominee] '
      + 'INNER JOIN Event ON [Nominee].EventID = Event.EventID ' +
      'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.EventID ' +
      'INNER JOIN Team ON HeatIndividual.HeatID = Team.HeatID ' +
      'INNER JOIN TeamEntrant ON [Team].TeamID = TeamEntrant.HeatID ' +
      'WHERE TeamEntrant.MemberID = :aMemberID';
    v := scmConnection.ExecSQLScalar(SQL, [aMemberID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;

end;

function TSCMHelper.NOM_IndvTeamID(aMemberID, aEventID: integer): integer;
var
  SQL: string;
  v: variant;
  aEventType: TEventType;
begin
  result := 0;
  if not SCMActive then exit;
  aEventType := Event_EventType(aEventID);
  if (aEventType = etINDV) then
  begin
    SQL := 'SELECT TOP 1 Entrant.EntrantID FROM [SwimClubMeet].[dbo].[Event] ' +
      'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.EventID ' +
      'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID ' +
      'WHERE [Event].EventID = :EventID AND (Entrant.MemberID = :MemberID)';
    v := scmConnection.ExecSQLScalar(SQL, [aMemberID, aEventID]);
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
    v := scmConnection.ExecSQLScalar(SQL, [aMemberID, aEventID]);
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
begin
  result := 0; // return EntrantID. Zero indicate 'not in event'.
  if Event_IsINDV then
  begin
    SQL := 'SELECT EntrantID FROM [SwimClubMeet].[dbo].[Nominee] ' +
      'INNER JOIN [Event] ON [Event].EventID = Nominee.EventID ' +
      'INNER JOIN HeatIndividual ON HeatIndividual.EventID = [Event].EventID ' +
      'INNER JOIN Entrant ON Entrant.HeatID = HeatIndividual.HeatID ' +
      'WHERE Nominee.NomineeID = :NomineeID ' +
      'AND Nominee.MemberID = Entrant.MemberID;';
  end
  else
  begin
    SQL := 'SELECT EntrantID FROM [SwimClubMeet].[dbo].[Nominee] ' +
      'INNER JOIN [Event] ON [Event].EventID = Nominee.EventID ' +
      'INNER JOIN HeatIndividual ON HeatIndividual.EventID = [Event].EventID ' +
      'INNER JOIN Team ON Team.HeatID = HeatIndividual.HeatID ' +
      'INNER JOIN TeamEntrant ON Team.TeamID = TeamEntrant.TeamID ' +
      'WHERE Nominee.NomineeID = :NomineeID ' +
      'AND Nominee.MemberID = Entrant.MemberID;';
  end;
  v := scmConnection.ExecSQLScalar(SQL, [aNomineeID]);
  if not VarIsNull(v) or not VarIsEmpty(v) or (v <> 0) then result := v;
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
  result := NOM_DeleteExclude(aMemberID, aEventID, DoExclude);
end;

function TSCMHelper.NOM_UnNominateMember(aMemberID, aEventID: integer;
  DoExclude: Boolean = true): integer;
var
  rows, aHeatStatusID: integer;
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
    rows := NOM_DeleteExclude(aMemberID, aEventID, DoExclude);
    // Entrant/TeamEntrant grid on form will need refresh.
    if (rows > 0) and (Owner is TForm) then
        PostMessage(TForm(Owner).Handle, SCM_LANEWASCLEANED, 0, 0);
    result := rows;
  end;

end;

end.
