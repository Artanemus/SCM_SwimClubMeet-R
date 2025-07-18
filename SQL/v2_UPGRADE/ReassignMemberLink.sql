USE [SwimClubMeet]
go

-- Standard Alter Table SQL

EXEC sp_rename 'dbo.FK__Nominee__6DB73E6A','FK_MemberLinkNominee'
go

-- Drop Constraint, Rename and Create Table SQL

EXEC sp_rename 'dbo.TeamEntrant.PK_TeamEntrant','PK_TeamEnt_07182025012741001','INDEX'
go
EXEC sp_rename 'dbo.StrokeTeamEntrant','StrokeTeam_07182025012741002'
go
EXEC sp_rename 'dbo.DisqualifyCodeTeamEntrant','Disqualify_07182025012741003'
go
EXEC sp_rename 'dbo.FK_TeamEntrant_MemberLink','FK_TeamEnt_07182025012741004'
go
EXEC sp_rename 'dbo.TeamTeamEntrant','TeamTeamEn_07182025012741005'
go
EXEC sp_rename 'dbo.TeamEntrant','TeamEntran_07182025012741000',OBJECT
go
CREATE TABLE dbo.TeamEntrant
(
    TeamEntrantID    int      IDENTITY,
    MemberID         int       NOT NULL,
    Lane             int      NULL,
    RaceTime         time(7)  NULL,
    TimeToBeat       time(7)  NULL,
    PersonalBest     time(7)  NULL,
    IsDisqualified   bit       NOT NULL,
    IsScratched      bit       NOT NULL,
    DisqualifyCodeID int      NULL,
    StrokeID         int      NULL,
    TeamID           int      NULL,
    SwimClubID       int       NOT NULL
)
ON [PRIMARY]
go
GRANT DELETE ON dbo.TeamEntrant TO SCM_Administrator
go
GRANT INSERT ON dbo.TeamEntrant TO SCM_Administrator
go
GRANT SELECT ON dbo.TeamEntrant TO SCM_Administrator
go
GRANT UPDATE ON dbo.TeamEntrant TO SCM_Administrator
go
GRANT SELECT ON dbo.TeamEntrant TO SCM_Guest
go
GRANT DELETE ON dbo.TeamEntrant TO SCM_Marshall
go
GRANT INSERT ON dbo.TeamEntrant TO SCM_Marshall
go
GRANT SELECT ON dbo.TeamEntrant TO SCM_Marshall
go
GRANT UPDATE ON dbo.TeamEntrant TO SCM_Marshall
go
EXEC sp_rename 'dbo.Entrant.PK_Entrant','PK_Entrant_07182025012742001','INDEX'
go
EXEC sp_rename 'dbo.FK_Entrant_MemberLink','FK_Entrant_07182025012742002'
go
EXEC sp_rename 'dbo.HeatEntrant','HeatEntran_07182025012742003'
go
EXEC sp_rename 'dbo.DisqualifyCodeEntrant','Disqualify_07182025012742004'
go
EXEC sp_rename 'dbo.DF__Entrant__IsScrat__182C9B23', 'DF__Entran_07182025012742005',OBJECT
go
EXEC sp_rename 'dbo.DF__Entrant__IsDisqu__173876EA', 'DF__Entran_07182025012742006',OBJECT
go
EXEC sp_rename 'dbo.Entrant','Entrant_07182025012742000',OBJECT
go
CREATE TABLE dbo.Entrant
(
    EntrantID        int      IDENTITY,
    MemberID         int       NOT NULL,
    Lane             int      NULL,
    RaceTime         time(7)  NULL,
    TimeToBeat       time(7)  NULL,
    PersonalBest     time(7)  NULL,
    IsDisqualified   bit      CONSTRAINT DF__Entrant__IsDisqu__173876EA DEFAULT ((0))  NOT NULL,
    IsScratched      bit      CONSTRAINT DF__Entrant__IsScrat__182C9B23 DEFAULT ((0))  NOT NULL,
    DisqualifyCodeID int      NULL,
    HeatID           int      NULL,
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

-- Insert Data SQL

SET IDENTITY_INSERT dbo.TeamEntrant ON
go
INSERT INTO dbo.TeamEntrant(
                            TeamEntrantID,
                            MemberID,
                            Lane,
                            RaceTime,
                            TimeToBeat,
                            PersonalBest,
                            IsDisqualified,
                            IsScratched,
                            DisqualifyCodeID,
                            StrokeID,
                            TeamID,
                            SwimClubID
                           )
                     SELECT 
                            TeamEntrantID,
                            MemberID,
                            Lane,
                            RaceTime,
                            TimeToBeat,
                            PersonalBest,
                            IsDisqualified,
                            IsScratched,
                            DisqualifyCodeID,
                            StrokeID,
                            TeamID,
                            SwimClubID
                       FROM dbo.TeamEntran_07182025012741000 
go
SET IDENTITY_INSERT dbo.TeamEntrant OFF
go
SET IDENTITY_INSERT dbo.Entrant ON
go
INSERT INTO dbo.Entrant(
                        EntrantID,
                        MemberID,
                        Lane,
                        RaceTime,
                        TimeToBeat,
                        PersonalBest,
                        IsDisqualified,
                        IsScratched,
                        DisqualifyCodeID,
                        HeatID,
                        SwimClubID
                       )
                 SELECT 
                        EntrantID,
                        MemberID,
                        Lane,
                        RaceTime,
                        TimeToBeat,
                        PersonalBest,
                        IsDisqualified,
                        IsScratched,
                        DisqualifyCodeID,
                        HeatID,
                        SwimClubID
                   FROM dbo.Entrant_07182025012742000 
go
SET IDENTITY_INSERT dbo.Entrant OFF
go

-- Add Constraint SQL

ALTER TABLE dbo.TeamEntrant ADD CONSTRAINT PK_TeamEntrant
PRIMARY KEY NONCLUSTERED (TeamEntrantID)
go
ALTER TABLE dbo.Entrant ADD CONSTRAINT PK_Entrant
PRIMARY KEY NONCLUSTERED (EntrantID)
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.TeamEntrant ADD CONSTRAINT StrokeTeamEntrant
FOREIGN KEY (StrokeID)
REFERENCES dbo.Stroke (StrokeID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.TeamEntrant ADD CONSTRAINT DisqualifyCodeTeamEntrant
FOREIGN KEY (DisqualifyCodeID)
REFERENCES dbo.DisqualifyCode (DisqualifyCodeID)
go
ALTER TABLE dbo.TeamEntrant ADD CONSTRAINT FK_MemberLinkTeamEntrant
FOREIGN KEY (MemberID,SwimClubID)
REFERENCES dbo.MemberLink (MemberID,SwimClubID)
go
ALTER TABLE dbo.TeamEntrant ADD CONSTRAINT TeamTeamEntrant
FOREIGN KEY (TeamID)
REFERENCES dbo.Team (TeamID)
 ON DELETE CASCADE
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
ALTER TABLE dbo.Entrant ADD CONSTRAINT DisqualifyCodeEntrant
FOREIGN KEY (DisqualifyCodeID)
REFERENCES dbo.DisqualifyCode (DisqualifyCodeID)
go
