USE [SwimClubMeet]
go

-- Standard Alter Table SQL

ALTER TABLE dbo.SCMSystem DROP CONSTRAINT DF__SCMSystem__DBVer__35BCFE0A
go
ALTER TABLE dbo.SCMSystem ADD CONSTRAINT DF__SCMSystem__DBVer__35BCFE0A DEFAULT ((0)) FOR DBVersion
go
ALTER TABLE dbo.Team ADD FOREIGN KEY (DisqualifiedID)
REFERENCES dbo.Disqualified (DisqualifiedID)
go
ALTER TABLE dbo.Entrant ADD FOREIGN KEY (DisqualifiedID)
REFERENCES dbo.Disqualified (DisqualifiedID)
go

-- Drop Constraint, Rename and Create Table SQL

DROP TABLE dbo.ContactNum_04162023003843000
go
EXEC sp_rename 'dbo.Disqualified.PK65','PK65_04162023004048001','INDEX'
go
EXEC sp_rename 'dbo.Disqualified','Disqualifi_04162023004048000',OBJECT
go
CREATE TABLE dbo.Disqualified
(
    DisqualifiedID int             NOT NULL,
    Caption        nvarchar(128)  NULL,
    ABREV          nvarchar(16)   NULL
)
go
DROP TABLE dbo.House_04162023003844000
go

-- Insert Data SQL

INSERT INTO dbo.Disqualified(
                             DisqualifiedID,
                             Caption,
                             ABREV
                            )
                      SELECT 
                             DisqualifiedID,
                             Caption,
                             ABREV
                        FROM dbo.Disqualifi_04162023004048000 
go

-- Add Constraint SQL

ALTER TABLE dbo.Disqualified ADD CONSTRAINT PK65
PRIMARY KEY CLUSTERED (DisqualifiedID)
go
