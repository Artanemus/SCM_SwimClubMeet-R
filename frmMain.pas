unit frmMain;
{
  RUNNING FireDAC Monitor
  RUN FireDAC Monitor tool
  Place TFDMoniRemoteClientLink  onto main form
  Insert into connection definition (SEE - SCMSimpleConnect.pas)
}
// {$IFDEF DEBUG}
// fDBConnection.Params.Add('MonitorBy=Remote');
// {$ENDIF}
{
  WRAP SECTION TO ENABLE AND DISABLE MONITORING.
}

// {$IFDEF DEBUG}
// { TODO -oBSA -cGeneral : FireDAC Tracing - ENABLE DEBBUG }
// if Assigned(SCM.scmConnection) then
// SCM.scmConnection.ConnectionIntf.Tracing := true;
// {$ENDIF}

// {$IFDEF DEBUG}
// { TODO -oBSA -cGeneral : FireDAC Tracing - DISABLE DEBBUG }
// if Assigned(SCM.scmConnection) then
// SCM.scmConnection.ConnectionIntf.Tracing := false;
// {$ENDIF}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ActnList, System.ImageList,
  Vcl.ImgList, Vcl.Menus, System.Actions, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.CheckLst, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, System.Contnrs, dlgBootProgress,
  SCMDefines, Vcl.VirtualImage, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.WinXCtrls, Vcl.ControlList,
  Vcl.ToolWin, Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.PlatformVclStylesActnCtrls,
  Data.FMTBcd, Data.SqlExpr, FireDAC.Moni.Base, FireDAC.Moni.RemoteClient,
  frame_INDV, frame_TEAM, SCMHelpers, dmSCM, FireDAC.UI.Intf,
  FireDAC.VCLUI.Error, FireDAC.Stan.Error, FireDAC.Stan.Intf, FireDAC.Comp.UI,
  FireDAC.Stan.Option, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys,
  FireDAC.Comp.Client, uFrameHeat;

type

  TMain = class(TForm)
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionManager1: TActionManager;
    actnAddSlot: TAction;
    actnClearSlot: TAction;
    actnMoveDownSlot: TAction;
    actnMoveUpSlot: TAction;
    actnRemoveSlot: TAction;
    actnStrikeSlot: TAction;
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
    dbtxtDebugEventType: TDBText;
    dbtxtDebugHeat: TDBText;
    dbtxtDebugMember: TDBText;
    dbtxtDebugNominee: TDBText;
    dbtxtDebugSession: TDBText;
    dbtxtDebugSwimClub: TDBText;
    dbtxtDebugTeam: TDBText;
    dbtxtDebugTeamEntrant: TDBText;
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
    Grid_EmptyLane: TAction;
    Grid_MoveDown: TAction;
    Grid_MoveUp: TAction;
    Grid_Renumber: TAction;
    Grid_Strike: TAction;
    Grid_SwapLanes: TAction;
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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblHeatNavigatorDistance: TLabel;
    lblHeatNavigatorEventNum: TLabel;
    lblHeatStrokeStr: TLabel;
    lblMsgTab1: TLabel;
    lblMsgTab3: TLabel;
    lblNomWarning: TLabel;
    lblSessionCaption: TLabel;
    lblSessionEventCaption: TLabel;
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
    Nominate_GotoMemberDetails: TAction;
    Nominate_Grid: TDBGrid;
    Nominate_MemberDetails: TAction;
    Nominate_Report: TAction;
    Nominate_SortMembers: TAction;
    oggleSessionStatus1: TMenuItem;
    oggleStatus1: TMenuItem;
    PageControl1: TPageControl;
    pnlClient: TPanel;
    pnlClubData: TRelativePanel;
    pnlDebugInfo: TPanel;
    pnlEventGrid: TPanel;
    pnlHeatsTabSheet: TPanel;
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
    vimgRelayDot: TVirtualImage;
    VirtualImage1: TVirtualImage;
    SwimClub_Switch: TAction;
    SwimClub_Manage: TAction;
    File_ExportSession: TAction;
    actnConnect: TAction;
    procedure ActionManager1Update(Action: TBasicAction; var Handled: boolean);
    procedure actnAddSlotExecute(Sender: TObject);
    procedure actnClearSlotExecute(Sender: TObject);
    procedure actnClearStrikeSlotUpdate(Sender: TObject);
    procedure actnConnectExecute(Sender: TObject);
    procedure actnConnectUpdate(Sender: TObject);
    procedure actnGridEntrantUpdate(Sender: TObject);
    procedure actnMoveDownSlotExecute(Sender: TObject);
    procedure actnMoveUpSlotExecute(Sender: TObject);
    procedure actnRemoveSlotExecute(Sender: TObject);
    procedure actnStrikeSlotExecute(Sender: TObject);
    procedure btnClearSearchClick(Sender: TObject);
    procedure clistCheckBoxClick(Sender: TObject);
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
    procedure File_ExportSessionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
    procedure FormShow(Sender: TObject);
    procedure Grid_EmptyLaneExecute(Sender: TObject);
    procedure Grid_EmptyLaneUpdate(Sender: TObject);
    procedure Grid_MoveDownExecute(Sender: TObject);
    procedure Grid_MoveDownUpdate(Sender: TObject);
    procedure Grid_MoveUpExecute(Sender: TObject);
    procedure Grid_MoveUpUpdate(Sender: TObject);
    procedure Grid_RenumberExecute(Sender: TObject);
    procedure Grid_RenumberUpdate(Sender: TObject);
    procedure Grid_StrikeExecute(Sender: TObject);
    procedure Grid_StrikeUpdate(Sender: TObject);
    procedure Grid_SwapLanesExecute(Sender: TObject);
    procedure Grid_SwapLanesUpdate(Sender: TObject);
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
    procedure Nominate_GotoMemberDetailsExecute(Sender: TObject);
    procedure Nominate_GotoMemberDetailsUpdate(Sender: TObject);
    procedure Nominate_GridDblClick(Sender: TObject);
    procedure Nominate_GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: integer; Column: TColumn; State: TGridDrawState);
    procedure Nominate_MemberDetailsExecute(Sender: TObject);
    procedure Nominate_MemberDetailsUpdate(Sender: TObject);
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
    procedure SwimClub_ManageExecute(Sender: TObject);
    procedure SwimClub_ManageUpdate(Sender: TObject);
    procedure SwimClub_SwitchExecute(Sender: TObject);
    procedure SwimClub_SwitchUpdate(Sender: TObject);
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
    fFrameBgColor: TColor;
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
    // number of members - called OnCreate and after frmManageMembers dialogue
		fCountOfMembers: integer;
    fDoLoginOnBoot: boolean;
		prefEnableDCode: boolean;

    SCMEventList: TObjectList;
    function AssertConnection(): boolean; // Check connection to MSSQL DATABASE
    procedure Heat_AutoBuildRelayExecute(Sender: TObject);
    procedure DBGridWndProc(var Msg: TMessage);
    procedure DrawEventStatus(oGrid: TObject; Rect: TRect; Column: TColumn);
    // procedure EnableEvent_GridEllipse();
    procedure Event_BuildSCMEventType(Sender: TObject;
      EventType: scmEventFinalsType);
    // Miscellaneous - uncatagorized
    procedure GetSCMPreferences();
    procedure Refresh_Event(DoBookmark: boolean = true;
      DoRenumber: boolean = false);
    procedure Refresh_Heat(DoBookmark: boolean = true;
      DoRenumber: boolean = false);
    // REFRESH
    procedure Refresh_IndvTeam(DoBookmark: boolean = true;
      DoRenumber: boolean = false);
    procedure Refresh_Nominate(DoBookmark: boolean = true);
    procedure Refresh_TeamEntrant(DoBookmark: boolean = true); // --
    // Generic TAction onExecute (extended params) for BATCH PRINT
    procedure Session_BatchReportExecute(Sender: TObject; RptType: scmRptType);
    // ENTRANT_GRID Toggle column display
    procedure ToggleDCode(DoEnable: boolean);
    procedure ToggleDivisions(SetVisible: boolean);
    procedure ToggleSwimmerCAT(SetVisible: boolean);

    procedure DisplayHeatStatusMsg(aHeatStatusID: integer);

  protected
    // posted by dmSCMNom : a refresh of the entrant grid is required.
    procedure Entrant_LaneWasCleaned(var Msg: TMessage);
      message SCM_LANEWASCLEANED;
    procedure Event_AssertStatusState(var Msg: TMessage);
      message SCM_EVENTASSERTSTATUSSTATE;
    procedure Event_Scroll(var Msg: TMessage); message SCM_EVENTSCROLL;
    procedure Heat_Scroll(var Msg: TMessage); message SCM_HEATSCROLL;
    procedure INDV_Scroll(var Msg: TMessage); message SCM_ENTRANTSCROLL;
    // Posted by TCORE.qryMemberQuickPick : AfterScroll
    procedure Nominate_Scroll(var Msg: TMessage); message SCM_NOMINATESCROLL;
    procedure RenumberHeats(var Msg: TMessage); message SCM_RENUMBERHEATS;
    procedure Session_AssertStatusState(var Msg: TMessage);
      message SCM_SESSIONASSERTSTATUSSTATE;
    // windows messages ....
    procedure Session_Scroll(var Msg: TMessage); message SCM_SESSIONSCROLL;
    procedure Session_RenumberEvents(var Msg: TMessage); message SCM_RENUMBEREVENTS;
    procedure SetTabSheetDisplayState(var Msg: TMessage);
      message SCM_TABSHEETDISPLAYSTATE;
    procedure TeamEntrant_Scroll(var Msg: TMessage);
      message SCM_TEAMENTRANTSCROLL;
    procedure Team_Scroll(var Msg: TMessage); message SCM_TEAMSCROLL;
    procedure UpdateEntrantCount(var Msg: TMessage);
      message SCM_UPDATEENTRANTCOUNT;
    procedure UpdateINDVTEAM(var Msg: TMessage); message SCM_UPDATEINDVTEAM;
    procedure UpdateStatusBar(var Msg: TMessage); message SCM_UPDATESTATUSBAR;
  public
    { Public declarations }
    fDoStatusBarUpdate: boolean; // FLAG ACTION - SCM_StatusBar.Enabled
    fSCMisInitializing: boolean; // FLAG FormCreate
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses

  System.UITypes, Vcl.Themes, SCMUtility,
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
  dlgAutoSchedule, dlgDCodePicker, dmSCMHelper, rptMarshallReportC,
  dlgSplitTimeTEAM, dlgSplitTimeINDV, dlgSwimClubSwitch, dlgSwimClubManage,
  dlgABRelay, uABRelayExec, dlgExportSessionJSON, dlgCheck_DOB_Gender, dmIMG,
	dmCORE, uLane, uHeat, uEvent, uSession, uSwimClub, scmLogin;

