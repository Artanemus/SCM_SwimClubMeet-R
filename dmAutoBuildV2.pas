unit dmAutoBuildV2;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, SCMDefines, dmSCM;

type

  TAutoBuildV2 = class(TDataModule)
    qryHeatsToDelete: TFDQuery;
    qryNominees: TFDQuery;
    qryRenumberHeats: TFDQuery;
    qryGenderMemberTypeCount: TFDQuery;
    qryGenderCount: TFDQuery;
    qryMemberTypeCount: TFDQuery;
    qryAgeCount: TFDQuery;
    qryGenderAgeCount: TFDQuery;
    qryGenericCount: TFDQuery;
    qryHeatMaxSeedNumber: TFDQuery;
    tbl_ABHeat: TFDTable;
    tbl_ABEntrant: TFDTable;
    qrySourceEvent: TFDQuery;
    qryNomineeCountExt: TFDQuery;
    qryNomineesExt: TFDQuery;
    qryInsertEvent: TFDQuery;
    qryUnplaced: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);

  private
    { Private declarations }
    prefHeatAlgorithm: integer;
    prefGroupBy: integer;
    prefRaceTimeTopPercent: double;
    prefUseDefRaceTime: boolean;
    prefExcludeOutsideLanes: boolean;
    prefSeperateGender: boolean;
    prefSeedMethod: seedMethod; // enum defined in SCMDefines
    prefSeedDepth: integer;
    // SEEDTIME IS USED TO INJECT DATA INTO THE ENTRANT TABLE
    // use the preference dialog to enable and set options.
    prefImportSeedTime: integer;

    { TODO -oBSA -cGeneral : Check order of params for calling procedures. }

    function AssertConnection(): boolean;
    procedure ReadPreferences(iniFileName: string);

    // Auto build sub-routines
    // SECTION A
    function AssignHeats(EventID, numOfSwimmingLanes, GroupBy,
      Unplaced: integer; SeperateGender: boolean): integer;
    function AssignNomineesExt(DataSet: TFDQuery;
      destEventID, MaxNumOfNominees: integer): integer;
    function AssignLanes(DataSet: TFDQuery;
      HeatID, numOfNomineesInHeat: integer): integer;
    function AssignLane(DataSet: TFDQuery; HeatID, laneNumber: integer)
      : boolean;
    // seedDepth is base 1 - must remain in the index bounds of the DynamicArrays
    // A bounds is check and adjusted.
    function CircleSeed(DataSet: TFDQuery; seedDepth: integer): integer;
    function AssignNominees(DataSet: TFDQuery; EventID: integer;
      Age: integer = 0; GenderID: integer = 0;
      SwimmerCategoryID: integer = 0): boolean;

    // Autobuild startup functions
    function GetNumOfSwimmingLanes(var NumOfPoolLanes: integer;
      DoExcludeOutsideLanes: boolean): integer;
    function GetHeatMaxSeedNumber(EventID: integer): integer;
    function CountNominees(EventID: integer): integer;
    function RenumberHeats(EventID: integer): integer;

    // Autobuild support functions
    // DEPRECIATED: 2023.02.21 - NOW SHARED CODE FOUND IN SCMUtility
    // function ScatterLanes(index, NumOfPoolLanes: integer): integer;
    function CreateNewEmptyHeat(EventID: integer): integer;
    function SeedNominees(DataSet: TFDQuery; mySeedMethod: seedMethod;
      mySeedDepth: integer = 3): integer;
    procedure PrepDynamicArrays(EventID, numOfNominees, numberOfHeats: integer);
    function CreateNewEvent(SourceEvent: TFDQuery;
      TypeOfFinals: scmEventFinalsType): integer;

  public
    { Public declarations }
    // DEFAULT Auto build ... ENTRY POINT
    // IMPORTANT NOTE:
    // if TMain's instance of Heat DataSet isn't sent to Auto-Build
    // ... unable to delete Heat record. (locked)  !!!!!!!!!!!!
    function AutoBuildExecute(DatasetHeat: TDataSet; EventID: integer;
      Verbose: boolean = true): boolean;
    // Auto build FINALS ... ENTRY POINT (also SEMI and QUARTER finals)
    function AutoBuildExecuteExt(SourceEventID: integer;
      TypeOfFinals: scmEventFinalsType = ftFinals): boolean;
  end;

var
  AutoBuildV2: TAutoBuildV2;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses SCMUtility, System.Math, vcl.Dialogs, System.Variants, dmSCMNom, IniFiles,
  vcl.StdCtrls, System.UITypes;

{$R *.dfm}

VAR
  NomineesInHeat: Array of integer;
  HeatIDs: Array of integer;

function TAutoBuildV2.AssertConnection: boolean;
begin
  result := false;
  if Assigned(SCM) then
    if SCM.SCMActive then
      result := true;
end;

function TAutoBuildV2.AssignHeats(EventID, numOfSwimmingLanes, GroupBy,
  Unplaced: integer; SeperateGender: boolean): integer;
var
  Success: boolean;
  numberOfHeats, numOfNominees, totalNumberOfHeats: integer;
  fAge, fGenderID, fSwimmerCategoryID: integer;
  ds: TFDQuery;
  Param: TFDParam;
