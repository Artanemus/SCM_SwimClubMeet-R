USE [SwimClubMeet2]
go

-- Drop Referencing Constraint SQL

ALTER TABLE dbo.ScheduleSession DROP CONSTRAINT FK_ScheduleSession
go
ALTER TABLE dbo.Event DROP CONSTRAINT SessionEvent
go

-- Drop Constraint, Rename and Create Table SQL

EXEC sp_rename 'dbo.Session.PK_Session','PK_Session_09022025040129001','INDEX'
go
EXEC sp_rename 'dbo.SwimClubSession','SwimClubSe_09022025040129002'
go
EXEC sp_rename 'dbo.SessionStatusSession','SessionSta_09022025040129003'
go
EXEC sp_rename 'dbo.FK_Meet','FK_Meet_09022025040129004'
go
EXEC sp_rename 'dbo.Session','Session_09022025040129000',OBJECT
go
CREATE TABLE dbo.[Session]
(
    SessionID       int            IDENTITY,
    Caption         nvarchar(128)  NULL,
    SessionDate     date           NULL,
    StartTime       time(7)        NULL,
    SessionDT       datetime       NULL,
    CreatedOn       datetime       NULL,
    ModifiedOn      datetime       NULL,
    NomineeCount    int            NULL,
    EntrantCount    int            NULL,
    SwimClubID      int            NULL,
    SessionStatusID int            NULL,
    MeetID          int            NULL
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

-- Insert Data SQL

SET IDENTITY_INSERT dbo.[Session] ON
go
INSERT INTO dbo.[Session](
                          SessionID,
                          Caption,
                          SessionDate,
                          StartTime,
                          SessionDT,
                          CreatedOn,
                          ModifiedOn,
                          NomineeCount,
                          EntrantCount,
                          SwimClubID,
                          SessionStatusID,
                          MeetID
                         )
                   SELECT 
                          SessionID,
                          Caption,
                          NULL,
                          NULL,
                          SessionDT,
                          CreatedOn,
                          ModifiedOn,
                          NomineeCount,
                          EntrantCount,
                          SwimClubID,
                          SessionStatusID,
                          MeetID
                     FROM dbo.Session_09022025040129000 
go
SET IDENTITY_INSERT dbo.[Session] OFF
go

-- Add Constraint SQL

ALTER TABLE dbo.[Session] ADD CONSTRAINT PK_Session
PRIMARY KEY NONCLUSTERED (SessionID)
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.ScheduleSession ADD CONSTRAINT FK_ScheduleSession
FOREIGN KEY (SessionID)
REFERENCES dbo.[Session] (SessionID)
go
ALTER TABLE dbo.Event ADD CONSTRAINT SessionEvent
FOREIGN KEY (SessionID)
REFERENCES dbo.[Session] (SessionID)
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
ALTER TABLE dbo.[Session] ADD CONSTRAINT FK_Meet
FOREIGN KEY (MeetID)
REFERENCES dbo.Meet (MeetID)
go
