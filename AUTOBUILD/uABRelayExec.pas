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
    FConnection: TFDConnection;
    fDistanceID: integer;
    fEventID: integer;
    { private declarations }
    fExcludeOutsideLanes: boolean;
    fHeatAlgorithm: integer;
    fIndvDistanceMetres: integer;
    fNumOfHeats: integer;
    fNumOfNominees: integer;
    fNumOfPoolLanes: integer; // takes into consideration preferences for gutter lanes.
    fNumOfSwimmers: integer;
    fNumOfSwimmersPerTeam: integer;
    fNumOfTeams: integer;
    fNumOfTeamsPerHeat: integer;
    fRaceTimeBottomPercent: integer;
    fSeedDepth: integer;
    fSeedMethod: integer;
    fSeperateGender: boolean;
    fStrokeID: integer;
    fSuccess: boolean;
    fTeamDistanceMetres: integer;
    fUseDefRaceTime: boolean;
    fVerbose: boolean;
    Generations: Integer; // = 1000;
    // An array of heats.
    Heats: array of THeat;
    MutationRate: Double; // = 0.01;
    // An array of swimmers, used by 'bin packing routine' using a genetic algorithm.
    Population: array of TChromosome;
    PopulationSize: Integer; // ... fNumOfSwimmers.
    // D Y N A M I C   A R R A Y S .
    // Nominee Database Pool : swimmers who nominated for the event.
    Swimmers: array of TSwimmer;
    // An array of teams - each team will contain MemberID x fNumOfSwimmersPerTeam.
    Teams: array of TTeam;
    // B i n   p a c k i n g   r o u t i n e s .
    function Crossover(Parent1, Parent2: TChromosome): TChromosome;
    function Fitness(Chromosome: TChromosome): Double;
    function GeneticAlgorithm: Boolean;
    function GetDistanceID(EventID: integer): integer;
    function GetNumberOfNominees(AEventID: Integer): integer;
    function GetNumberOfSwimmersPerTeam(ADistanceID: integer): integer;
    function GetPoolLanes: integer;
    function GetStrokeID(AEventID: integer): integer;
    function GetTeamDistanceMetres(ADistanceID: integer): integer;
    function InitializePopulation: TChromosome;
    function InsertIntoTeams(): boolean;
    procedure Mutate(var Chromosome: TChromosome);
    procedure ReadPreferences(IniFileName: string);
    function RetriveSwimmingData(): boolean;
    procedure Swap(var A, B: Integer);
    function TournamentSelection: TChromosome;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { public declarations }
    procedure ExecAutoBuildRelay();
    procedure Prepare(AConnection: TFDConnection; AEventID: integer);
    { published declarations }
    property Success: boolean read fSuccess write fSuccess;
  end;

implementation

{ TAutoBuildRelayExec }

uses System.Math, System.IniFiles, SCMUtility,
  dmABRelayData, system.Generics.Collections, System.StrUtils;

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