begin
  ds := nil;
  totalNumberOfHeats := 0;
  result := 0;
  { INFO: group on....
    0-No (DEFAULT),
    1-Entrant Age,
    2-Entrant Swimming Category,
    3-Division
  }

  {
    function AssignAutoBuildQuery(SeperateGender: boolean; GroupBy: integer ): AQuery: TFDQuery;
    Assign the query to run for AutoBuild.
    Stack nominees on param:Gender (optional).
    Then split stack on param:GroupBy
  }
  if (SeperateGender) then
  begin
    case (GroupBy) of
      1: // GroupBy Gender. may produce a very large amount of heats!
        ds := qryGenderAgeCount;
      2:
        // GroupBy Swimming Category
        ds := qryGenderMemberTypeCount;
      3:
        { TODO -oBSA -cGeneral : Sperate gender and GroupBy Division }
        ;
    else
      // DON'T GROUP ... split stack on param:Gender
      ds := qryGenderCount;
    end;
  end
  // prefSeperateGender = false
  // Group nominee without seperating genders
  else
  begin
    case (GroupBy) of
      1: // Gender
        ds := qryAgeCount;
      2: // Membership type.
        ds := qryMemberTypeCount;
      { TODO -oBSA -cGeneral : CASE 3: GroupBy Division }
    else
      // DON'T GROUP.
      // A simple count of the nominees who are UNPLACED.
      ds := qryGenericCount;
      ;
    end;
  end;

  // was a dataset assigned?
  if not Assigned(ds) then
  begin
    ds.Close;
    qryNominees.Close;
    exit;
  end;

  if Assigned(ds) then
  begin
    // prepare dataset with params ...
    ds.Close;
    ds.ParamByName('EVENTID').AsInteger := EventID;

    // not all queries use param SESSIONSTART
    Param := ds.FindParam('SESSIONSTART');
    if Assigned(Param) then
    begin
      if (GroupBy = 1) then // Group by AGE
        Param.AsDateTime := SCM.Session_Start
      else
        Param.Clear; // SESSIONSTART = <null>;
    end;

    ds.Prepare;
    ds.Open;

    // *******************************************************************
    // iterate through the QUERY COUNT records
    // building the DynamicArray items
    // and creating heats and empty entrant records (wit empty Lanes)
    // *******************************************************************

    // BEGIN : AssignHeats MAIN LOOP
    while not ds.Eof do
    begin
      numOfNominees := ds.FieldByName('countNominees').AsInteger;
      { TODO -oBSA -cGeneral : Unexpected error not handled
        if (numOfNominees > Unplaced) then
      }

      // no nominees found - move to next event.
      if (numOfNominees = 0) then
      begin
        ds.Next;
        Continue;
      end;

      // Calculate the number of heats in each event.
      if (numOfNominees > numOfSwimmingLanes) then
        numberOfHeats :=
          Ceil(double(numOfNominees) / double(numOfSwimmingLanes))
      else
        numberOfHeats := 1;

      // TOT - accumulative number of heats
      totalNumberOfHeats := totalNumberOfHeats + numberOfHeats;

      // ***************************************************************
      // Q R Y N O M I N E E S . . . .
      // Prepare and make active the Nominees query
      // A list of qualified nominees sorted fastest to slowest
      // ***************************************************************
      fAge := 0;
      fGenderID := 0;
      fSwimmerCategoryID := 0;

      // FINALIZE DATA PARAM ASSIGNMENT
      // Specific queries need specific data prior to calling AssignNominees.
      if (SeperateGender) then
        fGenderID := ds.FieldByName('GENDERID').AsInteger;

      case (GroupBy) of
        1: // Group on age.
          fAge := ds.FieldByName('Age').AsInteger;
        2: // Group on membership type.
          fSwimmerCategoryID := ds.FieldByName('SwimmerCategoryID').AsInteger;
        { TODO -oBSA -cGeneral : CASE 3: GroupBy Division }
      end;

      // C A L L   T O   C O L L A T E   E N T R A N T S
      Success := AssignNominees(qryNominees, EventID, fAge, fGenderID,
        fSwimmerCategoryID);

      if not Success then
      begin
        // Hide all messages 11/12/22
        // MessageDlg('ERR: SCM.AssignHeats(...) - Nominees list empty.',
        // mtError, [mbOK], 0);
        // SetLength(NomineesInHeat, 0);
        // SetLength(HeatIDs, 0);
        ds.Next;
        Continue;
      end;

      // ***************************************************************
      // CREATE DYNAMIC ARRAY DATA
      // CREATE HEATS AND ENTRANT RECORDS.
      // ***************************************************************
      // NomineesInHeat - The number of nominees to place into each heat.
      // HeatIDs - The IDs of the newly created heats
      // s i z e  . . . .
      // SetLength(NomineesInHeat, numberOfHeats);
      // SetLength(HeatIDs, numberOfHeats);
      // ***************************************************************
      PrepDynamicArrays(EventID, numOfNominees, numberOfHeats);

      {
        // DYNAMIC ARRAY CHECK ...
        // 15/03/2022 - HIDE ALL WARNINGS - ERRORS
        err := false;
        j := 0;
        for i in HeatIDs  do
        begin
        if (HeatIDs[i] = 0) then  err := true;
        end;
        for i in NomineesInHeat do
        begin
        j := j + NomineesInHeat[i];
        end;
        if (j <> numOfNominees) then
        err := true;
        if (err) then

        // MessageDlg("CheckSum error in DynamicArray", mtWarning, TMsgDlgButtons() << mbOK, 0);
        ;
      }

      // ****************************************************************
      // SEED THE NOMINEES
      // ****************************************************************
      SeedNominees(qryNominees, prefSeedMethod, prefSeedDepth);
      // ****************************************************************
      // FREE DYNAMIC ARRAY
      // then rinse and repeat ....
      // ****************************************************************
      SetLength(NomineesInHeat, 0);
      SetLength(HeatIDs, 0);

      // ****************************************************************
      // NEXT SET OF NOMINEES.
      // ****************************************************************
      ds.Next;

    end; // AssignHeats MAIN LOOP

    ds.Close;
    qryNominees.Close;

  end;

  result := totalNumberOfHeats;

end;

