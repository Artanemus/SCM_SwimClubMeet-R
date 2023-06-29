unit frmManageMember;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, VclTee.TeeGDIPlus,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, System.ImageList, Vcl.ImgList,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.StdCtrls, VclTee.TeEngine,
  VclTee.TeeSpline, VclTee.Series, VclTee.TeeProcs, VclTee.Chart,
  VclTee.DBChart, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.WinXCalendars, dmManageMemberData, SCMDefines,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan,
  Vcl.ToolWin, Vcl.ActnCtrls, Vcl.ActnMenus;

type
  TManageMember = class(TForm)
    Panel1: TPanel;
    lblMemberCount: TLabel;
    chkbHideInActive: TCheckBox;
    chkbHideArchived: TCheckBox;
    chkbHideNonSwimmers: TCheckBox;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel7: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label10: TLabel;
    DBText3: TDBText;
    Label7: TLabel;
    Label12: TLabel;
    dblblMemberID: TDBText;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    DBlucboGender: TDBLookupComboBox;
    DBedtFirstName: TDBEdit;
    DBedtLastName: TDBEdit;
    DBedtMembershipNum: TDBEdit;
    DBchkIsActive: TDBCheckBox;
    DBEdtEmail: TDBEdit;
    DBlucboHouse: TDBLookupComboBox;
    DBchkIsSwimmer: TDBCheckBox;
    DBchkIsArchived: TDBCheckBox;
    btnClearHouse: TButton;
    btnClearGender: TButton;
    TabSheet2: TTabSheet;
    DBGrid3: TDBGrid;
    ImageList1: TImageList;
    btnFindMember: TButton;
    btnGotoMemberID: TButton;
    Label18: TLabel;
    RegistrationNum: TDBEdit;
    Label8: TLabel;
    dtpickDOB: TCalendarPicker;
    lblCount: TLabel;
    btnGotoMembership: TButton;
    DBgridHistoryPB: TDBGrid;
    Label23: TLabel;
    Label13: TLabel;
    DBgridContactInfo: TDBGrid;
    DBContactNumNavigator: TDBNavigator;
    TabSheet3: TTabSheet;
    Label5: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label9: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    btnMemberDetail: TButton;
    btnClubMembersSummary: TButton;
    btnMemberHistory: TButton;
    btnClubMembersDetailed: TButton;
    btnClubMembersList: TButton;
    ActnMemberMenuBar: TActionMainMenuBar;
    ActnManagerMember: TActionManager;
    MemFile_AutoEdit: TAction;
    MemFile_Exit: TAction;
    MemSearch_GotoMembershipNum: TAction;
    MemSearch_GotoMemberID: TAction;
    MemSearch_FindMember: TAction;
    ImageCollectMember: TImageCollection;
    VirtlImageListMember: TVirtualImageList;
    Label6: TLabel;
    DBGrid1: TDBGrid;
    DBNavigator2: TDBNavigator;
    Label11: TLabel;
    DBEdit1: TDBEdit;
    Label15: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure About2Click(Sender: TObject);
    procedure DBGrid3CellClick(Column: TColumn);
    procedure DBGrid3ColEnter(Sender: TObject);
    procedure DBGrid3ColExit(Sender: TObject);
    procedure DBGrid3DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DrawCheckBoxes(oGrid: TObject; Rect: TRect; Column: TColumn;
  fontColor, bgColor: TColor);
    procedure dtpickDOBChange(Sender: TObject);
    procedure chkbHideArchivedClick(Sender: TObject);
    procedure chkbHideInActiveClick(Sender: TObject);
    procedure chkbHideNonSwimmersClick(Sender: TObject);
    procedure DBGrid3EditButtonClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnFindMemberClick(Sender: TObject);
    procedure btnGotoMemberIDClick(Sender: TObject);
    procedure btnGotoMembershipClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Onlinehelp1Click(Sender: TObject);
    procedure SCMwebsite1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure FormShow(Sender: TObject);
    procedure btnMemberDetailClick(Sender: TObject);
    procedure btnMemberHistoryClick(Sender: TObject);
    procedure btnClubMembersSummaryClick(Sender: TObject);
    procedure btnClubMembersDetailedClick(Sender: TObject);
    procedure btnClubMembersListClick(Sender: TObject);
    procedure MemFile_ExitExecute(Sender: TObject);
    procedure MemSearch_FindMemberExecute(Sender: TObject);

  private
    { Private declarations }
    fSwimClubID: Integer;
    fDoDelete: Boolean;
    FConnection: TFDConnection;
    fColorEditBoxFocused: TColor;
    fColorEditBoxNormal: TColor;
    fColorBgColor: TColor;

    function FindMember(MemberID: Integer): Boolean;
    function AssertConnection: Boolean;

    procedure ReadPreferences();
    procedure WritePreferences();

  protected
    // windows messages ....
    procedure ManageMemberAfterScroll(var Msg: TMessage);
      message SCM_AFTERSCROLL;
    procedure ManageMemberUpdate(var Msg: TMessage);
      message SCM_UPDATE;

  public
    { Public declarations }
    procedure Prepare(AConnection: TFDConnection; ASwimClubID: Integer = 1;
      AMemberID: Integer = 0);
    procedure ClearAllFilters();

  end;

