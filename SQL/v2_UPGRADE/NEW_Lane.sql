USE [SwimClubMeet]
go

-- Dictionary Object Alter SQL

CREATE DEFAULT dbo.Def_TIME AS NULL
go

-- Standard Alter Table SQL

ALTER TABLE dbo.Heat DROP CONSTRAINT EventHeat
go
ALTER TABLE dbo.Heat DROP CONSTRAINT HeatTypeHeat
go
ALTER TABLE dbo.Heat DROP CONSTRAINT HeatStatusHeat
go
ALTER TABLE dbo.Heat ADD CONSTRAINT FK_HeatType
FOREIGN KEY (HeatTypeID)
REFERENCES dbo.HeatType (HeatTypeID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Heat ADD CONSTRAINT FK_HeatStatus
FOREIGN KEY (HeatStatusID)
REFERENCES dbo.HeatStatus (HeatStatusID)
 ON DELETE SET NULL
go

-- Drop Referencing Constraint SQL

ALTER TABLE dbo.Nominee DROP CONSTRAINT EventNominee
go
ALTER TABLE dbo.Event DROP CONSTRAINT RoundEvent
go

-- Drop Constraint, Rename and Create Table SQL

DROP TABLE dbo.Split
go
DROP TABLE dbo.SwimmerCategory
go
EXEC sp_rename 'dbo.Team.PK_Team','PK_Team_07232025025942001','INDEX'
go
EXEC sp_rename 'dbo.TeamNameTeam','TeamNameTe_07232025025942002'
go
EXEC sp_rename 'dbo.DisqualifyCodeTeam','Disqualify_07232025025942003'
go
EXEC sp_rename 'dbo.HeatTeam','HeatTeam_07232025025942004'
go
EXEC sp_rename 'dbo.DF__Team__IsScratche__48CFD27E', 'DF__Team___07232025025942005',OBJECT
go
EXEC sp_rename 'dbo.DF__Team__IsDisquali__47DBAE45', 'DF__Team___07232025025942006',OBJECT
go
EXEC sp_rename 'dbo.Team','Team_07232025025942000',OBJECT
go
CREATE TABLE dbo.Team
(
    TeamID     int            IDENTITY,
    Caption    nvarchar(128)  NULL,
    RaceTime   time(7)        NULL,
    TimeToBeat time(7)        NULL,
    TeamNameID int            NULL
)
ON [PRIMARY]
go
GRANT DELETE ON dbo.Team TO SCM_Administrator
go
GRANT INSERT ON dbo.Team TO SCM_Administrator
go
GRANT SELECT ON dbo.Team TO SCM_Administrator
go
GRANT UPDATE ON dbo.Team TO SCM_Administrator
go
GRANT SELECT ON dbo.Team TO SCM_Guest
go
GRANT DELETE ON dbo.Team TO SCM_Marshall
go
GRANT INSERT ON dbo.Team TO SCM_Marshall
go
GRANT SELECT ON dbo.Team TO SCM_Marshall
go
GRANT UPDATE ON dbo.Team TO SCM_Marshall
go
DROP TABLE dbo.TeamEntrant
go
DROP TABLE dbo.TeamSplit
go
EXEC sp_rename 'dbo.Entrant.PK_Entrant','PK_Entrant_07232025025943001','INDEX'
go
EXEC sp_rename 'dbo.FK_MemberLinkEntrant','FK_MemberL_07232025025943002'
go
EXEC sp_rename 'dbo.HeatEntrant','HeatEntran_07232025025943003'
go
EXEC sp_rename 'dbo.DisqualifyCodeEntrant','Disqualify_07232025025943004'
go
EXEC sp_rename 'dbo.DF__Entrant__IsScrat__182C9B23', 'DF__Entran_07232025025943005',OBJECT
go
EXEC sp_rename 'dbo.DF__Entrant__IsDisqu__173876EA', 'DF__Entran_07232025025943006',OBJECT
go
EXEC sp_rename 'dbo.Entrant','Entrant_07232025025943000',OBJECT
go
CREATE TABLE dbo.Entrant
(
    EntrantID        int      IDENTITY,
    Lane             int      NULL,
    RaceTime         time(7)  NULL,
    TimeToBeat       time(7)  NULL,
    PersonalBest     time(7)  NULL,
    IsDisqualified   bit      CONSTRAINT DF__Entrant__IsDisqu__173876EA DEFAULT ((0))  NOT NULL,
    IsScratched      bit      CONSTRAINT DF__Entrant__IsScrat__182C9B23 DEFAULT ((0))  NOT NULL,
    DisqualifyCodeID int      NULL,
    HeatID           int      NULL,
    MemberID         int       NOT NULL,
    SwimClubID       int       NOT NULL
)
ON [PRIMARY]
go
GRANT DELETE ON dbo.Entrant TO SCM_Administrator
go
GRANT INSERT ON dbo.Entrant TO SCM_Administrator
go
GRANT SELECT ON dbo.Entrant TO SCM_Administrator
go
GRANT UPDATE ON dbo.Entrant TO SCM_Administrator
go
GRANT SELECT ON dbo.Entrant TO SCM_Guest
go
GRANT DELETE ON dbo.Entrant TO SCM_Marshall
go
GRANT INSERT ON dbo.Entrant TO SCM_Marshall
go
GRANT SELECT ON dbo.Entrant TO SCM_Marshall
go
GRANT UPDATE ON dbo.Entrant TO SCM_Marshall
go
EXEC sp_rename 'dbo.Event.PK_Event','PK_Event_07232025025944001','INDEX'
go
EXEC sp_rename 'dbo.SessionEvent','SessionEve_07232025025944002'
go
EXEC sp_rename 'dbo.StrokeEvent','StrokeEven_07232025025944003'
go
EXEC sp_rename 'dbo.DistanceEvent','DistanceEv_07232025025944004'
go
EXEC sp_rename 'dbo.EventStatusEvent','EventStatu_07232025025944005'
go
EXEC sp_rename 'dbo.GenderEvent','GenderEven_07232025025944007'
go
EXEC sp_rename 'dbo.Event','Event_07232025025944000',OBJECT
go
CREATE TABLE dbo.Event
(
    EventID       int            IDENTITY,
    EventNum      int            NULL,
    Caption       nvarchar(128)  NULL,
    ScheduleDT    time(7)        NULL,
    RallyOpenDT   datetime       NULL,
    RallyCloseDT  datetime       NULL,
    OpenDT        datetime       NULL,
    CloseDT       datetime       NULL,
    SessionID     int            NULL,
    StrokeID      int            NULL,
    DistanceID    int            NULL,
    EventStatusID int            NULL,
    RoundID       int            NULL,
    GenderID      int            NULL,
    EventAgeID    int            NULL
)
ON [PRIMARY]
go
GRANT DELETE ON dbo.Event TO SCM_Administrator
go
GRANT INSERT ON dbo.Event TO SCM_Administrator
go
GRANT SELECT ON dbo.Event TO SCM_Administrator
go
GRANT UPDATE ON dbo.Event TO SCM_Administrator
go
GRANT SELECT ON dbo.Event TO SCM_Guest
go
GRANT SELECT ON dbo.Event TO SCM_Marshall
go
EXEC sp_rename 'dbo.Nominee.PK_Nominee','PK_Nominee_07232025025945001','INDEX'
go
EXEC sp_rename 'dbo.FK_MemberLinkNominee','FK_MemberL_07232025025945003'
go
EXEC sp_rename 'dbo.Nominee','Nominee_07232025025945000',OBJECT
go
CREATE TABLE dbo.Nominee
(
    NomineeID     int      IDENTITY,
    TTB           time(7)  NULL,
    PB            time(7)  NULL,
    IsEntrant     bit       NOT NULL,
    SeedTime      time(7)  NULL,
    AutoBuildFlag bit      NULL,
    EventID       int      NULL,
    MemberID      int       NOT NULL,
    SwimClubID    int       NOT NULL
)
ON [PRIMARY]
go
if exists (select * from ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'table', 'Nominee', 'column', 'TTB'))
BEGIN
  exec sys.sp_dropextendedproperty 'MS_Description', 'schema', 'dbo', 'table', 'Nominee', 'column', 'TTB'