function TAutoBuildV2.AssignLane(DataSet: TFDQuery;
  HeatID, laneNumber: integer): boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  tbl_ABEntrant.Open;
  if (laneNumber > 0) then
  begin
    SearchOptions := [];
    result := tbl_ABEntrant.Locate('HeatID; Lane',
      VarArrayOf([HeatID, laneNumber]), SearchOptions);
    if (result) then
    begin
      tbl_ABEntrant.Edit;
      tbl_ABEntrant.FieldByName('MemberID').AsInteger :=
        DataSet.FieldByName('MemberID').AsInteger;
      (*
        NOTE:
        The dataset is either qryNominees or qryNomineesExt.
        The default is to send the TimeToBeat to field 'TTB'.
        When a finals, semi and quarter is seeded then the TFDQuery dataset
        re-directs the RACETIME time value to 'TTB' ...
      *)
      tbl_ABEntrant.FieldByName('TimeToBeat').AsDateTime :=
        DataSet.FieldByName('TTB').AsDateTime;
      tbl_ABEntrant.FieldByName('PersonalBest').AsDateTime :=
        DataSet.FieldByName('PB').AsDateTime;

      (*
        INJECT the Nominee.SeedTime value into the designated Entrant field
        To enable and set options use the prefence dialog.
        The default : 0 = DISABLED.
      *)
      if prefImportSeedTime > 0 then
      begin
        case prefImportSeedTime of
          1: // RaceTime
            tbl_ABEntrant.FieldByName('RaceTime').AsDateTime :=
              DataSet.FieldByName('SeedTime').AsDateTime;
        end;
      end;

    end;

    tbl_ABEntrant.Post;
  end;
end;

function TAutoBuildV2.AssignLanes(DataSet: TFDQuery;
  HeatID, numOfNomineesInHeat: integer): integer;
var
  pass: boolean;
  NumOfPoolLanes, laneNumber, i, entrantsAssigned: integer;
begin
  entrantsAssigned := 0;
  // The total number of pool lanes must be passed to scatter
  // (ignore: preExcludeOutsideLanes)
  NumOfPoolLanes := SCM.SwimClub_NumberOfLanes;
  for i := 0 to numOfNomineesInHeat - 1 do
  begin
    if DataSet.Eof then
      break;
    // *******************************************
    // For each nominee - assign a lane number.
    // nominees are ordered fastest to slowest
    // index i=0 results in lane number 4 when the pool lane count = 8
    laneNumber := SCMUtility.ScatterLanes(i, NumOfPoolLanes);
    if (laneNumber <> 0) then
    begin
      pass := AssignLane(DataSet, HeatID, laneNumber);
      if (pass) then
      begin
        entrantsAssigned := entrantsAssigned + 1;
        DataSet.Next;
      end;
    end;
  end;
  result := entrantsAssigned;
end;

// ***********************************************************************
// C O L L A T E    E N T R A N T S . . . .
// ***********************************************************************
function TAutoBuildV2.AssignNominees(DataSet: TFDQuery;
  EventID, Age, GenderID, SwimmerCategoryID: integer): boolean;
begin
  {
    BASED ON THE GIVEN EVENTID ...
    Prepare a list of swimmer who have nominated for the
    event - they will be sorted by TimeToBeat
    (this excluding nominees in closed or raced heats)
    Default assignment - age, GenderID, SwimmerCategoryID , DivisionID = 0
    The MSSQL is written - such that CASE statements...
    Values > zero enables filtering to INCLUDE SPECIFIC records.
  }
  DataSet.Close;
  DataSet.ParamByName('AGE').AsInteger := Age;
  DataSet.ParamByName('GENDERID').AsInteger := GenderID;
  DataSet.ParamByName('SWIMMERCATEGORYID').AsInteger := SwimmerCategoryID;
  { TODO -oBSA -cGeneral : dataset.ParamByName('DIVISIONID').AsInteger := DivisionID }
  DataSet.ParamByName('EVENTID').AsInteger := EventID;

  // if you are injecting data - the session date will pre-date the DOB of
  // most swimmers. So the SESSIONSTART should be set to Now()
  if (prefImportSeedTime > 0) then
    DataSet.ParamByName('SESSIONSTART').AsDateTime := Now
  else
    DataSet.ParamByName('SESSIONSTART').AsDateTime := SCM.Session_Start;

  DataSet.ParamByName('ALGORITHM').AsInteger := prefHeatAlgorithm;
  DataSet.ParamByName('CALCDEFAULT').AsInteger := integer(prefUseDefRaceTime);
  DataSet.ParamByName('PERCENT').AsFloat := double(prefRaceTimeTopPercent);
  DataSet.Prepare;
  // ************************************************************
  // PULL QUALIFIED NOMINEE LIST ORDERED BY FASTEST FIRST
  // ************************************************************
  DataSet.Open;
  if (DataSet.Active) then
  begin
    if DataSet.IsEmpty then
      DataSet.Close;
  end;
  result := DataSet.Active;
end;

function TAutoBuildV2.AssignNomineesExt(DataSet: TFDQuery;
  destEventID, MaxNumOfNominees: integer): integer;
var
  i: integer;
  nom: TSCMNom;
begin
  // NOMINATE the members from the destination event
  // 'dataset' - a list of members and their RaceTimes ..
  // from the sourceEvent - sorted by RaceTime ASCENDING.
  DataSet.First;
  nom := TSCMNom.CreateWithConnection(self, SCM.scmConnection);
  // for the max number of racing lanes ...
  for i := 0 to MaxNumOfNominees - 1 do
  begin
    if DataSet.Eof then
      break;
    nom.NominateMember(DataSet.FieldByName('MemberID').AsInteger, destEventID);
    DataSet.Next;
  end;
  nom.Free;
  result := i;
end;

function TAutoBuildV2.AutoBuildExecute(DatasetHeat: TDataSet; EventID: integer;
  Verbose: boolean): boolean;
// ***********************************************************************
// A U T O B U I L D . . .  ENTRY POINT
// SPECIAL NOTES:
// Prior to calling here ....
// ALL Heats (and associated Entrants) that are NOT CLOSED OR RACED
// have been REMOVED.
//
// ***********************************************************************
// IMPORTANT NOTE:
// TMain's instance of the Heat DataSet must be sent to AutoBuildExecute(...)
// Normally a call SCM.dsHeat.DataSet.Delete would be use but this
// doesn't work!... (tbl is locked?)
//
//
// EventID - CURRENT EVENT  in SCM.dsEvent.DataSet
// dataHeat - ptr to SCM.dsHeat.DataSet
//
// Verbose
// USED BY BATCH Auto-Build Heats. DEFAULT := ON. Displays/Hides messages.
//
var
  Unplaced, NumberOfPoolLanes, numOfSwimmingLanes, numberOfHeats: integer;
  s, strSQL: string;
