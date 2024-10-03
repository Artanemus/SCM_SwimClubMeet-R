unit uABRelayV1;

interface

uses
System.Classes, FireDAC.Comp.Client, FireDAC.Stan.Param, dmSCM, dmSCMHelper,
  SCMUtility, System.SysUtils;

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

// Bin packing algorithm in Delphi using a genetic algorithm
// Define the container and item types
var

  // D Y N A M I C   A R R A Y S .
  // Swimmers who nominated for the event.
  Swimmers: array of TSwimmer;
  // [HeatID][TeamID]. An array of heats - each containing a relay-team.
  Heats: array of THeat;
  // If the number of Relay-Teams exceeds the number of lanes
  // then multi-heats are required.
  Teams: array of TTeam;

  fNumOfNominees: integer; // Count of nominees.
  fNumOfTeams: integer; // Count of relay-teams.
  fNumOfHeats: integer; // Count of heats.
  fNumOfTeamsPerHeat: integer; // Count of relay-teams in each heat.
  fNumOfPoolLanes: integer; // takes into consideration preferences for gutter lanes.
  fNumOfEntrantsPerTeam: integer;

  // R E F E R E N C E S .
  fExcludeOutsideLanes: boolean;
  fHeatAlgorithm: integer;
  fNumOfSwimmersPerTeam: integer;
  fRaceTimeBottomPercent: integer;

  Population: array of TChromosome;
  PopulationSize: Integer = 100;
  Generations: Integer = 1000;
  MutationRate: Double = 0.01;


  procedure ReadPreferences(IniFileName: string);
  procedure GeneticAlgorithm();






end;

implementation

uses System.Math, system.Generics.Collections, System.IniFiles,
System.Variants, Data.DB;

procedure ReadPreferences(IniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(IniFileName);

  // When true gutter lanes are not used in events.
  fExcludeOutsideLanes := (iFile.ReadInteger('Preferences',
    'ExcludeOutsideLanes', 0) = 1);
  // Relay teams, by default, have four swimmers.
  fNumOfSwimmersPerTeam := iFile.ReadInteger('Preferences',
    'NumOfSwimmersPerTeam', 4);
  // TTB defaults to (1) .. the entrant's average of top 3 race-times
  fHeatAlgorithm := (iFile.ReadInteger('Preferences', 'HeatAlgorithm', 1));

  // The bottom percent to select from ... default is 50%
  fRaceTimeBottomPercent :=
    (iFile.ReadInteger('Preferences', 'RaceTimeTopPercent', 50));

  iFile.free;
end;

function InitializePopulation: TChromosome;
var
  i, j: Integer;
  Chromosome: TChromosome;
begin
  SetLength(Chromosome, fNumOfTeams);
  for i := 0 to fNumOfTeams - 1 do
  begin
    Chromosome[i].ID := i;
    Chromosome[i].Lane := i mod fNumOfPoolLanes;
    SetLength(Chromosome[i].Entrants, fNumOfEntrantsPerTeam);
    for j := 0 to fNumOfEntrantsPerTeam - 1 do
    begin
      Chromosome[i].Entrants[j] := Random(fNumOfNominees);
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


end.
