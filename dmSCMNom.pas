unit dmSCMNom;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, SCMDefines;

type
  TSCMNom = class(TDataModule)
    qryIsMemberInEvent: TFDQuery;
    qryEvent: TFDQuery;
    qryIsMemberNominated: TFDQuery;
    cmdNominateMember: TFDCommand;
    qryHeat: TFDQuery;
    cmdCleanLane: TFDCommand;
    cmdDeleteNominee: TFDCommand;
    qryEntrant: TFDQuery;
    qryGetEntrantID: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FConnection: TFDConnection;
    { Private declarations }
    prefCheckUnNomination: integer;
    procedure ReadPreferences(iniFileName: string);

    procedure DeleteNomination(aMemberID, aEventID: integer);
    function IsMemberInEvent(aMemberID, aEventID: integer): boolean;
    function IsMemberNominated(aMemberID, aEventID: integer): boolean;
    function IsMemberAssignedHeat(aMemberID, aEventID: integer): boolean;
    procedure CleanLane(aEntrantID: integer);
    function GetEntrantID(aMemberID, aEventID: integer): integer;
    function GetHeatStatusID(aEntrantID: integer): integer; overload;
    function GetHeatStatusID(aMemberID, aEventID: integer): integer; overload;
    function GetMemberAndEvent(aEntrantID: integer; var aMemberID: integer;
      var aEventID: integer): boolean;
    procedure HeatStatusWarning(HeatStatusID: integer);

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); reintroduce; overload;
    constructor CreateWithConnection(AOwner: TComponent; AConnection: TFDConnection);

    function NominateMember(aMemberID, aEventID: integer): boolean;
    function UnNominateMember(aMemberID, aEventID: integer): boolean;
    // Just cleans-up lane - doesn't remove nomination.
    function EmptyLane(aEntrantID: integer): boolean;
    // Only strikes if ... heat isn't closed or raced
    // if MemberID is found - will un-nominates first then clean-up lane
    function StrikeLane(aMemberID, aEventID: integer): boolean; overload;
    function StrikeLane(aEntrantID: integer): boolean; overload;
    // Execute is an extended version taking most of the code away from the caller.
    procedure StrikeExecute(aEntrantID: integer; aDataset: TDataSet);

    property Connection: TFDConnection read FConnection write FConnection;
  end;

var
  SCMNom: TSCMNom;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses SCMUtility, vcl.StdCtrls, System.IniFiles, vcl.Dialogs, System.UITypes,
vcl.Forms, winapi.Windows;

{$R *.dfm}
{ TDataModule1 }

procedure TSCMNom.CleanLane(aEntrantID: integer);
begin
  if Assigned(FConnection) then
  begin
    if (cmdCleanLane.Active) then
      cmdCleanLane.Close;
    cmdCleanLane.ParamByName('ENTRANTID').AsInteger := aEntrantID;
    cmdCleanLane.Prepare;
    cmdCleanLane.Execute;
  end;
end;

constructor TSCMNom.Create(AOwner: TComponent);
begin
  inherited;
  raise Exception.Create('Connection not assigned.');
end;

constructor TSCMNom.CreateWithConnection(AOwner: TComponent;  AConnection: TFDConnection);
begin
  inherited Create(AOwner);
  FConnection := AConnection;
end;

procedure TSCMNom.DataModuleCreate(Sender: TObject);
var
  iniFileName: string;
begin
  prefCheckUnNomination := integer(cbUnchecked);
  // read from preference file
  iniFileName := Scmutility.GetSCMPreferenceFileName;
  if (FileExists(iniFileName)) then
    ReadPreferences(iniFileName);

  // As SCM is a TEMPORY connection - ASSERT assignment for FireDAC.
  if Assigned(FConnection) then
  begin
    qryIsMemberInEvent.Connection := FConnection;
    qryIsMemberNominated.Connection := FConnection;
    qryGetEntrantID.Connection := FConnection;
    qryEntrant.Connection := FConnection;
    qryHeat.Connection := FConnection;
    qryEvent.Connection := FConnection;
    cmdCleanLane.Connection := FConnection;
    cmdNominateMember.Connection := FConnection;
    cmdDeleteNominee.Connection := FConnection;
  end;
end;