begin
  result := false;
  Unplaced := 0;

  if not AssertConnection then
  begin
    if (Verbose) then
      MessageDlg('No database connection!' + sLineBreak +
        'Auto-Build Heats will abort..', mtError, [mbOK], 0, mbOK);
    exit;
  end;

  if (EventID = 0) then
  begin
    if (Verbose) then
      MessageDlg('The event ID was invalid.' + sLineBreak +
        'Auto-Build Heats will abort.', mtError, [mbOK], 0, mbOK);
    exit;
  end;

  if (prefSeedMethod = smDualSeeding) then
  begin
    if (Verbose) then
      MessageDlg('The event selected is an individual event.' + sLineBreak +
        'Dual seeding can only be applied to teamed events (relays).' +
        sLineBreak + 'Auto-Build Heats will abort.', mtError, [mbOK], 0, mbOK);
    exit;
  end;

  if (prefSeedMethod = smMastersChampionSeeding) then
  begin
    if (Verbose) then
      MessageDlg('Master Champion seeding is in development' + sLineBreak +
        'and was made not available for this build.' + sLineBreak +
        'Auto-Build Heats will abort.', mtError, [mbOK], 0, mbOK);
    exit;
  end;

  // TODO : Test/Locate SwimClubID ... for future multi-club DB.
  numOfSwimmingLanes := GetNumOfSwimmingLanes(NumberOfPoolLanes,
    prefExcludeOutsideLanes);

  // There must be a least 2 lanes for the scatter algorithm.
  if (numOfSwimmingLanes < 2) then
  begin
    if (Verbose) then
    begin
      s := '';
      s := s + 'Your pool needs at least two swimming lanes' + sLineBreak +
        'else the scatter algorithm cannot run.' + sLineBreak +
        'Is the Club''s number of pool lanes correctly assigned?' + sLineBreak +
        'Auto-Build Heats will abort.';
      MessageDlg(s, mtError, [mbOK], 0, mbOK);
    end;
    exit;
  end;

  // FROM THIS POINT ...
  // Auto-Build must return true as the grids need a refresh.
  // *******************************************************
  result := true;
  // *******************************************************

  // CLEAN UP HEATS - make readyfor auto build
  if not DatasetHeat.IsEmpty then
  begin
    // EXCLUDE RACED OR CLOSED HEATS
    SCM.Heat_DeleteALLExclude(EventID); // also renumbers heats.
    // RenumberHeats(EventID);
  end;

  {
    With Heats CLEANED ....
    Count the number of Nominees to be placed into lanes.
    EXCLUDES pre-placed nominees in closed or raced heats
  }

  qryUnplaced.Close;
  qryUnplaced.Params.ParamByName('EVENTID').AsInteger := EventID;
  qryUnplaced.Prepare;
  qryUnplaced.Open;
  if (qryUnplaced.Active) then
  begin
    Unplaced := qryUnplaced.FieldByName('NomCount').AsInteger -
      qryUnplaced.FieldByName('EntCount').AsInteger;
    // FINISHED WITH QUERY
    qryUnplaced.Close;
    // Message disabled for BATCH AUTO-BUILD
    if (Unplaced = 0) then
    begin
      if (Verbose) then
      begin
        s := 'Heats have been cleaned.' + sLineBreak;
        s := s + 'After excluding entrants in closed and raced heats ...' +
          sLineBreak + 'all outstanding nominees have been given a lane.' +
          sLineBreak + 'Done - Auto-Build Heats will exit.';
        MessageDlg(s, mtError, [mbOK], 0, mbOK);
      end;
      // All the nominees are placed - nothing more to do. OK.
      exit;
    end;
    // Message disabled for BATCH AUTO-BUILD
    // NOTE: if UnPlaced < 0 :: UNEXPECTED ERROR.
    if (Unplaced < 0) then
    begin
      if (Verbose) then
      begin
        s := 'Heats have been cleaned.' + sLineBreak;
        s := s + 'Unexpected error ...' + sLineBreak +
          'There are more entrants (assigned a lane)' + sLineBreak +
          'than club members who nominated for the event!' + sLineBreak +
          'Auto-Build Heats will exit.';
        MessageDlg(s, mtError, [mbOK], 0, mbOK);
      end;
      // Return true - need refresh of grids after cleaning heats.
      exit;
    end;
  end;

  // ***************************************************
  // GOTO SECTION A. - HEAT ASSIGNMENT
  numberOfHeats := AssignHeats(EventID, numOfSwimmingLanes, prefGroupBy,
    Unplaced, prefSeperateGender);

  // no heats were constructed!
  // Message disabled for BATCH AUTO-BUILD
  if (numberOfHeats = 0) then
  begin
    if (Verbose) then
      MessageDlg('An error occurred while constructing heats.' + sLineBreak +
        'The number of new heats built was nil!' + sLineBreak +
        'Auto-Build Heats was aborted.', mtError, [mbOK], 0, mbOK);
    // Return true - need refresh of grids after cleaning heats.
    exit;
  end;
end;

function TAutoBuildV2.AutoBuildExecuteExt(SourceEventID: integer;
  TypeOfFinals: scmEventFinalsType): boolean;
var
  NomineeCountExt, numOfSwimmingLanes, NumOfPoolLanes, MaxNumOfNominees,
    numberOfHeats, numOfNominees, destEventID, mySeedDepth: integer;