procedure TABRelayExec.ExecAutoBuildRelay();
var
  IniFileName: TFileName;
  v: variant;
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
  s:= '''
  SELECT EventTypeID FROM [dbo].[Event]
  INNER JOIN [dbo].[Distance] ON Event.DistanceID = Distance.DistanceID
  WHERE EventID = :ID
  ''';

  v := SCM.scmConnection.ExecSQLScalar(s, [fEventID]);

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
  // Note: checks preferences - excluded outside lanes...
  fNumOfPoolLanes := GetPoolLanes;
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

  // use TeamNum or ABREV in dbo.Distance to calculate NumOfSwimmersInTeam.
  // On error returns default - 4 swimmers per team.
  fNumOfSwimmersPerTeam := GetNumberOfSwimmersPerTeam(fDistanceID);
  // use Meters in dbo.Distance to calculate team distance.
  // On error returns 0.
  fTeamDistanceMetres:= GetTeamDistanceMetres(fDistanceID);
  if (fTeamDistanceMetres = 0) then exit;
  // Individual Distance = the distance swum by each swimmer in the team.
  // WIT: 4x25m relay Total 100m ... entrants swim 25m.
  fIndvDistanceMetres := (fTeamDistanceMetres div fNumOfSwimmersPerTeam);
  // number of members who indicated that they wanted to swim the relay event.
  // Does not include members in raced or closed heats for this relay event.
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

  // D i s t r i b u t e  1 .  (Gender, house, etc)
  {TODO -oBSA -cAutoBuild Relays : Seperate gender}
  {TODO -oBSA -cAutoBuild Relays : Group by house}

  // Perfect number of swimmers - no partial teams.
  fNumOfSwimmers := fNumOfNominees - (fNumOfNominees mod fNumOfSwimmersPerTeam);
  // Perfect number of teams.
  fNumOfTeams := fNumOfSwimmers div fNumOfSwimmersPerTeam;

  {TODO -oBSA -cAutoBuild Relay : Enable the user to select nominees to trim. }
  if (fNumOfNominees > fNumOfSwimmers) then
  begin
    if fVerbose then
    begin
      s := '''
        Not enough swimmers to complete all teams.
        Spare entrants will be removed. (Slowest swimmers first. Nominations will remain).
        Manually assign these nominees - should you wish them to participate.
      ''';
      // if fVerbose then
      Application.MessageBox(Pchar(s), 'SwimClubMeet Warning', MB_ICONERROR or MB_OK);
    end;
  end;

  // D I S R I B U T E  - TEAMS ACROSS MULIT-HEATS.
  // check that the number of relay-teams doesn't exceed the number of lanes.
  if fNumOfTeams > fNumOfPoolLanes then
    fNumOfHeats := Ceil(fNumOfTeams / fNumOfPoolLanes)
  else
    fNumOfHeats := 1;
  // distribute evenly relay teams accross heats.
  fNumOfTeamsPerHeat := Ceil(fNumOfTeams / fNumOfHeats);

  {TODO -oBSA -cGeneral : Thread: AutoBuild Relays - Progress bar ....}

  // Clean OUT ALL HEATs, TEAMs, TEAMEntrants, TEAMSPLITs.
  // Does not remove raced or closed heats .
  SCM.Heat_DeleteAll(fEventID, true);

  // D I M   A R R A Y S . . .
  SetLength(Swimmers, fNumOfSwimmers);
  SetLength(Heats, fNumOfHeats);
  SetLength(Teams, fNumOfTeams);

  // R e t r i v e  S w i m m e r s .  Check - fSuccess.
  fSuccess := RetriveSwimmingData();

  if fSuccess then
  begin
    // Process the data using Genetic Algorithm.
    PopulationSize := fNumOfSwimmers; // perfect number of swimmers.
    fSuccess := GeneticAlgorithm();
    if fSuccess then
    begin
      fSuccess := InsertIntoTeams();
      // D i s t r i b u t e  2 .  (Gender, house, etc)
      // if fSuccess then DistributeTeams(FDQuery);
    end;
  end;

  // Refresh UI and data
  //  if Owner is TForm then
  //    SendMessage(TForm(Owner).Handle, SCM_AUTOBUILDRELAYSFIN, 0, 0);
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

function TABRelayExec.GeneticAlgorithm: boolean;
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

  result := true;
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

function TABRelayExec.GetNumberOfNominees(AEventID: Integer): integer;
var
  v: variant;
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
  // The query is unlikely to return NULL as this is trapped in the
  // MS SQL script - using ...
  // SELECT ISNULL(Count(NomineeID), 0) AS CountNominees...
  if VarIsNull(v) or (v=0) then exit;
  Result := v;
end;

function TABRelayExec.GetNumberOfSwimmersPerTeam(ADistanceID: integer): integer;
var
  s: string;
  i: integer;
