USE [SwimClubMeet]
go

-- Standard Alter Table SQL

ALTER TABLE dbo.Event ADD ParalympicTypeID int  NULL
go
ALTER TABLE dbo.Member DROP CONSTRAINT FK_MemberParalympic
go
ALTER TABLE dbo.Member DROP COLUMN ParalympicID
go
ALTER TABLE dbo.ParaCode DROP CONSTRAINT FK_ParaTypeCode
go
EXEC sp_rename 'dbo.ParaCode.ParaTypeID', 'ParalympicTypeID','COLUMN'
go
ALTER TABLE dbo.Event ADD CONSTRAINT FK_ParalympicType
FOREIGN KEY (ParalympicTypeID)
REFERENCES dbo.ParalympicType (ParalympicTypeID)
go
ALTER TABLE dbo.ParaCode ADD CONSTRAINT FK_ParaCodeType
FOREIGN KEY (ParalympicTypeID)
REFERENCES dbo.ParalympicType (ParalympicTypeID)
go

-- Drop Referencing Constraint SQL

ALTER TABLE dbo.TeamLink DROP CONSTRAINT FK_TeamLink
go
ALTER TABLE dbo.Lane DROP CONSTRAINT FK_LaneTeam
go

-- Drop Constraint, Rename and Create Table SQL

ALTER TABLE dbo.ParaCodeLink DROP CONSTRAINT FK_ParalympicLink
go
ALTER TABLE dbo.Team DROP CONSTRAINT TeamNameTeam
go
EXEC sp_rename 'dbo.Entrant.PK_Entrant','PK_Entrant_07282025022548001','INDEX'
go
EXEC sp_rename 'dbo.DF__Entrant__IsScrat__182C9B23', 'DF__Entran_07282025022548002',OBJECT
go
EXEC sp_rename 'dbo.DF__Entrant__IsDisqu__173876EA', 'DF__Entran_07282025022548003',OBJECT
go
EXEC sp_rename 'dbo.Entrant','Entrant_07282025022548000',OBJECT
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
    MemberID         int      NULL,
    SwimClubID       int      NULL
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
DROP TABLE dbo.ParaCodeLink
go
DROP TABLE dbo.Paralympic
go
EXEC sp_rename 'dbo.Team.PK_Team','PK_Team_07282025022549001','INDEX'
go
EXEC sp_rename 'dbo.Team','Team_07282025022549000',OBJECT
go
CREATE TABLE dbo.Team
(
    TeamID     int            IDENTITY,
    Caption    nvarchar(128)  NULL,
    TeamName   nvarchar(16)   NULL,
    ABBREV     nvarchar(16)   NULL,
    RaceTime   time(7)        NULL,
    TimeToBeat time(7)        NULL
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
DROP TABLE dbo.TeamName
go
CREATE TABLE dbo.MemberParaCodeLink
(
    ParaCodeID int   NOT NULL,
    MemberID   int   NOT NULL,
    CONSTRAINT PK_ParaCodeLink
    PRIMARY KEY CLUSTERED (ParaCodeID,MemberID)
)
go

-- Insert Data SQL

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
                   FROM dbo.Entrant_07282025022548000 
go
SET IDENTITY_INSERT dbo.Entrant OFF
go
SET IDENTITY_INSERT dbo.Team ON
go
INSERT INTO dbo.Team(
                     TeamID,
                     Caption,
                     TeamName,
                     ABBREV,
                     RaceTime,
                     TimeToBeat
                    )
              SELECT 
                     TeamID,
                     Caption,
                     NULL,
                     NULL,
                     RaceTime,
                     TimeToBeat
                FROM dbo.Team_07282025022549000 
go
SET IDENTITY_INSERT dbo.Team OFF
go

-- Add Constraint SQL

ALTER TABLE dbo.Entrant ADD CONSTRAINT PK_Entrant
PRIMARY KEY NONCLUSTERED (EntrantID)
go
ALTER TABLE dbo.Team ADD CONSTRAINT PK_Team
PRIMARY KEY NONCLUSTERED (TeamID)
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.TeamLink ADD CONSTRAINT FK_TeamLink
FOREIGN KEY (TeamID)
REFERENCES dbo.Team (TeamID)
go
ALTER TABLE dbo.Lane ADD CONSTRAINT FK_LaneTeam
FOREIGN KEY (TeamID)
REFERENCES dbo.Team (TeamID)
go
ALTER TABLE dbo.MemberParaCodeLink 
    ADD CONSTRAINT FK_ParaCode
FOREIGN KEY (ParaCodeID)
REFERENCES dbo.ParaCode (ParaCodeID)
go
ALTER TABLE dbo.MemberParaCodeLink 
    ADD CONSTRAINT FK_ParaCodeLink
FOREIGN KEY (MemberID)
REFERENCES dbo.Member (MemberID)
go
