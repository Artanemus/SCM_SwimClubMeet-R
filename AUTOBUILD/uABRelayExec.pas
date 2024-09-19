unit uABRelayExec;

interface

uses
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
System.Classes, dmSCM, dmSCMHelper,
FireDAC.Comp.Client, FireDAC.Stan.Param,
Vcl.Forms, SCMDefines, Data.DB;



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

  TABRelayExec = class(TComponent)
  private

    { private declarations }
    fExcludeOutsideLanes: boolean;
    fVerbose: boolean;
    fHeatAlgorithm: integer;
    fRaceTimeBottomPercent: integer;
    fUseDefRaceTime: boolean;
    fSeperateGender: boolean;
    fSeedMethod: integer;
    fSeedDepth: integer;
    fSuccess: boolean;
    FConnection: TFDConnection;
    fEventID: integer;
    fDistanceID: integer;
    fStrokeID: integer;

    fTeamDistanceMetres: integer;
    fIndvDistanceMetres: integer;

    fNumOfTeams: integer;
    fNumOfNominees: integer;
    fNumOfSwimmers: integer;
    fNumOfHeats: integer;
    fNumOfSwimmersPerTeam: integer;
    fNumOfTeamsPerHeat: integer;
    fNumOfPoolLanes: integer; // takes into consideration preferences for gutter lanes.

    // D Y N A M I C   A R R A Y S .
    // Nominee Database Pool : swimmers who nominated for the event.
    Swimmers: array of TSwimmer;
    // An array of heats.
    Heats: array of THeat;
    // An array of teams - each team will contain MemberID x fNumOfSwimmersPerTeam.
    Teams: array of TTeam;
    // An array of swimmers, used by 'bin packing routine' using a genetic algorithm.
    Population: array of TChromosome;

    PopulationSize: Integer; // ... fDivNumOfSwimmers.
    Generations: Integer; // = 1000;
    MutationRate: Double; // = 0.01;


    function GetPoolLaneCount: integer;
    function GetNumberOfSwimmersPerTeam(EventID: integer): integer;
    function GetIndvDistanceMetres(EventID, fNumOfSwimmersPerTeam: integer): integer;
    function GetStrokeID(AEventID: integer): integer;
    function GetDistanceID(EventID: integer): integer;

    procedure ReadPreferences(IniFileName: string);
    procedure RetriveSwimmingData(AEventID, fNumOfPoolLanes, fNumOfSwimmersPerTeam: integer);
    procedure InsertIntoTeams();

    // B i n   p a c k i n g   r o u t i n e s .
    function Crossover(Parent1, Parent2: TChromosome): TChromosome;
    function Fitness(Chromosome: TChromosome): Double;
    procedure GeneticAlgorithm;
    function GetNumberOfNominees(AEventID: Integer): integer;
    function InitializePopulation: TChromosome;
    procedure Mutate(var Chromosome: TChromosome);
    procedure Swap(var A, B: Integer);
    function TournamentSelection: TChromosome;
    function GetXDistanceID(EventID, fNumOfSwimmersPerTeam: integer): integer;



    // procedure Distribute(FDQuery: TFDQuery; AEventID: integer);

  protected
    { protected declarations }


  public
    { public declarations }
    procedure ExecAutoBuildRelay();
    procedure Prepare(AConnection: TFDConnection; AEventID: integer);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { published declarations }
    property Success: boolean read fSuccess write fSuccess;

  end;

implementation

{ TAutoBuildRelayExec }

uses System.Math, System.IniFiles, SCMUtility,
  dmABRelayData, system.Generics.Collections;

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
  fDistanceID := 1;
  FConnection := nil;
  fTeamDistanceMetres:=0;
  fIndvDistanceMetres:=0;
  fStrokeID := 1;
  fSuccess := false;

  // I N I T I A L I Z E   P R E F E R E N C E S .
  fExcludeOutsideLanes := false;
  fHeatAlgorithm := 1;
  fNumOfSwimmersPerTeam := 4;
  fRaceTimeBottomPercent := 50;
  fVerbose := false;
  fRaceTimeBottomPercent := 50;
  fUseDefRaceTime := true;
  fSeperateGender := false;
  fSeedMethod := 0;
  fSeedDepth := 3;

  PopulationSize := 100;
  Generations := 1000;
  MutationRate := 0.01;

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
  fNumOfPoolLanes: integer;
  s: string;
