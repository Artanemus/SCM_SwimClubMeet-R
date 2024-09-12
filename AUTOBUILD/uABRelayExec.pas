unit uABRelayExec;

interface

uses
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
System.Classes, dmSCM, dmSCMHelper,
FireDAC.Comp.Client, FireDAC.Stan.Param,
Vcl.Forms, SCMDefines, Data.DB;

type

  TABRelayExec = class(TComponent)
  private
    { private declarations }
    prefExcludeOutsideLanes: boolean;
    prefNumOfSwimmersPerTeam: integer;
    prefVerbose: boolean;
    prefHeatAlgorithm: integer;
    prefRaceTimeTopPercent: integer;

    prefUseDefRaceTime: boolean;
    prefSeperateGender: boolean;
    rgpSeedMethod: integer;
    spnSeedDepth: integer;

  FConnection: TFDConnection;
  fEventID: integer;
  fXDistanceID: integer;
  fStrokeID: integer;

  function GetPoolLaneCount: integer;
  function GetXDistanceID(EventID, teamSize: integer): integer;
  function GetStrokeID(EventID: integer): integer;

  procedure ReadPreferences(IniFileName: string);
  procedure RetriveSwimmingData(AEventID, poolLanes, teamSize: Integer);
  procedure InsertIntoTeams();

//  procedure Distribute(FDQuery: TFDQuery; AEventID: integer);

  protected
    { protected declarations }

  public
    { public declarations }
    procedure ExecAutoBuildRelay();
    procedure Prepare(AConnection: TFDConnection;  ASwimClubID, AEventID: Integer);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    { published declarations }

  end;

implementation

{ TAutoBuildRelayExec }

uses System.Math, System.IniFiles, SCMUtility, uABRelayV1,
  dmABRelayData;

{
procedure TAutoBuildRelayExec.Distribute(FDQuery: TFDQuery; AEventID: integer);
var
  i, j, k, m, n, ALaneNum: Integer;
  TeamRaceTime: TTIME;
begin
  // Distribute swimmers into teams
  i := 0;   // Nominees - Swimmers
  m := 0;   // 0 .. NumOfTeams-1
  for j := 0 to NumOfHeats - 1 do
  begin
    // HEAT.
    Heats[j].ID := j;
    Heats[j].HeatNum := j+1;
    Heats[j].EventID := AEventID;
    for k := 0 to NumOfTeamsPerHeat - 1 do
    begin
      // TEAM.
      Teams[m].ID := m; // Identifier 0...NumOfTeams-1
      inc(m, 1);
      ALaneNum := ScatterLanes(k, NumOfPoolLanes); // index is base 0
      Teams[m].Lane := ALaneNum;
      Teams[m].RaceTime := 0;

      // set the number of swimmers permitted in a relay team
      SetLength(Teams[k].Entrants, NumOfEntrantsPerTeam);
      TeamRaceTime := 0;
      // fill relay team with entrants.
      for n := 0 to NumOfEntrantsPerTeam - 1 do
      begin
        if (i <= high(Swimmers)) then
        begin
          // TEAMENTRANT.
          Teams[k].Entrants[n] := i;
          TeamRaceTime := TeamRaceTime + Swimmers[i].TTB;
        end;
        inc(i, 1);
      end;
      // total est.racetime for this relay-team
      Teams[k].RaceTime := TeamRaceTime;
    end;
    // TEST : exceed number of teams in total
    if m >= NumOfTeams then break;
  end;
end;
}


constructor TABRelayExec.Create(AOwner: TComponent);
begin
  inherited;
  fEventID := 0;
  FConnection := nil;
  fXDistanceID := 1;
  fStrokeID := 1;

  // I N I T I A L I Z E   P R E F E R E N C E S .
  prefExcludeOutsideLanes := false;
  prefHeatAlgorithm := 1;
  prefNumOfSwimmersPerTeam := 4;
  prefRaceTimeTopPercent := 50;
  prefVerbose := false;
  prefRaceTimeTopPercent := 50;
  prefUseDefRaceTime := true;
  prefSeperateGender := false;
  rgpSeedMethod := 0;
  spnSeedDepth := 3;

end;