const
  INIFILE_SCM_MEMBERPREF = 'SCM_MemberPref.ini';
  INIFILE_SECTION = 'SCM_Member';

var
  ManageMember: TManageMember;

implementation

{$R *.dfm}

uses SCMUtility, dlgBasicLogin, System.IniFiles, System.UITypes, dlgAbout,
  dlgDOBPicker, dlgFindMember, dlgGotoMember, dlgGotoMembership,
  System.IOUtils, Winapi.ShellAPI, dlgDeleteMember, vcl.Themes, rptMemberDetail,
  rptMemberHistory, rptMembersList, rptMembersDetail, rptMembersSummary;

procedure TManageMember.About2Click(Sender: TObject);
var
  dlg: TAbout;
begin
  dlg := TAbout.Create(Self);
  dlg.ShowModal;
  FreeAndNil(dlg);
end;

function TManageMember.AssertConnection: Boolean;
begin
  result := false;
  // test datamodule construction
  if Assigned(ManageMemberData) then
  begin
    // IsActive if TFDConnection::scmConnection && FireDAC tables are active
    if ManageMemberData.ManageMemberDataActive then
      result := true;
  end;
end;

procedure TManageMember.btnClearClick(Sender: TObject);
begin
  if Assigned(ManageMemberData) and (ManageMemberData.qryMember.Active) then
  begin
    if (ManageMemberData.qryMember.State <> dsInsert) or
      (ManageMemberData.qryMember.State <> dsEdit) then
      ManageMemberData.qryMember.Edit();
    case TButton(Sender).Tag of
      1:
        ManageMemberData.qryMember.FieldByName('GenderID').Clear();
      3:
        ManageMemberData.qryMember.FieldByName('HouseID').Clear();
    end;
  end;
end;

procedure TManageMember.btnClubMembersDetailedClick(Sender: TObject);
var
rpt: TMembersDetail;
begin
  if not Assigned(ManageMemberData) then exit;
    rpt := TMembersDetail.Create(self);
    rpt.RunReport(FConnection, FSwimClubID);
    rpt.Free;
end;

procedure TManageMember.btnClubMembersListClick(Sender: TObject);
var
rpt: TMembersList;
begin
  if not Assigned(ManageMemberData) then exit;
    rpt := TMembersList.Create(self);
    rpt.RunReport(FConnection, FSwimClubID);
    rpt.Free;
end;

procedure TManageMember.btnClubMembersSummaryClick(Sender: TObject);
var
rpt: TMembersSummary;
begin
  if not Assigned(ManageMemberData) then exit;
    rpt := TMembersSummary.Create(self);
    rpt.RunReport(FConnection, FSwimClubID);
    rpt.Free;
end;

procedure TManageMember.btnFindMemberClick(Sender: TObject);
var
  dlg: TFindMember;