END
exec sys.sp_addextendedproperty 'MS_Description', 'RaceTime, PB, TTB, SeedTime all use MS SQLEXPRESS TIME variable', 'schema', 'dbo', 'table', 'Nominee', 'column', 'TTB'
go
if exists (select * from ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'table', 'Nominee', 'column', 'PB'))
BEGIN
  exec sys.sp_dropextendedproperty 'MS_Description', 'schema', 'dbo', 'table', 'Nominee', 'column', 'PB'
END
exec sys.sp_addextendedproperty 'MS_Description', 'RaceTime, PB, TTB, SeedTime all use MS SQLEXPRESS TIME variable', 'schema', 'dbo', 'table', 'Nominee', 'column', 'PB'
go
if exists (select * from ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'table', 'Nominee', 'column', 'SeedTime'))
BEGIN
  exec sys.sp_dropextendedproperty 'MS_Description', 'schema', 'dbo', 'table', 'Nominee', 'column', 'SeedTime'
END
exec sys.sp_addextendedproperty 'MS_Description', 'RaceTime, PB, TTB, SeedTime all use MS SQLEXPRESS TIME variable', 'schema', 'dbo', 'table', 'Nominee', 'column', 'SeedTime'
go
GRANT DELETE ON dbo.Nominee TO SCM_Administrator
go
GRANT INSERT ON dbo.Nominee TO SCM_Administrator
go
GRANT SELECT ON dbo.Nominee TO SCM_Administrator
go
GRANT UPDATE ON dbo.Nominee TO SCM_Administrator
go
GRANT SELECT ON dbo.Nominee TO SCM_Guest
go
GRANT DELETE ON dbo.Nominee TO SCM_Marshall
go
GRANT INSERT ON dbo.Nominee TO SCM_Marshall
go
GRANT SELECT ON dbo.Nominee TO SCM_Marshall
go
GRANT UPDATE ON dbo.Nominee TO SCM_Marshall
go
EXEC sp_rename 'dbo.Round.PK_Round','PK_Round_07232025025946001','INDEX'
go
EXEC sp_rename 'dbo.Round','Round_07232025025946000',OBJECT
go
CREATE TABLE dbo.Round
(
    RoundID      int            IDENTITY,
    Caption      nvarchar(128)  NULL,
    CaptionShort nvarchar(16)   NULL,
    ABREV        nvarchar(2)    NULL
)
ON [PRIMARY]
go
CREATE TABLE dbo.SplitTime
(
    SplitTimeID int            IDENTITY,
    WatchNum    int            NULL,
    Caption     nvarchar(128)  NULL,
    [Time]      time(7)        NULL,
    LaneID      int            NULL,
    CONSTRAINT PK_SplitTime
    PRIMARY KEY CLUSTERED (SplitTimeID)
)
go
if exists (select * from ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'table', 'SplitTime', 'column', 'Time'))
BEGIN
  exec sys.sp_dropextendedproperty 'MS_Description', 'schema', 'dbo', 'table', 'SplitTime', 'column', 'Time'
