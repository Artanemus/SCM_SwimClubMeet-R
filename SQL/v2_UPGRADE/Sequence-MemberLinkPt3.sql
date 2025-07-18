USE [SwimClubMeet]
go

-- Standard Alter Table SQL

ALTER TABLE dbo.House DROP CONSTRAINT SwimClubHouse
go
ALTER TABLE dbo.House DROP COLUMN SwimClubID
go
ALTER TABLE dbo.MemberLink DROP CONSTRAINT FK_MemberLinkSwimClub
go
ALTER TABLE dbo.MemberLink DROP CONSTRAINT FK_HouseMemberLink
go
ALTER TABLE dbo.MemberLink ADD CONSTRAINT MemberLinkSwimClub
FOREIGN KEY (SwimClubID)
REFERENCES dbo.SwimClub (SwimClubID)
go
ALTER TABLE dbo.MemberLink ADD CONSTRAINT HouseMemberLink
FOREIGN KEY (HouseID)
REFERENCES dbo.House (HouseID)
go

-- Drop Referencing Constraint SQL

ALTER TABLE dbo.Split DROP CONSTRAINT EntrantSplit
go
ALTER TABLE dbo.Nominee DROP CONSTRAINT EventNominee
go
ALTER TABLE dbo.Heat DROP CONSTRAINT EventHeat
go
ALTER TABLE dbo.Entrant DROP CONSTRAINT HeatEntrant
go
ALTER TABLE dbo.Team DROP CONSTRAINT HeatTeam
go
ALTER TABLE dbo.Entrant DROP CONSTRAINT MemberEntrant
go
ALTER TABLE dbo.MemberLink DROP CONSTRAINT FK_MemberLink
go
ALTER TABLE dbo.Nominee DROP CONSTRAINT MemberNominee
go
ALTER TABLE dbo.TeamEntrant DROP CONSTRAINT MemberTeamEntrant
go
ALTER TABLE dbo.ContactNum DROP CONSTRAINT MemberContactNum
go
ALTER TABLE dbo.MemberRoleLink DROP CONSTRAINT MemberMemberRoleLink
go

-- Drop Constraint, Rename and Create Table SQL

