unit AutoBuildRelayAlgorithm;

interface

uses
System.Classes, FireDAC.Comp.Client, FireDAC.Stan.Param, dmSCM, dmSCMHelper,
  SCMUtility, System.SysUtils;

// Bin packing algorithm in Delphi using a genetic algorithm

// Define the container and item types
type

  TTeam = record
    // L A N E  >>> R E L A Y  - T E A M .
    // (Typically a relay-team holds four swimmers)
    ID: Integer; // IDENITY of the Team in dbo.Team.
    Lane: Integer;   // Lane number.
    RaceTime: TTime;  // The SUM of all PBs for swimmers in the relay-team.
    Entrants: array of integer; // Holds memberID - 4 x swimmers per lane.
    HeatID: Integer;
  end;

  TChromosome = array of TTeam;


  THeat = record
    // H E A T .
    ID: integer;
    HeatNum: integer;
    EventID: integer;
  end;

  TSwimmer = record
    // S W I M M E R .
    NomineeID: Integer; // Nomination ID for the swimmer in dbo.Nominee.
    MemberID: Integer; // Member ID for the swimmer used in dbo.Member table
    TTB: TTime; // Time-to-beat. Estimated (calculated) swimming for XDistance.
    PB: TTime; // Personal Best swimming time for the swimmer for the event.
  end;

var
 NumOfNominees: integer; // Count of nominees.
 NumOfTeams: integer; // Count of relay-teams.
 NumOfHeats: integer; // Count of heats.
 NumOfTeamsPerHeat: integer; // Count of relay-teams in each heat.
 NumOfPoolLanes: integer; // takes into consideration preferences for gutter lanes.
 NumOfEntrantsPerTeam: integer;

  Population: array of TChromosome;
  PopulationSize: Integer = 100;
  Generations: Integer = 1000;
  MutationRate: Double = 0.01;

 // D Y N A M I C   A R R A Y S .
 // Swimmers who nominated for the event.
 Swimmers: array of TSwimmer;
 // [HeatID][TeamID]. An array of heats - each containing a relay-team.
 Heats: array of THeat;
 // If the number of Relay-Teams exceeds the number of lanes
 // then multi-heats are required.
 Teams: array of TTeam;

 function GetStrokeID(EventID: integer): integer;
 function GetXDistanceID(EventID, teamSize: integer): integer;


implementation

uses System.Math, system.Generics.Collections, System.IniFiles, System.Variants;

function InitializePopulation: TChromosome;
var
  i, j: Integer;
  Chromosome: TChromosome;
begin
  SetLength(Chromosome, NumOfTeams);
  for i := 0 to NumOfTeams - 1 do
  begin
    Chromosome[i].ID := i;
    Chromosome[i].Lane := i mod NumOfPoolLanes;
    SetLength(Chromosome[i].Entrants, NumOfEntrantsPerTeam);
    for j := 0 to NumOfEntrantsPerTeam - 1 do
    begin
      Chromosome[i].Entrants[j] := Random(NumOfNominees);
    end;
  end;
  Result := Chromosome;
end;

function Fitness(Chromosome: TChromosome): Double;
var
  i, j: Integer;
  TotalTime, MaxTime, MinTime: TTime;
begin
  MaxTime := 0;
  MinTime := MaxInt;
  TotalTime := 0;
  for i := 0 to High(Chromosome) do
  begin
    Chromosome[i].RaceTime := 0;
    for j := 0 to High(Chromosome[i].Entrants) do
    begin
      Chromosome[i].RaceTime := Chromosome[i].RaceTime + Swimmers[Chromosome[i].Entrants[j]].TTB;
    end;
    if Chromosome[i].RaceTime > MaxTime then
      MaxTime := Chromosome[i].RaceTime;
    if Chromosome[i].RaceTime < MinTime then
      MinTime := Chromosome[i].RaceTime;
    TotalTime := TotalTime + Chromosome[i].RaceTime;
  end;
  Result := MaxTime - MinTime;
end;

function TournamentSelection: TChromosome;
var
  i, BestIndex: Integer;
  BestFitness, CurrentFitness: Double;
begin
  BestIndex := Random(PopulationSize);
  BestFitness := Fitness(Population[BestIndex]);
  for i := 1 to 4 do
  begin
    CurrentFitness := Fitness(Population[Random(PopulationSize)]);
    if CurrentFitness < BestFitness then
    begin
      BestFitness := CurrentFitness;
      BestIndex := i;
    end;
  end;
  Result := Population[BestIndex];
end;

function Crossover(Parent1, Parent2: TChromosome): TChromosome;
var
  i, CrossoverPoint: Integer;
  Child: TChromosome;
begin
  SetLength(Child, Length(Parent1));
  CrossoverPoint := Random(Length(Parent1));
  for i := 0 to CrossoverPoint do
    Child[i] := Parent1[i];
  for i := CrossoverPoint + 1 to High(Parent2) do
    Child[i] := Parent2[i];
  Result := Child;
end;

procedure Swap(var A, B: Integer);
var
  Temp: Integer;
begin
  Temp := A;
  A := B;
  B := Temp;
end;


procedure Mutate(var Chromosome: TChromosome);
var
  Team1, Team2, Swimmer1, Swimmer2: Integer;
begin
  if Random < MutationRate then
  begin
    Team1 := Random(Length(Chromosome));
    Team2 := Random(Length(Chromosome));
    Swimmer1 := Random(Length(Chromosome[Team1].Entrants));
    Swimmer2 := Random(Length(Chromosome[Team2].Entrants));
    Swap(Chromosome[Team1].Entrants[Swimmer1], Chromosome[Team2].Entrants[Swimmer2]);
  end;
