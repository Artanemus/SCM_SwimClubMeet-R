unit uSwimClub;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  vcl.Dialogs,
  dmSCMcore, dmSCM;

function ClubName(): string; // current club
function GetSwimClubID: integer;
function IsShortCourse(): Boolean; // current club
procedure Locate(SwimClubID: integer);
function PK(): integer; // NO CHECKS. RTNS: Primary key.
function NickName: string; // current club
function NumberOfLanes(): integer; // current club
function SessionCount(SwimClubID: integer; SDate, EDate: TDateTime): integer;
function StartOfSwimSeason(): TDateTime; overload;
function StartOfSwimSeason(SwimClubID: integer): TDateTime; overload;

type

  T_SwimClub = class
  public
    constructor Create;
    destructor Destroy;
  end;

var
  scmSwimClub: T_SwimClub;

implementation

uses
	uSession, uEvent, uHeat, uLane;


constructor T_SwimClub.Create;
begin
  inherited;

  if not Assigned(SCM) then
    raise Exception.Create('Data module SCM not assigned.');
  if not SCM.SCMActive then
    raise Exception.Create('Data module SCM tables are offline.');
  if not Assigned(SCMCore) then
    raise Exception.Create('Core data module not assigned.');
  if not SCMCore.CoreActive then
    raise Exception.Create('Core data module tables are offline.');

end;

destructor T_SwimClub.Destroy;
begin
  // do cleanup...
  inherited;
end;

function ClubName: string;
begin
  result := '';
  if SCMcore.dsSwimClub.DataSet.Active then
    if not SCMCore.dsSwimClub.DataSet.IsEmpty then
      result := SCMCore.dsSwimClub.DataSet.FieldByName('Caption').AsString;
end;

function GetSwimClubID: integer;
begin
  result := 0;
  if SCM.SCMActive and SCMcore.dsSwimClub.DataSet.Active then
    if not SCMcore.dsSwimClub.DataSet.IsEmpty then
      result := SCMcore.dsSwimClub.DataSet.FieldByName('SwimClubID').AsInteger;
end;

function IsShortCourse: Boolean;
var
  i: integer;
begin
  result := true;
  if SCMcore.dsSwimClub.DataSet.Active then
  begin
    if not SCMcore.dsSwimClub.DataSet.IsEmpty then
    begin
      i := SCMcore.dsSwimClub.DataSet.FieldByName('LenOfPool').AsInteger;
      if (i >= 50) then result := false;
    end;
  end;
end;

procedure Locate(SwimClubID: integer);
begin
  if not SCM.SCMActive then exit;
  SCMcore.qrySwimClub.DisableControls;
  SCMcore.qrySwimClub.Close;
  if SwimClubID <> 0 then
  begin
    SCMcore.qrySwimClub.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
    SCMcore.qrySwimClub.Prepare;
    SCMcore.qrySwimClub.Open;
  end;
  SCMcore.qrySwimClub.EnableControls;
end;

function PK(): integer;
begin // NO CHECKS. quick and dirty - primary key result.
  result := SCMcore.qrySwimClub.FieldByName('SwimClubID').AsInteger;
end;

function NickName: string;
begin
  result := '';
  if SCMcore.dsSwimClub.DataSet.Active then
    if not SCMcore.dsSwimClub.DataSet.IsEmpty then
      result := SCMcore.dsSwimClub.DataSet.FieldByName('NickName').AsString;
end;

function NumberOfLanes: integer;
var
  i: integer;
begin
  // how many lanes in the swim club's pool?
  result := 0;
  if (SCM.SCMActive) then
  begin
    i := SCMcore.dsSwimClub.DataSet.FieldByName('NumOfLanes').AsInteger;
    if (i = 0) or (i > 99) then
    begin
      MessageDlg('Unkown number of swimming lanes. (Expected 1..99).' +
        slinebreak + 'Check your ''Preferences'' setup.', TMsgDlgType.mtError,
        [mbOK], 0);
    end
    else
      result := i;
  end;
end;

function SessionCount(SwimClubID: integer;
  SDate, EDate: TDateTime): integer;
begin
  result := 0;
  // if qryGetSessionCount.Active then
  // qryGetSessionCount.Close;
  // qryGetSessionCount.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
  // qryGetSessionCount.ParamByName('SDATE').AsDateTime := SDate;
  // qryGetSessionCount.ParamByName('EDATE').AsDateTime := EDate;
  // qryGetSessionCount.Prepare;
  // qryGetSessionCount.Open;
  // if qryGetSessionCount.Active then
  // begin
  // if not qryGetSessionCount.IsEmpty then
  // begin
  // result := qryGetSessionCount.FieldByName('SessionCount').AsInteger;
  // end;
  // end;
end;

function StartOfSwimSeason: TDateTime;
begin
  result := 0;
  if SCM.SCMActive and SCMcore.dsSwimClub.DataSet.Active then
    if not SCMcore.dsSwimClub.DataSet.IsEmpty then
      result := SCMcore.dsSwimClub.DataSet.FieldByName('StartOfSwimSeason')
      .AsDateTime;
end;

function StartOfSwimSeason(SwimClubID: integer): TDateTime;
var
  dt: TDateTime;
begin
  result := Date();
  if SwimClubID > 0 then
  begin
    if SCMcore.qrySwimClub.Active then SCMcore.qrySwimClub.Close;
    SCMcore.qrySwimClub.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
    SCMcore.qrySwimClub.Prepare;
    SCMcore.qrySwimClub.Open;
    if SCMcore.qrySwimClub.Active then
    begin
      if not SCMcore.qrySwimClub.IsEmpty then
      begin
        dt := SCMcore.qrySwimClub.FieldByName('StartOfSwimSeason').AsDateTime;
        // If ANow and AThen are two and a half years apart,
        // calling WithinPastYears with AYears set to 2 returns True.
        if WithinPastYears(result, dt, 1) then result := dt;
      end;
    end;
  end;
end;

end.