begin
  // A S S E R T .
  fSuccess := false;
  // data module : use Prepare to initialize...
  if not assigned(ABRelayData) then exit;
  if fEventID = 0 then exit;
  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then ReadPreferences(IniFileName);
  // C h e c k   e v e n t   t y p e  .
  v :=
    SCM.scmConnection.ExecSQLScalar
    ('SELECT EventTypeID FROM [dbo].[Event] WHERE EventID = :ID', [fEventID]);

  if VarIsNull(v) then  // Is this a team event?
  begin
    if fVerbose then
    begin
      s := '''
      Event type isn't known by Auto-Build.
      Auto-Build ENDED.
      ''';
      Application.MessageBox(PChar(s), 'Auto Build Relays Error', MB_OK);
    end;
    exit;
  end;
  if (v <> 2) then
  begin
    if fVerbose then
    begin
      s := '''
      This event isn''t a relay.
      Auto-Build ENDED.
      ''';
      Application.MessageBox(PChar(s), 'Auto Build Relays Error', MB_OK);
    end;
    exit; // event type not a team event.
  end;

  // S t r o k e I D .
  fStrokeID := GetStrokeID(fEventID);
  // C h e c k   s w i m m i n g   s t r o k e .

  if (fStrokeID = 0) or (fStrokeID > 4) then
  begin
    if fVerbose then
    begin
      case fStrokeID of
        5: // Is Medley team relays OK?
        s := '''
        Medley Relays cannot be constructed by Auto-Built.
        Auto-Build ENDED.
        ''';
        else // NOT FS,BK, BS, BF ?
        s := '''
        The swimming stroke is not accepted by Auto-Build.
        Auto-Build ENDED.
        ''';
      end;
      Application.MessageBox(PChar(s), 'Auto Build Relays Error', MB_ICONERROR or MB_OK);
    end;
    exit;
  end;

  // D i s t a n c e I D .
  fDistanceID := GetDistanceID(fEventID);
  // C h e c k  P o o l   l a n e s .
  fNumOfPoolLanes := GetPoolLaneCount;
  // A S S E R T .
  if fNumOfPoolLanes = 0 then
  begin
    if fVerbose then
    begin
      s := '''
      No pool lanes are available. Check your swim-club preferences.
      Auto-Build ENDED.
      ''';
      Application.MessageBox(PChar(s), 'SwimClubMeet Error', MB_ICONERROR or MB_OK)
    end;
    exit;
  end;

  // use ABREV in dbo.Distance to calculate NumOfSwimmersInTeam.
  // TODO:
  fNumOfSwimmersPerTeam := GetNumberOfSwimmersPerTeam(fDistanceID);
  // use Meters in dbo.Distance to calculate team distance.
  fTeamDistanceMetres:= 0;
  // Individual Distance = the distance swum by each swimmer in the team.
  // WIT: 4x25m relay Total 100m ... entrants swim 25m.
  fIndvDistanceMetres := GetIndvDistanceMetres(fEventID, fNumOfSwimmersPerTeam);
  // use ABREV in dbo.Distance to calculate indv distance.
  fIndvDistanceMetres:= 0;

  fNumOfNominees := GetNumberOfNominees(fEventID);
  if fNumOfNominees = 0 then // No swimmers!.
  begin
    if fVerbose then
    begin
      s := '''
        No nominees were found for the team event.
        Note: Nominees for this event that have been raced or close are excluded.
        Auto-build ENDED.
      ''';
      Application.MessageBox(Pchar(s), 'Auto Build Relay', MB_ICONEXCLAMATION or MB_OK);
    end;
    exit;
  end;

  // Perfect number of swimmers - no partial teams.
  fNumOfSwimmers := v - (v mod fNumOfSwimmersPerTeam);
  // Perfect number of teams.
  fNumOfTeams := v div fNumOfSwimmers;

  {TODO -oBSA -cAutoBuild Relay : Enable the user to select nominees to trim. }
  if (fNumOfNominees > fNumOfSwimmers) then
  begin
    if fVerbose then
    begin
      s := '''
        Not enough swimmers to complete all teams.
        Entrants will be removed (slowest swimmer first. Nomination will remain).
        Manually assign these nominees - should you wish them to participate.
      ''';
      // if fVerbose then
      Application.MessageBox(Pchar(s), 'SwimClubMeet Warning', MB_ICONERROR or MB_OK);
    end;
  end;

  // D I S R I B U T E  - TEAMS ACROSS MULIT-HEATS.
  // check that the number of relay-teams doesn't exceed the number of lanes.
  if fNumOfTeams > fNumOfPoolLanes then
  fNumOfHeats := Ceil(fNumOfTeams / fNumOfPoolLanes);
  // distribute evenly relay teams accross heats.
  fNumOfTeamsPerHeat := Ceil(fNumOfTeams / fNumOfHeats);




  // Assign params passed.
  fNumOfPoolLanes := fNumOfPoolLanes;


  {TODO -oBSA -cGeneral : Thread: AutoBuild Relays - Progress bar ....}

  // Clean OUT ALL HEATs, TEAMs, TEAMEntrants, TEAMSPLITs.
  // Does not remove raced or closed heats .
  SCM.Heat_DeleteAll(fEventID, true);
  // D i s t r i b u t e  1 .  (Gender, house, etc)

  // R e t r i v e .  Check - fSuccess.
  RetriveSwimmingData(fEventID, fNumOfPoolLanes, fNumOfSwimmersPerTeam);
  if fSuccess then
  begin
    // Process the data using Genetic Algorithm
    GeneticAlgorithm();
    if fSuccess then InsertIntoTeams();
    // D i s t r i b u t e  2 .  (Gender, house, etc)
    // if fSuccess then DistributeTeams(FDQuery);
  end;

  // Refresh UI and data
  //  if Owner is TForm then
  //    SendMessage(TForm(Owner).Handle, SCM_AUTOBUILDRELAYSFIN, 0, 0);
