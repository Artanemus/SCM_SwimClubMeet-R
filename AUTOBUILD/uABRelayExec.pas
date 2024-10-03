unit uABRelayExec;

interface

uses
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
System.Classes, dmSCM, dmSCMHelper,
FireDAC.Comp.Client, FireDAC.Stan.Param,
Vcl.Forms, SCMDefines, Data.DB;



type

  // T E A M .
  TTeam = record
    TeamID: Integer; // IDENITY of dbo.TeamID.
    TeamNameID: integer; // IDENITY of dbo.TeamNameID.
    Lane: Integer;   // Lane number.
    idxSwimmer: array of integer; // Holds index of TSwimmer.
    HeatID: Integer;
    SumNormTTB: TTime;  // The sum of NormTTB of each swimmer.
    Deviation: double;  // Deviation from the average relay swimming time
  end;
  // H E A T .
  THeat = record
    ID: integer;
    HeatNum: integer;
    EventID: integer;
  end;
  // S W I M M E R .
  TSwimmer = record
    NomineeID: Integer; // Nomination ID for the swimmer in dbo.Nominee.
    MemberID: Integer; // Member ID for the swimmer used in dbo.Member table
    TTB: TTime; // Time-to-beat. Estimated (calculated) swimming for XDistance.
    PB: TTime; // Personal Best swimming time for the swimmer for the event.
    NormTTB: double; // normalized TTB.
  end;

  TTeamArray = array of TTeam; // genetic algorithm


  TABRelayExec = class(TComponent)
  private
    FConnection: TFDConnection;
    fDistanceID: integer;
    fEventID: integer;
    { private declarations }
    fExcludeOutsideLanes: boolean;
    fHeatAlgorithm: integer;
    fIndvDistanceMetres: integer; // distance swum by each swimmer in relay.
    fxDistanceID: integer; // lookup value gained from fIndvDistanceMetres.
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
    fAcceptedMarginOfDeviation: double; // packing bin algorithm
    fIterations: Integer; // genetic algorithm default = 1000.
    fPackAlgorithm: integer;
    fAcceptableMargin: integer; // Refined Algorithm - default 20 percent.

    { C A L C   R A C E - T I M E . }
    fAvgINDVNormTTB: double; // Average optimum INDV TTB - normalized.
    fAvgTEAMNormTTB: double; // Average optimum TEAM TTB - normalized.

    // D Y N A M I C   A R R A Y S .
    Heats: array of THeat; // An array of heats.
    // Nominee Database Pool : swimmers who nominated for the event.
    Swimmers: array of TSwimmer;
    // An array of teams - each team will contain MemberID x fNumOfSwimmersPerTeam.
    Teams: array of TTeam;

    function GetDistanceID(EventID: integer): integer;
    function GetxDistanceID(AMeters: integer): integer;
    function GetNumberOfNominees(AEventID: Integer): integer;
    function GetNumberOfSwimmersPerTeam(ADistanceID: integer): integer;
    function GetPoolLanes: integer;
    function GetStrokeID(AEventID: integer): integer;
    function GetTeamDistanceMetres(ADistanceID: integer): integer;
    function InsertIntoTeams(): boolean;
    procedure ReadPreferences(IniFileName: string);
    function RetriveSwimmingData(): boolean;


    // B i n   p a c k i n g   r o u t i n e s .
    { R O U T I N E S . }
    procedure GetAvgDeviation(var LowAvg: double; var HighAvg: double);
    function CalculateAcceptableMargin(Percent: integer): double;
    procedure NormalizeINDV_TTB;
    procedure FirstFit;
    procedure SecondFit(Percent: integer);
    procedure ThirdFit(Percent: integer);
    procedure GeneticAlgorithm;


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

function TABRelayExec.CalculateAcceptableMargin(Percent: integer): double;
var
  LowAvg, HighAvg: double;
begin
  // Calculate average deviations
  GetAvgDeviation(LowAvg, HighAvg);

  // Check for division by zero
  if (LowAvg = 0) and (HighAvg = 0) then
    Result := 0
  else
    Result := (Percent/100) * (LowAvg + HighAvg) / 2; // 60% of the average deviation
end;

