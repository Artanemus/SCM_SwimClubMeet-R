USE [SwimClubMeet]
go

-- Standard Alter Table SQL

EXEC sp_rename 'dbo.HeatIndividualTeam','HeatTeam'
go
EXEC sp_rename 'dbo.HeatIndividualEntrant','HeatEntrant'
go
