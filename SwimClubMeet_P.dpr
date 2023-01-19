program SwimClubMeet_P;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {Main},
  Vcl.Themes,
  Vcl.Styles,
  dlgAbout in 'dlgAbout.pas' {About},
  dlgBasicLogin in 'dlgBasicLogin.pas' {BasicLogin},
  dlgBootProgress in 'dlgBootProgress.pas' {BootProgress},
  dlgCloneSession in 'dlgCloneSession.pas' {CloneSession},
  dlgDivision in 'dlgDivision.pas' {Division},
  dlgHouse in 'dlgHouse.pas' {House},
  dlgLeaderBoard in 'dlgLeaderBoard.pas' {LeaderBoard},
  dlgNewSession in 'dlgNewSession.pas' {NewSession},
  dlgPointsScored in 'dlgPointsScored.pas' {PointsScored},
  dlgPreferences in 'dlgPreferences.pas' {Preferences},
  dmAutoBuildV2 in 'dmAutoBuildV2.pas' {AutoBuildV2: TDataModule},
  dmReports in 'dmReports.pas' {RPTS: TDataModule},
  dmSCM in 'dmSCM.pas' {SCM: TDataModule},
  dmSCMNom in 'dmSCMNom.pas' {SCMNom: TDataModule},
  SCMExeInfo in 'SCMExeInfo.pas',
  SCMDefines in 'SCMDefines.pas',
  SCMUtility in 'SCMUtility.pas',
  dlgAutoBuild_Heats in 'dlgAutoBuild_Heats.pas' {AutoBuild_Heats},
  dlgQualifyTimes in 'dlgQualifyTimes.pas' {QualifyTimes},
  dlgSwapLanes in 'dlgSwapLanes.pas' {SwapLanes},
  dlgMembershipType in 'dlgMembershipType.pas' {MembershipType},
  dlgDeleteMember in 'MEMBERS\dlgDeleteMember.pas' {DeleteMember},
  dlgFindMember in 'MEMBERS\dlgFindMember.pas' {FindMember},
  dlgGotoMember in 'MEMBERS\dlgGotoMember.pas' {GotoMember},
  dlgGotoMembership in 'MEMBERS\dlgGotoMembership.pas' {GotoMembership},
  frmManageMember in 'MEMBERS\frmManageMember.pas' {ManageMember},
  dlgDOBPicker in 'dlgDOBPicker.pas' {DOBPicker},
  dmManageMemberData in 'MEMBERS\dmManageMemberData.pas' {ManageMemberData: TDataModule},
  rptEventReportA in 'REPORTS\rptEventReportA.pas' {EventReportA: TDataModule},
  rptEventReportB in 'REPORTS\rptEventReportB.pas' {EventReportB: TDataModule},
  rptMarshallReportA in 'REPORTS\rptMarshallReportA.pas' {MarshallReportA: TDataModule},
  rptMarshallReportB in 'REPORTS\rptMarshallReportB.pas' {MarshallReportB: TDataModule},
  rptNominateReportA in 'REPORTS\rptNominateReportA.pas' {NominateReportA: TDataModule},
  rptNominateReportB in 'REPORTS\rptNominateReportB.pas' {NominateReportB: TDataModule},
  rptQTDistStrokeReportA in 'REPORTS\rptQTDistStrokeReportA.pas' {QTDistStrokeReportA: TDataModule},
  rptQTMemberReportA in 'REPORTS\rptQTMemberReportA.pas' {QTMemberReportA: TDataModule},
  rptQTSessionReportA in 'REPORTS\rptQTSessionReportA.pas' {QTSessionReportA: TDataModule},
  rptQTTableReportA in 'REPORTS\rptQTTableReportA.pas' {QTTableReportA: TDataModule},
  rptSessionReportA in 'REPORTS\rptSessionReportA.pas' {SessionReportA: TDataModule},
  rptSessionReportB in 'REPORTS\rptSessionReportB.pas' {SessionReportB: TDataModule},
  rptTimeKeeperReportA in 'REPORTS\rptTimeKeeperReportA.pas' {TimeKeeperReportA: TDataModule},
  rptTimeKeeperReportB in 'REPORTS\rptTimeKeeperReportB.pas' {TimeKeeperReportB: TDataModule},
  dlgAutoBuild_Finals in 'dlgAutoBuild_Finals.pas' {AutoBuild_Finals},
  dlgSelectPrinter in 'dlgSelectPrinter.pas' {SelectPrinter},
  dlgBatchProgress in 'dlgBatchProgress.pas' {BatchProgress},
  dlgAutoBuildPref in 'dlgAutoBuildPref.pas' {AutoBuildPref},
  UEnvVars in 'UEnvVars.pas',
  dlgEntrantPicker in 'dlgEntrantPicker.pas' {EntrantPicker},
  dlgEntrantPickerCTRL in 'dlgEntrantPickerCTRL.pas' {EntrantPickerCTRL},
  rptMemberReport in 'MEMBERS\rptMemberReport.pas' {MemberReport: TDataModule},
  rptMembersSummary in 'MEMBERS\rptMembersSummary.pas' {MembersSummaryRpt: TDataModule},
  rptMembersDetail in 'MEMBERS\rptMembersDetail.pas' {MembersDetailRpt: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