constructor TABRelayExec.Create(AOwner: TComponent);
begin
  inherited;
  fEventID := 0;
  fDistanceID := 1; // 25m
  fStrokeID := 1; // feestyle
  fxDistanceID := 0;
  FConnection := nil;
  fTeamDistanceMetres:=0;
  fIndvDistanceMetres:=0;
  fSuccess := false;
  fAcceptedMarginOfDeviation := 0;
  fIterations := 1000;
  fAcceptableMargin := 20;

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
  fNumOfPoolLanes := 8;
  fPackAlgorithm := 0;

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
  s: string;
  i: integer;
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

  v := fConnection.ExecSQLScalar(s, [fEventID]);

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
  fxDistanceID := GetxDistanceID(fIndvDistanceMetres);


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
  // populate array Swimmers.
  // ORDER BY fastest first.
  fSuccess := RetriveSwimmingData();
  if not fSuccess then
  begin
    if fVerbose then
    begin
      s := '''
        While reteving data from the SCM database an unknown error occurred.
        Auto-build ENDED.
      ''';
      Application.MessageBox(Pchar(s), 'SwimClubMeet Error', MB_ICONERROR or MB_OK);
    end;
  exit;
  end;

  // Normalize the TTB for all swimmers.
  // this routine also calculates the average TTB (normalized) for a swimmer.
  NormalizeINDV_TTB;

  // Optimum swimming time for all teams.
  fAvgTEAMNormTTB := fAvgINDVNormTTB * fNumOfSwimmersPerTeam;
  case fPackAlgorithm of
    0:
    begin
      FirstFit; // First fit. Scatter swimmers across teams.
      SecondFit(60); // Find most (+/-) deviation and swap swimmers.
      SecondFit(50); // Find most (+/-) deviation and swap swimmers.
      SecondFit(40); // Find most (+/-) deviation and swap swimmers.
    end;
    1:
    begin
      FirstFit;   // First fit. Scatter swimmers across teams.
      // Find most (+/-) deviation and swap swimmers. default 20 percent
      SecondFit(fAcceptableMargin); // Find most (+/-) deviation and swap swimmers.
      i := (fAcceptableMargin - 10);
      if (i<10)  then i := 10;
      ThirdFit(i); // Refine deviation until within margin or looped fIterations.
    end;
    2:
    begin
      FirstFit; // First fit. Scatter swimmers across teams.
//      GeneticAlgorithm; // A Generic Algorithm - slower, perhaps better?
      s := '''
        The Genetic Algorithm option is not available for this build.
        Auto-build ENDED.
      ''';
      Application.MessageBox(Pchar(s), 'SwimClubMeet AutoBuild', MB_ICONINFORMATION or MB_OK);
    end;
  end;

  // D i s t r i b u t e  2 .  (Gender, house, etc)
  // if fSuccess then DistributeTeams(FDQuery);
  fSuccess := InsertIntoTeams();

  // Refresh UI and data
  //  if Owner is TForm then
  //    SendMessage(TForm(Owner).Handle, SCM_AUTOBUILDRELAYSFIN, 0, 0);
end;

procedure TABRelayExec.FirstFit;
var
  I, j, k, swimmer: Integer;
  d: TTime;
  fwd: Boolean;
begin
  { first fit of swimmers into teams.}
  I := 0;

  { number of swimmers per team - initialize ARRAY: idxSwimmer in TTeams.}
  for j := Low(Teams) to High(Teams) do
    SetLength(Teams[j].idxSwimmer, fNumOfSwimmersPerTeam);

  { Scatter swimmers }
  fwd := True;
  for k := 0 to (fNumOfSwimmersPerTeam - 1) do
  begin
    if fwd then
    begin
      for j := Low(Teams) to High(Teams) do
      begin
        if I > High(Swimmers) then break;
        Teams[j].idxSwimmer[k] := I;
        inc(I);
      end;
    end
    else
    begin
      for j := High(Teams) downto Low(Teams) do
      begin
        if I > High(Swimmers) then break;
        Teams[j].idxSwimmer[k] := I;
        inc(I);
      end;
    end;
    fwd := not fwd;  { Toggle the direction }
    if I > High(Swimmers) then break;
  end;

  { calculate SumNormTTB and deviation }
  for j := Low(Teams) to High(Teams) do
  begin
    d := 0;
    for k := Low(Teams[j].idxSwimmer) to High(Teams[j].idxSwimmer) do
    begin
      swimmer := Teams[j].idxSwimmer[k];
      d := d + Swimmers[Swimmer].NormTTB;
    end;
    Teams[j].SumNormTTB := d;
    Teams[j].Deviation := fAvgTEAMNormTTB - d;
  end;