destructor TABRelayExec.Destroy;
begin
  if assigned(ABRelayData) then
    FreeAndNil( ABRelayData);
  inherited;
end;

procedure TABRelayExec.ExecAutoBuildRelay();
var
  IniFileName: TFileName;
  v: variant;
  poolLanes: integer;
begin
  // A S S E R T .
  // data module : use Prepare to initialize...
  if not assigned(ABRelayData) then exit;
  if fEventID = 0 then exit;
  // is this a team event.

  prefExcludeOutsideLanes := false;
  prefNumOfSwimmersPerTeam := 4;

  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then
    ReadPreferences(IniFileName);

  v :=
    SCM.scmConnection.ExecSQLScalar
    ('SELECT EventTypeID FROM [dbo].[Event] WHERE EventID = :ID', [fEventID]);
  if VarIsNull(v) then
  begin
    if prefVerbose then
      Application.MessageBox('Event type not assigned.', 'SCM Error', MB_OK)
    else
      exit; // error - NULL.
  end;

  if v <> 2 then
  begin
    if prefVerbose then
      Application.MessageBox('The event isn''t a relay', 'SCM Error', MB_OK)
    else
      exit; // error - event type not a team event.
  end;

  v :=
    SCM.scmConnection.ExecSQLScalar
    ('SELECT StrokeID FROM [dbo].[Event] WHERE EventID = :ID', [fEventID]);
  if VarIsNull(v) then exit; // error - unknow swimming stroke.

  if v = 5 then
    if prefVerbose then
      Application.MessageBox('''
        Medley relays cannot be auto-built by SwimClubMeet.
        Auto-build will abort.
        ''',
        'SwimClubMeet Error',
        MB_ICONERROR or MB_OK)
    else
      exit; // error - relay-type = Medley


  poolLanes := GetPoolLaneCount;
  // ASSERT
  if poolLanes = 0 then
    if prefVerbose then
      Application.MessageBox('''
        No pool lanes are available. Check swim-club preferences.
        Note: Nominees for relays that have been raced or close are excluded.
        Auto-build will abort.
        ''',
        'SwimClubMeet Error',
        MB_ICONERROR or MB_OK)
    else
      exit;

  // Test for nominees
  v := 0;
  ABRelayData.qryCountRNominee.Close;
  ABRelayData.qryCountRNominee.ParamByName('EVENTID').AsInteger := fEventID;
  ABRelayData.qryCountRNominee.Prepare;
  ABRelayData.qryCountRNominee.Open;
  if ABRelayData.qryCountRNominee.Active then
    v := ABRelayData.qryCountRNominee.FieldByName('CountNominees').AsInteger;

  if VarIsNull(v) OR v=0 then
    if prefVerbose then
      Application.MessageBox('''
        No nominees were found for the team event.
        Note: Nominees for this event that have been raced or close are excluded.
        Auto-build will abort.
        ''',
        'SwimClubMeet Error',
        MB_ICONERROR or MB_OK)
    else
    exit; // error - NULL.



  {TODO -oBSA -cGeneral : Progress bar and captions ....}

  // Clean OUT ALL HEATs, TEAMs, TEAMEntrants, TEAMSPLITs.
  // Does not remove raced or closed heats .
  SCM.Heat_DeleteAll(fEventID, true);

  // perform Auto-Build.
  RetriveSwimmingData(fEventID, poolLanes, prefNumOfSwimmersPerTeam);

  // Refresh UI and data
  if Owner is TForm then
    SendMessage(TForm(Owner).Handle, SCM_AUTOBUILDRELAYSFIN, 0, 0);
end;

function TABRelayExec.GetPoolLaneCount: integer;
var
  Lanes: integer;
begin
  result := 0;
  // Get number of lanes from dbo.SwimClub.NumOfLanes
  Lanes := SCM.SwimClub_NumberOfLanes;
  // Adjust lanes if excluding outside lanes
  if (prefExcludeOutsideLanes) then Dec(Lanes, 2);
  // Ensure there is at least one lane
  if (Lanes < 1) then Exit;
  result := Lanes;
end;

function TABRelayExec.GetStrokeID(EventID: integer): integer;
var
  v: variant;
