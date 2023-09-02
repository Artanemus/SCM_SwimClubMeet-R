unit SCMNomination;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils, System.Math,
  System.IniFiles, System.Variants, System.UITypes, Vcl.StdCtrls, Vcl.Dialogs,
  FireDAC.Comp.Client, Winapi.Windows,
  SCMUtility, SCMDefines;

type
  TEventType = (etUnknown = 0, etINDV = 1, etTEAM = 2);

type

  TSCMNomination = record
  private
    FCheckNomination: integer;
    { private declarations }
    fCheckUnNomination: integer;
    FConnection: TFDConnection;
    fHandle: THandle;
    procedure ClearLane(aID: integer; aEventType: TEventType = etUnknown);
    procedure DeleteNomination(aID: integer; aEventType: TEventType = etUnknown); overload;
    // RTN EventID for the given EntrantID or TeamEntrantID
    function GetEventID(aID: integer; aEventType: TEventType): integer;
    // RTN the EventType enum of the given EventID
    function GetEventType(aEventID: integer): TEventType;
    // Get the HeatStatus for the given EntrantID or TeamEntrantID
    function GetHeatStatusID(aID: integer; aEventType: TEventType = etUnknown)
      : integer; overload;
    // Get the EntrantID or the TeamEntrantID
    function GetID(aMemberID, aEventID: integer;
      aEventType: TEventType = etUnknown): integer;
    // RTN MemberID for the given EntrantID or TeamEntrantID
    function GetMemberID(aID: integer; aEventType: TEventType): integer;
    function IsMemberInEvent(aMemberID, aEventID: integer;
      aEventType: TEventType = etUnknown): boolean;
    function IsMemberNominated(aMemberID, aEventID: integer): boolean;
    procedure StrikeLane(aID: integer; aEventType: TEventType = etUnknown); overload;
    // un-nominate the swimmer for a given EntrantID or TeamEntrantID
    procedure UnNominateMember(aID: integer; aEventType: TEventType = etUnknown); overload;
  public
    procedure DeleteNomination(aMemberID, aEventID: integer); overload;
    function NominateMember(aMemberID, aEventID: integer): boolean;
    function StrikeLane(aMemberID, aEventID: integer): boolean; overload;
    function UnNominateMember(aMemberID, aEventID: integer): boolean; overload;
    class operator Finalize(var Dest: TSCMNomination);
    { public declarations }
    // In Delphi 10.4 'Managed Records' was introduced.
    // variables can now be initialized
    class operator Initialize(out Dest: TSCMNomination);
    property CheckNomination: integer read FCheckNomination write FCheckNomination;
    property Connection: TFDConnection read FConnection write FConnection;
    property Handle: THandle read fHandle write fHandle;
  end;

implementation

{ TSCMNomination }

procedure TSCMNomination.ClearLane(aID: integer;
  aEventType: TEventType = etUnknown);
var
  SQL: string;
begin
  if Assigned(FConnection) then
  begin
    if (aEventType = etINDV) then
    begin
      // delete split data (joined on dbo.Entrant)
      SQL := 'DELETE FROM SwimClubMeet.dbo.Split WHERE split.EntrantID = :ID';
      FConnection.ExecSQL(SQL, [aID]);
      // clear the entrant from the lane
      SQL := 'UPDATE Entrant SET [MemberID] = NULL ' +
        ',[RaceTime] = NULL ,[TimeToBeat] = NULL ' +
        ',[PersonalBest] = NULL ,[DisqualifyCodeID] = NULL ' +
        ',[IsDisqualified] = 0 ,[IsScratched] = 0 ' +
        'FROM SwimClubMeet.dbo.Entrant ' + 'WHERE EntrantID = :ID;';
      FConnection.ExecSQL(SQL, [aID]);
    end
    else if (aEventType = etTEAM) then
    begin
      // delete split data (joined on dbo.Team)
      SQL := 'DELETE FROM SwimClubMeet.dbo.TeamSplit WHERE TeamSplit.TeamID = :ID';
      FConnection.ExecSQL(SQL, [aID]);
      // delete team entrants (joined on dbo.Team)
      SQL := 'DELETE FROM SwimClubMeet.dbo.TeamEntrant WHERE TeamEntrant.TeamID = :ID';
      FConnection.ExecSQL(SQL, [aID]);
      // clear the relay team from the lane
      SQL := 'UPDATE Team SET [TeamNameID] = NULL ' + ',[RaceTime] = NULL ' +
        ',[TimeToBeat] = NULL ,[DisqualifyCodeID] = NULL ' +
        ',[IsDisqualified] = 0 ,[IsScratched] = 0 ' +
        'FROM SwimClubMeet.dbo.Team WHERE TeamID = :ID;';
      FConnection.ExecSQL(SQL, [aID]);
    end
    else
      exit;
  end;
end;

procedure TSCMNomination.DeleteNomination(aMemberID, aEventID: integer);
var
  SQL: string;