END
exec sys.sp_addextendedproperty 'MS_Description', 'RaceTime, PB, TTB, SeedTime all use MS SQLEXPRESS TIME variable', 'schema', 'dbo', 'table', 'SplitTime', 'column', 'Time'
go
EXEC sp_bindefault 'Def_TIME', 'dbo.SplitTime.Time'
go
CREATE TABLE dbo.TeamLink
(
    TeamID    int   NOT NULL,
    NomineeID int   NOT NULL,
    SwimOrder int  NULL,
    CONSTRAINT PK106
    PRIMARY KEY CLUSTERED (TeamID,NomineeID)
)
go
CREATE TABLE dbo.WatchTime
(
    WatchTimeID int            IDENTITY,
    LaneID      int            NULL,
    WatchNum    int            NULL,
    Caption     nvarchar(128)  NULL,
    [Time]      time(7)        NULL,
    CONSTRAINT PK105
    PRIMARY KEY CLUSTERED (WatchTimeID)
)
go
if exists (select * from ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'table', 'WatchTime', 'column', 'Time'))
BEGIN
  exec sys.sp_dropextendedproperty 'MS_Description', 'schema', 'dbo', 'table', 'WatchTime', 'column', 'Time'
END
exec sys.sp_addextendedproperty 'MS_Description', 'RaceTime, PB, TTB, SeedTime all use MS SQLEXPRESS TIME variable', 'schema', 'dbo', 'table', 'WatchTime', 'column', 'Time'
go
EXEC sp_bindefault 'Def_TIME', 'dbo.WatchTime.Time'
go
CREATE TABLE dbo.EventAge
(
    EventAgeID  int            IDENTITY,
    Caption     nvarchar(64)   NULL,
    LongCaption nvarchar(128)  NULL,
    ABREV       nvarchar(9)    NULL,
    AgeFrom     int            NULL,
    AgeTo       int            NULL,
    IsArchived  bit             NOT NULL,
    IsActive    bit             NOT NULL,
    CONSTRAINT PK_SwimmerCategory
    PRIMARY KEY CLUSTERED (EventAgeID)
)
go
EXEC sp_bindefault 'BIT_0', 'dbo.EventAge.IsArchived'
go
EXEC sp_bindefault 'BIT_1', 'dbo.EventAge.IsActive'
go
SET IDENTITY_INSERT [dbo].[EventAge] ON 
GO
INSERT [dbo].[EventAge] ([EventAgeID], [Caption], [LongCaption], [ABREV], [AgeFrom], [AgeTo], [IsArchived], [IsActive]) 
VALUES 

