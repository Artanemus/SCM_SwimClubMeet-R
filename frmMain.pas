unit frmMain;
{
 RUNNING FireDAC Monitor
 RUN FireDAC Monitor tool
 Place TFDMoniRemoteClientLink  onto main form
 Insert into connection definition (SEE - SCMSimpleConnect.pas)
}
//{$IFDEF DEBUG}
//  fDBConnection.Params.Add('MonitorBy=Remote');
//{$ENDIF}
{
WRAP SECTION TO ENABLE AND DISABLE MONITORING.
}
//{$IFDEF DEBUG}
//  { TODO -oBSA -cGeneral : FireDAC Tracing - DISABLE DEBBUG }
//  SCM.scmConnection.ConnectionIntf.Tracing := false;
//{$ENDIF}

//{$IFDEF DEBUG}
//        { TODO -oBSA -cGeneral : FireDAC- DISABLE DEBBUG }
//        SCM.scmConnection.ConnectionIntf.Tracing := true;
//{$ENDIF}



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
  Vcl.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  Vcl.ToolWin, Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.PlatformVclStylesActnCtrls,
  Data.FMTBcd, Data.SqlExpr, FireDAC.Moni.Base, FireDAC.Moni.RemoteClient,
  frame_INDV, frame_TEAM, SCMHelpers;

