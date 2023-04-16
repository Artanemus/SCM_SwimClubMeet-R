USE [SwimClubMeet]
go

-- Dictionary Object Alter SQL

CREATE DEFAULT dbo.BIT_0 AS 0
go

-- Standard Alter Table SQL

ALTER TABLE dbo.Entrant ADD DisqualifiedID int  NULL
go
ALTER TABLE dbo.Event ADD ScheduleDT time(7)  NULL
go
ALTER TABLE dbo.SCMSystem DROP CONSTRAINT DF__SCMSystem__DBVer__35BCFE0A
go
ALTER TABLE dbo.SCMSystem ADD CONSTRAINT DF__SCMSystem__DBVer__35BCFE0A DEFAULT ((0)) FOR DBVersion
go
ALTER TABLE dbo.SwimClub ADD LogoDir varchar(max)  NULL
go
ALTER TABLE dbo.SwimClub ADD LogoImg image  NULL
go
ALTER TABLE dbo.SwimClub ADD LogoType nvarchar(5)  NULL
go
ALTER TABLE dbo.Team ADD DisqualifiedID int  NULL
go
ALTER TABLE dbo.Entrant ADD FOREIGN KEY (DisqualifiedID)
REFERENCES dbo.Disqualified (DisqualifiedID)
go
ALTER TABLE dbo.Team ADD FOREIGN KEY (DisqualifiedID)
REFERENCES dbo.Disqualified (DisqualifiedID)
go

-- Drop Referencing Constraint SQL

ALTER TABLE dbo.Member DROP CONSTRAINT FK_House_Member
go

-- Drop Constraint, Rename and Create Table SQL

EXEC sp_rename 'dbo.ContactNum.PK_ContactNum','PK_Contact_04162023003843001','INDEX'
go
EXEC sp_rename 'dbo.FK_Member_ContactNum','FK_Member__04162023003843002'
go
EXEC sp_rename 'dbo.FK_ContactNumType_ContactNum','FK_Contact_04162023003843003'
go
EXEC sp_rename 'dbo.ContactNum','ContactNum_04162023003843000',OBJECT
go
CREATE TABLE dbo.ContactNum
(
    ContactNumID     int           IDENTITY,
    Number           nvarchar(30)  NULL,
    ContactNumTypeID int           NULL,
    MemberID         int           NULL,
    IsArchived       bit            NOT NULL,
    CreatedOn        datetime      NULL
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
EXEC sp_rename 'dbo.House.PK_House','PK_House_04162023003844001','INDEX'
go
EXEC sp_rename 'dbo.House','House_04162023003844000',OBJECT
go
CREATE TABLE dbo.House
(
    HouseID    int            IDENTITY,
    Caption    nvarchar(128)  NULL,
    Motto      nvarchar(128)  NULL,
    Color      int            NULL,
    LogoDir    varchar(max)   NULL,
    LogoImg    image          NULL,
    LogoType   nvarchar(5)    NULL,
    IsArchived bit             NOT NULL,
    CreatedOn  datetime       NULL
)
ON [PRIMARY]
go
GRANT DELETE ON dbo.House TO SCM_Administrator
go
GRANT INSERT ON dbo.House TO SCM_Administrator
go
GRANT SELECT ON dbo.House TO SCM_Administrator
go
GRANT UPDATE ON dbo.House TO SCM_Administrator
go
GRANT SELECT ON dbo.House TO SCM_Guest
go
GRANT SELECT ON dbo.House TO SCM_Marshall
go
EXEC sp_bindefault 'Def_NVARCHAR', 'dbo.House.Caption'
go
EXEC sp_bindefault 'Def_NVARCHAR', 'dbo.House.Motto'
go
CREATE TABLE dbo.Disqualified
(
    DisqualifiedID int             NOT NULL,
    Caption        nvarchar(128)  NULL,
    ABREV          nvarchar(16)   NULL,
    CONSTRAINT PK65
    PRIMARY KEY CLUSTERED (DisqualifiedID)
)
go

-- Insert Data SQL

SET IDENTITY_INSERT dbo.ContactNum ON
go
INSERT INTO dbo.ContactNum(
                           ContactNumID,
                           Number,
                           ContactNumTypeID,
                           MemberID,
                           IsArchived,
                           CreatedOn
                          )
                    SELECT 
                           ContactNumID,
                           Number,
                           ContactNumTypeID,
                           MemberID,
                           0,
                           NULL
                      FROM dbo.ContactNum_04162023003843000 
go
SET IDENTITY_INSERT dbo.ContactNum OFF
go
SET IDENTITY_INSERT dbo.House ON
go
INSERT INTO dbo.House(
                      HouseID,
                      Caption,
                      Motto,
                      Color,
                      LogoDir,
                      LogoImg,
                      LogoType,
                      IsArchived,
                      CreatedOn
                     )
               SELECT 
                      HouseID,
                      Caption,
                      Motto,
                      Color,
                      LogoDir,
                      LogoImg,
                      NULL,
                      0,
                      NULL
                 FROM dbo.House_04162023003844000 
go
SET IDENTITY_INSERT dbo.House OFF
go

-- Add Constraint SQL

ALTER TABLE dbo.ContactNum ADD CONSTRAINT PK_ContactNum
PRIMARY KEY CLUSTERED (ContactNumID)
go
ALTER TABLE dbo.House ADD CONSTRAINT PK_House
PRIMARY KEY CLUSTERED (HouseID)
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.Member ADD CONSTRAINT FK_House_Member
FOREIGN KEY (HouseID)
REFERENCES dbo.House (HouseID)
go
ALTER TABLE dbo.ContactNum ADD CONSTRAINT FK_Member_ContactNum
FOREIGN KEY (MemberID)
REFERENCES dbo.Member (MemberID)
 ON DELETE CASCADE
go
ALTER TABLE dbo.ContactNum ADD CONSTRAINT FK_ContactNumType_ContactNum
FOREIGN KEY (ContactNumTypeID)
REFERENCES dbo.ContactNumType (ContactNumTypeID)
 ON DELETE SET NULL
go