(1, N'Competitive 9 years+', N'Competitive Swimmer 9 years and over.',N'COMPET9+', 9, 99, 0,1)
,(2, N'Casual 9 years+', N'Casual or recreational Swimmer 9 years and over, who does not compete in Metropolitan ChampionShips ',N'CASUAL9+', 9, 99, 0,1)
,(3, N'Junior Dolphin 7 & under', N'Junior Dolphin 7 and under.',N'JrDOLP7U', 1, 7, 0,1)
,(4, N'Junior Dolphin 8 years', N'Junior Dolphin 8 year old.',N'JrDOLPH8Y', 8, 8, 0,1)
GO
SET IDENTITY_INSERT [dbo].[EventAge] OFF
GO
go
CREATE TABLE dbo.Lane
(
    LaneID           int       NOT NULL,
    LaneNum          int      NULL,
    RaceTime         time(7)  NULL,
    ClubRecord       time(7)  NULL,
    IsDisqualified   bit      NULL,
    IsScratched      bit      NULL,
    HeatID           int       NOT NULL,
    DisqualifyCodeID int      NULL,
    TeamID           int      NULL,
    NomineeID        int      NULL,
    CONSTRAINT PK_Lane
    PRIMARY KEY CLUSTERED (LaneID)
)
go
CREATE TABLE dbo.ScheduleEvent
(
    ScheduleEventID   int       IDENTITY,
    evRallyStart      datetime  NULL,
    evRallyEnd        datetime  NULL,
    evStart           datetime  NULL,
    evEnd             datetime  NULL,
    EventID           int       NULL,
    ScheduleSessionID int       NULL,
    CONSTRAINT PK_ScheduleEvent
    PRIMARY KEY CLUSTERED (ScheduleEventID)
)
go
CREATE TABLE dbo.ScheduleMeet
(
    ScheduleMeetID int            IDENTITY,
    Start          datetime       NULL,
    [End]          datetime       NULL,
    OverViewDOC    nvarchar(256)  NULL,
    OutLineDOC     nvarchar(256)  NULL,
    RacesDoc       nvarchar(256)  NULL,
    PublishedOn    datetime       NULL,
    ModifiedOn     datetime       NULL,
    CreatedOn      datetime       NULL,
    CONSTRAINT PK103
    PRIMARY KEY CLUSTERED (ScheduleMeetID)
)
go
CREATE TABLE dbo.ScheduleSession
(
    ScheduleSessionID int       IDENTITY,
    gateOpen          datetime  NULL,
    entryOpen         datetime  NULL,
    entryClose        datetime  NULL,
    warmupStart       datetime  NULL,
    warmupEnd         datetime  NULL,
    sessStart         datetime  NULL,
    int1Start         datetime  NULL,
    int1End           datetime  NULL,
    lunchStart        datetime  NULL,
    lunchEnd          datetime  NULL,
    int2Start         datetime  NULL,
    int2End           datetime  NULL,
    sessEnd           datetime  NULL,
    gateClose         datetime  NULL,
    SessionID         int       NULL,
    ScheduleMeetID    int       NULL,
    CONSTRAINT PK102
    PRIMARY KEY CLUSTERED (ScheduleSessionID)
)
go

