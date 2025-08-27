unit f_FrameHeat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Data.DB,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.WinXCtrls, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.WinXPanels,
  uDefines,
  dmSCM,dmCORE, dmIMG,
  uSwimClub, uSession, uEvent, uHeat, uLane,
  Vcl.Menus
  ;

type
  TFrameHeat = class(TFrame)
    gHeat: TDBAdvGrid;
    ShapeHeatBar1: TShape;
    ShapeHeatBar2: TShape;
    ShapeHeatBar3: TShape;
    spbtnHeatAutoBuild: TSpeedButton;
    spbtnHeatBatchPrintSet: TSpeedButton;
    spbtnHeatDelete: TSpeedButton;
    spbtnHeatDown: TSpeedButton;
    spbtnHeatMarshall: TSpeedButton;
    spbtnHeatNew: TSpeedButton;
    spbtnHeatReport: TSpeedButton;
    spbtnHeatTimeKeeper: TSpeedButton;
    spbtnHeatToggleStatus: TSpeedButton;
    spbtnHeatUp: TSpeedButton;
    actnlistHeat: TActionList;
    actnHeat_MoveUp: TAction;
    actnHeat_MoveDown: TAction;
    actnHeat_ToogleStatus: TAction;
    actnHeat_New: TAction;
    actnHeat_Delete: TAction;
    actnHeat_Build: TAction;
    actnHeat_MarshalSheet: TAction;
    actnHeat_TimeSheet: TAction;
    actnHeat_PrintSet: TAction;
    actnHeat_Report: TAction;
    pnlStack: TStackPanel;
    pnlgHeat: TPanel;
    pumenuHeat: TPopupMenu;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    oogleHeatStatus1: TMenuItem;
    NewHeat1: TMenuItem;
    DeleteHeat1: TMenuItem;
    AutobuildHeats1: TMenuItem;
    imekeeperSheet1: TMenuItem;
    MarshalSheet1: TMenuItem;
    PrintSet1: TMenuItem;
    HeatReport1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    actnHeat_RenumberLanes: TAction;
    procedure actnHeat_BuildExecute(Sender: TObject);
    procedure actnHeat_MoveUpDownExecute(Sender: TObject);
    procedure actnHeat_DefaultUpdate(Sender: TObject);
    procedure actnHeat_DeleteExecute(Sender: TObject);
    procedure actnHeat_MarshalSheetExecute(Sender: TObject);
    procedure actnHeat_ReportUpdate(Sender: TObject);
    procedure actnHeat_NewExecute(Sender: TObject);
    procedure actnHeat_PrintSetExecute(Sender: TObject);
    procedure actnHeat_ReportExecute(Sender: TObject);
    procedure actnHeat_TimeSheetExecute(Sender: TObject);
    procedure actnHeat_ToogleStatusExecute(Sender: TObject);
    procedure gHeatGetDisplText(Sender: TObject; ACol, ARow: Integer; var Value:
        string);
  private
    { Private declarations }
    function AssertSCM(): boolean;
    function AssertCORE(): boolean;
  protected
      procedure msgScrollHeat(var Msg: TMessage); message SCM_SCROLL_HEAT;

  public
    { Public declarations }
  end;

implementation
uses
  SCMUtility, dmAutoBuildV2, dlgAutoBuild_Heats, dlgCheckMemberRequisites,
  rptMarshallReportC, rptMarshallReportB, rptMarshallReportA,
  rptTimeKeeperReportB, rptTimeKeeperReportA, rptHeatReportB, rptHeatReportA;

{$R *.dfm}

procedure TFrameHeat.actnHeat_BuildExecute(Sender: TObject);
var
  AutoBuild: TAutoBuildV2;
	dlg: TAutoBuild_Heats;
	dlg2: TCheckMemberRequisites;
	success, IsErronous: boolean;
	EventID, rtnValue: integer;
	s: string;
begin
  success := false;
  // A U T O - B U I L D   R E L A Y   TE A M .
  if uEvent.EventType = etTEAM then
  begin