begin
  result := false;
  NomineeCountExt := 0;
  mySeedDepth := 2;

  numOfSwimmingLanes := GetNumOfSwimmingLanes(NumOfPoolLanes,
    prefExcludeOutsideLanes);

  qryNomineeCountExt.Close;
  qryNomineeCountExt.ParamByName('EVENTID').AsInteger := SourceEventID;
  qryNomineeCountExt.Prepare;
  qryNomineeCountExt.Open;
  if (qryNomineeCountExt.Active) then
    NomineeCountExt := qryNomineeCountExt.FieldByName('NomineeCountExt')
      .AsInteger;
  qryNomineeCountExt.Close;

  case (TypeOfFinals) of
    ftFinals:
      if (NomineeCountExt < 2) then
      begin
        MessageDlg('A least two swimmers are needed to build a final.', mtError,
          [mbOK], 0);
        exit;
      end;
    ftSemi:
      if (NomineeCountExt < 4) then
      begin
        MessageDlg('The selected event must have at least' + sLineBreak +
          'four swimmers to build semi-finals.', mtError, [mbOK], 0);
        exit;
      end;
    ftQuarter:
      if (NomineeCountExt < 8) then
      begin
        MessageDlg('The selected event must have at least' + sLineBreak +
          'eight swimmers to build quarter-finals.', mtError, [mbOK], 0);
        exit;
      end;
  end;

  SCM.dsEvent.DataSet.DisableControls();

  qrySourceEvent.Close;
  qrySourceEvent.ParamByName('EVENTID').AsInteger := SourceEventID;
  qrySourceEvent.Prepare;
  qrySourceEvent.Open;
  if (qrySourceEvent.Active) then
  begin
    if (qrySourceEvent.IsEmpty) then
    begin
      qrySourceEvent.Close;
      exit;
    end;

    case (TypeOfFinals) of
      ftFinals:
        begin
          MaxNumOfNominees := numOfSwimmingLanes;
          numberOfHeats := 1;
        end;
      ftSemi:
        begin
          MaxNumOfNominees := (numOfSwimmingLanes * 2);
          numberOfHeats := 2;
        end;
      ftQuarter:
        begin
          MaxNumOfNominees := (numOfSwimmingLanes * 4);
          numberOfHeats := 4;
        end;
    else
      begin
        MaxNumOfNominees := 0;
        numberOfHeats := 0;
      end;
    end;

    if (prefSeperateGender) then
    begin
      SCM.luGender.DataSet.First;
      while not SCM.luGender.DataSet.Eof do
      begin
        // CREATE A NEW EVENT FOR EACH DATATYPE.
        destEventID := CreateNewEvent(qrySourceEvent, TypeOfFinals);
        // FILTER BY GENDER
        qrySourceEvent.Filter := 'GenderID := ' +
          SCM.luGender.DataSet.FieldByName('GenderID').AsString;
        qrySourceEvent.Filtered := true;
        // build the list of nominees for the FINAL TYPE ...
        numOfNominees := AssignNomineesExt(qrySourceEvent, destEventID,
          MaxNumOfNominees);
        // Special arrays that manage the seeding
        PrepDynamicArrays(destEventID, numOfNominees, numberOfHeats);
        // prepare the destination query
        qryNomineesExt.Close;
        qryNomineesExt.ParamByName('SRCEVENTID').AsInteger := SourceEventID;
        qryNomineesExt.ParamByName('DESTEVENTID').AsInteger := destEventID;
        qryNomineesExt.ParamByName('SESSIONSTART').AsDateTime :=
          SCM.Session_Start;
        qryNomineesExt.ParamByName('GENDERID').AsInteger :=
          SCM.luGender.DataSet.FieldByName('GenderID').AsInteger;
        qryNomineesExt.Prepare;
        qryNomineesExt.Open;
        if (qryNomineesExt.Active) then
        begin
          // Seed nominees into FINAL TYPE
          SeedNominees(qryNomineesExt, prefSeedMethod, mySeedDepth);
        end;
        SCM.luGender.DataSet.Next;
      end;
    end
    else
    begin
      qrySourceEvent.Filter := '';
      qrySourceEvent.Filtered := false;
      destEventID := CreateNewEvent(qrySourceEvent, TypeOfFinals);
      numOfNominees := AssignNomineesExt(qrySourceEvent, destEventID,
        MaxNumOfNominees);
      PrepDynamicArrays(destEventID, numOfNominees, numberOfHeats);
      qryNomineesExt.Close;
      // retrive memberID, genderID and RaceTime . TTB
      qryNomineesExt.ParamByName('SRCEVENTID').AsInteger := SourceEventID;
      // Nominees for the destination event have been fully populated
      qryNomineesExt.ParamByName('DESTEVENTID').AsInteger := destEventID;
      // for PersonalBest PB
      qryNomineesExt.ParamByName('SESSIONSTART').AsDateTime :=
        SCM.Session_Start;
      // display all genders ....
      qryNomineesExt.ParamByName('GENDERID').AsInteger := 0;
      qryNomineesExt.Prepare;
      qryNomineesExt.Open;
      if (qryNomineesExt.Active) then
        SeedNominees(qryNomineesExt, prefSeedMethod, mySeedDepth);
    end;
  end;

  // ****************************************************************
  // FREE DYNAMIC ARRAY
  // ****************************************************************
  SetLength(NomineesInHeat, 0);
  SetLength(HeatIDs, 0);

  SCM.dsEvent.DataSet.EnableControls;
  result := true;

end;

function TAutoBuildV2.CircleSeed(DataSet: TFDQuery; seedDepth: integer)
  : integer;
var
  i, j, laneNumber, NumOfPoolLanes, entrantsAssigned, lowBounds: integer;
  Success: boolean;