begin
  result := 0;
  v := SCM.scmConnection.ExecSQLScalar
    ('SELECT StrokeID FROM [dbo].[Event] WHERE [EventID] = :ID', [EventID]);
  if not VarIsNull(v) then
    result := v;
end;

function TABRelayExec.GetXDistanceID(EventID,
  teamSize: integer): integer;
var
  v: variant;
  meters: Integer;
begin
  result := 0;
  v := SCM.scmConnection.ExecSQLScalar('''
    SELECT[meters]
    FROM[SwimClubMeet].[dbo].[Distance]
    INNER JOIN[dbo].[Event] ON[Distance].[DistanceID] = [Event].[DistanceID]
    WHERE EventID = :ID
    ''', [EventID]);
  if not VarIsNull(v) then
  begin
    // divide the total relay distance by the number of swimmers in the relay
    meters := Floor(v/teamSize);
    // cross reference value 'meters' to find the XDistanceID for a swimmer.
    v := SCM.scmConnection.ExecSQLScalar('''
    SELECT[DistanceID]
    FROM[SwimClubMeet].[dbo].[Distance]
    WHERE[meters] = :ID
    ''', [meters]);
    if not VarIsNull(v) then
    begin
      result := v;
    end;
  end;
end;

procedure TABRelayExec.InsertIntoTeams;
var
  qry1, qry2, qry3: TFDQuery;
  AHeatID: integer;
  ATeamID: integer;
  ATeamEntrantID: integer;
  i, j, m, n, p, r: integer;
begin



  qry1 := TFDQuery.Create(nil);
  qry2 := TFDQuery.Create(nil);
  qry3 := TFDQuery.Create(nil);

  qry1.Connection := SCM.scmConnection;
  qry2.Connection := SCM.scmConnection;
  qry3.Connection := SCM.scmConnection;

  for j := Low(Heats) to High(Heats) do
  Begin
    // Insert into dbo.HeatIndividual
      qry1.SQL.Text := 'INSERT INTO HeatIndividual (HeatNum, OpenDT, HeatTypeID, HeatStatusID) VALUES (:HEATNUM, GETDATE(), 1, 1)';
      qry1.ParamByName('HEATNUM').AsInteger := Heats[j].HeatNum;
      qry1.ExecSQL;
      // Get the new heat record's ID
      AHeatID := qry1.Connection.GetLastAutoGenValue('HeatID');

    for i := 0 to NumOfTeamsPerHeat - 1 do
    begin
      // Insert into Team table
      qry2.SQL.Text := 'INSERT INTO Team (Lane, TeamNameID, HeatID) VALUES (:LANE, :TEAMNAMEID, :HEATID)';
      qry2.ParamByName('LANE').AsInteger := Teams[i].Lane;
      // dbo.TeamName is a table filled with ID's starting from 1, ending in 26 and Caption's TeamA...TeamZ.
      // i is base 0.
      // i is range 0 to NumOfTeams (unlikely, though not impossible, to exceed 25 (the number of team names - 1).
      qry2.ParamByName('TEAMNAMEID').AsInteger := Teams[i].ID+1; // Base zero.
      qry2.ParamByName('HEATID').AsInteger := AHeatID; // Base zero.
      qry2.ExecSQL;
      // Get the new team record's ID
      ATeamID := qry2.Connection.GetLastAutoGenValue('TeamID');
      p := 1; // Swimming order 1 to NumOfEntrantsPerTeam.
      // Insert into TeamEntrant table
      for m := Low(Teams[i].Entrants) to High(Teams[i].Entrants) do
      begin
        qry3.SQL.Text := 'INSERT INTO TeamEntrant (MemberID, Lane, TeamID, PersonalBest, TimeToBeat) VALUES (:MemberID, :Lane, :TeamID, :PersonalBest, :TimeToBeat)';
        qry3.ParamByName('MemberID').AsInteger := Teams[i].Entrants[m];
        qry3.ParamByName('Lane').AsInteger := p;
        qry3.ParamByName('TeamID').AsInteger := ATeamID;
        // locate swimmer in Swimmers...
        for r  := Low(Swimmers) to High(Swimmers) do
        begin
          if Swimmers[r].MemberID = Teams[i].Entrants[m] then
          begin
            qry3.ParamByName('PersonalBest').AsTime := Swimmers[r].PB;
            qry3.ParamByName('TimeToBeat').AsTime := Swimmers[r].TTB;
            break;
          end;
        end;
        qry3.ExecSQL;
        inc(p, 1);
      end;
    end;
  End;

  qry3.Close;
  qry2.Close;
  qry1.Close;

  qry1.Free;
  qry2.Free;
  qry3.Free;

