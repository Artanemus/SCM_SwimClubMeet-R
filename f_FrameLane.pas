unit f_FrameLane;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Vcl.ExtCtrls, Vcl.WinXPanels,

  uDefines,
  dmSCM,dmCORE, dmIMG,
  uSwimClub, uSession, uEvent, uHeat, uLane,
  Vcl.Menus, Vcl.Buttons, System.Actions, Vcl.ActnList


  ;

type
  TFrameLane = class(TFrame)
    gLane: TDBAdvGrid;
    pnlgLane: TPanel;
    pnlStack: TStackPanel;
    spbtnLaneDown: TSpeedButton;
    spbtnLaneUp: TSpeedButton;
    spbtnLaneDelete: TSpeedButton;
    spbtnLaneReport: TSpeedButton;
    spbtnLaneDeleteForever: TSpeedButton;
    spbtnLaneEdit: TSpeedButton;
    spbtnLanePlus: TSpeedButton;
    spbtnLaneMinus: TSpeedButton;
    ShapeLaneBar1: TShape;
    actnlistLane: TActionList;
    pumenuLane: TPopupMenu;
    actnLane_MoveUp: TAction;
    actnLane_Movedown: TAction;
    actnLane_Edit: TAction;
    actnLane_Plus: TAction;
    actnLane_Minus: TAction;
    actnLane_Delete: TAction;
    actnLane_DeleteForever: TAction;
    actnLane_Report: TAction;
    actnLane_Empty: TAction;
    actnLane_Strike: TAction;
    actnLane_Swap: TAction;
    spbtnLane_Swap: TSpeedButton;
    actnLane_MemberGoto: TAction;
    procedure actnLane_MemberGotoExecute(Sender: TObject);
    procedure actnLane_MemberGotoUpdate(Sender: TObject);
    procedure actnLane_DefaultUpdate(Sender: TObject);
    procedure gLaneDblClick(Sender: TObject);
  private
    function AssertCORE: boolean;
  public
    { Public declarations }
  end;

implementation

uses
  frmManageMember;

{$R *.dfm}

procedure TFrameLane.actnLane_MemberGotoExecute(Sender: TObject);
var
  dlg: TManageMember;
	NomineeID: integer;
	v: variant;
	aSQL: string;
begin
	// REDUNDANT - tested by Nominate_GotoMemberDetailsUpdate.
	//  if not AssertConnection then exit;
	NomineeID := CORE.dsLane.DataSet.FieldByName('NomineeID').AsInteger;
	aSQL := '''
		SELECT MemberID FROM SwimClubMeet2.dbo.MemberLink
		WHERE NomineeID = :ID
		''';
	v := SCM.scmConnection.ExecSQLScalar(aSQL, [NomineeID]);
	if not VarIsClear(v)  then // NULL or EMPTY.
	begin
			try
				dlg := TManageMember.Create(self);
				dlg.Prepare(SCM.scmConnection, 1, v);
				dlg.ShowModal;
			finally
				dlg.Free;
			end;
	end;
end;

procedure TFrameLane.actnLane_MemberGotoUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
	if AssertCORE then // connected to database - tables are active.
		if (uEvent.EventType() = etINDV) then // individual event.
			if not CORE.dsLane.DataSet.IsEmpty then // we have lanes.
				if not CORE.dsLane.DataSet.FieldByName('NomineeID').IsNull then // empty lane
					DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TFrameLane.actnLane_DefaultUpdate(Sender: TObject);
var
  DoEnable: boolean;
  aEventType: scmEventType;
begin
  DoEnable := false;
  if AssertCORE then
    // Checks if session is Empty. Then checks if locked..
		if not uSession.IsEmptyOrLocked then
      // are there any heats?
			if not CORE.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
				if not uHeat.IsClosed then
        begin
						if not CORE.dsLane.DataSet.IsEmpty then
							DoEnable := true;
        end;
  TAction(Sender).Enabled := DoEnable;
end;

function TFrameLane.AssertCORE: boolean;
begin
  result := false;
  if Assigned(CORE) and CORE.IsActive then
    result := true;