type

  TMain = class(TForm)
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionManager1: TActionManager;
    BindingsList1: TBindingsList;
    BindSourceDB1: TBindSourceDB;
    BindSourceDB2: TBindSourceDB;
    BindSourceDB3: TBindSourceDB;
    btnClearSearch: TButton;
    clbtnHeatStatus: TControlListButton;
    clistCheckBox: TControlListButton;
    clistEventCaption: TLabel;
    clistEventDistStrokeStr: TLabel;
    CloneSession2: TMenuItem;
    dbimgSwimClubLogo: TDBImage;
    dbnavEventNavigateNext: TDBNavigator;
    dbnavEventNavigatePrior: TDBNavigator;
    dbtxtDebugEntrant: TDBText;
    dbtxtDebugEvent: TDBText;
    dbtxtDebugHeat: TDBText;
    dbtxtDebugMember: TDBText;
    dbtxtDebugNominee: TDBText;
    dbtxtDebugSession: TDBText;
    dbtxtDebugSwimClub: TDBText;
    dbtxtEventCaption: TDBText;
    dbtxtNominateFullName: TDBText;
    dbtxtSwimClubCaption: TDBText;
    dbtxtSwimClubNickName: TDBText;
    DeleteEvent1: TMenuItem;
    DeleteHeat1: TMenuItem;
    DeleteSession1: TMenuItem;
    EditSession1: TMenuItem;
    EmptyLane1: TMenuItem;
    EntrantWidgets: TRelativePanel;
    Entrant_EmptyLane: TAction;
    Entrant_GotoMemberDetails: TAction;
    Entrant_MoveDown: TAction;
    Entrant_MoveUp: TAction;
    Entrant_Renumber: TAction;
    Entrant_Sort: TAction;
    Entrant_Strike: TAction;
    Entrant_SwapLanes: TAction;
    EventRpt1: TMenuItem;
    EventWidgets: TRelativePanel;
    Event_AutoSchedule: TAction;
    Event_BuildFinals: TAction;
    Event_BuildQuarterFinals: TAction;
    Event_BuildSemiFinals: TAction;
    Event_Delete: TAction;
    Event_Grid: TDBGrid;
    Event_MoveDown: TAction;
    Event_MoveUp: TAction;
    Event_NewRecord: TAction;
    Event_Renumber: TAction;
    Event_Report: TAction;
    Event_ToggleGridView: TAction;
    File_Exit: TAction;
    File_ExportCarnival: TAction;
    File_ImportCarnival: TAction;
    Filter1: TMenuItem;
    GotoMember: TMenuItem;
    HeatControlList: TControlList;
    HeatLeftPanel: TPanel;
    HeatNavigateControlList: TControlList;
    HeatNavigationPanel: TRelativePanel;
    HeatRightPanel: TPanel;
    HeatRpt1: TMenuItem;
    HeatWidgets: TRelativePanel;
    Heat_AutoBuild: TAction;
    Heat_BatchBuildHeats: TAction;
    Heat_BatchMarshallReport: TAction;
    Heat_BatchTimeKeeperReport: TAction;
    Heat_Delete: TAction;
    Heat_MarshallReport: TAction;
    Heat_MoveDown: TAction;
    Heat_MoveUp: TAction;
    Heat_NewRecord: TAction;
    Heat_PrintSet: TAction;
    Heat_Renumber: TAction;
    Heat_Report: TAction;
    Heat_TimeKeeperReport: TAction;
    Heat_ToggleStatus: TAction;
    Help_About: TAction;
    Help_LocalHelp: TAction;
    Help_OnlineHelp: TAction;
    Help_Website: TAction;
    ImageCollection1: TImageCollection;
    imeKeeper1: TMenuItem;
    INDV: TframeINDV;
    Label1: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    lblHeatNavigatorDistance: TLabel;
    lblHeatNavigatorEventNum: TLabel;
    lblHeatStrokeStr: TLabel;
    lblNomWarning: TLabel;
    lblSessionCaption: TLabel;
    lblSessionEventCaption: TLabel;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    LinkGridToDataSourceBindSourceDB3: TLinkGridToDataSource;
    LinkPropertyToFieldCaption: TLinkPropertyToField;
    LinkPropertyToFieldCaption2: TLinkPropertyToField;
    LinkPropertyToFieldCaption3: TLinkPropertyToField;
    LinkPropertyToFieldCaption4: TLinkPropertyToField;
    LinkPropertyToFieldCaption5: TLinkPropertyToField;
    Marshall1: TMenuItem;
    MoveDown1: TMenuItem;
    MoveDown2: TMenuItem;
    MoveDown3: TMenuItem;
    MoveUp1: TMenuItem;
    MoveUp2: TMenuItem;
    MoveUp3: TMenuItem;
    N1: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    NewEvent1: TMenuItem;
    NewRecord1: TMenuItem;
    NewSession1: TMenuItem;
    NominateBackPanel: TRelativePanel;
    NominateCenteredPanel: TPanel;
    NominateQuickPick: TRelativePanel;
    NominateRightPanel: TRelativePanel;
    NominateRpt1: TMenuItem;
    NominateWidgets: TRelativePanel;
    Nominate_ClearEventNominations: TAction;
    Nominate_ClearSessionNominations: TAction;
    Nominate_ControlList: TControlList;
    Nominate_Edit: TEdit;
    Nominate_Grid: TDBGrid;
    Nominate_MemeberDetails: TAction;
    Nominate_Report: TAction;
    Nominate_SortMembers: TAction;
    oggleSessionStatus1: TMenuItem;
    oggleStatus1: TMenuItem;
    PageControl1: TPageControl;
    pnlEventGrid: TPanel;
    pnlClient: TPanel;
    pnlClubData: TRelativePanel;
    pnlDebugInfo: TPanel;
    pnlPageControl: TPanel;
    pnlRight: TPanel;
    pnlSessClientTop: TPanel;
    pnlSessionClient: TPanel;
    pnlSessionLeft: TPanel;
    pnlSessLeftTop: TPanel;
    pnlTitleBar: TRelativePanel;
    pumEntrant: TPopupMenu;
    pumEvent: TPopupMenu;
    pumHeat: TPopupMenu;
    pumNominate: TPopupMenu;
    pumSession: TPopupMenu;
    Renumber1: TMenuItem;
    Renumber2: TMenuItem;
    sbtnMembers: TSpeedButton;
    sbtnRefresh: TSpeedButton;
    SCM_ManageMembers: TAction;
    SCM_Refresh: TAction;
    SCM_StatusBar: TAction;
    SessionRpt1: TMenuItem;
    SessionWidgets: TRelativePanel;
    Session_Clone: TAction;
    Session_Delete: TAction;
    Session_Edit: TAction;
    Session_Export: TAction;
    Session_Grid: TDBGrid;
    Session_Import: TAction;
    Session_New: TAction;
    Session_Report: TAction;
    Session_Sort: TAction;
    Session_ToggleLock: TAction;
    Session_ToggleVisible: TAction;
    ShapeBarEv1: TShape;
    ShapeBarEv2: TShape;
    ShapeDotEv1: TShape;
    ShapeHeatBar1: TShape;
    ShapeHeatBar2: TShape;
    ShapeHeatBar3: TShape;
    ShapeHeatDot1: TShape;
    ShapeHeatDot2: TShape;
    ShapeHeatDot3: TShape;
    ShapeHeatNavBlackLine: TShape;
    ShapeNomBar1: TShape;
    ShapeNomDot1: TShape;
    ShapeSessBar1: TShape;
    ShapeSessBar2: TShape;
    ShapeSessDot1: TShape;
    Sort1: TMenuItem;
    Sort2: TMenuItem;
    spbtnEntrantDown: TSpeedButton;
    spbtnEntrantEmptyLane: TSpeedButton;
    spbtnEntrantScratchLane: TSpeedButton;
    spbtnEntrantSort: TSpeedButton;
    spbtnEntrantSwapLanes: TSpeedButton;
    spbtnEntrantUp: TSpeedButton;
    spbtnEventDelete: TSpeedButton;
    spbtnEventMoveDown: TSpeedButton;
    spbtnEventMoveUp: TSpeedButton;
    spbtnEventNew: TSpeedButton;
    spbtnEventReport: TSpeedButton;
    spbtnEventToggleGridView: TSpeedButton;
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
    spbtnNominateReport: TSpeedButton;
    spbtnNominateSortMember: TSpeedButton;
    spbtnSessionDelete: TSpeedButton;
    spbtnSessionNew: TSpeedButton;
    spbtnSessionReport: TSpeedButton;
    spbtnSessionToggleLock: TSpeedButton;
    spbtnSessionToggleVisible: TSpeedButton;
    StatusBar1: TStatusBar;
    StrikeEntrant1: TMenuItem;
    SwapLanes1: TMenuItem;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TEAM: TframeTEAM;
    Tools_ConnectionManager: TAction;
    Tools_DisqualifyCodes: TAction;
    Tools_Divisions: TAction;
    Tools_House: TAction;
    Tools_LeaderBoard: TAction;
    Tools_Preferences: TAction;
    Tools_QualifyTimes: TAction;
    Tools_Score: TAction;
    Tools_Swimmercategory: TAction;
    vimage: TVirtualImage;
    vimgHeatCircle: TVirtualImage;
    vimgHeatNum: TVirtualImage;
    vimgHeatStroke: TVirtualImage;
    vimgNoHeatsMsg: TVirtualImage;
    vimgNoEventsMsg: TVirtualImage;
    vimgRelayDot: TVirtualImage;
    VirtualImage1: TVirtualImage;
    VirtualImageList1: TVirtualImageList;
    VirtualImageList2: TVirtualImageList;
    VirtualImageList3: TVirtualImageList;
    VirtualImageListMenu: TVirtualImageList;
    pnlHeatsTabSheet: TPanel;
    vimgHeatsNotifications: TVirtualImage;
    lblMsgNoNominees: TLabel;
    procedure ActionManager1Update(Action: TBasicAction; var Handled: boolean);
    procedure btnClearSearchClick(Sender: TObject);
    procedure clistCheckBoxClick(Sender: TObject);
    procedure Entrant_EmptyLaneExecute(Sender: TObject);
    procedure Entrant_EmptyLaneUpdate(Sender: TObject);
    procedure Entrant_GotoMemberDetailsExecute(Sender: TObject);
    procedure Entrant_GotoMemberDetailsUpdate(Sender: TObject);
    procedure Entrant_MoveDownExecute(Sender: TObject);
    procedure Entrant_MoveDownUpdate(Sender: TObject);
    procedure Entrant_MoveUpExecute(Sender: TObject);
    procedure Entrant_MoveUpUpdate(Sender: TObject);
    procedure Entrant_SortExecute(Sender: TObject);
    procedure Entrant_SortUpdate(Sender: TObject);
    procedure Entrant_StrikeExecute(Sender: TObject);
    procedure Entrant_StrikeUpdate(Sender: TObject);
    procedure Entrant_SwapLanesExecute(Sender: TObject);
    procedure Entrant_SwapLanesUpdate(Sender: TObject);
    procedure Event_AutoScheduleExecute(Sender: TObject);
    procedure Event_AutoScheduleUpdate(Sender: TObject);
    procedure Event_BuildFinalsExecute(Sender: TObject);
    procedure Event_BuildQuarterFinalsExecute(Sender: TObject);
    procedure Event_BuildSCMEventTypeUpdate(Sender: TObject);
    procedure Event_BuildSemiFinalsExecute(Sender: TObject);
    procedure Event_DeleteExecute(Sender: TObject);
    procedure Event_DeleteUpdate(Sender: TObject);
    procedure Event_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: integer; Column: TColumn; State: TGridDrawState);
    procedure Event_GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Event_MoveDownExecute(Sender: TObject);
    procedure Event_MoveUpExecute(Sender: TObject);
    procedure Event_MoveUpOrDownUpdate(Sender: TObject);
    procedure Event_NewRecordExecute(Sender: TObject);
    procedure Event_NewRecordUpdate(Sender: TObject);
    procedure Event_RenumberExecute(Sender: TObject);
    procedure Event_RenumberUpdate(Sender: TObject);
    procedure Event_ReportExecute(Sender: TObject);
    procedure Event_ReportUpdate(Sender: TObject);
    procedure Event_ToggleGridViewExecute(Sender: TObject);
    procedure Event_ToggleGridViewUpdate(Sender: TObject);
    procedure File_ExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
    procedure FormShow(Sender: TObject);
    procedure HeatControlListBeforeDrawItem(AIndex: integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure HeatNavigateControlListBeforeDrawItem(AIndex: integer;
      ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
    procedure Heat_AutoBuildExecute(Sender: TObject);
    procedure Heat_AutoBuildUpdate(Sender: TObject);
    procedure Heat_BatchBuildHeatsExecute(Sender: TObject);
    procedure Heat_BatchBuildHeatsUpdate(Sender: TObject);
    procedure Heat_BatchMarshallReportExecute(Sender: TObject);
    procedure Heat_BatchMarshallReportUpdate(Sender: TObject);
    procedure Heat_BatchTimeKeeperReportExecute(Sender: TObject);
    procedure Heat_BatchTimeKeeperReportUpdate(Sender: TObject);
    procedure Heat_DeleteExecute(Sender: TObject);
    procedure Heat_DeleteUpdate(Sender: TObject);
    procedure Heat_MarshallReportExecute(Sender: TObject);
    procedure Heat_MarshallReportUpdate(Sender: TObject);
    procedure Heat_MoveDownExecute(Sender: TObject);
    procedure Heat_MoveDownUpdate(Sender: TObject);
    procedure Heat_MoveUpExecute(Sender: TObject);
    procedure Heat_MoveUpUpdate(Sender: TObject);
    procedure Heat_NewRecordExecute(Sender: TObject);
    procedure Heat_NewRecordUpdate(Sender: TObject);
    procedure Heat_PrintSetExecute(Sender: TObject);
    procedure Heat_PrintSetUpdate(Sender: TObject);
    procedure Heat_ReportExecute(Sender: TObject);
    procedure Heat_ReportUpdate(Sender: TObject);
    procedure Heat_TimeKeeperReportExecute(Sender: TObject);
    procedure Heat_TimeKeeperReportUpdate(Sender: TObject);
    procedure Heat_ToggleStatusExecute(Sender: TObject);
    procedure Heat_ToggleStatusUpdate(Sender: TObject);
    procedure Help_AboutExecute(Sender: TObject);
    procedure Help_LocalHelpExecute(Sender: TObject);
    procedure Help_OnlineHelpExecute(Sender: TObject);
    procedure Help_OnlineHelpUpdate(Sender: TObject);
    procedure Help_WebsiteExecute(Sender: TObject);
    procedure Help_WebsiteUpdate(Sender: TObject);
    procedure Nominate_ControlListBeforeDrawItem(AIndex: integer;
      ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
    procedure Nominate_EditChange(Sender: TObject);
    procedure Nominate_GridDblClick(Sender: TObject);
    procedure Nominate_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: integer; Column: TColumn; State: TGridDrawState);
    procedure Nominate_MemeberDetailsExecute(Sender: TObject);
    procedure Nominate_MemeberDetailsUpdate(Sender: TObject);
    procedure Nominate_ReportExecute(Sender: TObject);
    procedure Nominate_ReportUpdate(Sender: TObject);
    procedure Nominate_SortMembersExecute(Sender: TObject);
    procedure Nominate_SortMembersUpdate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: boolean);
    procedure SCM_ManageMembersExecute(Sender: TObject);
    procedure SCM_ManageMembersUpdate(Sender: TObject);
    procedure SCM_RefreshExecute(Sender: TObject);
    procedure SCM_RefreshUpdate(Sender: TObject);
    procedure SCM_StatusBarExecute(Sender: TObject);
    procedure SCM_StatusBarUpdate(Sender: TObject);
    procedure Session_CloneExecute(Sender: TObject);
    procedure Session_CloneUpdate(Sender: TObject);
    procedure Session_DeleteExecute(Sender: TObject);
    procedure Session_DeleteUpdate(Sender: TObject);
    procedure Session_EditExecute(Sender: TObject);
    procedure Session_EditUpdate(Sender: TObject);
    procedure Session_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: integer; Column: TColumn; State: TGridDrawState);
    procedure Session_NewExecute(Sender: TObject);
    procedure Session_NewUpdate(Sender: TObject);
    procedure Session_ReportExecute(Sender: TObject);
    procedure Session_ReportUpdate(Sender: TObject);
    procedure Session_SortExecute(Sender: TObject);
    procedure Session_SortUpdate(Sender: TObject);
    procedure Session_ToggleGridUpdate(Sender: TObject);
    procedure Session_ToggleLockExecute(Sender: TObject);
    procedure Session_ToggleLockUpdate(Sender: TObject);
    procedure Session_ToggleVisibleExecute(Sender: TObject);
    procedure Session_ToggleVisibleUpdate(Sender: TObject);
    procedure Tools_ConnectionManagerExecute(Sender: TObject);
    procedure Tools_DisqualifyCodesExecute(Sender: TObject);
    procedure Tools_DivisionsExecute(Sender: TObject);
    procedure Tools_DivisionsUpdate(Sender: TObject);
    procedure Tools_HouseExecute(Sender: TObject);
    procedure Tools_HouseUpdate(Sender: TObject);
    procedure Tools_LeaderBoardExecute(Sender: TObject);
    procedure Tools_LeaderBoardUpdate(Sender: TObject);
    procedure Tools_PreferencesExecute(Sender: TObject);
    procedure Tools_QualifyTimesExecute(Sender: TObject);
    procedure Tools_ScoreExecute(Sender: TObject);
    procedure Tools_ScoreUpdate(Sender: TObject);
    procedure Tools_SwimmercategoryExecute(Sender: TObject);
    procedure Tools_SwimmercategoryUpdate(Sender: TObject);
  private
    bootprogress: TBootProgress;