begin
  // if depth is 3 and number of pool lanes is 8 then
  // fastest  three swimmers will use index = 1 and
  // will be placed into lane 4.
  // Second fastest swimmers will be index 2 and
  // will be placed into lane 5.
  entrantsAssigned := 0;
  // ********************************
  // seedDepth IS BASE 1  : Dynamic Arrays are base 0....
  // ********************************
  // The total number of pool lanes must be passed to scatter
  // (the routine ignores preExcludeOutsideLanes)
  NumOfPoolLanes := SCM.SwimClub_NumberOfLanes;
  // seedDepth is BASE 1 - brackets needed!
  lowBounds := (High(HeatIDs) - (seedDepth - 1)); // must have brackets!
  if (lowBounds < Low(HeatIDs)) then
  begin
    lowBounds := Low(HeatIDs);
  end;

  // ITERATE over number of pool lanes
  // get the next SET of fastest swimmers
  for i := 0 to NumOfPoolLanes - 1 do
  begin
    // Reverse ITERATE over Heats - down to depth.
    // Stacking the fastest heat to be the last to run.
    for j := High(HeatIDs) downto lowBounds do
    begin
      if DataSet.Eof then
        break;
      // if lane count exceed the number of nominees in the heat
      // move the current nominee into to next heat ...
      if (i < NomineesInHeat[j]) then
      begin
        // swimmers index value is passed as base 0
        laneNumber := SCMUtility.ScatterLanes(i, NumOfPoolLanes);
        Success := AssignLane(DataSet, HeatIDs[j], laneNumber);
        // next nominee
        if (Success) then
        begin
          DataSet.Next;
          entrantsAssigned := entrantsAssigned + 1;
        end;
      end;
    end;
  end;
  result := entrantsAssigned;
end;

function TAutoBuildV2.CountNominees(EventID: integer): integer;
begin
  result := 0;
  if AssertConnection then
  begin
    qryGenericCount.Close;
    qryGenericCount.ParamByName('EVENTID').AsInteger := EventID;
    qryGenericCount.Prepare;
    qryGenericCount.Open;
    if not qryGenericCount.Active then
      exit;
    if not qryGenericCount.IsEmpty then
      // return the number of nominees
      result := qryGenericCount.FieldByName('countNominees').AsInteger;
    qryGenericCount.Close;
  end;
end;

function TAutoBuildV2.CreateNewEmptyHeat(EventID: integer): integer;
var
  SearchOptions: TLocateOptions;
  NextHeatNum, NumberOfLanes, iterLanes, HeatID: integer;
  pass: boolean;
begin
  result := 0;
  SearchOptions := [];

  // GET a lane count for ALL pool lanes. (ignore prefExcludeOutsideLanes)
  NumberOfLanes := SCM.SwimClub_NumberOfLanes;
  // find the next heat number **tblEvent.tbl_ABHeat.MAX(HeatNum)+1**
  // if no heats in event or error ... returns 0
  NextHeatNum := GetHeatMaxSeedNumber(EventID) + 1;

  tbl_ABHeat.Open;
  tbl_ABHeat.Append;
  // Heat Number as calculated by GetMaxHeatNum()
  tbl_ABHeat.FieldByName('HeatNum').AsInteger := NextHeatNum;
  // Assign EventID ...
  tbl_ABHeat.FieldByName('EventID').AsInteger := EventID;
  // set to heat (or alt... quarter, semi, final)
  tbl_ABHeat.FieldByName('HeatTypeID').AsInteger := 1;
  // set to Open (or alt... raced, Closed)
  tbl_ABHeat.FieldByName('HeatStatusID').AsInteger := 1;
  tbl_ABHeat.Post;

  // CREATE all the LANES (empty of entrants)
  pass := tbl_ABHeat.Locate('HeatNum; EventID',
    VarArrayOf([NextHeatNum, EventID]), SearchOptions);
  if (pass) then
  begin
    tbl_ABEntrant.Open;
    HeatID := tbl_ABHeat.FieldByName('HeatID').AsInteger;
    for iterLanes := 0 to NumberOfLanes - 1 do
    begin
      tbl_ABEntrant.Append;
      // Assign new created tbl_ABHeat.HeatID
      tbl_ABEntrant.FieldByName('HeatID').AsInteger :=
        tbl_ABHeat.FieldByName('HeatID').AsInteger;
      // Assign lane number
      tbl_ABEntrant.FieldByName('Lane').AsInteger := (iterLanes + 1);
      tbl_ABEntrant.Post;
    end;
    tbl_ABEntrant.Close;
    result := HeatID;
  end;
  tbl_ABHeat.Close;
end;

function TAutoBuildV2.CreateNewEvent(SourceEvent: TFDQuery;
  TypeOfFinals: scmEventFinalsType): integer;
var
  s: string;
begin
  case (TypeOfFinals) of
    ftFinals:
      s := 'FINALS (seed event# ';
    ftSemi:
      s := 'SEMI-FINALS (seed event# ';
    ftQuarter:
      s := 'QUATER-FINALS (seed event# ';
  end;
  s := s + SourceEvent.FieldByName('EventNum').AsString;
  s := s + '): ';
  s := s + SourceEvent.FieldByName('Caption').AsString;
  qryInsertEvent.Close;
  qryInsertEvent.ParamByName('CAPTION').AsString := s;
  qryInsertEvent.ParamByName('DISTANCEID').AsInteger :=
    SourceEvent.FieldByName('DistanceID').AsInteger;;
  qryInsertEvent.ParamByName('STROKEID').AsInteger :=
    SourceEvent.FieldByName('StrokeID').AsInteger;;
  qryInsertEvent.ParamByName('SESSIONID').AsInteger := SCM.Session_ID();
  qryInsertEvent.Prepare();
  qryInsertEvent.Execute();
  { TODO -oBSA -cGeneral : Check new Scalar function. }
  // How To Get Last Inserted ID On SQL Server for a specific table.
  s := 'SELECT IDENT_CURRENT(''SwimClubMeet.dbo.Event'') AS LastID;';
  // return EventID
  result := SCM.scmConnection.ExecSQLScalar(s);
end;

procedure TAutoBuildV2.DataModuleCreate(Sender: TObject);
var
  iniFileName: string;
