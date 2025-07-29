USE [SwimClubMeet]
go

-- Standard Alter Table SQL

ALTER TABLE dbo.Entrant
ALTER COLUMN HeatID int NULL
go
ALTER TABLE dbo.Entrant
ALTER COLUMN MemberID int NULL
go
ALTER TABLE dbo.Entrant
ALTER COLUMN SwimClubID int NULL
go

-- Drop Referencing Constraint SQL

ALTER TABLE dbo.SplitTime DROP CONSTRAINT FK_LaneSplit
go
ALTER TABLE dbo.WatchTime DROP CONSTRAINT FK_LaneWatchTime
go

-- Drop Constraint, Rename and Create Table SQL

EXEC sp_rename 'dbo.Lane.PK_Lane','PK_Lane_07292025020116001','INDEX'
go
EXEC sp_rename 'dbo.FK_LaneNominee','FK_LaneNom_07292025020116002'
go
EXEC sp_rename 'dbo.FK_LaneHeat','FK_LaneHea_07292025020116003'
go
EXEC sp_rename 'dbo.FK_LaneDq','FK_LaneDq_07292025020116004'
go
EXEC sp_rename 'dbo.FK_LaneTeam','FK_LaneTea_07292025020116005'
go
EXEC sp_rename 'dbo.Lane','Lane_07292025020116000',OBJECT
go
CREATE TABLE dbo.Lane
(
    LaneID           int      IDENTITY,
    LaneNum          int      NULL,
    RaceTime         time(7)  NULL,
    ClubRecord       time(7)  NULL,
    IsDisqualified   bit      NULL,
    IsScratched      bit      NULL,
    HeatID           int      NULL,
    DisqualifyCodeID int      NULL,
    TeamID           int      NULL,
    NomineeID        int      NULL
)
ON [PRIMARY]
go

-- Insert Data SQL

SET IDENTITY_INSERT dbo.Lane ON
go
INSERT INTO dbo.Lane(
                     LaneID,
                     LaneNum,
                     RaceTime,
                     ClubRecord,
                     IsDisqualified,
                     IsScratched,
                     HeatID,
                     DisqualifyCodeID,
                     TeamID,
                     NomineeID
                    )
              SELECT 
                     LaneID,
                     LaneNum,
                     RaceTime,
                     ClubRecord,
                     IsDisqualified,
                     IsScratched,
                     HeatID,
                     DisqualifyCodeID,
                     TeamID,
                     NomineeID
                FROM dbo.Lane_07292025020116000 
go
SET IDENTITY_INSERT dbo.Lane OFF
go

-- Add Constraint SQL

ALTER TABLE dbo.Lane ADD CONSTRAINT PK_Lane
PRIMARY KEY CLUSTERED (LaneID)
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.SplitTime ADD CONSTRAINT FK_LaneSplit
FOREIGN KEY (LaneID)
REFERENCES dbo.Lane (LaneID)
go
ALTER TABLE dbo.WatchTime ADD CONSTRAINT FK_LaneWatchTime
FOREIGN KEY (LaneID)
REFERENCES dbo.Lane (LaneID)
go
ALTER TABLE dbo.Lane ADD CONSTRAINT FK_LaneNominee
FOREIGN KEY (NomineeID)
REFERENCES dbo.Nominee (NomineeID)
go
ALTER TABLE dbo.Lane ADD CONSTRAINT FK_LaneHeat
FOREIGN KEY (HeatID)
REFERENCES dbo.Heat (HeatID)
go
ALTER TABLE dbo.Lane ADD CONSTRAINT FK_LaneDq
FOREIGN KEY (DisqualifyCodeID)
REFERENCES dbo.DisqualifyCode (DisqualifyCodeID)
go
ALTER TABLE dbo.Lane ADD CONSTRAINT FK_LaneTeam
FOREIGN KEY (TeamID)
REFERENCES dbo.Team (TeamID)
go
