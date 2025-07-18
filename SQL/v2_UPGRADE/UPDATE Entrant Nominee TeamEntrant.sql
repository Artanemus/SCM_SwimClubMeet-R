USE [SwimClubMeet]
GO

UPDATE [dbo].[Entrant]
   SET [SwimClubID] = 1
GO

UPDATE [dbo].[Nominee]
   SET [SwimClubID] = 1
GO

UPDATE [dbo].[TeamEntrant]
   SET [SwimClubID] = 1
GO