end;

procedure TABRelayExec.Prepare(AConnection: TFDConnection; ASwimClubID,
  AEventID: Integer);
begin
  FConnection := AConnection;
  fEventID := AEventID;
  // ----------------------------------------------------
  // C R E A T E   D A T A M O D U L E   S C M .
  // ----------------------------------------------------
  try
    ABRelayData := TABRelayData.CreateWithConnection(Self,
      FConnection);
  finally
    // with ManageMemberData created and the essential tables are open then
    // asserting the connection should be true
    if not assigned(ABRelayData) then
      raise Exception.Create('Auto-Build Relay''s Data Module creation error.');
  end;
end;

procedure TABRelayExec.ReadPreferences(IniFileName: string);
var
  iFile: TIniFile;
  i: Integer;
begin
  iFile := TIniFile.Create(IniFileName);

  // When true gutter lanes are not used in events.
  i := iFile.ReadInteger('Preferences', 'ExcludeOutsideLanes', 0);
  prefExcludeOutsideLanes := (i = 1);

  // 2024-09-10
  // Relay teams, by default, have four swimmers.
  prefNumOfSwimmersPerTeam := iFile.ReadInteger('Preferences', 'NumOfSwimmersPerTeam', 4);
  // Verbose. Message all errors.
  i := iFile.ReadInteger('Preferences', 'Verbose', 0);
  prefVerbose  := (i = 1);

  // TTB defaults to (1) .. the entrant's average of top 3 race-times
  prefHeatAlgorithm :=
    (iFile.ReadInteger('Preferences', 'HeatAlgorithm', 1));

  // default to - get an average race-time of other swimmers
  i := iFile.ReadInteger('Preferences',  'UseDefRaceTime', 1);
  prefUseDefRaceTime  := (i = 1);

  // The bottom percent to select from ... default is 50%
  prefRaceTimeTopPercent :=
    (iFile.ReadInteger('Preferences', 'RaceTimeTopPercent', 50));

  i := iFile.ReadInteger('Preferences', 'SeperateGender', 0);
  prefSeperateGender := (i = 1);

  // SCM default seeding.
  rgpSeedMethod := iFile.ReadInteger('Preferences', 'SeedMethod', 0);

  // 2020-11-01 auto-build v2 seed depth for Circle Seed */
  spnSeedDepth := (iFile.ReadInteger('Preferences', 'SeedDepth', 3));

  iFile.free;
end;

procedure TABRelayExec.RetriveSwimmingData(AEventID, poolLanes,
  teamSize: Integer);
var
  FDQuery: TFDQuery;
  IniFileName: TFilename;
  StrokeID, xDistanceID, i: integer;
begin
{
Retrieve Swimmer Data: Fetch swimmers’ data from the Nominee table,
focusing on their MemberID TTB (TimeToBeat) and PB (Personal Best) times.
}

  {
    SET @EventID = :EVENTID;
    SET @Algorithm = :ALGORITHM;
    SET @ToggleName = :TOGGLENAME;
    SET @CalcDefault = :CALCDEFAULT
    SET @BottomPercent = :BOTTOMPERCENT
    SET @EventType = :EVENTTYPE
    SET @DistanceID = :DISTANCEID


  ABRelayData.qryRNominee.Close;
  ABRelayData.qryRNominee.ParamByName('EVENTID').AsInteger := fEventID;
  ABRelayData.qryRNominee.ParamByName('ALGORITHM').AsInteger := prefHeatAlgorithm;
  ABRelayData.qryRNominee.ParamByName('TOGGLENAME').AsBoolean := false;
  ABRelayData.qryRNominee.ParamByName('CALCDEFAULT').AsInteger := prefRaceTimeTopPercent;
  ABRelayData.qryRNominee.ParamByName('BOTTOMPERCENT').AsInteger := prefRaceTimeTopPercent;
  ABRelayData.qryRNominee.ParamByName('EVENTTYPE').AsInteger := prefRaceTimeTopPercent;
  ABRelayData.qryRNominee.ParamByName('DISTANCEID').AsInteger := XDistanceID;

   }