begin
  result := 4; // Default is 4 swimmers in a each team.
  if not assigned(ABRelayData) then exit;
  // Use TeamNum column (db1.1.5.4) - if available
  ABRelayData.qryTNum.Close;
  ABRelayData.qryTNum.ParamByName('DistanceID').AsInteger := ADistanceID;
  ABRelayData.qryTNum.Prepare;
  ABRelayData.qryTNum.Open;

  if not ABRelayData.qryTNum.Active then exit;
    i := ABRelayData.qryTNum.FieldByName('TNum').AsInteger;
  if (i > 0) then
    result := i //
  else
  begin
    // use ABREV : extract swimmers per team. (example text '4x100')
    s := ABRelayData.qryTNum.FieldByName('ABREV').AsString;
    if (Pos('x', s) = 0) then exit; // bad syntax
    s := Copy(s, 1, Pos('x', s) - 1); // the team size. Swimmers per team.
    i := StrToIntDef(s, 0); // bad syntax - not a number
    if (i > 0) then
      result := i; // return team size else use default (4).
  end;
end;

function TABRelayExec.GetPoolLanes: integer;
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

function TABRelayExec.GetTeamDistanceMetres(ADistanceID: integer): integer;
var
  v: variant;
  s: string;
begin
  result := 0;
  { NOTE: Using American English 'Meters' NOT British English 'metres'}
  s := '''
    SELECT Meters FROM [dbo].[Distance]
    WHERE DistanceID = :ID
  ''';
  v := SCM.scmConnection.ExecSQLScalar(s, [ADistanceID]);
  if not VarIsNull(v) then
    result := v;
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

function TABRelayExec.InsertIntoTeams: Boolean;
var
  qry1, qry2, qry3: TFDQuery;
  AHeatID: integer;
  ATeamID: integer;
  ATeamEntrantID: integer;
  ATeamNameID: integer;
  s: string;
  i, j, m, n, p, r, lanenum: integer;
begin
  result := false;
  qry1 := TFDQuery.Create(nil);
  qry2 := TFDQuery.Create(nil);
  qry3 := TFDQuery.Create(nil);

  qry1.Connection := SCM.scmConnection;
  qry2.Connection := SCM.scmConnection;
  qry3.Connection := SCM.scmConnection;

  for j := Low(Heats) to High(Heats) do
  Begin
    // Insert into dbo.HeatIndividual
    // HeatTypeID - Heat, HeatStatus - open, HeatNum - (1 ... )
    s := '''
    INSERT INTO HeatIndividual (EventID, HeatNum, OpenDT, HeatTypeID, HeatStatusID)
    VALUES (:EVENTID, :HEATNUM, GETDATE(), 1, 1)';
    ''';
    qry1.SQL.Text := s;
    qry1.ParamByName('EVENTID').AsInteger := fEventID;
    qry1.ParamByName('HEATNUM').AsInteger := Heats[j].HeatNum;
    qry1.ExecSQL;
    // Get the newly created heat's record ID.
    AHeatID := qry1.Connection.GetLastAutoGenValue('HeatID');

    { T E A M N A M E   I D . }
    // dbo.TeamName is a table filled with ID's starting from 1 .. 26
    //  and Caption's (1)'TeamA' ... (26)'TeamZ'.
    ATeamNameID := ABRelayData.GetLastTeamNameID(fEventID);

    for i := 0 to fNumOfTeamsPerHeat - 1 do
    begin
      s := '''
      INSERT INTO Team (Lane, TeamNameID, HeatID)
      VALUES (:LANE, :TEAMNAMEID, :HEATID);
      ''';
      // Insert into Team table
      qry2.SQL.Text := s;
        // place team in lane - using center lanes first.
      lanenum :=  SCMUtility.ScatterLanes(Teams[i].Lane, fNumOfPoolLanes);
      qry2.ParamByName('LANE').AsInteger := lanenum;
      inc(ATeamNameID, 1);
      qry2.ParamByName('TEAMNAMEID').AsInteger := ATeamNameID;
      qry2.ParamByName('HEATID').AsInteger := AHeatID; // Base zero.
      qry2.ExecSQL;
      // Get the new team record's ID
      ATeamID := qry2.Connection.GetLastAutoGenValue('TeamID');

      {TODO -oBSA -cAutoBuild Relay :
        Sort entrants - Fastest last, 2nd fastest first, etc... }
      p := 1; // Swimming order 1 to NumOfEntrantsPerTeam.

      // Insert into TeamEntrant table.
      for m := Low(Teams[i].Entrants) to High(Teams[i].Entrants) do
      begin
        s := '''
        INSERT INTO TeamEntrant
        (MemberID, Lane, TeamID, PersonalBest, TimeToBeat, StrokeID, IsDisqualified)
        VALUES
        (:MEMBERID, :LANE, :TEAMID, :PB, :TTB, :STROKEID, 0);
        ''';
        qry3.SQL.Text := s;
        qry3.ParamByName('MEMBERID').AsInteger := Teams[i].Entrants[m];
        qry3.ParamByName('LANE').AsInteger := p;
        qry3.ParamByName('TEAMID').AsInteger := ATeamID;
        qry3.ParamByName('STROKEID').AsInteger := fStrokeID;
        // TeamEntrant.Disqualified - BIT : NOT NULL
        // qry3.ParamByName('DISQUALIFIED').AsBoolean := false;

        // locate swimmer in Swimmers...
        for r  := Low(Swimmers) to High(Swimmers) do
        begin
          if Swimmers[r].MemberID = Teams[i].Entrants[m] then
          begin
            qry3.ParamByName('PB').AsTime := Swimmers[r].PB;
            qry3.ParamByName('TTB').AsTime := Swimmers[r].TTB;
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

  result := true;

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