procedure TMain.Heat_AutoBuildRelayExecute(Sender: TObject);
var
  i, rtnValue: Integer;
  dlg: TABRelay;
	ABRelay: TABRelayExec;
	s: string;

begin
  // NOTE: actn..Update determines if this routine is accessable.
  { Count number of nominees (swimmers) for event.
    Exclude entrants (swimmers) in RACED or CLOSED heats.
		INCLUDE entrants (swimmers) in OPEN heats.
    INCLUDE pooled nominees (swimmers) not assigned a lane to the event.
    }
  i := SCM.CountTEAMNominee();
  if (i = 0) then
	begin
		s := '''
			No available nominees were found for this event.
			Note: Closed or raced heats are always preserved and excluded from auto-builds.
			Auto-Build relays was aborted.
			''';
		MessageDlg(s,	mtError, [mbOK], 0, mbOK);
    exit;
  end;
  {open the RELAY_TEAM dialogue.}
  dlg := TABRelay.Create(self);
  rtnValue := dlg.ShowModal;
  {closing the form here ensures prefences have been
    written out to the preference ini file.}
  dlg.Free;
  if not IsPositiveResult(rtnValue) then exit;
	{TODO -oBSA -cAutoBuildRelay : Partial team. Exclude nominee dialogue.}
  {Hand over process to uABRelayExec.}
	ABRelay := TABRelayExec.Create(Self);
	{CORE.qryEvent.FieldByName('EventID').AsInteger}
	ABRelay.Prepare(SCM.scmConnection, CORE.qryEvent.FieldByName('EventID').AsInteger);
	ABRelay.ExecAutoBuildRelay();
	if ABRelay.Success then
  begin
		CORE.qryLane.DisableControls;
		CORE.qryHeat.DisableControls;
		{TODO -oBSA -cV2 : Perform apply master in ExecAutorelay}
		CORE.qryHeat.ApplyMaster;
		CORE.qryLane.ApplyMaster;
		CORE.qryHeat.EnableControls;
		CORE.qryLane.EnableControls;

    // Requery CORE.qryEvent to update entrant count.
    PostMessage(Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
    // Set flag for statusbar update.
    PostMessage(Handle, SCM_UPDATESTATUSBAR, 0, 0);
  end;
  ABRelay.free;
end;

procedure TMain.ActionManager1Update(Action: TBasicAction;
  var Handled: boolean);
begin
  // kill the statusbar action during initialization.
  if AssertConnection then
  begin
    if fSCMisInitializing then SCM_StatusBar.Enabled := false;
  end;
end;

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

procedure TMain.actnConnectExecute(Sender: TObject);
var
  aLoginDlg: TLogin;  // 24/04/2020 uses simple INI access
  NumOfLanes: integer;
begin
  fDoLoginOnBoot := false; // Do Once...
  // -----------------------------------------------------------
  // 02/05/2025 connect - %AppData%\Artanemus\SCM\FDConnectionDefs.ini
  // -----------------------------------------------------------
  aLoginDlg := TLogin.Create(self);
  aLoginDlg.ShowModal;
  aLoginDlg.Free;

  if SCM.scmConnection.Connected then
  begin
    { sessGrid.BeginUpdate;
      eventGrid.BeginUpdate;
      heatGrid.BeginUpdate;
      laneGrid.BeginUpdate;
    }
    try
      SCM.DeActivateTable;
    finally
    { sessionGrid.EndUpdate;
      eventGrid.EndUpdate;
      heatGrid.EndUpdate;
      laneGrid.EndUpdate;
    }
    end;
    TAction(Sender).Caption := 'Disconnect from the SCM database...';
  end
  else
  begin
    TAction(Sender).Caption := 'Connect to the SCM database...';
  end;

  if SCM.IsActive then
  begin
    // init?...
  end;
end;

procedure TMain.actnConnectUpdate(Sender: TObject);
begin
  if Assigned(SCM) and SCM.scmFDManager.Active then
  begin
    if not TAction(Sender).Enabled then
      TAction(Sender).Enabled := true;
  end
  else
    if TAction(Sender).Enabled then
      TAction(Sender).Enabled := false;
end;

procedure TMain.actnGridEntrantUpdate(Sender: TObject);
var
  DoEnable: boolean;
  aEventType: scmEventType;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
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
//							if TEAM.TeamActiveGrid = 2 then
//								if not CORE.dsTeamEntrant.DataSet.IsEmpty then DoEnable := true;
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

function TMain.AssertConnection: boolean;
begin
  result := false;
  // test datamodule construction
  if Assigned(SCM) then
  begin
    // IsActive if TFDConnection::scmConnection && FireDAC tables are active
    if SCM.IsActive then result := true;
  end;
end;

procedure TMain.btnClearSearchClick(Sender: TObject);
begin
  Nominate_Edit.Text := '';
  if Nominate_Edit.CanFocus then Nominate_Edit.SetFocus;
end;

procedure TMain.clistCheckBoxClick(Sender: TObject);
var
  MemberID, EventID, EventNum: integer;
  DoNominate: boolean;
  nom: TSCMNom;
begin
  if not AssertConnection then exit;

  MemberID := CORE.dsNominee.DataSet.FieldByName('MemberID').AsInteger;
  if (MemberID = 0) then exit;

  // PERFORM THE TOGGLE
  DoNominate := not DoNominate;
  // Class to nominate/unnominate safely
  nom := TSCMNom.CreateWithConnection(self, SCM.scmConnection);
  if (DoNominate) then nom.NominateMember(MemberID, EventID)
  else
    // Returns true if member was unNominated.
    // May have required that a Lane was emptied of member.
    // TSCMnom will post message SCM_LANEWASCLEANED
      nom.UnNominateMember(MemberID, EventID);
  nom.Free;
  // CLOSE, SET new PARMS and OPEN the database used by the controllist.
  // This is needed for images in event Nominate_ControlListBeforeDrawItem
  SCM.Nominate_UpdateControlList(uSession.PK, MemberID);
  // locate to the last selected ControlList record.
  // SCM.Nominate_LocateEventNum(gridEvent.DataSet, EventNum);
  // paint the member tomatoe red in the nominate_grid
  Nominate_Grid.Invalidate;

  // Requery CORE.qryEvent to update entrant count.
  PostMessage(Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
  // Set flag for statusbar update.
  PostMessage(Handle, SCM_UPDATESTATUSBAR, 0, 0);


end;

procedure TMain.DBGridWndProc(var Msg: TMessage);
begin
  if ((Msg.Msg = WM_VSCROLL) and (Msg.WParamLo = SB_THUMBTRACK)) then
      Msg.WParamLo := SB_THUMBPOSITION;
  if Assigned(FOrgDBGridWndProc) then FOrgDBGridWndProc(Msg);
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

procedure TMain.Entrant_LaneWasCleaned(var Msg: TMessage);
begin
  // message posted by TSCMNom SCM_LANEWASCLEANED
  Refresh_IndvTeam;
end;

procedure TMain.Event_AssertStatusState(var Msg: TMessage);
var
  AllClosed: boolean;
  aEventID, newEventStatusID: integer;
  fld: TField;
begin

  if not AssertConnection then exit;
  // Toggle EVENT_GRID EventStatusID.
  // If all the heats for the event have been closed then a tick is displayed
  // in the UI.
	aEventID := CORE.dsEvent.DataSet.FieldByName('EventID').AsInteger;
  if (aEventID > 0) then
  begin
		AllClosed := uEvent.AllHeatsAreClosed();
    if (((AllClosed = true) and
      (CORE.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger = 1)) or
      ((AllClosed = false) and (CORE.dsEvent.DataSet.FieldByName('EventStatusID')
      .AsInteger = 2))) then
    begin
      CORE.dsEvent.DataSet.DisableControls;
      if AllClosed then newEventStatusID := 2
      else newEventStatusID := 1;
      // only modify the record if required ...
      if (CORE.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger <>
        newEventStatusID) then
      begin

        { ALTERNATIVE METHOD
          if uEvent.SetEventStatusID(aEventID, newEventStatusID) then
          begin
          CORE.dsEvent.DataSet.Refresh;
          uEvent.Locate(aEventID);
          end;
        }

        // 13.10.2020 CORE.qryEvent.EventStatusID is READ ONLY
        fld := CORE.dsEvent.DataSet.FindField('EventStatusID');
        if Assigned(fld) then fld.ReadOnly := false;
        // go update the status of the event
        CORE.dsEvent.DataSet.Edit;
        CORE.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger :=
          newEventStatusID;
        // 22.09.2020 TimeStamp event closed date.
        // posted by TMain::Heat_ToggleStatusExecute(TObject *Sender)
        // used by SCM_LeaderBoard application to auto-update it's view
        // with the most resently closed event.
        if AllClosed then
          // Only timestamp if needed
            CORE.dsEvent.DataSet.FieldByName('CloseDT').AsDateTime := Now();
        CORE.dsEvent.DataSet.Post;
        CORE.dsEvent.DataSet.Refresh;
        if Assigned(fld) then fld.ReadOnly := true;
				// que to event record
				uEvent.Locate(aEventID);
      end;
			CORE.dsEvent.DataSet.EnableControls();
    end;
  end;

end;

procedure TMain.Event_AutoScheduleExecute(Sender: TObject);
var
  dlg: TAutoSchedule;
  EventID: integer;
  rtnValue: TModalResult;
begin
  if not AssertConnection then exit;
  CORE.dsEvent.DataSet.DisableControls;
	EventID := uEvent.PK;
  dlg := TAutoSchedule.CreateWithConnection(self, SCM.scmConnection);
	dlg.SessionID := uSession.PK;
  rtnValue := dlg.ShowModal;
  dlg.Free;
  if IsPositiveResult(rtnValue) then
  begin
    CORE.dsEvent.DataSet.Refresh;
		uEvent.Locate(EventID);
  end;
  CORE.dsEvent.DataSet.EnableControls;
end;

procedure TMain.Event_AutoScheduleUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
		if not CORE.dsSession.DataSet.IsEmpty then
    begin
      if not CORE.dsEvent.DataSet.IsEmpty then DoEnable := true;
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
  if not AssertConnection then exit;
  dlg := TAutoBuild_Finals.Create(self);
  dlg.TypeOfEvent := EventType;
  rtnValue := dlg.ShowModal;
  dlg.Free;
  if (rtnValue = mrYes) then
  begin
    EventID := CORE.dsEvent.DataSet.FieldByName('EventID').AsInteger;
    dm := TAutoBuildV2(self);
    success := dm.AutoBuildExecuteExt(EventID, EventType);
    dm.Free;
    if (success) then
    begin
      // refresh...
      Refresh_Heat; // needed to display the new heats
      Refresh_IndvTeam; // needed to display the new entrants
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
    if not CORE.dsSession.DataSet.IsEmpty then DoEnable := true;
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
	aEventID := uEvent.PK;
	HasClosedHeats :=uEvent.HasClosedHeats();
  HasRacedHeats := uEvent.HasRacedHeats();
  if HasClosedHeats then
	begin

		SQL := 'Unable to delete the event ';

    SQL := SQL + CORE.dsEvent.DataSet.FieldByName('ShortCaption').AsString +
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
    if (rtnValue <> mrYes) then exit;
  end;

  // 2 .  C o n f i r m   d e l e t i o n .
	// --------------------------------------------------------
  SQL := 'Delete event?';
	SQL := SQL + CORE.dsEvent.DataSet.FieldByName('ShortCaption').AsString +
    sLineBreak;
  if (HasRacedHeats) then
      SQL := SQL + 'Including all (open or raced) heats, entrant and nomination data?'
  else SQL := SQL + 'Including all open heats, entrant and nomination data?';
  rtnValue := MessageDlg(SQL, mtConfirmation, [mbYes, mbNo], 0, mbYes);

  if (rtnValue = mrYes) then
  begin
		uEvent.DeleteRecord();
		CORE.qryEvent.EnableControls;
    PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 1, 0);
  end;
end;

procedure TMain.Event_DeleteUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
		// Checks if session is Empty. Then checks if locked..
		if not uSession.IsLocked then
      // are there any events?
      if not CORE.dsEvent.DataSet.IsEmpty then DoEnable := true;
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
      'F': i := 1;
      'B', 'R': i := 2;
      'A': i := 3;
      'U': i := 4;
      'M': i := 5;
    else i := 0;
    end;

    if (i > 0) then
    begin
      CORE.dsEvent.DataSet.DisableControls;
      CORE.dsEvent.DataSet.Edit;
      CORE.dsEvent.DataSet.FieldByName('StrokeID').AsInteger := i;
      CORE.dsEvent.DataSet.Post;
      CORE.dsEvent.DataSet.EnableControls;
      Key := 0;
    end;
  end
  else if (dg.SelectedField.FieldName = 'luDistance') then
  begin
    case char(Key) of
      '2': i := 1; // 25m
      '5': i := 2; // 50m
      '1': i := 3; // 100m
      '0': i := 4; // 200m
      '4': i := 5; // 400m
      // 1000m - there is no shortcut
    else i := 0;
    end;
    if (i > 0) then
    begin
      CORE.dsEvent.DataSet.DisableControls;
      CORE.dsEvent.DataSet.Edit;
      CORE.dsEvent.DataSet.FieldByName('DistanceID').AsInteger := i;
      CORE.dsEvent.DataSet.Post;
      CORE.dsEvent.DataSet.EnableControls;
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
  if not Assigned(SCM) then exit;
  if not ds.Active then exit;
  if ds.IsEmpty then exit;
  if SCM.IsLastRecord(ds) then
  begin
    beep;
    exit;
  end;

  fld := ds.FindField('EventNum');
  if Assigned(fld) then fld.ReadOnly := false;
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
  if Assigned(fld) then fld.ReadOnly := true;
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
  if not Assigned(SCM) then exit;
  if not ds.Active then exit;
  if ds.IsEmpty then exit;
  if SCM.IsFirstRecord(ds) then
  begin
    beep;
    exit;
  end;

  fld := ds.FindField('EventNum');
  if Assigned(fld) then fld.ReadOnly := false;
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
  if Assigned(fld) then fld.ReadOnly := true;
  ds.Refresh;
  ds.EnableControls();
end;

procedure TMain.Event_MoveUpOrDownUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  { TODO -oBSA -cGeneral :
    In a perfect world we would need a least two events to move up or down. }
  // connected?
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not (uSession.IsLocked) then
      if not CORE.dsEvent.DataSet.IsEmpty then DoEnable := true;
  // finally
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Event_NewRecordExecute(Sender: TObject);
begin
  if not AssertConnection then exit;
  CORE.dsEvent.DataSet.CheckBrowseMode;
  CORE.dsEvent.DataSet.Insert();
  PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 1, 0);