begin
  dlg := TFindMember.Create(Self);
  dlg.Prepare(FConnection, fSwimClubID);
  if IsPositiveResult(dlg.ShowModal()) then
  begin
    // LOCATE MEMBER IN qryMember
    FindMember(dlg.MemberID)
  end;
  dlg.Free;
end;

procedure TManageMember.btnGotoMemberIDClick(Sender: TObject);
var
  dlg: TGotoMember;
  rtn: TModalResult;
begin
  if Assigned(ManageMemberData) then
  begin
    dlg := TGotoMember.Create(Self);
    dlg.Prepare(FConnection, fSwimClubID);
    rtn := dlg.ShowModal;
    if IsPositiveResult(rtn) then
    begin
      // LOCATE MEMBER IN qryMember
      FindMember(dlg.MemberID)
    end;
    dlg.Free;
  end;
end;

procedure TManageMember.btnGotoMembershipClick(Sender: TObject);
var
  dlg: TGotoMembership;
  rtn: TModalResult;
begin
  if Assigned(ManageMemberData) then
  begin
    dlg := TGotoMembership.Create(Self);
    dlg.Prepare(FConnection, fSwimClubID);
    rtn := dlg.ShowModal;
    if IsPositiveResult(rtn) then
    begin
      // NOTE: returns both MembershipNum and MemberID
      // LOCATE MEMBER IN qryMember
      FindMember(dlg.MemberID)
    end;
    dlg.Free;
  end;
end;

procedure TManageMember.btnMemberDetailClick(Sender: TObject);
var
  rpt: TMemberDetail;
  MemberID: Integer;
begin
  if not Assigned(ManageMemberData) then
    exit;
  MemberID := ManageMemberData.dsMember.DataSet.FieldByName('MemberID')
    .AsInteger;
  rpt := TMemberDetail.Create(Self);
  rpt.RunReport(FConnection, fSwimClubID, MemberID);
  rpt.Free;
end;

procedure TManageMember.btnMemberHistoryClick(Sender: TObject);
var
  rpt: TMemberHistory;
  MemberID: Integer;
begin
  if not Assigned(ManageMemberData) then
    exit;
  MemberID := ManageMemberData.dsMember.DataSet.FieldByName('MemberID')
    .AsInteger;
  rpt := TMemberHistory.Create(Self);
  rpt.RunReport(FConnection, fSwimClubID, MemberID);
  rpt.Free;
end;

procedure TManageMember.chkbHideArchivedClick(Sender: TObject);
begin
  if Assigned(ManageMemberData) then
    ManageMemberData.UpdateMember(fSwimClubID, chkbHideArchived.Checked,
      chkbHideInActive.Checked, chkbHideNonSwimmers.Checked);
end;

procedure TManageMember.chkbHideInActiveClick(Sender: TObject);
begin
  if Assigned(ManageMemberData) then
    ManageMemberData.UpdateMember(fSwimClubID, chkbHideArchived.Checked,
      chkbHideInActive.Checked, chkbHideNonSwimmers.Checked);
end;

procedure TManageMember.chkbHideNonSwimmersClick(Sender: TObject);
begin
  if Assigned(ManageMemberData) then
    ManageMemberData.UpdateMember(fSwimClubID, chkbHideArchived.Checked,
      chkbHideInActive.Checked, chkbHideNonSwimmers.Checked);
end;

procedure TManageMember.ClearAllFilters;
begin
  if Assigned(ManageMemberData) then
  begin
    chkbHideArchived.Checked := false;
    chkbHideInActive.Checked := false;
    chkbHideNonSwimmers.Checked := false;
    ManageMemberData.UpdateMember(fSwimClubID, chkbHideArchived.Checked,
      chkbHideInActive.Checked, chkbHideNonSwimmers.Checked);
  end;
end;

