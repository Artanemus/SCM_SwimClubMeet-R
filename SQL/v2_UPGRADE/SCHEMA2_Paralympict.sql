USE [SwimClubMeet]
go

-- Drop Constraint, Rename and Create Table SQL

CREATE TABLE dbo.Entrant
(
    EntrantID        int      IDENTITY,
    Lane             int      NULL,
    RaceTime         time(7)  NULL,
    TimeToBeat       time(7)  NULL,
    PersonalBest     time(7)  NULL,
    IsDisqualified   bit       NOT NULL,
    IsScratched      bit       NOT NULL,
    DisqualifyCodeID int      NULL,
    HeatID           int       NOT NULL,
    MemberID         int       NOT NULL,
    SwimClubID       int       NOT NULL,
    CONSTRAINT PK_Entrant
    PRIMARY KEY NONCLUSTERED (EntrantID)
)
ON [PRIMARY]
go