end;

procedure TMain.Event_NewRecordUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // connected?
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not (uSession.IsLocked) then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Event_RenumberExecute(Sender: TObject);
begin
  if AssertConnection then uSession.RenumberEvents(true, true);
end;

procedure TMain.Event_RenumberUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      if not CORE.dsEvent.DataSet.IsEmpty then DoEnable := true;
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
    on E: Exception do ShowMessage('Error opening report.');
  end;
  if Event_Grid.CanFocus then Event_Grid.SetFocus;
end;

procedure TMain.Event_ReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      // Are there any Events?
      if not CORE.dsEvent.DataSet.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Event_Scroll(var Msg: TMessage);
var
  EnabledState: boolean;
  aEventType: scmEventType;
begin

  if not AssertConnection then exit;
  EnabledState := false;

  // is the session is Open?
  if (CORE.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 1) then
  begin
    // Is the heat Open?
    if (CORE.dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger <> 3) then
        EnabledState := true;
  end;

  if PageControl1.ActivePageIndex = 2 then
    PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 3, 0);


  // SYNC the enabled state of the INDVTEAM Grids
  aEventType := uEvent.EventType;
  if aEventType = etINDV then
  begin
    if (INDV.Grid.Enabled <> EnabledState) then
        INDV.Grid.Enabled := EnabledState;
  end;

  if aEventType = etTEAM then
  begin
    if (TEAM.Grid.Enabled <> EnabledState) then
        TEAM.Grid.Enabled := EnabledState;
  end;

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
    CORE.qryEvent.DisableControls;
    // e v e n t   d e s c r i p t i o n ...
		fld := CORE.qryEvent.FindField('Caption');
    if Assigned(fld) then fld.Visible := Checked;

    // e v e n t   s c h e d u l e  t i m e ...
    fld := CORE.qryEvent.FindField('ScheduleDT');
    if Assigned(fld) then fld.Visible := Checked;

    // INDV or RELAY event type ....
    // fld := CORE.qryEvent.FindField('luEventType');
    // if Assigned(fld) then
    // fld.Visible := Checked;

    // Fields that are always visible in either grid display mode.
    // n o m i n a t i o n s  ...
    fld := CORE.qryEvent.FindField('NomineeCount');
    if Assigned(fld) then
    begin
      if Checked then fld.DisplayLabel := 'Nominees'
      else fld.DisplayLabel := 'Nom#';
    end;
    // e n t r a n t s ...
    fld := CORE.qryEvent.FindField('EntrantCount');
    if Assigned(fld) then
    begin
      if Checked then fld.DisplayLabel := 'Entrants'
      else fld.DisplayLabel := ' Ent#';
    end;
    CORE.qryEvent.EnableControls;
  end;
end;

procedure TMain.Event_ToggleGridViewUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
      DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.File_ExitExecute(Sender: TObject);
begin
  { TODO -oBSA -cGeneral : CheckBrowseMode on all grids before exit? }
  Close;
end;

procedure TMain.File_ExportSessionExecute(Sender: TObject);
var
dlg : TExportSessionJSON;
begin
  // EXPORT THE RACETIME OF MEMBERS in THE CURRENT SELECTED SESSION.
  dlg := TExportSessionJSON.Create(self);
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.FormCreate(Sender: TObject);
var
  str: string;
  passed: boolean;
//  aBasicLogin: TBasicLogin;
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
  fFrameBgColor := clAppWorkSpace;
  fMyInternetConnected := true;
  fCountOfMembers := 0;
	prefEnableDCode := false;


	(*
  // A Class that uses JSON to read and write application configuration
  Settings := TPrgSetting.Create;

	{ If settings FILE doesn't exsist in %AppData% - it will be created and
		default data will be assigned. }

	if Assigned(Settings) then
  begin
    LoadSettings;
    // if true the login DLG will appear on first boot-up.
    // TForm.FormShow takes care of this.
    if Settings.DoLoginOnBoot then
			fDoLoginOnBoot := true;
	end;
	*)

  try
    SCM := TSCM.Create(self);
  finally
		if not Assigned(SCM) then
    begin
			MessageDlg('Error creating SCM!', mtError,  [mbOK], 0);
			Application.Terminate();
    end;
  end;

	if not Assigned(SCM) then exit;


	// CREATE IMAGE COLLECTION DATAMODULE.
	if not Assigned(IMG) then
	begin
		try
			IMG := TIMG.Create(Self);
		except on E: Exception do
		end;
	end;

	// CREATE Core Master-Detail Datamodule.
	if not Assigned(CORE) then
  begin
    try
			CORE := TCORE.Create(Self);
    except
      on E: Exception do
        // Handle exception if needed.
    end;
	end;

	// -----------------------------------------------------------
  // 24/04/2020 Basic login using simple INI access
  // to the FireDAC connection definition file
  // -----------------------------------------------------------
