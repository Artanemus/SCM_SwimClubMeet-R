USE [SwimClubMeet]
go

-- Standard Alter Table SQL

ALTER TABLE dbo.Distance ADD EventTypeID int  NULL
go
ALTER TABLE dbo.Event DROP CONSTRAINT EventTypeEvent
go
ALTER TABLE dbo.Event DROP COLUMN EventTypeID
go
ALTER TABLE dbo.Distance ADD CONSTRAINT EventTpeDistance
FOREIGN KEY (EventTypeID)
REFERENCES dbo.EventType (EventTypeID)
go
