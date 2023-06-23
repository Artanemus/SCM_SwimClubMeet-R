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

-- calculate swimming time for heat heat  for each event

IF OBJECT_ID('tempDB..#HeatTime', 'U') IS NOT NULL
    DROP TABLE #HeatTime;

SELECT MAX([Entrant].[TimeToBeat]) AS MaxSwimTime
     , [Event].[EventID] AS EventID
INTO #HeatTime
FROM [SwimClubMeet].[dbo].[Entrant]
    INNER JOIN [HeatIndividual]
        ON [Entrant].[HeatID] = [HeatIndividual].[HeatID]
    INNER JOIN [Event]
        ON [HeatIndividual].[EventID] = [Event].[EventID]
WHERE [Entrant].[TimeToBeat] IS NOT NULL
      AND [Event].[SessionID] = 1
GROUP BY [Event].[EventID];

SELECT [Event].EventID
     , [Event].EventNum
     , [Event].ScheduleDT
     , Distance.Meters
     , HeatCount
     , MaxSwimTime
FROM [Event]
    INNER JOIN Distance
        ON [Event].DistanceID = Distance.DistanceID
    LEFT JOIN #CountHeats
        ON [Event].[EventID] = #CountHeats.EventID
    LEFT JOIN #HeatTime
        ON [Event].[EventID] = #HeatTime.EventID
WHERE SessionID = @SessionID
ORDER BY EventNum;