procedure TSCMNom.DeleteNomination(aMemberID, aEventID: integer);
begin
  if Assigned(FConnection) then
  begin
    if (cmdDeleteNominee.Active) then
      cmdDeleteNominee.Close;
    cmdDeleteNominee.ParamByName('MEMBERID').AsInteger := aMemberID;
    cmdDeleteNominee.ParamByName('EVENTID').AsInteger := aEventID;
    cmdDeleteNominee.Prepare;
    cmdDeleteNominee.Execute;
  end;
end;

function TSCMNom.EmptyLane(aEntrantID: integer): boolean;
var
  HeatStatusID: integer;
begin
  // -------------------------------------------------------------------------
  // E M P T Y   L A N E .
  // -------------------------------------------------------------------------
  // Empty lane removes any reference of the member but doesn't
  // delete the member from the nominations.
  // Only heats that are open can have there lanes emptied
  //
  // NOTE:
  // Attempting to Clear MemberID using SCM->dsEntrant ends in an
  // exception error - 'MemberID must have a value'
  // UNLESS THE TFDQuery has UpdateOptions -'CheckRequired' disabled
  // I BELIEVE THIS HAS BEEN FIXED IN KEY ATTIBUTES
  result := false;
  HeatStatusID := GetHeatStatusID(aEntrantID);
  if (HeatStatusID = 1) then
  begin
    CleanLane(aEntrantID);
    result := true;
  end
  else
    HeatStatusWarning(HeatStatusID);
end;

function TSCMNom.GetEntrantID(aMemberID, aEventID: integer): integer;
begin
  result := 0;
  if Assigned(FConnection) then
  begin
    if (qryGetEntrantID.Active) then
      qryGetEntrantID.Close;
    qryGetEntrantID.ParamByName('MEMBERID').AsInteger := aMemberID;
    qryGetEntrantID.ParamByName('EVENTID').AsInteger := aEventID;
    qryGetEntrantID.Prepare;
    qryGetEntrantID.Open;
    if (qryGetEntrantID.Active) then
    begin
      if not(qryGetEntrantID.IsEmpty) then
      begin
        qryGetEntrantID.Last;
        if (qryGetEntrantID.RecordCount > 1) then
          MessageDlg('OOPS :: An unexpected error has been occurred.' +
            sLineBreak +
            'The member has been placed multiply times into this event!',
            mtWarning, [mbOK], 0, mbOK)
        else
          result := qryGetEntrantID.FieldByName('EntrantID').AsInteger;
      end;
    end;
    qryGetEntrantID.Close;
  end;
end;

function TSCMNom.GetHeatStatusID(aEntrantID: integer): integer;
begin
  result := 0;
  if Assigned(FConnection) then
  begin
    if (qryEntrant.Active) then
      qryEntrant.Close;
    qryEntrant.ParamByName('ENTRANTID').AsInteger := aEntrantID;
    qryEntrant.Prepare;
    qryEntrant.Open;
    if (qryEntrant.Active) then
    begin
      if not(qryEntrant.IsEmpty) then
        result := qryEntrant.FieldByName('HeatStatusID').AsInteger;
    end;
    qryEntrant.Close;
  end;
end;

function TSCMNom.GetHeatStatusID(aMemberID, aEventID: integer): integer;
var
  aEntrantID: integer;
begin
  result := 0;
  aEntrantID := GetEntrantID(aMemberID, aEventID);
  if (aEntrantID > 0) then
    result := GetHeatStatusID(aEntrantID);
end;

function TSCMNom.GetMemberAndEvent(aEntrantID: integer;
  var aMemberID, aEventID: integer): boolean;
begin
  result := false;
  if Assigned(FConnection) then
  begin
    if (qryEntrant.Active) then
      qryEntrant.Close;
    qryEntrant.ParamByName('ENTRANTID').AsInteger := aEntrantID;
    qryEntrant.Prepare;
    qryEntrant.Open;
    if (qryEntrant.Active) then
    begin
      if not(qryEntrant.IsEmpty) then
      begin
        aMemberID := qryEntrant.FieldByName('MemberID').AsInteger;
        aEventID := qryEntrant.FieldByName('EventID').AsInteger;
        if (aMemberID > 0) and (aEventID > 0) then
          result := true;
      end;
    end;
    qryEntrant.Close;
  end;
end;

procedure TSCMNom.HeatStatusWarning(HeatStatusID: integer);
begin
  if (HeatStatusID = 2) or (HeatStatusID = 3) then
    MessageDlg('The heat in a ''raced'' or ''closed''' + sLineBreak +
      'Changes are not permitted.', mtWarning, [mbOK], 0, mbOK)
  else if (HeatStatusID = 0) then
    MessageDlg('The heat status couldn''t be found!', mtWarning,
      [mbOK], 0, mbOK);