procedure TManageMember.DBGrid3CellClick(Column: TColumn);
begin
  if Assigned(Column.Field) and (Column.Field.DataType = ftBoolean) then
  begin
    Column.Grid.DataSource.DataSet.CheckBrowseMode;
    Column.Grid.DataSource.DataSet.Edit;
    Column.Field.AsBoolean := not Column.Field.AsBoolean;
  end;
  if Assigned(Column.Field) and (Column.Field.FieldKind = fkLookup) then
  begin
    Column.Grid.DataSource.DataSet.CheckBrowseMode;
    Column.Grid.DataSource.DataSet.Edit;
  end;
end;

procedure TManageMember.DBGrid3ColEnter(Sender: TObject);
begin
  // By default, two clicks on the same cell enacts the cell editing mode.
  // The grid draws a TEditBox over the cell, killing the checkbox draw UI.
  with Sender as TDBGrid do
  begin
    if Assigned(SelectedField) and (SelectedField.DataType = ftBoolean) then
    begin
      Options := Options - [dgEditing];
    end;
  end;
end;

procedure TManageMember.DBGrid3ColExit(Sender: TObject);
begin
  with Sender as TDBGrid do
  if Assigned(SelectedField) and   (SelectedField.DataType = ftBoolean) then
    Options := Options + [dgEditing];
end;

procedure TManageMember.DBGrid3DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  clFont, clBg: TColor;
begin
  // NOTE : DEFAULT DRAWING IS DISABLED ....
  if (Column.Field.FieldName = 'IsActive') or
    (Column.Field.FieldName = 'IsArchived') or
    (Column.Field.FieldName = 'IsSwimmer') then
  begin
    if gdFocused in State then
      clFont := fColorEditBoxFocused
    else
      clFont := fColorEditBoxNormal;
    clBg := fColorBgColor;
    DrawCheckBoxes(Sender, Rect, Column, clFont, clBg);
    // draw 'Focused' frame  (for boolean datatype only)
    if gdFocused in State then
      TDBGrid(Sender).Canvas.DrawFocusRect(Rect);
  end
  else
  begin
    TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then
      TDBGrid(Sender).Canvas.DrawFocusRect(Rect);
  end;
end;

procedure TManageMember.DBGrid3EditButtonClick(Sender: TObject);
var
  fld: TField;
  cal: TDOBPicker;
  // point: TPoint;
  Rect: TRect;
  rtn: TModalResult;
begin
  // handle the ellipse button for the DOB - show DatePicker
  fld := TDBGrid(Sender).SelectedField;
  if fld.Name = 'qryMemberDOB' then
  begin
    cal := TDOBPicker.Create(Self);
    Rect := TButton(Sender).ClientToScreen(TButton(Sender).ClientRect);
    cal.Left := Rect.Left;
    cal.Top := Rect.Top;
    cal.CalendarView1.Date := fld.AsDateTime;
    rtn := cal.ShowModal;
    if IsPositiveResult(rtn) then
    begin
      if (TDBGrid(Sender).DataSource.State <> dsEdit) or
        (TDBGrid(Sender).DataSource.State <> dsInsert) then
      begin
        // ALT: ManageMemberData.UpdateDOB(cal.CalendarView1.Date);
        TDBGrid(Sender).DataSource.Edit;
        fld.Value := cal.CalendarView1.Date;
      end;

    end;
    cal.Free;
  end;
end;

