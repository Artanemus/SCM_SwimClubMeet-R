USE [SwimClubMeet2]
go

-- Drop Referencing Constraint SQL

ALTER TABLE dbo.ScheduleSession DROP CONSTRAINT FK_SessionSchedule
go
ALTER TABLE dbo.Event DROP CONSTRAINT SessionEvent
go
ALTER TABLE dbo.Nominee DROP CONSTRAINT EventNominee
go
ALTER TABLE dbo.ScheduleEvent DROP CONSTRAINT FK_ScheduleEvent
go
ALTER TABLE dbo.Heat DROP CONSTRAINT FK_EventHeat
go

-- Drop Constraint, Rename and Create Table SQL

EXEC sp_rename 'dbo.Session.PK_Session','PK_Session_08042025031052001','INDEX'
go
EXEC sp_rename 'dbo.SwimClubSession','SwimClubSe_08042025031052002'
go
EXEC sp_rename 'dbo.SessionStatusSession','SessionSta_08042025031052003'
go
EXEC sp_rename 'dbo.Session','Session_08042025031052000',OBJECT
go
CREATE TABLE dbo.[Session]
(
    SessionID       int            IDENTITY,
    Caption         nvarchar(128)  NULL,
    SessionStart    datetime       NULL,
    SessionEnd      datetime       NULL,
    ClosedDT        datetime       NULL,
    NomineeCount    int            NULL,
    EntrantCount    int            NULL,
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
EXEC sp_rename 'dbo.Event.PK_Event','PK_Event_08042025031053001','INDEX'
go
EXEC sp_rename 'dbo.FK_EventStroke','FK_EventSt_08042025031053003'
go
EXEC sp_rename 'dbo.FK_EventDistance','FK_EventDi_08042025031053004'
go
EXEC sp_rename 'dbo.FK_EventAge','FK_EventAg_08042025031053005'
go
EXEC sp_rename 'dbo.FK_EventStatus','FK_EventSt_08042025031053006'
go
EXEC sp_rename 'dbo.GenderEvent','GenderEven_08042025031053007'
go
EXEC sp_rename 'dbo.FK_ParalympicType','FK_Paralym_08042025031053008'
go
EXEC sp_rename 'dbo.FK_EventRound','FK_EventRo_08042025031053009'
go
EXEC sp_rename 'dbo.Event','Event_08042025031053000',OBJECT
go
CREATE TABLE dbo.Event
(
    EventID          int            IDENTITY,
    EventNum         int            NULL,
    Caption          nvarchar(128)  NULL,
    ScheduleDT       time(7)        NULL,
    RallyOpenDT      datetime       NULL,
    RallyCloseDT     datetime       NULL,
    OpenDT           datetime       NULL,
    CloseDT          datetime       NULL,
    NomineeCount     int            NULL,
    EntrantCount     int            NULL,
    SessionID        int            NULL,
    StrokeID         int            NULL,
    DistanceID       int            NULL,
    EventStatusID    int            NULL,
    RoundID          int            NULL,
    GenderID         int            NULL,
    EventCategoryID  int            NULL,
    ParalympicTypeID int            NULL
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

-- Insert Data SQL

SET IDENTITY_INSERT dbo.[Session] ON
go
INSERT INTO dbo.[Session](
                          SessionID,
                          Caption,
                          SessionStart,
                          SessionEnd,
                          ClosedDT,
                          NomineeCount,
                          EntrantCount,
                          SwimClubID,
                          SessionStatusID
                         )
                   SELECT 
                          SessionID,
                          Caption,
                          SessionStart,
                          SessionEnd,
                          ClosedDT,
                          NULL,
                          NULL,
                          SwimClubID,
                          SessionStatusID
                     FROM dbo.Session_08042025031052000 
go
SET IDENTITY_INSERT dbo.[Session] OFF
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
                      NomineeCount,
                      EntrantCount,
                      SessionID,
                      StrokeID,
                      DistanceID,
                      EventStatusID,
                      RoundID,
                      GenderID,
                      EventCategoryID,
                      ParalympicTypeID
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
                      NULL,
                      NULL,
                      SessionID,
                      StrokeID,
                      DistanceID,
                      EventStatusID,
                      RoundID,
                      GenderID,
                      EventCategoryID,
                      ParalympicTypeID
                 FROM dbo.Event_08042025031053000 
go
SET IDENTITY_INSERT dbo.Event OFF
go

-- Add Constraint SQL

ALTER TABLE dbo.[Session] ADD CONSTRAINT PK_Session
PRIMARY KEY NONCLUSTERED (SessionID)
go
ALTER TABLE dbo.Event ADD CONSTRAINT PK_Event
PRIMARY KEY NONCLUSTERED (EventID)
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.ScheduleSession ADD CONSTRAINT FK_SessionSchedule
FOREIGN KEY (SessionID)
REFERENCES dbo.[Session] (SessionID)
go
ALTER TABLE dbo.Event ADD CONSTRAINT SessionEvent
FOREIGN KEY (SessionID)
REFERENCES dbo.[Session] (SessionID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.Nominee ADD CONSTRAINT EventNominee
FOREIGN KEY (EventID)
REFERENCES dbo.Event (EventID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.ScheduleEvent ADD CONSTRAINT FK_ScheduleEvent
FOREIGN KEY (EventID)
REFERENCES dbo.Event (EventID)
go
ALTER TABLE dbo.Heat ADD CONSTRAINT FK_EventHeat
FOREIGN KEY (EventID)
REFERENCES dbo.Event (EventID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.[Session] ADD CONSTRAINT SwimClubSession
FOREIGN KEY (SwimClubID)
REFERENCES dbo.SwimClub (SwimClubID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.[Session] ADD CONSTRAINT SessionStatusSession
FOREIGN KEY (SessionStatusID)
REFERENCES dbo.SessionStatus (SessionStatusID)
 ON DELETE SET NULL
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
ALTER TABLE dbo.Event ADD CONSTRAINT FK_EventAge
FOREIGN KEY (EventCategoryID)
REFERENCES dbo.EventCategory (EventCategoryID)
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
ALTER TABLE dbo.Event ADD CONSTRAINT FK_ParalympicType
FOREIGN KEY (ParalympicTypeID)
REFERENCES dbo.ParalympicType (ParalympicTypeID)
go
ALTER TABLE dbo.Event ADD CONSTRAINT FK_EventRound
FOREIGN KEY (RoundID)
REFERENCES dbo.Round (RoundID)
go
