unit uTeam;

interface
uses
  System.SysUtils, System.Classes, System.DateUtils,
  System.Variants, System.VarUtils,
  System.StrUtils,
  vcl.Dialogs, Data.DB,
  dmCORE, dmSCM, SCMdefines,
	FireDAC.Comp.Client;

  function ClearTeam(aTeamID: Integer; DoExclude: Boolean = true): boolean;
  function StrikeTeam(aTeamID: Integer; DoExclude: Boolean = true): boolean;

implementation
uses
 uSwimClub, uSession, uEvent, uHeat, uLane;

function ClearTeam(aTeamID: Integer; DoExclude: Boolean = true): boolean;
var
  SQL: string;
  recCount: integer;
begin
  // prior to calling here dbo.Lane.TeamID must be cleared.
  result := false;
  if not Assigned(SCM) or not SCM.scmConnection.Connected then exit;
  if uSession.IsLocked() then exit;
  if (uHeat.HeatStatusID() = 1) or (DoExclude = false) then
  begin
    CORE.qryTeam.DisableControls;
    try
      SQL := '''
        DELETE FROM SwimClubMeet2.dbo.TeamLink
        WHERE TeamLink.TeamID = :ID;
        ''';
      recCount := SCM.scmConnection.ExecSQL(SQL, [aTeamID]);
      if recCount <> 0 then result := true;
    finally
      CORE.qryTeam.ApplyMaster;
      CORE.qryTeam.EnableControls;
    end;
  end;
end;

function StrikeTeam(aTeamID: Integer; DoExclude: Boolean = true): boolean;
var
  SQL: string;
  recCount, aNomineeID, aEventID: integer;
begin
  // prior to calling here dbo.Lane.TeamID must be cleared.
  result := false;
  aNomineeID := 0;
  if not Assigned(SCM) or not SCM.scmConnection.Connected then exit;
  if uSession.IsLocked() then exit;
  if (uHeat.HeatStatusID() = 1) or (DoExclude = false) then
  begin
    CORE.qryTeam.DisableControls;
    try
      aEventId := uEvent.PK;
      // NOTE: qryTeamLink is not a part of Master-Detail schema.
      CORE.qryTeamLink.Close;
      CORE.qryTeamLink.ParamByName('TEAMID').AsInteger := aTeamID;
      CORE.qryTeamLink.Prepare;
      try
        CORE.qryTeamLink.Open;
        if CORE.qryTeamLink.Active then
        begin
          CORE.qryTeamLink.First;
          while not CORE.qryTeamLink.eof do
          begin
            aNomineeID := CORE.qryTeamLink.FieldByName('NomineeID').AsInteger;
            try // delete the many-to-many link...
              CORE.qryTeamLink.Delete;
            except on E: Exception do
                CORE.qryTeamLink.Next;
            end;
            try // delete the nomination.
              SQL := '''
                    DELETE FROM SwimClubMeet2.dbo.Nominee
                    WHERE NomineeID = :ID1 AND Nominee.EventID = ID2;
                    ''';
              SCM.scmConnection.ExecSQL(SQL, VarArrayOf([aNomineeID,
                  aEventID]));
            except on E: Exception do
                // do FireDAC error message..
            end;
            continue;
          end;
        end;

      except on E: Exception do
      end;
    finally
      CORE.qryTeam.EnableControls;
    end;
  end;
end;





end.