end;

procedure TABRelayExec.GeneticAlgorithm;
const
  PopulationSize = 1000;
  MaxGenerations = 100;
  MutationRate = 0.01;
var
  Population: array of TTeamArray;
  NewPopulation: array of TTeamArray;
  Generation, i, j, k: Integer;
  BestFitness: Double;

  procedure CopyPopulation(var Dest: array of TTeamArray; const Src: array of TTeamArray);
  var
    i, j, k: Integer;
  begin

// caller ....
//  CopyPopulation(Population, NewPopulation);

    SetLength(Population, Length(Src));  // Dest = Population
    for i := Low(Src) to High(Src) do
    begin
      SetLength(Dest[i], Length(Src[i]));
      for j := Low(Src[i]) to High(Src[i]) do
      begin
        // Initialize the TTeam record
        Dest[i][j].TeamID := Src[i][j].TeamID;
        Dest[i][j].TeamNameID := Src[i][j].TeamNameID;
        Dest[i][j].Lane := Src[i][j].Lane;
        Dest[i][j].HeatID := Src[i][j].HeatID;
        Dest[i][j].SumNormTTB := Src[i][j].SumNormTTB;
        Dest[i][j].Deviation := Src[i][j].Deviation;

        // Set the length of idxSwimmer and copy the values
        SetLength(Dest[i][j].idxSwimmer, Length(Src[i][j].idxSwimmer));
        for k := Low(Src[i][j].idxSwimmer) to High(Src[i][j].idxSwimmer) do
        begin
          Dest[i][j].idxSwimmer[k] := Src[i][j].idxSwimmer[k];
        end;
      end;
    end;
  end;


  function Fitness(Teams: TTeamArray): Double;
  var
    i: Integer;
    TotalDeviation: Double;
  begin
    TotalDeviation := 0;
    for i := Low(Teams) to High(Teams) do
      TotalDeviation := TotalDeviation + Abs(Teams[i].Deviation);
    Result := 1 / (1 + TotalDeviation); // Lower deviation means higher fitness
  end;

  procedure ShuffleTeams(var Teams: TTeamArray);
  var
    i, j, k, temp: Integer;
  begin
    for i := Low(Teams) to High(Teams) do
    begin
      for j := Low(Teams[i].idxSwimmer) to High(Teams[i].idxSwimmer) do
      begin
        k := Random(High(Teams[i].idxSwimmer) - Low(Teams[i].idxSwimmer) + 1) + Low(Teams[i].idxSwimmer);
        temp := Teams[i].idxSwimmer[j];
        Teams[i].idxSwimmer[j] := Teams[i].idxSwimmer[k];
        Teams[i].idxSwimmer[k] := temp;
      end;
    end;
  end;

  procedure InitializePopulation;
  var
    i, j: Integer;
  begin
    SetLength(Population, PopulationSize);
    for i := 0 to PopulationSize - 1 do
    begin
      SetLength(Population[i], Length(Teams));
      for j := Low(Teams) to High(Teams) do
        Population[i][j] := Teams[j]; // Copy initial teams
      ShuffleTeams(Population[i]); // Randomize team compositions
    end;
  end;

  procedure Crossover(Parent1, Parent2: TTeamArray; var Child1, Child2: TTeamArray);
  var
    i, crossoverPoint: Integer;
  begin
    crossoverPoint := Random(Length(Parent1));
    for i := 0 to crossoverPoint do
    begin
      Child1[i] := Parent1[i];
      Child2[i] := Parent2[i];
    end;
    for i := crossoverPoint + 1 to High(Parent1) do
    begin
      Child1[i] := Parent2[i];
      Child2[i] := Parent1[i];
    end;
  end;

  procedure Mutate(var Teams: TTeamArray);
  var
    i, j, k, temp: Integer;
  begin
    for i := Low(Teams) to High(Teams) do
    begin
      if Random < MutationRate then
      begin
        j := Random(High(Teams[i].idxSwimmer) - Low(Teams[i].idxSwimmer) + 1) + Low(Teams[i].idxSwimmer);
        k := Random(High(Teams[i].idxSwimmer) - Low(Teams[i].idxSwimmer) + 1) + Low(Teams[i].idxSwimmer);
        temp := Teams[i].idxSwimmer[j];
        Teams[i].idxSwimmer[j] := Teams[i].idxSwimmer[k];
        Teams[i].idxSwimmer[k] := temp;
      end;
    end;
  end;

  procedure EvaluatePopulation;
  var
    i, j: Integer;
    dfitness: Double;
  begin
    BestFitness := 0;
    for i := 0 to PopulationSize - 1 do
    begin
      dfitness := Fitness(Population[i]);
      if dfitness > BestFitness then
      begin
        BestFitness := dfitness;
        // Explicitly copy each team from the best individual in the population
        for j := Low(Population[i]) to High(Population[i]) do
        begin
          Teams[j] := Population[i][j];
        end;
      end;
    end;
  end;