begin
  if Assigned(FConnection) then
  begin
    SQL := 'DELETE FROM SwimClubMeet.[dbo].[Nominee] ' +
      'WHERE MemberID = :MemberID AND EventID = :EventID;';
    FConnection.ExecSQL(SQL, [aMemberID, aEventID]);
  end;
end;

function TSCMNomination.GetEventID(aID: integer;
  aEventType: TEventType): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if Assigned(FConnection) then
  begin
    if (aEventType = etINDV) then
    begin
      SQL := 'SELECT HeatIndividual.EventID ' +
        'FROM [SwimClubMeet].[dbo].[Entrant] ' +
        'INNER JOIN HeatIndividual ON [Entrant].HeatID = HeatIndividual.HeatID '
        + 'WHERE Entrant.EntrantID = :aID';
      v := FConnection.ExecSQLScalar(SQL, [aID]);
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
      begin
        result := v;
      end;
    end
    else if (aEventType = etTEAM) then
    begin
      SQL := 'SELECT HeatIndividual.EventID ' +
        'FROM [SwimClubMeet].[dbo].[TeamEntrant] ' +
        'INNER JOIN Team ON TeamEntrant.TeamID = Team.TeamID ' +
        'INNER JOIN HeatIndividual ON [Team].HeatID = HeatIndividual.HeatID ' +
        'WHERE TeamEntrant.TeamEntrantID = :aID';
      v := FConnection.ExecSQLScalar(SQL, [aID]);
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
        result := v;
    end;
  end;
end;

function TSCMNomination.GetEventType(aEventID: integer): TEventType;
begin
// TODO
end;

function TSCMNomination.GetHeatStatusID(aID: integer;
  aEventType: TEventType): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if Assigned(FConnection) then
  begin
    if (aEventType = etINDV) then
    begin
      SQL := 'SELECT HeatStatusID FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
        'INNER JOIN Entrant ON [HeatIndividual].[HeatID] = Entrant.HeatID ' +
        'WHERE [Entrant].[EntrantID] = :ID;';
      v := FConnection.ExecSQLScalar(SQL, [aID]);
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
        result := v;
    end;
    if (aEventType = etTEAM) then
    begin
      SQL := 'SELECT HeatStatusID FROM [SwimClubMeet].[dbo].[HeatIndividual] ' +
        'INNER JOIN Team ON [HeatIndividual].[HeatID] = Team.HeatID ' +
        'INNER JOIN TeamEntrant ON [Team].[TeamID] = [TeamEntrant].[TeamID] ' +
        'WHERE [TeamEntrant].[TeamEntrantID] = :ID;';
      v := FConnection.ExecSQLScalar(SQL, [aID]);
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
        result := v;
    end;
  end;
end;

function TSCMNomination.GetID(aMemberID, aEventID: integer;
  aEventType: TEventType): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if Assigned(FConnection) then
  begin
    if (aEventType = etINDV) or (aEventType = etUnknown) then
    begin
      SQL := 'SELECT TOP 1 Entrant.EntrantID FROM [SwimClubMeet].[dbo].[Event] '
        + 'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.EventID '
        + 'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID ' +
        'WHERE [Event].EventID = :EventID AND (Entrant.MemberID = :MemberID)';
      v := FConnection.ExecSQLScalar(SQL, [aMemberID, aEventID]);
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
      begin
        result := v;
        exit;
      end;
    end;
    if (aEventType = etTEAM) or (aEventType = etUnknown) then
    begin
      SQL := 'SELECT TOP 1 TeamEntrant.TeamEntrantID FROM [SwimClubMeet].[dbo].[Event] '
        + 'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.EventID '
        + 'INNER JOIN Team ON HeatIndividual.HeatID = Team.HeatID ' +
        'INNER JOIN TeamEntrant ON Team.TeamID = TeamEntrant.TeamID ' +
        'WHERE [Event].EventID = :EventID AND (TeamEntrant.MemberID = :MemberID)';
      v := FConnection.ExecSQLScalar(SQL, [aMemberID, aEventID]);
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
        result := v;
    end;
  end;
end;

function TSCMNomination.GetMemberID(aID: integer;
  aEventType: TEventType): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if Assigned(FConnection) then
  begin
    if (aEventType = etINDV) then
    begin
      SQL := 'SELECT Entrant.MemberID FROM [SwimClubMeet].[dbo].[Entrant] ' +
        'WHERE Entrant.EntrantID = :aID';
      v := FConnection.ExecSQLScalar(SQL, [aID]);
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
      begin
        result := v;
      end;
    end
    else if (aEventType = etTEAM) then
    begin
      SQL := 'SELECT TeamEntrant.MemberID FROM [SwimClubMeet].[dbo].[TeamEntrant] '
        + 'WHERE TeamEntrant.TeamEntrantID = :aID';
      v := FConnection.ExecSQLScalar(SQL, [aID]);
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
        result := v;
    end;
  end;
end;

function TSCMNomination.IsMemberInEvent(aMemberID, aEventID: integer;
  aEventType: TEventType): boolean;
begin
  result := false;
  if (GetID(aMemberID, aEventID, aEventType) > 0) then
    result := true;
end;

function TSCMNomination.IsMemberNominated(aMemberID, aEventID: integer)
  : boolean;
