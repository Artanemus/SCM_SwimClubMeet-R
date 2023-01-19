USE SwimClubMeet;

DECLARE @SessionID AS INTEGER;

SET @SessionID = 100;

SELECT [SessionID]
     , [Caption]
     , [SessionStart]
     , [ClosedDT]
     , [SwimClubID]
     , [SessionStatusID]
FROM [SwimClubMeet].[dbo].[Session]
WHERE [Session].[SessionID] = @SessionID;