begin
  Randomize;
  InitializePopulation;
  for Generation := 1 to MaxGenerations do
  begin
    SetLength(NewPopulation, PopulationSize);
    for i := 0 to PopulationSize div 2 - 1 do
    begin
      // Selection (simple random selection for demonstration)
      j := Random(PopulationSize);
      k := Random(PopulationSize);
      Crossover(Population[j], Population[k], NewPopulation[2 * i], NewPopulation[2 * i + 1]);
      Mutate(NewPopulation[2 * i]);
      Mutate(NewPopulation[2 * i + 1]);
    end;
    CopyPopulation(Population, NewPopulation);
    EvaluatePopulation;
    if BestFitness >= 1 / (1 + fAcceptedMarginOfDeviation) then
      Break; // Stop if we reach an acceptable fitness level
  end;
end;

procedure TABRelayExec.GetAvgDeviation(var LowAvg, HighAvg: double);
var
LowDeviation, HighDeviation: double;
LowCount, HighCount, i: integer;
begin
    LowDeviation := 0;
    HighDeviation := 0;
    LowCount := 0;
    HighCount := 0;
    LowAvg := 0;
    HighAvg := 0;
    for i := Low(Teams) to High(Teams) do
    begin
      LowDeviation := LowDeviation + Teams[i].Deviation;
      if Teams[i].Deviation <= 0 then
      begin
         LowDeviation := LowDeviation + Abs(Teams[i].Deviation);
         Inc(LowCount);
      end;
      if Teams[i].Deviation > 0 then
      begin
         HighDeviation := HighDeviation + Teams[i].Deviation;
         Inc(HighCount);
      end;
    end;
    if (LowDeviation > 0) then
      LowAvg := LowDeviation / LowCount;
    if (HighDeviation > 0) then
      HighAvg := HighDeviation / HighCount;
end;

function TABRelayExec.GetDistanceID(EventID: integer): integer;
var
  v: variant;
begin
  result := 0;
  v := fConnection.ExecSQLScalar
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
  v := fConnection.ExecSQLScalar
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
  v := fConnection.ExecSQLScalar(s, [ADistanceID]);
  if not VarIsNull(v) then
    result := v;
end;

function TABRelayExec.GetxDistanceID(AMeters: integer): integer;
var
  v: variant;
  s: string;
begin
  {
    Get the distance ID using the metres swum value.
    ABS(Meters - @SwumDistance) calculates the absolute difference
    between the Meters column and the swum distance.
  }
  result := 0;
  s := '''
  SELECT TOP 1 DistanceID
  FROM SwimClubMeet.dbo.Distance
  WHERE EventTypeID = 1  AND ABS(Meters - :SwumDistance) <= 10
  ORDER BY ABS(Meters - :SwumDistance);
  ''';
  v := fConnection.ExecSQLScalar(s, [AMeters]);
  if not VarIsNull(v) then
    result := v
end;

function TABRelayExec.InsertIntoTeams: Boolean;
var
  qry1, qry2: TFDQuery;
  AHeatID: integer;
  ATeamID: integer;
  ATeamEntrantID: integer;
  ATeamNameID: integer;
  s, s2: string;
  i, j, m, n, p, r, t, laneidx, lanenum, idx, lanes: integer;
  v: variant;
  ATeamTTB: TTime;