var
  SQL: string;
  v: variant;
begin
  result := false;
  if Assigned(FConnection) then
  begin
    SQL := 'SELECT Nominee.NomineeID FROM SwimClubMeet.dbo.Nominee ' +
      'WHERE Nominee.MemberID = :MEMBERID AND Nominee.EventID = :EVENTID;';
    v := FConnection.ExecSQLScalar(SQL, [aMemberID, aEventID]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
      result := true;
  end;
end;

function TSCMNomination.NominateMember(aMemberID, aEventID: integer): boolean;
var
  SQL: string;
  rows: integer;
begin
  result := false;
  if Assigned(FConnection) then
  begin
    SQL := 'INSERT INTO [SwimClubMeet].[dbo].[Nominee] ' +
      '([AutoBuildFlag],[TTB],[PB],[MemberID],[EventID],[SeedTime]) ' +
      'VALUES (0,NULL,NULL,:MemberID,:EventID,NULL)';
    rows := FConnection.ExecSQL(SQL, [aMemberID, aEventID]);
    if rows > 0 then
      result := true;
  end;
end;

function TSCMNomination.StrikeLane(aMemberID, aEventID: integer): boolean;
var
  aID: integer;
  aEventType: TEventType;
begin
  result := false;

  aEventType := GetEventType(aEventID);
  aID := GetID(aMemberID, aEventID, aEventType);
  if (GetHeatStatusID(aID, aEventType) = 1) then
  begin
    DeleteNomination(aMemberID, aEventID); // remove nomination ...
    ClearLane(aID, aEventType); // Update Entrant Data
    result := true;
  end;
end;

procedure TSCMNomination.StrikeLane(aID: integer; aEventType: TEventType = etUnknown);
var
aMemberID, AEventID: integer;
begin
  // -------------------------------------------------------------------------
  // S T R I K E   L A N E .  E N T R A N T .
  // -------------------------------------------------------------------------
  // strike lane will remove the nominee data and clear the lane
  if (aID > 0) then
  begin
    if (GetHeatStatusID(aID, aEventType) = 1) then
    begin
      aMemberID := GetMemberID(aID, aEventType);
      aEventID := GetEventID(aID, aEventType);
      DeleteNomination(aMemberID, aEventID);
      ClearLane(aID, aEventType);
    end
  end;
end;

function TSCMNomination.UnNominateMember(aMemberID, aEventID: integer): boolean;
var
  aEventType: TEventType;
  aID: integer;
begin
  result := false;
  // Bad ID - exit procedure.
  if (aMemberID = 0) or (aEventID = 0) then
    exit;
  // The member isn't nominated for this event - exit procedure;
  if not IsMemberNominated(aMemberID, aEventID) then
    exit;
  aEventType := GetEventType(aEventID);
  aID := GetID(aMemberID, aEventID, aEventType);
  UnNominateMember(aID, aEventType);
  result := true;
end;

procedure TSCMNomination.UnNominateMember(aID: integer; aEventType: TEventType);
var
  DoEmptyLane: boolean;
  response: integer;
begin
  DoEmptyLane := false; // empty out lane.
  // Has the nominated member been given a lane?
  if (aID > 0) then
  begin
    // The heat is locked - exit procedure
    if (GetHeatStatusID(aID, aEventType) <> 1) then
    begin
      MessageDlg('The member is nominated and has been given a lane.' +
        sLineBreak + 'The assigned heat has been set to raced or closed.' +
        sLineBreak + 'The member can''t be un-nominated.',
        TMsgDlgType.mtInformation, [mbOK], 0);
      exit;
    end;
    // preference setting - the user the option to abort procedure
    if (fCheckUnNomination = integer(cbChecked)) then
    begin
      response := MessageDlg
        ('The member is nominated and has been given a lane.' + sLineBreak +
        'Remove the nomination AND empty the lane?', mtWarning,
        [mbYes, mbNo], 0, mbNo);
      if (response = mrNo) then
        exit;
    end;
    // ---------------------------------------------------------------------
    // S E T   T A S K   :  remove member from lane
    // ---------------------------------------------------------------------
    DoEmptyLane := true;
  end;
  // p e r f o r m   t a s k   - remove nomination.
  DeleteNomination(aID, aEventType);

  // p e r f o r m   t a s k   - remove entrant.
  if (DoEmptyLane) then
  begin
    if (aID > 0) then
    begin
      // NOTE : not using EmptyLane as heat status has been checked.
      ClearLane(aID, aEventType);
      // Entrant gird on main form will need refresh.
      if (fHandle <> 0) then
        PostMessage(fHandle, SCM_LANEWASCLEANED, 0, 0);
    end;
  end;
end;

class operator TSCMNomination.Finalize(var Dest: TSCMNomination);
begin

end;

class operator TSCMNomination.Initialize(out Dest: TSCMNomination);
var
  iniFileName: string;
begin
  Dest.FConnection := nil;
  Dest.fCheckUnNomination := integer(cbUnchecked);
  Dest.fHandle := 0;
end;

end.