begin

  // Default preferences ...
  prefExcludeOutsideLanes := false;
  prefHeatAlgorithm := 1; // average of the 3 best racetimes
  prefUseDefRaceTime := true;
  prefRaceTimeTopPercent := 50.0;
  prefSeperateGender := false;
  prefGroupBy := 0;

  prefSeedMethod := smSCMSeeding;
  prefSeedDepth := 3; // Base 1

  prefImportSeedTime := 0;

  if not Assigned(SCM) then
    raise Exception.Create('SCM data module not assigned.');

  // As SCM is a TEMPORY connection - ASSERT assignment for FireDAC.
  qryMemberTypeCount.Connection := SCM.scmConnection;
  qryGenderCount.Connection := SCM.scmConnection;
  qryHeatsToDelete.Connection := SCM.scmConnection;
  qryUnplaced.Connection := SCM.scmConnection;
  qryRenumberHeats.Connection := SCM.scmConnection;
  qryInsertEvent.Connection := SCM.scmConnection;
  qryNomineesExt.Connection := SCM.scmConnection;
  qryNomineeCountExt.Connection := SCM.scmConnection;
  qrySourceEvent.Connection := SCM.scmConnection;
  qryHeatMaxSeedNumber.Connection := SCM.scmConnection;
  qryGenericCount.Connection := SCM.scmConnection;
  qryGenderAgeCount.Connection := SCM.scmConnection;
  qryAgeCount.Connection := SCM.scmConnection;
  qryGenderMemberTypeCount.Connection := SCM.scmConnection;
  qryNominees.Connection := SCM.scmConnection;
  tbl_ABEntrant.Connection := SCM.scmConnection;
  tbl_ABHeat.Connection := SCM.scmConnection;

  // read the preference file
  iniFileName := GetSCMPreferenceFileName();
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName);
end;

function TAutoBuildV2.GetHeatMaxSeedNumber(EventID: integer): integer;
var
  ds: TFDQuery;
begin
  result := 0;
  ds := qryHeatMaxSeedNumber;
  ds.Close;
  ds.ParamByName('EVENTID').AsInteger := EventID;
  ds.Prepare;
  ds.Open;
  if not ds.Active then
    exit;
  if not ds.IsEmpty then
    result := ds.FieldByName('HeatMaxSeedNumber').AsInteger;
  ds.Close;
end;

function TAutoBuildV2.GetNumOfSwimmingLanes(var NumOfPoolLanes: integer;
  DoExcludeOutsideLanes: boolean): integer;
begin
  result := 0;
  if AssertConnection then
  begin
    NumOfPoolLanes := SCM.SwimClub_NumberOfLanes;
    result := NumOfPoolLanes;
    if (DoExcludeOutsideLanes) then
      result := result - 2;
  end;
end;

procedure TAutoBuildV2.PrepDynamicArrays(EventID, numOfNominees,
  numberOfHeats: integer);
var
  i, j: integer;
  d: double;