end;

function TABRelayExec.GetDistanceID(EventID: integer): integer;
var
  v: variant;
begin
  result := 0;
  v := SCM.scmConnection.ExecSQLScalar
  ('SELECT DistanceID FROM [dbo].[Event] WHERE EventID = :ID', [EventID]);
  if not VarIsNull(v) then
    result := v
end;

function TABRelayExec.GetIndvDistanceMetres(EventID,
  fNumOfSwimmersPerTeam: integer): integer;
begin

end;

function TABRelayExec.GetNumberOfSwimmersPerTeam(EventID: integer): integer;
var
  v: variant;
  s: string;
begin
  result := 0;
  s := '''
  SELECT ABREV FROM [SwimClubMeet].[dbo].[Event]
  INNER JOIN [dbo].[Distance] ON [Event].DistanceID = [Distance].[DistanceID]
  WHERE EventID = :ID
  ''';
  v := SCM.scmConnection.ExecSQLScalar(s, [EventID]);
  if VarIsNull(v) then exit;

end;

function TABRelayExec.GetPoolLaneCount: integer;
var
  Lanes: integer;
begin
  result := 0;
  // Get number of lanes from dbo.SwimClub.NumOfLanes
  Lanes := SCM.SwimClub_NumberOfLanes;
  // Adjust lanes if excluding outside lanes
  if (fExcludeOutsideLanes) then Dec(Lanes, 2);
  // Ensure there is at least one lane
  if (Lanes < 1) then Exit;
  result := Lanes;
end;

function TABRelayExec.GetStrokeID(AEventID: integer): integer;
var
  v: variant;
begin
  result := 0;
  v := SCM.scmConnection.ExecSQLScalar
    ('SELECT StrokeID FROM [dbo].[Event] WHERE [EventID] = :ID', [AEventID]);
  if not VarIsNull(v) then
    result := v;
end;