//    fEntrantBgColor: TColor;
//    fEntrantEditBoxFocused: TColor;
//    fEntrantEditBoxNormal: TColor;
    // TRACK the MemberID of the last known member to have their
    // IsQualified status checked via Nominee_UpdateCheckListBoxQualified();
    fLastMemberQualified: integer;
    // Internet connection state
    fMyInternetConnected: boolean;
    { Private declarations }
    // For scroll wheel tracking on mouse ...
    FOrgDBGridWndProc: TWndMethod;
    fscmStyleName: String;
    fSessionClosedBgColor: TColor;
    fSessionClosedFontColor: TColor;
    prefDisplayDivisions: boolean;
    prefDisplaySwimmerCAT: boolean;
    prefEnableDCode: boolean;
    prefEnableTeamEvents: boolean;
    SCMEventList: TObjectList;
    fTeamActiveGrid: integer;
    function AssertConnection(): boolean; // Check connection to MSSQL DATABASE
    procedure DBGridWndProc(var Msg: TMessage);
    procedure DrawEventStatus(oGrid: TObject; Rect: TRect; Column: TColumn);
    // procedure EnableEvent_GridEllipse();
    procedure Event_BuildSCMEventType(Sender: TObject;
      EventType: scmEventFinalsType);
    // Miscellaneous - uncatagorized
    procedure GetSCMPreferences();
    // REFRESH
    procedure Refresh_Entrant(DoBookmark: boolean = true);
    procedure Refresh_Event(DoBookmark: boolean = true);
    procedure Refresh_Heat(DoBookmark: boolean = true);
    procedure Refresh_Nominate(DoBookmark: boolean = true);
    procedure Refresh_Team(DoBookmark: boolean = true);
    procedure Refresh_TeamEntrant(DoBookmark: boolean = true);
    // Generic TAction onExecute (extended params) for BATCH PRINT
    procedure Session_BatchReportExecute(Sender: TObject; RptType: scmRptType);
    // ENTRANT_GRID Toggle column display
    procedure ToggleDCode(DoEnable: boolean);
    procedure ToggleDivisions(SetVisible: boolean);
    procedure ToggleSwimmerCAT(SetVisible: boolean);
//    procedure ToggleTeamEvents(SetVisible: boolean);
    procedure ToggleVisibileTabSheet3;
    procedure ToggleVisibileTabSheet1;
  protected
    // posted by dmSCMNom : a refresh of the entrant grid is required.
    procedure Entrant_LaneWasCleaned(var Msg: TMessage); message SCM_LANEWASCLEANED;
    procedure Entrant_Scroll(var Msg: TMessage); message SCM_ENTRANTSCROLL;
    procedure Event_AssertState(var Msg: TMessage);
      message SCM_EVENTASSERTSTATE;
    procedure Event_AssertStatusState(var Msg: TMessage);
      message SCM_EVENTASSERTSTATUSSTATE;
    procedure Event_Scroll(var Msg: TMessage); message SCM_EVENTSCROLL;
    procedure Heat_Scroll(var Msg: TMessage); message SCM_HEATSCROLL;
    // Posted by TSCM.qryMemberQuickPick : AfterScroll
    procedure Nominate_Scroll(var Msg: TMessage); message SCM_NOMINATESCROLL;
    procedure Session_AssertStatusState(var Msg: TMessage);
      message SCM_SESSIONASSERTSTATUSSTATE;
    // windows messages ....
    procedure Session_Scroll(var Msg: TMessage); message SCM_SESSIONSCROLL;
    procedure UpdateINDVTEAM(var Msg: TMessage); message SCM_UPDATEINDVTEAM;
    procedure Team_Scroll(var Msg: TMessage); message SCM_TEAMSCROLL;
  public
    { Public declarations }
    fDoStatusBarUpdate: boolean; // FLAG ACTION - SCM_StatusBar.Enabled
    fSCMisInitializing: boolean; // FLAG FormCreate
    prefGenerateEventDescription: boolean;
    prefGenerateEventDescStr: string;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses

  System.UITypes, dmSCM, dlgBasicLogin, Vcl.Themes, SCMUtility,
  System.IniFiles, System.DateUtils,
  dlgCloneSession, rptSessionReportA, rptSessionReportB,
  dlgNewSession, dmAutoBuildV2, rptEventReportA, rptEventReportB,
  dlgAutoBuild_Heats, dlgAbout, dlgPreferences, rptNominateReportA,
  rptNominateReportB, dlgQualifyTimes, dlgSwimmerCategory,
  FireDAC.VCLUI.ConnEdit, FireDAC.Stan.Param, frmManageMember,
  rptMarshallReportA,
  rptMarshallReportB, rptTimeKeeperReportA, rptTimeKeeperReportB, dlgHouse,
  dlgAutoBuild_Finals, dlgPointsScored, dlgDivision, dlgLeaderBoard,
  dlgSelectPrinter, ioutils, dlgBatchProgress, dlgAutoBuild_Batch, ShellAPI,
  UEnvVars, dlgEntrantPicker, dlgEntrantPickerCTRL, dmSCMNom, dlgSwapLanes,
  dlgDBVerInfo, rptHeatReportA, rptHeatReportB, frmDisqualificationCodes,
  dlgAutoSchedule, dlgDCodePicker, dmSCMHelper;

procedure TMain.ActionManager1Update(Action: TBasicAction;
  var Handled: boolean);
begin
  // kill the statusbar action during initialization.
  if AssertConnection then
  begin
    if fSCMisInitializing then
      SCM_StatusBar.Enabled := false;
  end;
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
  // CLOSE, SET new PARMS and OPEN the database used by the controllist.
  // This is needed for images in event Nominate_ControlListBeforeDrawItem
  SCM.Nominate_UpdateControlList(SCM.Session_ID, MemberID);
  // CLOSE makes inactive the bind source, but DATASET connection ok.
  if not BindSourceDB1.DataSet.Active then
    BindSourceDB1.DataSet.Active := true;
  // paint the member tomatoe red in the nominate_grid
  Nominate_Grid.Invalidate;

  // S T A T U S B A R .
  // Modifying the nominees changes the Session's Nominees Totals
  fDoStatusBarUpdate := true; // flag set false after SCM_StatusBarExecute.
  SCM_StatusBar.Update;
  SCM_StatusBar.Execute;
  // E V E N T _ G R I D .
  // The number of nominations has changed - event grid will need to update.
  Refresh_Event;