procedure TManageMember.DBGrid3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  fld: TField;
begin

  With Sender as TDBGrid do begin
  if Assigned(SelectedField) then
  begin

    if (SelectedField.DataType = ftBoolean) then
    begin
      // If the selected field is a boolean,
      // then enable SPACE key to toggle the value.
      fld := SelectedField;
      if (Key = vkSpace) then
      begin
        if (DataSource.DataSet.State <> dsEdit) or
          (DataSource.DataSet.State <> dsInsert) then
        begin
          DataSource.DataSet.Edit();
        end;
        fld.Value := not fld.AsBoolean;
        Key := NULL;
      end;
      // Y, y, T, t
      if (Key = $59) or (Key = $79) or (Key = $54) or (Key = $74) then
      begin
        if (DataSource.DataSet.State <> dsEdit) or
          (DataSource.DataSet.State <> dsInsert) then
        begin
          DataSource.DataSet.Edit();
        end;
        fld.Value := 1;
        Key := NULL;
      end;
      // N, n, F, f
      if (Key = $4E) or (Key = $6E) or (Key = $46) or (Key = $66) then
      begin
        if (DataSource.DataSet.State <> dsEdit) or
          (DataSource.DataSet.State <> dsInsert) then
        begin
          DataSource.DataSet.Edit();
        end;
        fld.Value := 0;
        Key := NULL;
      end;
    end;

    // DROPDOWN COMBOBOX
    if (SelectedField.FieldKind = fkLookup) then
    begin
      // NullValueKey - Alt+BkSp - CLEAR
      if (Key = vkBack) and (ssAlt in Shift) then
      begin
        fld := SelectedField;
        if (fld.FieldName = 'luHouse') then
        begin
          DataSource.DataSet.Edit();
          DataSource.DataSet.FieldByName('HouseID').Clear();
          DataSource.DataSet.Post();
          Key := NULL;
        end;
        if (fld.FieldName = 'luMembershipType') then
        begin
          DataSource.DataSet.Edit();
          DataSource.DataSet.FieldByName('MembershipTypeID').Clear();
          DataSource.DataSet.Post();
          Key := NULL;
        end;
        if (fld.FieldName = 'luGender') then
        begin
          DataSource.DataSet.Edit();
          DataSource.DataSet.FieldByName('GenderID').Clear();
          DataSource.DataSet.Post();
          Key := NULL;
        end;
      end;
    end;
  end;
  end;

end;

procedure TManageMember.DBNavigator1BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
var
  dlg: TDeleteMember;
  FName, s: string;
  ID: Integer;
begin
  if Button = nbDelete then
  begin
    fDoDelete := false;
    dlg := TDeleteMember.Create(Self);
    // get the fullname of the member to delete
    FName := ManageMemberData.dsMember.DataSet.FieldByName('FName').AsString;
    ID := ManageMemberData.dsMember.DataSet.FieldByName('MemberID').AsInteger;
    s := IntToStr(ID);
    dlg.lblTitle.Caption := 'Delete (ID: ' + s + ') ' + FName +
      ' from the SwimClubMeet database ?';
    // display the confirm delete dlg
    if IsPositiveResult(dlg.ShowModal) then
    begin
      fDoDelete := true;
      // the delete action is allowed to continue ...
    end
    else
      // raises a silent exception - cancelling the action.
      Abort;
    dlg.Free;
  end;
end;

procedure TManageMember.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  if Button = nbDelete then
  begin
    // click occurs after action...
    fDoDelete := false;
  end;
end;

// ---------------------------------------------------------------------------
// Draw a very basic checkbox (ticked) - not a nice as TCheckListBox
// ---------------------------------------------------------------------------
procedure TManageMember.DrawCheckBoxes(oGrid: TObject; Rect: TRect; Column: TColumn;
  fontColor, bgColor: TColor);
var
  MyRect: TRect;
  oField: TField;
  iPos, iFactor: integer;
  bValue: boolean;
  g: TDBGrid;
  points: Array [0 .. 4] of TPoint;
