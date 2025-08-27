unit f_FrameTeam;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFrameTeam2 = class(TFrame)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


(*
procedure TMain.actnAddSlotExecute(Sender: TObject);
begin
  if AssertConnection then TEAM.spbtnAddSlotClick(Sender);
end;

procedure TMain.actnClearSlotExecute(Sender: TObject);
var
  rtnValue, rows: integer;
	aEventType: scmEventType;
begin
	aEventType := uEvent.EventType;
	if aEventType = etUnknown then exit;
  rtnValue := MessageDlg('Clear the team entrant?', mtConfirmation,
    [mbNo, mbYes], 0, mbYes);
  if (rtnValue = mrYes) then
  begin
    rows := TEAM.ClearSlot;
    if rows > 0 then
    begin
      // S T A T U S B A R . Update entrant totals and any other UI elements
      fDoStatusBarUpdate := true; // permits TACTION StatusBarUpdate
      SCM_StatusBar.Execute;
    end;
  end;
end;

procedure TMain.actnClearStrikeSlotUpdate(Sender: TObject);
var
  DoEnable: boolean;
  aEventType: scmEventType;
begin
  DoEnable := false;
  if AssertConnection then
		if not uSession.IsEmptyOrLocked then
      // are there any heats?
			if not CORE.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
				if not uHeat.IsClosed then
        begin
          aEventType := uEvent.EventType;
          if aEventType = etTEAM then
          begin
						if not CORE.dsLane.DataSet.IsEmpty then
            begin
//              if not CORE.dsTeamEntrant.DataSet.IsEmpty then
//                if TEAM.TeamActiveGrid = 2 then
//                   Need a relay in a lane to be able to clear it....
//                  if not CORE.dsTeamEntrant.DataSet.FieldByName('MemberID').IsNull
//                  then DoEnable := true;
						end;
          end;
        end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.actnMoveDownSlotExecute(Sender: TObject);
begin
  TEAM.SlotMovedOWN(Sender);
end;

procedure TMain.actnMoveUpSlotExecute(Sender: TObject);
begin
  TEAM.SlotMoveUp(Sender);
end;

procedure TMain.actnRemoveSlotExecute(Sender: TObject);
begin
  if AssertConnection then TEAM.spbtnRemoveSlotClick(Sender);
end;

procedure TMain.actnStrikeSlotExecute(Sender: TObject);
begin
  if AssertConnection then TEAM.spbtnTeamEntrantStrikeClick(Sender);
end;

procedure TMain.Refresh_TeamEntrant(DoBookmark: boolean);
var
  bm: TBookmark;
begin
  if not AssertConnection then exit;
	bm := nil;
  With CORE.dsTeamLink.DataSet do
	begin
    DisableControls;
    if Active and not IsEmpty then bm := GetBookmark;
    Close;
    Open;
    if Active then
    begin
      try
        if Assigned(bm) then GotoBookmark(bm);
      except
        on E: Exception do
      end;
    end;
    EnableControls;
  end;
end;


*)

end.