begin
  // NOMINEESINHEAT - the number of nominees to place into each heat.
  SetLength(NomineesInHeat, numberOfHeats);
  // HEATIDS - the HeatIDs of the newly created heats
  SetLength(HeatIDs, numberOfHeats);
  // ***************************************************************
  // FILL DYNAMIC ARRAY WITH DATA
  // FILL HEAT IDs AND NUMBER OF ENTRANTS IN EACH HEAT ID.
  // ***************************************************************
  for i := 0 to numberOfHeats - 1 do
  begin
    // ***********************************************************
    // ALGORITHM ... NUMBER OF NOMINEES IN HEAT
    // store the number of nominees to be entered into this heat
    // ***********************************************************
    { TODO -oBSA -cGeneral : ALERT : Check algorithm - it's changed }
    d := (numOfNominees + numberOfHeats - (i + 1)) / numberOfHeats;
    // Floor ? Round ? Ceiling ?
    j := Floor(d);

    NomineesInHeat[i] := j;
    // C A L L   T O   C R E A T E   N E W   H E A T   . . .
    // and new empty entrant records
    // on error HeatID == 0
    HeatIDs[i] := CreateNewEmptyHeat(EventID);
  end;
end;

procedure TAutoBuildV2.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
  i: integer;
begin
  iFile := TIniFile.Create(iniFileName);
  {
    (0) ... use the entrant's last know racetime
    (1) ... the average of 3 fastest race-times
    (3) ... use entrant's personal best
  }
  prefHeatAlgorithm := iFile.ReadInteger('Preferences', 'HeatAlgorithm', 1);
  { For entrant's without racetimes ... checkbox (tri-state) }
  i := iFile.ReadInteger('Preferences', 'UseDefRaceTime', integer(cbChecked));
  if (i = 1) then
    prefUseDefRaceTime := true
  else
    prefUseDefRaceTime := false;
  { Calculate a racetime based on the mean average of the bottom
    (#PERCENT#) percent. (With consideration to age and gender)
    ... default #PERCENT# := 50% }
  prefRaceTimeTopPercent := iFile.ReadFloat('Preferences',
    'RaceTimeTopPercent', 50.0);
  { omit gutter lanes ... checkbox (tri-state) }
  i := iFile.ReadInteger('Preferences', 'ExcludeOutsideLanes',
    integer(cbUnchecked));
  if (i = 1) then
    prefExcludeOutsideLanes := true
  else
    prefExcludeOutsideLanes := false;
  { seperate entrant's based on GenderID ... checkbox (tri-state) }
  i := iFile.ReadInteger('Preferences', 'SeperateGender', integer(cbUnchecked));
  if (i = 1) then
    prefSeperateGender := true
  else
    prefSeperateGender := false;
  // S E E D   M E T H O D . . .
  prefSeedMethod := seedMethod(iFile.ReadInteger('Preferences',
    'SeedMethod', 0));
  { /* 2020-11-01 auto-build v2 seed depth for Circle Seed */ }
  prefSeedDepth := (iFile.ReadInteger('Preferences', 'SeedDepth', 3));
  { /group on....
    Don't (DEFAULT),
    Entrant Age,
    Entrant Swimming Category,
    Division
  }
  prefGroupBy := iFile.ReadInteger('Preferences', 'GroupBy', 0);

  // defaullt - do nothing - ignore
  // SEEDTIME IS USED TO INJECT DATA INTO ENTRANT TABLE
  // use the preference dialog to enable and set options.
  // NOTE: the session date used will be Now().
  prefImportSeedTime := iFile.ReadInteger('Preferences', 'ImportSeedTime', 0);

  iFile.Free;
end;

function TAutoBuildV2.RenumberHeats(EventID: integer): integer;
var
  ds: TFDQuery;
  iter: integer;
begin
  result := 0;
  iter := 1;
  ds := qryRenumberHeats;
  ds.Close;
  // ORDER BY HeatNum ASC ... NULL IS LAST. INDEX HeatID;
  ds.ParamByName('EVENTID').AsInteger := EventID;
  ds.Prepare;
  ds.Open();
  while not ds.Eof do
  begin
    ds.Edit;
    ds.FieldByName('HeatNum').AsInteger := result;
    ds.Post;
    iter := iter + 1;
    ds.Next;
  end;
  ds.Close;
  result := iter;
end;

(*
  function TAutoBuildV2.ScatterLanes(index, NumOfPoolLanes: integer): integer;
  var
  Lanes: Array of integer;
  i: integer;
  IsEven: boolean;
  begin
  result := 0;
  // NumOfPoolLanes must be greater than 1
  if (NumOfPoolLanes < 2) then
  exit;
  // index passed is base 0
  // test for out-of-bounds
  if ((index + 1) > NumOfPoolLanes) then
  exit;
  SetLength(Lanes, NumOfPoolLanes);
  // seed number for first array value
  // Find the center lane. For 'odd' number of pool lanes - round up;
  Lanes[0] := Ceil(double(NumOfPoolLanes) / 2.0);
  // build the
  for i := 1 to NumOfPoolLanes - 1 do
  begin
  // start the iterate at index 1
  // reference previous value in list with base 0
  if (((i + 1) MOD 2) = 0) then
  IsEven := true
  else
  IsEven := false;
  if IsEven then
  Lanes[i] := (i) + (Lanes[(i - 1)])
  else
  Lanes[i] := (Lanes[(i - 1)]) - (i);
  end;
  // pull the entrants lane number.
  result := Lanes[index];

  {
  You don't need to call SetLength at the end.
  A dynamic-array field like 'Lanes' gets released automatically when
  the object is destroyed.

  }
  // free the array.   ALT Lanes := nil;
  SetLength(Lanes, 0);
  end;
*)

function TAutoBuildV2.SeedNominees(DataSet: TFDQuery; mySeedMethod: seedMethod;
  mySeedDepth: integer): integer;
var
  i, entrantsAssigned, totalNumberOfEntrants, fSeedDepth: integer;
begin
  totalNumberOfEntrants := 0;
  // ****************************************************************
  // SEED THE NOMINEES
  // ****************************************************************
  case (mySeedMethod) of

    // 1.Timed Finals Seeding
    // The fastest athletes/relays are assigned lanes alternating left/right starting
    // in the center of the pool. In an 8 lane pool, the lanes typically would be
    // assigned 4-5-3-6-2-7-1-8 with the fastest entry in the heat in lane 4 and
    // the slowest in lane 8. This type of seeding is used for one round events
    // and for the final round of a multi-round event.
    smTimedFinalsSeeding, smSCMSeeding:
      begin
        for i := High(HeatIDs) downto Low(HeatIDs) do
        begin
          entrantsAssigned := AssignLanes(DataSet, HeatIDs[i],
            NomineesInHeat[i]);
          totalNumberOfEntrants := totalNumberOfEntrants + entrantsAssigned;
        end;
      end;
    // 2.Circle Seeding
    // This format is used primarily for Preliminaries and Semis where the fastest
    // swimmers are Circle Seeded in the last 3 heats using a straight serpentine
    // method. In special cases the circle seeding is performed on more or less than
    // the last 3 heats. All remaining heats are seeded using the Timed Finals methods.
    smCircleSeedingTimed, smCircleSeeding:
      begin
        // adjust the seed depth to remain in the bounds of heats
        // SEED DEPTH IS BASE 1
        i := (High(HeatIDs) - Low(HeatIDs)); // BASE 0
        if (i < (mySeedDepth - 1)) then // BASE 0 comparision
          fSeedDepth := (i + 1) // BASE 1
        else
          fSeedDepth := mySeedDepth; // BASE 1

        // assert positioned at starting record of nominees table
        DataSet.First();
        // fill out heats within depth
        // pass in seed depth base = 1
        totalNumberOfEntrants := CircleSeed(DataSet, fSeedDepth);
        // complete the remaining heats
        // Note : fSeedDepth is BASE 1 - this places us at the next heatID
        // that follows the above circle seeding..
        //
        // if there is 3 heats and seedDepth is two
        // HIHG = 2, LOW = 0
        // then circle seed has completed heats 2 and 1  (BASE 0)
        // next heat will be 0
        i := (High(HeatIDs) - fSeedDepth);
        if (i >= Low(HeatIDs)) and not DataSet.Eof then
        begin
          for i := i downto Low(HeatIDs) do
          begin
            // iterate across the Heats - assigning lanes to each entrant....
            entrantsAssigned := AssignLanes(DataSet, NomineesInHeat[i],
              HeatIDs[i]);
            totalNumberOfEntrants := totalNumberOfEntrants + entrantsAssigned;
          end;
        end;
      end;
    // 3.Dual Seeding
    // This type of seeding is usually for meets with two to four teams competing in
    // multiple dual meets.  Each team is assigned specific lanes.
    smDualSeeding:
      ;
    // 4.Masters Championship Seeding
    // This is seeding by age then time specifically designed for Masters Swimming.
    smMastersChampionSeeding:
      ;
  end;

  result := totalNumberOfEntrants;
end;

end.