-- Insert Data SQL

SET IDENTITY_INSERT dbo.Team ON
go
INSERT INTO dbo.Team(
                     TeamID,
                     Caption,
                     RaceTime,
                     TimeToBeat,
                     TeamNameID
                    )
              SELECT 
                     TeamID,
                     NULL,
                     RaceTime,
                     TimeToBeat,
                     TeamNameID
                FROM dbo.Team_07232025025942000 
go
SET IDENTITY_INSERT dbo.Team OFF
go
SET IDENTITY_INSERT dbo.Entrant ON
go
INSERT INTO dbo.Entrant(
                        EntrantID,
                        Lane,
                        RaceTime,
                        TimeToBeat,
                        PersonalBest,
                        IsDisqualified,
                        IsScratched,
                        DisqualifyCodeID,
                        HeatID,
                        MemberID,
                        SwimClubID
                       )
                 SELECT 
                        EntrantID,
                        Lane,
                        RaceTime,
                        TimeToBeat,
                        PersonalBest,
                        IsDisqualified,
                        IsScratched,
                        DisqualifyCodeID,
                        HeatID,
                        MemberID,
                        SwimClubID
                   FROM dbo.Entrant_07232025025943000 
go
SET IDENTITY_INSERT dbo.Entrant OFF
go
SET IDENTITY_INSERT dbo.Event ON
go
INSERT INTO dbo.Event(
                      EventID,
                      EventNum,
                      Caption,
                      ScheduleDT,
                      RallyOpenDT,
                      RallyCloseDT,
                      OpenDT,
                      CloseDT,
                      SessionID,
                      StrokeID,
                      DistanceID,
                      EventStatusID,
                      RoundID,
                      GenderID,
                      EventAgeID
                     )
               SELECT 
                      EventID,
                      EventNum,
                      Caption,
                      ScheduleDT,
                      RallyOpenDT,
                      RallyCloseDT,
                      OpenDT,
                      CloseDT,
                      SessionID,
                      StrokeID,
                      DistanceID,
                      EventStatusID,
                      RoundID,
                      GenderID,
                      NULL
                 FROM dbo.Event_07232025025944000 
go
SET IDENTITY_INSERT dbo.Event OFF
go
SET IDENTITY_INSERT dbo.Nominee ON
go
INSERT INTO dbo.Nominee(
                        NomineeID,
                        TTB,
                        PB,
                        IsEntrant,
                        SeedTime,
                        AutoBuildFlag,
                        EventID,
                        MemberID,
                        SwimClubID
                       )
                 SELECT 
                        NomineeID,
                        TTB,
                        PB,
                        0,
                        SeedTime,
                        AutoBuildFlag,
                        EventID,
                        MemberID,
                        SwimClubID
                   FROM dbo.Nominee_07232025025945000 
go
SET IDENTITY_INSERT dbo.Nominee OFF
go
SET IDENTITY_INSERT dbo.Round ON
go
INSERT INTO dbo.Round(
                      RoundID,
                      Caption,
                      CaptionShort,
                      ABREV
                     )
               SELECT 
                      RoundID,
                      Caption,
                      NULL,
                      ABREV
                 FROM dbo.Round_07232025025946000 
go
SET IDENTITY_INSERT dbo.Round OFF
go

-- Add Constraint SQL