end;

procedure TMain.DBGridWndProc(var Msg: TMessage);
begin
  if ((Msg.Msg = WM_VSCROLL) and (Msg.WParamLo = SB_THUMBTRACK)) then
    Msg.WParamLo := SB_THUMBPOSITION;
  if Assigned(FOrgDBGridWndProc) then
    FOrgDBGridWndProc(Msg);
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

// procedure TMain.EnableEvent_GridEllipse;
// var
// i: integer;
// col: TColumn;
// begin
// for i := 0 to Event_Grid.Columns.Count - 1 do
// begin
// col := Event_Grid.Columns.Items[i];
// if (col.FieldName = 'ScheduleDT') then
// begin
// // editing in the this cell isn't allowed - use ellipse button.
// col.ButtonStyle := cbsEllipsis;
// Event_Grid.Repaint;
// break;
// end;
// end;
// end;

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
    // Generic routine for INDV and TEAM
    success := SCM.EmptyLane;
    if not success then
      beep;
  end;

  if SCM.Event_IsINDV then
  begin
  if INDV.Grid.CanFocus then
    INDV.Grid.SetFocus;
  end
  else
  begin
  if TEAM.Grid.CanFocus then
    TEAM.Grid.SetFocus;
  end;

end;

procedure TMain.Entrant_EmptyLaneUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.Session_IsLocked then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.Heat_IsClosed then
          // is there any entrants?
          if not SCM.dsEntrant.DataSet.IsEmpty then
            DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Entrant_GotoMemberDetailsExecute(Sender: TObject);
var
  dlg: TManageMember;
  MemberID: integer;
begin
  if not AssertConnection then
    exit;
  dlg := TManageMember.Create(self);
  MemberID := SCM.dsEntrant.DataSet.FieldByName('MemberID').AsInteger;
  try
    dlg.Prepare(SCM.scmConnection, 1, MemberID);
    dlg.ShowModal;
  finally
    dlg.Free;
  end;
end;

procedure TMain.Entrant_GotoMemberDetailsUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // No members listed.
    if not SCM.dsEntrant.DataSet.IsEmpty then
      DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Entrant_LaneWasCleaned(var Msg: TMessage);
begin
  // message posted by TSCMNom SCM_LANEWASCLEANED
  Refresh_Entrant;
end;

procedure TMain.Entrant_MoveDownExecute(Sender: TObject);
begin
  if SCM.Event_IsINDV then
    INDV.GridMoveDown(Sender)
  else
    TEAM.GridMoveDown(Sender);
end;

procedure TMain.Entrant_MoveDownUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.Session_IsLocked then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.Heat_IsClosed then
        begin
          if SCM.Event_IsINDV then
          begin
            // is there any entrants?
            if not SCM.dsEntrant.DataSet.IsEmpty then
              DoEnable := true;
          end
          else
          begin
            // is there any Relays?
            if not SCM.dsTeam.DataSet.IsEmpty then
              DoEnable := true;
          end;
        end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Entrant_MoveUpExecute(Sender: TObject);
begin
  if SCM.Event_IsINDV then
    INDV.GridMoveUp(Sender)
  else
    TEAM.GridMoveUp(Sender);
end;

procedure TMain.Entrant_MoveUpUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.Session_IsLocked then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.Heat_IsClosed then
        begin
          if SCM.Event_IsINDV then
          begin
            // is there any entrants?
            if not SCM.dsEntrant.DataSet.IsEmpty then
              DoEnable := true;
          end
          else
          begin
            // is there any Relays?
            if not SCM.dsTeam.DataSet.IsEmpty then
              DoEnable := true;
          end;
        end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Entrant_Scroll(var Msg: TMessage);
var
  fld: TField;
begin
  // messages posted by TSCM.qryMemberQuickPickAfterScroll
  {TODO -oBSA -cGeneral : TEAM Entrant_Scroll}
  if not AssertConnection then
    exit;
  if SCM.Event_IsINDV  and INDV.Grid.Focused then
  begin
    // After moving row re-engage editing for selected fields.
    fld := INDV.Grid.SelectedField;
    if Assigned(fld) then
    begin
      if (fld.FieldName = 'RaceTime') or (fld.FieldName = 'DCode') or
        (fld.FieldName = 'FullName') then
      begin
        INDV.Grid.EditorMode := true;
        // INDV.Grid.SelectAll;
      end
      else
        INDV.Grid.EditorMode := false;
    end;
  end;
end;

procedure TMain.Entrant_SortExecute(Sender: TObject);
var
  HeatID, EntrantID: integer;
begin
  if SCM.Event_IsINDV then
  begin
    {TODO -oBSA -cGeneral : Routine should be placed in data module...}
    with SCM.dsEntrant.DataSet do
    begin
      DisableControls;
      // needed to cue-to-entrant
      EntrantID := FieldByName('EntrantID').AsInteger;
      // the heat to pad
      HeatID := FieldByName('HeatID').AsInteger;
      SCM.Entrant_PadWithEmptyLanes(HeatID);
      SCM.Lane_RenumberLanes(HeatID, false); // force renumber
      // sort
      if (SCM.Entrant_Sort(HeatID)) then
      begin
        Refresh;
        // go cue-to-entrant
        SCM.Entrant_Locate(EntrantID);
      end;
      EnableControls;
    end;
  end
  else
  begin
    {TODO -oBSA -cGeneral : SortExecute Event_IsTEAM....}
  end;
end;

procedure TMain.Entrant_SortUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.Session_IsLocked then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.Heat_IsClosed then
          // is there any entrants?
          if not SCM.dsEntrant.DataSet.IsEmpty then
            DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
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
    success := SCM.StrikeLane;
    if not success then
      beep;
  end;

  if SCM.Event_IsINDV then
  begin
  if INDV.Grid.CanFocus then
    INDV.Grid.SetFocus;
  end
  else
  begin
  if TEAM.Grid.CanFocus then
    TEAM.Grid.SetFocus;
  end;
end;

procedure TMain.Entrant_StrikeUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.Session_IsLocked then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.Heat_IsClosed then
          // is there any entrants?
          if not SCM.dsEntrant.DataSet.IsEmpty then
            DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Entrant_SwapLanesExecute(Sender: TObject);
var
  dlg: TSwapLanes;
begin
  if SCM.Event_IsINDV then
  begin
  dlg := TSwapLanes.Create(self);
  if IsPositiveResult(dlg.ShowModal) then
    Refresh_Entrant;
  dlg.Free;
  end
  else
  begin
    { TODO -oBSA -cGeneral : Dialogue - Swap relay teams in lanes }
    { dlg := TSwapLanesTEAM.Create(self);
      if IsPositiveResult(dlg.ShowModal) then
      Refresh_Entrant;
      dlg.Free; }
  end;

  if INDV.Grid.CanFocus then
    INDV.Grid.SetFocus else TEAM.Grid.SetFocus;
end;

procedure TMain.Entrant_SwapLanesUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.Session_IsLocked then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        // is the current heat closed?
        if not SCM.Heat_IsClosed then
          // is there any entrants?
          if not SCM.dsEntrant.DataSet.IsEmpty then
            DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
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
  // Toggle EVENT_GRID EventStatusID.
  // If all the heats for the event have been closed then a tick is displayed
  // in the UI.
  i := SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger;
  if (i > 0) then
  begin
    AllClosed := SCM.Event_AllHeatsAreClosed(i);
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

procedure TMain.Event_AutoScheduleExecute(Sender: TObject);
var
  dlg: TAutoSchedule;
  EventID: integer;
  rtnValue: TModalResult;
begin
  if not AssertConnection then
    exit;
  SCM.dsEvent.DataSet.DisableControls;
  EventID := SCM.Event_ID;
  dlg := TAutoSchedule.CreateWithConnection(self, SCM.scmConnection);
  dlg.SessionID := SCM.Session_ID;
  rtnValue := dlg.ShowModal;
  dlg.Free;
  if IsPositiveResult(rtnValue) then
  begin
    SCM.dsEvent.DataSet.Refresh;
    SCM.Event_Locate(EventID);
  end;
  SCM.dsEvent.DataSet.EnableControls;
