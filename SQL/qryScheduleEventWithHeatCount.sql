USE SwimClubMeet;

-- Drop a temporary table called '#CountHeats'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#CountHeats', 'U') IS NOT NULL
    DROP TABLE #CountHeats;

DECLARE @SessionID AS INTEGER;
SET @SessionID = 1; -- :SESSIONID;

-- Create the temporary table from a physical table called 'HeatIndivual' in schema 'dbo' in database 'SwimClubMeet'
SELECT COUNT(HeatID) AS HeatCount
     , [HeatIndividual].EventID
INTO #CountHeats
FROM [SwimClubMeet].[dbo].[HeatIndividual]
    INNER JOIN [Event]
        ON [HeatIndividual].[EventID] = [Event].[EventID]
WHERE [Event].[SessionID] = @SessionID
GROUP BY [HeatIndividual].[EventID]

SELECT [Event].EventID
     , [Event].EventNum
     , [Event].ScheduleDT
     , Distance.Meters
     , HeatCount
FROM [Event]
    INNER JOIN Distance
        ON [Event].DistanceID = Distance.DistanceID
    LEFT JOIN #CountHeats
        ON [Event].[EventID] = #CountHeats.EventID
WHERE SessionID = @SessionID
ORDER BY EventNum;