//  aBasicLogin := TBasicLogin.Create(self);
//	aBasicLogin.DBName := 'SwimClubMeet2';
//  aBasicLogin.DBConnection := SCM.scmConnection;
//  result := aBasicLogin.ShowModal;
//  aBasicLogin.Free;

  // user has aborted .
  if (result = mrAbort) or (result = mrCancel) then
  begin
    if (SCM.scmConnection.Connected) then SCM.scmConnection.Close;
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
  if not SCM.IsActive then
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

  bootprogress.lblProgress.Caption := 'Loading user preferences.';
  bootprogress.lblProgress.Repaint;
  Application.ProcessMessages;

  // ====================================================================
  // PREFERENCE - SETUP
  if (passed) then GetSCMPreferences();
  // ====================================================================

  bootprogress.lblProgress.Caption := 'Final checks on database integerity.';
  bootprogress.lblProgress.Repaint;
  Application.ProcessMessages;

  pnlPageControl.Caption := '';

  // ERROR CHECK for valid swimming club record
  if AssertConnection() then
  begin
    if (CORE.dsSwimClub.DataSet.RecordCount = 0) then
    begin
      // disable InterFace
      PageControl1.Visible := false;
      // Session1.Enabled := false;
      // Tools1.Enabled := false;
      // display message
      MessageDlg('The swimming club hasn''t been defined!' + sLineBreak +
        'Run the utility, SCM_BuildMeAClub, with the supplied SQL' + sLineBreak
        + 'creation scripts to build your club.' + sLineBreak +
        'For more information, refer to the SwimClubMeet2 help files.', mtError,
        [mbOK], 0, mbOK);
      // with the page control hidden - this message will appear
      pnlPageControl.Caption := 'ERROR: The swimming club is undefined!';
    end;
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
  Session_GRid.DataSource := CORE.dsSession;
  Event_Grid.DataSource := CORE.dsEvent;
	Nominate_Grid.DataSource := CORE.dsNominee;
	INDV.Grid.DataSource := CORE.dsLane;
	TEAM.Grid.DataSource := CORE.dsLane;
//  TEAM.GridEntrant.DataSource := CORE.dsTeamEntrant;

  // L I N K   T D B T e x t
  dbtxtSwimClubCaption.DataSource := CORE.dsSwimClub;
  dbtxtSwimClubNickName.DataSource := CORE.dsSwimClub;
	dbtxtDebugEntrant.DataSource := CORE.dsLane;
  dbtxtDebugSwimClub.DataSource := CORE.dsSwimClub;
  dbtxtDebugSession.DataSource := CORE.dsSession;
  dbtxtDebugEvent.DataSource := CORE.dsEvent;
  dbtxtDebugHeat.DataSource := CORE.dsHeat;
	dbtxtDebugMember.DataSource := CORE.dsLane;
  dbtxtDebugNominee.DataSource := CORE.dsNominee;
  dbtxtDebugEventType.DataSource := CORE.dsEvent;
  dbtxtDebugTeam.DataSource := CORE.dsTeam;
//  dbtxtDebugTeamEntrant.DataSource := CORE.dsTeamEntrant;
  dbtxtEventCaption.DataSource := CORE.dsEvent;
	dbtxtNominateFullName.DataSource := CORE.dsNominee;
	// LINK EVENT NAVIGATOR
	dbnavEventNavigatePrior.DataSource := CORE.dsEvent;
  dbnavEventNavigateNext.DataSource := CORE.dsEvent;
  // L I N K   C L U B   L O G O  .
  dbimgSwimClubLogo.DataSource := CORE.dsSwimClub;

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
  if Assigned(col) then col.DropDownRows := 12;
  col := Event_Grid.ColumnByName('luStroke');
  if Assigned(col) then col.DropDownRows := 6;
  // col := Event_Grid.ColumnByName('luEventType');
  // if Assigned(col) then  col.DropDownRows := 3;

  // PREPARE GRIDS (not framed) - COLUMN VISIBILITY
  ToggleDCode(prefEnableDCode);

  // Calculation of fCountOfMembers made 'OnCreate' and 'SCM_ManageMembers' (TAction)
  // Always call prior to post of SCM_TABSHEETDISPLAYSTATE
	fCountOfMembers := CORE.Members_Count;
  PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 0, 0);

{$IFDEF DEBUG}
  { TODO -oBSA -cGeneral : FireDAC Tracing - ENABLE DEBBUG }
  // if Assigned(SCM) then
  // SCM.scmConnection.ConnectionIntf.Tracing := true;
{$ENDIF}
end;

procedure TMain.FormDestroy(Sender: TObject);
begin

