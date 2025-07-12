USE [SwimClubMeet]
go

-- Standard Alter Table SQL

ALTER TABLE dbo.Distance DROP CONSTRAINT EventTypeDistance
go
ALTER TABLE dbo.Distance DROP COLUMN EventTypeID
go
ALTER TABLE dbo.Gender ADD ABREV nvarchar(16)  NULL
go
ALTER TABLE dbo.Heat DROP CONSTRAINT HeatTypeHeatIndividual
go
ALTER TABLE dbo.Heat DROP CONSTRAINT HeatStatusHeatIndividual
go
ALTER TABLE dbo.Heat ADD CONSTRAINT HeatTypeHeat
FOREIGN KEY (HeatTypeID)
REFERENCES dbo.HeatType (HeatTypeID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Heat ADD CONSTRAINT HeatStatusHeat
FOREIGN KEY (HeatStatusID)
REFERENCES dbo.HeatStatus (HeatStatusID)
 ON DELETE SET NULL
go

-- Drop Referencing Constraint SQL

ALTER TABLE dbo.ScoreDivision DROP CONSTRAINT SwimClubScoreDivision
go
ALTER TABLE dbo.ScorePoints DROP CONSTRAINT SwimClubScorePoints
go
ALTER TABLE dbo.House DROP CONSTRAINT SwimClubHouse
go
ALTER TABLE dbo.Member DROP CONSTRAINT SwimClubMember
go
ALTER TABLE dbo.[Session] DROP CONSTRAINT SwimClubSession
go
ALTER TABLE dbo.SwimClubMetaDataLink DROP CONSTRAINT SwimClubSwimClubMetaDataLink
go
ALTER TABLE dbo.SwimmerCategory DROP CONSTRAINT SwimClubSwimmerCategory
go
ALTER TABLE dbo.Nominee DROP CONSTRAINT EventNominee
go
ALTER TABLE dbo.Heat DROP CONSTRAINT EventHeatIndividual
go
ALTER TABLE dbo.Event DROP CONSTRAINT SessionEvent
go

-- Drop Constraint, Rename and Create Table SQL

EXEC sp_rename 'dbo.SwimClub.PK_SwimClub','PK_SwimClu_07122025045323001','INDEX'
go
EXEC sp_rename 'dbo.SwimClubTypeSwimClub','SwimClubTy_07122025045323002'
go
EXEC sp_rename 'dbo.PoolTypeSwimClub','PoolTypeSw_07122025045323003'
go
EXEC sp_rename 'dbo.DF__SwimClub__LenOfP__44FF419A', 'DF__SwimCl_07122025045323004',OBJECT
go
EXEC sp_rename 'dbo.DF__SwimClub__NumOfL__440B1D61', 'DF__SwimCl_07122025045323005',OBJECT
go
EXEC sp_rename 'dbo.DF__SwimClub__Enable__4316F928', 'DF__SwimCl_07122025045323006',OBJECT
go
EXEC sp_rename 'dbo.DF__SwimClub__Enable__4222D4EF', 'DF__SwimCl_07122025045323007',OBJECT
go
EXEC sp_rename 'dbo.DF__SwimClub__Enable__412EB0B6', 'DF__SwimCl_07122025045323008',OBJECT
go
EXEC sp_rename 'dbo.DF__SwimClub__Enable__403A8C7D', 'DF__SwimCl_07122025045323009',OBJECT
go
EXEC sp_rename 'dbo.SwimClub','SwimClub_07122025045323000',OBJECT
go
CREATE TABLE dbo.SwimClub
(
    SwimClubID                   int            IDENTITY,
    NickName                     nvarchar(128)  NULL,
    Caption                      nvarchar(128)  NULL,
    Email                        nvarchar(128)  NULL,
    ContactNum                   nvarchar(30)   NULL,
    WebSite                      nvarchar(256)  NULL,
    HeatAlgorithm                int            NULL,
    EnableTeamEvents             bit            CONSTRAINT DF__SwimClub__Enable__403A8C7D DEFAULT ((0))  NOT NULL,
    EnableSwimOThon              bit            CONSTRAINT DF__SwimClub__Enable__412EB0B6 DEFAULT ((0))  NOT NULL,
    EnableExtHeatTypes           bit            CONSTRAINT DF__SwimClub__Enable__4222D4EF DEFAULT ((0))  NOT NULL,
    EnableMembershipStr          bit            CONSTRAINT DF__SwimClub__Enable__4316F928 DEFAULT ((0))  NOT NULL,
    EnableSimpleDisqualification bit             NOT NULL,
    NumOfLanes                   int            CONSTRAINT DF__SwimClub__NumOfL__440B1D61 DEFAULT ((8)) NULL,
    NumOfSwimmersInTEAMS         int            NULL,
    LenOfPool                    int            CONSTRAINT DF__SwimClub__LenOfP__44FF419A DEFAULT ((25)) NULL,
    StartOfSwimSeason            datetime       NULL,
    CreatedOn                    datetime       NULL,
    LogoDir                      varchar(max)   NULL,
    LogoImg                      image          NULL,
    LogoType                     nvarchar(5)    NULL,
    PoolTypeID                   int            NULL,
    SwimClubTypeID               int            NULL
)
ON [PRIMARY]
go
if exists (select * from ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'table', 'SwimClub', 'column', 'EnableMembershipStr'))
BEGIN
  exec sys.sp_dropextendedproperty 'MS_Description', 'schema', 'dbo', 'table', 'SwimClub', 'column', 'EnableMembershipStr'
