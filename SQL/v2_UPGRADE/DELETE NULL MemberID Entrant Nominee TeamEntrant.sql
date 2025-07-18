USE [SwimClubMeet]
GO

DELETE FROM [dbo].[Entrant]
      WHERE MemberID is NULL
GO

DELETE FROM [dbo].[Nominee]
      WHERE MemberID is NULL
GO

DELETE FROM [dbo].[TeamEntrant]
      WHERE MemberID is NULL
GO


