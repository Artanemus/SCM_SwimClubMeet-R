USE [SwimClubMeet];

DECLARE @SwimClubID AS INTEGER;

SET @SwimClubID = 1; --:SWIMCLUBID;

SELECT [SwimmerCategoryID]
     , [Caption]
     , [LongCaption]
     , [ABREV]
     , [AgeFrom]
     , [AgeTo]
     , [IsActive]
     , [IsArchived]
FROM [dbo].[SwimmerCategory]
WHERE SwimClubID = @SwimClubID
ORDER BY AgeFrom;