ALTER TABLE dbo.Team ADD CONSTRAINT PK_Team
PRIMARY KEY NONCLUSTERED (TeamID)
go
ALTER TABLE dbo.Entrant ADD CONSTRAINT PK_Entrant
PRIMARY KEY NONCLUSTERED (EntrantID)
go
ALTER TABLE dbo.Event ADD CONSTRAINT PK_Event
PRIMARY KEY NONCLUSTERED (EventID)
go
ALTER TABLE dbo.Nominee ADD CONSTRAINT PK_Nominee
PRIMARY KEY CLUSTERED (NomineeID)
go
ALTER TABLE dbo.Round ADD CONSTRAINT PK_Round
PRIMARY KEY CLUSTERED (RoundID)
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.Nominee ADD CONSTRAINT EventNominee
FOREIGN KEY (EventID)
REFERENCES dbo.Event (EventID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.Heat ADD CONSTRAINT FK_EventHeat
FOREIGN KEY (EventID)
REFERENCES dbo.Event (EventID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.Event ADD CONSTRAINT FK_EventRound
FOREIGN KEY (RoundID)
REFERENCES dbo.Round (RoundID)
go
ALTER TABLE dbo.SplitTime 
    ADD CONSTRAINT FK_LaneSplit
FOREIGN KEY (LaneID)
REFERENCES dbo.Lane (LaneID)
go
ALTER TABLE dbo.TeamLink 
    ADD CONSTRAINT FK_TeamLink
FOREIGN KEY (TeamID)
REFERENCES dbo.Team (TeamID)
go
ALTER TABLE dbo.TeamLink 
    ADD FOREIGN KEY (NomineeID)
REFERENCES dbo.Nominee (NomineeID)
go
ALTER TABLE dbo.WatchTime 
    ADD CONSTRAINT FK_LaneWatchTime
FOREIGN KEY (LaneID)
REFERENCES dbo.Lane (LaneID)
go
ALTER TABLE dbo.Lane 
    ADD FOREIGN KEY (TeamID)
REFERENCES dbo.Team (TeamID)
go
ALTER TABLE dbo.Lane 
    ADD FOREIGN KEY (NomineeID)
REFERENCES dbo.Nominee (NomineeID)
go
ALTER TABLE dbo.Lane 
    ADD FOREIGN KEY (HeatID)
REFERENCES dbo.Heat (HeatID)
go
ALTER TABLE dbo.Lane 
    ADD CONSTRAINT FK_LaneDq
FOREIGN KEY (DisqualifyCodeID)
REFERENCES dbo.DisqualifyCode (DisqualifyCodeID)
go
ALTER TABLE dbo.ScheduleEvent 
    ADD CONSTRAINT FK_ScheduleEvent
FOREIGN KEY (EventID)
REFERENCES dbo.Event (EventID)
go
ALTER TABLE dbo.ScheduleEvent 
    ADD FOREIGN KEY (ScheduleSessionID)
REFERENCES dbo.ScheduleSession (ScheduleSessionID)
go
ALTER TABLE dbo.ScheduleSession 
    ADD FOREIGN KEY (SessionID)
REFERENCES dbo.[Session] (SessionID)
go
ALTER TABLE dbo.ScheduleSession 
    ADD FOREIGN KEY (ScheduleMeetID)
REFERENCES dbo.ScheduleMeet (ScheduleMeetID)
go
ALTER TABLE dbo.Team ADD CONSTRAINT TeamNameTeam
FOREIGN KEY (TeamNameID)
REFERENCES dbo.TeamName (TeamNameID)
go
ALTER TABLE dbo.Entrant ADD CONSTRAINT FK_MemberLinkEntrant
FOREIGN KEY (MemberID,SwimClubID)
REFERENCES dbo.MemberLink (MemberID,SwimClubID)
go
ALTER TABLE dbo.Entrant ADD CONSTRAINT HeatEntrant
FOREIGN KEY (HeatID)
REFERENCES dbo.Heat (HeatID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.Event ADD CONSTRAINT SessionEvent
FOREIGN KEY (SessionID)
REFERENCES dbo.[Session] (SessionID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.Event ADD CONSTRAINT FK_EventStroke
FOREIGN KEY (StrokeID)
REFERENCES dbo.Stroke (StrokeID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Event ADD CONSTRAINT FK_EventDistance
FOREIGN KEY (DistanceID)
REFERENCES dbo.Distance (DistanceID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Event ADD CONSTRAINT FK_EventStatus
FOREIGN KEY (EventStatusID)
REFERENCES dbo.EventStatus (EventStatusID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Event ADD CONSTRAINT GenderEvent
FOREIGN KEY (GenderID)
REFERENCES dbo.Gender (GenderID)
go
ALTER TABLE dbo.Event ADD CONSTRAINT FK_EventAge
FOREIGN KEY (EventAgeID)
REFERENCES dbo.EventAge (EventAgeID)
go
ALTER TABLE dbo.Nominee ADD CONSTRAINT FK_MemberLinkNominee
FOREIGN KEY (MemberID,SwimClubID)
REFERENCES dbo.MemberLink (MemberID,SwimClubID)
go
