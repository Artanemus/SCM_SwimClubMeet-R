USE SwimClubMeet;

DECLARE @swimclubid AS INTEGER;
SET @swimclubid = 1;

SELECT [SessionID]
     , [Caption]
     , [SessionStart]
     , [ClosedDT]
     , [SwimClubID]
     , [SessionStatusID]
FROM [SwimClubMeet].[dbo].[Session]
WHERE [Session].[SwimClubID] = @swimclubid;