ALTER TABLE dbo.SwimClubMetaDataLink DROP CONSTRAINT MetaDataSwimClubMetaDataLink
go
EXEC sp_rename 'dbo.ContactNum.PK_ContactNum','PK_Contact_07182025004015001','INDEX'
go
EXEC sp_rename 'dbo.ContactNumTypeContactNum','ContactNum_07182025004015002'
go
EXEC sp_rename 'dbo.ContactNum','ContactNum_07182025004015000',OBJECT
go
CREATE TABLE dbo.ContactNum
(
    ContactNumID     int           IDENTITY,
    Number           nvarchar(30)  NULL,
    IsArchived       bit            NOT NULL,
    CreatedOn        datetime      NULL,
    MemberID         int           NULL,
    ContactNumTypeID int           NULL
)
ON [PRIMARY]
go
GRANT DELETE ON dbo.ContactNum TO SCM_Administrator
go
GRANT INSERT ON dbo.ContactNum TO SCM_Administrator
go
GRANT SELECT ON dbo.ContactNum TO SCM_Administrator
go
GRANT UPDATE ON dbo.ContactNum TO SCM_Administrator
go
GRANT SELECT ON dbo.ContactNum TO SCM_Guest
go
GRANT SELECT ON dbo.ContactNum TO SCM_Marshall
go
EXEC sp_rename 'dbo.Entrant.PK_Entrant','PK_Entrant_07182025004016001','INDEX'
go
EXEC sp_rename 'dbo.DisqualifyCodeEntrant','Disqualify_07182025004016002'
go
EXEC sp_rename 'dbo.DF__Entrant__IsScrat__182C9B23', 'DF__Entran_07182025004016005',OBJECT
go
EXEC sp_rename 'dbo.DF__Entrant__IsDisqu__173876EA', 'DF__Entran_07182025004016006',OBJECT
go
EXEC sp_rename 'dbo.Entrant','Entrant_07182025004016000',OBJECT
go
CREATE TABLE dbo.Entrant
(
    EntrantID        int      IDENTITY,
    MemberID         int      NULL,
    Lane             int      NULL,
    RaceTime         time(7)  NULL,
    TimeToBeat       time(7)  NULL,
    PersonalBest     time(7)  NULL,
    IsDisqualified   bit      CONSTRAINT DF__Entrant__IsDisqu__173876EA DEFAULT ((0))  NOT NULL,
    IsScratched      bit      CONSTRAINT DF__Entrant__IsScrat__182C9B23 DEFAULT ((0))  NOT NULL,
    DisqualifyCodeID int      NULL,
    HeatID           int      NULL
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
EXEC sp_rename 'dbo.Event.PK_Event','PK_Event_07182025004017001','INDEX'
go
EXEC sp_rename 'dbo.SessionEvent','SessionEve_07182025004017002'
go
EXEC sp_rename 'dbo.StrokeEvent','StrokeEven_07182025004017003'
go
EXEC sp_rename 'dbo.DistanceEvent','DistanceEv_07182025004017004'
go
EXEC sp_rename 'dbo.EventStatusEvent','EventStatu_07182025004017005'
go
EXEC sp_rename 'dbo.RoundEvent','RoundEvent_07182025004017006'
go
EXEC sp_rename 'dbo.GenderEvent','GenderEven_07182025004017007'
go
EXEC sp_rename 'dbo.Event','Event_07182025004017000',OBJECT
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
    MinAge        int            NULL,
    MaxAge        int            NULL,
    SessionID     int            NULL,
    StrokeID      int            NULL,
    DistanceID    int            NULL,
    EventStatusID int            NULL,
    RoundID       int            NULL,
    GenderID      int            NULL
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
EXEC sp_rename 'dbo.Heat.PK_HeatIndividual','PK_HeatInd_07182025004018001','INDEX'
go
EXEC sp_rename 'dbo.HeatTypeHeat','HeatTypeHe_07182025004018002'
go
EXEC sp_rename 'dbo.HeatStatusHeat','HeatStatus_07182025004018003'
go
EXEC sp_rename 'dbo.Heat','Heat_07182025004018000',OBJECT
go
CREATE TABLE dbo.Heat
(
    HeatID       int            IDENTITY,
    HeatNum      int            NULL,
    Caption      nvarchar(128)  NULL,
    ScheduleDT   time(7)        NULL,
    RallyOpenDT  datetime       NULL,
    RallyCloseDT datetime       NULL,
    OpenDT       datetime       NULL,
    CloseDT      datetime       NULL,
    EventID      int            NULL,
    HeatTypeID   int            NULL,
    HeatStatusID int            NULL
)
ON [PRIMARY]
go
GRANT DELETE ON dbo.Heat TO SCM_Administrator
go
GRANT INSERT ON dbo.Heat TO SCM_Administrator
go
GRANT SELECT ON dbo.Heat TO SCM_Administrator
go
GRANT UPDATE ON dbo.Heat TO SCM_Administrator
go
GRANT SELECT ON dbo.Heat TO SCM_Guest
go
GRANT DELETE ON dbo.Heat TO SCM_Marshall
go
GRANT INSERT ON dbo.Heat TO SCM_Marshall
go
GRANT SELECT ON dbo.Heat TO SCM_Marshall
go
GRANT UPDATE ON dbo.Heat TO SCM_Marshall
go
EXEC sp_rename 'dbo.Member.PK_Member','PK_Member_07182025004019001','INDEX'
go
EXEC sp_rename 'dbo.GenderMember','GenderMemb_07182025004019002'
go
EXEC sp_rename 'dbo.SwimClubMember','SwimClubMe_07182025004019003'
go
EXEC sp_rename 'dbo.HouseMember','HouseMembe_07182025004019004'
go
EXEC sp_rename 'dbo.DF_Member_EnableEmailSessionReport', 'DF_Member__07182025004019005',OBJECT
go
EXEC sp_rename 'dbo.DF_Member_EnableEmailNomineeForm', 'DF_Member__07182025004019006',OBJECT
go
EXEC sp_rename 'dbo.DF__Member__EnableEm__2B3F6F97', 'DF__Member_07182025004019007',OBJECT
go
EXEC sp_rename 'dbo.DF_Member_IsSwimmer', 'DF_Member__07182025004019008',OBJECT
go
EXEC sp_rename 'dbo.DF__Member__IsActive__2A4B4B5E', 'DF__Member_07182025004019009',OBJECT
go
EXEC sp_rename 'dbo.DF_Member_IsArchived', 'DF_Member__07182025004019010',OBJECT
go
EXEC sp_rename 'dbo.Member','Member_07182025004019000',OBJECT
go
CREATE TABLE dbo.Member
(
    MemberID                 int            IDENTITY,
    MembershipNum            int            NULL,
    MembershipStr            nvarchar(24)   NULL,
    FirstName                nvarchar(128)  NULL,
    MiddleInitial            nvarchar(4)    NULL,
    LastName                 nvarchar(128)  NULL,
    RegisterNum              int            NULL,
    RegisterStr              nvarchar(24)   NULL,
    DOB                      datetime       NULL,
    IsArchived               bit            CONSTRAINT DF_Member_IsArchived DEFAULT ((0))  NOT NULL,
    IsActive                 bit            CONSTRAINT DF__Member__IsActive__2A4B4B5E DEFAULT ((1))  NOT NULL,
    IsSwimmer                bit            CONSTRAINT DF_Member_IsSwimmer DEFAULT ((1))  NOT NULL,
    Email                    nvarchar(256)  NULL,
    CreatedOn                datetime       NULL,
    ArchivedOn               datetime       NULL,
    EnableEmailOut           bit            CONSTRAINT DF__Member__EnableEm__2B3F6F97 DEFAULT ((0))  NOT NULL,
    EnableEmailNomineeForm   bit            CONSTRAINT DF_Member_EnableEmailNomineeForm DEFAULT ((0))  NOT NULL,
    EnableEmailSessionReport bit            CONSTRAINT DF_Member_EnableEmailSessionReport DEFAULT ((0))  NOT NULL,
    TAGS                     ntext          NULL,
    GenderID                 int            NULL
)
ON [PRIMARY]
go
GRANT DELETE ON dbo.Member TO SCM_Administrator
go
GRANT INSERT ON dbo.Member TO SCM_Administrator
go
GRANT SELECT ON dbo.Member TO SCM_Administrator
go
GRANT UPDATE ON dbo.Member TO SCM_Administrator
go
GRANT SELECT ON dbo.Member TO SCM_Guest
go
GRANT SELECT ON dbo.Member TO SCM_Marshall
go
DROP TABLE dbo.MetaData
go
EXEC sp_rename 'dbo.Qualify.PK_Qualify','PK_Qualify_07182025004020001','INDEX'
go
EXEC sp_rename 'dbo.DistanceQualifyTrialDist','DistanceQu_07182025004020002'
go
EXEC sp_rename 'dbo.StrokeQualify','StrokeQual_07182025004020003'
go
EXEC sp_rename 'dbo.DistanceQualifyDist','DistanceQu_07182025004020004'
go
EXEC sp_rename 'dbo.GenderQualify','GenderQual_07182025004020005'
go
EXEC sp_rename 'dbo.DF__Qualify__IsShort__32E0915F', 'DF__Qualif_07182025004020006',OBJECT
go
EXEC sp_rename 'dbo.Qualify','Qualify_07182025004020000',OBJECT
go
CREATE TABLE dbo.Qualify
(
    QualifyID     int      IDENTITY,
    TrialTime     time(7)  NULL,
    IsShortCourse bit      CONSTRAINT DF__Qualify__IsShort__32E0915F DEFAULT ((1))  NOT NULL,
    LengthOfPool  int      NULL,
    TrialDistID   int      NULL,
    QualifyDistID int      NULL,
    StrokeID      int      NULL,
    GenderID      int      NULL
)
ON [PRIMARY]
go
if exists (select * from ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'table', 'Qualify', default, default))
BEGIN
  exec sys.sp_dropextendedproperty 'MS_Description', 'schema', 'dbo', 'table', 'Qualify'
