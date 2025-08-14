unit uSwimClub;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, Data.DB,
  vcl.Dialogs,
  dmCORE, dmSCM;

function Assert(): boolean;
function ClubName(): string;
function GetSwimClubID: integer; // Assert made here.
function IsShortCourse(): Boolean;
function Locate(SwimClubID: integer): boolean;
function PK(): integer; // RTNS: Primary key.
function NickName: string;
function NumberOfLanes(): integer;
function SessionCount(SDate, EDate: TDateTime): integer;
function StartOfSwimSeason(): TDateTime; overload;

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
  if not SCM.IsActive then
    raise Exception.Create('Data module SCM tables are offline.');
  if not Assigned(CORE) then
    raise Exception.Create('Core data module not assigned.');
  if not CORE.IsActive then
    raise Exception.Create('Core data module tables are offline.');

end;

destructor T_SwimClub.Destroy;
begin
  // do cleanup...
  inherited;
end;

function Assert(): boolean;
begin
  result := false;
  if CORE.qrySwimClub.Active then
    if not CORE.qrySwimClub.IsEmpty then
      result := true;
end;

function ClubName: string;
begin
  result := CORE.dsSwimClub.DataSet.FieldByName('Caption').AsString;
end;

function GetSwimClubID: integer;
begin
  result := 0;
  if uSwimClub.Assert then
    result := CORE.dsSwimClub.DataSet.FieldByName('SwimClubID').AsInteger;
end;

function IsShortCourse: Boolean;
var
  i: integer;
begin
  result := true;
  i := CORE.dsSwimClub.DataSet.FieldByName('LenOfPool').AsInteger;
  if (i >= 50) then result := false;
end;

function Locate(SwimClubID: integer): boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  SearchOptions := [];
  result := CORE.qrySwimClub.Locate('SwimClubID', SwimClubID,  SearchOptions);
end;

function PK(): integer;
begin // NO CHECKS. quick and dirty - primary key result.
  result := CORE.qrySwimClub.FieldByName('SwimClubID').AsInteger;
end;

function NickName: string;
begin
  result := CORE.dsSwimClub.DataSet.FieldByName('NickName').AsString;
end;

function NumberOfLanes: integer;
var
  i: integer;
begin // how many lanes in the swim club's pool?
  result := CORE.dsSwimClub.DataSet.FieldByName('NumOfLanes').AsInteger;
end;

function SessionCount(SDate, EDate: TDateTime): integer;
var
  SQL: string;
  v: variant;
begin
  result := 0;
  if Assigned(SCM) and SCM.IsActive then
  begin
    SQL := '''
    SELECT Count(SessionID)
    FROM SwimClubMeet2.dbo.Session
    WHERE Session.SwimClubID = :ID1 AND StartDT >= :ID2 AND EndDT <= :ID3;
    ''';
    v := SCM.scmConnection.ExecSQLScalar(SQL, [uSwimClub.PK, SDate, EDate]);
    if not VarIsClear(v) then result := v;
  end;
end;

function StartOfSwimSeason: TDateTime;
begin
  result := CORE.dsSwimClub.DataSet.FieldByName('StartOfSwimSeason').AsDateTime;
end;

end.

