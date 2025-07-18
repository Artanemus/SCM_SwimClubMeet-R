USE [SwimClubMeet]
go

-- Standard Alter Table SQL

EXEC sp_rename 'dbo.MemberLinkTeamEntrant','FK_MemberLinkTeamEntrant'
go
ALTER TABLE dbo.Entrant ADD CONSTRAINT FK_MemberLinkEntrant
FOREIGN KEY (MemberID,SwimClubID)
REFERENCES dbo.MemberLink (MemberID,SwimClubID)
go
ALTER TABLE dbo.Nominee ADD CONSTRAINT FK_MemberLinkNominee
FOREIGN KEY (MemberID,SwimClubID)
REFERENCES dbo.MemberLink (MemberID,SwimClubID)
go
