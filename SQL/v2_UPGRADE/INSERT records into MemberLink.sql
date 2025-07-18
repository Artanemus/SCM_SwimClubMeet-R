USE [SwimClubMeet]
GO


INSERT INTO [dbo].[MemberLink]
           ([MemberID]
           ,[SwimClubID]
           ,[HouseID])
     SELECT
           Member.MemberID
           ,1
           ,NULL
FROM dbo.Member
GO