begin
  result := false;
  qry1 := TFDQuery.Create(nil);
  qry2 := TFDQuery.Create(nil);

  qry1.Connection := fConnection;
  qry2.Connection := fConnection;

  for j := Low(Heats) to High(Heats) do
  Begin

    // Insert into dbo.HeatIndividual
    // HeatTypeID - Heat, HeatStatus - open, HeatNum - (1 ... )
    qry1.Close;
    s := '''
    INSERT INTO HeatIndividual (EventID, HeatNum, OpenDT, HeatTypeID, HeatStatusID)
    VALUES (:EVENTID, :HEATNUM, GETDATE(), 1, 1);
    ''';
    qry1.SQL.Text := s;
    qry1.ParamByName('EVENTID').AsInteger := fEventID;
    qry1.ParamByName('HEATNUM').AsInteger := (Heats[j].HeatNum + 1);
    qry1.Prepare;
    qry1.ExecSQL;
    // Get the newly created heat's record IDENTITY.
    v := qry1.Connection.GetLastAutoGenValue('');
    if VarIsNull(v) or VarIsEmpty(v) then
        raise Exception.Create('Failed to retrieve AHeatID');
    AHeatID := v;

    // ----------------------------------------
    // Build all the lanes for this new heat...
    // Assigns [HeatID], [Lane], BIT values, etc .
    // Not assigned is TeamNameID. (wit: indicates empty Lane).
    // returns number of lanes.
    // ----------------------------------------
    lanes := SCM.PadLanes(AHeatID);

    laneidx := 0;
    { P L A C E   R E L A Y   T EA M .}
    // Iterate accross all TTeams over multi-heats ...
    for i := (j * fNumOfHeats) to (j * fNumOfHeats) + (fNumOfTeamsPerHeat - 1) do
    begin
      if (i > High(Teams))  then  break;  // Out of range ...

      { L A N E   N U M B E R .}
      lanenum := SCMUtility.ScatterLanes(laneidx, fNumOfPoolLanes);

      { T E A M N A M E   I D . }
      // dbo.TeamName is a table filled with ID's starting from 1 .. 26
      //  and Caption's (1)'TeamA' ... (26)'TeamZ'.
      ATeamNameID := ABRelayData.GetLastTeamNameID(fEventID) + 1;

      { L O O K U P   T E A M I D . }
      s := '''
      SELECT TeamID FROM SwimClubMeet.dbo.Team
      WHERE HeatID = :HEATID AND Lane = :LANENUM;
      ''';
      v := fConnection.ExecSQLScalar(s, [AHeatID, lanenum]);
      if VarIsNull(v) or VarIsEmpty(v) then
          raise Exception.Create('Failed to retrieve ATeamID');
      ATeamID := v;
      ATeamTTB := 0;

      { A S S I G N   T E A M   D A T A (Part-A).}
      s := '''
      UPDATE  [dbo].[Team]
      SET [TeamNameID] = :TEAMNAMEID
      WHERE TeamID = :TEAMID;
      ''';
      fConnection.ExecSQL(s, [ATeamNameID, ATeamID]);

      { ASSIGN SWIMMERS TO TEAM }
      // ---------------------------------------------------------------------

      {TODO -oBSA -cAutoBuild Relay :
        Sort entrants - Fastest last, 2nd fastest first, etc... }

      p := 1; // Swimming order for relay team members.

      // Insert into fNumOfSwimmersInTeam x TeamEntrant table.
      for m := Low(Teams[i].idxSwimmer) to High(Teams[i].idxSwimmer) do
      begin
        idx := Teams[i].idxSwimmer[m];  // TSwimming index to lookup swimmers.
        qry2.Close;
        s := '''
        INSERT INTO dbo.TeamEntrant
        (MemberID, Lane, TeamID, PersonalBest, TimeToBeat, StrokeID, IsDisqualified, IsScratched)
        VALUES
        (:MEMBERID, :LANE, :TEAMID, :PB, :TTB, :STROKEID, :ISDISQUALIFIED, :ISSCRATCHED);
        ''';
        qry2.SQL.Text := s;
        // S e t   D a t a T y p e .