end;

procedure TFrameLane.gLaneDblClick(Sender: TObject);
begin
  actnListLane.UpdateAction(actnLane_MemberGoto); // Assert state.
  if actnLane_MemberGoto.Enabled then
    actnListLane.ExecuteAction(actnLane_MemberGoto);
end;

(*

procedure TMain.Grid_EmptyLaneExecute(Sender: TObject);
var
  rtnValue, rows: integer;
  aEventType: scmEventType;
  Msg: string;
begin
  aEventType := uEvent.EventType;
  if aEventType = etUnknown then exit;
  if aEventType = etINDV then Msg := 'Empty the lane.?'
  else Msg := 'Clear the team and it''s swimmers.';

  rtnValue := MessageDlg(Msg, mtConfirmation, [mbNo, mbYes], 0, mbYes);

  if (rtnValue = mrYes) then
  begin
    if aEventType = etINDV then rows := INDV.ClearLane
    else rows := TEAM.ClearLane;
    if rows > 0 then
    begin
      // Requery CORE.qryEvent to update entrant count.
//      PostMessage(Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
      // Set flag for statusbar update.
//      PostMessage(Handle, SCM_UPDATESTATUSBAR, 0, 0);
    end;
  end;
end;

procedure TMain.Grid_EmptyLaneUpdate(Sender: TObject);
var
  DoEnable: boolean;
  aEventType: scmEventType;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      // are there any heats?
      if not CORE.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not uHeat.IsClosed then
				begin
					// BSA V2: do we have lanes?
					if not CORE.dslane.DataSet.IsEmpty then DoEnable := true;
				end;
	TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Grid_MoveDownExecute(Sender: TObject);
var
	aEventType: scmEventType;
begin
	aEventType := uEvent.EventType;
	if aEventType = etINDV then INDV.GridMoveDown(Sender)
	else if aEventType = etTEAM then TEAM.GridMoveDown(Sender);
end;

procedure TMain.Grid_MoveDownUpdate(Sender: TObject);
var
	DoEnable: boolean;
	aEventType: scmEventType;
begin
	DoEnable := false;
	if AssertConnection then
		// Checks if session is Empty. Then checks if locked..
		if not uSession.IsLocked then
			// Are there any heats?
			if not CORE.dsHeat.DataSet.IsEmpty then
				// Is the current heat closed?
				if not uHeat.IsClosed then
				begin
					// BSA V2: do we have lanes?
					if not CORE.dslane.DataSet.IsEmpty then DoEnable := true;
				end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Grid_MoveUpExecute(Sender: TObject);
var
  aEventType: scmEventType;
begin
  aEventType := uEvent.EventType;
  if aEventType = etINDV then INDV.GridMoveUp(Sender)
  else if aEventType = etTEAM then TEAM.GridMoveUp(Sender);
end;

procedure TMain.Grid_MoveUpUpdate(Sender: TObject);
var
  DoEnable: boolean;
  aEventType: scmEventType;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      // are there any heats?
      if not CORE.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not uHeat.IsClosed then
        begin
					// BSA V2: do we have lanes?
					if not CORE.dslane.DataSet.IsEmpty then DoEnable := true;
				end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Grid_RenumberExecute(Sender: TObject);
var
  aHeatID, rows: integer;
begin
  aHeatID := CORE.dsHeat.DataSet.FieldByName('Heat').AsInteger;
  rows := uHeat.RenumberLanes(true);
  if rows > 0 then Refresh; { TODO -oBSA -cGeneral : TEST }
end;

procedure TMain.Grid_RenumberUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      // are there any heats?
      if not CORE.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not uHeat.IsClosed then
          // BSA V2: are there lanes?
					if not CORE.dsLane.DataSet.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Grid_StrikeExecute(Sender: TObject);
var
  rtnValue, rows: integer;
  aEventType: scmEventType;
  Msg: string;
begin
  aEventType := uEvent.EventType;
  if aEventType = etUnknown then exit;
  rows := 0;
  if aEventType = etINDV then Msg := 'Remove nomination and empty the lane.?'
  else Msg := 'Remove nominations and clear the team and it''s swimmers.?';
  rtnValue := MessageDlg(Msg, mtConfirmation, [mbNo, mbYes], 0, mbYes);
  if (rtnValue = mrYes) then
  begin
    if aEventType = etINDV then rows := INDV.StrikeLane
    else if aEventType = etTEAM then rows := TEAM.StrikeLane;
    if rows > 0 then
    begin
      // Requery CORE.qryEvent to update entrant count.
//      PostMessage(Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
      // Set flag for statusbar update.
//      PostMessage(Handle, SCM_UPDATESTATUSBAR, 0, 0);
    end;
  end;
end;

procedure TMain.Grid_StrikeUpdate(Sender: TObject);
var
  DoEnable: boolean;
  aEventType: scmEventType;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      // are there any heats?
      if not CORE.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not uHeat.IsClosed then
				begin
					// BSA V2: are there lanes?
					if not CORE.dsLane.DataSet.IsEmpty then DoEnable := true;
				end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Grid_SwapLanesExecute(Sender: TObject);
var
  dlg: TSwapLanes;
  aEventType: scmEventType;
begin
  aEventType := uEvent.EventType;
  if aEventType = etINDV then
  begin
    dlg := TSwapLanes.Create(self);
    if IsPositiveResult(dlg.ShowModal) then Refresh_IndvTeam;
    dlg.Free;
  end
  else if aEventType = etTEAM then
  begin
    { TODO -oBSA -cGeneral : Dialogue - Swap relay teams in lanes }
    { dlg := TSwapLanesTEAM.Create(self);
      if IsPositiveResult(dlg.ShowModal) then
      Refresh_Entrant;
      dlg.Free; }
  end;

  if INDV.Grid.CanFocus then INDV.Grid.SetFocus
  else TEAM.Grid.SetFocus;
end;

procedure TMain.Grid_SwapLanesUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      // are there any heats?
      if not CORE.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not uHeat.IsClosed then
					// BSA V2: do we have lanes?
					if not CORE.dslane.DataSet.IsEmpty then DoEnable := true;
	TAction(Sender).Enabled := DoEnable;
end;


*)