end;

function TSCMNom.IsMemberAssignedHeat(aMemberID, aEventID: integer): boolean;
begin
  result := false;
  if Assigned(FConnection) then
  begin
    if (qryHeat.Active) then
      qryHeat.Close;
    qryHeat.ParamByName('MEMBERID').AsInteger := aMemberID;
    qryHeat.ParamByName('EVENTID').AsInteger := aEventID;
    qryHeat.Prepare;
    qryHeat.Open;
    if (qryHeat.Active) then
    begin
      if not(qryHeat.IsEmpty) then
        result := true;
    end;
    qryHeat.Close;
  end;
end;

function TSCMNom.IsMemberInEvent(aMemberID, aEventID: integer): boolean;
begin
  result := false;
  if (aMemberID > 0) and (aEventID > 0) then
  begin
    if Assigned(FConnection) then
    begin
      if (qryIsMemberInEvent.Active) then
        qryIsMemberInEvent.Close;
      qryIsMemberInEvent.ParamByName('MEMBERID').AsInteger := aMemberID;
      qryIsMemberInEvent.ParamByName('EVENTID').AsInteger := aEventID;
      qryIsMemberInEvent.Prepare;
      qryIsMemberInEvent.Open;
      if (qryIsMemberInEvent.Active) then
      begin
        if not(qryIsMemberInEvent.IsEmpty) then
          result := true;
      end;
      qryIsMemberInEvent.Close;
    end;
  end
end;

function TSCMNom.IsMemberNominated(aMemberID, aEventID: integer): boolean;
begin
  // ------------------------------------------------------------------------
  // I S   M E M B E R   N O M I N A T E D
  // ------------------------------------------------------------------------
  result := true;
  if (aMemberID > 0) and (aEventID > 0) then
  begin
    if Assigned(FConnection) then
    begin
      if (qryIsMemberNominated.Active) then
        qryIsMemberNominated.Close;
      qryIsMemberNominated.ParamByName('MEMBERID').AsInteger := aMemberID;
      qryIsMemberNominated.ParamByName('EVENTID').AsInteger := aEventID;
      qryIsMemberNominated.Prepare;
      qryIsMemberNominated.Open;
      if (qryIsMemberNominated.Active) then
      begin
        if (qryIsMemberNominated.IsEmpty) then
          result := false;
      end;
      qryIsMemberNominated.Close;
    end;
  end;
end;

function TSCMNom.NominateMember(aMemberID, aEventID: integer): boolean;
begin
  // -------------------------------------------------------------------------
  // N O M I N A T E   M E M B E R .
  // -------------------------------------------------------------------------
  result := false;
  if (aMemberID > 0) and (aEventID > 0) then
  begin
    // If the member isn't nominated for this event ....
    if not IsMemberNominated(aMemberID, aEventID) then
    begin
      if Assigned(FConnection) then
      begin
        cmdNominateMember.Close;
        cmdNominateMember.ParamByName('EVENTID').AsInteger := aEventID;
        cmdNominateMember.ParamByName('MEMBERID').AsInteger := aMemberID;
        cmdNominateMember.Prepare;
        cmdNominateMember.Execute;
        result := true;
      end;
    end
    else
      result := true;
  end;
end;

procedure TSCMNom.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(iniFileName);
  prefCheckUnNomination := iFile.ReadInteger('Preferences', 'CheckUnNomination',
    integer(cbUnchecked));
  iFile.free;
end;

procedure TSCMNom.StrikeExecute(aEntrantID: integer; aDataset: TDataSet);
var
  SearchOptions: TLocateOptions;
  results, aMemberID, aEventID: integer;
begin
  if Assigned(FConnection) then
  begin
    if (aEntrantID > 0) then
    begin
      if GetMemberAndEvent(aEntrantID, aMemberID, aEventID) then
      begin
        results := MessageDlg('Strike the entrant from the lane and remove' +
          sLineBreak + 'the member''s nomination from the "Entrant Pool"?',
          mtConfirmation, [mbNo, mbYes], 0, mbYes);
        if (results = mrYes) then
        begin
          aDataset.DisableControls();
          if (StrikeLane(aEntrantID)) then
          begin
            // requires a refresh of the entrant table
            aDataset.Refresh();
            // cue-to ID
            SearchOptions := [];
            // compact version - Variant v[1] array not needed
            aDataset.Locate('EntrantID', aEntrantID, SearchOptions);
          end;
          aDataset.EnableControls();
        end;
      end
      // possibly no member to strike, so just clean the lane.
      // (ie. assert it's condition) If heat is open ...
      else
        EmptyLane(aEntrantID);
    end;
  end;