{$IFDEF DEBUG}
  { TODO -oBSA -cGeneral : FireDAC Tracing - DISABLE DEBBUG }
  // if Assigned(SCM) then
  // SCM.scmConnection.ConnectionIntf.Tracing := false;
{$ENDIF}
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

  if Assigned(CORE) then CORE.free;
  if Assigned(IMG) then  IMG.free;

  if Assigned(SCM) then
  begin
    if SCM.scmConnection.Connected then SCM.scmConnection.Close;
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
    if (WheelDelta > 0) then SendMessage(g.Handle, WM_VSCROLL, SB_LINEUP, 0)
    else SendMessage(g.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
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

  if Session_Grid.CanFocus then Session_Grid.SetFocus;

  INDV.Align := alClient;
  INDV.Visible := true;
  TEAM.Align := alClient;
  TEAM.Visible := false;

  { Find the FINA DCode 'alias' for the simplified disqualification. DO ONCE.}
  INDV.fIsScratchedDCode := SCM.GetIsScratchedDCode;
  INDV.fIsDisqualifiedDCode := SCM.GetIsDisqualifiedDCode;
  TEAM.fIsScratchedDCode := SCM.GetIsScratchedDCode;
	TEAM.fIsDisqualifiedDCode := SCM.GetIsDisqualifiedDCode;

(*
  	// LOGIN TO THE SCM DB SERVER.
  	if fDoLoginOnBoot then
  		// Prompt user to connect to SCM. (... and update UI.)
  		// calling ... sets fDoLoginOnBoot := false.
  		PostMessage(Self.Handle, SCM_CONNECT, 0 , 0 )
  	else
  		// Assert UI display is up-to-date.
  		PostMessage(Self.Handle, SCM_UPDATEUI_SCM, 0 , 0 );

*)

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
  if not FileExists(iniFileName) then exit;
  iFile := TIniFile.Create(iniFileName);

  // Display debug info ... see note AA.
  // -------------------------------------------
  i := iFile.ReadInteger('Preferences', 'ShowDebugInfo', integer(cbUnchecked));
  if (i = integer(cbChecked)) then pnlDebugInfo.Visible := true
  else pnlDebugInfo.Visible := false;

  // 2024-08-31
  // Hide - Show title panel.
  // Adds more screen real estate for 1080H laptop users using 125% scaling.
  // -------------------------------------------
  i := iFile.ReadInteger('Preferences', 'HideTitlePanel', integer(cbUnchecked));
  if (i = integer(cbChecked)) then pnlTitleBar.Visible := false
  else pnlTitleBar.Visible := true;


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
    fFrameBgColor := css.GetSystemColor(clBtnFace);
  end
  else
  begin
    fSessionClosedFontColor := clWebTomato;
    fSessionClosedBgColor := clAppWorkSpace;
    fFrameBgColor := clAppWorkSpace;
  end;

	// 2023.06.26
	prefEnableDCode := iFile.ReadBool('Preferences', 'EnableDCodes', false);

  iFile.Free;

  // Update the preferences used by THE DATAMODULE
  if AssertConnection then SCM.ReadPreferences(iniFileName);

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
      PostMessage(Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
      // Set flag for statusbar update.
      PostMessage(Handle, SCM_UPDATESTATUSBAR, 0, 0);
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
      PostMessage(Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
      // Set flag for statusbar update.
      PostMessage(Handle, SCM_UPDATESTATUSBAR, 0, 0);
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

procedure TMain.HeatControlListBeforeDrawItem(AIndex: integer; ACanvas: TCanvas;
  ARect: TRect; AState: TOwnerDrawState);
var
  i: integer;
begin
(*
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
*)
end;

procedure TMain.HeatNavigateControlListBeforeDrawItem(AIndex: integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
var
  s: string;
  i, j: integer;
begin
(*
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
  *)
end;

procedure TMain.Heat_AutoBuildExecute(Sender: TObject);
var
  AutoBuild: TAutoBuildV2;
	dlg: TAutoBuild_Heats;
	dlg2: TCheck_DOB_Gender;
	success, IsErronous: boolean;
	EventID, rtnValue: integer;
	s: string;
begin
  // A U T O - B U I L D   R E L A Y   TE A M .
  if uEvent.EventType = etTEAM then
  begin
    Heat_AutoBuildRelayExecute(Sender);
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

  // DISABLE CONTROLS
	CORE.dsNominee.DataSet.DisableControls;
	CORE.dsLane.DataSet.DisableControls;
	CORE.dsHeat.DataSet.DisableControls;
	// Check for bad DOB and GENDER.
	dlg2 := TCheck_DOB_Gender.Create(Self);
	IsErronous := dlg2.CheckExec(SCM.scmConnection, EventID);
	if IsErronous then dlg.ShowModal;
	dlg2.Free;

	if not IsErronous then
	begin
		// NOTE : cfgBuildHeatsVerboseON := OFF for BATCH Auto-Build Heats
		AutoBuild := TAutoBuildV2.Create(self);
		// ALERT : IMPORTANT NOTE ...
		// ***************************************************************
		// if TMain's instance of the Heat DataSet isn't sent to Auto-Build
		// ... unable to delete Heat record. (tbl is locked?)
		// That is - call via  to CORE.dsDeat.DataSet ...  doesn't work!
		// ***************************************************************
		// Verbose OFF for BATCH Auto-Build Heats
		success := AutoBuild.AutoBuildExecute();
		if (success) then
		begin
			Refresh_Heat;
			Refresh_IndvTeam;
			// Requery CORE.qryEvent to update entrant count.
			PostMessage(Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
			// Set flag for statusbar update.
			PostMessage(Handle, SCM_UPDATESTATUSBAR, 0, 0);
		end;
		AutoBuild.Free;
	end;


	// ENABLE CONTROLS
	CORE.dsHeat.DataSet.EnableControls;
	CORE.dsLane.DataSet.EnableControls;
	CORE.dsNominee.DataSet.DisableControls;

  if HeatControlList.CanFocus then HeatControlList.SetFocus;
end;

procedure TMain.Heat_AutoBuildUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      // are there any Events?
      if not CORE.dsEvent.DataSet.IsEmpty then
      begin
        // A distance and stroke is needed before a new heat can be built
        if not CORE.dsEvent.DataSet.FieldByName('DistanceID').IsNull and
          not CORE.dsEvent.DataSet.FieldByName('StrokeID').IsNull then
          DoEnable := true;
      end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_BatchBuildHeatsExecute(Sender: TObject);
var
  success, passed: boolean;
  errCount: integer;
  dlg: TAutoBuildPref;
  dmv2: TAutoBuildV2;
  rtnValue: TModalResult;
	aEventType: scmEventType;
begin
  success := false;
  passed := false;
  errCount := 0;
	{TODO -oBSA -cV2 : Moves all this into seperate unit.}
  // TActionUpdate determines access to this routine.
  // DISPLAY AUTO-BUILD CONFIGURATION DIALOGUE
  dlg := TAutoBuildPref.Create(self);
  rtnValue := dlg.ShowModal;
  // closing the form here ensures prefHeatAlgorithm,
  // prefUseDefRaceTime, prefSeedMode and prefRaceTimeTopPercent have been
  // written out to the preference ini file.
  dlg.Free;
  // user aborted ?
  if not IsPositiveResult(rtnValue) then exit;

  // Auto-build heat class constructor.
  // NOTE: Assigns auto-build configuration params on creation.
  try
    dmv2 := TAutoBuildV2.Create(self);
  except
    on E: Exception do exit;
  end;

	// disable core tables
	CORE.dsEvent.DataSet.DisableControls;
  CORE.dsHeat.DataSet.DisableControls;
	CORE.dsLane.DataSet.DisableControls;
	try
		begin
			CORE.dsEvent.DataSet.First;
			while not Eof do
			// iterate over the events ...
			begin
				// Is the EVENT CLOSED?
				if (CORE.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger = 2) then
				begin
					CORE.dsEvent.DataSet.Next;
					continue;
				end;
				// Is this a TEAM EVENT?
				// 20231008 currently Auto-Build is not available for TEAMS
				aEventType := uEvent.EventType();
				if (aEventType = etTEAM) then
				begin
					CORE.dsEvent.DataSet.Next;
					continue;
				end;
				// 2023.02.16
				// DELETE HEATS ...  For current event. Only open heats are deleted.
				uEvent.DeleteRecord();
				// QUICK TEST - Do we have NOMINEES?
				if not uEvent.HasNominees() then
				begin
					CORE.dsEvent.DataSet.Next;
					continue;
				end;
				// CORE.dsHeat.DataSet must be sent to Auto-Build - else errors.
				// ***************************************************************
				// Verbose OFF for BATCH Auto-Build Heats
				success := dmv2.AutoBuildExecute(false);
				if not success then Inc(errCount);

				CORE.dsEvent.DataSet.Next; // LOOP
			end;
		end;
	finally
		if (errCount = 0) then passed := true;

		// clean-up memory
		dmv2.Free;

		// REFRESH ...
		// NOTE: DataSet.Refresh not used.
		// BSA V2: Move apply master into Auto Build routine
		CORE.qryEvent.ApplyMaster;
		CORE.qryHeat.ApplyMaster;
		CORE.qryLane.ApplyMaster;

	//	CORE.dsEntrant.DataSet.Close;
	//	CORE.dsHeat.DataSet.Close;
	//	CORE.dsEvent.DataSet.Close;
	//	CORE.dsEvent.DataSet.Open;
	//	CORE.dsHeat.DataSet.Open;
	//	CORE.dsEntrant.DataSet.Open;

		// Enable core tables
		CORE.dsEvent.DataSet.EnableControls;
		CORE.dsHeat.DataSet.EnableControls;
		CORE.dsLane.DataSet.EnableControls;

	end;

	if passed then
  begin
    // Display success.
    if not success then
        MessageDlg('Batch Build Heats completed but with errors.' + sLineBreak +
        'Check output!', mtInformation, [mbOK], 0)
    else MessageDlg('Batch Build Heats completed without errors.',
        mtInformation, [mbOK], 0);
  end;
end;

procedure TMain.Heat_BatchBuildHeatsUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if not uSession.IsLocked then
      if not CORE.dsSession.DataSet.IsEmpty then
        // Do we have Events?.
        if not CORE.dsEvent.DataSet.IsEmpty then DoEnable := true;
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
    if not CORE.dsSession.DataSet.IsEmpty then
    begin
      // Note: Locked sessions can be printed.
      // Do we have Events?.
      if not CORE.dsEvent.DataSet.IsEmpty then DoEnable := true;
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
    if not CORE.dsSession.DataSet.IsEmpty then
    begin
      // Note: Locked sessions can be printed.
      // Do we have Events?.
      if not CORE.dsEvent.DataSet.IsEmpty then DoEnable := true;
    end;
  end;
  // no connection or no events or event is closed - disable actions
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_DeleteExecute(Sender: TObject);
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
    success := uHeat.DeleteRecord(false);
    if success then
    begin
      // Requery CORE.qryEvent to update entrant count.
      PostMessage(Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
      // Set flag for statusbar update.
      PostMessage(Handle, SCM_UPDATESTATUSBAR, 0, 0);
      // Displays info messages on sidebar and asserts TFrame visibility states.
      PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 3, 0);
    end;
  end;
end;

procedure TMain.Heat_DeleteUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      // are there any Events?
      if not CORE.dsEvent.DataSet.IsEmpty then
        // ILLEGAL EVENT - missing params.
        if not CORE.dsEvent.DataSet.FieldByName('DistanceID').IsNull and
          not CORE.dsEvent.DataSet.FieldByName('StrokeID').IsNull then
          // are there any Heats?
          if not CORE.dsHeat.DataSet.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_MarshallReportExecute(Sender: TObject);
var
  rptA: TMarshallReportA;
  rptB: TMarshallReportB;
  rptC: TMarshallReportC;
  EventID: integer;
begin
  if not AssertConnection then exit;

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
  if HeatControlList.CanFocus then HeatControlList.SetFocus;
end;

procedure TMain.Heat_MarshallReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Are there any heats? Note: Locked sessions can be printed.
    if not CORE.dsHeat.DataSet.IsEmpty then DoEnable := true;
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
  if not AssertConnection then exit;
  With CORE.dsHeat.DataSet do
  begin
    if not SCM.IsLastRecord(CORE.dsHeat.DataSet) then
    begin
      DisableControls();
      try
        begin
          bm := Bookmark;
          enA := FieldByName('HeatNum').AsInteger;
          enB := 0;
          fld := CORE.qryHeat.FindField('HeatNum');
          try
            begin
              // 3.10.2020 ensure field is writable
              if Assigned(fld) then fld.ReadOnly := false;
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
            if Assigned(fld) then fld.ReadOnly := true;
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
    if not uSession.IsLocked then
      // By default, heat is assumed to be LOCKED.
      // This routine asserts the state of heat dataset (connection, active and
      // not isempty) and if all checks pass, returns the record status.
      // Not locked if the HeatStatusID <> 3.
      if not uHeat.IsClosed then DoEnable := true;
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
  if not AssertConnection then exit;
  With CORE.dsHeat.DataSet do
  begin
    if not SCM.IsFirstRecord(CORE.dsHeat.DataSet) then
    begin
      DisableControls();
      try
        begin
          bm := Bookmark;
          enA := FieldByName('HeatNum').AsInteger;
          enB := 0;
          fld := CORE.qryHeat.FindField('HeatNum');
          try
            begin
              // 3.10.2020 ensure field is writable
              if Assigned(fld) then fld.ReadOnly := false;
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
            if Assigned(fld) then fld.ReadOnly := true;
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
    if not uSession.IsLocked then
      // By default, heat is assumed to be LOCKED.
      // This routine asserts the state of heat dataset (connection, active and
      // not isempty) and if all checks pass, returns the record status.
      // Not locked if the HeatStatusID <> 3.
      if not uHeat.IsClosed then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_NewRecordExecute(Sender: TObject);
begin
  // The event must have DistanceID Assigned!!!
  if CORE.dsEvent.DataSet.FieldByName('DistanceID').IsNull or
    CORE.dsEvent.DataSet.FieldByName('StrokeID').IsNull then
      raise Exception.Create
      ('Error: The event has not been assigned a distance.');
  uHeat.NewRecord; // + IndvTeam TDataSet refresh
  PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 3, 0);
end;

procedure TMain.Heat_NewRecordUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      // are there any Events?
      if not CORE.dsEvent.DataSet.IsEmpty then
      begin
        // A siatance and stroke is needed before a new heat can be built
        if not CORE.dsEvent.DataSet.FieldByName('DistanceID').IsNull and
          not CORE.dsEvent.DataSet.FieldByName('StrokeID').IsNull then
            DoEnable := true;
      end;
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

procedure TMain.Heat_PrintSetUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Are there any heats? Note: Locked sessions can be printed.
    if not CORE.dsHeat.DataSet.IsEmpty then DoEnable := true;
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
    on E: Exception do ShowMessage('Error opening report.');
  end;
  if HeatControlList.CanFocus then HeatControlList.SetFocus;
end;

procedure TMain.Heat_ReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Are there any heats? Note: Locked sessions can be printed.
    if not CORE.dsHeat.DataSet.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_Scroll(var Msg: TMessage);
// var
// DoEnable: boolean;
 var i: integer;
begin
  {
    DoEnable := false;
    // Would we see a scroll-msg if a there was no connection?
    if not AssertConnection then
    exit;

    // Is the session is locked?
    if (CORE.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 1) then
    begin
    // Is the heat closed?
    if (CORE.dsHeat.DataSet.FieldByName('HeatStatusID').AsInteger <> 3) then
    DoEnable := true;
    end;
    // Set the INDV grid's 'disabled' state.
    if (INDV.Grid.Enabled <> DoEnable) then
    INDV.Grid.Enabled := DoEnable;
    // Set the TEAM 'disabled' state.
    if (TEAM.Grid.Enabled <> DoEnable) then
    TEAM.Grid.Enabled := DoEnable;
  }

  if not AssertConnection then     exit;

(*
    i := gridHeat.DataSource.DataSet.FieldByName('HeatStatusID').AsInteger;
    case i of
      1:
        begin
          lblMsgTab3.Visible := false;
        end;
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
    end;
*)


end;

procedure TMain.Heat_TimeKeeperReportExecute(Sender: TObject);
var
  rptA: TTimeKeeperReportA;
  rptB: TTimeKeeperReportB;
  HeatID: integer;
begin
  if not AssertConnection then exit;
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
  if HeatControlList.CanFocus then HeatControlList.SetFocus;
end;

procedure TMain.Heat_TimeKeeperReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Are there any heats? Note: Locked sessions can be printed.
    if not CORE.dsHeat.DataSet.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Heat_ToggleStatusExecute(Sender: TObject);
var
  i: integer;
begin
  (*
  uHeat.ToggleStatus;
  i := gridHeat.DataSource.DataSet.FieldByName('HeatStatusID').AsInteger;
  case i of
    2:
      begin
        INDV.Grid.Enabled := true;
        INDV.Grid.Invalidate; // Text color changes - needs a repaint.
        TEAM.Grid.Enabled := true;
        TEAM.Grid.Invalidate; // Text color changes - needs a repaint.
        TEAM.GridEntrant.Invalidate;
      end;
    3:
      begin
        INDV.Grid.Enabled := false;
        TEAM.Grid.Enabled := false;
        TEAM.GridEntrant.Enabled := false;
      end;
  else
    begin
      INDV.Grid.Enabled := true;
      TEAM.Grid.Enabled := true;
      TEAM.GridEntrant.Enabled := true;
    end;
  end;

  DisplayHeatStatusMsg(i);

  if HeatControlList.CanFocus then HeatControlList.SetFocus;

  // All the heats have been closed then the event grid will display a tick.
  PostMessage(Main.Handle, SCM_EVENTASSERTSTATUSSTATE, 0, 0);
  *)

end;

procedure TMain.Heat_ToggleStatusUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Checks if session is Empty. Then checks if locked..
    if not uSession.IsLocked then
      // are there any heats?
      if not CORE.dsHeat.DataSet.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Help_AboutExecute(Sender: TObject);
var
  dlg: TAbout;
begin
  dlg := TAbout.Create(self);
  dlg.DBName := 'SwimClubMeet2'; // DEFAULT
  // Note: Safe to call TAbout without connection params assigned.
  if AssertConnection then dlg.DBConnection := SCM.scmConnection;
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
  if fMyInternetConnected then TAction(Sender).Enabled := true
  else TAction(Sender).Enabled := false;
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
  if fMyInternetConnected then TAction(Sender).Enabled := true
  else TAction(Sender).Enabled := false;
end;

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

procedure TMain.Nominate_ControlListBeforeDrawItem(AIndex: integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
var
  s: string;
  b: boolean;
begin
(*
  with gridNominee.DataSet do
  begin
    clistEventDistStrokeStr.Caption := FieldByName('DistStrokeStr').AsString;

    s := FieldByName('Caption').AsString;
    if (s = '') then clistEventCaption.Caption := ''
    else clistEventCaption.Caption := s;
    b := FieldByName('IsNominated').AsBoolean;
    if b then clistCheckBox.ImageIndex := 1
    else clistCheckBox.ImageIndex := 0;
    b := FieldByName('IsQualified').AsBoolean;
    if b then vimage.ImageIndex := 24
    else vimage.ImageIndex := -1;
  end;
  *)
end;

procedure TMain.Nominate_EditChange(Sender: TObject);
var
  fs: String;
begin
  if not AssertConnection then exit;
  fs := '';
  with CORE.dsNominee.DataSet do
  begin
    DisableControls;
    // update filter string ....
    if (Length(Nominate_Edit.Text) > 0) then
    begin
      fs := fs + '[FName] LIKE ' + QuotedStr('%' + Nominate_Edit.Text + '%');
    end;
    // assign filter
    if fs.IsEmpty then Filtered := false
    else
    begin
      Filter := fs;
      if not Filtered then Filtered := true;
    end;
    EnableControls;
  end;
end;

procedure TMain.Nominate_GotoMemberDetailsExecute(Sender: TObject);
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
		WHERE NomineeID = :ID1
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

procedure TMain.Nominate_GotoMemberDetailsUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
	if AssertConnection then // connected to database - tables are active.
		if (uEvent.EventType() = etINDV) then // individual event.
			if not CORE.dsLane.DataSet.IsEmpty then // we have lanes.
				if not CORE.dsLane.DataSet.FieldByName('NomineeID').IsNull then // empty lane
					DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Nominate_GridDblClick(Sender: TObject);
begin
  Nominate_MemberDetailsExecute(self);
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

procedure TMain.Nominate_MemberDetailsExecute(Sender: TObject);
var
  dlg: TManageMember;
  MemberID: integer;
begin
  if not AssertConnection then exit;
  dlg := TManageMember.Create(self);
  MemberID := CORE.dsNominee.DataSet.FieldByName('MemberID').AsInteger;
  try
    dlg.Prepare(SCM.scmConnection, 1, MemberID);
    dlg.ShowModal;
  finally
    dlg.Free;
  end;
end;

procedure TMain.Nominate_MemberDetailsUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // No members listed.
    if not Nominate_Grid.DataSource.DataSet.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Nominate_ReportExecute(Sender: TObject);
var
  rptA: TNominateReportA;
  rptB: TNominateReportB;
begin
  if not AssertConnection then exit;
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
  if Nominate_Grid.CanFocus then Nominate_Grid.SetFocus;
end;

procedure TMain.Nominate_ReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // No members listed. Nothing to sort.
    if not Nominate_Grid.DataSource.DataSet.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

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

procedure TMain.PageControl1Change(Sender: TObject);
begin
  // Update page
  case (PageControl1.TabIndex) of
    0: // S e s s i o n .
      begin

        PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 1, 0);
      end;

    1: // N o m i n a t e .
      begin
        PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 2, 0);
        if Nominate_Grid.CanFocus then
          Nominate_Grid.SetFocus;
			end;
    2: // H e a t s .
      begin
        PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 3, 0);
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
          CORE.qryEvent.CheckBrowseMode;
          CORE.qrySession.CheckBrowseMode;
        end;
      1:
      begin
        ;
      end;
      2:
        begin
          CORE.qryLane.CheckBrowseMode;
          CORE.qryTeam.CheckBrowseMode;
          CORE.qryHeat.CheckBrowseMode;
        end;
    end;
  end;
end;

procedure TMain.Refresh_Event(DoBookmark: boolean = true;
  DoRenumber: boolean = false);
var
  v: variant;
begin
  if not AssertConnection then exit;
  with CORE.dsEvent.DataSet do
  begin
    DisableControls;
    if Active and not IsEmpty then
    begin
      v := FieldByName('EventID').AsVariant;
    end;
    Close;
    Open;
    if Active then
    begin
      if DoRenumber then
      begin
				uSession.RenumberEvents(false, false);
        Refresh;
			end;
      if not VarIsNull(v) and not VarIsEmpty(v) and (v > 0) then
          uEvent.Locate(v);
    end;
    EnableControls;
  end;
end;

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
      uEvent.RenumberHeats(false, false);
      uHeat.Locate(aHeatID);
    end;
    EnableControls;
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



procedure TMain.Refresh_Nominate(DoBookmark: boolean = true);
var
  bm: TBookmark;
begin
  if not AssertConnection then exit;
  bm := nil;
  // Update the CORE.dsQmember's table
  // (may have changed if the user has been editing the member's table
  // in the member's dialogue)
  with CORE.dsNominee.DataSet do
  begin
    DisableControls;
    if Active and not IsEmpty then bm := GetBookmark;
    Close;
    Open;
    if Active then
    begin
      try
        // NOTE: Posts nominate-scroll event - forces a nominate_controllist update.
        if Assigned(bm) then GotoBookmark(bm);
      finally;
      end;
    end;
		Nominate_ControlList.ItemCount := SCM.qryNominateEvent.RecordCount;
    EnableControls;
  end;
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

procedure TMain.RenumberHeats(var Msg: TMessage);
var
  aEventID, aHeatID: integer;
begin
  if not AssertConnection then exit;

  aEventID := CORE.dsEvent.DataSet.FieldByName('EventID').AsInteger;
  aHeatID := CORE.dsHeat.DataSet.FieldByName('HeatID').AsInteger;
	uHeat.RenumberLanes(true);
	uEvent.RenumberHeats(true, true);
end;

procedure TMain.SCM_ManageMembersExecute(Sender: TObject);
var
  dlg: TManageMember;
begin
  if not AssertConnection then exit;
  dlg := TManageMember.Create(self);
  try
		dlg.Prepare(SCM.scmConnection, uSwimClub.PK, 0);
    dlg.ShowModal();
  finally
    dlg.Free;
  end;
	// requery on dmSCM members
  Refresh_Nominate;
  // count the number of members in DB prior to PostMessage
  fCountOfMembers := CORE.Members_Count;
  // Assert the 'No Members' Caption in TLabel lblNomWarning
  // refresh all controls and labels on active tabsheet
  // via page control - it also actions SCM_TABSHEETDISPLAYSTATE
  PageControl1Change(PageControl1);

end;

procedure TMain.SCM_ManageMembersUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.SCM_RefreshExecute(Sender: TObject);
var
  DoRenumber: boolean;
begin
  if not AssertConnection then exit;
  // Renumber the Events/Heats/Teams/Entrants
  if ((GetKeyState(VK_CONTROL) and 128) = 128) then DoRenumber := true
  else DoRenumber := false;

  // Disable everthing
  CORE.dsSession.DataSet.DisableControls;
  CORE.dsEvent.DataSet.DisableControls;
  CORE.dsHeat.DataSet.DisableControls;
	CORE.dsLane.DataSet.DisableControls;
  CORE.dsTeam.DataSet.DisableControls;
	CORE.dsTeamLink.DataSet.DisableControls;
  // SESSION
  Session_SortExecute(self);
  // EVENT
  Refresh_Event(true, DoRenumber);
  // NOMINEE + NOMINATE_GRID
  Refresh_Nominate;
  // HEAT
  Refresh_Heat(true, DoRenumber);
  // ENTRANT/TEAM
  Refresh_IndvTeam(true, DoRenumber);
  // TEAMENTRANT
  Refresh_TeamEntrant;

  CORE.dsSession.DataSet.EnableControls;
  CORE.dsEvent.DataSet.EnableControls;
  CORE.dsHeat.DataSet.EnableControls;
	CORE.dsLane.DataSet.EnableControls;
  CORE.dsTeam.DataSet.EnableControls;
	CORE.dsTeamLink.DataSet.EnableControls;
end;

procedure TMain.SCM_RefreshUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.SCM_StatusBarExecute(Sender: TObject);
var
  dt: TDateTime;
  s: String;
  aSessionID, i: integer;
begin

  if (CORE.dsSession.DataSet.IsEmpty) then
  begin
    Main.StatusBar1.Panels.BeginUpdate;
    for i := 0 to Main.StatusBar1.Panels.Count - 1 do
        Main.StatusBar1.Panels.Items[i].Text := '';
    Main.StatusBar1.Panels.EndUpdate;
    fDoStatusBarUpdate := false;
    exit;
  end;

  if (CORE.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 2) then
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
          dt := CORE.dsSession.DataSet.FieldByName('SessionStart').AsDateTime;
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
          aSessionID := CORE.dsSession.DataSet.FieldByName('SessionID')
            .AsInteger;
          s := IntToStr(uSession.GetNomineeCount());
          Main.StatusBar1.Panels.Items[i].Text := 'Nominees: ' + s;
        end;
      2:
        begin
          // ENTRANTS ...
          aSessionID := CORE.dsSession.DataSet.FieldByName('SessionID')
            .AsInteger;
          s := IntToStr(uSession.GetEntrantCount);
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
    if fDoStatusBarUpdate and not fSCMisInitializing then DoEnable := true;
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
  if not AssertConnection then exit;
  if CORE.dsEvent.DataSet.IsEmpty then exit;
  // Assume current event ID is not zero.
  AllClosed := uEvent.AllHeatsAreClosed();
  currStatus := CORE.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger;
  if (AllClosed and (currStatus = 1)) or (not AllClosed and (currStatus = 2))
  then
  begin
    CORE.dsEvent.DataSet.DisableControls;
    if AllClosed then reqStatus := 2
    else reqStatus := 1;
    // only modify the record if required ...
    if (currStatus <> reqStatus) then
    begin
      // bookmark the current record
      bm := CORE.dsEvent.DataSet.GetBookmark;
      // 13.10.2020 CORE.qryEvent.EventStatusID is READ ONLY
      fld := CORE.dsEvent.DataSet.FindField('EventStatusID');
      if Assigned(fld) then fld.ReadOnly := false;
      // go update the status of the event
      CORE.dsEvent.DataSet.Edit;
      CORE.dsEvent.DataSet.FieldByName('EventStatusID').AsInteger := reqStatus;
      if (AllClosed = true) then
          CORE.dsEvent.DataSet.FieldByName('CloseDT').AsDateTime := Now;
      CORE.dsEvent.DataSet.Post;
      CORE.dsEvent.DataSet.Refresh;
      if Assigned(fld) then fld.ReadOnly := true;
      try
        // que to event record
        CORE.dsEvent.DataSet.GotoBookmark(bm);
      except
      end;
    end;
    CORE.dsEvent.DataSet.EnableControls;
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
  else dlg.Panel2.Caption := 'Batch Print Marshall Reports';
  if IsAbortResult(dlg.ShowModal) then exit;

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
    if (SendToMode = stmSendToFile) then s := 'ERROR: No folder-name given.'
    else s := 'ERROR: No printer selected.';
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
  CORE.dsSession.DataSet.DisableControls;
  CORE.dsEvent.DataSet.DisableControls;
  CORE.dsHeat.DataSet.DisableControls;
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
  CORE.dsSession.DataSet.EnableControls;
  CORE.dsEvent.DataSet.EnableControls;
  CORE.dsHeat.DataSet.EnableControls;
  if (success) then
  begin
    MessageDlg('Batch Print completed without errors.', mtInformation,
      [mbOK], 0);
  end
  else MessageDlg('Batch Print done but with errors(' + IntToStr(errCount) +
      ').' + sLineBreak + 'Check!', mtWarning, [mbOK], 0);
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
    begin
      SCM_RefreshExecute(self);
    end;
    dlg.Free;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TMain.Session_CloneUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if not CORE.dsSession.DataSet.IsEmpty then DoEnable := true;
  end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_DeleteExecute(Sender: TObject);
var
  rtnValue, aSessionID: integer;
begin
  if not AssertConnection then exit;
  if CORE.dsSession.DataSet.IsEmpty then exit;
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
  { D E L E T E  S E S S I O N   D O   N O T   E X C L U D E ! }
  uSession.DeleteRecord(false);
  // update the grid views
  SCM_RefreshExecute(self);
  PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 1, 0);
end;

procedure TMain.Session_DeleteUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if not CORE.dsSession.DataSet.IsEmpty then
    begin
      if not uSession.IsLocked then DoEnable := true;
    end;
  end;
  // no connection or no events or event is closed - disable actions
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_EditExecute(Sender: TObject);
var
  dlg: TNewSession;
begin
  if not AssertConnection then exit;
  dlg := TNewSession.CreateWithConnection(self, SCM.scmConnection);
  dlg.SessionMode := smEditSession;
  dlg.SessionID := uSession.PK;
  if IsPositiveResult(dlg.ShowModal) then Session_SortExecute(self);
  dlg.Free;
end;

procedure TMain.Session_EditUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    if not CORE.dsSession.DataSet.IsEmpty then DoEnable := true;
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
  else Session_Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
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
    // ATERNATIVE...
    // This routine disables all controls across all tables..
    // SCM_RefreshExecute(self);

    CORE.dsSession.DataSet.DisableControls;
    CORE.dsSession.DataSet.Close; // Requery,
    CORE.dsSession.DataSet.Open;
    CORE.dsSession.DataSet.EnableControls;

    uSession.Locate(dlg.SessionID); // CUE-TO NEW session.
    PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 1, 0);
  end;
  dlg.Free;
