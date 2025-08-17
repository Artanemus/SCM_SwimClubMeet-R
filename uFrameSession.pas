unit uFrameSession;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Vcl.WinXPanels, Vcl.Buttons,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Data.DB,

  uDefines,
  dmSCM,dmCORE, dmIMG,
  uSwimClub, uSession, uEvent, uHeat, uLane,
  Vcl.Menus
  ;


type
  TFrameSession = class(TFrame)
    pnlgSession: TPanel;
    gSession: TDBAdvGrid;
    pnlStack: TStackPanel;
    spbtnSessVisible: TSpeedButton;
    ShapeSessBar1: TShape;
    spbtnSessNew: TSpeedButton;
    actnlistSess: TActionList;
    actnSess_Visible: TAction;
    pumenuSess: TPopupMenu;
    actnSess_Lock: TAction;
    actnSess_Delete: TAction;
    actnSess_New: TAction;
    actnSess_Report: TAction;
    spbtnSessLock: TSpeedButton;
    spbtnSessDelete: TSpeedButton;
    ShapeSessBar2: TShape;
    spbtnSessReport: TSpeedButton;
    procedure actnSess_VisibleExecute(Sender: TObject);
    procedure actnSess_DefaultUpdate(Sender: TObject);
    procedure actnSess_DeleteExecute(Sender: TObject);
    procedure actnSess_DeleteUpdate(Sender: TObject);
    procedure actnSess_LockExecute(Sender: TObject);
    procedure actnSess_NewExecute(Sender: TObject);
    procedure actnSess_NewUpdate(Sender: TObject);
    procedure actnSess_ReportExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  dlgNewSession, rptSessionReportB, rptSessionReportA;

type
  sessAction = (actVisible, actLock, actNew, actDelete, actReport);

{$R *.dfm}

procedure TFrameSession.actnSess_VisibleExecute(Sender: TObject);
begin
  with (Sender as TAction) do
  begin
    gSession.BeginUpdate;
    Checked := not Checked;
    if Checked then // hide locked session from view. eye with line
      TAction(Sender).ImageIndex := 2
      // DEPRECIATED not required? - spbtnSessVisible.ImageIndex := 2;
    else  // display locked sessions. plain eye
      TAction(Sender).ImageIndex := 1;
      //  DEPRECIATED not required?  - spbtnSessVisible.ImageIndex := 1;
    uSession.SetVisibilityOfLocked(Checked); // toggle visibility of locked sessions

    gSession.EndUpdate;
  end;
end;

procedure TFrameSession.actnSess_DefaultUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if Assigned(CORE) and CORE.IsActive and
    not CORE.qrySession.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TFrameSession.actnSess_DeleteExecute(Sender: TObject);
var
  rtnValue, aSessionID: integer;
begin
  aSessionID := CORE.dsSession.DataSet.FieldByName('SessionID').AsInteger;
  if uSession.IsLocked then
  begin
    MessageDlg('A locked session can''t be deleted.', mtInformation,
      [mbOK], 0, mbOK);
    exit;
  end;
  { WARNING #1 }
  rtnValue := MessageDlg('Delete the selected session?' + sLineBreak +
    'Including it''s events, nominees, heats, entrants, relays, etc.',
    mtConfirmation, [mbYes, mbNo], 0, mbNo);
  // DON'T USE (rtnValue = mrNo) AS IT DOESN'T ACCOUNT FOR OS CLOSE 'X' BTN.
  // mrCancel=2 mrNo=7 mrYes=6
  if (rtnValue <> mrYes) then exit;
  { WARNING #2 }
  if uSession.HasClosedOrRacedHeats() then
  begin
    rtnValue := MessageDlg('The session contains CLOSED and/or RACED heats.' +
      sLineBreak +
      'Racetimes and entrant data will be lost if you delete this session.' +
      sLineBreak + 'Do you wish to delete the session?', mtWarning,
      [mbYes, mbNo], 0, mbNo);
    // DON'T USE (results = mrNo) AS IT DOESN'T ACCOUNT FOR OS CLOSE 'X' BTN.
    // mrCancel=2 mrNo=7 mrYes=6
    if (rtnValue <> mrYes) then exit;
  end;
  gSession.BeginUpdate;
  try
  { D E L E T E  S E S S I O N   D O   N O T   E X C L U D E ! }
  uSession.DeleteSession(false);
  finally
    gSession.EndUpdate;
  end;

  { Enable/Disable grids. LParam - delete }
  // if Assigned(Owner) then
//    PostMessage(TForm(Owner).Handle, SCM_SESSION_CHANGED, ORD(actDelete), 0);


end;

procedure TFrameSession.actnSess_DeleteUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if Assigned(CORE) and CORE.IsActive
    and not CORE.qrySession.IsEmpty
      and (CORE.qrySession.FieldByName('SessionStatusID').AsInteger <> 2)
        then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TFrameSession.actnSess_LockExecute(Sender: TObject);
begin
  with (Sender as TAction) do
  begin
    gSession.BeginUpdate;
    Checked := not Checked;
    if Checked then
    begin
      TAction(Sender).ImageIndex := 7;
      // DEPRECIATED not required? - spbtnSessLock.ImageIndex := 7;
      uSession.SetSessionStatusID(1); // UN-LOCKED.
    end
    else
    begin
      TAction(Sender).ImageIndex := 6;
      //  DEPRECIATED not required?  - spbtnSessLock.ImageIndex := 6;
      uSession.SetSessionStatusID(2); // LOCKED.
    end;
    // toggle visibility of locked sessions
    gSession.endUpdate;
  end;

  { Enable/Disable grids. LParam - lock state changed }
  // if Assigned(Owner) then
  //  PostMessage(TForm(Owner).Handle, SCM_SESSION_CHANGED, ORD(actLock), 0);

end;

procedure TFrameSession.actnSess_NewExecute(Sender: TObject);
var
  dlg: TNewSession;
begin
  { TODO -oBSA -cGeneral : Check overload, methods for insert or edit modes }
  // Exception raised if connection assigned.
  dlg := TNewSession.CreateWithConnection(self, SCM.scmConnection);
  dlg.SessionMode := smNewSession;
  if IsPositiveResult(dlg.ShowModal) then
  begin
    gSession.BeginUpdate;
    try
      uSession.NewSession;
    finally
      dlg.Free;
      gSession.EndUpdate;
    end;

  { LParam - new session. Check - cue-to-record. grid sorted correctly. }
  // if Assigned(Owner) then
  //  PostMessage(TForm(Owner).Handle, SCM_SESSION_CHANGED, ORD(actNew), 0);

  end;
end;

procedure TFrameSession.actnSess_NewUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false; // session table can be empty.
  if Assigned(CORE) and CORE.IsActive then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TFrameSession.actnSess_ReportExecute(Sender: TObject);
var
  rpt: TSessionReportA;
  rpt2: TSessionReportB;
begin
  try
    if ((GetKeyState(VK_CONTROL) AND 128) = 128) then
    begin
      rpt2 := TSessionReportB.Create(self);
      // raises exception if SCM not assigned.
      rpt2.RunReport;
      rpt2.Free;
    end
    else
    begin
      rpt := TSessionReportA.Create(self);
      // raises exception if SCM not assigned.
      rpt.RunReport;
      rpt.Free;
    end;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

end.