end;

function TSCMNom.StrikeLane(aMemberID, aEventID: integer): boolean;
var
  aEntrantID, HeatStatusID: integer;
begin
  // -------------------------------------------------------------------------
  // S T R I K E   L A N E .  M E M B E R ,   E V E N T .
  // -------------------------------------------------------------------------
  // strike lane will remove the nominee data and clear the lane
  result := false;
  if (aMemberID > 0) and (aEventID > 0) then
  begin
    HeatStatusID := GetHeatStatusID(aMemberID, aEventID);
    if (HeatStatusID = 1) then
    begin
      DeleteNomination(aMemberID, aEventID); // remove nomination ...
      aEntrantID := GetEntrantID(aMemberID, aEventID);
      if (aEntrantID > 0) then
      begin
        CleanLane(aEntrantID); // Update Entrant Data
        result := true;
      end;
    end
    else
      HeatStatusWarning(HeatStatusID);
  end;
end;

function TSCMNom.StrikeLane(aEntrantID: integer): boolean;
var
  aMemberID, aEventID, HeatStatusID: integer;
begin
  // -------------------------------------------------------------------------
  // S T R I K E   L A N E .  E N T R A N T .
  // -------------------------------------------------------------------------
  // strike lane will remove the nominee data and clear the lane
  result := false;
  if (aEntrantID > 0) then
  begin
    HeatStatusID := GetHeatStatusID(aEntrantID);
    if (HeatStatusID = 1) then
    begin
      if (GetMemberAndEvent(aEntrantID, aMemberID, aEventID)) then
        DeleteNomination(aMemberID, aEventID); // remove nomination ...
      CleanLane(aEntrantID); // Update Entrant Data
      result := true;
    end
    else
      HeatStatusWarning(HeatStatusID);
  end;
end;

function TSCMNom.UnNominateMember(aMemberID, aEventID: integer): boolean;
var
  DoEmptyLane: boolean;
  response, aEntrantID: integer;
begin

  DoEmptyLane := false; // empty out lane.
  result := false;

  // Bad ID - exit procedure.
  if (aMemberID = 0) or (aEventID = 0) then
    exit;
  // The member isn't nominated for this event - exit procedure;
  if not IsMemberNominated(aMemberID, aEventID) then
    exit;

  // Has the nominated member been given a lane?
  if IsMemberAssignedHeat(aMemberID, aEventID) then
  begin
    // The heat is locked - exit procedure
    if (GetHeatStatusID(aMemberID, aEventID) <> 1) then
    begin
      MessageDlg('The member is nominated and has been given a lane.' +
        sLineBreak + 'The assigned heat has been set to raced or closed.' +
        sLineBreak + 'The member can''t be un-nominated.',
        TMsgDlgType.mtInformation, [mbOK], 0);
      exit;
    end;
    // preference setting - the user the option to abort procedure
    if (prefCheckUnNomination = integer(cbChecked)) then
    begin
      response := MessageDlg
        ('The member is nominated and has been given a lane.' + sLineBreak +
        'Remove the nomination AND empty the lane?',
        mtWarning, [mbYes, mbNo], 0, mbNo);
      if (response = mrNo) then
        exit;
    end;
    // ---------------------------------------------------------------------
    // S E T   T A S K   :  remove member from lane
    // ---------------------------------------------------------------------
    DoEmptyLane := true;
  end;
  // p e r f o r m   t a s k   - remove nomination.
  DeleteNomination(aMemberID, aEventID);

  // p e r f o r m   t a s k   - remove entrant.
  if (DoEmptyLane) then
  begin
    aEntrantID := GetEntrantID(aMemberID, aEventID);
    if (aEntrantID > 0) then
      begin
      // NOTE : not using EmptyLane as heat status has been checked.
      CleanLane(aEntrantID);
      // Entrant gird on main form will need refresh.
      if Owner is TForm then
        PostMessage(TForm(Owner).Handle, SCM_LANEWASCLEANED, 0, 0);
      end;
  end;

  result := true;
end;

end.
