unit f_FrameMember;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.WinXPanels,
  Vcl.ExtCtrls, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid,
  Vcl.VirtualImage, Vcl.StdCtrls,

  dmIMG, dmSCM, dmCORE, uSwimClub, uSession, uEvent, uHeat, ulane,

  Vcl.Buttons, Vcl.Menus, System.Actions, Vcl.ActnList;

type
  TFrameMember = class(TFrame)
    gMember: TDBAdvGrid;
    pnlDetail: TPanel;
    pnlStack: TStackPanel;
    pnlBody: TPanel;
    pnlHeader: TPanel;
    btnClearSearch: TButton;
    edtMemberName: TEdit;
    vimgSearch: TVirtualImage;
    pnlMessage: TPanel;
    lblMessage: TLabel;
    spbtnNominateReport: TSpeedButton;
    ShapeNomBar1: TShape;
    spbtnNominateSortMember: TSpeedButton;
    actnlistMember: TActionList;
    pumenuMember: TPopupMenu;
    actnMemberSwitch: TAction;
    actnMemberReport: TAction;
    actnMemberGoto: TAction;
    procedure actnMemberDefaultUpdate(Sender: TObject);
    procedure actnMemberGotoExecute(Sender: TObject);
    procedure actnMemberReportExecute(Sender: TObject);
    procedure edtMemberNameChange(Sender: TObject);
    procedure gMemberDblClick(Sender: TObject);
    procedure gMemberGetCellColor(Sender: TObject; ARow, ACol: Integer; AState:
        TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    function AssertCORE: boolean;
  public
    { Public declarations }
  end;

implementation

uses
  frmManageMember, rptNominateReportB, rptNominateReportA;

{$R *.dfm}

procedure TFrameMember.actnMemberDefaultUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertCORE then
    if not CORE.qrymember.IsEmpty then
      DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TFrameMember.actnMemberGotoExecute(Sender: TObject);
var
  dlg: TManageMember;
  MemberID: Variant;
begin
  dlg := TManageMember.Create(self);
  MemberID := CORE.qrymember.FieldByName('MemberID').AsInteger;
  try
    dlg.Prepare(SCM.scmConnection, 1, MemberID);
    dlg.ShowModal;
  finally
    dlg.Free;
  end;
end;

procedure TFrameMember.actnMemberReportExecute(Sender: TObject);
var
  rptA: TNominateReportA;
  rptB: TNominateReportB;
begin
  if not AssertCORE then exit;
  try
    begin
      if ((GetKeyState(VK_CONTROL) and 128) = 128) then
      begin
        rptA := TNominateReportA.Create(self);
        rptA.RunReport;
        rptA.Free;
      end
      else
      begin
        rptB := TNominateReportB.Create(self);
        rptB.RunReport;
        rptB.Free;
      end;
    end;
  except
    on E: Exception do ShowMessage('Error opening nominatation report.');
  end;
end;

function TFrameMember.AssertCORE: boolean;
begin
  result := false;
  if Assigned(CORE) and CORE.IsActive then
    result := true;
end;

procedure TFrameMember.edtMemberNameChange(Sender: TObject);
var
  fs: String;
begin
  if not AssertCORE then exit;
  fs := '';
  with CORE.dsNominee.DataSet do
  begin
    gMember.BeginUpdate;
    DisableControls;
    // update filter string ....
    if (Length(edtMemberName.Text) > 0) then
    begin
      fs := fs + '[FName] LIKE ' + QuotedStr('%' + edtMemberName.Text + '%');
    end;
    // assign filter
    if fs.IsEmpty then Filtered := false
    else
    begin
      Filter := fs;
      if not Filtered then Filtered := true;
    end;
    EnableControls;
    gMember.EndUpdate;
  end;
end;

procedure TFrameMember.gMemberDblClick(Sender: TObject);
begin
  if AssertCORE and CORE.qryMember.IsEmpty then
    actnlistMember.ExecuteAction(actnMemberGoto);
end;

procedure TFrameMember.gMemberGetCellColor(Sender: TObject; ARow, ACol:
    Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  SQL: String;
  MemberID, SessionID: integer;
  v: variant;
begin
  if not AssertCORE then exit;
  if (ARow > gMember.FixedRows) and (gMember.Columns[ACol].FieldName = 'FullName') then
  begin
    MemberID := CORE.qryMember.FieldByName('MemberID').AsInteger;
    SessionID := uSession.PK;
    SQL := '''
        SELECT Count(MemberID) FROM [SwimClubMeet2].[dbo].[Nominee]
        INNER JOIN [SwimClubMeet2].[dbo].[Event] ON Nominee.EventID = [Event].EventID
        WHERE WHERE SessionID = :id1 AND MemberID = :id2;
      ''';
    v := SCM.scmConnection.ExecSQLScalar(SQL, [SessionID, MemberID]);
    if not VarIsClear(v) and (v > 0) then
    begin
      AFont.Color := clWebTomato;
    end;
  end;
end;

(*
procedure TMain.Nominate_SortMembersExecute(Sender: TObject);
var
  actn: TAction;
begin
  // TActionUpdate determines if this procedure can be called.
  actn := TAction(Sender);
  actn.Checked := not actn.Checked;
  SCM.Nominate_SortMembers(actn.Checked);
  if Nominate_Grid.CanFocus then Nominate_Grid.SetFocus;
end;

procedure TMain.Nominate_SortMembersUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      // No members listed. Nothing to sort.
      if not Nominate_Grid.DataSource.DataSet.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;
*)

(*
  procedure TMain.Nominate_Scroll(var Msg: TMessage);
  var
    MemberID: integer;
    success: boolean;
  begin
    if not AssertConnection then exit;

    MemberID := CORE.dsNominee.DataSet.FieldByName('MemberID').AsInteger;
    success := SCM.Nominate_UpdateControlList(uSession.PK, MemberID);

    if success then Nominate_ControlList.Invalidate;
  end;
*)

(*
procedure TMain.Nominate_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: integer; Column: TColumn; State: TGridDrawState);
var
  SQL: String;
  Count, MemberID, SessionID: integer;
begin
  with Sender AS TDBGrid do
  begin
    if AssertConnection then
    begin
      // Default draw disabled
      // Has the member been nominated to some events?
      MemberID := DataSource.DataSet.FieldByName('MemberID').AsInteger;
      SessionID := uSession.PK;
      SQL := 'SELECT Count(MemberID) FROM [SwimClubMeet2].[dbo].Nominee ' +
        sLineBreak + 'INNER JOIN [SwimClubMeet2].[dbo].[Event] ON ' + sLineBreak
        + '[SwimClubMeet2].[dbo].Nominee.EventID = [SwimClubMeet2].[dbo].[Event].EventID '
        + sLineBreak + 'WHERE SessionID = :id1 AND MemberID = :id2;';
      // run scalar function on DB
      Count := SCM.scmConnection.ExecSQLScalar(SQL, [SessionID, MemberID],
        [ftInteger, ftInteger]);
      if (Count > 0) then
      begin
        Canvas.Font.Color := clWebTomato;
      end;
    end;
    // DEFAULT cell draaw
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;
*)


end.