//        qry2.ParamByName('ISDISQUALIFIED').DataType := ftBoolean;
//        qry2.ParamByName('ISSCRATCHED').DataType := ftBoolean;
//        qry2.ParamByName('PB').DataType := ftTime;
//        qry2.ParamByName('TTB').DataType := ftTime;
        // A s s i g n   v a l u  e .
        qry2.ParamByName('MEMBERID').AsInteger := Swimmers[idx].MemberID;
        qry2.ParamByName('LANE').AsInteger := p;
        qry2.ParamByName('TEAMID').AsInteger := ATeamID;
        qry2.ParamByName('PB').AsTime := Swimmers[idx].PB;
        qry2.ParamByName('TTB').AsTime := Swimmers[idx].TTB;
        qry2.ParamByName('STROKEID').AsInteger := fStrokeID;
        qry2.ParamByName('ISDISQUALIFIED').AsBoolean := false;
        qry2.ParamByName('ISSCRATCHED').AsBoolean := false;

        qry2.Prepare;
        qry2.ExecSQL;
        ATeamTTB := ATeamTTB + Swimmers[idx].TTB;
        inc(p, 1);
      end; { N E X T   T E A M   -   S W I M M E R . }

      // ---------------------------------------------------------------------

      { A S S I G N   T E A M   D A T A (Part-B).}
      // Had to make a new var 's2' else ExecSQL uses cached 's'  ...!
      s2 := '''
      UPDATE dbo.Team
      SET TimeToBeat = :ATEAMTTB
      WHERE TeamID = :ATEAMID
      ''';
      // Explicently assign ATyes.
      fConnection.ExecSQL(s2, [ATeamTTB, ATeamID],[ftTime, ftInteger]);

      // next lane index for the current heat.
      inc(laneIdx);

    end; { N E X T   T E A M . }

  End; { N E X T   H E A T . }

  qry2.Close;
  qry1.Close;

  qry1.Free;
  qry2.Free;

  result := true;

end;

procedure TABRelayExec.NormalizeINDV_TTB;
var
  I: integer;
  minTTB, maxTTB: TTime;
  range, totalNormTTB: TTime;

begin
  if Length(Swimmers) = 0 then Exit;

  // Initialize min and max with the first swimmer's TTB
  minTTB := Swimmers[Low(Swimmers)].TTB;
  maxTTB := Swimmers[Low(Swimmers)].TTB;

  // Find the min and max TTB values
  for I := Low(Swimmers) to High(Swimmers) do
  begin
    if Swimmers[I].TTB < minTTB then
      minTTB := Swimmers[I].TTB;
    if Swimmers[I].TTB > maxTTB then
      maxTTB := Swimmers[I].TTB;
  end;

  // Calculate the range
  range := maxTTB - minTTB;

  // Normalize each swimmer's TTB to a value between 0 and 1
  totalNormTTB := 0;
  for I := Low(Swimmers) to High(Swimmers) do
  begin
    if range = 0 then
      Swimmers[I].NormTTB := 0 // Avoid division by zero
    else
      Swimmers[I].NormTTB := (Swimmers[I].TTB - minTTB) / range;
    totalNormTTB := totalNormTTB + Swimmers[I].NormTTB;
  end;

  // Calculate the normalized average TTB
  if Length(Swimmers) > 0 then
    fAvgINDVNormTTB := totalNormTTB / Length(Swimmers)
  else
    fAvgINDVNormTTB := 0;
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

  // 2024-08-26 AUTO-BUILD RELAYS.
  // Pack Method.
  fPackAlgorithm :=
    (iFile.ReadInteger('Preferences', 'PackAlgorithm', 0));



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

  // 2024-10-3 auto-build relays acceptable margin for refined algorithm */
  fAcceptableMargin := (iFile.ReadInteger('Preferences', 'AcceptableMargin', 20));


  iFile.free;
end;

function TABRelayExec.RetriveSwimmingData(): boolean;
var
  i: integer;
