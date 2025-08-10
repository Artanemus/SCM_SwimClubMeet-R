unit dmSCMHelper;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils, System.Math,
  System.IniFiles, System.Variants, System.UITypes, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, FireDAC.Comp.Client, FireDAC.Stan.Param,
  Winapi.Windows, SCMUtility, SCMDefines,
	Data.DB, dmCORE;

type
	TSCMHelper = class helper for TCORE
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

function TSCMHelper.Members_Count: integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if not SCMActive then exit;
  SQL := 'SELECT Count(MemberID) FROM SwimClubMeet2.dbo.Member';
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
    'SELECT [Nominee].[MemberID]  FROM [SwimClubMeet2].[dbo].[Nominee] ' +
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
    SQL := 'SELECT [Heat].[HeatStatusID] FROM [SwimClubMeet2].[dbo].[Nominee] '
      + 'INNER JOIN Event ON [Nominee].EventID = Event.EventID ' +
      'INNER JOIN Heat ON [Event].EventID = Heat.EventID ' +
      'INNER JOIN Entrant ON [Heat].HeatID = Entrant.HeatID ' +
      'WHERE Entrant.MemberID = :ID1 AND [Event].EventID = :ID2';
    v := scmConnection.ExecSQLScalar(SQL, [aMemberID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
    begin
      result := v;
    end;
  end
  else if (aEventType = etTEAM) then
  begin
    SQL := 'SELECT [Heat].[HeatStatusID] FROM [SwimClubMeet2].[dbo].[Nominee] '
      + 'INNER JOIN Event ON [Nominee].EventID = Event.EventID ' +
      'INNER JOIN Heat ON [Event].EventID = Heat.EventID ' +
      'INNER JOIN Team ON Heat.HeatID = Team.HeatID ' +
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
    SQL := 'SELECT TOP 1 Entrant.EntrantID FROM [SwimClubMeet2].[dbo].[Event] ' +
      'INNER JOIN Heat ON [Event].EventID = Heat.EventID ' +
      'INNER JOIN Entrant ON Heat.HeatID = Entrant.HeatID ' +
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
    SQL := 'SELECT TOP 1 TeamEntrant.TeamEntrantID FROM [SwimClubMeet2].[dbo].[Event] '
      + 'INNER JOIN Heat ON [Event].EventID = Heat.EventID '
      + 'INNER JOIN Team ON Heat.HeatID = Team.HeatID ' +
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
  SQL := 'SELECT Nominee.NomineeID FROM SwimClubMeet2.dbo.Nominee ' +
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
  SQL := 'SELECT EventID FROM [SwimClubMeet2].[dbo].[Nominee] '+
        ' WHERE Nominee.NomineeID = :ID';
  v := scmConnection.ExecSQLScalar(SQL, [aNomineeID]);
  if VarIsNull(v) or VarIsEmpty(v) or (v = 0) then exit;

  aEventType := GetEventType(v);
  if aEventType = etINDV then
  begin
    SQL := 'SELECT EntrantID FROM [SwimClubMeet2].[dbo].[Nominee] ' +
      'INNER JOIN [Event] ON [Event].EventID = Nominee.EventID ' +
      'INNER JOIN Heat ON Heat.EventID = [Event].EventID ' +
      'INNER JOIN Entrant ON Entrant.HeatID = Heat.HeatID ' +
      'WHERE Nominee.NomineeID = :NomineeID ' +
      'AND Nominee.MemberID = Entrant.MemberID;';
  end
  else if aEventType = etTEAM then
  begin
    SQL := 'SELECT EntrantID FROM [SwimClubMeet2].[dbo].[Nominee] ' +
      'INNER JOIN [Event] ON [Event].EventID = Nominee.EventID ' +
      'INNER JOIN Heat ON Heat.EventID = [Event].EventID ' +
      'INNER JOIN Team ON Team.HeatID = Heat.HeatID ' +
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
    SQL := 'INSERT INTO [SwimClubMeet2].[dbo].[Nominee] ' +
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
  tbl.TableName := 'SwimClubMeet2..Distance';
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

end.