(*
  procedure TMain.INDV_Scroll(var Msg: TMessage);
  var
    fld: TField;
    aEventType: scmEventType;
  begin
    // messaged by TCORE.qryMemberQuickPickAfterScroll
    // messaged by TCORE.qryHeatAfterScroll
    if not AssertConnection then exit;
    aEventType := uEvent.EventType;
    if (aEventType = etINDV) and TEAM.Grid.Focused then
    begin
      // After moving row re-engage editing for selected fields.
      fld := INDV.Grid.SelectedField;
      if Assigned(fld) then
      begin
        if (fld.FieldName = 'RaceTime') or (fld.FieldName = 'DCode') or
          (fld.FieldName = 'FullName') then INDV.Grid.EditorMode := true
        else INDV.Grid.EditorMode := false;
      end;
    end;
  end;


procedure TMain.Refresh_IndvTeam(DoBookmark: boolean = true;
  DoRenumber: boolean = false);
var
  bm: TBookmark;
  aHeatID, aLaneID: integer;
  aEventType: scmEventType;
begin
  if not AssertConnection then exit;
	bm := nil;
	// BSA V2: major modification done here
	With CORE.dsLane.DataSet do
  begin
    DisableControls;
    if Active and not IsEmpty then bm := GetBookmark;
		CORE.qryLane.ApplyMaster;
		try
			if Assigned(bm) then GotoBookmark(bm);
		except
			on E: Exception do
		end;
		if DoRenumber then
		begin
			uHeat.RenumberLanes(false);
			aHeatID := uHeat.PK; // curr heat
			aEventType := uEvent.EventType;

			aLaneID := uLane.PK; // returns either NomineeID or TeamID.
      uLane.Locate(aLaneID);
    end;
    EnableControls;
  end;
end;



*)


end.
