unit f_FrameSession;

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
    actnSess_Edit: TAction;
    actnSess_Export: TAction;
    actnSess_Import: TAction;
    actnSess_Clone: TAction;
    actnSess_Sort: TAction;
    spbtnSessEdit: TSpeedButton;
    spbtnSessClone: TSpeedButton;
    oggleVisibility1: TMenuItem;
    oggleLock1: TMenuItem;
    EditSession1: TMenuItem;
    NewSession1: TMenuItem;
    DeleteSession1: TMenuItem;
    CloneSession1: TMenuItem;
    SessionReport1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    actnSess_BatchReport: TAction;
    actnSess_RenumberEvents: TAction;
    procedure actnSess_CloneExecute(Sender: TObject);
    procedure actnSess_DefaultUpdate(Sender: TObject);
    procedure actnSess_DeleteExecute(Sender: TObject);
    procedure actnSess_DeleteUpdate(Sender: TObject);
    procedure actnSess_EditExecute(Sender: TObject);
    procedure actnSess_LockExecute(Sender: TObject);
    procedure actnSess_NewExecute(Sender: TObject);
    procedure actnSess_NewUpdate(Sender: TObject);
    procedure actnSess_ReportExecute(Sender: TObject);
    procedure actnSess_SortExecute(Sender: TObject);
    procedure actnSess_VisibleExecute(Sender: TObject);
    procedure gSessionDrawCell(Sender: TObject; ACol, ARow: LongInt; Rect: TRect;
        State: TGridDrawState);
  private
    { Private declarations }
    function AssertCORE(): boolean;

  protected
    procedure msgScrollSession(var Msg: TMessage); message SCM_SCROLL_SESSION;

  public
    { Public declarations }
  end;

implementation

uses
  dlgNewSession, rptSessionReportB, rptSessionReportA, dlgCloneSession;

{$R *.dfm}


procedure TFrameSession.actnSess_CloneExecute(Sender: TObject);
var
  dlg: TCloneSession;
begin
  { TODO -oBSA -cGeneral :  Check abort method. }
  try
    dlg := TCloneSession.Create(self);
    // raises exception if SCM not assigned.
    if IsPositiveResult(dlg.ShowModal) then
    begin
      uSession.DetailTBLs_ApplyMaster;
    end;
    dlg.Free;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TFrameSession.actnSess_VisibleExecute(Sender: TObject);
begin
    gSession.BeginUpdate;
    TAction(Sender).Checked := not TAction(Sender).Checked;
    try
      if TAction(Sender).Checked then // hide locked session from view. eye with line
        TAction(Sender).ImageIndex := 2
        // DEPRECIATED not required? - spbtnSessVisible.ImageIndex := 2;
      else  // display locked sessions. plain eye
        TAction(Sender).ImageIndex := 1;
        //  DEPRECIATED not required?  - spbtnSessVisible.ImageIndex := 1;
      { uSession handles enable/disable and re-sync of Master-Detail}
      uSession.SetVisibilityOfLocked(TAction(Sender).Checked);
    finally
      gSession.EndUpdate;
    end;
end;

function TFrameSession.AssertCORE: boolean;
begin
  result := false;
  if Assigned(CORE) and CORE.IsActive then
    result := true;
end;

procedure TFrameSession.msgScrollSession(var Msg: TMessage);
begin
  if not AssertCORE then exit;
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
  rtnValue: integer;
begin
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
    { uSession handles enable/disable and re-sync of Master-Detail}
    uSession.DeleteSession(false);
  finally
    gSession.EndUpdate;
  end;
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

procedure TFrameSession.actnSess_EditExecute(Sender: TObject);
var
  dlg: TNewSession;
  DT: TDateTime;
begin
  DT := CORE.qrySession.FieldByName('StartDT').AsDateTime;
  try
  dlg := TNewSession.CreateWithConnection(self, SCM.scmConnection);
  dlg.SessionMode := smEditSession;
  dlg.SessionID := uSession.PK;
  if IsPositiveResult(dlg.ShowModal) then
  begin
    { if the session date has been modified then
      the session table will need to be resorted.
    }
    if DT <> CORE.qrySession.FieldByName('StartDT').AsDateTime then
      { uSession handles enable/disable and re-sync of Master-Detail}
      uSession.SortSession();
  end;
  finally
    dlg.Free;
  end;
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

      { uSession handles enable/disable and re-sync of Master-Detail}
      uSession.SetSessionStatusID(2); // LOCKED.
    end;
    // toggle visibility of locked sessions
    gSession.endUpdate;
  end;
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
      { uSession handles enable/disable and re-sync of Master-Detail}
      uSession.NewSession;
    finally
      dlg.Free;
      gSession.EndUpdate;
    end;
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

procedure TFrameSession.actnSess_SortExecute(Sender: TObject);
var
  aSessionID: integer;
begin
  gSession.BeginUpdate;
  try
    uSession.SortSession();
  finally
    gSession.EndUpdate;
  end;
end;

procedure TFrameSession.gSessionDrawCell(Sender: TObject; ACol, ARow: LongInt;
    Rect: TRect; State: TGridDrawState);
var
  Size: TSize;
  topMargin: integer;
  MyRect: TRect;
  fSessionClosedBgColor, fSessionClosedFontColor: TColor;
  txt:string;
begin
  // dim the text if the session is closed
  // DEFAULT DRAWING IS DISABLED ....
  // a CLOSED SESSION
  if (gSession.DataSource.DataSet.FieldByName('SessionStatusID') .AsInteger = 2) then
  begin
    txt := gSession.DataSource.DataSet.FieldByName('Caption') .AsString;
    // CLEAR THE CANVAS
    gSession.Canvas.Brush.Color := fSessionClosedBgColor;
    gSession.Canvas.Brush.Style := bsSolid;
    gSession.Canvas.FillRect(Rect);
    // PRINT THE TEXT
    gSession.Canvas.Font.Color := fSessionClosedFontColor;
    Size := gSession.Canvas.TextExtent(txt);
    topMargin := Round((Rect.Height - Size.Height) / 2);
    // calculate margins
    MyRect.Top := Rect.Top + topMargin;
    MyRect.Left := Rect.Left + topMargin;
    MyRect.Bottom := Rect.Bottom;
    MyRect.Right := Rect.Right;
    gSession.Canvas.TextRect(Rect, Rect.Left, Rect.Top, txt);
  end;
end;

end.