END
exec sys.sp_addextendedproperty 'MS_Description', 'Allows for AlphaNumerical membership number. Once enabled Member.MembershipNum is ignored.', 'schema', 'dbo', 'table', 'SwimClub', 'column', 'EnableMembershipStr'
go
GRANT SELECT ON dbo.SwimClub TO SCM_Administrator
go
GRANT SELECT ON dbo.SwimClub TO SCM_Guest
go
GRANT SELECT ON dbo.SwimClub TO SCM_Marshall
go
EXEC sp_rename 'dbo.Event.PK_Event','PK_Event_07122025045324001','INDEX'
go
EXEC sp_rename 'dbo.StrokeEvent','StrokeEven_07122025045324003'
go
EXEC sp_rename 'dbo.DistanceEvent','DistanceEv_07122025045324004'
go
EXEC sp_rename 'dbo.EventStatusEvent','EventStatu_07122025045324005'
go
EXEC sp_rename 'dbo.Event','Event_07122025045324000',OBJECT
go
CREATE TABLE dbo.Event
(
    EventID       int            IDENTITY,
    EventNum      int            NULL,
    Caption       nvarchar(128)  NULL,
    SessionID     int            NULL,
    RallyOpenDT   datetime       NULL,
    StrokeID      int            NULL,
    RallyCloseDT  datetime       NULL,
    DistanceID    int            NULL,
    MinAge        int            NULL,
    OpenDT        datetime       NULL,
    MaxAge        int            NULL,
    EventStatusID int            NULL,
    CloseDT       datetime       NULL,
    ScheduleDT    time(7)        NULL,
    RoundID       int            NULL,
    GenderID      int            NULL,
    EventTypeID   int            NULL
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
EXEC sp_rename 'dbo.Session.PK_Session','PK_Session_07122025045325001','INDEX'
go
EXEC sp_rename 'dbo.SessionStatusSession','SessionSta_07122025045325002'
go
EXEC sp_rename 'dbo.Session','Session_07122025045325000',OBJECT
go
CREATE TABLE dbo.[Session]
(
    SessionID       int            IDENTITY,
    Caption         nvarchar(128)  NULL,
    SessionStart    datetime       NULL,
    SessionEnd      datetime       NULL,
    ClosedDT        datetime       NULL,
    SwimClubID      int            NULL,
    SessionStatusID int            NULL
)
ON [PRIMARY]
go
GRANT DELETE ON dbo.[Session] TO SCM_Administrator
go
GRANT INSERT ON dbo.[Session] TO SCM_Administrator
go
GRANT SELECT ON dbo.[Session] TO SCM_Administrator
go
GRANT UPDATE ON dbo.[Session] TO SCM_Administrator
go
GRANT SELECT ON dbo.[Session] TO SCM_Guest
go
GRANT SELECT ON dbo.[Session] TO SCM_Marshall
go
CREATE TABLE dbo.Round
(
    RoundID int            IDENTITY,
    Caption nvarchar(128)  NULL,
    ABREV   nvarchar(2)    NULL,
    CONSTRAINT PK_Round
    PRIMARY KEY CLUSTERED (RoundID)
)
go
SET IDENTITY_INSERT [dbo].[Round] ON 
GO
INSERT [dbo].[Round] ([RoundID], [Caption], [ABREV]) VALUES (1, N'All',  N'A')
GO
INSERT [dbo].[Round] ([RoundID], [Caption], [ABREV]) VALUES (2, N'Preliminary',  N'P')
GO
INSERT [dbo].[Round] ([RoundID], [Caption], [ABREV]) VALUES (3, N'Quarterfinals',  N'Q')
GO
INSERT [dbo].[Round] ([RoundID], [Caption], [ABREV]) VALUES (4, N'Semifinals',   N'S')
GO
INSERT [dbo].[Round] ([RoundID], [Caption], [ABREV]) VALUES (5, N'Finals',   N'F')
GO
SET IDENTITY_INSERT [dbo].[Round] OFF
GO
go

-- Insert Data SQL

SET IDENTITY_INSERT dbo.SwimClub ON
go
INSERT INTO dbo.SwimClub(
                         SwimClubID,
                         NickName,
                         Caption,
                         Email,
                         ContactNum,
                         WebSite,
                         HeatAlgorithm,
                         EnableTeamEvents,
                         EnableSwimOThon,
                         EnableExtHeatTypes,
                         EnableMembershipStr,
                         EnableSimpleDisqualification,
                         NumOfLanes,
                         NumOfSwimmersInTEAMS,
                         LenOfPool,
                         StartOfSwimSeason,
                         CreatedOn,
                         LogoDir,
                         LogoImg,
                         LogoType,
                         PoolTypeID,
                         SwimClubTypeID
                        )
                  SELECT 
                         SwimClubID,
                         NickName,
                         Caption,
                         Email,
                         ContactNum,
                         WebSite,
                         HeatAlgorithm,
                         EnableTeamEvents,
                         EnableSwimOThon,
                         EnableExtHeatTypes,
                         EnableMembershipStr,
                         EnableSimpleDisqualification,
                         NumOfLanes,
                         NULL,
                         LenOfPool,
                         StartOfSwimSeason,
                         CreatedOn,
                         LogoDir,
                         LogoImg,
                         LogoType,
                         PoolTypeID,
                         SwimClubTypeID
                    FROM dbo.SwimClub_07122025045323000 
go
SET IDENTITY_INSERT dbo.SwimClub OFF
go
SET IDENTITY_INSERT dbo.Event ON
go
INSERT INTO dbo.Event(
                      EventID,
                      EventNum,
                      Caption,
                      SessionID,
                      RallyOpenDT,
                      StrokeID,
                      RallyCloseDT,
                      DistanceID,
                      MinAge,
                      OpenDT,
                      MaxAge,
                      EventStatusID,
                      CloseDT,
                      ScheduleDT,
                      RoundID,
                      GenderID,
                      EventTypeID
                     )
               SELECT 
                      EventID,
                      EventNum,
                      Caption,
                      SessionID,
                      RallyOpenDT,
                      StrokeID,
                      RallyCloseDT,
                      DistanceID,
                      NULL,
                      OpenDT,
                      NULL,
                      EventStatusID,
                      CloseDT,
                      ScheduleDT,
                      NULL,
                      NULL,
                      NULL
                 FROM dbo.Event_07122025045324000 
go
SET IDENTITY_INSERT dbo.Event OFF
go
SET IDENTITY_INSERT dbo.[Session] ON
go
INSERT INTO dbo.[Session](
                          SessionID,
                          Caption,
                          SessionStart,
                          SessionEnd,
                          ClosedDT,
                          SwimClubID,
                          SessionStatusID
                         )
                   SELECT 
                          SessionID,
                          Caption,
                          SessionStart,
                          NULL,
                          ClosedDT,
                          SwimClubID,
                          SessionStatusID
                     FROM dbo.Session_07122025045325000 
go
SET IDENTITY_INSERT dbo.[Session] OFF
go

-- Add Constraint SQL

ALTER TABLE dbo.SwimClub ADD CONSTRAINT PK_SwimClub
PRIMARY KEY NONCLUSTERED (SwimClubID)
go
ALTER TABLE dbo.Event ADD CONSTRAINT PK_Event
PRIMARY KEY NONCLUSTERED (EventID)
go
ALTER TABLE dbo.[Session] ADD CONSTRAINT PK_Session
PRIMARY KEY NONCLUSTERED (SessionID)
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.ScoreDivision ADD CONSTRAINT SwimClubScoreDivision
FOREIGN KEY (SwimClubID)
REFERENCES dbo.SwimClub (SwimClubID)
go
ALTER TABLE dbo.ScorePoints ADD CONSTRAINT SwimClubScorePoints
FOREIGN KEY (SwimClubID)
REFERENCES dbo.SwimClub (SwimClubID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.House ADD CONSTRAINT SwimClubHouse
FOREIGN KEY (SwimClubID)
REFERENCES dbo.SwimClub (SwimClubID)
go
ALTER TABLE dbo.Member ADD CONSTRAINT SwimClubMember
FOREIGN KEY (SwimClubID)
REFERENCES dbo.SwimClub (SwimClubID)
go
ALTER TABLE dbo.[Session] ADD CONSTRAINT SwimClubSession
FOREIGN KEY (SwimClubID)
REFERENCES dbo.SwimClub (SwimClubID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.SwimClubMetaDataLink ADD CONSTRAINT SwimClubSwimClubMetaDataLink
FOREIGN KEY (SwimClubID)
REFERENCES dbo.SwimClub (SwimClubID)
go
ALTER TABLE dbo.SwimmerCategory ADD CONSTRAINT SwimClubSwimmerCategory
FOREIGN KEY (SwimClubID)
REFERENCES dbo.SwimClub (SwimClubID)
go
ALTER TABLE dbo.Nominee ADD CONSTRAINT EventNominee
FOREIGN KEY (EventID)
REFERENCES dbo.Event (EventID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.Heat ADD CONSTRAINT EventHeatIndividual
FOREIGN KEY (EventID)
REFERENCES dbo.Event (EventID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.Event ADD CONSTRAINT SessionEvent
FOREIGN KEY (SessionID)
REFERENCES dbo.[Session] (SessionID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.SwimClub ADD CONSTRAINT SwimClubTypeSwimClub
FOREIGN KEY (SwimClubTypeID)
REFERENCES dbo.SwimClubType (SwimClubTypeID)
go
ALTER TABLE dbo.SwimClub ADD CONSTRAINT PoolTypeSwimClub
FOREIGN KEY (PoolTypeID)
REFERENCES dbo.PoolType (PoolTypeID)
go
ALTER TABLE dbo.Event ADD CONSTRAINT StrokeEvent
FOREIGN KEY (StrokeID)
REFERENCES dbo.Stroke (StrokeID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Event ADD CONSTRAINT DistanceEvent
FOREIGN KEY (DistanceID)
REFERENCES dbo.Distance (DistanceID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Event ADD CONSTRAINT EventStatusEvent
FOREIGN KEY (EventStatusID)
REFERENCES dbo.EventStatus (EventStatusID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Event ADD CONSTRAINT RoundEvent
FOREIGN KEY (RoundID)
REFERENCES dbo.Round (RoundID)
go

ALTER TABLE dbo.Event ADD CONSTRAINT GenderEvent
FOREIGN KEY (GenderID)
REFERENCES dbo.Gender (GenderID)
go
ALTER TABLE dbo.Event ADD CONSTRAINT EventTypeEvent
FOREIGN KEY (EventTypeID)
REFERENCES dbo.EventType (EventTypeID)
go


ALTER TABLE dbo.[Session] ADD CONSTRAINT SessionStatusSession
FOREIGN KEY (SessionStatusID)
REFERENCES dbo.SessionStatus (SessionStatusID)
 ON DELETE SET NULL
go