begin
  {
  Retrieve Swimmer Data: Fetch swimmers’ data from the Nominee table,
  focusing on their MemberID TTB (TimeToBeat) and PB (Personal Best) times.
  }
  result := false;
  with ABRelayData.qryRNominee do
  begin
    //Connection := fConnection;
    Close;
    // Relay Event ID.
    ParamByName('EVENTID').AsInteger := fEventID;
    // 0,1,2 - Default: 1. The avgerage of the 3 fastest race times.
    ParamByName('ALGORITHM').AsInteger := fHeatAlgorithm;
    // Lastname, firstname (format for display of entrants name)
    ParamByName('TOGGLENAME').AsBoolean := true;
    // if then entrant has no race history then ...
    // Calculate a race time based on the mean average of the bottom...
    ParamByName('CALCDEFAULT').AsInteger := 1;
    // ... bottom precent (Default is 50%)
    ParamByName('BOTTOMPERCENT').AsFloat := fRaceTimeBottomPercent;
    // Distance swum by a swimmer in the Team-Relay.
    // Relay's total distance DIV number of swimmers in the relay-team.
    // LOOKUP DISTANCE to determine ID number ...
    ParamByName('XDISTANCEID').AsInteger := fxDistanceID;
    // Perfect number of swimmers to fill ALL relay-teams perfectly.
    ParamByName('TOPNUMBER').AsInteger := fNumOfSwimmers;
    Prepare;
    // DEBUG ...
    // SQL.SaveToFile('C:\Users\Ben\Documents\GitHub\SCM_SwimClubMeet-R\SQL\dump.sql');
    Open;
    if not ABRelayData.qryRNominee.Active then exit;
    if ABRelayData.qryRNominee.IsEmpty then exit;
  end;

  // ASSERT array size.
  i:= ABRelayData.qryRNominee.RecordCount;
  if (Length(Swimmers) <> i) then
  SetLength(Swimmers, i);

  // Populate the array with swimmers.
  // ARRAY SIZE: Perfect number of swimmers = qry.RecordCount.
  ABRelayData.qryRNominee.First;
  try
    for I := Low(Swimmers) to High(Swimmers) do
    begin
      Swimmers[i].MemberID := ABRelayData.qryRNominee.FieldByName('MemberID').AsInteger;
      Swimmers[i].NomineeID := ABRelayData.qryRNominee.FieldByName('NomineeID').AsInteger;
      Swimmers[i].TTB := TTime(ABRelayData.qryRNominee.FieldByName('xTTB').AsDateTime);
      Swimmers[i].PB := TTime(ABRelayData.qryRNominee.FieldByName('xPB').AsDateTime);
      ABRelayData.qryRNominee.Next;
    end;
  except on E: Exception do
      exit;
  end;

  result := true;

end;

procedure TABRelayExec.SecondFit(Percent: integer);
var
  i, j, k, teamLow, teamHigh, swimmerLow, swimmerHigh: Integer;
  minDeviation, maxDeviation, fAcceptedMarginOfDeviation: double;
  tempSwimmer, lowSwimmer, highSwimmer, iter: Integer;
begin
  // Define your acceptable margin here
  fAcceptedMarginOfDeviation := CalculateAcceptableMargin(Percent);
  fIterations := 3000;
  iter := 0; // Initialize iter
  repeat
    // Find the team with the lowest and highest deviation
    minDeviation := MaxDouble;
    maxDeviation := -MaxDouble;
    teamLow := -1;
    teamHigh := -1;

    for i := Low(Teams) to High(Teams) do
    begin
      if Teams[i].Deviation < minDeviation then
      begin
        minDeviation := Teams[i].Deviation;
        teamLow := i;
      end;
      if Teams[i].Deviation > maxDeviation then
      begin
        maxDeviation := Teams[i].Deviation;
        teamHigh := i;
      end;
    end;

    // If deviations are within the acceptable margin, break the loop
    if Abs(maxDeviation - minDeviation) <= fAcceptedMarginOfDeviation then
      Break;

    // Try to find a swimmer to swap between the two teams
    for j := Low(Teams[teamLow].idxSwimmer) to High(Teams[teamLow].idxSwimmer)
      do
    begin
      swimmerLow := Teams[teamLow].idxSwimmer[j];
      for k := Low(Teams[teamHigh].idxSwimmer) to
        High(Teams[teamHigh].idxSwimmer) do
      begin
        swimmerHigh := Teams[teamHigh].idxSwimmer[k];

        // Swap the swimmers
        tempSwimmer := Teams[teamLow].idxSwimmer[j];
        Teams[teamLow].idxSwimmer[j] := Teams[teamHigh].idxSwimmer[k];
        Teams[teamHigh].idxSwimmer[k] := tempSwimmer;

        // Recalculate deviations
        Teams[teamLow].SumNormTTB := Teams[teamLow].SumNormTTB -
          Swimmers[swimmerLow].NormTTB + Swimmers[swimmerHigh].NormTTB;
        Teams[teamHigh].SumNormTTB := Teams[teamHigh].SumNormTTB -
          Swimmers[swimmerHigh].NormTTB + Swimmers[swimmerLow].NormTTB;
        Teams[teamLow].Deviation := fAvgTEAMNormTTB - Teams[teamLow].SumNormTTB;
        Teams[teamHigh].Deviation := fAvgTEAMNormTTB -
          Teams[teamHigh].SumNormTTB;

        // Check if the deviations are now within the acceptable margin
        if ((Abs(Teams[teamLow].Deviation) <= fAcceptedMarginOfDeviation)) then
        begin
          if ((Abs(Teams[teamHigh].Deviation) <= fAcceptedMarginOfDeviation)) then
          begin
            highSwimmer := Teams[teamHigh].idxSwimmer[k];
            lowSwimmer := Teams[teamLow].idxSwimmer[j];
            Exit;
          end;
        end;
      end;
    end;
    inc(iter);

  until False OR (iter > fIterations);