END
exec sys.sp_addextendedproperty 'MS_Description', 'Qualifying Times:
For a swimmer to compete in an event of said distance and stroke they must have swum the stoke in a (shorter) distance within a given time.', 'schema', 'dbo', 'table', 'Qualify'
go
if exists (select * from ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'table', 'Qualify', 'column', 'LengthOfPool'))
BEGIN
  exec sys.sp_dropextendedproperty 'MS_Description', 'schema', 'dbo', 'table', 'Qualify', 'column', 'LengthOfPool'
END
exec sys.sp_addextendedproperty 'MS_Description', 'While IsShortCourse will determine the generic pool standard - ie the course length. Short Course (SC),  Long Course (LC)
LengthOfPool allows for more options in filtering of the qualify table.
An example.
If the tblSwimClub->LengthOfPool value is 33m and Qualify->LengthOfPool is 33m then it can pull these records under the guise of the generic pool standard.
If these values don''t exist then the pool length that matches the generic pool standard is used. towit Short Course (SC) 25m,  Long Course (LC) 50m', 'schema', 'dbo', 'table', 'Qualify', 'column', 'LengthOfPool'
go
GRANT DELETE ON dbo.Qualify TO SCM_Administrator
go
GRANT INSERT ON dbo.Qualify TO SCM_Administrator
go
GRANT SELECT ON dbo.Qualify TO SCM_Administrator
go
GRANT UPDATE ON dbo.Qualify TO SCM_Administrator
go
GRANT SELECT ON dbo.Qualify TO SCM_Guest
go
GRANT SELECT ON dbo.Qualify TO SCM_Marshall
go
EXEC sp_rename 'dbo.ScoreDivision.PK_ScoreDivision','PK_ScoreDi_07182025004021001','INDEX'
go
EXEC sp_rename 'dbo.GenderScoreDivision','GenderScor_07182025004021002'
go
EXEC sp_rename 'dbo.SwimClubScoreDivision','SwimClubSc_07182025004021003'
go
EXEC sp_rename 'dbo.ScoreDivision','ScoreDivis_07182025004021000',OBJECT
go
CREATE TABLE dbo.ScoreDivision
(
    ScoreDivisionID int            IDENTITY,
    Caption         nvarchar(128)  NULL,
    AgeFrom         int            NULL,
    AgeTo           int            NULL,
    SwimClubID      int            NULL,
    GenderID        int            NULL
)
ON [PRIMARY]
go
GRANT DELETE ON dbo.ScoreDivision TO SCM_Administrator
go
GRANT INSERT ON dbo.ScoreDivision TO SCM_Administrator
go
GRANT SELECT ON dbo.ScoreDivision TO SCM_Administrator
go
GRANT UPDATE ON dbo.ScoreDivision TO SCM_Administrator
go
GRANT SELECT ON dbo.ScoreDivision TO SCM_Guest
go
GRANT SELECT ON dbo.ScoreDivision TO SCM_Marshall
go
EXEC sp_rename 'dbo.ScorePoints.PK_ScorePoints','PK_ScorePo_07182025004022001','INDEX'
go
EXEC sp_rename 'dbo.SwimClubScorePoints','SwimClubSc_07182025004022002'
go
EXEC sp_rename 'dbo.ScorePoints','ScorePoint_07182025004022000',OBJECT
go
CREATE TABLE dbo.ScorePoints
(
    ScorePointsID int    IDENTITY,
    Place         int    NULL,
    Points        float  NULL,
    SwimClubID    int    NULL
)
ON [PRIMARY]
go
GRANT DELETE ON dbo.ScorePoints TO SCM_Administrator
go
GRANT INSERT ON dbo.ScorePoints TO SCM_Administrator
go
GRANT SELECT ON dbo.ScorePoints TO SCM_Administrator
go
GRANT UPDATE ON dbo.ScorePoints TO SCM_Administrator
go
GRANT SELECT ON dbo.ScorePoints TO SCM_Guest
go
GRANT SELECT ON dbo.ScorePoints TO SCM_Marshall
go
DROP TABLE dbo.SwimClubMetaDataLink
go
EXEC sp_rename 'dbo.TeamEntrant.PK_TeamEntrant','PK_TeamEnt_07182025004023001','INDEX'
go
EXEC sp_rename 'dbo.StrokeTeamEntrant','StrokeTeam_07182025004023002'
go
EXEC sp_rename 'dbo.DisqualifyCodeTeamEntrant','Disqualify_07182025004023003'
go
EXEC sp_rename 'dbo.TeamTeamEntrant','TeamTeamEn_07182025004023004'
go
EXEC sp_rename 'dbo.TeamEntrant','TeamEntran_07182025004023000',OBJECT
go
CREATE TABLE dbo.TeamEntrant
(
    TeamEntrantID    int      IDENTITY,
    MemberID         int      NULL,
    Lane             int      NULL,
    RaceTime         time(7)  NULL,
    TimeToBeat       time(7)  NULL,
    PersonalBest     time(7)  NULL,
    IsDisqualified   bit       NOT NULL,
    IsScratched      bit       NOT NULL,
    DisqualifyCodeID int      NULL,
    StrokeID         int      NULL,
    TeamID           int      NULL
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

-- Insert Data SQL

SET IDENTITY_INSERT dbo.ContactNum ON
go
INSERT INTO dbo.ContactNum(
                           ContactNumID,
                           Number,
                           IsArchived,
                           CreatedOn,
                           MemberID,
                           ContactNumTypeID
                          )
                    SELECT 
                           ContactNumID,
                           Number,
                           IsArchived,
                           CreatedOn,
                           MemberID,
                           ContactNumTypeID
                      FROM dbo.ContactNum_07182025004015000 
go
SET IDENTITY_INSERT dbo.ContactNum OFF
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
                        HeatID
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
                        HeatID
                   FROM dbo.Entrant_07182025004016000 
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
                      MinAge,
                      MaxAge,
                      SessionID,
                      StrokeID,
                      DistanceID,
                      EventStatusID,
                      RoundID,
                      GenderID
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
                      MinAge,
                      MaxAge,
                      SessionID,
                      StrokeID,
                      DistanceID,
                      EventStatusID,
                      RoundID,
                      GenderID
                 FROM dbo.Event_07182025004017000 
go
SET IDENTITY_INSERT dbo.Event OFF
go
SET IDENTITY_INSERT dbo.Heat ON
go
INSERT INTO dbo.Heat(
                     HeatID,
                     HeatNum,
                     Caption,
                     ScheduleDT,
                     RallyOpenDT,
                     RallyCloseDT,
                     OpenDT,
                     CloseDT,
                     EventID,
                     HeatTypeID,
                     HeatStatusID
                    )
              SELECT 
                     HeatID,
                     HeatNum,
                     Caption,
                     ScheduleDT,
                     RallyOpenDT,
                     RallyCloseDT,
                     OpenDT,
                     CloseDT,
                     EventID,
                     HeatTypeID,
                     HeatStatusID
                FROM dbo.Heat_07182025004018000 
go
SET IDENTITY_INSERT dbo.Heat OFF
go
SET IDENTITY_INSERT dbo.Member ON
go
INSERT INTO dbo.Member(
                       MemberID,
                       MembershipNum,
                       MembershipStr,
                       FirstName,
                       MiddleInitial,
                       LastName,
                       RegisterNum,
                       RegisterStr,
                       DOB,
                       IsArchived,
                       IsActive,
                       IsSwimmer,
                       Email,
                       CreatedOn,
                       ArchivedOn,
                       EnableEmailOut,
                       EnableEmailNomineeForm,
                       EnableEmailSessionReport,
                       TAGS,
                       GenderID
                      )
                SELECT 
                       MemberID,
                       MembershipNum,
                       MembershipStr,
                       FirstName,
                       MiddleInitial,
                       LastName,
                       RegisterNum,
                       RegisterStr,
                       DOB,
                       IsArchived,
                       IsActive,
                       IsSwimmer,
                       Email,
                       CreatedOn,
                       ArchivedOn,
                       EnableEmailOut,
                       EnableEmailNomineeForm,
                       EnableEmailSessionReport,
                       TAGS,
                       GenderID
                  FROM dbo.Member_07182025004019000 
go
SET IDENTITY_INSERT dbo.Member OFF
go
SET IDENTITY_INSERT dbo.Qualify ON
go
INSERT INTO dbo.Qualify(
                        QualifyID,
                        TrialTime,
                        IsShortCourse,
                        LengthOfPool,
                        TrialDistID,
                        QualifyDistID,
                        StrokeID,
                        GenderID
                       )
                 SELECT 
                        QualifyID,
                        TrialTime,
                        IsShortCourse,
                        LengthOfPool,
                        TrialDistID,
                        QualifyDistID,
                        StrokeID,
                        GenderID
                   FROM dbo.Qualify_07182025004020000 
go
SET IDENTITY_INSERT dbo.Qualify OFF
go
SET IDENTITY_INSERT dbo.ScoreDivision ON
go
INSERT INTO dbo.ScoreDivision(
                              ScoreDivisionID,
                              Caption,
                              AgeFrom,
                              AgeTo,
                              SwimClubID,
                              GenderID
                             )
                       SELECT 
                              ScoreDivisionID,
                              Caption,
                              AgeFrom,
                              AgeTo,
                              SwimClubID,
                              GenderID
                         FROM dbo.ScoreDivis_07182025004021000 
go
SET IDENTITY_INSERT dbo.ScoreDivision OFF
go
SET IDENTITY_INSERT dbo.ScorePoints ON
go
INSERT INTO dbo.ScorePoints(
                            ScorePointsID,
                            Place,
                            Points,
                            SwimClubID
                           )
                     SELECT 
                            ScorePointsID,
                            Place,
                            Points,
                            SwimClubID
                       FROM dbo.ScorePoint_07182025004022000 
go
SET IDENTITY_INSERT dbo.ScorePoints OFF
go
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
                            TeamID
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
                            TeamID
                       FROM dbo.TeamEntran_07182025004023000 
go
SET IDENTITY_INSERT dbo.TeamEntrant OFF
go

-- Add Constraint SQL

ALTER TABLE dbo.ContactNum ADD CONSTRAINT PK_ContactNum
PRIMARY KEY CLUSTERED (ContactNumID)
go
ALTER TABLE dbo.Entrant ADD CONSTRAINT PK_Entrant
PRIMARY KEY NONCLUSTERED (EntrantID)
go
ALTER TABLE dbo.Event ADD CONSTRAINT PK_Event
PRIMARY KEY NONCLUSTERED (EventID)
go
ALTER TABLE dbo.Heat ADD CONSTRAINT PK_HeatIndividual
PRIMARY KEY NONCLUSTERED (HeatID)
go
ALTER TABLE dbo.Member ADD CONSTRAINT PK_Member
PRIMARY KEY NONCLUSTERED (MemberID)
go
ALTER TABLE dbo.Qualify ADD CONSTRAINT PK_Qualify
PRIMARY KEY CLUSTERED (QualifyID)
go
ALTER TABLE dbo.ScoreDivision ADD CONSTRAINT PK_ScoreDivision
PRIMARY KEY CLUSTERED (ScoreDivisionID)
go
ALTER TABLE dbo.ScorePoints ADD CONSTRAINT PK_ScorePoints
PRIMARY KEY CLUSTERED (ScorePointsID)
go
ALTER TABLE dbo.TeamEntrant ADD CONSTRAINT PK_TeamEntrant
PRIMARY KEY NONCLUSTERED (TeamEntrantID)
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.Split ADD CONSTRAINT EntrantSplit
FOREIGN KEY (EntrantID)
REFERENCES dbo.Entrant (EntrantID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.Nominee ADD CONSTRAINT EventNominee
FOREIGN KEY (EventID)
REFERENCES dbo.Event (EventID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.Heat ADD CONSTRAINT EventHeat
FOREIGN KEY (EventID)
REFERENCES dbo.Event (EventID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.Entrant ADD CONSTRAINT HeatEntrant
FOREIGN KEY (HeatID)
REFERENCES dbo.Heat (HeatID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.Team ADD CONSTRAINT HeatTeam
FOREIGN KEY (HeatID)
REFERENCES dbo.Heat (HeatID)
go
ALTER TABLE dbo.Entrant ADD CONSTRAINT MemberEntrant
FOREIGN KEY (MemberID)
REFERENCES dbo.Member (MemberID)
 NOT FOR REPLICATION
go
ALTER TABLE dbo.MemberLink ADD CONSTRAINT FK_MemberLink
FOREIGN KEY (MemberID)
REFERENCES dbo.Member (MemberID)
go
ALTER TABLE dbo.Nominee ADD CONSTRAINT MemberNominee
FOREIGN KEY (MemberID)
REFERENCES dbo.Member (MemberID)
go
ALTER TABLE dbo.TeamEntrant ADD CONSTRAINT MemberTeamEntrant
FOREIGN KEY (MemberID)
REFERENCES dbo.Member (MemberID)
go
ALTER TABLE dbo.ContactNum ADD CONSTRAINT MemberContactNum
FOREIGN KEY (MemberID)
REFERENCES dbo.Member (MemberID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.MemberRoleLink ADD CONSTRAINT MemberMemberRoleLink
FOREIGN KEY (MemberID)
REFERENCES dbo.Member (MemberID)
go
ALTER TABLE dbo.ContactNum ADD CONSTRAINT ContactNumTypeContactNum
FOREIGN KEY (ContactNumTypeID)
REFERENCES dbo.ContactNumType (ContactNumTypeID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Entrant ADD CONSTRAINT DisqualifyCodeEntrant
FOREIGN KEY (DisqualifyCodeID)
REFERENCES dbo.DisqualifyCode (DisqualifyCodeID)
go
ALTER TABLE dbo.Event ADD CONSTRAINT SessionEvent
FOREIGN KEY (SessionID)
REFERENCES dbo.[Session] (SessionID)
 ON DELETE CASCADE
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
ALTER TABLE dbo.Member ADD CONSTRAINT GenderMember
FOREIGN KEY (GenderID)
REFERENCES dbo.Gender (GenderID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Qualify ADD CONSTRAINT DistanceQualifyTrialDist
FOREIGN KEY (TrialDistID)
REFERENCES dbo.Distance (DistanceID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Qualify ADD CONSTRAINT StrokeQualify
FOREIGN KEY (StrokeID)
REFERENCES dbo.Stroke (StrokeID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.Qualify ADD CONSTRAINT DistanceQualifyDist
FOREIGN KEY (QualifyDistID)
REFERENCES dbo.Distance (DistanceID)
go
ALTER TABLE dbo.Qualify ADD CONSTRAINT GenderQualify
FOREIGN KEY (GenderID)
REFERENCES dbo.Gender (GenderID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.ScoreDivision ADD CONSTRAINT SwimClubScoreDivision
FOREIGN KEY (SwimClubID)
REFERENCES dbo.SwimClub (SwimClubID)
go
ALTER TABLE dbo.ScoreDivision ADD CONSTRAINT GenderScoreDivision
FOREIGN KEY (GenderID)
REFERENCES dbo.Gender (GenderID)
go
ALTER TABLE dbo.ScorePoints ADD CONSTRAINT SwimClubScorePoints
FOREIGN KEY (SwimClubID)
REFERENCES dbo.SwimClub (SwimClubID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.TeamEntrant ADD CONSTRAINT TeamTeamEntrant
FOREIGN KEY (TeamID)
REFERENCES dbo.Team (TeamID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.TeamEntrant ADD CONSTRAINT StrokeTeamEntrant
FOREIGN KEY (StrokeID)
REFERENCES dbo.Stroke (StrokeID)
 ON DELETE SET NULL
go
ALTER TABLE dbo.TeamEntrant ADD CONSTRAINT DisqualifyCodeTeamEntrant
FOREIGN KEY (DisqualifyCodeID)
REFERENCES dbo.DisqualifyCode (DisqualifyCodeID)
go