end;

procedure TMain.Session_NewUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // only a connection is required to create a new session
  if AssertConnection then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_RenumberEvents(var Msg: TMessage);
begin
  uSession.RenumberEvents(true, true);
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
    on E: Exception do ShowMessage(E.Message);
  end;
  if Session_Grid.CanFocus then Session_Grid.SetFocus;
end;

procedure TMain.Session_ReportUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
  begin
    if not CORE.dsSession.DataSet.IsEmpty then
      // 13.10.2020 : A report can be printed even if the session is locked.
        DoEnable := true;
  end;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Session_Scroll(var Msg: TMessage);
begin
  if AssertConnection then
  begin
    if (CORE.dsSession.DataSet.FieldByName('SessionStatusID').AsInteger = 2) then
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

  PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 1, 0);

  // S T A T U S B A R .
  // Session scroll will change statusbar totals for the session
  fDoStatusBarUpdate := true; // permits ACTION (flag sets false after update)
  // SCM_StatusBar.Update;
  SCM_StatusBar.Execute;
end;

procedure TMain.Session_SortExecute(Sender: TObject);
var
  aSessionID: integer;
begin
  if AssertConnection then
  begin
    aSessionID := uSession.PK;
    Session_Grid.DataSource.DataSet.Close;
// ORIGINALLY ... simple refresh : not effective enough.
//    Session_Grid.DataSource.DataSet.Refresh;
    Session_Grid.DataSource.DataSet.Open;
    try
      uSession.Locate(aSessionID);
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
    if not CORE.dsSession.DataSet.IsEmpty then DoEnable := true;
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
  uSession.ToggleLockState;
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
    if not CORE.dsSession.DataSet.IsEmpty then DoEnable := true;
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
    uSession.HideLocked(Checked);
    if Session_Grid.CanFocus then Session_Grid.SetFocus;
  end;