begin
  // ---------------------------------------------------------------------------
  // Draw a very basic checkbox (ticked) - not a nice as TCheckListBox
  // ---------------------------------------------------------------------------

  g := TDBGrid(oGrid);
  // is the cell checked?
  oField := Column.Field;
  if (oField.value = -1) then
    bValue := true
  else
    bValue := false;

  g.Canvas.Pen.Color := fontColor; //
  g.Canvas.Brush.Color := bgColor;
  g.Canvas.Brush.Style := bsSolid;
  g.Canvas.FillRect(Rect);

  // calculate margins
  MyRect.Top := Trunc((Rect.Bottom - Rect.Top - 17) / 2) + Rect.Top;
  MyRect.Left := Trunc((Rect.Right - Rect.Left - 17) / 2) + Rect.Left;
  MyRect.Bottom := MyRect.Top + 16;
  MyRect.Right := MyRect.Left + 16;

  // USES PEN - draw the box (with cell margins)
  points[0].x := MyRect.Left;
  points[0].y := MyRect.Top;
  points[1].x := MyRect.Right;
  points[1].y := MyRect.Top;
  points[2].x := MyRect.Right;
  points[2].y := MyRect.Bottom;
  points[3].x := MyRect.Left;
  points[3].y := MyRect.Bottom;
  points[4].x := MyRect.Left;
  points[4].y := MyRect.Top;

  g.Canvas.Polyline(points);

  iPos := MyRect.Left;
  iFactor := 1;
  // USES PEN - DRAW A TICK - Cross would be nicer?
  if bValue then
  begin
    // 16x16 grid. Pen width is 1 pixel.
    // tick falls
    g.Canvas.MoveTo(iPos + (iFactor * 2), MyRect.Top + 8);
    g.Canvas.LineTo(iPos + (iFactor * 2), MyRect.Top + 11);
    g.Canvas.MoveTo(iPos + (iFactor * 3), MyRect.Top + 9);
    g.Canvas.LineTo(iPos + (iFactor * 3), MyRect.Top + 12);
    g.Canvas.MoveTo(iPos + (iFactor * 4), MyRect.Top + 10);
    g.Canvas.LineTo(iPos + (iFactor * 4), MyRect.Top + 13);
    g.Canvas.MoveTo(iPos + (iFactor * 5), MyRect.Top + 11);
    g.Canvas.LineTo(iPos + (iFactor * 5), MyRect.Top + 14);
    // bottom ... flattens
    g.Canvas.MoveTo(iPos + (iFactor * 6), MyRect.Top + 12);
    g.Canvas.LineTo(iPos + (iFactor * 6), MyRect.Top + 15);
    g.Canvas.MoveTo(iPos + (iFactor * 7), MyRect.Top + 12);
    g.Canvas.LineTo(iPos + (iFactor * 7), MyRect.Top + 15);
    // tick rises
    g.Canvas.MoveTo(iPos + (iFactor * 8), MyRect.Top + 11);
    g.Canvas.LineTo(iPos + (iFactor * 8), MyRect.Top + 14);
    g.Canvas.MoveTo(iPos + (iFactor * 9), MyRect.Top + 10);
    g.Canvas.LineTo(iPos + (iFactor * 9), MyRect.Top + 13);
    g.Canvas.MoveTo(iPos + (iFactor * 10), MyRect.Top + 9);
    g.Canvas.LineTo(iPos + (iFactor * 10), MyRect.Top + 12);
    g.Canvas.MoveTo(iPos + (iFactor * 11), MyRect.Top + 8);
    g.Canvas.LineTo(iPos + (iFactor * 11), MyRect.Top + 11);
    g.Canvas.MoveTo(iPos + (iFactor * 12), MyRect.Top + 7);
    g.Canvas.LineTo(iPos + (iFactor * 12), MyRect.Top + 10);
    g.Canvas.MoveTo(iPos + (iFactor * 13), MyRect.Top + 6);
    g.Canvas.LineTo(iPos + (iFactor * 13), MyRect.Top + 9);
    g.Canvas.MoveTo(iPos + (iFactor * 14), MyRect.Top + 5);
    g.Canvas.LineTo(iPos + (iFactor * 14), MyRect.Top + 8);
    g.Canvas.MoveTo(iPos + (iFactor * 15), MyRect.Top + 4);
    g.Canvas.LineTo(iPos + (iFactor * 15), MyRect.Top + 7);
    g.Canvas.MoveTo(iPos + (iFactor * 16), MyRect.Top + 3);
    g.Canvas.LineTo(iPos + (iFactor * 16), MyRect.Top + 6);
  end;
end;

procedure TManageMember.dtpickDOBChange(Sender: TObject);
begin
  if Assigned(ManageMemberData) and (ManageMemberData.qryMember.Active) then
  begin
    if (ManageMemberData.qryMember.State <> dsEdit) then
      ManageMemberData.qryMember.Edit();
    ManageMemberData.qryMember.FieldByName('DOB').AsDateTime := dtpickDOB.Date;
    // let user perform manual post
    // ManageMemberData.qryMember.Post();
  end;