function TABRelayExec.GetXDistanceID(EventID,
  fNumOfSwimmersPerTeam: integer): integer;
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
    meters := Floor(v/fNumOfSwimmersPerTeam);
    // cross reference value 'meters' to find the XDistanceID for a swimmer.
    v := SCM.scmConnection.ExecSQLScalar('''
    SELECT[DistanceID]
    FROM[SwimClubMeet].[dbo].[Distance]
    WHERE[meters] = :ID AND [EventTypeID] = 1
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

    for i := 0 to fNumOfTeamsPerHeat - 1 do
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

procedure TABRelayExec.Prepare(AConnection: TFDConnection; AEventID: Integer);
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
  fExcludeOutsideLanes := (i = 1);

  // 2024-09-10
  // Relay teams, by default, have four swimmers.
  fNumOfSwimmersPerTeam := iFile.ReadInteger('Preferences', 'NumOfSwimmersPerTeam', 4);
  // Verbose. Message all errors.
  i := iFile.ReadInteger('Preferences', 'Verbose', 0);
  fVerbose  := (i = 1);

  // TTB defaults to (1) .. the entrant's average of top 3 race-times
  fHeatAlgorithm :=
    (iFile.ReadInteger('Preferences', 'HeatAlgorithm', 1));

  // default to - get an average race-time of other swimmers
  i := iFile.ReadInteger('Preferences',  'UseDefRaceTime', 1);
  fUseDefRaceTime  := (i = 1);

  // The bottom percent to select from ... default is 50%
  fRaceTimeBottomPercent :=
    (iFile.ReadInteger('Preferences', 'RaceTimeTopPercent', 50));

  i := iFile.ReadInteger('Preferences', 'SeperateGender', 0);
  fSeperateGender := (i = 1);

  // SCM default seeding.
  fSeedMethod := iFile.ReadInteger('Preferences', 'SeedMethod', 0);

  // 2020-11-01 auto-build v2 seed depth for Circle Seed */
  fSeedDepth := (iFile.ReadInteger('Preferences', 'SeedDepth', 3));

  iFile.free;
end;

procedure TABRelayExec.RetriveSwimmingData(AEventID, fNumOfPoolLanes,
  fNumOfSwimmersPerTeam: Integer);
var
  StrokeID, xDistanceID, i: integer;
  qry: TFDQuery;
begin
{
Retrieve Swimmer Data: Fetch swimmers’ data from the Nominee table,
focusing on their MemberID TTB (TimeToBeat) and PB (Personal Best) times.
}


  qry := ABRelayData.qryRelayNominee;  // improves reability.

    qry.Close;
    qry.ParamByName('TOPNUMBER').AsInteger := fNumOfSwimmers;
    qry.ParamByName('EVENTID').AsInteger := AEventID;
    qry.ParamByName('SESSIONSTART').AsDateTime := SCM.Session_Start;
    qry.ParamByName('XDISTANCEID').AsDateTime := xDistanceID;
    qry.ParamByName('STROKEID').AsDateTime := StrokeID;
    qry.ParamByName('ALGORITHM').AsDateTime := fHeatAlgorithm;
    qry.ParamByName('BOTTOMPERCENT').AsDateTime := fRaceTimeBottomPercent;
    qry.Prepare;
    qry.Open;

    if not qry.Active then exit;


    if qry.IsEmpty then
    begin
      qry.Close;
      fSuccess := false;
      exit;
    end;

    // DIM ARRAY -
    SetLength(Swimmers, fNumOfSwimmers);
    // iterate through the list of nominees
    for I := Low(Swimmers) to High(Swimmers) do
    begin
      Swimmers[i].MemberID := qry.FieldByName('MemberID').AsInteger;
      Swimmers[i].NomineeID := qry.FieldByName('NomineeID').AsInteger;
      Swimmers[i].TTB := qry.FieldByName('TTB').AsDateTime;
      Swimmers[i].PB := qry.FieldByName('pB').AsDateTime;
      qry.Next;
    end;

    SetLength(Heats, fNumOfHeats);
    SetLength(Teams, fNumOfTeams);



end;


function TABRelayExec.InitializePopulation: TChromosome;
var
  i, j: Integer;
  Chromosome: TChromosome;
begin
  SetLength(Chromosome, fNumOfTeams);
  for i := 0 to fNumOfTeams - 1 do
  begin
    Chromosome[i].ID := i;
    Chromosome[i].Lane := i mod fNumOfPoolLanes;
    SetLength(Chromosome[i].Entrants, fNumOfSwimmersPerTeam);
    for j := 0 to fNumOfSwimmersPerTeam - 1 do
    begin
      Chromosome[i].Entrants[j] := Random(fNumOfSwimmers);
    end;
  end;
  Result := Chromosome;
end;

function TABRelayExec.Fitness(Chromosome: TChromosome): Double;
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

function TABRelayExec.TournamentSelection: TChromosome;
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

function TABRelayExec.Crossover(Parent1, Parent2: TChromosome): TChromosome;
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

procedure TABRelayExec.Swap(var A, B: Integer);
var
  Temp: Integer;
begin
  Temp := A;
  A := B;
  B := Temp;
end;

procedure TABRelayExec.Mutate(var Chromosome: TChromosome);
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

procedure TABRelayExec.GeneticAlgorithm;
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

function TABRelayExec.GetNumberOfNominees(AEventID: Integer): integer;
var
  v: variant;
  s: string;
begin
  Result := 0;
  // Test for nominees. Count total number of nominees.
  ABRelayData.qryCountRNominee.Close;
  ABRelayData.qryCountRNominee.ParamByName('EVENTID').AsInteger := AEventID;
  ABRelayData.qryCountRNominee.Prepare;
  ABRelayData.qryCountRNominee.Open;
  if ABRelayData.qryCountRNominee.Active then
    v := ABRelayData.qryCountRNominee.FieldByName('CountNominees').AsInteger;
  ABRelayData.qryCountRNominee.Close;
  if VarIsNull(v) or (v=0) then exit;
  Result := v;
end;



end.