end;

procedure TMain.Session_ToggleVisibleUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then
    if not CORE.dsSession.DataSet.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.SetTabSheetDisplayState(var Msg: TMessage);
var
  aEventType: scmEventType;
  aHeatStatusID: integer;
begin

  // SCM_TABSHEETDISPLAYSTATE

  if not AssertConnection then exit;
  if (Msg.WParam = 0) or (Msg.WParam = 1) then
  begin
    {
      --------------------------------------------------------------
      TOGGLE VISIBILITY OF EVENT GRID PANEL
      --------------------------------------------------------------
    }
    Session_Grid.Visible := true;
    Event_Grid.Visible := true;
    lblMsgTab1.Visible := false;
    StatusBar1.Panels[3].Text := '';
    if CORE.dsSession.DataSet.IsEmpty then
    begin
      Event_Grid.Visible := false;
      lblMsgTab1.Caption := 'No Sessions';
      lblMsgTab1.Visible := true;
    end
    else if CORE.dsEvent.DataSet.IsEmpty then
    begin
      lblMsgTab1.Caption := 'No Events';
      lblMsgTab1.Visible := true;
    end;
  end;
  if (Msg.WParam = 0) or (Msg.WParam = 2) then
  begin
    {
      --------------------------------------------------------------
      NOMINATION
      --------------------------------------------------------------
      What nominate refresh does:
      ----------------------------------------------------
      Nominate_UpdateStatusLabels;
      Resets last known qualified MemberID to unknown.
      Nominate_ControlList.Invalidate;
    }
    lblNomWarning.Visible := false;
    Refresh_Nominate;
    if (CORE.dsSession.DataSet.IsEmpty) then
    begin
      // lblNomWarning.Font.Color := clWebTomato;
      lblNomWarning.Caption := 'Session is Empty';
      lblNomWarning.Visible := true;
    end
    else if uSession.IsLocked then
    begin
      // lblNomWarning.Font.Color := clWebTomato;
      lblNomWarning.Caption := 'Session is Locked';
      lblNomWarning.Visible := true;
    end
    else if (CORE.dsEvent.DataSet.IsEmpty) then
    begin
      // lblNomWarning.Font.Color := clWebTomato;
      lblNomWarning.Caption := 'No Events in Session';
      lblNomWarning.Visible := true;
    end
    else if CORE.dsEvent.DataSet.FieldByName('DistanceID').IsNull or
      CORE.dsEvent.DataSet.FieldByName('StrokeID').IsNull then
    // A Distance and stroke is needed before a new heat can be built
    begin
      lblNomWarning.Caption := 'Distance .. Stroke?';
      lblNomWarning.Visible := true;
    end
    // Calculation of fCountOfMembers made 'OnCreate' and 'SCM_ManageMembers' (TAction)
    else if (fCountOfMembers = 0) then
    begin
    // lblNomWarning.Font.Color := clWebTomato;
    lblNomWarning.Caption := 'No Members';
    lblNomWarning.Visible := true;
    end;

  end;

  if (Msg.WParam = 0) or (Msg.WParam = 3) then
  begin
    {
      --------------------------------------------------------------
      TOGGLE VISIBILITY OF INDV or TEAM GRIDS
      --------------------------------------------------------------
    }
    lblMsgTab3.Visible := false;
    pnlClient.Visible := true;
    HeatControlList.Visible := true;
    StatusBar1.Panels[3].Text := '';

		if CORE.dsSession.DataSet.IsEmpty then
    begin
      pnlClient.Visible := false;
      lblMsgTab3.Caption := 'No Sessions';
      lblMsgTab3.Visible := true;
      //StatusBar1.Panels[3].Text := 'Create a new session.';
    end
    else if CORE.dsEvent.DataSet.IsEmpty then
    begin
      pnlClient.Visible := false;
      lblMsgTab3.Caption := 'No Events';
      lblMsgTab3.Visible := true;
      //StatusBar1.Panels[3].Text :=
      //  'Use the NEW EVENT button to create an event.';
    end
    else if CORE.dsEvent.DataSet.FieldByName('DistanceID').IsNull or
      CORE.dsEvent.DataSet.FieldByName('StrokeID').IsNull then
    begin
      pnlClient.Visible := false;
      lblMsgTab3.Caption := 'Distance-Stroke?';
      lblMsgTab3.Visible := true;
      //StatusBar1.Panels[3].Text := 'Assign a distance and stroke to the event.';
    end
    else if CORE.dsHeat.DataSet.IsEmpty then
    begin
      lblMsgTab3.Caption := 'No Heats';
      lblMsgTab3.Visible := true;
      //StatusBar1.Panels[3].Text := 'Use the NEW HEAT button to create a heat';
    end
    else
    begin
      if not uEvent.HasNominees() then
      begin
        lblMsgTab3.Caption := 'No Nominees';
        lblMsgTab3.Visible := true;
        // StatusBar1.Panels[3].Text := 'Nominate members to your events.';
      end;

    end;

    // if not message to display - check if a heatstatus can be shown
    if (PageControl1.ActivePageIndex = 2) and (lblMsgTab3.Visible = false) then
    begin
      aHeatStatusID := uHeat.HeatStatusID();
      DisplayHeatStatusMsg(aHeatStatusID);
    end;

    if CORE.dsEvent.DataSet.IsEmpty or CORE.dsHeat.DataSet.IsEmpty then
    begin // No Events or no heats
      TEAM.Visible := false;
      INDV.Visible := false;
      TEAM.Panel1.Color := fFrameBgColor;
      TEAM.Panel3.Color := fFrameBgColor;
    end
    else
    begin
      aEventType := uEvent.EventType;
      if aEventType = etINDV then
      begin // INDIVIDUAL EVENT
        TEAM.Visible := false;
        INDV.Visible := true;
      end
      else if aEventType = etTEAM then
      begin // RELAY TEAMS
        TEAM.Visible := true;
        INDV.Visible := false;
      end
      else
      begin // UNKNOWN
        TEAM.Visible := false;
        INDV.Visible := false;
        TEAM.Panel1.Color := fFrameBgColor;
        TEAM.Panel3.Color := fFrameBgColor;
      end;
    end;
  end;