end;

function TManageMember.FindMember(MemberID: Integer): Boolean;
var
  b: Boolean;
  s: string;
  rtn: TModalResult;
begin
  result := false;
  b := ManageMemberData.LocateMember(MemberID);
  if b then
    result := true
  else
  begin
    s := 'Filters must to be cleared to display this member.' + sLineBreak +
      'Clear the filters?';
    rtn := MessageDlg(s, TMsgDlgType.mtConfirmation, mbYesNo, 0);
    if IsPositiveResult(rtn) then
    begin
      ClearAllFilters;
      b := ManageMemberData.LocateMember(MemberID);
      if b then
        result := true;
    end;
  end;
end;

procedure TManageMember.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Test database state
  if Assigned(ManageMemberData) and (ManageMemberData.qryMember.Active) then
  begin
    if (ManageMemberData.qryMember.State = dsEdit) or
      (ManageMemberData.qryMember.State = dsInsert) then
      ManageMemberData.qryMember.Post();
  end;
end;

procedure TManageMember.FormCreate(Sender: TObject);
var
  css: TCustomStyleServices;

begin
  // ----------------------------------------------------
  // R E G I S T E R   W I N D O W S   M E S S A G E S  .
  // var defined in winMsgDef.pas
  // ----------------------------------------------------
  // WM_SCMAFTERSCOLL := RegisterWindowMessage('WM_SCMAFTERSCOLL');
  // WM_SCMREQUERY := RegisterWindowMessage('WM_SCMREQUERY');
  // Application.OnMessage := HandleMessage;

  // ----------------------------------------------------
  // I N I T I A L I Z E   P A R A M S .
  // ----------------------------------------------------
  fSwimClubID := 1;

  // Special color assignment - used in TDBGrid painting...
  // -------------------------------------------
  css := TStyleManager.Style[TStyleManager.ActiveStyle.Name];
  if Assigned(css) then
  begin
    fColorEditBoxFocused := css.GetStyleFontColor(sfEditBoxTextFocused);
    fColorEditBoxNormal := css.GetStyleFontColor(sfEditBoxTextNormal);
    fColorBgColor := css.GetStyleColor(scGrid);
  end
  else
  begin
    fColorEditBoxFocused := clWebTomato;
    fColorEditBoxNormal := clWindowText;
    fColorBgColor := clAppWorkSpace;
  end;

  // Display tabsheet
  PageControl1.TabIndex := 0;

end;

procedure TManageMember.FormDestroy(Sender: TObject);
begin
  WritePreferences;
end;

procedure TManageMember.FormShow(Sender: TObject);
begin
  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // ----------------------------------------------------
  // Note: Don't read preferences OnCreate.
  // Forces requery of qryMember as checkbox states are changed.
  ReadPreferences;

  // ----------------------------------------------------
  // D I S P L A Y   F O R M   C A P T I O N   I N F O .
  // ----------------------------------------------------
  if not AssertConnection then
    exit;
  Self.Caption := 'Manage SwimClubMeet Members - ' +
    ManageMemberData.qrySwimClub.FieldByName('DetailStr').AsString;
end;

procedure TManageMember.ManageMemberAfterScroll(var Msg: TMessage);
begin
  if not AssertConnection then
    exit;
  // DATE-OF-BIRTH - DATETIME PICKER INIT
  dtpickDOB.Date := ManageMemberData.qryMember.FieldByName('DOB').AsDateTime;

end;

procedure TManageMember.ManageMemberUpdate(var Msg: TMessage);
begin
  if not AssertConnection then
    exit;
  // UPDATE THE NUMBER OF RECORDS.
  lblCount.Caption := IntToStr(ManageMemberData.RecordCount);
end;

procedure TManageMember.MemFile_ExitExecute(Sender: TObject);
begin
  Close();