end;

procedure TMain.Event_AutoScheduleUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    if not SCM.dsSession.DataSet.IsEmpty then
    begin
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
    end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Event_BuildFinalsExecute(Sender: TObject);
begin
  Event_BuildSCMEventType(Sender, ftFinals);
end;

procedure TMain.Event_BuildQuarterFinalsExecute(Sender: TObject);
begin
  Event_BuildSCMEventType(Sender, ftSemi);
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

procedure TMain.Event_BuildSemiFinalsExecute(Sender: TObject);
begin
  Event_BuildSCMEventType(Sender, ftQuarter);
end;

procedure TMain.Event_DeleteExecute(Sender: TObject);
var
  rtnValue, aEventID: integer;
  SQL: String;
  HasClosedHeats, HasRacedHeats: boolean;
begin
  aEventID := SCM.Event_ID;
  HasClosedHeats := SCM.Event_HasClosedHeats(aEventID);
  HasRacedHeats := SCM.Event_HasRacedHeats(aEventID);
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
      'Including all (open or raced) heats, entrant and nomination data?'
  else
    SQL := SQL + 'Including all open heats, entrant and nomination data?';
  rtnValue := MessageDlg(SQL, mtConfirmation, [mbYes, mbNo], 0, mbYes);

  if (rtnValue = mrYes) then
  begin
    SCM.Event_DeleteExclude(SCM.Event_ID, false); // delete the current selected event.
    Refresh_Event;
    ToggleVisibileTabSheet1;
  end;
end;

procedure TMain.Event_DeleteUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.Session_IsLocked then
      // are there any events?
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
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
    TAction(Sender).Enabled := DoEnable;
    exit;
  end;
  // session is locked
  if (SCM.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 2) then
  begin
    TAction(Sender).Enabled := DoEnable;
    exit;
  end;
  // we need events to move up or down
  { TODO -oBSA -cGeneral : In a perfect world we would need a least two events. }
  if not SCM.dsEvent.DataSet.IsEmpty then
    DoEnable := true;
  // 13.10.2020
  // events can be moved up or down (re-ordered)
  // even if the heat has been raced or closed
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Event_NewRecordExecute(Sender: TObject);
begin
  if not AssertConnection then
    exit;
  SCM.dsEvent.DataSet.CheckBrowseMode;
  SCM.dsEvent.DataSet.Append();
  ToggleVisibileTabSheet1;
end;

procedure TMain.Event_NewRecordUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // connected?
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.Session_IsLocked then
      DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
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
    if not SCM.Session_IsLocked then
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Event_ReportExecute(Sender: TObject);
var
  rptA: TEventReportA;
  rptB: TEventReportB;
begin
  // finalize editing within table
  Event_Grid.DataSource.DataSet.CheckBrowseMode;
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
    if not SCM.Session_IsLocked then
      // Are there any Events?
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Event_Scroll(var Msg: TMessage);
var
  EnabledState: boolean;
begin

  if not AssertConnection then
    exit;
  EnabledState := false;
  // is the session is Open?
  if (SCM.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 1) then
  begin
    // Is the heat Open?
    if (SCM.dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger <> 3) then
      EnabledState := true;
  end;

  ToggleVisibileTabSheet3;

  // SYNC the enabled state of the INDV.Grid to the
  // session/heat status.
  if (INDV.Grid.Enabled <> EnabledState) then
    INDV.Grid.Enabled := EnabledState;
  if (TEAM.Grid.Enabled <> EnabledState) then
    TEAM.Grid.Enabled := EnabledState;

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
      ImageIndex := 1;
      // collapse session grid
      pnlSessionLeft.Visible := false;
    end
    else
    begin
      ImageIndex := 0;
      // reveal session grid (default)
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

    // INDV or RELAY event type ....
//    fld := SCM.qryEvent.FindField('luEventType');
//    if Assigned(fld) then
//      fld.Visible := Checked;

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
  TAction(Sender).Enabled := DoEnable;
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
  aBasicLogin: TBasicLogin;
  // 24/04/2020 uses simple INI access
  result: TModalResult;
  hf: NativeUInt;
  col: TColumn;
begin
  bootprogress := nil;
  SCMEventList := nil;
  fDoStatusBarUpdate := false; // false : aborts StatusBar Update procedure.
  fSCMisInitializing := true;
  fSessionClosedFontColor := clWebTomato; // Use to custom draw closed session
  fSessionClosedBgColor := clAppWorkSpace; // Use to custom draw closed session
  fMyInternetConnected := true;

  // UI indicator for focused TEAM GRID vs TEAMENTRANT GRID
  // (TPanel OnEnter event... displays maroon border.)
  fTeamActiveGrid := 0;
  Team.Panel2.BorderWidth := 0;
  Team.Panel1.BorderWidth := 0;

  prefEnableTeamEvents := false;
  prefEnableDCode := false;

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
  aBasicLogin.DBName := 'SwimClubMeet';
  aBasicLogin.DBConnection := SCM.scmConnection;
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
  // INDV.Grid->DefaultDrawing = false;

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
      // Session1.Enabled := false;
      // Tools1.Enabled := false;
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

  // 22/12/22
  // L I N K   G R I D S   T O   D A T A S O U R C E S .
  Event_Grid.DataSource := SCM.dsEvent;
  Nominate_Grid.DataSource := SCM.dsNominateMembers;
  INDV.Grid.DataSource := SCM.dsEntrant;
  TEAM.Grid.DataSource := SCM.dsTeam;
  TEAM.GridEntrant.DataSource := SCM.dsTeamEntrant;

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
  dbtxtNominateFullName.DataSource := SCM.dsNominateMembers;
  // LINK EVENT NAVIGATOR
  dbnavEventNavigatePrior.DataSource := SCM.dsEvent;
  dbnavEventNavigateNext.DataSource := SCM.dsEvent;
  // L I N K   C L U B   L O G O  .
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

  {
    Sort out the menubar font height - so tiny!

    The font of the MenuItemTextNormal element (or any other) in the style
    designer has no effect, this is because the Vcl Style Engine simply
    ignores the font-size and font-name, and just uses the font color defined in
    the vcl style file.

    S O L U T I O N :

    Define and register a new TActionBarStyleEx descendent and override
    the DrawText methods of the TCustomMenuItem and TCustomMenuButton
    classes, using the values of the Screen.MenuFont to draw the menu
  }

  Screen.MenuFont.Name := 'Segoe UI Semibold';
  Screen.MenuFont.Size := 12;
  ActionManager1.Style := PlatformVclStylesStyle;

  {
    When the Columns.State property of the grid is csDefault, grid columns
    are dynamically generated from the visible fields of the dataset and the
    order of columns in the grid matches the order of fields in the dataset.
  }
  Session_Grid.Columns.State := csDefault;
  Event_Grid.Columns.State := csDefault;
  Nominate_Grid.Columns.State := csDefault;

  {
    Small tidy-up on the grid displays.
    Set the drop-downs rowcount.
    Uses developer's Class Helper
  }
  col := Event_Grid.ColumnByName('luDistance');
  if Assigned(col) then  col.DropDownRows := 12;
  col := Event_Grid.ColumnByName('luStroke');
  if Assigned(col) then  col.DropDownRows := 6;
//  col := Event_Grid.ColumnByName('luEventType');
//  if Assigned(col) then  col.DropDownRows := 3;


  // PREPARE GRIDS (not framed) - COLUMN VISIBILITY
  ToggleDCode(prefEnableDCode);
  ToggleSwimmerCAT(prefDisplaySwimmerCAT);
  ToggleDivisions(prefDisplayDivisions);

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

  // S T A T U S B A R .
  fDoStatusBarUpdate := true; // flag set false after SCM_StatusBarExecute.
  SCM_StatusBar.Update;
  SCM_StatusBar.Execute;

  if Session_Grid.CanFocus then
    Session_Grid.SetFocus;

  INDV.Align := alClient;
  INDV.Visible := true;
  TEAM.Align := alClient;
  TEAM.Visible := false;

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

  // Color assignment to custom paint closed sessions in grid.
  // -------------------------------------------
  css := TStyleManager.Style[TStyleManager.ActiveStyle.Name];
  if Assigned(css) then
  begin
    fSessionClosedFontColor := css.GetStyleFontColor(sfEditBoxTextDisabled);
    fSessionClosedBgColor := css.GetStyleColor(scGrid);
  end
  else
  begin
    fSessionClosedFontColor := clWebTomato;
    fSessionClosedBgColor := clAppWorkSpace;
  end;


  // 2023.06.26
  prefEnableTeamEvents := iFile.ReadBool('Preferences', 'EnableTeamEvents', false);
  prefEnableDCode := iFile.ReadBool('Preferences', 'EnableDCodes', false);
  prefDisplaySwimmerCAT := iFile.ReadBool('Preferences', 'DisplaySwimmerCAT', false);
  prefDisplayDivisions := iFile.ReadBool('Preferences', 'DisplayDivisions', false);

  iFile.Free;

  // Update the preferences used by dmSCM
  if AssertConnection then
    SCM.ReadPreferences(IniFileName);

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
  i, j: integer;
