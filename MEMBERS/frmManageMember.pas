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
  Vcl.ToolWin, Vcl.ActnCtrls, Vcl.ActnMenus, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, Vcl.VirtualImage, SCMHelpers,
  Vcl.ButtonGroup, dlgMemberFilter, VCLTee.TeeData;

type
  TManageMember = class(TForm)
    ActnManagerMember: TActionManager;
    ActnMemberMenuBar: TActionMainMenuBar;
    btnClearGender: TButton;
    btnClearHouse: TButton;
    btnClubMembersDetailed: TButton;
    btnClubMembersList: TButton;
    btnClubMembersSummary: TButton;
    btnFindMember: TButton;
    btnGotoMemberID: TButton;
    btnGotoMembership: TButton;
    btnMemberDetail: TButton;
    btnMemberHistory: TButton;
    DBchkIsActive: TDBCheckBox;
    DBchkIsArchived: TDBCheckBox;
    DBchkIsSwimmer: TDBCheckBox;
    DBContactNumNavigator: TDBNavigator;
    DBEdtEmail: TDBEdit;
    DBedtFirstName: TDBEdit;
    DBedtLastName: TDBEdit;
    DBedtMembershipNum: TDBEdit;
    DBGrid3: TDBGrid;
    DBgridContactInfo: TDBGrid;
    DBgridHistoryPB: TDBGrid;
    DBGridRole: TDBGrid;
    dblblMemberID: TDBText;
    DBlucboGender: TDBLookupComboBox;
    DBlucboHouse: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    ImageCollectMember: TImageCollection;
    Label1: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MemFile_AutoEdit: TAction;
    MemFile_Exit: TAction;
    MemSearch_FindMember: TAction;
    MemSearch_GotoMemberID: TAction;
    MemSearch_GotoMembershipNum: TAction;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel7: TPanel;
    RegistrationNum: TDBEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    VirtlImageListMember: TVirtualImageList;
    BalloonHint1: TBalloonHint;
    btnInfoRoles: TVirtualImage;
    btnInfoContact: TVirtualImage;
    btnClearDOB: TButton;
    lblMembersAge: TLabel;
    TabSheet4: TTabSheet;
    btnDOBPicker: TButton;
    BTNImageList32x32: TVirtualImageList;
    DBedtDOB: TDBEdit;
    Label11: TLabel;
    btnInfoDateTime: TVirtualImage;
    Label15: TLabel;
    btnFilter: TButton;
    actnFilter: TAction;
    btnInfoFilter: TVirtualImage;
    Label25: TLabel;
    Label26: TLabel;
    DBGrid1: TDBGrid;
    DBTextFullName: TDBText;
    TabSheet5: TTabSheet;
    Panel2: TPanel;
    cmboDistance: TComboBox;
    cmboStroke: TComboBox;
    Label27: TLabel;
    Label28: TLabel;
    DBChart1: TDBChart;
    Series2: TLineSeries;
    chkbDoCurrSeason: TCheckBox;
    btmPrintChart: TButton;
    procedure About2Click(Sender: TObject);
    procedure actnFilterExecute(Sender: TObject);
    procedure btmPrintChartClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnClearDOBClick(Sender: TObject);
    procedure btnClubMembersDetailedClick(Sender: TObject);
    procedure btnClubMembersListClick(Sender: TObject);
    procedure btnClubMembersSummaryClick(Sender: TObject);
    procedure btnDOBPickerClick(Sender: TObject);
    procedure btnFindMemberClick(Sender: TObject);
    procedure btnGotoMemberIDClick(Sender: TObject);
    procedure btnGotoMembershipClick(Sender: TObject);
    procedure btnInfoContactClick(Sender: TObject);
    procedure btnInfoDateTimeClick(Sender: TObject);
    procedure btnInfoFilterClick(Sender: TObject);
    procedure btnInfoRolesClick(Sender: TObject);
    procedure btnInfoMouseLeave(Sender: TObject);
    procedure btnMemberDetailClick(Sender: TObject);
    procedure btnMemberHistoryClick(Sender: TObject);
    procedure chkbDoCurrSeasonClick(Sender: TObject);
    procedure cmboDistanceChange(Sender: TObject);
    procedure cmboStrokeChange(Sender: TObject);
    procedure DBChart1GetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
        ValueIndex: Integer; var LabelText: string);
    procedure DBChart1GetLegendText(Sender: TCustomAxisPanel; LegendStyle:
        TLegendStyle; Index: Integer; var LegendText: string);
    procedure DBGridCellClick(Column: TColumn);
    procedure DBGridColEnter(Sender: TObject);
    procedure DBGridColExit(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridEditButtonClick(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridRoleCellClick(Column: TColumn);
    procedure DBGridRoleEditButtonClick(Sender: TObject);
    procedure DBGridGenericKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MemFile_ExitExecute(Sender: TObject);
    procedure MemSearch_FindMemberExecute(Sender: TObject);
    procedure Onlinehelp1Click(Sender: TObject);
    procedure SCMwebsite1Click(Sender: TObject);
  private
    { Private declarations }
    fColorBgColor: TColor;
    fColorEditBoxFocused: TColor;
    fColorEditBoxNormal: TColor;
    FConnection: TFDConnection;
    fSwimClubID: Integer;
    // Used to convert DATETIME and then post TMessage to Member DataModule.
    fSystemTime: TSystemTime;
    fHideArchived: Boolean;
    fHideInActive: Boolean;
    fHideNonSwimmer: Boolean;

    fFilterDlg: TMemberFilter;

    function AssertConnection: Boolean;
    function FindMember(MemberID: Integer): Boolean;
    function GetMembersAge(aMemberID: Integer; aDate: TDate): Integer;
    procedure ReadPreferences(aIniFileName: string);
    procedure WritePreferences();
    procedure UpdateFilterCount();
    procedure UpdateMembersAge();
    procedure UpdateChart();
    procedure ChartReport();


  protected
    // windows messages ....
    procedure ManageMemberAfterScroll(var Msg: TMessage);
      message SCM_AFTERSCROLL;
    procedure ManageMemberAfterPost(var Msg: TMessage);
      message SCM_AFTERPOST;
    procedure FilterDlgUpdated(var Msg: TMessage); message SCM_FILTERUPDATED;
    procedure FilterDlgDeactivated(var Msg: TMessage);
      message SCM_FILTERDEACTIVATED;

  public
    { Public declarations }
    procedure Prepare(AConnection: TFDConnection; ASwimClubID: Integer = 1;
      aMemberID: Integer = 0);
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
  System.IOUtils, Winapi.ShellAPI, dlgDeleteMember, Vcl.Themes, rptMemberDetail,
  rptMemberHistory, rptMembersList, rptMembersDetail, rptMembersSummary,
  System.DateUtils, rptMemberChart;

procedure TManageMember.About2Click(Sender: TObject);
var
  dlg: TAbout;
begin
  dlg := TAbout.Create(Self);
  dlg.ShowModal;
  FreeAndNil(dlg);
end;

procedure TManageMember.actnFilterExecute(Sender: TObject);
var
  aRect: TRect;
begin
  // double tap on btnFilter

  if assigned(fFilterDlg) then
  begin
    FreeAndNil(fFilterDlg);
    exit;
  end;

  WritePreferences;

  fFilterDlg := TMemberFilter.Create(Self);
  fFilterDlg.Position := poDesigned;
  aRect := btnFilter.ClientToScreen(btnFilter.ClientRect);
  fFilterDlg.Left := aRect.Left;
  fFilterDlg.Top := aRect.Bottom + 1;
  fFilterDlg.Show;
end;

function TManageMember.AssertConnection: Boolean;
begin
  result := false;
  // test datamodule construction
  if assigned(ManageMemberData) then
  begin
    // IsActive if TFDConnection::scmConnection && FireDAC tables are active
    if ManageMemberData.ManageMemberDataActive then result := true;
  end;
end;

procedure TManageMember.btmPrintChartClick(Sender: TObject);
begin
  ChartReport;
end;

procedure TManageMember.btnClearClick(Sender: TObject);
begin
  if not assigned(ManageMemberData) then exit;
  with ManageMemberData.dsMember.DataSet do
  begin
    if not(Active) then exit;
    if (State <> dsInsert) or (State <> dsEdit) then Edit;
    case TButton(Sender).Tag of
      1: FieldByName('GenderID').Clear();
      3: FieldByName('HouseID').Clear();
    end;
  end;
end;

procedure TManageMember.btnClearDOBClick(Sender: TObject);
begin
  if not assigned(ManageMemberData) then exit;
  with ManageMemberData.dsMember.DataSet do
  begin
    if not(Active) then exit;
    if (State <> dsInsert) or (State <> dsEdit) then Edit;
    FieldByName('DOB').Clear;
  end;
end;

procedure TManageMember.btnClubMembersDetailedClick(Sender: TObject);
var
  rpt: TMembersDetail;
begin
  if not assigned(ManageMemberData) then exit;
  rpt := TMembersDetail.Create(Self);
  rpt.RunReport(FConnection, fSwimClubID);
  rpt.Free;
end;

procedure TManageMember.btnClubMembersListClick(Sender: TObject);
var
  rpt: TMembersList;
begin
  if not assigned(ManageMemberData) then exit;
  rpt := TMembersList.Create(Self);
  rpt.RunReport(FConnection, fSwimClubID);
  rpt.Free;
end;

procedure TManageMember.btnClubMembersSummaryClick(Sender: TObject);
var
  rpt: TMembersSummary;
begin
  if not assigned(ManageMemberData) then exit;
  rpt := TMembersSummary.Create(Self);
  rpt.RunReport(FConnection, fSwimClubID);
  rpt.Free;
end;

procedure TManageMember.btnDOBPickerClick(Sender: TObject);
var
  dlg: TDOBPicker;
  Rect: TRect;
  rtn: TModalResult;
begin
  dlg := TDOBPicker.Create(Self);
  dlg.Position := poDesigned;
  // Assign date to DB Field.
  Rect := btnDOBPicker.ClientToScreen(btnDOBPicker.ClientRect);
  dlg.Left := Rect.Left;
  dlg.Top := Rect.Bottom + 1;
  dlg.CalendarView1.Date := ManageMemberData.dsMember.DataSet.FieldByName('DOB')
    .AsDateTime;
  rtn := dlg.ShowModal;
  if IsPositiveResult(rtn) then
  begin
    with ManageMemberData.dsMember.DataSet do
    begin
      if (State <> dsEdit) or (State <> dsInsert) then
      begin
        Edit;
        FieldByName('DOB').AsDateTime := dlg.CalendarView1.Date;
      end;
    end;
  end;
  dlg.Free;
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
  if assigned(ManageMemberData) then
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
  if assigned(ManageMemberData) then
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

procedure TManageMember.btnInfoContactClick(Sender: TObject);
begin
  BalloonHint1.Title := 'Contact Number.';
  BalloonHint1.Description := 'A contact number must have a contact type.' +
    sLinebreak + 'To clear a selected cell, press ALT-BACKSPACE.'+ sLinebreak +
    'To delete a record, press CTRL-DEL';
  BalloonHint1.ShowHint(btnInfoContact);
end;

procedure TManageMember.btnInfoDateTimeClick(Sender: TObject);
begin
  BalloonHint1.Title := 'Region Date.';
  BalloonHint1.Description := 'SCM uses ''Short Date'' locale format.' +
    sLinebreak +
    'To modify how dates are displayed and the syntax used to enter dates, ' +
    sLinebreak + 'go to the ''Region Settings'' in MS Windows. ';
  BalloonHint1.ShowHint(btnInfoDateTime);
end;

procedure TManageMember.btnInfoFilterClick(Sender: TObject);
begin
  BalloonHint1.Title := 'Filter records.';
  BalloonHint1.Description := 'The number displayed on the filter button' +
    sLinebreak + 'is the number of records found using the ' + sLinebreak +
    'current filter settings.';
  BalloonHint1.ShowHint(btnInfoFilter);
end;

procedure TManageMember.btnInfoRolesClick(Sender: TObject);
begin
  BalloonHint1.Title := 'Membership Roles.';
  BalloonHint1.Description := 'To enter a start or end date, select the cell' +
    sLinebreak + 'and then press the ellipse button.' + sLinebreak +
    'To clear a selected cell, press ALT-BACKSPACE.'+ sLinebreak +
    'To delete a record, press CTRL-DEL';
  BalloonHint1.ShowHint(btnInfoRoles);
end;

procedure TManageMember.btnInfoMouseLeave(Sender: TObject);
begin
  BalloonHint1.HideHint;
end;

procedure TManageMember.btnMemberDetailClick(Sender: TObject);
var
  rpt: TMemberDetail;
  MemberID: Integer;
begin
  if not assigned(ManageMemberData) then exit;
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
  if not assigned(ManageMemberData) then exit;
  MemberID := ManageMemberData.dsMember.DataSet.FieldByName('MemberID')
    .AsInteger;
  rpt := TMemberHistory.Create(Self);
  rpt.RunReport(FConnection, fSwimClubID, MemberID);
  rpt.Free;
end;

procedure TManageMember.ChartReport;
var
aMemberID: integer;
s, s2: string;
rpt: TMemberChart;
begin
	// Distance
	s := cmboDistance.Text;
	// Stroke
	s2 := cmboStroke.Text;
	rpt := TMemberChart.Create(self);
	aMemberID := ManageMemberData.dsMember.DataSet.FieldByName('MemberID').AsInteger;
	// params ... SwimClubID, MemberID
	rpt.RunReport(aMemberID, DBChart1, s, s2);
	rpt.free;
end;

procedure TManageMember.chkbDoCurrSeasonClick(Sender: TObject);
begin
  UpdateChart;
end;

procedure TManageMember.cmboDistanceChange(Sender: TObject);
begin
  UpdateChart;
end;

procedure TManageMember.cmboStrokeChange(Sender: TObject);
begin
  UpdateChart;
end;

procedure TManageMember.DBChart1GetAxisLabel(Sender: TChartAxis; Series:
    TChartSeries; ValueIndex: Integer; var LabelText: string);
begin
(*

  	TFDQuery *qry;
  	TDateTime dt;
  	TLocateOptions SearchOptions;
  	Variant v[1]; // VarArray
  	bool Success;
  	// replace axis label with session date
  	if (Sender == DBChart1->BottomAxis) {
  		if (Series != nullptr) {
  			if (Series->DataSource != nullptr) {
  				qry = reinterpret_cast<TFDQuery*>(Series->DataSource);
  				if (qry->Active == true) {
  					v[0] = Variant((ValueIndex + 1));
  					SearchOptions.Clear();
  					Success = qry->Locate("ChartX", VarArrayOf(v, 0),
  						SearchOptions);
  					if (Success) {
  						dt = qry->FieldByName("SessionStart")->AsDateTime;
  						LabelText = dt.DateString();
  					}
  					else {
  						LabelText = "ERR";
  					}
  				}
  			}
  		}
  	}

*)
end;

procedure TManageMember.DBChart1GetLegendText(Sender: TCustomAxisPanel;
    LegendStyle: TLegendStyle; Index: Integer; var LegendText: string);
var
s: string;
 LFormatSettings: TFormatSettings;
begin
  if not AssertConnection then exit;
  LFormatSettings := TFormatSettings.Create;
  ManageMemberData.LocateChart((Index+1));
  s := FormatDateTime(LFormatSettings.ShortDateFormat,
    ManageMemberData.dsChart.DataSet.FieldByName('SessionStart').AsDateTime,
     LFormatSettings) ;
  LegendText :=
    ManageMemberData.dsChart.DataSet.FieldByName('RaceTimeAsString').AsString
    + '  ' +  s;
end;

procedure TManageMember.DBGridCellClick(Column: TColumn);
begin
  if assigned(Column.Field) and (Column.Field.DataType = ftBoolean) then
  begin
    Column.Grid.DataSource.DataSet.CheckBrowseMode;
    Column.Grid.DataSource.DataSet.Edit;
    Column.Field.AsBoolean := not Column.Field.AsBoolean;
  end;
  if assigned(Column.Field) and (Column.Field.FieldKind = fkLookup) then
  begin
    Column.Grid.DataSource.DataSet.CheckBrowseMode;
    Column.Grid.DataSource.DataSet.Edit;
  end;
end;

procedure TManageMember.DBGridColEnter(Sender: TObject);
begin
  // By default, two clicks on the same cell enacts the cell editing mode.
  // The grid draws a TEditBox over the cell, killing the checkbox draw UI.
  with Sender as TDBGrid do
  begin
    if assigned(SelectedField) and (SelectedField.DataType = ftBoolean) then
    begin
      Options := Options - [dgEditing];
    end;
  end;
end;

procedure TManageMember.DBGridColExit(Sender: TObject);
begin
  with Sender as TDBGrid do
    if assigned(SelectedField) and (SelectedField.DataType = ftBoolean) then
        Options := Options + [dgEditing];
end;

procedure TManageMember.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  clFont, clBg: TColor;
begin
  // NOTE: DEFAULT DRAWING IS DISABLED ....
  // NOTE: DO NOT ENABLE TDBGRID OPTION dgAlwaysShowEditor.
  // (inconsistent OS MESSAGING)
  if (Column.Field.FieldName = 'IsActive') or
    (Column.Field.FieldName = 'IsArchived') or
    (Column.Field.FieldName = 'IsSwimmer') then
  begin
    if gdFocused in State then clFont := fColorEditBoxFocused
    else clFont := fColorEditBoxNormal;
    clBg := fColorBgColor;
    TDBGrid(Sender).DrawCheckBoxes(Sender, Rect, Column, clFont, clBg);
    // draw 'Focused' frame  (for boolean datatype only)
    if gdFocused in State then TDBGrid(Sender).Canvas.DrawFocusRect(Rect);
  end
  else
  begin
    TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then TDBGrid(Sender).Canvas.DrawFocusRect(Rect);
  end;
end;

procedure TManageMember.DBGridEditButtonClick(Sender: TObject);
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

procedure TManageMember.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  fld: TField;
begin

  With Sender as TDBGrid do
  begin
    if assigned(SelectedField) then
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

procedure TManageMember.DBGridRoleCellClick(Column: TColumn);
var
  fld: TField;
begin
  if assigned(Column.Field) and (Column.Field.DataType = ftBoolean) then
  begin
    fld := DBGridRole.DataSource.DataSet.FindField('MemberID');
    if fld.IsNull then exit;
    if Column.Grid.DataSource.DataSet.State <> dsEdit then
        Column.Grid.DataSource.DataSet.Edit;

    // Column.Grid.DataSource.DataSet.CheckBrowseMode;
    // Column.Grid.DataSource.DataSet.Edit;
    Column.Field.AsBoolean := not Column.Field.AsBoolean;
  end;

  if assigned(Column.Field) and (Column.Field.FieldKind = fkLookup) then
  begin
    if Column.Grid.DataSource.DataSet.State <> dsEdit then
        Column.Grid.DataSource.DataSet.Edit;
    // Column.Grid.DataSource.DataSet.CheckBrowseMode;
    // Column.Grid.DataSource.DataSet.Edit;
  end;
end;

procedure TManageMember.DBGridRoleEditButtonClick(Sender: TObject);
var
  fld: TField;
  dlg: TDOBPicker;
  mrRtn: TModalResult;
begin
  // handle the ellipse button for TDateTime entry...
  fld := TDBGrid(Sender).SelectedField;
  if not assigned(fld) then exit;
  if (fld.FieldName = 'ElectedOn') OR (fld.FieldName = 'RetiredOn') then
  begin
    dlg := TDOBPicker.Create(Self);
    mrRtn := dlg.ShowModal; // open DATE PICKER ...
    if (mrRtn = mrOk) then
    begin
      DateTimeToSystemTime(dlg.CalendarView1.Date, fSystemTime);
      if (fld.FieldName = 'ElectedOn') then
          PostMessage(ManageMemberData.Handle, SCM_ELECTEDONUPDATED,
          longint(@fSystemTime), 0)
      else PostMessage(ManageMemberData.Handle, SCM_RETIREDONUPDATED,
          longint(@fSystemTime), 0);
    end;
    dlg.Free;
  end;
end;

procedure TManageMember.DBGridGenericKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  fld: TField;
begin
  if (Key = VK_BACK) and (ssAlt in Shift) then
  BEGIN
    with Sender as TDBGrid do
    Begin
      DataSource.DataSet.DisableControls;
      fld := TDBGrid(Sender).SelectedField;
      if assigned(fld) then
      BEGIN
        // if the query is not in edit mode
        if (DataSource.DataSet.State <> dsEdit) or
          (DataSource.DataSet.State <> dsInsert) then DataSource.DataSet.Edit;
        // D B G r i d R o l e  ...
        if (fld.FieldName = 'ElectedOn') or (fld.FieldName = 'RetiredOn') then
            fld.Clear;
        // D B G r i d C o n t a c t I n f o ...
        if (fld.FieldName = 'luContactNumType') then fld.Clear;
      end;
      DataSource.DataSet.EnableControls;
      // signal finished with key;
      Key := 0;
    END;
  END;
end;

procedure TManageMember.DBNavigator1BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
var
  dlg: TDeleteMember;
  FName, s: string;
  ID: Integer;
  fDoDelete: boolean;
begin
  fDoDelete := false;
  if Button = nbDelete then
  begin
    dlg := TDeleteMember.Create(Self);
    // get the fullname of the member to delete
    FName := ManageMemberData.dsMember.DataSet.FieldByName('FName').AsString;
    ID := ManageMemberData.dsMember.DataSet.FieldByName('MemberID').AsInteger;
    s := IntToStr(ID);
    dlg.lblTitle.Caption := 'Delete (ID: ' + s + ') ' + FName +
      ' from the SwimClubMeet database ?';
    // display the confirm delete dlg
    if IsPositiveResult(dlg.ShowModal) then
      fDoDelete := true;
    dlg.Free;
    if not fDoDelete then
      // raises a silent exception - cancelling the action.
      Abort;
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
  if b then result := true
  else
  begin
    s := 'Filters must to be cleared to display this member.' + sLinebreak +
      'Clear the filters?';
    rtn := MessageDlg(s, TMsgDlgType.mtConfirmation, mbYesNo, 0);
    if IsPositiveResult(rtn) then
    begin
      fHideArchived := false;
      fHideInActive := false;
      fHideNonSwimmer := false;

      b := ManageMemberData.LocateMember(MemberID);
      if b then result := true;
    end;
  end;
end;

procedure TManageMember.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Test database state
  if assigned(ManageMemberData) and (ManageMemberData.qryMember.Active) then
  begin
    if (ManageMemberData.qryMember.State = dsEdit) or
      (ManageMemberData.qryMember.State = dsInsert) then
        ManageMemberData.qryMember.Post();
  end;
end;

procedure TManageMember.FormCreate(Sender: TObject);
var
  css: TCustomStyleServices;
  LFormatSettings: TFormatSettings;
begin
  // ----------------------------------------------------
  // I N I T I A L I Z E   P A R A M S .
  // ----------------------------------------------------
  fSwimClubID := 1;
  fHideArchived := false;
  fHideInActive := false;
  fHideNonSwimmer := false;
  fFilterDlg := nil;

  // Special color assignment - used in TDBGrid painting...
  // -------------------------------------------
  css := TStyleManager.Style[TStyleManager.ActiveStyle.Name];
  if assigned(css) then
  begin
    fColorEditBoxFocused := css.GetStyleFontColor(sfEditBoxTextFocused);
    fColorEditBoxNormal := css.GetStyleFontColor(sfEditBoxTextNormal);
    fColorBgColor := css.GetStyleColor(scGrid);
  end
  else
  begin
    fColorEditBoxFocused := cardinal(clWebTomato);   // TColors.Tomato;
    fColorEditBoxNormal := cardinal(clWindowText);   //TColors.SysWindowText;
    fColorBgColor := cardinal(clAppWorkSpace);  // TColors.SysAppWorkSpace;
  end;

  // Display tabsheet
  PageControl1.TabIndex := 0;
  LFormatSettings := TFormatSettings.Create;
  Label11.Caption := 'Date Syntax : ' + LFormatSettings.ShortDateFormat;



end;

procedure TManageMember.FormDestroy(Sender: TObject);
begin
  WritePreferences;
  if assigned(fFilterDlg) then fFilterDlg.Free;
end;

procedure TManageMember.FormShow(Sender: TObject);
var
  iniFileName: string;
begin
  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // ----------------------------------------------------
  iniFileName := SCMUtility.GetSCMPreferenceFileName;
  ReadPreferences(iniFileName);
  if not AssertConnection then exit;

  // run filter
  ManageMemberData.UpdateMember(fSwimClubID, fHideArchived, fHideInActive,
    fHideNonSwimmer);
  UpdateFilterCount;

  // display record count
  actnFilter.Caption := 'Filter (' +
    IntToStr(ManageMemberData.RecordCount) + ')';
end;

procedure TManageMember.FilterDlgDeactivated(var Msg: TMessage);
begin
  if assigned(fFilterDlg) then FreeAndNil(fFilterDlg);
end;

function TManageMember.GetMembersAge(aMemberID: Integer; aDate: TDate): Integer;
var
  SQL: string;
  v: Variant;
  dt: TDateTime;
begin
  result := 0;
  if not AssertConnection then exit;
  with ManageMemberData.dsMember.DataSet do
  begin
    if not Active or IsEmpty then exit;
    if FieldByName('DOB').IsNull then exit;
    dt := FieldByName('DOB').AsDateTime;
    SQL := 'SELECT dbo.SwimmerAge(GETDATE(), :ID1) AS SwimmerAge FROM ' +
      '[SwimClubMeet].[dbo].[Member] WHERE MemberID = :ID2';
    v := FConnection.ExecSQLScalar(SQL, [dt, aMemberID],
      [ftDateTime, ftInteger]);
    if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then result := v;
  end;
end;


procedure TManageMember.ReadPreferences(aIniFileName: string);
var
  i: Integer;
  iFile: TIniFile;
begin
  // ---------------------------------------------------------
  // A S S I G N   MANAGEMEMBER  P R E F E R E N C E S ...
  // ---------------------------------------------------------
  if not FileExists(aIniFileName) then exit;
  iFile := TIniFile.Create(aIniFileName);
  fHideArchived := iFile.ReadBool(INIFILE_SECTION, 'HideArchived', true);
  fHideInActive := iFile.ReadBool(INIFILE_SECTION, 'HideInActive', false);
  fHideNonSwimmer := iFile.ReadBool(INIFILE_SECTION, 'HideNonSwimmer', false);
  // 2024.03.18
  i := iFile.ReadInteger('ManageMember', 'cmboDistanceItemIndex', 0);
  if i < cmboDistance.Items.Count then cmboDistance.ItemIndex := i;
  i := iFile.ReadInteger('ManageMember', 'cmboStrokeItemIndex', 0);
  if i < cmboStroke.Items.Count then cmboStroke.ItemIndex := i;
  chkbDoCurrSeason.Checked := iFile.ReadBool('ManageMember',
    'chkbDoCurrSeason', false);
  iFile.Free;
end;

procedure TManageMember.ManageMemberAfterPost(var Msg: TMessage);
begin
  UpdateMembersAge;
end;

procedure TManageMember.ManageMemberAfterScroll(var Msg: TMessage);

begin
  UpdateMembersAge;
  UpdateChart;
end;

procedure TManageMember.FilterDlgUpdated(var Msg: TMessage);
var
  CopyData: PCopyDataStruct;
  FilterState: PFilterState;
begin
  if Msg.LParam = 0 then exit;
  try
    begin
      CopyData := PCopyDataStruct(Msg.LParam);
      FilterState := PFilterState(CopyData^.lpData);
      // access the fields of the record
      fHideArchived := FilterState^.HideArchived;
      fHideInActive := FilterState^.HideInActive;
      fHideNonSwimmer := FilterState^.HideNonSwimmer;
    end
  finally
    begin
      ManageMemberData.UpdateMember(fSwimClubID, fHideArchived, fHideInActive,
        fHideNonSwimmer);

      actnFilter.Caption := 'Filter (' +
        IntToStr(ManageMemberData.RecordCount) + ')';
    end;
  end;

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
  ASwimClubID, aMemberID: Integer);
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
    if not assigned(ManageMemberData) then
        raise Exception.Create('Manage Member''s Data Module creation error.');
  end;

  // ----------------------------------------------------
  // Check that ManageMemberData is active .
  // ----------------------------------------------------
  ManageMemberData.ActivateTable;
  if not ManageMemberData.ManageMemberDataActive then
  begin
    MessageDlg('An error occurred during MSSQL table activation.' + sLinebreak +
      'The database''s schema may need updating.' + sLinebreak +
      'The application will terminate!', mtError, [mbOk], 0);
    raise Exception.Create('ManageMemberData Member not active.');
  end;
  // ----------------------------------------------------
  // Prepares all core queries  (Master+Child)
  // ----------------------------------------------------
  PostMessage(Handle, SCM_UPDATE, 0, 0);

  // Cue-to-member
  if aMemberID > 0 then FindMember(aMemberID);

  // prepare comboboxes - distance and stroke

  if ManageMemberData.ManageMemberDataActive then
  begin
    ManageMemberData.tblDistance.First;
    cmboDistance.Items.Clear;
    while not ManageMemberData.tblDistance.eof and (ManageMemberData.tblDistance.FieldByName('EventTypeID').AsInteger = 1) do
    begin
      cmboDistance.Items.Add(ManageMemberData.tblDistance.FieldByName('Caption').AsString) ;
      ManageMemberData.tblDistance.next;
    end;
    cmboDistance.ItemIndex := 0;

    ManageMemberData.tblStroke.First;
    cmboStroke.Items.Clear;
    while not ManageMemberData.tblStroke.eof do
    begin
      cmboStroke.Items.Add(ManageMemberData.tblStroke.FieldByName('Caption').AsString) ;
      ManageMemberData.tblStroke.next;
    end;
    cmboStroke.ItemIndex := 0;
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

procedure TManageMember.UpdateChart;
var
  d, s: Integer;
  docurrseason: Boolean;
  str: string;
begin
  // Gather UI state
  if not AssertConnection then exit;
  if cmboDistance.ItemIndex <> -1 then d := cmboDistance.ItemIndex + 1
  else d := 1;
  if cmboStroke.ItemIndex <> -1 then s := cmboStroke.ItemIndex + 1
  else s := 1;
  if chkbDoCurrSeason.Checked then docurrseason := true
  else docurrseason := false;
  // Requery FireDAC Chart
  ManageMemberData.UpdateChart(0, d, s, docurrseason);
  // Chart title
  DBChart1.Title.Text.Clear;
  str := ManageMemberData.dsMember.DataSet.FieldByName('FName').AsString;
  str := str + ' ' +cmboDistance.Text + ' ' + cmboStroke.Text;
  if docurrseason then
    str := str + ' - Start of season '
      + ManageMemberData.dsSwimClub.DataSet.FieldByName('StartOfSwimSeason').AsString
  else
    str := str + ' - (Max 26 events)';
  DBChart1.Title.Text.Add(str);
  // Reload chart data
  DBChart1.RefreshData;
end;

procedure TManageMember.UpdateFilterCount;
begin
  if not AssertConnection then exit;
  // display record count
  actnFilter.Caption := 'Filter (' +
    IntToStr(ManageMemberData.RecordCount) + ')';
end;

procedure TManageMember.UpdateMembersAge;
var
  dt: TDate;
  age: Integer;
begin
  lblMembersAge.Caption := '';
  if not AssertConnection then exit;
  with ManageMemberData.dsMember.DataSet do
  BEGIN // calculate the age of the member
    if not Active or IsEmpty then exit;
    if FieldByName('MemberID').IsNull then exit;
    if FieldByName('DOB').IsNull then exit;
    dt := FieldByName('DOB').AsDateTime;
    if (dt <= 0) then exit;
    age := GetMembersAge(FieldByName('MemberID').AsInteger, dt);
    if (age <= 0) then exit;
    lblMembersAge.Caption := IntToStr(age);
  END;
end;

procedure TManageMember.WritePreferences;
var
  iFile: TIniFile;
  iniFileName: string;
begin
  iniFileName := SCMUtility.GetSCMPreferenceFileName;
  if not FileExists(iniFileName) then exit;
  iFile := TIniFile.Create(iniFileName);
  iFile.WriteBool(INIFILE_SECTION, 'HideArchived', fHideArchived);
  iFile.WriteBool(INIFILE_SECTION, 'HideInActive', fHideInActive);
  iFile.WriteBool(INIFILE_SECTION, 'HideNonSwimmer', fHideNonSwimmer);

  // 2024 03 18
  if (cmboDistance.ItemIndex > -1) then
    iFile.WriteInteger('ManageMember', 'cmboDistanceItemIndex', cmboDistance.ItemIndex);

  if (cmboStroke.ItemIndex > -1) then
    iFile.WriteInteger('ManageMember', 'cmboStrokeItemIndex', cmboStroke.ItemIndex);

  iFile.WriteBool('ManageMember',  'chkbDoCurrSeason', chkbDoCurrSeason.Checked);

  iFile.Free;
end;

end.
