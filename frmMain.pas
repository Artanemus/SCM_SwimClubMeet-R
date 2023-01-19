unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ActnList, System.ImageList,
  Vcl.ImgList, Vcl.Menus, System.Actions, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.CheckLst, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, System.Contnrs, dlgBootProgress,
  SCMDefines, Vcl.VirtualImage, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.WinXCtrls, Vcl.ControlList, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Vcl.Bind.ControlList, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope;

type

  TMain = class(TForm)
    dbtxtSwimClubCaption: TDBText;
    dbtxtSwimClubNickName: TDBText;
    sbtnRefresh: TSpeedButton;
    sbtnMembers: TSpeedButton;
    pnlDebugInfo: TPanel;
    dbtxtDebugEntrant: TDBText;
    dbtxtDebugSwimClub: TDBText;
    dbtxtDebugSession: TDBText;
    dbtxtDebugEvent: TDBText;
    dbtxtDebugHeat: TDBText;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    dbtxtDebugMember: TDBText;
    Label2: TLabel;
    dbtxtDebugNominee: TDBText;
    pnlPageControl: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    pnlSessionLeft: TPanel;
    spbtnSessionToggleLock: TSpeedButton;
    spbtnSessionNew: TSpeedButton;
    spbtnSessionDelete: TSpeedButton;
    spbtnSessionReport: TSpeedButton;
    ShapeSessBar2: TShape;
    ShapeSessDot1: TShape;
    spbtnSessionToggleVisible: TSpeedButton;
    ShapeSessBar1: TShape;
    pnlSessLeftTop: TPanel;
    lblSessionCaption: TLabel;
    Session_Grid: TDBGrid;
    pnlSessionClient: TPanel;
    pnlSessClientTop: TPanel;
    lblSessionEventCaption: TLabel;
    Panel7: TPanel;
    Event_Grid: TDBGrid;
    spbtnEventMoveUp: TSpeedButton;
    spbtnEventMoveDown: TSpeedButton;
    spbtnEventNew: TSpeedButton;
    spbtnEventDelete: TSpeedButton;
    spbtnEventReport: TSpeedButton;
    ShapeDotEv1: TShape;
    ShapeBarEv2: TShape;
    ShapeBarEv1: TShape;
    spbtnEventToggleGridView: TSpeedButton;
    TabSheet2: TTabSheet;
    lblNomWarning: TLabel;
    spbtnNominateSortMember: TSpeedButton;
    spbtnNominateReport: TSpeedButton;
    ShapeNomDot1: TShape;
    ShapeNomBar1: TShape;
    Nominate_Grid: TDBGrid;
    Nominate_Edit: TEdit;
    TabSheet3: TTabSheet;
    spbtnHeatToggleStatus: TSpeedButton;
    spbtnHeatDown: TSpeedButton;
    spbtnHeatUp: TSpeedButton;
    spbtnHeatAutoBuild: TSpeedButton;
    spbtnHeatMarshall: TSpeedButton;
    spbtnHeatTimeKeeper: TSpeedButton;
    spbtnHeatBatchPrintSet: TSpeedButton;
    ShapeHeatBar2: TShape;
    ShapeHeatBar3: TShape;
    ShapeHeatBar1: TShape;
    spbtnHeatNew: TSpeedButton;
    spbtnHeatDelete: TSpeedButton;
    spbtnHeatReport: TSpeedButton;
    spbtnEntrantUp: TSpeedButton;
    spbtnEntrantDown: TSpeedButton;
    ShapeHeatDot3: TShape;
    ShapeHeatDot2: TShape;
    ShapeHeatDot1: TShape;
    spbtnEntrantSwapLanes: TSpeedButton;
    spbtnEntrantEmptyLane: TSpeedButton;
    spbtnEntrantScratchLane: TSpeedButton;
    Entrant_Grid: TDBGrid;
    dbnavEventNavigatePrior: TDBNavigator;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    mnuImportXLS: TMenuItem;
    mnuExportXLS: TMenuItem;
    N13: TMenuItem;
    ImportSession2: TMenuItem;
    ExportSession2: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Session1: TMenuItem;
    NewSession2: TMenuItem;
    EditSession2: TMenuItem;
    CloneSession1: TMenuItem;
    DeleteSession2: TMenuItem;
    N3: TMenuItem;
    ToggleStatus2: TMenuItem;
    N14: TMenuItem;
    BuildALLHeats1: TMenuItem;
    BatchPrintALLMarshallReports1: TMenuItem;
    BatchPrintALLTimekeeperReports1: TMenuItem;
    mnuEvents: TMenuItem;
    mnuBuildQuarterFinal: TMenuItem;
    mnuBuildSemiFinal: TMenuItem;
    mnuBuildFinal: TMenuItem;
    N7: TMenuItem;
    mnuMastersChampionships: TMenuItem;
    mnuRelay: TMenuItem;
    mnuNominate: TMenuItem;
    Cleareventsnominations1: TMenuItem;
    Tools1: TMenuItem;
    EventQualificationTimes1: TMenuItem;
    MembershipType1: TMenuItem;
    HouseScore1: TMenuItem;
    Connection1: TMenuItem;
    PlacePoints1: TMenuItem;
    Divisions1: TMenuItem;
    LeaderBoard1: TMenuItem;
    N12: TMenuItem;
    Options1: TMenuItem;
    CleanMSSQL2: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Help_Help: TMenuItem;
    Help_Online: TMenuItem;
    N15: TMenuItem;
    Help_HomePage: TMenuItem;
    ActionManager1: TActionManager;
    Help_About: TAction;
    File_Exit: TAction;
    Session_Sort: TAction;
    Session_Clone: TAction;
    Session_Export: TAction;
    Session_Import: TAction;
    Session_New: TAction;
    Session_Delete: TAction;
    Tools_Preferences: TAction;
    Session_Report: TAction;
    Tools_FDAdministrator: TAction;
    Nominate_Report: TAction;
    Event_MoveUp: TAction;
    Event_MoveDown: TAction;
    Tools_QualifyTimes: TAction;
    Event_Renumber: TAction;
    Entrant_MoveUp: TAction;
    Entrant_MoveDown: TAction;
    Entrant_SwapLanes: TAction;
    Entrant_EmptyLane: TAction;
    Entrant_Strike: TAction;
    Entrant_Sort: TAction;
    Entrant_Renumber: TAction;
    Heat_MoveUp: TAction;
    Heat_MoveDown: TAction;
    Heat_ToggleStatus: TAction;
    Heat_Renumber: TAction;
    Heat_NewRecord: TAction;
    SCM_Refresh: TAction;
    Heat_Delete: TAction;
    Heat_HeatReport: TAction;
    Heat_MarshallReport: TAction;
    Heat_TimeKeeperReport: TAction;
    Heat_AutoBuild: TAction;
    Event_NewRecord: TAction;
    Event_Delete: TAction;
    Event_Report: TAction;
    Event_ToggleGridView: TAction;
    Session_ToggleLock: TAction;
    Nominate_TagQualified: TAction;
    Nominate_SortMembers: TAction;
    Tools_MembershipType: TAction;
    Tools_ConnectionManager: TAction;
    Entrant_GotoMemberDetails: TAction;
    Heat_PrintSet: TAction;
    Tools_House: TAction;
    actnClearNominee: TAction;
    actnClearEventNominations: TAction;
    Tools_CheckDataBase: TAction;
    Event_BuildFinals: TAction;
    Event_BuildSemiFinals: TAction;
    Event_BuildQuarterFinals: TAction;
    Session_BatchBuildHeats: TAction;
    Session_BatchMarshallReport: TAction;
    Session_BatchTimeKeeperReport: TAction;
    Session_Edit: TAction;
    Tools_Score: TAction;
    Tools_Divisions: TAction;
    Tools_LeaderBoard: TAction;
    pumHeat: TPopupMenu;
    MoveUp2: TMenuItem;
    MoveDown2: TMenuItem;
    oggleStatus1: TMenuItem;
    NewRecord1: TMenuItem;
    DeleteHeat1: TMenuItem;
    N6: TMenuItem;
    Marshall1: TMenuItem;
    imeKeeper1: TMenuItem;
    N4: TMenuItem;
    HeatRpt1: TMenuItem;
    pumSession: TPopupMenu;
    DeleteSession1: TMenuItem;
    EditSession1: TMenuItem;
    CloneSession2: TMenuItem;
    NewSession1: TMenuItem;
    N5: TMenuItem;
    Sort1: TMenuItem;
    oggleSessionStatus1: TMenuItem;
    N8: TMenuItem;
    SessionRpt1: TMenuItem;
    pumEntrant: TPopupMenu;
    MoveUp3: TMenuItem;
    MoveDown3: TMenuItem;
    SwapLanes1: TMenuItem;
    EmptyLane1: TMenuItem;
    StrikeEntrant1: TMenuItem;
    Renumber2: TMenuItem;
    N1: TMenuItem;
    GotoMember: TMenuItem;
    pumEvent: TPopupMenu;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    NewEvent1: TMenuItem;
    DeleteEvent1: TMenuItem;
    Renumber1: TMenuItem;
    N9: TMenuItem;
    EventRpt1: TMenuItem;
    N11: TMenuItem;
    pumNominate: TPopupMenu;
    Sort2: TMenuItem;
    Filter1: TMenuItem;
    N10: TMenuItem;
    NominateRpt1: TMenuItem;
    SCM_ManageMembers: TAction;
    Session_ToggleVisible: TAction;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    VirtualImage1: TVirtualImage;
    HeatWidgets: TRelativePanel;
    EntrantWidgets: TRelativePanel;
    SessionWidgets: TRelativePanel;
    EventWidgets: TRelativePanel;
    NominateWidgets: TRelativePanel;
    NominateQuickPick: TRelativePanel;
    Nominate_ControlList: TControlList;
    clistEventDistStrokeStr: TLabel;
    clistEventCaption: TLabel;
    clistCheckBox: TControlListButton;
    vimage: TVirtualImage;
    dbtxtNominateFullName: TDBText;
    VirtualImageList2: TVirtualImageList;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    LinkPropertyToFieldCaption: TLinkPropertyToField;
    NominateBackPanel: TRelativePanel;
    NominateCenteredPanel: TPanel;
    NominateRightPanel: TRelativePanel;
    HeatNavigationPanel: TRelativePanel;
    HeatRightPanel: TPanel;
    HeatLeftPanel: TPanel;
    dbnavEventNavigateNext: TDBNavigator;
    HeatNavigateControlList: TControlList;
    vimgHeatStroke: TVirtualImage;
    lblHeatNavigatorDistance: TLabel;
    dbtxtEventCaption: TDBText;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    LinkPropertyToFieldCaption4: TLinkPropertyToField;
    LinkPropertyToFieldCaption3: TLinkPropertyToField;
    lblHeatNavigatorEventNum: TLabel;
    LinkPropertyToFieldCaption5: TLinkPropertyToField;
    vimgHeatCircle: TVirtualImage;
    lblHeatStrokeStr: TLabel;
    HeatControlList: TControlList;
    vimgHeatNum: TVirtualImage;
    clbtnHeatStatus: TControlListButton;
    Label1: TLabel;
    BindSourceDB3: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB3: TLinkGridToDataSource;
    LinkPropertyToFieldCaption2: TLinkPropertyToField;
    ShapeHeatNavBlackLine: TShape;
    pnlTitleBar: TRelativePanel;
    dbimgSwimClubLogo: TDBImage;
    pnlClubData: TRelativePanel;
    btnClearSearch: TButton;
    VirtualImageList3: TVirtualImageList;
    spbtnEntrantSort: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SCM_RefreshExecute(Sender: TObject);
    procedure Session_CloneExecute(Sender: TObject);
    procedure Session_ReportExecute(Sender: TObject);
    procedure Session_SortExecute(Sender: TObject);
    procedure Session_SortUpdate(Sender: TObject);
    procedure Session_EditUpdate(Sender: TObject);
    procedure Session_NewExecute(Sender: TObject);
    procedure Session_DeleteExecute(Sender: TObject);
    procedure Event_MoveUpExecute(Sender: TObject);
    procedure Event_MoveDownExecute(Sender: TObject);
    procedure Event_RenumberExecute(Sender: TObject);
    procedure Event_GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Event_ReportExecute(Sender: TObject);
    procedure Event_DeleteExecute(Sender: TObject);
    procedure Event_NewRecordExecute(Sender: TObject);
    procedure Event_MoveUpOrDownUpdate(Sender: TObject);
    procedure Event_NewRecordUpdate(Sender: TObject);
    procedure Heat_AutoBuildExecute(Sender: TObject);
    procedure Help_AboutExecute(Sender: TObject);
    procedure File_ExitExecute(Sender: TObject);
    procedure Session_CloneUpdate(Sender: TObject);
    procedure Session_DeleteUpdate(Sender: TObject);
    procedure Tools_PreferencesExecute(Sender: TObject);
    procedure Session_ReportUpdate(Sender: TObject);
    procedure Nominate_ReportExecute(Sender: TObject);
    procedure Tools_QualifyTimesExecute(Sender: TObject);
    procedure Event_RenumberUpdate(Sender: TObject);
    procedure Entrant_MoveUpExecute(Sender: TObject);
    procedure Entrant_EmptyLaneExecute(Sender: TObject);
    procedure Entrant_EmptyLaneUpdate(Sender: TObject);
    procedure Entrant_MoveDownExecute(Sender: TObject);
    procedure Entrant_MoveDownUpdate(Sender: TObject);
    procedure Entrant_MoveUpUpdate(Sender: TObject);
    procedure Entrant_StrikeExecute(Sender: TObject);
    procedure Entrant_StrikeUpdate(Sender: TObject);
    procedure Entrant_SortExecute(Sender: TObject);
    procedure Entrant_SortUpdate(Sender: TObject);
    procedure Event_DeleteUpdate(Sender: TObject);
    procedure Heat_ToggleStatusExecute(Sender: TObject);
    procedure Heat_ToggleStatusUpdate(Sender: TObject);
    procedure Heat_NewRecordExecute(Sender: TObject);
    procedure Heat_NewRecordUpdate(Sender: TObject);
    procedure Heat_DeleteExecute(Sender: TObject);
    procedure Heat_DeleteUpdate(Sender: TObject);
    procedure Heat_AutoBuildUpdate(Sender: TObject);
    procedure Event_ReportUpdate(Sender: TObject);
    procedure Session_ToggleLockExecute(Sender: TObject);
    procedure Session_ToggleLockUpdate(Sender: TObject);
    procedure Nominate_SortMembersExecute(Sender: TObject);
    procedure Nominate_SortMembersUpdate(Sender: TObject);
    procedure Tools_MembershipTypeExecute(Sender: TObject);
    procedure Tools_ConnectionManagerExecute(Sender: TObject);
    procedure SCM_ManageMembersExecute(Sender: TObject);
    procedure SCM_ManageMembersUpdate(Sender: TObject);
    procedure Heat_PrintSetExecute(Sender: TObject);
    procedure Heat_PrintSetUpdate(Sender: TObject);
    procedure Tools_HouseExecute(Sender: TObject);
    procedure Tools_HouseUpdate(Sender: TObject);
    procedure Session_ToggleVisibleExecute(Sender: TObject);
    procedure Session_ToggleVisibleUpdate(Sender: TObject);
    procedure Session_ToggleGridUpdate(Sender: TObject);
    procedure Event_BuildSemiFinalsExecute(Sender: TObject);
    procedure Event_BuildFinalsExecute(Sender: TObject);
    procedure Event_BuildQuarterFinalsExecute(Sender: TObject);
    procedure Event_BuildSCMEventTypeUpdate(Sender: TObject);
    procedure Session_EditExecute(Sender: TObject);
    procedure Tools_ScoreExecute(Sender: TObject);
    procedure Tools_ScoreUpdate(Sender: TObject);
    procedure Tools_DivisionsExecute(Sender: TObject);
    procedure Tools_DivisionsUpdate(Sender: TObject);
    procedure Tools_LeaderBoardExecute(Sender: TObject);
    procedure Tools_LeaderBoardUpdate(Sender: TObject);
    procedure Entrant_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: integer; Column: TColumn; State: TGridDrawState);
    procedure Entrant_GridColEnter(Sender: TObject);
    procedure Entrant_GridColExit(Sender: TObject);
    procedure Entrant_GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Entrant_GridEnter(Sender: TObject);
    procedure Session_BatchBuildHeatsExecute(Sender: TObject);
    procedure Session_BatchBuildHeatsUpdate(Sender: TObject);
    procedure Help_HomePageClick(Sender: TObject);
    procedure Help_OnlineClick(Sender: TObject);
    procedure Help_HelpClick(Sender: TObject);
    procedure Entrant_GridEditButtonClick(Sender: TObject);
    procedure Entrant_GridCellClick(Column: TColumn);
    procedure Nominate_EditChange(Sender: TObject);
    procedure Nominate_GridDblClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: boolean);
    procedure FormShow(Sender: TObject);
    procedure ActionManager1Update(Action: TBasicAction; var Handled: boolean);
    procedure Event_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: integer; Column: TColumn; State: TGridDrawState);
    procedure Session_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: integer; Column: TColumn; State: TGridDrawState);
    procedure Event_ToggleGridViewExecute(Sender: TObject);
    procedure Event_ToggleGridViewUpdate(Sender: TObject);
    procedure Session_BatchMarshallReportExecute(Sender: TObject);
    procedure Session_BatchTimeKeeperReportExecute(Sender: TObject);
    procedure Session_BatchMarshallReportUpdate(Sender: TObject);
    procedure Session_BatchTimeKeeperReportUpdate(Sender: TObject);
    procedure Nominate_ControlListBeforeDrawItem(AIndex: integer;
      ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
    procedure clistCheckBoxClick(Sender: TObject);
    procedure HeatNavigateControlListBeforeDrawItem(AIndex: integer;
      ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
    procedure HeatControlListBeforeDrawItem(AIndex: integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure Heat_MoveUpExecute(Sender: TObject);
    procedure Heat_MoveUpUpdate(Sender: TObject);
    procedure Heat_MoveDownExecute(Sender: TObject);
    procedure Heat_MoveDownUpdate(Sender: TObject);
    procedure Session_NewUpdate(Sender: TObject);
    procedure Heat_MarshallReportUpdate(Sender: TObject);
    procedure Heat_MarshallReportExecute(Sender: TObject);
    procedure Heat_TimeKeeperReportUpdate(Sender: TObject);
    procedure Heat_TimeKeeperReportExecute(Sender: TObject);
    procedure btnClearSearchClick(Sender: TObject);
    procedure Entrant_SwapLanesExecute(Sender: TObject);
    procedure Entrant_SwapLanesUpdate(Sender: TObject);
  private
    { Private declarations }
    // For scroll wheel tracking on mouse ...
    FOrgDBGridWndProc: TWndMethod;
    // TRACK the MemberID of the last known member to have their
    // IsQualified status checked via Nominee_UpdateCheckListBoxQualified();
    fLastMemberQualified: integer;
    bootprogress: TBootProgress;
    fSessionClosedFontColor: TColor;
    fSessionClosedBgColor: TColor;
    fEntrantEditBoxFocused: TColor;
    fEntrantEditBoxNormal: TColor;
    fEntrantBgColor: TColor;
    fscmStyleName: String;

    SCMEventList: TObjectList;

    procedure DBGridWndProc(var Msg: TMessage);

    // REFRESH
    procedure Refresh_Event();
    procedure Refresh_Heat();
    procedure Refresh_Entrant();
    procedure Refresh_Nominate();

    // NOMINATE

    // Miscellaneous - uncatagorized
    procedure GetSCMPreferences();

    // D R A W   C H E C K   B O X E S .
    procedure DrawCheckBoxes(oGrid: TObject; Rect: TRect; Column: TColumn;
      fontColor: TColor; bgColor: TColor);
    procedure DrawEventStatus(oGrid: TObject; Rect: TRect; Column: TColumn);
    // ASSERT CONNECTION TO MSSQL DATABASE
    function AssertConnection(): boolean;

    procedure UpdateStatusBar();
    procedure EnableEntrant_GridEllipse();
    procedure Event_BuildSCMEventType(Sender: TObject;
      EventType: scmEventFinalsType);

    // Generic TAction onExecute (extended params) for BATCH PRINT
    procedure Session_BatchReportExecute(Sender: TObject; RptType: scmRptType);
    // -----------------------------------------------------------

  protected
    // windows messages ....
    procedure Session_Scroll(var Msg: TMessage); message SCM_SESSIONSCROLL;
    procedure Session_AssertStatusState(var Msg: TMessage);
      message SCM_SESSIONASSERTSTATUSSTATE;
    procedure Event_Scroll(var Msg: TMessage); message SCM_EVENTSCROLL;
    procedure Event_AssertState(var Msg: TMessage);
      message SCM_EVENTASSERTSTATE;
    procedure Event_AssertStatusState(var Msg: TMessage);
      message SCM_EVENTASSERTSTATUSSTATE;
    procedure Heat_Scroll(var Msg: TMessage); message SCM_HEATSCROLL;
    procedure Entrant_Scroll(var Msg: TMessage); message SCM_ENTRANTSCROLL;
    // Posted by TSCM.qryMemberQuickPick : AfterScroll
    procedure Nominate_Scroll(var Msg: TMessage); message SCM_NOMINATESCROLL;
    // posted by dmSCMNom : a refresh of the entrant grid is required.
    procedure Entrant_LaneWasCleaned(var Msg: TMessage); message SCM_LANEWASCLEANED;

  public
    { Public declarations }
    fDoStatusBarUpdate: boolean;
    fSCMisInitializing: boolean;
    prefGenerateEventDescription: boolean;
    prefGenerateEventDescStr: string;

  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses

  System.UITypes, dmSCM, dlgBasicLogin, Vcl.Themes, SCMUtility,
  System.IniFiles, dlgCloneSession, rptSessionReportA, rptSessionReportB,
  dlgNewSession, dmAutoBuildV2, rptEventReportA, rptEventReportB,
  dlgAutoBuild_Heats, dlgAbout, dlgPreferences, rptNominateReportA,
  rptNominateReportB, dlgQualifyTimes, dlgMembershipType,
  FireDAC.VCLUI.ConnEdit, FireDAC.Stan.Param, frmManageMember,
  rptMarshallReportA,
  rptMarshallReportB, rptTimeKeeperReportA, rptTimeKeeperReportB, dlgHouse,
  dlgAutoBuild_Finals, dlgPointsScored, dlgDivision, dlgLeaderBoard,
  dlgSelectPrinter, ioutils, dlgBatchProgress, dlgAutoBuildPref, ShellAPI,
  UEnvVars, dlgEntrantPicker, dlgEntrantPickerCTRL, dmSCMNom, dlgSwapLanes;

{ TTSCMEvent }

(*
  constructor TSCMEvent.Create();
  begin
  inherited;
  // performed by Delphi by default.
  // fSessionID := 0;
  // fDistanceID := 0;
  // fStrokeID := 0;
  // fEventID := 0;
  // fCaption := '';
  // fDistStrokeStr := '';
  fIsQualified := false;
  end;

  destructor TSCMEvent.Destroy;
  begin

  inherited;
  end;

  procedure TSCMEvent.writeCaption(value: string);
  begin
  fCaption := value;
  end;

  procedure TSCMEvent.writeDistanceID(value: integer);
  begin
  fDistanceID := value;
  end;

  procedure TSCMEvent.writeEventID(value: integer);
  begin
  fEventID := value;
  end;

  procedure TSCMEvent.writeSessionID(value: integer);
  begin
  fSessionID := value;
  end;

  procedure TSCMEvent.writeStrokeID(value: integer);
  begin
  fStrokeID := value;
  end;
*)

{ TMainP }

procedure TMain.ActionManager1Update(Action: TBasicAction;
  var Handled: boolean);
begin
  if AssertConnection then
  begin
    if not fSCMisInitializing then
      if fDoStatusBarUpdate then
        UpdateStatusBar;
  end;
  fDoStatusBarUpdate := false;
end;

function TMain.AssertConnection: boolean;
begin
  result := false;
  // test datamodule construction
  if Assigned(SCM) then
  begin
    // IsActive if TFDConnection::scmConnection && FireDAC tables are active
    if SCM.SCMActive then
      result := true;
  end;
end;

procedure TMain.btnClearSearchClick(Sender: TObject);
begin
  Nominate_Edit.Text := '';
  if Nominate_Edit.CanFocus then
    Nominate_Edit.SetFocus;
end;

procedure TMain.clistCheckBoxClick(Sender: TObject);
var
  MemberID, EventID: integer;
  DoNominate: boolean;
  nom: TSCMNom;
begin
  if not AssertConnection then
    exit;
  MemberID := SCM.dsNominateMembers.DataSet.FieldByName('MemberID').AsInteger;
  if (MemberID = 0) then
    exit;
  DoNominate := BindSourceDB1.DataSet.FieldByName('IsNominated').AsBoolean;
  EventID := BindSourceDB1.DataSet.FieldByName('EventID').AsInteger;
  // PERFORM THE TOGGLE
  DoNominate := not DoNominate;
  // Class to nominate/unnominate safely
  nom := TSCMNom.CreateWithConnection(self, SCM.scmConnection);
  if (DoNominate) then
    nom.NominateMember(MemberID, EventID)
  else
    // Returns true if member was unNominated.
    // May have required that a Lane was emptied of member.
    // TSCMnom will post message SCM_LANEWASCLEANED
    nom.UnNominateMember(MemberID, EventID);
  nom.Free;
  // REQUERY the database used by the controllist (and repaint)
  BindSourceDB1.DataSet.Refresh;
  fDoStatusBarUpdate := true;
end;

procedure TMain.Nominate_ControlListBeforeDrawItem(AIndex: integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
var
  s: string;
  b: boolean;
begin
  with BindSourceDB1.DataSet do
  begin
    clistEventDistStrokeStr.Caption := FieldByName('DistStrokeStr').AsString;

    s := FieldByName('Caption').AsString;
    if (s = '') then
      clistEventCaption.Caption := '. .'
    else
      clistEventCaption.Caption := s;
    b := FieldByName('IsNominated').AsBoolean;
    if b then
      clistCheckBox.ImageIndex := 1
    else
      clistCheckBox.ImageIndex := 0;
    b := FieldByName('IsQualified').AsBoolean;
    if b then
      vimage.ImageIndex := 24
    else
      vimage.ImageIndex := -1;
  end;
end;

procedure TMain.DBGridWndProc(var Msg: TMessage);
begin
  if ((Msg.Msg = WM_VSCROLL) and (Msg.WParamLo = SB_THUMBTRACK)) then
    Msg.WParamLo := SB_THUMBPOSITION;
  if Assigned(FOrgDBGridWndProc) then
    FOrgDBGridWndProc(Msg);
end;

procedure TMain.DrawCheckBoxes(oGrid: TObject; Rect: TRect; Column: TColumn;
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
  MyRect.Top := Trunc((Rect.Bottom - Rect.Top - 9) / 2) + Rect.Top;
  MyRect.Left := Trunc((Rect.Right - Rect.Left - 9) / 2) + Rect.Left;
  MyRect.Bottom := MyRect.Top + 8;
  MyRect.Right := MyRect.Left + 8;

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
    g.Canvas.MoveTo(iPos + (iFactor * 2), MyRect.Top + 4);
    g.Canvas.LineTo(iPos + (iFactor * 2), MyRect.Top + 7);
    g.Canvas.MoveTo(iPos + (iFactor * 3), MyRect.Top + 5);
    g.Canvas.LineTo(iPos + (iFactor * 3), MyRect.Top + 8);
    g.Canvas.MoveTo(iPos + (iFactor * 4), MyRect.Top + 6);
    g.Canvas.LineTo(iPos + (iFactor * 4), MyRect.Top + 9);
    g.Canvas.MoveTo(iPos + (iFactor * 5), MyRect.Top + 5);
    g.Canvas.LineTo(iPos + (iFactor * 5), MyRect.Top + 8);
    g.Canvas.MoveTo(iPos + (iFactor * 6), MyRect.Top + 4);
    g.Canvas.LineTo(iPos + (iFactor * 6), MyRect.Top + 7);
    g.Canvas.MoveTo(iPos + (iFactor * 7), MyRect.Top + 3);
    g.Canvas.LineTo(iPos + (iFactor * 7), MyRect.Top + 6);
    g.Canvas.MoveTo(iPos + (iFactor * 8), MyRect.Top + 2);
    g.Canvas.LineTo(iPos + (iFactor * 8), MyRect.Top + 5);
  end;
end;

procedure TMain.DrawEventStatus(oGrid: TObject; Rect: TRect; Column: TColumn);
var
  MyRect: TRect;
  iPos, iFactor: integer;
  g: TDBGrid;
begin
  g := TDBGrid(oGrid);
  // clear the cell with the current OS brush color?
  g.Canvas.FillRect(Rect);
  // calculate margins
  MyRect.Top := Round((Rect.Bottom - Rect.Top - 11) / 2) + Rect.Top;
  MyRect.Left := Round((Rect.Right - Rect.Left - 11) / 2) + Rect.Left;
  MyRect.Bottom := MyRect.Top + 10;
  MyRect.Right := MyRect.Left + 10;

  iPos := MyRect.Left;
  iFactor := 1;
  // DRAW A TICK
  g.Canvas.Pen.Color := clWebTomato;
  g.Canvas.MoveTo(iPos + (iFactor * 2), MyRect.Top + 4);
  g.Canvas.LineTo(iPos + (iFactor * 2), MyRect.Top + 7);
  g.Canvas.MoveTo(iPos + (iFactor * 3), MyRect.Top + 5);
  g.Canvas.LineTo(iPos + (iFactor * 3), MyRect.Top + 8);
  g.Canvas.MoveTo(iPos + (iFactor * 4), MyRect.Top + 6);
  g.Canvas.LineTo(iPos + (iFactor * 4), MyRect.Top + 9);
  g.Canvas.MoveTo(iPos + (iFactor * 5), MyRect.Top + 5);
  g.Canvas.LineTo(iPos + (iFactor * 5), MyRect.Top + 8);
  g.Canvas.MoveTo(iPos + (iFactor * 6), MyRect.Top + 4);
  g.Canvas.LineTo(iPos + (iFactor * 6), MyRect.Top + 7);
  g.Canvas.MoveTo(iPos + (iFactor * 7), MyRect.Top + 3);
  g.Canvas.LineTo(iPos + (iFactor * 7), MyRect.Top + 6);
  g.Canvas.MoveTo(iPos + (iFactor * 8), MyRect.Top + 2);
  g.Canvas.LineTo(iPos + (iFactor * 8), MyRect.Top + 5);

end;

procedure TMain.EnableEntrant_GridEllipse;
var
  i: integer;
  col: TColumn;
begin
  for i := 0 to Entrant_Grid.Columns.Count - 1 do
  begin
    col := Entrant_Grid.Columns.Items[i];
    if (col.FieldName = 'FullName') then
    begin
      col.ButtonStyle := cbsEllipsis;
      Entrant_Grid.Repaint;
      break;
    end;
  end;
end;

procedure TMain.Entrant_EmptyLaneExecute(Sender: TObject);
var
  success: boolean;
  rtnValue: integer;
begin
  // ...Update traps illegal calls.
  rtnValue := MessageDlg('Empty the lane?', mtConfirmation, [mbNo, mbYes],
    0, mbYes);
  if (rtnValue = mrYes) then
  begin
    success := SCM.Entrant_EmptyLane;
    if not success then
      beep;
  end;
  if Entrant_Grid.CanFocus then
    Entrant_Grid.SetFocus;
end;

procedure TMain.Entrant_EmptyLaneUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.IsClosedHeat then
          // is there any entrants?
          if not SCM.dsEntrant.DataSet.IsEmpty then
            DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Entrant_GridCellClick(Column: TColumn);
begin
  if Assigned(Column.Field) and (Column.Field.DataType = ftBoolean) then
  begin
    Column.Grid.DataSource.DataSet.Edit;
    Column.Field.value := not Column.Field.AsBoolean;
    Column.Grid.DataSource.DataSet.Post;
  end;
end;

procedure TMain.Entrant_GridColEnter(Sender: TObject);
begin
  // Important to cast TBGridOptions - else assignment desn't work!
  // If the field is boolean, switch off Grid editing, else allow editing
  if Assigned(Entrant_Grid.SelectedField) and
    (Entrant_Grid.SelectedField.DataType = ftBoolean) then
    // Important to use TBGridOptions constructor
    // - else assignment desn't work!
    Entrant_Grid.Options := Entrant_Grid.Options + [dgEditing];

end;

procedure TMain.Entrant_GridColExit(Sender: TObject);
begin
  if Assigned(Entrant_Grid.SelectedField) and
    (Entrant_Grid.SelectedField.DataType = ftBoolean) then
    Entrant_Grid.Options := Entrant_Grid.Options + [dgEditing];
end;

procedure TMain.Entrant_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: integer; Column: TColumn; State: TGridDrawState);
var
  clFont, clBg: TColor;
begin
  // NOTE : DEFAULT DRAWING IS DISABLED ....
  if (Column.Field.FieldName = 'IsScratched') or
    (Column.Field.FieldName = 'IsDisqualified') then
  begin
    if gdFocused in State then
      clFont := fEntrantEditBoxFocused
    else
      clFont := fEntrantEditBoxNormal;
    clBg := fEntrantBgColor;
    DrawCheckBoxes(Entrant_Grid, Rect, Column, clFont, clBg);
    // draw 'Focused' frame  (for boolean datatype only)
    if gdFocused in State then
      Entrant_Grid.Canvas.DrawFocusRect(Rect);
  end
  else if (Column.Field.FieldName = 'FullName') then
  begin
    // ENABLE the button if not enabled
    if (Column.ButtonStyle <> TColumnButtonStyle.cbsEllipsis) then
      Column.ButtonStyle := TColumnButtonStyle.cbsEllipsis;
    Entrant_Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then
      Entrant_Grid.Canvas.DrawFocusRect(Rect);
  end
  else
  begin
    // default drawing DOESN'T draw a themed (yellow) background color
    Entrant_Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then
      Entrant_Grid.Canvas.DrawFocusRect(Rect);
  end;
end;

procedure TMain.Entrant_GridEditButtonClick(Sender: TObject);
var
  passed: boolean;
  dlg: TEntrantPicker;
  dlgCntrl: TEntrantPickerCTRL;
  EntrantID: integer;
  rtnValue: TModalResult;
begin
  if not AssertConnection then
    exit;
  rtnValue := mrCancel;
  SCM.dsEntrant.DataSet.DisableControls;
  EntrantID := SCM.dsEntrant.DataSet.FieldByName('EntrantID').AsInteger;
  if ((GetKeyState(VK_CONTROL) and 128) = 128) then
  begin
    // if (GetKeyState(VK_CONTROL) < 0) then begin
    dlgCntrl := TEntrantPickerCTRL.Create(self);
    passed := dlgCntrl.Prepare(SCM.scmConnection, EntrantID);
    if passed then
      rtnValue := dlgCntrl.ShowModal;
    dlgCntrl.Free;
  end
  else
  begin
    dlg := TEntrantPicker.Create(self);
    passed := dlg.Prepare(SCM.scmConnection, EntrantID);
    if passed then
      rtnValue := dlg.ShowModal;
    dlg.Free;
  end;

  // require a refresh to update members name
  if passed and IsPositiveResult(rtnValue) then
  begin
    SCM.dsEntrant.DataSet.Refresh;
    SCM.Entrant_Locate(EntrantID);
  end;

  SCM.dsEntrant.DataSet.EnableControls;
end;

procedure TMain.Entrant_GridEnter(Sender: TObject);
begin
  // Ensure that correct editing options are applied on
  // first use. SelectedIndex defaults to the first column,
  // if you tab into the grid or your first click goes to
  // the first column then OnColEnter doesn't fire.
  Entrant_GridColEnter(Entrant_Grid);
end;

procedure TMain.Entrant_GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Opts: TLocateOptions;
  i, j: integer;
  success: boolean;
begin
  Opts := [];

  if (Key = VK_UP) and (ssCtrl in Shift) then
  begin
    Entrant_MoveUpExecute(self); // SWAP LANES
    Key := NULL;
    exit;
  end
  else if (Key = VK_UP) then
  begin
    // Move UP to next heat.
    if AssertConnection then
    begin
      // Navigate to prev heats if current location is on the first lane
      if (SCM.dsEntrant.DataSet.FieldByName('Lane').AsInteger = 1) then
      begin
        // Can't move if we are at the top of the heat.
        if (SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger > 1) then
        begin
          // move to prev heat
          i := SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger;
          i := i - 1;
          success := SCM.dsHeat.DataSet.Locate('HeatNum', i, Opts);
          // found previous heat move to last lane
          if (success) then
          begin
            j := SCM.GetNumberOfLanes;
            SCM.dsEntrant.DataSet.Locate('Lane', j, Opts);
            Key := 0;
          end;
        end;
      end;
    end;
  end;

  if (Key = VK_DOWN) and (ssCtrl in Shift) then
  begin
    Entrant_MoveDownExecute(self); // SWAP LANES?
    Key := 0;
    exit;
  end
  else if (Key = VK_DOWN) then
  begin
    // Move DOWN to next heat ....
    if (AssertConnection) then
    begin
      // Navigate to next heats if current location is on the last lane
      if (SCM.dsEntrant.DataSet.FieldByName('Lane')
        .AsInteger = SCM.GetNumberOfLanes) then
      begin
        // Can't move if we are at the bottom of the last heat stack.
        if (SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger <
          SCM.dsHeat.DataSet.RecordCount) then
        begin
          // move to next heat
          i := SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger;
          i := i + 1;
          success := SCM.dsHeat.DataSet.Locate('HeatNum', i, Opts);
          // found next heat move to first  lane
          if (success) then
          begin
            SCM.dsEntrant.DataSet.Locate('Lane', 1, Opts);
            Key := 0;
          end;
        end;
      end;
    end;
  end;

  // PAGE UP - navigate to the previous heat. Cue to same lane as org.heat;
  if (Key = VK_PRIOR) and (Shift = []) then
  begin
    // Move up to next heat ....
    if AssertConnection then
    begin
      if (SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger > 1) then
      begin
        // move to prev heat
        i := SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger;
        Dec(i);
        j := SCM.dsEntrant.DataSet.FieldByName('Lane').AsInteger;
        success := SCM.dsHeat.DataSet.Locate('HeatNum', i, Opts);
        if (success) then
        begin
          SCM.dsEntrant.DataSet.Locate('Lane', j, Opts);
          Key := 0;
        end;
      end;
    end;
  end
  // PAGE DOWN - navigate to the next heat. Cue to same lane as org.heat;
  else if (Key = VK_NEXT) and (Shift = []) then
  begin
    // Move DOWN to next heat ....
    if AssertConnection then
    begin
      // Move only if NOT a bottom of heats
      if (SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger <
        SCM.dsHeat.DataSet.RecordCount) then
      begin
        // move to prev heat
        i := SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger;
        Inc(i);
        j := SCM.dsEntrant.DataSet.FieldByName('Lane').AsInteger;
        success := SCM.dsHeat.DataSet.Locate('HeatNum', i, Opts);
        if (success) then
        begin
          SCM.dsEntrant.DataSet.Locate('Lane', j, Opts);
          Key := 0;
        end;
      end;
    end;

  end;

  // TOGGLE THE CHECKBOX WITH THE SPACE KEY.
  if Assigned(Entrant_Grid.SelectedField) and
    (Entrant_Grid.SelectedField.DataType = ftBoolean) and (Key = VK_SPACE) then
  begin
    Entrant_Grid.DataSource.DataSet.Edit;
    Entrant_Grid.SelectedField.value :=
      not Entrant_Grid.SelectedField.AsBoolean;
    Entrant_Grid.DataSource.DataSet.Post;
    Key := 0;
  end;

  // FINALIZE THE EDIT
  if (Key = VK_RETURN) then
  begin
    if AssertConnection then
    begin
      if (SCM.dsEntrant.DataSet.State = dsEdit) then
      begin
        SCM.dsEntrant.DataSet.Post;
        Key := NULL;
      end;
    end;
  end;

end;

procedure TMain.Entrant_LaneWasCleaned(var Msg: TMessage);
begin
  // message posted by TSCMNom SCM_LANEWASCLEANED
  Refresh_Entrant;
end;

procedure TMain.Entrant_MoveDownExecute(Sender: TObject);
var
  success: boolean;
  MaxLane: integer;
begin
  // ...Update traps illegal calls.
  // already at bottom of stack?  Last lane in pool.
  MaxLane := SCM.GetNumberOfLanes;
  if (Entrant_Grid.DataSource.DataSet.FieldByName('Lane').AsInteger = MaxLane)
  then
    begin
    success := SCM.SwapMoveDownHeat(Entrant_Grid.DataSource.DataSet);
    // move to next heat  (By default, will position on first entrant.)
    SCM.dsHeat.DataSet.Next;
    end
  else
    success := SCM.SwapMoveDown(Entrant_Grid.DataSource.DataSet);
  if not success then
    beep;
end;

procedure TMain.Entrant_MoveDownUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.IsClosedHeat then
          // is there any entrants?
          if not SCM.dsEntrant.DataSet.IsEmpty then
            DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Entrant_MoveUpExecute(Sender: TObject);
var
  success: boolean;
begin
  // ...Update traps illegal calls.
  // already at top of stack? First lane in pool.
  if (Entrant_Grid.DataSource.DataSet.FieldByName('Lane').AsInteger = 1) then
  begin
    success := SCM.SwapMoveUpHeat(Entrant_Grid.DataSource.DataSet);
    // move to the previous heat ....
    SCM.dsHeat.DataSet.Prior;
    // move to last entrant ....
    SCM.dsEntrant.DataSet.Last;
  end
  else
    success := SCM.SwapMoveUp(Entrant_Grid.DataSource.DataSet);
  if not success then
    beep;
end;

procedure TMain.Entrant_MoveUpUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.IsClosedHeat then
          // is there any entrants?
          if not SCM.dsEntrant.DataSet.IsEmpty then
            DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Entrant_Scroll(var Msg: TMessage);
begin
  // messages posted by TSCM.qryMemberQuickPickAfterScroll
  if not AssertConnection then
    exit;
  if Entrant_Grid.Focused then
    fDoStatusBarUpdate := true;
end;

procedure TMain.Entrant_SortExecute(Sender: TObject);
var
  HeatID, EntrantID: integer;
begin
  // ...Update traps illegal calls.
  with SCM.dsEntrant.DataSet do
  begin
    DisableControls;
    // needed to cue-to-entrant
    EntrantID := FieldByName('EntrantID').AsInteger;
    // the heat to pad
    HeatID := FieldByName('HeatID').AsInteger;
    SCM.Entrant_PadWithEmptyLanes(HeatID);
    SCM.Entrant_RenumberLanes(HeatID);
    // sort
    if (SCM.Entrant_Sort(HeatID)) then
    begin
      Refresh;
      // go cue-to-entrant
      SCM.Entrant_Locate(EntrantID);
    end;
    EnableControls;
  end;
end;

procedure TMain.Entrant_SortUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.IsClosedHeat then
          // is there any entrants?
          if not SCM.dsEntrant.DataSet.IsEmpty then
            DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Entrant_StrikeExecute(Sender: TObject);
var
  success: boolean;
  rtnValue: integer;
begin
  // ...Update traps illegal calls.
  rtnValue := MessageDlg('Remove nomination and empty the lane.?',
    mtConfirmation, [mbNo, mbYes], 0, mbYes);
  if (rtnValue = mrYes) then
  begin
    success := SCM.Entrant_Strike;
    if not success then
      beep;
  end;
  if Entrant_Grid.CanFocus then
    Entrant_Grid.SetFocus;
end;

procedure TMain.Entrant_StrikeUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.IsClosedHeat then
          // is there any entrants?
          if not SCM.dsEntrant.DataSet.IsEmpty then
            DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Entrant_SwapLanesExecute(Sender: TObject);
var
	dlg: TSwapLanes;
begin
	dlg := TSwapLanes.Create(self); // DEPENDANT ON THE SCM DATA MODULE
	if IsPositiveResult(dlg.ShowModal) then
		Refresh_Entrant;
  dlg.Free;
	if Entrant_Grid.CanFocus then
		Entrant_Grid.SetFocus;
end;

procedure TMain.Entrant_SwapLanesUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.IsClosedHeat then
          // is there any entrants?
          if not SCM.dsEntrant.DataSet.IsEmpty then
            DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Event_AssertState(var Msg: TMessage);
begin
  // The following routines send the windows message SCM_EVENTASSERTSTATE
  // 1. SCM->qrySession. (on events : AfterPost, AfterDelete)
  // 2. dlgNewSession TNewSession::tblSessionAfterPost(TDataSet *DataSet)
  //
  if not AssertConnection then
    exit;
  // if there are no sessions then events can't be displayed
  if SCM.dsSession.DataSet.IsEmpty then
  begin
    Event_Grid.Enabled := false;
    lblSessionEventCaption.Caption := 'The sessions table is empty...';
  end
  else
  begin
    Event_Grid.Enabled := true;
    lblSessionEventCaption.Caption := 'EVENTS.';
  end;
end;

procedure TMain.Event_AssertStatusState(var Msg: TMessage);
var
  AllClosed: boolean;
  bm: TBookmark;
  i, currStatusID: integer;
  fld: TField;
begin

  if not AssertConnection then
    exit;
  // init
  i := SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger;
  if (i > 0) then
  begin
    AllClosed := SCM.IsAllHeatsClosed(i);
    if (((AllClosed = true) and
      (SCM.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger = 1)) or
      ((AllClosed = false) and (SCM.dsEvent.DataSet.FieldByName('EventStatusID')
      .AsInteger = 2))) then
    begin
      SCM.dsEvent.DataSet.DisableControls;
      if AllClosed then
        currStatusID := 2
      else
        currStatusID := 1;
      // only modify the record if required ...
      if (SCM.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger <>
        currStatusID) then
      begin
        // bookmark the current record
        bm := SCM.dsEvent.DataSet.GetBookmark;
        // 13.10.2020 SCM.qryEvent.EventStatusID is READ ONLY
        fld := SCM.dsEvent.DataSet.FindField('EventStatusID');
        if Assigned(fld) then
          fld.ReadOnly := false;
        // go update the status of the event
        SCM.dsEvent.DataSet.Edit;
        SCM.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger :=
          currStatusID;
        // 22.09.2020 TimeStamp event closed date.
        // posted by TMain::Heat_ToggleStatusExecute(TObject *Sender)
        // used by SCM_LeaderBoard application to auto-update it's view
        // with the most resently closed event.
        if AllClosed then
          // Only timestamp if needed
          SCM.dsEvent.DataSet.FieldByName('ClosedDT').AsDateTime := Now();
        SCM.dsEvent.DataSet.Post;
        SCM.dsEvent.DataSet.Refresh;
        if Assigned(fld) then
          fld.ReadOnly := true;
        // que to event record
        try
          SCM.dsEvent.DataSet.GotoBookmark(bm);
        except
          on E: Exception do
        end;
      end;
      SCM.dsEvent.DataSet.EnableControls();
    end;
  end;

end;

procedure TMain.Event_BuildSCMEventType(Sender: TObject;
  EventType: scmEventFinalsType);
var
  dm: TAutoBuildV2;
  dlg: TAutoBuild_Finals;
  success: boolean;
  EventID, rtnValue: integer;
begin
  if not AssertConnection then
    exit;
  dlg := TAutoBuild_Finals.Create(self);
  dlg.TypeOfEvent := EventType;
  rtnValue := dlg.ShowModal;
  dlg.Free;
  if (rtnValue = mrYes) then
  begin
    EventID := SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger;
    dm := TAutoBuildV2(self);
    success := dm.AutoBuildExecuteExt(EventID, EventType);
    dm.Free;
    if (success) then
    begin
      // refresh...
      Refresh_Heat; // needed to display the new heats
      Refresh_Entrant; // needed to display the new entrants
      // the events appear in the grid but the nom and ent values
      // haven't been updated
      Refresh_Event;
    end;
  end;
end;

procedure TMain.Event_BuildFinalsExecute(Sender: TObject);
begin
  Event_BuildSCMEventType(Sender, ftFinals);
end;

procedure TMain.Event_BuildSCMEventTypeUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    if not SCM.dsSession.DataSet.IsEmpty then
      DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Event_BuildQuarterFinalsExecute(Sender: TObject);
begin
  Event_BuildSCMEventType(Sender, ftSemi);
end;

procedure TMain.Event_BuildSemiFinalsExecute(Sender: TObject);
begin
  Event_BuildSCMEventType(Sender, ftQuarter);
end;

procedure TMain.Event_DeleteExecute(Sender: TObject);
var
  rtnValue: integer;
  SQL: String;
  HasClosedHeats, HasRacedHeats: boolean;
begin
  HasClosedHeats := SCM.HasClosedHeats;
  HasRacedHeats := SCM.HasRacedHeats;
  if HasClosedHeats then
  begin
    SQL := 'Unable to delete the event ';
    SQL := SQL + SCM.dsEvent.DataSet.FieldByName('EventStr').AsString +
      sLineBreak;
    SQL := SQL + 'as the event includes ''closed'' heats.';
    MessageDlg(SQL, mtError, [mbOK], 0, mbOK);
    exit;
  end;
  // 1 .  C o n f i r m   d e l e t i o n (RACED HEATS) .
  // --------------------------------------------------------
  if HasRacedHeats then
  begin
    rtnValue := MessageDlg('WARNING: This event contains RACED heats.' +
      sLineBreak +
      'Racetimes and entrant data will be lost if you delete this event.' +
      sLineBreak + 'Do you wish to delete the event?', mtWarning,
      [mbYes, mbNo], 0, mbNo);
    // DON'T USE (results == mrNo) as it doesn't account for VK_ESCAPE.
    // mrCancel=2 mrNo=7 mrYes=6
    if (rtnValue <> mrYes) then
      exit;
  end;

  // 2 .  C o n f i r m   d e l e t i o n .
  // --------------------------------------------------------
  SQL := 'Delete event?';
  SQL := SQL + SCM.dsEvent.DataSet.FieldByName('EventStr').AsString +
    sLineBreak;
  if (HasRacedHeats) then
    SQL := SQL +
      'including all (open or raced) heats, entrant and nomination data?'
  else
    SQL := SQL + 'including all open heats, entrant and nomination data?';
  rtnValue := MessageDlg(SQL, mtConfirmation, [mbYes, mbNo], 0, mbYes);

  if (rtnValue = mrYes) then
    SCM.Event_Delete(); // delete the current selected event.
end;

procedure TMain.Event_DeleteUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // are there any events?
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Event_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: integer; Column: TColumn; State: TGridDrawState);
var
  oField: TField;
begin
  if (Column.Field.FieldName = 'EventStatusID') then
  begin
    oField := Column.Field;
    if (oField.value = '2') then
      // draw a tick if all the heats have been raced...
      DrawEventStatus(Event_Grid, Rect, Column)
    else
      // 17.10.2020 - leave the column blank ...
      Event_Grid.Canvas.FillRect(Rect);
  end;
end;

procedure TMain.Event_GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  dg: TDBGrid;
  c: char;
  i: integer;
begin
  if (Key = VK_UP) and (ssCtrl in Shift) then
  begin
    Event_MoveUpExecute(self);
    Key := NULL;
    exit;
  end;
  if (Key = VK_DOWN) and (ssCtrl in Shift) then
  begin
    Event_MoveDownExecute(self);
    Key := NULL;
    exit;
  end;

  {
    "1"	"FreeStyle"
    "2"	"BreastStroke"
    "3"	"BackStroke"
    "4"	"ButterFly"
    "5"	"Medley"

    "1"	"25m"	"25"
    "2"	"50m"	"50"
    "3"	"100m"	"100"
    "4"	"200m"	"200"
    "5"	"400m"	"400"
    "6"	"1000m"	"1000"
  }

  dg := TDBGrid(Sender);
  if (dg.SelectedField.FieldName = 'luStroke') then
  begin
    c := upcase(char(Key));
    case (c) of
      'F':
        i := 1;
      'B', 'R':
        i := 2;
      'A':
        i := 3;
      'U':
        i := 4;
      'M':
        i := 5;
    else
      i := 0;
    end;

    if (i > 0) then
    begin
      SCM.dsEvent.DataSet.DisableControls;
      SCM.dsEvent.DataSet.Edit;
      SCM.dsEvent.DataSet.FieldByName('StrokeID').AsInteger := i;
      SCM.dsEvent.DataSet.Post;
      SCM.dsEvent.DataSet.EnableControls;
      Key := 0;
    end;
  end
  else if (dg.SelectedField.FieldName = 'luDistance') then
  begin
    case char(Key) of
      '2':
        i := 1; // 25m
      '5':
        i := 2; // 50m
      '1':
        i := 3; // 100m
      '0':
        i := 4; // 200m
      '4':
        i := 5; // 400m
      // 1000m - there is no shortcut
    else
      i := 0;
    end;
    if (i > 0) then
    begin
      SCM.dsEvent.DataSet.DisableControls;
      SCM.dsEvent.DataSet.Edit;
      SCM.dsEvent.DataSet.FieldByName('DistanceID').AsInteger := i;
      SCM.dsEvent.DataSet.Post;
      SCM.dsEvent.DataSet.EnableControls;
      Key := 0;
    end;
  end;

end;

procedure TMain.Event_MoveDownExecute(Sender: TObject);
var
  bm: TBookmark;
  enA, enB: integer;
  ds: TDataSet;
  fld: TField;
begin
  ds := Event_Grid.DataSource.DataSet;
  if not Assigned(SCM) then
    exit;
  if not ds.Active then
    exit;
  if ds.IsEmpty then
    exit;
  if SCM.IsLastRecord(ds) then
  begin
    beep;
    exit;
  end;

  fld := ds.FindField('EventNum');
  if Assigned(fld) then
    fld.ReadOnly := false;
  ds.DisableControls();
  bm := ds.Bookmark;
  enA := ds.FieldByName('EventNum').AsInteger;
  enB := 0;
  try
    ds.Next;
    enB := ds.FieldByName('EventNum').AsInteger;
    ds.Edit;
    ds.FieldByName('EventNum').AsInteger := enA;
    ds.Post;
  finally
    ds.Bookmark := bm;
    ds.Edit;
    ds.FieldByName('EventNum').AsInteger := enB;
    ds.Post;
  end;
  ds.Refresh;
  if Assigned(fld) then
    fld.ReadOnly := true;
  ds.EnableControls();
end;

procedure TMain.Event_MoveUpExecute(Sender: TObject);
// move event up
var
  bm: TBookmark;
  enA, enB: integer;
  ds: TDataSet;
  fld: TField;
begin
  ds := Event_Grid.DataSource.DataSet;
  if not Assigned(SCM) then
    exit;
  if not ds.Active then
    exit;
  if ds.IsEmpty then
    exit;
  if SCM.IsFirstRecord(ds) then
  begin
    beep;
    exit;
  end;

  fld := ds.FindField('EventNum');
  if Assigned(fld) then
    fld.ReadOnly := false;
  ds.DisableControls();
  bm := ds.Bookmark;
  enA := ds.FieldByName('EventNum').AsInteger;
  enB := 0;
  try
    begin
      ds.Prior;
      enB := ds.FieldByName('EventNum').AsInteger;
      ds.Edit;
      ds.FieldByName('EventNum').AsInteger := enA;
      ds.Post;
    end;
  finally
    begin
      ds.Bookmark := bm;
      ds.Edit;
      ds.FieldByName('EventNum').AsInteger := enB;
      ds.Post;
    end;
  end;
  ds.Refresh;
  if Assigned(fld) then
    fld.ReadOnly := true;
  ds.EnableControls();

end;

procedure TMain.Event_MoveUpOrDownUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // no connection
  if not AssertConnection then
  begin
    (Sender as TAction).Enabled := DoEnable;
    exit;
  end;
  // session is locked
  if (SCM.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 2) then
  begin
    (Sender as TAction).Enabled := DoEnable;
    exit;
  end;
  // we need events to move up or down
  { TODO -oBSA -cGeneral : In a perfect world we would need a least two events. }
  if not SCM.dsEvent.DataSet.IsEmpty then
    DoEnable := true;
  // 13.10.2020
  // events can be moved up or down (re-ordered)
  // even if the heat has been raced or closed
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Event_NewRecordExecute(Sender: TObject);
begin
  if not AssertConnection then
    exit;
  SCM.dsEvent.DataSet.CheckBrowseMode;
  SCM.dsEvent.DataSet.Append();
end;

procedure TMain.Event_NewRecordUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // connected?
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Event_RenumberExecute(Sender: TObject);
begin
  if Assigned(SCM) then
    SCM.Event_Renumber;
end;

procedure TMain.Event_RenumberUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Event_ReportExecute(Sender: TObject);
var
  rptA: TEventReportA;
  rptB: TEventReportB;
begin
  try
    begin
      if ((GetKeyState(VK_CONTROL) and 128) = 128) then
      begin
        rptB := TEventReportB.Create(self);
        rptB.RunReport;
        rptB.Free;
      end
      else
      begin
        rptA := TEventReportA.Create(self);
        rptA.RunReport;
        rptA.Free;
      end;
    end;
  except
    on E: Exception do
      ShowMessage('Error opening report.');
  end;
  if Event_Grid.CanFocus then
    Event_Grid.SetFocus;
end;

procedure TMain.Event_ReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // Are there any Events?
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Event_Scroll(var Msg: TMessage);
var
  EnabledState: boolean;
begin

  if not AssertConnection then
    exit;
  EnabledState := false;
  // is the session is locked?
  if (SCM.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 1) then
  begin
    // Is the heat closed?
    if (SCM.dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger <> 3) then
      EnabledState := true;
  end;
  // ensures the entrant grid is disable when stepping around GUI
  if (Entrant_Grid.Enabled <> EnabledState) then
    Entrant_Grid.Enabled := EnabledState;
  if (Event_Grid.Focused) then
    fDoStatusBarUpdate := true;
end;

procedure TMain.Event_ToggleGridViewExecute(Sender: TObject);
var
  fld: TField;
begin
  // TActionUpdate determines if this routine can be accessed
  with (Sender as TAction) do
  begin
    // T O G G L E .
    Checked := not Checked;
    if Checked then
    begin
      ImageIndex := 1; // collapse session grid
      pnlSessionLeft.Visible := false;
    end
    else
    begin
      ImageIndex := 0; // reveal session grid (default)
      pnlSessionLeft.Visible := true;
    end;
    // makes visible the event caption field used to enter event details
    SCM.qryEvent.DisableControls;
    // e v e n t   d e s c r i p t i o n ...
    fld := SCM.qryEvent.FindField('Caption');
    if Assigned(fld) then
      fld.Visible := Checked;
    // e v e n t   s c h e d u l e  t i m e ...
    fld := SCM.qryEvent.FindField('ScheduleDT');
    if Assigned(fld) then
      fld.Visible := Checked;

    // Fields that are always visible in either grid display mode.
    // n o m i n a t i o n s  ...
    fld := SCM.qryEvent.FindField('NomineeCount');
    if Assigned(fld) then
    begin
      if Checked then
        fld.DisplayLabel := 'Nominees'
      else
        fld.DisplayLabel := 'Nom#';
    end;
    // e n t r a n t s ...
    fld := SCM.qryEvent.FindField('EntrantCount');
    if Assigned(fld) then
    begin
      if Checked then
        fld.DisplayLabel := 'Entrants'
      else
        fld.DisplayLabel := ' Ent#';
    end;
    SCM.qryEvent.EnableControls;
  end;
end;

procedure TMain.Event_ToggleGridViewUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Event_grid View can be toggled if no event?
    DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.File_ExitExecute(Sender: TObject);
begin
  { TODO -oBSA -cGeneral : CheckBrowseMode on all grids before exit? }
  Close;
end;

procedure TMain.FormCreate(Sender: TObject);
var
  str: string;
  passed: boolean;
  aBasicLogin: TBasicLogin; // 24/04/2020 uses simple INI access
  result: TModalResult;
  hf: NativeUInt;
begin
  bootprogress := nil;
  SCMEventList := nil;
  fDoStatusBarUpdate := false;
  fSCMisInitializing := true;
  fSessionClosedFontColor := clWebTomato;
  fSessionClosedBgColor := clAppWorkSpace;

  try
    SCM := TSCM.Create(self);
  finally
    // with SCM created and the essential tables are open then
    // asserting the connection should be true
    if not Assigned(SCM) then
    begin
      MessageDlg('The SCM connection couldn''t be created!', mtError,
        [mbOK], 0);
      Application.Terminate();
    end;
  end;

  if not Assigned(SCM) then
    exit;

  // -----------------------------------------------------------
  // 24/04/2020 Basic login using simple INI access
  // to the FireDAC connection definition file
  // -----------------------------------------------------------
  aBasicLogin := TBasicLogin.Create(self);
  result := aBasicLogin.ShowModal;
  aBasicLogin.Free;

  // user has aborted .
  if (result = mrAbort) or (result = mrCancel) then
  begin
    if (SCM.scmConnection.Connected) then
      SCM.scmConnection.Close;
    SCM.Free;
    SCM := nil;
    Application.Terminate;
    exit;
  end;

  bootprogress := TBootProgress.Create(self);
  bootprogress.Show;
  Application.ProcessMessages;

  bootprogress.lblProgress.Caption := 'Activating SQL Server tables.';
  bootprogress.lblProgress.Repaint;
  Application.ProcessMessages;

  // scmConnectionAfterConnect calls ActivateTables
  SCM.ActivateTable;

  // then test 'IsActive
  if not SCM.SCMActive then
  begin
    MessageDlg('An error occurred during MSSQL table activation.' + sLineBreak +
      'The application will terminate!', mtError, [mbOK], 0);

    // play it safe and destroy this form
    FreeAndNil(bootprogress);
    // note: cleans and destroys SCM
    Application.Terminate;
  end;

  bootprogress.lblProgress.Caption := 'Tables Activated ... OK.';
  bootprogress.lblProgress.Repaint;
  Application.ProcessMessages;

  // NOMINEE -
  // reset last known qualified MemberID to unknown
  fLastMemberQualified := 0;
  Nominate_TagQualified.Checked := false;

  // For scroll wheel tracking on mouse ...
  FOrgDBGridWndProc := Nominate_Grid.WindowProc;
  Nominate_Grid.WindowProc := DBGridWndProc;

  // ---------------------------------------------------------
  // S C M   S y s t e m   I n i t i a l i z a t i o n.
  // ---------------------------------------------------------
  // Set default tab sheet page - Session
  PageControl1.TabIndex := 0;
  if Assigned(TStyleManager.ActiveStyle) then
    fscmStyleName := TStyleManager.ActiveStyle.Name;

  // ---------------------------------------------------------
  // N O M I N A T E   . .  .
  // ---------------------------------------------------------
  // an object list pointing to current events
  // and synced to the checkbox list on the nominee's tabsheet
  SCMEventList := TObjectList.Create(true); // OwnsObjects


  // ---------------------------------------------------------
  // H E A T   . . .
  // ---------------------------------------------------------
  // LEGACY depreciated - left here for reference only.
  // Entrant_Grid->DefaultDrawing = false;

  bootprogress.lblProgress.Caption := 'Checking user preferences.';
  bootprogress.lblProgress.Repaint;
  Application.ProcessMessages;

  // -----------------------------------------------------------------------
  // DO ONCE ... TEST FOR Artanemus\ in USER\APPDATA
  // -----------------------------------------------------------------------
  passed := true;
  str := GetEnvironmentVariable('APPDATA');
  str := IncludeTrailingPathDelimiter(str);
  str := str + 'Artanemus\';

  // Make sure the 'User\AppData\Roaming\Artanemus' is created!
  if not DirectoryExists(str) then
  begin
    if not CreateDir(str) then
      // FAILED! - Use alternative default document directory...
      passed := false;
  end;
  // Make sure the 'User\AppData\Roaming\Artanemus\SCM' is created!
  if (passed) then
  begin
    str := str + 'SCM\';
    if not DirectoryExists(str) then
    begin
      if not CreateDir(str) then
        // FAILED! - Use alternative default document directory...
        passed := false;
    end;
  end;
  // Make sure the 'User\AppData\Roaming\Artanemus\SCM\SCMPref.ini' is created!
  // routine suits - 32bit platform.
  if (passed) then
  begin
    str := SCMUtility.GetSCMPreferenceFileName();
    if not FileExists(str) then
    begin
      hf := NativeUInt(FileCreate(str));
      // display a general message ... missing preference file.
      passed := false;
      if (NativeInt(hf) = -1) then
      begin
        // FAILED! - Use alternative default document directory...
        // critical error .... write permissions?
      end
      else
        // close of the handle.....
        FileClose(hf);
    end;
  end;

  prefGenerateEventDescription := false;
  prefGenerateEventDescStr := '';

  bootprogress.lblProgress.Caption := 'Loading user preferences.';
  bootprogress.lblProgress.Repaint;
  Application.ProcessMessages;

  // ====================================================================
  // PREFERENCE - SETUP
  if (passed) then
    GetSCMPreferences();
  // ====================================================================

  bootprogress.lblProgress.Caption := 'Final checks on database integerity.';
  bootprogress.lblProgress.Repaint;
  Application.ProcessMessages;

  pnlPageControl.Caption := '';

  // ERROR CHECK for valid swimming club record
  if AssertConnection() then
  begin
    if (SCM.dsSwimClub.DataSet.RecordCount = 0) then
    begin
      // disable InterFace
      PageControl1.Visible := false;
      Session1.Enabled := false;
      Tools1.Enabled := false;
      // display message
      MessageDlg('The swimming club hasn''t been defined!' + sLineBreak +
        'Run the utility, SCM_BuildMeAClub, with the supplied SQL' + sLineBreak
        + 'creation scripts to build your club.' + sLineBreak +
        'For more information, refer to the SwimClubMeet help files.', mtError,
        [mbOK], 0, mbOK);
      // with the page control hidden - this message will appear
      pnlPageControl.Caption := 'ERROR: The swimming club is undefined!';
    end;
    // Set the visibility of events based on the existance of a
    // single record in the session table
    PostMessage(Main.Handle, SCM_EVENTASSERTSTATE, 0, 0);
  end;

  bootprogress.lblProgress.Caption := 'Construct GUI components.';
  bootprogress.lblProgress.Repaint;
  Application.ProcessMessages;

  // enable hints
  Application.ShowHint := true;
  // inhibits statusbar updates in TActionManager.Update
  fSCMisInitializing := false;
  // 3.10.2020
  EnableEntrant_GridEllipse;

  // 22/12/22
  // L I N K   G R I D S   T O   D A T A S O U R C E S .
  Event_Grid.DataSource := SCM.dsEvent;
  Nominate_Grid.DataSource := SCM.dsNominateMembers;
  // Heat_Grid.DataSource := SCM.dsHeat;
  Entrant_Grid.DataSource := SCM.dsEntrant;
  // L I N K   T D B T e x t
  dbtxtSwimClubCaption.DataSource := SCM.dsSwimClub;
  dbtxtSwimClubNickName.DataSource := SCM.dsSwimClub;
  dbtxtDebugEntrant.DataSource := SCM.dsEntrant;
  dbtxtDebugSwimClub.DataSource := SCM.dsSwimClub;
  dbtxtDebugSession.DataSource := SCM.dsSession;
  dbtxtDebugEvent.DataSource := SCM.dsEvent;
  dbtxtDebugHeat.DataSource := SCM.dsHeat;
  dbtxtDebugMember.DataSource := SCM.dsEntrant;
  dbtxtDebugNominee.DataSource := SCM.dsNominee;

  dbtxtEventCaption.DataSource := SCM.dsEvent;
  dbnavEventNavigatePrior.DataSource := SCM.dsEvent;
  dbnavEventNavigateNext.DataSource := SCM.dsEvent;

  dbtxtNominateFullName.DataSource := SCM.dsNominateMembers;

  dbimgSwimClubLogo.DataSource := SCM.dsSwimClub;

  // Assert binding - because it always fails!!!
  BindSourceDB1.DataSet := SCM.qryNominateControlList;
  if not BindSourceDB1.DataSet.Active then
    BindSourceDB1.DataSet.Active := true;

  BindSourceDB2.DataSet := SCM.qryEvent;
  if not BindSourceDB2.DataSet.Active then
    BindSourceDB2.DataSet.Active := true;

  BindSourceDB3.DataSet := SCM.qryHeat;
  if not BindSourceDB3.DataSet.Active then
    BindSourceDB3.DataSet.Active := true;

end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  if Assigned(bootprogress) then
  begin
    bootprogress.Close;
    bootprogress.Free;
  end;

  if Assigned(SCMEventList) then
  begin
    SCMEventList.Clear;
    SCMEventList.Free;
  end;
  if Assigned(SCM) then
  begin
    if SCM.scmConnection.Connected then
      SCM.scmConnection.Close;
    SCM.Free;
  end;
end;

procedure TMain.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
var
  g: TDBGrid;
begin
  if (Screen.ActiveControl.ClassName() = 'TDBGrid') then
  begin
    g := TDBGrid(Screen.ActiveControl);
    if (WheelDelta > 0) then
      SendMessage(g.Handle, WM_VSCROLL, SB_LINEUP, 0)
    else
      SendMessage(g.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
    Handled := false;
  end;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  if Assigned(bootprogress) then
  begin
    bootprogress.Close;
    bootprogress.Free;
    bootprogress := nil;
  end;

  if Session_Grid.CanFocus then
    Session_Grid.SetFocus;
end;

procedure TMain.GetSCMPreferences();
var
  iniFileName: String;
  i: integer;
  css: TCustomStyleServices;
  iFile: TIniFile;
begin
  // ---------------------------------------------------------
  // A S S I G N   P R E F E R E N C E S ...
  // Note AA: Need to wrangle the return state on some preferences
  // as they refer to the state of a RAD checkbox.
  // A RAD checkbox may have three states -1, 0, 1.
  // ---------------------------------------------------------
  iniFileName := SCMUtility.GetSCMPreferenceFileName;
  if not FileExists(iniFileName) then
    exit;
  iFile := TIniFile.Create(iniFileName);

  // Generate event descriptions for new events : see note AA.
  // -------------------------------------------
  i := iFile.ReadInteger('Preferences', 'GenerateEventDescription',
    integer(cbUnchecked));
  if (i = integer(cbChecked)) then
    prefGenerateEventDescription := true
  else
    prefGenerateEventDescription := false;

  prefGenerateEventDescStr := iFile.ReadString('Preferences',
    'GenerateEventDescStr', ' - Individual, all genders, all ages.');

  // Display debug info ... see note AA.
  // -------------------------------------------
  i := iFile.ReadInteger('Preferences', 'ShowDebugInfo', integer(cbUnchecked));
  if (i = integer(cbChecked)) then
    pnlDebugInfo.Visible := true
  else
    pnlDebugInfo.Visible := false;

  // Switch to the default windows scheme else use stored fscmStyleName.
  // -------------------------------------------
  i := iFile.ReadInteger('Preferences', 'UseWindowsDefTheme',
    integer(cbUnchecked));
  if (i = integer(cbChecked)) then
  begin
    if (TStyleManager.ActiveStyle.Name <> 'Windows') then
      TStyleManager.TrySetStyle('Windows');
  end
  else if (TStyleManager.ActiveStyle.Name <> fscmStyleName) then
    TStyleManager.TrySetStyle(fscmStyleName);

  // Special color assignment - used in TDBGrid painting...
  // -------------------------------------------
  css := TStyleManager.Style[TStyleManager.ActiveStyle.Name];
  if Assigned(css) then
  begin
    fSessionClosedFontColor := css.GetStyleFontColor(sfEditBoxTextDisabled);
    fSessionClosedBgColor := css.GetStyleColor(scGrid);
    fEntrantEditBoxFocused := css.GetStyleFontColor(sfEditBoxTextFocused);
    fEntrantEditBoxNormal := css.GetStyleFontColor(sfEditBoxTextNormal);
    fEntrantBgColor := css.GetStyleColor(scGrid);
  end
  else
  begin
    fSessionClosedFontColor := clWebTomato;
    fSessionClosedBgColor := clAppWorkSpace;
    fEntrantEditBoxFocused := clWebTomato;
    fEntrantEditBoxNormal := clWindowText;
    fEntrantBgColor := clAppWorkSpace;
  end;
  iFile.Free;
end;

procedure TMain.HeatControlListBeforeDrawItem(AIndex: integer; ACanvas: TCanvas;
  ARect: TRect; AState: TOwnerDrawState);
var
  i: integer;
begin
  i := BindSourceDB3.DataSet.FieldByName('HeatStatusID').AsInteger;
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
  i := BindSourceDB2.DataSet.FieldByName('StrokeID').AsInteger;
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
  i: integer;
begin
  with BindSourceDB2.DataSet do
  begin
    lblHeatNavigatorDistance.Caption := FieldByName('Meters').AsString;
    s := FieldByName('luStroke').AsString;
    i := FieldByName('StrokeID').AsInteger;
    s := s.SubString(0, 4);

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

procedure TMain.Heat_AutoBuildExecute(Sender: TObject);
var
  AutoBuild: TAutoBuildV2;
  dlg: TAutoBuild_Heats;
  success: boolean;
  EventID, rtnValue: integer;
begin
  // actn..Update determines if this routine is accessable.

  EventID := SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger;

  // 'Quick' check if we have nominees to auto-create heats.
  // This routine is simplified (for expediance), it looks at all
  // nominees placed and un-placed ... ignoring open,raced,closed heat
  // status.
  if not SCM.HasNominees(EventID) then
  begin
    MessageDlg('No one has been nominated for this event.' + sLineBreak +
      'Auto-Build Heats was aborted.', mtError, [mbOK], 0, mbOK);
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
  if not IsPositiveResult(rtnValue) then
    exit;
  // -------------------------------------------------------

  // DISABLE CONTROLS
  SCM.dsEntrant.DataSet.DisableControls;
  SCM.dsHeat.DataSet.DisableControls;
  // NOTE : cfgBuildHeatsVerboseON := OFF for BATCH Auto-Build Heats
  AutoBuild := TAutoBuildV2.Create(self);
  // ALERT : IMPORTANT NOTE ...
  // ***************************************************************
  // if TMain's instance of the Heat DataSet isn't sent to Auto-Build
  // ... unable to delete Heat record. (tbl is locked?)
  // That is - call via  to SCM.dsDeat.DataSet ...  doesn't work!
  // ***************************************************************
  // Verbose OFF for BATCH Auto-Build Heats
  success := AutoBuild.AutoBuildExecute(SCM.dsHeat.DataSet, EventID);
  if (success) then
  begin
    Refresh_Heat;
    Refresh_Entrant;
    // if BATCH AUTO-BUILD enabled ...
    // Don't refresh EVENT as we are iterating through the list
    // Event's grid need to be refreshed
    // to update NOM# and ENT#
    SCM.dsEvent.DataSet.DisableControls;
    Refresh_Event;
    SCM.dsEvent.DataSet.EnableControls;
  end;
  AutoBuild.Free;
  // ENABLE CONTROLS
  SCM.dsHeat.DataSet.EnableControls;
  SCM.dsEntrant.DataSet.EnableControls;

  if HeatControlList.CanFocus then
    HeatControlList.SetFocus;
end;

procedure TMain.Heat_AutoBuildUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // are there any Events?
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Heat_DeleteExecute(Sender: TObject);
var
  results: integer;
begin
  // actn.Update dictates if this routine is accessable.
  // The heat is CLOSED.
  if SCM.IsClosedHeat then
  begin
    MessageDlg('This heat is CLOSE' + sLineBreak +
      'The heat can''t be deleted.', mtInformation, [mbOK], 0, mbOK);
    exit;
  end;
  // The heat is RACED
  if SCM.IsRacedHeat then
  begin
    results := MessageDlg('WARNING: This heat is RACED.' + sLineBreak +
      'Racetimes and entrant data will be lost if you delete this heat.' +
      sLineBreak + 'Do you wish to delete the heat?', mtWarning,
      [mbYes, mbNo], 0, mbNo);
    if (results <> mrYes) then
      exit;
  end;
  // Heat status is RACED or OPEN. Final confirmation message.
  if SCM.IsRacedHeat then
    results := MessageDlg('Final confirmation:' + sLineBreak +
      'Delete the RACED heat, all of it''s racetimes and entrant data?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes)
  else
  begin
    results := MessageDlg
      ('Delete the selected heat and all it''s assigned entrants?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes);
  end;
  // d e l e t e   t h e   c u r r e n t   s e l e c t e d   h e a t .
  // -----------------------------------------------------------------
  if (results = mrYes) then
    SCM.Heat_Delete
end;

procedure TMain.Heat_DeleteUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // are there any Events?
      if not SCM.dsEvent.DataSet.IsEmpty then
        // are there any Heats?
        if not SCM.dsHeat.DataSet.IsEmpty then
          DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Heat_MarshallReportExecute(Sender: TObject);
var
rptA: TMarshallReportA;
rptB: TMarshallReportB;
EventID: integer;
begin
  if not AssertConnection then exit;

  EventID := SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger;
	try
		if ((GetKeyState(VK_CONTROL) and 128) = 128) then
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
  except on E: Exception do
		ShowMessage('Error opening report.');
  end;
	if HeatControlList.CanFocus then
    HeatControlList.SetFocus;
end;

procedure TMain.Heat_MarshallReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Are there any heats? Note: Locked sessions can be printed.
    if not SCM.dsHeat.DataSet.IsEmpty then
      DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Heat_MoveDownExecute(Sender: TObject);
var
  bm: TBookmark;
  enA, enB: integer;
  fld: TField;
begin
  // TActionUpdate determines if this routine can be called
  // m o v e   e v e n t   d o w n  .
  if not AssertConnection then
    exit;
  With SCM.dsHeat.DataSet do
  begin
    if not SCM.IsLastRecord(SCM.dsHeat.DataSet) then
    begin
      DisableControls();
      try
        begin
          bm := Bookmark;
          enA := FieldByName('HeatNum').AsInteger;
          enB := 0;
          fld := SCM.qryHeat.FindField('HeatNum');
          try
            begin
              // 3.10.2020 ensure field is writable
              if Assigned(fld) then
                fld.ReadOnly := false;
              Next();
              enB := FieldByName('HeatNum').AsInteger;
              Edit();
              FieldByName('HeatNum').AsInteger := enA;
              Post();
            end;
          finally
            Bookmark := bm;
            Edit();
            FieldByName('HeatNum').AsInteger := enB;
            Post();
            // 3.10.2020
            if Assigned(fld) then
              fld.ReadOnly := true;
          end;
        end;
      finally
        // RE-ORDER and RE-CUE ...
        Refresh();
        EnableControls();
      end;
    end;
  end;
end;

procedure TMain.Heat_MoveDownUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // By default, heat is assumed to be LOCKED.
      // This routine asserts the state of heat dataset (connection, active and
      // not isempty) and if all checks pass, returns the record status.
      // Not locked if the HeatStatusID <> 3.
      if not SCM.IsLockedHeat then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_MoveUpExecute(Sender: TObject);
var
  bm: TBookmark;
  enA, enB: integer;
  fld: TField;
begin
  // TActionUpdate determines if this routine can be called
  // m o v e   e v e n t   u  p  .
  if not AssertConnection then
    exit;
  With SCM.dsHeat.DataSet do
  begin
    if not SCM.IsFirstRecord(SCM.dsHeat.DataSet) then
    begin
      DisableControls();
      try
        begin
          bm := Bookmark;
          enA := FieldByName('HeatNum').AsInteger;
          enB := 0;
          fld := SCM.qryHeat.FindField('HeatNum');
          try
            begin
              // 3.10.2020 ensure field is writable
              if Assigned(fld) then
                fld.ReadOnly := false;
              Prior();
              enB := FieldByName('HeatNum').AsInteger;
              Edit();
              FieldByName('HeatNum').AsInteger := enA;
              Post();
            end;
          finally
            Bookmark := bm;
            Edit();
            FieldByName('HeatNum').AsInteger := enB;
            Post();
            // 3.10.2020
            if Assigned(fld) then
              fld.ReadOnly := true;
          end;
        end;
      finally
        // RE-ORDER and RE-CUE ...
        Refresh();
        EnableControls();
      end;
    end;
  end;
end;

procedure TMain.Heat_MoveUpUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // By default, heat is assumed to be LOCKED.
      // This routine asserts the state of heat dataset (connection, active and
      // not isempty) and if all checks pass, returns the record status.
      // Not locked if the HeatStatusID <> 3.
      if not SCM.IsLockedHeat then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_NewRecordExecute(Sender: TObject);
begin
  SCM.Heat_NewRecord;
end;

procedure TMain.Heat_NewRecordUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // are there any Events?
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Heat_PrintSetExecute(Sender: TObject);
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
  if not AssertConnection then exit;

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
  SCM.dsHeat.DataSet.First;
  while not SCM.dsHeat.DataSet.Eof do
  begin
    HeatID := SCM.dsHeat.DataSet.FieldByName('HeatID').AsInteger;
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
          break; // something wrong during printing.
        end;
      end;
    end;
    rptTimeKeeper.qryReport.Close;
    // disable select printer dialog ....
    rptTimeKeeper.frxReport1.PrintOptions.ShowDialog := false;
    // store printer name
    // printerName := rptTimeKeeper.lastPrinterName;
    SCM.dsHeat.DataSet.Next;
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
    // set printer name
    rptMarshall.frxReport1.PrintOptions.Printer := printerName;
    EventID := SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger;
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

procedure TMain.Heat_PrintSetUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Are there any heats? Note: Locked sessions can be printed.
    if not SCM.dsHeat.DataSet.IsEmpty then
      DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Heat_Scroll(var Msg: TMessage);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Would we see a scroll-msg if a there was no connection?
  if not AssertConnection then
    exit;
  // Is the session is locked?
  if (SCM.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 1) then
  begin
    // Is the heat closed?
    if (SCM.dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger <> 3) then
      DoEnable := true;
  end;
  // ensures the entrant grid is disable when stepping around GUI
  if (Entrant_Grid.Enabled <> DoEnable) then
    Entrant_Grid.Enabled := DoEnable;

  if (HeatControlList.Focused) then
    fDoStatusBarUpdate := true;
end;

procedure TMain.Heat_TimeKeeperReportExecute(Sender: TObject);
var
rptA: TTimeKeeperReportA;
rptB: TTimeKeeperReportB;
HeatID: integer;
begin
  if not AssertConnection then exit;
  HeatID := SCM.dsHeat.DataSet.FieldByName('HeatID').AsInteger;
	try
		if ((GetKeyState(VK_CONTROL) and 128) = 128) then
    begin
			rptB := TTimeKeeperReportB.Create(self);
      rptB.Prepare(SCM.scmConnection, HeatID);
      rptB.RunReport;
			rptB.Free;
		end
		else
    begin
			rptA := TTimeKeeperReportA.Create(self);
      rptA.Prepare(SCM.scmConnection, HeatID);
      rptA.RunReport;
			rptA.Free;
		end;
  except on E: Exception do
		ShowMessage('Error opening report.');
  end;
	if HeatControlList.CanFocus then
    HeatControlList.SetFocus;
end;

procedure TMain.Heat_TimeKeeperReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Are there any heats? Note: Locked sessions can be printed.
    if not SCM.dsHeat.DataSet.IsEmpty then
      DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Heat_ToggleStatusExecute(Sender: TObject);
var
  i: integer;
begin
  SCM.Heat_ToggleStatus;
  i := SCM.dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger;
  case i of
    1, 2:
      Entrant_Grid.Enabled := true;
    3:
      Entrant_Grid.Enabled := false;
  end;
  if HeatControlList.CanFocus then
    HeatControlList.SetFocus;
  PostMessage(Main.Handle, SCM_EVENTASSERTSTATUSSTATE, 0, 0);
end;

procedure TMain.Heat_ToggleStatusUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Help_AboutExecute(Sender: TObject);
var
  dlg: TAbout;
begin
  dlg := TAbout.Create(self);
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Help_HelpClick(Sender: TObject);
var
  base_URL: string;
begin
  base_URL := '${PROGRAMDATA}\Artanemus\SCM\SCM_Help\index.htm';
  // Expand Environment Variables
  base_URL := UEnvVars.ExpandEnvVars(base_URL);
  ShellExecute(0, nil, PWideChar(base_URL), nil, nil, SW_SHOWNORMAL);
end;

procedure TMain.Help_HomePageClick(Sender: TObject);
var
  base_URL: string;
begin
  base_URL := 'http://artanemus.github.io';
  ShellExecute(0, 'open', PWideChar(base_URL), nil, nil, SW_SHOWNORMAL);
end;

procedure TMain.Help_OnlineClick(Sender: TObject);
var
  base_URL: string;
begin
  base_URL := 'http://artanemus.github.io/manual/index.htm';
  ShellExecute(0, nil, PWideChar(base_URL), nil, nil, SW_SHOWNORMAL);
end;

procedure TMain.Nominate_EditChange(Sender: TObject);
var
  fs: String;
begin
  if not AssertConnection then
    exit;
  fs := '';
  with SCM.dsNominateMembers.DataSet do
  begin
    DisableControls;
    // update filter string ....
    if (Length(Nominate_Edit.Text) > 0) then
    begin
      fs := fs + '[FName] LIKE ' + QuotedStr('%' + Nominate_Edit.Text + '%');
    end;
    // assign filter
    if fs.IsEmpty then
      Filtered := false
    else
    begin
      Filter := fs;
      if not Filtered then
        Filtered := true;
    end;
    EnableControls;
  end;
end;

procedure TMain.Nominate_GridDblClick(Sender: TObject);
var
  dlg: TManageMember;
  MemberID: integer;
begin
  if not AssertConnection then
    exit;
  dlg := TManageMember.Create(self);
  MemberID := SCM.dsNominateMembers.DataSet.FieldByName('MemberID').AsInteger;
  try
    dlg.Prepare(SCM.scmConnection, 1, MemberID);
    dlg.ShowModal;
  finally
    dlg.Free;
  end;
end;

procedure TMain.Nominate_ReportExecute(Sender: TObject);
var
  rptA: TNominateReportA;
  rptB: TNominateReportB;
begin
  if not AssertConnection then
    exit;
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
    on E: Exception do
      ShowMessage('Error opening nominatation report.');
  end;
  if Nominate_Grid.CanFocus then
    Nominate_Grid.SetFocus;
end;

procedure TMain.Nominate_Scroll(var Msg: TMessage);
var
  MemberID: integer;
  success: boolean;
begin
  if AssertConnection then
  begin
    MemberID := SCM.dsNominateMembers.DataSet.FieldByName('MemberID').AsInteger;
    success := SCM.Nominate_UpdateControlList(SCM.GetSessionID, MemberID);
    // Close, prepare and open - the binding source must be reactivated.
    // -------------------------------------------------------------------
    if not BindSourceDB1.DataSet.Active then
      BindSourceDB1.DataSet.Active := true;
    if success then
      Nominate_ControlList.Invalidate;
  end;
end;

procedure TMain.Nominate_SortMembersExecute(Sender: TObject);
var
  actn: TAction;
begin
  // TActionUpdate determines if this procedure can be called.
  actn := TAction(Sender);
  actn.Checked := not actn.Checked;
  SCM.Nominate_SortMembers(actn.Checked);
  if Nominate_Grid.CanFocus then
    Nominate_Grid.SetFocus;
end;

procedure TMain.Nominate_SortMembersUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.IsLockedSession then
      // No members listed. Nothing to sort.
      if not Nominate_Grid.DataSource.DataSet.IsEmpty then
        DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.PageControl1Change(Sender: TObject);
begin
  // Update page
  case (PageControl1.TabIndex) of
    0: // S e s s i o n .
      fDoStatusBarUpdate := true;
    1: // N o m i n a t e .
      begin
        if AssertConnection then
        begin

          (*
            What nominate refresh does:
            ----------------------------------------------------
            Nominate_UpdateStatusLabels;
            Resets last known qualified MemberID to unknown.
            Nominate_ControlList.Invalidate;
          *)
          Refresh_Nominate;
          if (SCM.qryEvent.IsEmpty) then
            lblNomWarning.Visible := true
          else
            lblNomWarning.Visible := false;
        end;
        // places focus onto the nominees list
        if Nominate_Grid.CanFocus then
          Nominate_Grid.SetFocus;
      end;
    2: // H e a t s .
      begin
        fDoStatusBarUpdate := true;
        if HeatControlList.CanFocus then
          HeatControlList.SetFocus;
      end;
  end;
end;

procedure TMain.PageControl1Changing(Sender: TObject; var AllowChange: boolean);
begin
  (*
    CheckBrowseMode is used internally by many dataset methods to ensure that
    modifications to the active record are posted when a dataset's state is
    dsEdit, dsInsert, or dsSetKey and a method switches to a different record.

    If State is dsEdit or dsInsert, CheckBrowseMode calls UpdateRecord, and,
    if the Modified property for the dataset is true, calls Post. If Modified
    is false, CheckBrowseMode calls Cancel.

    If State is dsSetKey, CheckBrowseMode calls Post.

    If State is dsInactive, CheckBrowseMode raises an exception.

    If an application uses existing dataset methods, CheckBrowseMode is always
    called when necessary, so there is usually no need to call CheckBrowseMode
    directly.

    Applications that provide custom dataset routines may need to call
    CheckBrowseMode inside those routines to guarantee that changes are posted
    when switching to a different record.
  *)
  if AssertConnection then
  begin
    case PageControl1.TabIndex of
      0:
        begin
          SCM.qryEvent.CheckBrowseMode;
          SCM.qrySession.CheckBrowseMode;
        end;
      2:
        begin
          SCM.qryEntrant.CheckBrowseMode;
          SCM.qryHeat.CheckBrowseMode;
        end;
    end;
  end;
end;

procedure TMain.Refresh_Entrant;
var
  bm: TBookmark;
begin
  if not AssertConnection then
    exit;
  With SCM.dsEntrant.DataSet do
  begin
    DisableControls;
    bm := GetBookmark;
    Close;
    Open;
    if Active then
    begin
      try
        GotoBookmark(bm);
      except
        on E: Exception do
      end;
    end;
    EnableControls;
  end;
end;

procedure TMain.Refresh_Event;
var
  bm: TBookmark;
begin
  if not AssertConnection then
    exit;
  with SCM.dsEvent.DataSet do
  begin
    DisableControls;
    bm := GetBookmark;
    Close;
    Open;
    if Active then
    begin
      try
        GotoBookmark(bm);
      except
        on E: Exception do
      end;
    end;
    EnableControls;
  end;
end;

procedure TMain.Refresh_Heat;
var
  bm: TBookmark;
begin
  if not AssertConnection then
    exit;
  with SCM.dsHeat.DataSet do
  begin
    DisableControls;
    bm := GetBookmark;
    Close;
    Open;
    if Active then
    begin
      try
        GotoBookmark(bm);
      except
        on E: Exception do
      end;
    end;
    EnableControls;
  end;
end;

procedure TMain.Refresh_Nominate;
var
  bm: TBookmark;
begin
  if not AssertConnection then
    exit;
  // Update the SCM.dsQmember's table
  // (may have changed if the user has been editing the member's table
  // in the member's dialogue)
  with  SCM.dsNominateMembers.DataSet do begin
  DisableControls;
  bm := GetBookmark;
  Close;
  Open;
  if Active then
  begin
    try
      // NOTE: Posts nominate-scroll event - forces a nominate_controllist update.
      GotoBookmark(bm);
    finally;
    end;
  end;
  Nominate_ControlList.ItemCount := SCM.qryNominateEvent.RecordCount;
  EnableControls;
  end;
end;

procedure TMain.SCM_ManageMembersExecute(Sender: TObject);
var
  dlg: TManageMember;
begin
  dlg := TManageMember.Create(self);
  try
    dlg.Prepare(SCM.scmConnection, 1, 0);
    dlg.ShowModal();
  finally
    dlg.Free;
  end;
end;

procedure TMain.SCM_ManageMembersUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.SCM_RefreshExecute(Sender: TObject);
begin
  if not AssertConnection then
    exit;
  // Disable everthing
  SCM.dsSession.DataSet.DisableControls;
  SCM.dsEvent.DataSet.DisableControls;
  SCM.dsHeat.DataSet.DisableControls;
  SCM.dsEntrant.DataSet.DisableControls;
  // SESSION
  Session_SortExecute(self);
  // EVENT
  Refresh_Event;
  // NOMINEE + NOMINATE_GRID
  Refresh_Nominate;
  // HEAT
  Refresh_Heat;
  // ENTRANT
  Refresh_Entrant;
  SCM.dsSession.DataSet.EnableControls;
  SCM.dsEvent.DataSet.EnableControls;
  SCM.dsHeat.DataSet.EnableControls;
  SCM.dsEntrant.DataSet.EnableControls;
end;

procedure TMain.Session_AssertStatusState(var Msg: TMessage);
var
  AllClosed: boolean;
  bm: TBookmark;
  reqStatus, currStatus: integer;
  fld: TField;
begin
  // -------------------------------------------------------------
  // d e p r e c i a t e d .
  // this windows message has been depreciated
  // -------------------------------------------------------------
  if not AssertConnection then
    exit;
  if SCM.dsEvent.DataSet.IsEmpty then
    exit;
  // Assume current event ID is not zero.
  AllClosed := SCM.IsAllHeatsClosed(SCM.GetEventID);
  currStatus := SCM.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger;
  if (AllClosed and (currStatus = 1)) or (not AllClosed and (currStatus = 2))
  then
  begin
    SCM.dsEvent.DataSet.DisableControls;
    if AllClosed then
      reqStatus := 2
    else
      reqStatus := 1;
    // only modify the record if required ...
    if (currStatus <> reqStatus) then
    begin
      // bookmark the current record
      bm := SCM.dsEvent.DataSet.GetBookmark;
      // 13.10.2020 SCM.qryEvent.EventStatusID is READ ONLY
      fld := SCM.dsEvent.DataSet.FindField('EventStatusID');
      if Assigned(fld) then
        fld.ReadOnly := false;
      // go update the status of the event
      SCM.dsEvent.DataSet.Edit;
      SCM.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger := reqStatus;
      if (AllClosed = true) then
        SCM.dsEvent.DataSet.FieldByName('ClosedDT').AsDateTime := Now;
      SCM.dsEvent.DataSet.Post;
      SCM.dsEvent.DataSet.Refresh;
      if Assigned(fld) then
        fld.ReadOnly := true;
      try
        // que to event record
        SCM.dsEvent.DataSet.GotoBookmark(bm);
      except
      end;
    end;
    SCM.dsEvent.DataSet.EnableControls;
  end;
end;

procedure TMain.Session_BatchBuildHeatsExecute(Sender: TObject);
var
  success, passed: boolean;
  errCount: integer;
  dlg: TAutoBuildPref;
  dmv2: TAutoBuildV2;
  rtnValue: TModalResult;
begin
  success := false;
  passed := false;
  errCount := 0;

  // TActionUpdate determines access to this routine.
  // DISPLAY AUTO-BUILD CONFIGURATION DIALOGUE
  dlg := TAutoBuildPref.Create(self);
  rtnValue := dlg.ShowModal;
  // closing the form here ensures prefHeatAlgorithm,
  // prefUseDefRaceTime, prefSeedMode and prefRaceTimeTopPercent have been
  // written out to the preference ini file.
  dlg.Free;
  // user aborted ?
  if not IsPositiveResult(rtnValue) then
    exit;

  // Auto-build heat class constructor.
  // NOTE: Assigns auto-build configuration params on creation.
  try
    dmv2 := TAutoBuildV2.Create(self);
  except
    on E: Exception do
      exit;
  end;

  // disable core tables
  SCM.dsEvent.DataSet.DisableControls;
  SCM.dsHeat.DataSet.DisableControls;
  SCM.dsEntrant.DataSet.DisableControls;

  with SCM.dsEvent.DataSet do
  begin
    First;
    while not Eof do // iterate over the events ...
    begin
      // Is the EVENT CLOSED?
      if (FieldByName('EventStatusID').AsInteger = 2) then
      begin
        Next;
        continue;
      end;
      // QUICK TEST - Do we have NOMINEES?
      if not SCM.HasNominees(FieldByName('EventID').AsInteger) then
      begin
        Next;
        continue;
      end;
      // SCM.dsHeat.DataSet must be sent to Auto-Build - else errors.
      // ***************************************************************
      // Verbose OFF for BATCH Auto-Build Heats
      success := dmv2.AutoBuildExecute(SCM.dsHeat.DataSet,
        FieldByName('EventID').AsInteger, false);
      if not success then
        Inc(errCount);

      Next; // LOOP
    end;
  end;

  if (errCount = 0) then
    passed := true;

  // clean-up memory
  dmv2.Free;

  // REFRESH ...
  // NOTE: DataSet.Refresh not used.
  SCM.dsEntrant.DataSet.Close;
  SCM.dsHeat.DataSet.Close;
  SCM.dsEvent.DataSet.Close;
  SCM.dsEvent.DataSet.Open;
  SCM.dsHeat.DataSet.Open;
  SCM.dsEntrant.DataSet.Open;

  // Enable core tables
  SCM.dsEvent.DataSet.EnableControls;
  SCM.dsHeat.DataSet.EnableControls;
  SCM.dsEntrant.DataSet.EnableControls;

  if passed then
  begin
    // Display success.
    if not success then
      MessageDlg('Batch Build Heats completed but with errors.' + sLineBreak +
        'Check output!', mtInformation, [mbOK], 0)
    else
      MessageDlg('Batch Build Heats completed without errors.', mtInformation,
        [mbOK], 0);
  end;
end;

procedure TMain.Session_BatchBuildHeatsUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if not SCM.IsLockedSession then
      if not SCM.dsSession.DataSet.IsEmpty then
        // Do we have Events?.
        if not SCM.dsEvent.DataSet.IsEmpty then
          DoEnable := true;
  end;
  // no connection or no events or event is closed - disable actions
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_BatchMarshallReportExecute(Sender: TObject);
begin
  Session_BatchReportExecute(Sender, rtMarshall);
end;

procedure TMain.Session_BatchMarshallReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if not SCM.dsSession.DataSet.IsEmpty then
    begin
      // Note: Locked sessions can be printed.
      // Do we have Events?.
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
    end;
  end;
  // no connection or no events or event is closed - disable actions
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_BatchReportExecute(Sender: TObject;
  RptType: scmRptType);
var
  success: boolean;
  dlg: TSelectPrinter;
  bp: TBatchProgress;
  PrinterOrFolderName, s: String;
  SendToMode: scmSendToMode;
  SendToFileType: scmSendToFileType;
  errCount: integer;
begin
  errCount := 0;
  // TActionUpdate determines if this routine is accessed.
  // Sessions, Event 'not IsEmpty' passed test.
  // Select printer for reports.
  // OR
  // Select folder (and ..TODO: collation) for PDF export.
  dlg := TSelectPrinter.Create(self);

  if (RptType = scmRptType.rtTimeKeeper) then
    dlg.Panel2.Caption := 'Batch Print Timekeeper Reports'
  else
    dlg.Panel2.Caption := 'Batch Print Marshall Reports';
  if IsAbortResult(dlg.ShowModal) then
    exit;

  if dlg.rbtnSendToPrinter.Checked then
  begin
    SendToMode := stmSendToPrinter;
    SendToFileType := sftNA;
    PrinterOrFolderName := dlg.printerName;
  end
  else
  begin
    SendToMode := stmSendToFile;
    SendToFileType := sftPDF;
    PrinterOrFolderName := dlg.edtFolder.Text;
  end;
  dlg.Free;

  if PrinterOrFolderName.IsEmpty then
  begin
    if (SendToMode = stmSendToFile) then
      s := 'ERROR: No folder name given.'
    else
      s := 'ERROR: No printer selected.';
    MessageDlg(s, mtError, [mbOK], 0);
    exit;
  end;

  if (SendToMode = stmSendToFile) then
  begin
    // FINAL CHECKS ON FOLDER PARAM.
    // append delimeter
    PrinterOrFolderName := IncludeTrailingPathDelimiter(PrinterOrFolderName);
    // Does the folder exists
    if not TDirectory.Exists(PrinterOrFolderName) then
    begin;
      MessageDlg('ERROR: Output folder doesn''t exist.', mtError, [mbOK], 0);
      exit;
    end;
  end;
  // *************************************************
  // F I N A L L Y   B A T C H   P R I N T ....
  // *************************************************
  // disable core tables
  SCM.dsSession.DataSet.DisableControls;
  SCM.dsEvent.DataSet.DisableControls;
  SCM.dsHeat.DataSet.DisableControls;
  bp := TBatchProgress.Create(self);
  bp.Show;
  // allow time for the dlg to be fully painted?
  Application.ProcessMessages;
  // Dlg tasked to print/export reports.
  // BatchPrint(
  // REPORT TYPE - MARSHALL or TIMEKEEPER,
  // PRINTER NAME OR FOLDER NAME FOR FILE EXPORT,
  // NUMBER OF ERRORS (REFERENCE PARAM),
  // SEND TO PRINTER (DEFAULT) OR EXPORT TO FILE
  // FILE TYPE TO EXPORT PDF, XLS, HTML, NA (DEFAULT)
  success := bp.BatchPrint(RptType, PrinterOrFolderName, errCount, SendToMode,
    SendToFileType);
  bp.Free;
  // restore state
  SCM.dsSession.DataSet.EnableControls;
  SCM.dsEvent.DataSet.EnableControls;
  SCM.dsHeat.DataSet.EnableControls;
  if (success) then
  begin
    MessageDlg('Batch Print completed without errors.', mtInformation,
      [mbOK], 0);
  end
  else
    MessageDlg('Batch Print done but with errors(' + IntToStr(errCount) + ').' +
      sLineBreak + 'Check!', mtWarning, [mbOK], 0);
end;

procedure TMain.Session_BatchTimeKeeperReportExecute(Sender: TObject);
begin
  Session_BatchReportExecute(Sender, rtTimeKeeper);
end;

procedure TMain.Session_BatchTimeKeeperReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if not SCM.dsSession.DataSet.IsEmpty then
    begin
      // Note: Locked sessions can be printed.
      // Do we have Events?.
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
    end;
  end;
  // no connection or no events or event is closed - disable actions
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_CloneExecute(Sender: TObject);
var
  dlg: TCloneSession;
begin
  { TODO -oBSA -cGeneral :  Check abort method. }
  try
    dlg := TCloneSession.Create(self);
    // raises exception if SCM not assigned.
    if IsPositiveResult(dlg.ShowModal) then
      SCM_RefreshExecute(self);
    dlg.Free;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TMain.Session_CloneUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if not SCM.dsSession.DataSet.IsEmpty then
      DoEnable := true;
  end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_DeleteExecute(Sender: TObject);
var
  rtnValue: integer;
  SQLstr: string;
  ContainsClosedHeats, ContainsRacedHeats: boolean;
begin
  ContainsClosedHeats := false;
  ContainsRacedHeats := false;

  if not AssertConnection then
    exit;
  if SCM.dsSession.DataSet.IsEmpty then
    exit;
  if (SCM.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 2) then
  begin
    MessageDlg('A locked session can''t be deleted.', mtInformation,
      [mbOK], 0, mbOK);
    exit;
  end;

  // WARNING #1
  rtnValue := MessageDlg('Delete the selected session?' + sLineBreak +
    'Including it''s events, nominees, heats and entrants.', mtConfirmation,
    [mbYes, mbNo], 0, mbNo);
  // DON'T USE (rtnValue = mrNo) AS IT DOESN'T ACCOUNT FOR OS CLOSE 'X' BTN.
  // mrCancel=2 mrNo=7 mrYes=6
  if (rtnValue <> mrYes) then
    exit;

  // look for closed heats
  SCM.dsHeat.DataSet.DisableControls;
  SCM.dsHeat.DataSet.First;
  while not SCM.dsHeat.DataSet.Eof do
  begin
    if (SCM.dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger = 3) then
    begin
      ContainsClosedHeats := true;
      break;
    end;
    SCM.dsHeat.DataSet.Next;
  end;

  // look for raced heats
  SCM.dsHeat.DataSet.First;
  while not SCM.dsHeat.DataSet.Eof do
  begin
    if (SCM.dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger = 2) then
    begin
      ContainsRacedHeats := true;
      break;
    end;
    SCM.dsHeat.DataSet.Next;
  end;

  SCM.dsHeat.DataSet.EnableControls;

  // WARNING #2
  if (ContainsClosedHeats or ContainsRacedHeats) then
  begin
    rtnValue := MessageDlg('The session contains CLOSED and/or RACED heats.' +
      sLineBreak +
      'Racetimes and entrant data will be lost if you delete this session.' +
      sLineBreak + 'Do you wish to delete the session?', mtWarning,
      [mbYes, mbNo], 0, mbNo);

    // DON'T USE (results = mrNo) AS IT DOESN'T ACCOUNT FOR OS CLOSE 'X' BTN.
    // mrCancel=2 mrNo=7 mrYes=6
    if (rtnValue <> mrYes) then
      exit;
  end;

  SCM.dsSession.DataSet.DisableControls;
  SCM.dsEvent.DataSet.DisableControls;
  SCM.dsHeat.DataSet.DisableControls;
  SCM.dsEntrant.DataSet.DisableControls;
  SCM.dsNominee.DataSet.DisableControls;

  // DB parent...child sync
  if not SCM.dsEvent.DataSet.IsEmpty then
  begin
    // ITERATE OVER EVENTS .. WITHIN CURRENT SESSION
    SCM.dsEvent.DataSet.First;
    while not SCM.dsEvent.DataSet.Eof do
    begin
      if not SCM.dsHeat.DataSet.IsEmpty then
      begin
        // DELETE ENTRANTS ... FROM HEATS
        SCM.dsHeat.DataSet.First;
        while not SCM.dsHeat.DataSet.Eof do
        begin
          SQLstr := 'DELETE FROM dbo.Entrant WHERE Entrant.HeatID := ' +
            IntToStr(SCM.dsHeat.DataSet.FieldByName('HeatID').AsInteger);
          SCM.scmConnection.ExecSQL(SQLstr);
          SCM.dsHeat.DataSet.Next;
        end;
      end;

      // DELETE HEATS  .. FROM EVENT
      SQLstr := 'DELETE FROM dbo.HeatIndividual WHERE HeatIndividual.EventID := '
        + IntToStr(SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger);
      SCM.scmConnection.ExecSQL(SQLstr);

      // DELETE NOMINATIONS  ... FROM EVENT
      SQLstr := 'DELETE FROM dbo.Nominee WHERE Nominee.EventID := ' +
        IntToStr(SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger);
      SCM.scmConnection.ExecSQL(SQLstr);

      SCM.dsEvent.DataSet.Next;
    end;
  end;

  // DELETE ALL EVENTS associated with current selected session
  SQLstr := 'DELETE FROM dbo.Event WHERE Event.SessionID := ' +
    IntToStr(SCM.dsSession.DataSet.FieldByName('SessionID').AsInteger);
  SCM.scmConnection.ExecSQL(SQLstr);

  // FINALLY ... DELETE the SESSION
  SQLstr := 'DELETE FROM dbo.Session WHERE Session.SessionID := ' +
    IntToStr(SCM.dsSession.DataSet.FieldByName('SessionID').AsInteger);
  SCM.scmConnection.ExecSQL(SQLstr);

  SCM.dsNominee.DataSet.EnableControls;
  SCM.dsEntrant.DataSet.EnableControls;
  SCM.dsHeat.DataSet.EnableControls;
  SCM.dsEvent.DataSet.EnableControls;
  SCM.dsSession.DataSet.EnableControls;

  // update the grid views
  SCM_RefreshExecute(self);

end;

procedure TMain.Session_DeleteUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if not SCM.dsSession.DataSet.IsEmpty then
    begin
      if not SCM.IsLockedSession then
        DoEnable := true;
    end;
  end;
  // no connection or no events or event is closed - disable actions
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_EditExecute(Sender: TObject);
var
  dlg: TNewSession;
begin
  if not AssertConnection then
    exit;
  dlg := TNewSession.CreateWithConnection(self, SCM.scmConnection);
  dlg.SessionMode := smEditSession;
  dlg.SessionID := SCM.GetSessionID;
  if IsPositiveResult(dlg.ShowModal) then
    Session_SortExecute(self);
  dlg.Free;
end;

procedure TMain.Session_EditUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    if not SCM.dsSession.DataSet.IsEmpty then
      DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: integer; Column: TColumn; State: TGridDrawState);
var
  size: TSize;
  topMargin: integer;
  MyRect: TRect;
begin
  // dim the text if the session is closed
  // DEFAULT DRAWING IS DISABLED ....
  // a CLOSED SESSION
  if (Session_Grid.DataSource.DataSet.FieldByName('SessionStatusID')
    .AsInteger = 2) then
  begin
    // CLEAR THE CANVAS
    Session_Grid.Canvas.Brush.Color := fSessionClosedBgColor;
    Session_Grid.Canvas.Brush.Style := bsSolid;
    Session_Grid.Canvas.FillRect(Rect);
    // PRINT THE TEXT
    // Session_Grid.Canvas.Pen.Color = clWebTomato;
    Session_Grid.Canvas.Font.Color := clWebTomato;
    size := Session_Grid.Canvas.TextExtent(Column.Field.DisplayText);
    topMargin := Round((Rect.Height - size.Height) / 2);
    // calculate margins
    MyRect.Top := Rect.Top + topMargin;
    MyRect.Left := Rect.Left + topMargin;
    MyRect.Bottom := Rect.Bottom;
    MyRect.Right := Rect.Right;
    Session_Grid.Canvas.TextRect(Rect, Rect.Left, Rect.Top,
      Column.Field.DisplayText);
  end
  else
    Session_Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TMain.Session_NewExecute(Sender: TObject);
var
  dlg: TNewSession;
begin
  { TODO -oBSA -cGeneral : Check overload, methods for insert or edit modes }
  // Exception raised if connection assigned.
  dlg := TNewSession.CreateWithConnection(self, SCM.scmConnection);
  dlg.SessionMode := smNewSession;
  if IsPositiveResult(dlg.ShowModal) then
  begin
    SCM.dsSession.DataSet.Refresh; // Requery, Sort.
    SCM.Session_Locate(dlg.SessionID); // CUE-TO NEW session.
    PostMessage(self.Handle, SCM_EVENTASSERTSTATE, 0, 0);
  end;
  dlg.Free;
end;

procedure TMain.Session_NewUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // only a connection is required to create a new session
  if AssertConnection then
    DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_ReportExecute(Sender: TObject);
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
    on E: Exception do
      ShowMessage(E.Message);
  end;
  if Session_Grid.CanFocus then
    Session_Grid.SetFocus;
end;

procedure TMain.Session_ReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if not SCM.dsSession.DataSet.IsEmpty then
      // 13.10.2020 : A report can be printed even if the session is locked.
      DoEnable := true;
  end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_Scroll(var Msg: TMessage);
begin
  if AssertConnection then
  begin
    if (SCM.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 2) then
    begin
      // disable all grids
      Event_Grid.Enabled := false;
      // Heat_Grid.Enabled := false;
      Entrant_Grid.Enabled := false;
      Nominate_ControlList.Enabled := false;
    end
    else
    begin
      Event_Grid.Enabled := true;
      // Heat_Grid.Enabled := true;
      Entrant_Grid.Enabled := true;
      Nominate_ControlList.Enabled := true;
    end;
  end;
  if (Session_Grid.Focused) then
    fDoStatusBarUpdate := true;
end;

procedure TMain.Session_SortExecute(Sender: TObject);
var
  bm: TBookmark;
begin
  if AssertConnection then
  begin
    bm := SCM.dsSession.DataSet.GetBookmark;
    Session_Grid.DataSource.DataSet.Refresh;
    try
      SCM.dsSession.DataSet.GotoBookmark(bm);
    except
      on E: Exception do;
    end;
  end;
end;

procedure TMain.Session_SortUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    if not SCM.dsSession.DataSet.IsEmpty then
      DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_ToggleGridUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // the grid can be toggled even if we don't have sessions.
    DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_ToggleLockExecute(Sender: TObject);
begin
  // TAction ...Update determines if this routine is accessable
  SCM.Session_ToggleLockState;
  // Announce status change and enabled/disable grid access.
  PostMessage(Main.Handle, SCM_SESSIONSCROLL, 0, 0);
end;

procedure TMain.Session_ToggleLockUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then
    if not SCM.dsSession.DataSet.IsEmpty then
      DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Session_ToggleVisibleExecute(Sender: TObject);
begin
  With (Sender as TAction) do
  begin
    Checked := not Checked;
    if Checked then
    begin
      ImageIndex := 22; // hide locked
      spbtnSessionToggleVisible.ImageIndex := 22;
    end
    else
    begin
      ImageIndex := 23; // show locked (default)
      spbtnSessionToggleVisible.ImageIndex := 23;
    end;
    // toggle visibility of locked sessions
    SCM.Session_HideLocked(Checked);
    if Session_Grid.CanFocus then
      Session_Grid.SetFocus;
  end;
end;

procedure TMain.Session_ToggleVisibleUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then
    if not SCM.dsSession.DataSet.IsEmpty then
      DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Tools_ConnectionManagerExecute(Sender: TObject);
var
  sConnStr: String;
  dlg: TfrmFDGUIxFormsConnEdit;
  passed: boolean;
  results: integer;
begin
  // edit the FireDac connection string ....
  if not AssertConnection then
    exit;
  results := MessageDlg('Open the database connection tool?.' + sLineBreak +
    'If you have other SwimClubMeet apps running' + sLineBreak +
    'on this computer then they should be closed.' + sLineBreak +
    '(Be patient, this tool is slow to load.)', mtConfirmation,
    [mbYes, mbNo], 0, mbNo);
  if (results <> mrYes) then
    exit;

  // Builds as INI formatted string for the current connection
  sConnStr := SCM.scmConnection.ResultConnectionDef.BuildString;
  // FireDAC connection edit dialogue box
  dlg := TfrmFDGUIxFormsConnEdit.Create(self);
  // ----------------------------------------------
  // SHUT DOWN SCM ...
  // ----------------------------------------------
  SCM.DeActivateTable;
  SCM.scmConnection.Connected := false; // manatory
  // ----------------------------------------------
  // Display the FireDAC connection dialogue box
  // ----------------------------------------------
  // This dialogue makes changes to FireDAC's FDConnectionDefs.ini
  // file. It only shows the current connection profile ...
  // On return - aConnStr will reflect the changes that have been made.
  passed := dlg.Execute(sConnStr, '');
  dlg.Free;
  if (passed) then
    SCM.scmConnection.ResultConnectionDef.ParseString(sConnStr);
  // ----------------------------------------------
  // RESTART SCM
  // ----------------------------------------------
  try
    SCM.scmConnection.Connected := true;
    SCM.ActivateTable;
    // REFRESH
    SCM_RefreshExecute(self);
  except
    on E: Exception do
      MessageDlg('It''s recommended you close and restart SCM', mtError,
        [mbOK], 0);
  end;
end;

procedure TMain.Tools_DivisionsExecute(Sender: TObject);
var
  dt: TDateTime;
  dlg: TDivision;
begin
  // TActionUpdate determine access to this routine.
  dt := SCM.GetStartOfSwimSeason();
  if (dt <= 0) then
  begin
    // error no start of swim season given
    MessageDlg('A ''Start Of Swim Season'' value hasn''t been assigned.' +
      sLineBreak + 'Check your options and preferences!', mtInformation,
      [mbOK], 0);
    exit;
  end;
  dlg := TDivision(self);
  dlg.Connection := SCM.scmConnection;
  dlg.StartOfSwimSeason := dt;
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Tools_DivisionsUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then
    DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Tools_HouseExecute(Sender: TObject);
var
  dlg: THouse;
begin
  // TActionUpdate determins if this routine can be accessed.
  dlg := THouse.CreateWithConnection(self, SCM.scmConnection);
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Tools_HouseUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then
    DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Tools_LeaderBoardExecute(Sender: TObject);
var
  dlg: TLeaderBoard;
begin
  // TActionUpdate determins if this routine can be accessed.
  dlg := TLeaderBoard.Create(self);
  dlg.Connection := SCM.scmConnection;
  dlg.SessionID := SCM.GetSessionID;
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Tools_LeaderBoardUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then
    DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.Tools_MembershipTypeExecute(Sender: TObject);
var
  dlg: TMembershipType;
begin
  // display the membership type dialogue
  dlg := TMembershipType.Create(self);
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Tools_PreferencesExecute(Sender: TObject);
var
  dlg: TPreferences;
begin
  // finalize any editing before opening options dialogue
  if not AssertConnection then
    exit;
  case PageControl1.TabIndex of
    0:
      begin
        SCM.qryEvent.CheckBrowseMode;
        SCM.qrySession.CheckBrowseMode;
      end;
    2:
      begin
        SCM.qryEntrant.CheckBrowseMode;
        SCM.qryHeat.CheckBrowseMode;
      end;
  end;
  SCM.qrySwimClub.CheckBrowseMode;
  dlg := TPreferences.Create(self, SCM.scmConnection);
  dlg.ShowModal();
  dlg.Free;

  GetSCMPreferences();
  // deals with some repaint issues if event title is enabled/disabled
  { TODO -oBSA -cGeneral : Call action SCMRefresh? }
  Refresh_Event();
  SCM.qrySwimClub.Refresh();
end;

procedure TMain.Tools_QualifyTimesExecute(Sender: TObject);
var
  dlg: TQualifyTimes;
begin
  dlg := TQualifyTimes.Create(self);
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Tools_ScoreExecute(Sender: TObject);
var
  dlg: TPointsScored;
begin
  // display PASCAL PointsScored dialogue
  if not AssertConnection then
    exit;
  dlg := TPointsScored.Create(self);
  dlg.Connection := SCM.scmConnection;
  dlg.SwimClubID := SCM.GetSwimClubID;
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Tools_ScoreUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then
    DoEnable := true;
  (Sender as TAction).Enabled := DoEnable;
end;

procedure TMain.UpdateStatusBar;
var
  dt: TDateTime;
  s: String;
  aSessionID, i: integer;
begin

  if (SCM.dsSession.DataSet.IsEmpty) then
  begin
    Main.StatusBar1.Panels.BeginUpdate;
    for i := 0 to Main.StatusBar1.Panels.Count - 1 do
      Main.StatusBar1.Panels.Items[i].Text := '';
    Main.StatusBar1.Panels.EndUpdate;
    exit;
  end;

  if (SCM.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 2) then
  begin
    Main.StatusBar1.Panels.BeginUpdate;
    for i := 0 to Main.StatusBar1.Panels.Count - 1 do
      Main.StatusBar1.Panels.Items[i].Text := '';
    Main.StatusBar1.Panels.EndUpdate;
    exit;
  end;

  // Note: Most datasets try to maintain the current record position
  // when you call refresh.
  // next line fixes an exception error
  if (Main.StatusBar1.Panels.Count = 0) then
    exit;

  Main.StatusBar1.Panels.BeginUpdate;
  for i := 0 to Main.StatusBar1.Panels.Count - 1 do
  begin
    // Application.ProcessMessages;
    case (i) of
      0:
        begin
          dt := SCM.dsSession.DataSet.FieldByName('SessionStart').AsDateTime;
          if (dt > 0) then
          begin
            DateTimeToString(s, 'dd mmmm yyyy hh:nn', dt);
            // next line fixes an exception error
            Main.StatusBar1.Panels.Items[i].Text := 'Session: ' + s;
            Main.StatusBar1.Invalidate;
          end;
        end;
      1:
        begin
          // NOMINEES ...
          aSessionID := SCM.dsSession.DataSet.FieldByName('SessionID')
            .AsInteger;
          s := IntToStr(SCM.Session_GetNomineeCount(aSessionID));
          Main.StatusBar1.Panels.Items[i].Text := 'Nominees: ' + s;
        end;
      2:
        begin
          // ENTRANTS ...
          aSessionID := SCM.dsSession.DataSet.FieldByName('SessionID')
            .AsInteger;
          s := IntToStr(SCM.Session_GetEntrantCount(aSessionID));
          Main.StatusBar1.Panels.Items[i].Text := 'Entrants: ' + s;
        end;
    end;
  end;
  Main.StatusBar1.Panels.EndUpdate;
  Main.StatusBar1.Invalidate;

end;

end.