function TABRelayExec.RetriveSwimmingData(): boolean;
var
  i: integer;
  qry: TFDQuery;
begin
  {
  Retrieve Swimmer Data: Fetch swimmers’ data from the Nominee table,
  focusing on their MemberID TTB (TimeToBeat) and PB (Personal Best) times.
  }
  result := false;
  qry := ABRelayData.qryRelayNominee; // improves reability.

  qry.Close;
  // Relay Event ID.
  qry.ParamByName('EVENTID').AsInteger := fEventID;
  // 0,1,2 - Default: 1. The avgerage of the 3 fastest race times.
  qry.ParamByName('ALGORITHM').AsInteger := fHeatAlgorithm;
  // Lastname, firstname (format for display of entrants name)
  qry.ParamByName('TOGGLENAME').AsBoolean := true;
  // if then entrant has no race history then ...
  // Calculate a race time based on the mean average of the bottom...
  qry.ParamByName('CALCDEFAULT').AsInteger := 1;
  // ... bottom precent (Default is 50%)
  qry.ParamByName('BOTTOMPERCENT').AsFloat := fRaceTimeBottomPercent;
  // Distance swum by a swimmer in the Team-Relay.
  // Relay's total distance DIV number of swimmers in the relay-team.
  qry.ParamByName('XDISTANCEID').AsInteger := fIndvDistanceMetres;
  // Perfect number of swimmers to fill ALL relay-teams perfectly.
  qry.ParamByName('TOPNUMBER').AsInteger := fNumOfSwimmers;
  qry.Prepare;
  qry.Open;

  if not qry.Active then exit;

  if qry.IsEmpty then
  begin
    qry.Close;
    exit;
  end;

  // Populate the array with swimmers.
  // ARRAY SIZE: Perfect number of swimmers = qry.RecordCount.
  try
    for I := Low(Swimmers) to High(Swimmers) do
    begin
      Swimmers[i].MemberID := qry.FieldByName('MemberID').AsInteger;
      Swimmers[i].NomineeID := qry.FieldByName('NomineeID').AsInteger;
      Swimmers[i].TTB := qry.FieldByName('TTB').AsDateTime;
      Swimmers[i].PB := qry.FieldByName('PB').AsDateTime;
      qry.Next;
    end;
  except on E: Exception do
      exit;
  end;

  result := true;

end;

procedure TABRelayExec.Swap(var A, B: Integer);
var
  Temp: Integer;
begin
  Temp := A;
  A := B;
  B := Temp;
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




end.