{
  poolLanes = swimming lanes - prefExcludeOutsideLanes
  teamSize = number of swimmers in a relay-team. Default = 4;
}

  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then
    ReadPreferences(IniFileName);

  // Freestyle, backstroke, breaststroke, butterfly.
  // This routine doesn't autobuild Medley-Relays
  // StrokeID = 5 (Medley-Relays) illegal.
  StrokeID := GetStrokeID(AEventID);
  // XDistance = the distance each entrant in relay-team swims.
  // WIT: 4x25m relay Total 100m ... entrants swim 25m.
  xDistanceID := GetXDistanceID(AEventID, teamSize);

  // Assign params passed.
  NumOfPoolLanes := poolLanes;
  NumOfEntrantsPerTeam := teamSize;

  FDQuery := TFDQuery.Create(nil);
  try

    FDQuery.Connection := SCM.scmConnection; // Your FireDAC connection
    // Sort swimmers by personal best (PB)
    // Order by ascending - FASTEST to SLOWEST
    FDQuery.SQL.Text := '''
    SELECT
		 [NomineeID]
		,[SeedTime]
		,[AutoBuildFlag]
		,[EventID]
		,[MemberID]
        -- Re-Calculate TimeToBeat...
        -- algorithm default ... average of the 3 fastest racetimes
        -- percentage default ... 50%
        -- MemberID, 25m, freestyle, SesssionStart.
    ,dbo.TimeToBeat(1, :ALGORITHM, :PERCENT, [MemberID], :XDISTANCEID, :STROKEID, :SESSIONSTART) AS TTB
    ,dbo.PersonalBest([MemberID],:XDISTANCEID, :STROKEID, :SESSIONSTART) AS PB
    FROM [dbo].[Nominee]
    WHERE [EventID] = :EVENTID
    ORDER BY [TTB] ASC
''';

    FDQuery.ParamByName('EVENTID').AsInteger := AEventID;
    FDQuery.ParamByName('SESSIONSTART').AsDateTime := SCM.Session_Start;
    FDQuery.ParamByName('XDISTANCEID').AsDateTime := xDistanceID;
    FDQuery.ParamByName('STROKEID').AsDateTime := StrokeID;
    FDQuery.ParamByName('ALGORITHM').AsDateTime := prefHeatAlgorithm;
    FDQuery.ParamByName('PERCENT').AsDateTime := prefRaceTimeTopPercent;
    FDQuery.Open;

    if FDQuery.IsEmpty then
    begin
      FDQuery.Close;
      FDQuery.Free;
      exit;
    end;

    // the number of club members who nominated for the relay event.
    NumOfNominees := FDQuery.RecordCount;
    // the number of teams
    NumOfTeams := Ceil(NumOfNominees / teamsize);
    // ASSERT
    if NumOfTeams = 0 then exit;
    // check that the number of relay-teams doesn't exceed the number of lanes.
    if NumOfTeams > poolLanes then
      NumOfHeats := Ceil(NumOfTeams / poolLanes);

    NumOfTeamsPerHeat := Ceil(NumOfTeams / NumOfHeats);

    SetLength(Swimmers, NumOfNominees);

    // iterate through the list of nominees
    i := 0;
    while not FDQuery.Eof do
    begin
      Swimmers[i].MemberID := FDQuery.FieldByName('MemberID').AsInteger;
      Swimmers[i].NomineeID := FDQuery.FieldByName('NomineeID').AsInteger;
      Swimmers[i].TTB := FDQuery.FieldByName('TTB').AsDateTime;
      Swimmers[i].pB := FDQuery.FieldByName('pB').AsDateTime;
      Inc(i, 1);
      FDQuery.Next;
    end;

    SetLength(Heats, NumOfHeats);
    SetLength(Teams, NumOfTeams);


    // Process the data
    // DistributeTeams(FDQuery);

    // Process the data using Genetic Algorithm
    GeneticAlgorithm();

    InsertIntoTeams();

  finally
    FDQuery.Free;
  end;
end;

end.
