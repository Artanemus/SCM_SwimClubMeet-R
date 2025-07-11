USE SwimClubMeet;
DECLARE @SwimClubID AS INTEGER;
SET @SwimClubID = 1;
SELECT [ScorePointsID]
     , [SwimClubID]
     , [Place]
     , [Points]
FROM [SwimClubMeet].[dbo].[ScorePoints]
ORDER BY [Place] ASC