begin
  with BindSourceDB2.DataSet do
  begin
    lblHeatNavigatorDistance.Caption := FieldByName('ABREV').AsString;
    s := FieldByName('luStroke').AsString;
    i := FieldByName('StrokeID').AsInteger;
    j := FieldByName('EventTypeID').AsInteger;
    s := s.SubString(0, 4);

    // RELAY DOT VISIBILITY
    if (j=0) or (j=1) then
      vimgRelayDot.Visible := false
    else
      vimgRelayDot.Visible := true;

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
  if not SCM.Event_HasNominees(EventID) then
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
    // Event's grid need to be refreshed to update NOM# and ENT#
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
    if not SCM.Session_IsLocked then
      // are there any Events?
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_BatchBuildHeatsExecute(Sender: TObject);
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
    while not Eof do
    // iterate over the events ...
    begin
      // Is the EVENT CLOSED?
      if (FieldByName('EventStatusID').AsInteger = 2) then
      begin
        Next;
        continue;
      end;
      // 2023.02.16
      // DELETE HEATS ...  For current event. Only open heats are deleted.
      SCM.Heat_DeleteALLExclude(FieldByName('EventID').AsInteger);
      // QUICK TEST - Do we have NOMINEES?
      if not SCM.Event_HasNominees(FieldByName('EventID').AsInteger) then
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

procedure TMain.Heat_BatchBuildHeatsUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if not SCM.Session_IsLocked then
      if not SCM.dsSession.DataSet.IsEmpty then
        // Do we have Events?.
        if not SCM.dsEvent.DataSet.IsEmpty then
          DoEnable := true;
  end;
  // no connection or no events or event is closed - disable actions
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_BatchMarshallReportExecute(Sender: TObject);
begin
  Session_BatchReportExecute(Sender, rtMarshall);
end;

procedure TMain.Heat_BatchMarshallReportUpdate(Sender: TObject);
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

procedure TMain.Heat_BatchTimeKeeperReportExecute(Sender: TObject);
begin
  Session_BatchReportExecute(Sender, rtTimeKeeper);
end;

procedure TMain.Heat_BatchTimeKeeperReportUpdate(Sender: TObject);
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

procedure TMain.Heat_DeleteExecute(Sender: TObject);
var
  results: integer;
begin
  // actn.Update dictates if this routine is accessable.
  // The heat is CLOSED.
  if SCM.Heat_IsClosed then
  begin
    MessageDlg('This heat is CLOSE' + sLineBreak +
      'The heat can''t be deleted.', mtInformation, [mbOK], 0, mbOK);
    exit;
  end;
  // The heat is RACED
  if SCM.Heat_IsRaced then
  begin
    results := MessageDlg('WARNING: This heat is RACED.' + sLineBreak +
      'Racetimes and entrant data will be lost if you delete this heat.' +
      sLineBreak + 'Do you wish to delete the heat?', mtWarning,
      [mbYes, mbNo], 0, mbNo);
    if (results <> mrYes) then
      exit;
  end;
  // Heat status is RACED or OPEN. Final confirmation message.
  if SCM.Heat_IsRaced then
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
  begin
    SCM.Heat_DeleteExclude(SCM.dsHeat.DataSet.FieldByName('HeatID').AsInteger, false);
    Refresh_Heat();
    ToggleVisibileTabSheet3;
  end;
end;

procedure TMain.Heat_DeleteUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.Session_IsLocked then
      // are there any Events?
      if not SCM.dsEvent.DataSet.IsEmpty then
        // are there any Heats?
        if not SCM.dsHeat.DataSet.IsEmpty then
          DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_MarshallReportExecute(Sender: TObject);
var
  rptA: TMarshallReportA;
  rptB: TMarshallReportB;
  EventID: integer;
begin
  if not AssertConnection then
    exit;

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
  except
    on E: Exception do
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
  TAction(Sender).Enabled := DoEnable;
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
    if not SCM.Session_IsLocked then
      // By default, heat is assumed to be LOCKED.
      // This routine asserts the state of heat dataset (connection, active and
      // not isempty) and if all checks pass, returns the record status.
      // Not locked if the HeatStatusID <> 3.
      if not SCM.Heat_IsClosed then
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
    if not SCM.Session_IsLocked then
      // By default, heat is assumed to be LOCKED.
      // This routine asserts the state of heat dataset (connection, active and
      // not isempty) and if all checks pass, returns the record status.
      // Not locked if the HeatStatusID <> 3.
      if not SCM.Heat_IsClosed then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_NewRecordExecute(Sender: TObject);
var
aEventID: integer;
begin
  // The event must have DistanceID Assigned!!!
  aEventID := SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger;
  if SCM.Event_EventTypeID(aEventID) = 0 then
    raise Exception.Create('Error: The event has not been assigned a distance.');
  SCM.Heat_NewRecord;
  ToggleVisibileTabSheet3;
end;

procedure TMain.Heat_NewRecordUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.Session_IsLocked then
      // are there any Events?
      if not SCM.dsEvent.DataSet.IsEmpty then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
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
  if not AssertConnection then
    exit;

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
    // set printer-name
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
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_ReportExecute(Sender: TObject);
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
    on E: Exception do
      ShowMessage('Error opening report.');
  end;
  if HeatControlList.CanFocus then
    HeatControlList.SetFocus;
end;

procedure TMain.Heat_ReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Are there any heats? Note: Locked sessions can be printed.
    if not SCM.dsHeat.DataSet.IsEmpty then
      DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_Scroll(var Msg: TMessage);
//var
//  DoEnable: boolean;
begin
  {
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
  // Set the INDV grid's 'disabled' state.
  if (INDV.Grid.Enabled <> DoEnable) then
    INDV.Grid.Enabled := DoEnable;
  // Set the TEAM 'disabled' state.
  if (TEAM.Grid.Enabled <> DoEnable) then
    TEAM.Grid.Enabled := DoEnable;
  }
end;

procedure TMain.Heat_TimeKeeperReportExecute(Sender: TObject);
var
  rptA: TTimeKeeperReportA;
  rptB: TTimeKeeperReportB;
  HeatID: integer;
begin
  if not AssertConnection then
    exit;
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
  except
    on E: Exception do
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
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_ToggleStatusExecute(Sender: TObject);
var
  i: integer;
begin
  SCM.Heat_ToggleStatus;
  i := BindSourceDB3.DataSource.DataSet.FieldByName('HeatStatusID').AsInteger;
  // i := SCM.dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger;
  case i of
    1, 2:
      INDV.Grid.Enabled := true;
    3:
      INDV.Grid.Enabled := false;
  end;
  if HeatControlList.CanFocus then
    HeatControlList.SetFocus;

  // All the heats have been closed then the event grid will display a tick.
  PostMessage(Main.Handle, SCM_EVENTASSERTSTATUSSTATE, 0, 0);

end;

procedure TMain.Heat_ToggleStatusUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not SCM.Session_IsLocked then
      // are there any heats?
      if not SCM.dsHeat.DataSet.IsEmpty then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Help_AboutExecute(Sender: TObject);
var
  dlg: TAbout;
begin
  dlg := TAbout.Create(self);
  dlg.DBName := 'SwimClubMeet'; // DEFAULT
  // Note: Safe to call TAbout without connection params assigned.
  if AssertConnection then
    dlg.DBConnection := SCM.scmConnection;
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Help_LocalHelpExecute(Sender: TObject);
var
  base_URL: string;
begin
  base_URL := '%PROGRAMDATA%\Artanemus\SCM\SCM_Help\index.htm';
  // Expand Environment Variables
  base_URL := UEnvVars.ExpandEnvVars(base_URL);
  ShellExecute(0, nil, PWideChar(base_URL), nil, nil, SW_SHOWNORMAL);
end;