end;

procedure GeneticAlgorithm;
var
  i, j: Integer;
  Parent1, Parent2, Child: TChromosome;
  BestChromosome: TChromosome;
  BestFitness, CurrentFitness: Double;
begin
  SetLength(Population, PopulationSize);
  for i := 0 to PopulationSize - 1 do
    Population[i] := InitializePopulation;

  for i := 0 to Generations - 1 do
  begin
    for j := 0 to PopulationSize - 1 do
    begin
      Parent1 := TournamentSelection;
      Parent2 := TournamentSelection;
      Child := Crossover(Parent1, Parent2);
      Mutate(Child);
      Population[j] := Child;
    end;
  end;

  BestChromosome := Population[0];
  BestFitness := Fitness(BestChromosome);
  for i := 1 to PopulationSize - 1 do
  begin
    CurrentFitness := Fitness(Population[i]);
    if CurrentFitness < BestFitness then
    begin
      BestFitness := CurrentFitness;
      BestChromosome := Population[i];
    end;
  end;

  // Use BestChromosome to set your final teams
  SetLength(Teams, Length(BestChromosome));
  for i := 0 to High(BestChromosome) do
    Teams[i] := BestChromosome[i];
end;



function GetStrokeID(EventID: integer): integer;
var
v: variant;
begin
  result := 0;
  v := SCM.scmConnection.ExecSQLScalar('SELECT StrokeID FROM [dbo].[Event] WHERE [EventID] = :ID',[EventID]);
  if not VarIsNull(v) then
    result := v;
end;

function GetXDistanceID(EventID, teamSize: Integer): Integer;
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


procedure DistributeTeams(FDQuery: TFDQuery);
var
  i, j, k, m, n, AHeatID, AEventID, ATeamID, ATeamEntrantID, ALaneNum: Integer;
  TeamRaceTime: TTIME;
begin
  i := 0;
  // iterate through the list of nominees
  while not FDQuery.Eof do
  begin
    Swimmers[i].MemberID := FDQuery.FieldByName('MemberID').AsInteger;
    Swimmers[i].NomineeID := FDQuery.FieldByName('NomineeID').AsInteger;
    Swimmers[i].TTB := FDQuery.FieldByName('TTB').AsDateTime;
    Inc(i);
    FDQuery.Next;
  end;

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


procedure InsertIntoTeams();
var
  qry1, qry2, qry3: TFDQuery;
  AHeatID: integer;
  ATeamID: integer;
  ATeamEntrantID: integer;
  i: integer;
  j: integer;
  k: integer;
  m: integer;
  n: integer;
  p: integer;
  r: integer;
begin
  k := 0;

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
      inc(k, 1);
    end;
  End;
end;



{
Retrieve Swimmer Data: Fetch the 16 swimmers’ data from the Nominee table,
focusing on their MemberID and PB (Personal Best) times.
}


procedure RetriveSwimmingData(AEventID, poolLanes, teamSize: Integer);
var
  FDQuery: TFDQuery;
  IniFileName: TFilename;
  StrokeID, xDistanceID: integer;
begin

  FDQuery := TFDQuery.Create(nil);
  try

    StrokeID := GetStrokeID(AEventID);
    xDistanceID := GetXDistanceID(AEventID, teamSize);
    NumOfPoolLanes := poolLanes;
    NumOfEntrantsPerTeam := teamSize;

    FDQuery.Connection := SCM.scmConnection; // Your FireDAC connection
    // Sort swimmers by personal best (PB)
    // Order by ascending - FASTEST to SLOWEST
    FDQuery.SQL.Text := '''
    SELECT
		 [NomineeID]
		,[PB]
		,[SeedTime]
		,[AutoBuildFlag]
		,[EventID]
		,[MemberID]
        -- Re-Calculate TimeToBeat...
        -- algorithm 1 ... average of the 3 fastest racetimes
        -- 1, 50%, MemberID, 25m, freestyle, SesssionStart.
    ,dbo.TimeToBeat(1, default, default, [MemberID], :XDISTANCEID, :STROKEID, :SESSIONSTART) AS TTB
    FROM [dbo].[Nominee]
    WHERE [EventID] = :EVENTID
    ORDER BY [TTB] ASC
''';


 //'SELECT MemberID, PB FROM dbo.Nominee WHERE EventID = :ID ORDER BY PB ASC';


    FDQuery.ParamByName('EVENTID').AsInteger := AEventID;
    FDQuery.ParamByName('SESSIONSTART').AsDateTime := SCM.Session_Start;
    FDQuery.ParamByName('XDISTANCEID').AsDateTime := xDistanceID;
    FDQuery.ParamByName('STROKEID').AsDateTime := StrokeID;
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
    if NumOfTeams = 0 then exit;
    // check that the number of relay-teams doesn't exceed the number of lanes.
    if NumOfTeams > poolLanes then
      NumOfHeats := Ceil(NumOfTeams / poolLanes);

    NumOfTeamsPerHeat := Ceil(NumOfTeams / NumOfHeats);

    SetLength(Swimmers, NumOfNominees);
    SetLength(Heats, NumOfHeats);
    SetLength(Teams, NumOfTeams);

    // Clean OUT ALL HEATs, TEAMs, TEAMSPLITs.
    SCM.Heat_DeleteAll(AEventID);

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