end;

procedure TManageMember.MemSearch_FindMemberExecute(Sender: TObject);
begin
  btnFindMemberClick(Self);
end;

procedure TManageMember.Onlinehelp1Click(Sender: TObject);
var
  base_URL: string;
begin
  base_URL := 'http://artanemus.github.io/manual/index.htm';
  ShellExecute(0, NIL, PChar(base_URL), NIL, NIL, SW_SHOWNORMAL);

end;

procedure TManageMember.Prepare(AConnection: TFDConnection;
  ASwimClubID, AMemberID: Integer);
begin
  FConnection := AConnection;
  fSwimClubID := ASwimClubID;

  // ----------------------------------------------------
  // C R E A T E   D A T A M O D U L E   S C M .
  // ----------------------------------------------------
  try
    ManageMemberData := TManageMemberData.CreateWithConnection(Self,
      FConnection);
  finally
    // with ManageMemberData created and the essential tables are open then
    // asserting the connection should be true
    if not Assigned(ManageMemberData) then
      raise Exception.Create('Manage Member''s Data Module creation error.');
  end;

  // ----------------------------------------------------
  // Check that ManageMemberData is active .
  // ----------------------------------------------------
  ManageMemberData.ActivateTable;
  if not ManageMemberData.ManageMemberDataActive then
  begin
    MessageDlg('An error occurred during MSSQL table activation.' + sLineBreak +
      'The database''s schema may need updating.' + sLineBreak +
      'The application will terminate!', mtError, [mbOk], 0);
    raise Exception.Create('ManageMemberData Member not active.');
  end;

  // execute SQL. Make all null IsArchived, IsActive, IsSwimmer = 0;
  //  ManageMemberData.FixNullBooleans;

  // ----------------------------------------------------
  // Prepares all core queries  (Master+Child)
  // ----------------------------------------------------
  ManageMemberData.UpdateMember(fSwimClubID, chkbHideArchived.Checked,
    chkbHideInActive.Checked, chkbHideNonSwimmers.Checked);

  // Cue-to-member
  if AMemberID > 0 then
    FindMember(AMemberID);

end;

procedure TManageMember.ReadPreferences;
var
  ini: TIniFile;
begin
  // C:\Users\<#USERNAME#>\AppData\Roaming\Artanemus\ManageMemberData\ + SCMMEMBERPREF
  ini := TIniFile.Create(GetSCMAppDataDir + INIFILE_SCM_MEMBERPREF);
  try
    chkbHideArchived.Checked := ini.ReadBool(INIFILE_SECTION,
      'HideArchived', true);
    chkbHideInActive.Checked := ini.ReadBool(INIFILE_SECTION,
      'HideInActive', false);
    chkbHideNonSwimmers.Checked := ini.ReadBool(INIFILE_SECTION,
      'HideNonSwimmer', false);
  finally
    ini.Free;
  end;
end;

procedure TManageMember.SCMwebsite1Click(Sender: TObject);
var
  base_URL: string;
begin
  // compiles just fine!
  // ShellExecute(0, 0, L"http://artanemus.github.io", 0, 0, SW_SHOW);

  base_URL := 'http://artanemus.github.io';
  ShellExecute(0, 'open', PChar(base_URL), NIL, NIL, SW_SHOWNORMAL);

end;

procedure TManageMember.WritePreferences;
var
  ini: TIniFile;
begin
  // C:\Users\<#USERNAME#>\AppData\Roaming\Artanemus\ManageMember\ + SCMMEMBERPREF
  ini := TIniFile.Create(GetSCMAppDataDir + INIFILE_SCM_MEMBERPREF);
  try
    ini.WriteBool(INIFILE_SECTION, 'HideArchived', chkbHideArchived.Checked);
    ini.WriteBool(INIFILE_SECTION, 'HideInActive', chkbHideInActive.Checked);
    ini.WriteBool(INIFILE_SECTION, 'HideNonSwimmer',
      chkbHideNonSwimmers.Checked);
  finally
    ini.Free;
  end;
end;

end.