procedure TMain.Help_OnlineHelpExecute(Sender: TObject);
var
  base_URL: string;
begin
  if CheckInternetA then
  begin
    base_URL := 'http://artanemus.github.io/manual/index.htm';
    ShellExecute(0, nil, PWideChar(base_URL), nil, nil, SW_SHOWNORMAL);
  end
  else
  begin
    MessageDlg('No internet connection found!', TMsgDlgType.mtError, [mbOK], 0);
    // NOTE: requires a restart of app after re-connection.
    fMyInternetConnected := false;
  end;
end;

procedure TMain.Help_OnlineHelpUpdate(Sender: TObject);
begin
  if fMyInternetConnected then
    TAction(Sender).Enabled := true
  else
    TAction(Sender).Enabled := false;
end;

procedure TMain.Help_WebsiteExecute(Sender: TObject);
var
  base_URL: string;
begin
  if CheckInternetA then
  begin
    base_URL := 'http://artanemus.github.io';
    ShellExecute(0, 'open', PWideChar(base_URL), nil, nil, SW_SHOWNORMAL);
  end
  else
  begin
    MessageDlg('No internet connection found!', TMsgDlgType.mtError, [mbOK], 0);
    // NOTE: requires a restart of app after re-connection.
    fMyInternetConnected := false;
  end;
end;

procedure TMain.Help_WebsiteUpdate(Sender: TObject);
begin
  if fMyInternetConnected then
    TAction(Sender).Enabled := true
  else
    TAction(Sender).Enabled := false;
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
      clistEventCaption.Caption := ''
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
begin
  Nominate_MemeberDetailsExecute(self);
end;

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
      SessionID := SCM.Session_ID;
      SQL := 'SELECT Count(MemberID) FROM [SwimClubMeet].[dbo].Nominee ' +
        sLineBreak + 'INNER JOIN [SwimClubMeet].[dbo].[Event] ON ' + sLineBreak
        + '[SwimClubMeet].[dbo].Nominee.EventID = [SwimClubMeet].[dbo].[Event].EventID '
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

procedure TMain.Nominate_MemeberDetailsExecute(Sender: TObject);
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

procedure TMain.Nominate_MemeberDetailsUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // No members listed.
    if not Nominate_Grid.DataSource.DataSet.IsEmpty then
      DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
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

procedure TMain.Nominate_ReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // No members listed. Nothing to sort.
    if not Nominate_Grid.DataSource.DataSet.IsEmpty then
      DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Nominate_Scroll(var Msg: TMessage);
var
  MemberID: integer;
  success: boolean;
begin
  if AssertConnection then
  begin
    MemberID := SCM.dsNominateMembers.DataSet.FieldByName('MemberID').AsInteger;
    success := SCM.Nominate_UpdateControlList(SCM.Session_ID, MemberID);
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
    if not SCM.Session_IsLocked then
      // No members listed. Nothing to sort.
      if not Nominate_Grid.DataSource.DataSet.IsEmpty then
        DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.PageControl1Change(Sender: TObject);
begin


  // Update page
  case (PageControl1.TabIndex) of
    // 0: // S e s s i o n .

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
          lblNomWarning.Visible := false;
          Refresh_Nominate;
          if (SCM.dsMember.DataSet.IsEmpty) then
          begin
//            lblNomWarning.Font.Color := clWebTomato;
            lblNomWarning.Caption := 'No Members';
            lblNomWarning.Visible := true;
          end
          else if (SCM.dsEvent.DataSet.IsEmpty) then
          begin
//            lblNomWarning.Font.Color := clWebTomato;
            lblNomWarning.Caption := 'No Events in Session';
            lblNomWarning.Visible := true;
          end
          else if (SCM.dsSession.DataSet.IsEmpty) then
          begin
//            lblNomWarning.Font.Color := clWebTomato;
            lblNomWarning.Caption := 'Session is Empty';
            lblNomWarning.Visible := true;
          end
          else if SCM.Session_IsLocked then
          begin
//            lblNomWarning.Font.Color := clWebTomato;
            lblNomWarning.Caption := 'Session is Locked';
            lblNomWarning.Visible := true;
          end;

        end;
        // places focus onto the nominees list
        if Nominate_Grid.CanFocus then
          Nominate_Grid.SetFocus;
      end;
    2:
      // H e a t s .
      begin
        ToggleVisibileTabSheet3;
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

procedure TMain.Refresh_Entrant(DoBookmark: boolean = true);
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

procedure TMain.Refresh_Event(DoBookmark: boolean = true);
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
      SCM.Event_Renumber;
      try
        GotoBookmark(bm);
      except
        on E: Exception do
      end;
    end;
    EnableControls;
  end;
end;

procedure TMain.Refresh_Heat(DoBookmark: boolean = true);
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

procedure TMain.Refresh_Nominate(DoBookmark: boolean = true);
var
  bm: TBookmark;
begin
  if not AssertConnection then
    exit;
  // Update the SCM.dsQmember's table
  // (may have changed if the user has been editing the member's table
  // in the member's dialogue)
  with SCM.dsNominateMembers.DataSet do
  begin
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

procedure TMain.Refresh_Team(DoBookmark: boolean);
var
  bm: TBookmark;
begin
  if not AssertConnection then
    exit;
  With SCM.dsTeam.DataSet do
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

procedure TMain.Refresh_TeamEntrant(DoBookmark: boolean);
var
  bm: TBookmark;
begin
  if not AssertConnection then
    exit;
  With SCM.dsTeamEntrant.DataSet do
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
  TAction(Sender).Enabled := DoEnable;
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
  SCM.dsTeam.DataSet.DisableControls;
  SCM.dsTeamEntrant.DataSet.DisableControls;
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
  // TEAM
  Refresh_Team;
  // TEAMENTRANT
  Refresh_Team;
  SCM.dsSession.DataSet.EnableControls;
  SCM.dsEvent.DataSet.EnableControls;
  SCM.dsHeat.DataSet.EnableControls;
  SCM.dsEntrant.DataSet.EnableControls;
  SCM.dsTeam.DataSet.EnableControls;
  SCM.dsTeamEntrant.DataSet.EnableControls;
end;

procedure TMain.SCM_RefreshUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.SCM_StatusBarExecute(Sender: TObject);
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
    fDoStatusBarUpdate := false;
    exit;
  end;

  if (SCM.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 2) then
  begin
    Main.StatusBar1.Panels.BeginUpdate;
    for i := 0 to Main.StatusBar1.Panels.Count - 1 do
      Main.StatusBar1.Panels.Items[i].Text := '';
    Main.StatusBar1.Panels.EndUpdate;
    fDoStatusBarUpdate := false;
    exit;
  end;

  // Note: Most datasets try to maintain the current record position
  // when you call refresh.
  // next line fixes an exception error
  if (Main.StatusBar1.Panels.Count = 0) then
  begin
    fDoStatusBarUpdate := false;
    exit;
  end;

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
  fDoStatusBarUpdate := false;
  Main.StatusBar1.Panels.EndUpdate;
  Main.StatusBar1.Invalidate;

end;

procedure TMain.SCM_StatusBarUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if fDoStatusBarUpdate and not fSCMisInitializing then
      DoEnable := true;
  end;
  TAction(Sender).Enabled := DoEnable;
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
  AllClosed := SCM.Event_AllHeatsAreClosed(SCM.Event_ID);
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
      s := 'ERROR: No folder-name given.'
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
  // PRINTER-NAME OR FOLDER-NAME FOR FILE EXPORT,
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
  rtnValue, aSessionID: integer;