end;

procedure TABRelayExec.ThirdFit(Percent: integer);
var
  i, j, k, teamLow, teamHigh, swimmerLow, swimmerHigh: Integer;
  minDeviation, maxDeviation, fAcceptedMarginOfDeviation: double;
  tempSwimmer, iter: Integer;
  improvement: Boolean;
begin
  // Define your acceptable margin here
  fAcceptedMarginOfDeviation := CalculateAcceptableMargin(Percent);
  fIterations := 3000;
  iter := 0; // Initialize iter

  repeat
    improvement := False;

    // Find the team with the lowest and highest deviation
    minDeviation := MaxDouble;
    maxDeviation := -MaxDouble;
    teamLow := -1;
    teamHigh := -1;

    for i := Low(Teams) to High(Teams) do
    begin
      if Teams[i].Deviation < minDeviation then
      begin
        minDeviation := Teams[i].Deviation;
        teamLow := i;
      end;
      if Teams[i].Deviation > maxDeviation then
      begin
        maxDeviation := Teams[i].Deviation;
        teamHigh := i;
      end;
    end;

    // If deviations are within the acceptable margin, break the loop
    if Abs(maxDeviation - minDeviation) <= fAcceptedMarginOfDeviation then
      Break;

    // Try to find a swimmer to swap between the two teams
    for j := Low(Teams[teamLow].idxSwimmer) to High(Teams[teamLow].idxSwimmer) do
    begin
      swimmerLow := Teams[teamLow].idxSwimmer[j];
      for k := Low(Teams[teamHigh].idxSwimmer) to High(Teams[teamHigh].idxSwimmer) do
      begin
        swimmerHigh := Teams[teamHigh].idxSwimmer[k];

        // Swap the swimmers
        tempSwimmer := Teams[teamLow].idxSwimmer[j];
        Teams[teamLow].idxSwimmer[j] := Teams[teamHigh].idxSwimmer[k];
        Teams[teamHigh].idxSwimmer[k] := tempSwimmer;

        // Recalculate deviations
        Teams[teamLow].SumNormTTB := Teams[teamLow].SumNormTTB -
          Swimmers[swimmerLow].NormTTB + Swimmers[swimmerHigh].NormTTB;
        Teams[teamHigh].SumNormTTB := Teams[teamHigh].SumNormTTB -
          Swimmers[swimmerHigh].NormTTB + Swimmers[swimmerLow].NormTTB;
        Teams[teamLow].Deviation := fAvgTEAMNormTTB - Teams[teamLow].SumNormTTB;
        Teams[teamHigh].Deviation := fAvgTEAMNormTTB - Teams[teamHigh].SumNormTTB;

        // Check if the deviations are now within the acceptable margin
        if (Abs(Teams[teamLow].Deviation) <= fAcceptedMarginOfDeviation) and
           (Abs(Teams[teamHigh].Deviation) <= fAcceptedMarginOfDeviation) then
          Exit;

        // If the swap improved the balance, mark improvement
        if (Abs(Teams[teamLow].Deviation) < minDeviation) or (Abs(Teams[teamHigh].Deviation) < maxDeviation) then
          improvement := True;
      end;
    end;

    Inc(iter);

  until (iter > fIterations) or not improvement;
end;






end.