//    Heat_AutoBuildRelayExecute(Sender);
    exit;
  end;

  // actn..Update determines if this routine is accessable.
  EventID := CORE.dsEvent.DataSet.FieldByName('EventID').AsInteger;

  // 'Quick' check if we have nominees to auto-create heats.
  // This routine is simplified (for expediance), it looks at all
  // nominees placed and un-placed ... ignoring open,raced,closed heat
  // status.
  if not uEvent.HasNominees() then
	begin
		s := '''
			No one has been nominated for this event.
			Auto-Build Heats was aborted.
			''';
		MessageDlg(s, mtError, [mbOK], 0, mbOK);
    exit;
  end;

  // -------------------------------------------------------
  // For BATCH BUILDING the DLG is hidden after first use.
  // -------------------------------------------------------
  dlg := TAutoBuild_Heats.Create(self);
  rtnValue := dlg.ShowModal;
  // closing the form here ensures prefHeatAlgorithm,
  // prefUseDefRaceTime, prefSeedMode and prefRaceTimeTopPercent have been
  // written out to the preference ini file.
  dlg.Free;
  if not IsPositiveResult(rtnValue) then exit;
  // -------------------------------------------------------
	// Check for bad DOB and GENDER.
	dlg2 := TCheckMemberRequisites.Create(Self);
	IsErronous := dlg2.CheckExec(SCM.scmConnection, EventID);
	if IsErronous then dlg.ShowModal;
	dlg2.Free;

	if not IsErronous then
	begin
    CORE.qryNominee.DisableControls;
    CORE.qryLane.DisableControls;
    CORE.qryHeat.DisableControls;
    CORE.qryWatchTime.DisableControls;
    CORE.qrySplitTime.DisableControls;
    CORE.qryTeam.DisableControls;
    try
      AutoBuild := TAutoBuildV2.Create(self);
      success := AutoBuild.AutoBuildExecute();
      AutoBuild.Free;
    finally
			CORE.qryHeat.ApplyMaster;
			CORE.qryLane.ApplyMaster;
			CORE.qryWatchTime.ApplyMaster;
			CORE.qrySplitTime.ApplyMaster;
			CORE.qryTeam.ApplyMaster;

      CORE.qryHeat.EnableControls;
      CORE.qryLane.EnableControls;
      CORE.qryWatchTime.EnableControls;
      CORE.qrySplitTime.EnableControls;
      CORE.qryTeam.EnableControls;
      if (success) then
      begin
//        PostMessage(Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
//        PostMessage(Handle, SCM_UPDATESTATUSBAR, 0, 0);
      end;
    end;
end;



//  if HeatControlList.CanFocus then HeatControlList.SetFocus;
end;

procedure TFrameHeat.actnHeat_MoveUpDownExecute(Sender: TObject);
var
  aHeatID, recA, recB: integer;
  fld: TField;
  recPos: TRecordPos;
begin
  if not AssertCORE then exit;
  recPos := SCMUtility.GetRecordPosition(CORE.qryHeat);
  if recPos = rpMiddle then
  begin
    gHeat.BeginUpdate;
    CORE.qryHeat.DisableControls();
    CORE.qryHeat.CheckBrowseMode;
    fld := CORE.qryHeat.FindField('HeatNum');
    if Assigned(fld) and fld.ReadOnly then fld.ReadOnly := false;
    try
      aHeatID := uHeat.PK;
      recA := CORE.qryHeat.FieldByName('HeatNum').AsInteger;
      recB := 0;
      try
        if TAction.UnitName.Contains('Down') then
          CORE.qryHeat.Next()
        else if TAction.UnitName.Contains('Up')  then
          CORE.qryHeat.Prior()
        else exit;

        recB := CORE.qryHeat.FieldByName('HeatNum').AsInteger;
        CORE.qryHeat.Edit();
        CORE.qryHeat.FieldByName('HeatNum').AsInteger := recA;
        CORE.qryHeat.Post();
        recA := 0;
        if uHeat.Locate(aHeatID) then
        begin
          CORE.qryHeat.Edit();
          CORE.qryHeat.FieldByName('HeatNum').AsInteger := recB;
          CORE.qryHeat.Post();
        end;
      except on E: Exception do
        begin
          CORE.qryHeat.Cancel;
          { if recA = 0 then  uHeat.RenumberLanes(true); }
          exit;
        end;
      end;
    finally
      if Assigned(fld) then fld.ReadOnly := true;
      CORE.qryHeat.EnableControls();
      gHeat.EndUpdate;
    end;
  end;
end;