begin
  if not AssertConnection then
    exit;
  if SCM.dsSession.DataSet.IsEmpty then
    exit;
  aSessionID := SCM.dsSession.DataSet.FieldByName('SessionID').AsInteger;
  if SCM.Session_IsLocked then
  begin
    MessageDlg('A locked session can''t be deleted.', mtInformation,
      [mbOK], 0, mbOK);
    exit;
  end;
  { WARNING #1  }
  rtnValue := MessageDlg('Delete the selected session?' + sLineBreak +
    'Including it''s events, nominees, heats, entrants, relays, etc.', mtConfirmation,
    [mbYes, mbNo], 0, mbNo);
  // DON'T USE (rtnValue = mrNo) AS IT DOESN'T ACCOUNT FOR OS CLOSE 'X' BTN.
  // mrCancel=2 mrNo=7 mrYes=6
  if (rtnValue <> mrYes) then
    exit;
  { WARNING #2  }
  if SCM.Session_HasClosedOrRacedHeats(aSessionID) then
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
  {  D E L E T E  }
  SCM.Session_DeleteExclude(aSessionID, false);
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
      if not SCM.Session_IsLocked then
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
  dlg.SessionID := SCM.Session_ID;
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
  Size: TSize;
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
    Session_Grid.Canvas.Font.Color := fSessionClosedFontColor;
    Size := Session_Grid.Canvas.TextExtent(Column.Field.DisplayText);
    topMargin := Round((Rect.Height - Size.Height) / 2);
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
    SCM.dsSession.DataSet.Refresh;
    // Requery, Sort.
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
      // Disable grids.
      // With the exception of the Heat grid. This allows user to browse races,
      // entrant data and race times. Buttons and menu items will be disabled
      // via the ActionManager.
      Event_Grid.Enabled := false;
      INDV.Grid.Enabled := false;
      Nominate_ControlList.Enabled := false;
    end
    else
    begin
      Event_Grid.Enabled := true;
      INDV.Grid.Enabled := true;
      Nominate_ControlList.Enabled := true;
    end;
  end;

  ToggleVisibileTabSheet1;

  // S T A T U S B A R .
  // Session scroll will change statusbar totals for the session
  fDoStatusBarUpdate := true; // permits ACTION (flag sets false after update)
  SCM_StatusBar.Update;
  SCM_StatusBar.Execute;
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
  TAction(Sender).Enabled := DoEnable;
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
      ImageIndex := 23;
      // show locked (default)
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
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Team_Scroll(var Msg: TMessage);
var
  fld: TField;
begin
  // messages posted by TSCM.qryMemberQuickPickAfterScroll
  {TODO -oBSA -cGeneral : TEAM Entrant_Scroll}
  if not AssertConnection then
    exit;
  if SCM.Event_IsTEAM  and TEAM.Grid.Focused then
  begin
    // After moving row re-engage editing for selected fields.
    fld := TEAM.Grid.SelectedField;
    if Assigned(fld) then
    begin
      if (fld.FieldName = 'RaceTime') or (fld.FieldName = 'DCode') or
        (fld.FieldName = 'TeamName') then
      begin
        TEAM.Grid.EditorMode := true;
      end
      else
        TEAM.Grid.EditorMode := false;
    end;
  end;
end;

procedure TMain.ToggleDCode(DoEnable: boolean);

begin
  // USE FINA codes or use simple scratch/disqualified method
  INDV.ToggleDCode(DoEnable);
  TEAM.ToggleDCode(DoEnable);
end;

procedure TMain.ToggleDivisions(SetVisible: boolean);
var
  fld: TField;
begin
  // NOTE: Swimmer Category and Divisions mutally exclusive.
  with SCM.dsEntrant.DataSet do
  begin
  DisableControls;
  fld := Fields.FindField('luDivision');
  if Assigned(fld) then
    fld.Visible := SetVisible;
  EnableControls;
  end;
end;

procedure TMain.ToggleSwimmerCAT(SetVisible: boolean);
var
  fld: TField;
begin
  // NOTE: Swimmer Category and Divisions mutally exclusive.
  with SCM.dsEntrant.DataSet do
  begin
  DisableControls;
  fld := Fields.FindField('luCategory');
  if Assigned(fld) then
    fld.Visible := SetVisible;
  EnableControls;
  end;
end;

procedure TMain.ToggleVisibileTabSheet3;
begin
  {
  --------------------------------------------------------------
   TOGGLE VISIBILITY OF INDV or TEAM GRIDS
   Reveals vimgNoHeatsMsg
  --------------------------------------------------------------
  }
  if SCM.dsSession.DataSet.IsEmpty then
  begin
    // hides tab sheet panel and displays notification image.
    vimgNoHeatsMsg.Visible := false;
    pnlHeatsTabSheet.Visible := false;
    vimgHeatsNotifications.ImageName := 'NoSessions 512x512';
    vimgHeatsNotifications.Visible := true;
  end
  else if SCM.dsEvent.DataSet.IsEmpty then
  begin
    // hides tab sheet panel and displays notification image.
    vimgNoHeatsMsg.Visible := false;
    pnlHeatsTabSheet.Visible := false;
    vimgHeatsNotifications.ImageName := 'NoEvents 512x512';
    vimgHeatsNotifications.Visible := true;
  end
  else if SCM.dsHeat.DataSet.IsEmpty then
  begin
    // hides INDV/TEAM GRIDS and displays 'No Heats' image.
    vimgHeatsNotifications.Visible := false;
    pnlHeatsTabSheet.Visible := true;
    pnlClient.Visible := false;
    pnlRight.Visible := false;
    vimgNoHeatsMsg.ImageName := 'NoHeats 512x512';
    vimgNoHeatsMsg.Visible := true;
  end
  else
  begin
    // Restores tab sheet panel and clears any notifications.
    vimgHeatsNotifications.Visible := false;
    vimgNoHeatsMsg.Visible := false;
    pnlHeatsTabSheet.Visible := true;
    pnlClient.Visible := true;
    if not SCM.Event_HasNominees(SCM.dsEvent.DataSet.FieldByName('EventID')
      .AsInteger) then
      lblMsgNoNominees.Visible := true
    else
      lblMsgNoNominees.Visible := false;

    pnlRight.Visible := true;
    if SCM.Event_IsTEAM then
    begin  // RELAYS
      TEAM.Visible := true;
      INDV.Visible := false;
    end
    else
    begin // INDIVIDUAL EVENT
      TEAM.Visible := false;
      INDV.Visible := true;
    end;
  end;
end;

procedure TMain.ToggleVisibileTabSheet1;
begin
  {
  --------------------------------------------------------------
   TOGGLE VISIBILITY OF EVENT GRID PANEL
   Reveals vimgNoEventsMsg
  --------------------------------------------------------------
  }
  if SCM.dsSession.DataSet.IsEmpty then
  begin
    Event_Grid.Visible := false;
    EventWidgets.Visible := false;
    vimgNoEventsMsg.Visible := true;
    vimgNoEventsMsg.ImageName := 'NoSessions 512x512';
  end
  else if SCM.dsEvent.DataSet.IsEmpty then
  begin
    EventWidgets.Visible := true;
    Event_Grid.Visible := false;
    vimgNoEventsMsg.Visible := true;
    vimgNoEventsMsg.ImageName := 'NoEvents 512x512';
  end
  else
  begin
    EventWidgets.Visible := true;
    Event_Grid.Visible := true;
    vimgNoEventsMsg.Visible := false;
  end;
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

procedure TMain.Tools_DisqualifyCodesExecute(Sender: TObject);
var
  dlg: TDisqualificationCodes;
begin
  dlg := TDisqualificationCodes.CreateWithConnection(self, SCM.scmConnection);
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Tools_DivisionsExecute(Sender: TObject);
var
  dt: TDateTime;
  dlg: TDivision;
begin
  // TActionUpdate determine access to this routine.
  dt := SCM.SwimClub_StartOfSwimSeason();
  if (dt <= 0) then
  begin
    // error no start of swim season given
    MessageDlg('A ''Start Of Swim Season'' value hasn''t been assigned.' +
      sLineBreak + 'Check your options and preferences!', mtInformation,
      [mbOK], 0);
    exit;
  end;
  dlg := TDivision.Create(self);
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
  TAction(Sender).Enabled := DoEnable;
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
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Tools_LeaderBoardExecute(Sender: TObject);
var
  dlg: TLeaderBoard;
begin
  // TActionUpdate determins if this routine can be accessed.
  dlg := TLeaderBoard.Create(self);
  dlg.Connection := SCM.scmConnection;
  dlg.SessionID := SCM.Session_ID;
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
  TAction(Sender).Enabled := DoEnable;
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
  ToggleDCode(prefEnableDCode);
  ToggleSwimmerCAT(prefDisplaySwimmerCAT);
  ToggleDivisions(prefDisplayDivisions);
//  ToggleTeamEvents(prefEnableTeamEvents);

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
  dlg.SwimClubID := SCM.SwimClub_ID;
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
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Tools_SwimmercategoryExecute(Sender: TObject);
var
  dlg: TSwimmerCategory;
begin
  // display the membership type dialogue
  dlg := TSwimmerCategory.Create(self);
  dlg.Connection := SCM.scmConnection;
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Tools_SwimmercategoryUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then
    DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.UpdateINDVTEAM(var Msg: TMessage);
begin
  Refresh_Event;
  ToggleVisibileTabSheet3;
end;



end.