end;

procedure TMain.SwimClub_ManageExecute(Sender: TObject);
var
dlg: TSwimClubManage;
ASwimClubID: integer;
begin
  dlg := TSwimClubManage.Create(Self);
  ASwimClubID := CORE.dsSwimClub.DataSet.FieldByName('SwimClubID').AsInteger;
  dlg.ActiveSwimClub := ASwimClubID;
  if  IsPositiveResult(dlg.ShowModal) and (dlg.ActiveSwimClub <> ASwimClubID) then
  begin
    uSwimClub.Locate(dlg.ActiveSwimClub);
    ExecuteAction(SCM_Refresh);
  end;
end;

procedure TMain.SwimClub_ManageUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Are there any clubs in this database?
    if not CORE.dsSwimClub.DataSet.IsEmpty then DoEnable := true;
  // finally ...
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.SwimClub_SwitchExecute(Sender: TObject);
var
dlg: TSwimClubSwitch;
ASwimClubID: integer;
begin
  dlg := TSwimClubSwitch.Create(Self);
  ASwimClubID := CORE.dsSwimClub.DataSet.FieldByName('SwimClubID').AsInteger;
  dlg.ActiveSwimClub := ASwimClubID;
  if  IsPositiveResult(dlg.ShowModal) and (dlg.ActiveSwimClub <> ASwimClubID) then
  begin
    uSwimClub.Locate(dlg.ActiveSwimClub);
    ExecuteAction(SCM_Refresh);
  end;
end;

procedure TMain.SwimClub_SwitchUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertConnection then
    // Are there any clubs in this database?
    if not CORE.dsSwimClub.DataSet.IsEmpty then DoEnable := true;
  // finally ...
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.TeamEntrant_Scroll(var Msg: TMessage);
begin
  // messaged by TCORE.qryMemberQuickPickAfterScroll
  // messaged by TCORE.qryTeamEntrantAfterScroll
  if not AssertConnection then exit;
  if (PageControl1.ActivePageIndex = 2) then TEAM.TeamEntrantScroll;
end;

procedure TMain.Team_Scroll(var Msg: TMessage);
begin
	// Messaged by TCORE.qryTeamAfterScroll  - uEvent.EventType = etTEAM
  if not AssertConnection then exit;
  if (PageControl1.ActivePageIndex = 2) then TEAM.TeamScroll;
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
	with CORE.dsLane.DataSet do
  begin
    DisableControls;
    fld := Fields.FindField('luDivision');
    if Assigned(fld) then fld.Visible := SetVisible;
    EnableControls;
  end;
end;

procedure TMain.ToggleSwimmerCAT(SetVisible: boolean);
var
  fld: TField;
begin
  // NOTE: Swimmer Category and Divisions mutally exclusive.
	with CORE.dsLane.DataSet do
  begin
    DisableControls;
    fld := Fields.FindField('luCategory');
    if Assigned(fld) then fld.Visible := SetVisible;
    EnableControls;
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
  if not AssertConnection then exit;
  results := MessageDlg('Open the database connection tool?.' + sLineBreak +
    'If you have other SwimClubMeet2 apps running' + sLineBreak +
    'on this computer then they should be closed.' + sLineBreak +
    '(Be patient, this tool is slow to load.)', mtConfirmation,
    [mbYes, mbNo], 0, mbNo);
  if (results <> mrYes) then exit;

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
  if (passed) then SCM.scmConnection.ResultConnectionDef.ParseString(sConnStr);
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
  if dlg.fDCodesUpdated then
  begin
    { Find the FINA DCode 'alias' for the simplified disqualification.}
    INDV.fIsScratchedDCode := SCM.GetIsScratchedDCode;
    INDV.fIsDisqualifiedDCode := SCM.GetIsDisqualifiedDCode;
    TEAM.fIsScratchedDCode := SCM.GetIsScratchedDCode;
    TEAM.fIsDisqualifiedDCode := SCM.GetIsDisqualifiedDCode;
  end;
  dlg.Free;
end;

procedure TMain.Tools_DivisionsExecute(Sender: TObject);
var
  dt: TDateTime;
  dlg: TDivision;
begin
  // TActionUpdate determine access to this routine.
	dt := uSwimClub.StartOfSwimSeason();
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
  if AssertConnection then DoEnable := true;
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
  if AssertConnection then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Tools_LeaderBoardExecute(Sender: TObject);
var
  dlg: TLeaderBoard;
begin
  // TActionUpdate determins if this routine can be accessed.
  dlg := TLeaderBoard.Create(self);
  dlg.Connection := SCM.scmConnection;
	dlg.SessionID := uSession.PK;
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Tools_LeaderBoardUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.Tools_PreferencesExecute(Sender: TObject);
var
  dlg: TPreferences;
begin
  // finalize any editing before opening options dialogue
  if not AssertConnection then exit;
  case PageControl1.TabIndex of
    0:
      begin
				CORE.qryEvent.CheckBrowseMode;
        CORE.qrySession.CheckBrowseMode;
      end;
    2:
      begin
        CORE.qryLane.CheckBrowseMode;
        CORE.qryHeat.CheckBrowseMode;
      end;
  end;
  CORE.qrySwimClub.CheckBrowseMode;
  dlg := TPreferences.Create(self, SCM.scmConnection);
  dlg.ShowModal();
  dlg.Free;

  GetSCMPreferences();
  ToggleDCode(prefEnableDCode);
//  ToggleSwimmerCAT(prefDisplaySwimmerCAT);
//  ToggleDivisions(prefDisplayDivisions);
  // ToggleTeamEvents(prefEnableTeamEvents);

  // deals with some repaint issues if event title is enabled/disabled
  { TODO -oBSA -cGeneral : Call action SCMRefresh? }
  Refresh_Event();

  CORE.qrySwimClub.Refresh();
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
  if not AssertConnection then exit;
  dlg := TPointsScored.Create(self);
  dlg.Connection := SCM.scmConnection;
  dlg.SwimClubID := uSwimClub.PK;
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.Tools_ScoreUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  // Are we connected?
  if AssertConnection then DoEnable := true;
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
  if AssertConnection then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TMain.UpdateEntrantCount(var Msg: TMessage);
var
  aEventID: integer;
begin
  if not AssertConnection then exit;
	aEventID := uEvent.PK;
  if aEventID = 0 then exit;
  // If entrant or team or team-entrant post
  // from frame_TEAM or frame_INDV then a
  // refresh of qryEvent and re-locate is all
  // that's required to keep record sync.
  CORE.dsEvent.DataSet.DisableControls;
  CORE.dsEvent.DataSet.Refresh;
  uEvent.Locate(aEventID);
	CORE.dsEvent.DataSet.EnableControls;
end;

procedure TMain.UpdateINDVTEAM(var Msg: TMessage);
begin
  Refresh_Event;
  PostMessage(Handle, SCM_TABSHEETDISPLAYSTATE, 3, 0);
end;

procedure TMain.UpdateStatusBar(var Msg: TMessage);
begin
  // S T A T U S B A R .
  fDoStatusBarUpdate := true; // flag set false after SCM_StatusBarExecute.
  SCM_StatusBar.Update; // Asserts enabled state.
  SCM_StatusBar.Execute; // Fire actions
end;

end.
