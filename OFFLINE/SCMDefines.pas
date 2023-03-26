unit SCMDefines;

interface

uses
  Winapi.Messages;

const
  SCM_NOMINATESCROLL = WM_USER + 1;
  SCM_SESSIONSCROLL = WM_USER + 2;
  SCM_ENTRANTSCROLL = WM_USER + 3;
  SCM_EVENTSCROLL = WM_USER + 4;
  SCM_HEATSCROLL = WM_USER + 5;
  SCM_EVENTASSERTSTATE = WM_USER + 6;
  SCM_EVENTASSERTSTATUSSTATE = WM_USER + 7;
  SCM_SESSIONASSERTSTATUSSTATE = WM_USER + 8;
  SCM_PROGRESSBARBEGIN = WM_USER + 9;
  SCM_PROGRESSBARUPDATE = WM_USER + 10;
  SCM_PROGRESSBAREND = WM_USER + 11;

  {
    L e a d e r B o a r d .
    (Depreciated? CHECK)
    SCMDefines may be referenced in SCM_LEADERBOARD
  }
  LB_INITIALISE = WM_USER + 12;
  LB_EMPTYENTRANTS = WM_USER + 13;
  LB_UPDATEENTRANTS = WM_USER + 14;
  LB_EMPTYEVENTS = WM_USER + 15;
  LB_UPDATEMEMBERSAGE = WM_USER + 16;
  LB_UPDATESESSION = WM_USER + 17;
  LB_UPDATEMEMBERSSCORE = WM_USER + 18;
  LB_PROGRESSBARBEGIN = WM_USER + 19;
  LB_PROGRESSBARUPDATE = WM_USER + 20;
  LB_PROGRESSBAREND = WM_USER + 21;
  LB_UPDATEENTRANTSSCORE = WM_USER + 22;
  LB_OPTIONS = WM_USER + 23;

  // Messages used in Manage Members form.
  MANAGEMEMBER_AFTERSCROLL =  WM_USER + 26;
  MANAGEMEMBER_UPDATE = WM_USER + 27;

  // Messages sent by dmSCMNom
  SCM_LANEWASCLEANED = WM_USER + 28;  // refresh of entrant grid required

type
  scmSendToFileType = (sftPDF, sftXLS, sftHTML, sftNA);
  scmSendToMode = (stmSendToPrinter, stmSendToFile);
  scmRptType = (rtMarshall, rtTimeKeeper);

  seedMethod = (
    // *********************************
    // U S E R   S E L E C T I O N . . .
    // *********************************
    // times used = TTB algorithym
    smSCMSeeding = 0,
    // times used = TTB algorithym,
    // circle for depth count then switch to smSCMSeeding
    smCircleSeeding,
    // *********************************
    // I N T E R N A L . . . S Y S T E M
    // *********************************
    // times used originate from events held in current session
    // must be semi-finals race-times else ...
    smTimedFinalsSeeding,
    // times used originate from events held in current session
    // must be quarter-finals race-times
    smCircleSeedingTimed,
    // times used originate from events held in current session
    // Event must be built using the Team-Event utility
    // Used for relays
    smDualSeeding,
    // times used originate from events held in current session
    smMastersChampionSeeding);

  scmEventFinalsType = (ftFinals, ftSemi, ftQuarter);

var
  scmSendToFileTypes: scmSendToFileType;
  scmSendToModes: scmSendToMode;
  scmRptTypes: scmRptType;

implementation

end.