procedure TFrameHeat.actnHeat_DefaultUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertCORE then
    if not uSession.IsEmptyOrLocked then
      if not CORE.qryHeat.IsEmpty then
        // The event must have Distance and stroke Assigned!!!
        if not CORE.dsEvent.DataSet.FieldByName('DistanceID').IsNull and
          not CORE.dsEvent.DataSet.FieldByName('StrokeID').IsNull then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
  if gHeat.Enabled <> DoEnable then gHeat.Enabled := DoEnable;
end;

procedure TFrameHeat.actnHeat_DeleteExecute(Sender: TObject);
var
  mr: TModalResult;
  aHeatID: integer;
  aEventType: scmEventType;
  success: Boolean;
begin
  // actn.Update dictates if this routine is accessable.
  aEventType := uEvent.EventType;
  mr := mrNone;

  // The heat is CLOSED.
  if uHeat.IsClosed then
  begin
    MessageDlg('This heat is CLOSE' + sLineBreak +
      'The heat can''t be deleted.', mtInformation, [mbOK], 0, mbOK);
    exit;
  end;
  // The heat is RACED
  if uHeat.IsRaced then
  begin
    mr := MessageDlg('WARNING: This heat is RACED.' + sLineBreak +
      'Racetimes and entrant data will be lost if you delete this heat.' +
      sLineBreak + 'Do you wish to delete the heat?', mtWarning,
      [mbYes, mbNo], 0, mbNo);
    if (mr <> mrYes) then exit;
  end;

  // Heat status is RACED or OPEN. Final confirmation message.
  if uHeat.IsRaced then
  begin
    if aEventType = etINDV then
        mr := MessageDlg('Final confirmation:' + sLineBreak +
        'Delete the RACED heat, all of it''s racetimes and entrant data?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes)
    else if aEventType = etTEAM then
        mr := MessageDlg('Final confirmation:' + sLineBreak +
        'Delete the RACED heat, all of it''s racetimes and relay team data?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes);
  end
  else
  begin
    if aEventType = etINDV then
        mr := MessageDlg
        ('Delete the selected heat and all it''s assigned entrants?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes)
    else if aEventType = etTEAM then
        mr := MessageDlg
        ('Delete the selected heat and all it''s assigned relay teams?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes);
  end;

  // d e l e t e   t h e   c u r r e n t   s e l e c t e d   h e a t .
  // -----------------------------------------------------------------
  if (mr = mrYes) then
  begin
    aHeatID := CORE.dsHeat.DataSet.FieldByName('HeatID').AsInteger;
    success := uHeat.DeleteHeat(false);
    if success then
    begin
      // Requery CORE.qryEvent to update entrant count.
//      PostMessage(Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
      // Set flag for statusbar update.
//      PostMessage(Handle, SCM_UPDATESTATUSBAR, 0, 0);
      // Displays info messages on sidebar and asserts TFrame visibility states.
//      PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 3, 0);
    end;
  end;

end;

procedure TFrameHeat.actnHeat_MarshalSheetExecute(Sender: TObject);
var
  rptA: TMarshallReportA;
  rptB: TMarshallReportB;
  rptC: TMarshallReportC;
  EventID: integer;
begin
  EventID := CORE.dsEvent.DataSet.FieldByName('EventID').AsInteger;
  try
    if ((GetKeyState(VK_CONTROL) and 128) = 128) and
      ((GetKeyState(VK_SHIFT) and 128) = 128) then
    begin
      rptC := TMarshallReportC.Create(self);
      rptC.Prepare(SCM.scmConnection, EventID);
      rptC.RunReport;
      rptC.Free;
    end

    else if ((GetKeyState(VK_CONTROL) and 128) = 128) then
    begin
      rptB := TMarshallReportB.Create(self);
      rptB.Prepare(SCM.scmConnection, EventID);
      rptB.RunReport;
      rptB.Free;
    end
    else
    begin
      rptA := TMarshallReportA.Create(self);
      rptA.Prepare(SCM.scmConnection, EventID);
      rptA.RunReport;
      rptA.Free;
    end;
  except
    on E: Exception do ShowMessage('Error opening report.');
  end;
end;

procedure TFrameHeat.actnHeat_ReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertCORE then // Note: Locked sessions can be printed.
    if not CORE.dsHeat.DataSet.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TFrameHeat.actnHeat_NewExecute(Sender: TObject);
begin
  gHeat.BeginUpdate;
  CORE.qryHeat.DisableControls();
  CORE.qryHeat.CheckBrowseMode;
  try
    uHeat.NewHeat;
    {uHeat.RenumberLanesAdv(true);}
  finally
    CORE.qryHeat.EnableControls();
    gHeat.EndUpdate;
  end;
end;

procedure TFrameHeat.actnHeat_PrintSetExecute(Sender: TObject);
// Print Set : Print both the timekeeper and marshall report
type
  EPrintStatus = (psUserCancelled, psPrinterError, psOK);
var
  rptMarshall: TMarshallReportA;
  rptTimeKeeper: TTimeKeeperReportA;
  printerName, Msg: String;
  PrintStatus: EPrintStatus;
  HeatID, EventID: integer;
begin

  {
    Looking at the FastReport source code for the TfrxPreviewPages.Print
    function, it is clear that the OnPrintReport event handler is called
    after selecting the printer but before the print job executes.

    I put the following code in my OnPrintReport handler:

    PrinterName := frxPrinters.Printers[frxPrinters.PrinterIndex];
    and PrinterName yielded whatever printer I selected in the FastReport
    printer selection.

    Once you have that, you can select it later by performing the following:

    frxReport.PrepareReport(True);
    frxReport.PrintOptions.Printer := PrinterName;
    frxReport.PrintOptions.ShowDialog := True;
    frxReport.Print;
    I have verified that all of this works.
  }

  PrintStatus := psOK;

  // loop heats
  // note: select printer dialog is enabled (by default)....
  rptTimeKeeper := TTimeKeeperReportA.Create(self);
  CORE.dsHeat.DataSet.First;
  while not CORE.dsHeat.DataSet.Eof do
  begin
    HeatID := CORE.dsHeat.DataSet.FieldByName('HeatID').AsInteger;
    rptTimeKeeper.Prepare(SCM.scmConnection, HeatID);
    if rptTimeKeeper.qryReport.Active then
    begin
      rptTimeKeeper.frxReport1.PrepareReport;
      // When frxReportPrint.Print returns false, it is either user cancel
      // or error in printing. So you need to check Errors.Text is empty
      // or not, like:
      if not rptTimeKeeper.frxReport1.Print then
      begin
        if rptTimeKeeper.frxReport1.Errors.Text.IsEmpty then
        begin
          PrintStatus := psUserCancelled;
          break;
        end
        else
        begin
          PrintStatus := psPrinterError;
          break;
          // something wrong during printing.
        end;
      end;
    end;
    rptTimeKeeper.qryReport.Close;
    // disable select printer dialog ....
    rptTimeKeeper.frxReport1.PrintOptions.ShowDialog := false;
    // store printer-name
    // printerName := rptTimeKeeper.lastPrinterName;
    CORE.dsHeat.DataSet.Next;
  end;
  // Assert close state on 'user cancelled' or 'printer error'.
  rptTimeKeeper.qryReport.Close;

  // Handle printer errors
  if (PrintStatus = psPrinterError) then
  begin
    // display error message and exit
    Msg := 'The printer reported an error ...' + sLineBreak;
    Msg := Msg + rptTimeKeeper.frxReport1.Errors.Text + sLineBreak;
    Msg := Msg + 'The batch print of marshall and timekeeper reports' +
      sLineBreak;
    Msg := Msg + 'will be aborted.' + sLineBreak;
    MessageDlg(Msg, mtError, [mbOK], 0);
  end;
  // finished with instance
  rptTimeKeeper.Free;
  // close on errors
  if (PrintStatus = psPrinterError) or (PrintStatus = psUserCancelled) then
      exit;
  // no errors? no user abort? ... go print marshall report.
  if (PrintStatus = psOK) then
  begin
    rptMarshall := TMarshallReportA.Create(self);
    // disable select printer dialog ....
    rptMarshall.frxReport1.PrintOptions.ShowDialog := false;
    // set printer-name
    rptMarshall.frxReport1.PrintOptions.Printer := printerName;
    EventID := CORE.dsEvent.DataSet.FieldByName('EventID').AsInteger;
    rptMarshall.Prepare(SCM.scmConnection, EventID);
    if rptMarshall.qryReport.Active then
    begin
      rptMarshall.frxReport1.PrepareReport;
      if not rptMarshall.frxReport1.Print then
      begin
        if not rptTimeKeeper.frxReport1.Errors.Text.IsEmpty then
        begin
          // display printer error message
          Msg := 'The printer reported an error ...' + sLineBreak;
          Msg := Msg + rptTimeKeeper.frxReport1.Errors.Text + sLineBreak;
          Msg := Msg + 'Printing of the marshall report was aborted.' +
            sLineBreak;
          MessageDlg(Msg, mtError, [mbOK], 0);
        end;
      end;
    end;
    rptMarshall.qryReport.Close;
    rptMarshall.Free;
  end;
end;

procedure TFrameHeat.actnHeat_ReportExecute(Sender: TObject);
var
  rptA: THeatReportA;
  rptB: THeatReportB;
begin
  try
    begin
      if ((GetKeyState(VK_CONTROL) and 128) = 128) then
      begin
        rptB := THeatReportB.Create(self);
        rptB.RunReport;
        rptB.Free;
      end
      else
      begin
        rptA := THeatReportA.Create(self);
        rptA.RunReport;
        rptA.Free;
      end;
    end;
  except
    on E: Exception do ShowMessage('Error opening report.');
  end;
end;

procedure TFrameHeat.actnHeat_TimeSheetExecute(Sender: TObject);
var
  rptA: TTimeKeeperReportA;
  rptB: TTimeKeeperReportB;
  HeatID: integer;
begin
  HeatID := CORE.dsHeat.DataSet.FieldByName('HeatID').AsInteger;
  try
    if ((GetKeyState(VK_CONTROL) and 128) = 128) then
    begin
      // displays stripe lines for cutting. compact. inc. PB.TTB.
      rptA := TTimeKeeperReportA.Create(self);
      rptA.Prepare(SCM.scmConnection, HeatID);
      rptA.RunReport;
      rptA.Free;
    end
    else
    begin
      // basic - oversize racetime box. inc. PB.TTB
      rptB := TTimeKeeperReportB.Create(self);
      rptB.Prepare(SCM.scmConnection, HeatID);
      rptB.RunReport;
      rptB.Free;
    end;
  except
    on E: Exception do ShowMessage('Error opening report.');
  end;
end;

procedure TFrameHeat.actnHeat_ToogleStatusExecute(Sender: TObject);
var
  status: integer;
begin
  gHeat.BeginUpdate;
  CORE.qryHeat.DisableControls();
  CORE.qryHeat.CheckBrowseMode;
  try
    status := uHeat.HeatStatusID;
    case status of
      1: Inc(status);
      2: Inc(status);
      3: status := 1;
    else
      status := 1; // default.
    end;
        try
      CORE.qryHeat.CheckBrowseMode;
      CORE.qryHeat.Edit;
      CORE.qryHeat.FieldByName('HeatStatusID').AsInteger := status;
      CORE.qryHeat.Post;
    except on E: Exception do
      begin
        CORE.qryHeat.Cancel;
        exit;
      end;
    end;
  finally
    CORE.qryHeat.EnableControls();
    gHeat.EndUpdate;
  end;
end;

function TFrameHeat.AssertCORE: boolean;
begin
  result := false;
  if Assigned(CORE) and CORE.IsActive then
    result := true;
end;

function TFrameHeat.AssertSCM: boolean;
begin
  result := false;
  if Assigned(SCM) and SCM.IsActive then
    result := true;
end;

procedure TFrameHeat.gHeatGetDisplText(Sender: TObject; ACol, ARow: Integer;
    var Value: string);
begin
/// <remarks>
///  The TDBAdvGrid is set to display a SVG image in the cell.
///  Calling here 'additionally' display a heat number.
///  The cell's font must be increased and the contents centered aligned.
/// </remarks>
  if (ACol = 1) and (ARow > 0) then
    Value := IntToStr(CORE.qryHeat.FieldByName('HeatNum').Asinteger)
  else
    Value := '';
end;

procedure TFrameHeat.msgScrollHeat(var Msg: TMessage);
begin
  if not AssertCore then     exit;
  // perform UI changes to gEvent.

end;


(*
procedure TMain.Refresh_Heat(DoBookmark: boolean = true;
  DoRenumber: boolean = false);
var
  bm: TBookmark;
  aHeatID: integer;
begin
  if not AssertConnection then exit;
  bm := nil;
  with CORE.dsHeat.DataSet do
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
    if DoRenumber then
    begin
      aHeatID := uHeat.PK;
      // DoLocate - don't locate last selected.
      // DoExclude - disabled. Will renumber/repair even when session is locked.
      uEvent.RenumberHeats(false); // don't relocate.
      uHeat.Locate(aHeatID);
    end;
    EnableControls;
  end;
end;

procedure TMain.DisplayHeatStatusMsg(aHeatStatusID: integer);
begin
  case aHeatStatusID of
    2:
      begin
        lblMsgTab3.Caption := 'Heat Raced';
        lblMsgTab3.Visible := true;
      end;
    3:
      begin
        lblMsgTab3.Caption := 'Heat Closed';
        lblMsgTab3.Visible := true;
      end;
    else
      lblMsgTab3.Visible := false;
  end;
end;

procedure TMain.HeatControlListBeforeDrawItem(AIndex: integer; ACanvas: TCanvas;
  ARect: TRect; AState: TOwnerDrawState);
var
  i: integer;
begin

  i := gridHeat.DataSet.FieldByName('HeatStatusID').AsInteger;
  // H E A T   S T A T U S   I N D I C A T O R .
  case i of
    1:
      begin
        clbtnHeatStatus.ImageIndex := 33;
      end;
    2:
      begin
        clbtnHeatStatus.ImageIndex := 34;
      end;
    3:
      begin
        clbtnHeatStatus.ImageIndex := 35;
      end;
  end;
  // S t r o k e   c o l o r   r e f l e c t e d
  // i n   h e a t   n u m b e r   i c o n .
  i := gridHeat.DataSet.FieldByName('StrokeID').AsInteger;
  case i of
    1:
      begin
        vimgHeatNum.ImageIndex := 33; // green circle
      end;
    2:
      begin
        vimgHeatNum.ImageIndex := 28; // blue circle
      end;
    3:
      begin
        vimgHeatNum.ImageIndex := 37; // red circle

      end;
    4:
      begin
        vimgHeatNum.ImageIndex := 30; // brown circle
      end;
    5:
      begin
        vimgHeatNum.ImageIndex := 35; // multicolor circle
      end
  else
    begin
      // Unknow system stroke : User defined stroke.
      vimgHeatNum.ImageIndex := 49; // Empty Circle
    end;
  end;

end;

procedure TMain.HeatNavigateControlListBeforeDrawItem(AIndex: integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
var
  s: string;
  i, j: integer;
begin

  with gridHeat.DataSet do
  begin
    lblHeatNavigatorDistance.Caption := FieldByName('ABREV').AsString;
    s := FieldByName('luStroke').AsString;
    i := FieldByName('StrokeID').AsInteger;
    j := FieldByName('EventTypeID').AsInteger;
    s := s.SubString(0, 4);

    // RELAY DOT VISIBILITY
    if (j = 0) or (j = 1) then vimgRelayDot.Visible := false
    else vimgRelayDot.Visible := true;

    lblHeatStrokeStr.Visible := false;
    case i of
      1:
        begin
          vimgHeatStroke.ImageIndex := 32; // Fr
          vimgHeatCircle.ImageIndex := 33; // green circle
        end;
      2:
        begin
          vimgHeatStroke.ImageIndex := 29; // Br
          vimgHeatCircle.ImageIndex := 28; // blue circle
        end;
      3:
        begin
          vimgHeatStroke.ImageIndex := 27; // Ba
          vimgHeatCircle.ImageIndex := 37; // red circle

        end;
      4:
        begin
          vimgHeatStroke.ImageIndex := 31; // Bu
          vimgHeatCircle.ImageIndex := 30; // brown circle
        end;
      5:
        begin
          vimgHeatStroke.ImageIndex := 34; // Me
          vimgHeatCircle.ImageIndex := 35; // multicolor circle
        end
    else
      begin
        // Unknow system stroke : User defined stroke.
        vimgHeatStroke.ImageIndex := 47; // Empty Black Frame
        vimgHeatCircle.ImageIndex := 49; // Empty Circle
        lblHeatStrokeStr.Caption := s;
        lblHeatStrokeStr.Visible := true;
      end;
    end;
  end;

end;



*)

end.
