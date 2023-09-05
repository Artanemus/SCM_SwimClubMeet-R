USE SwimClubMeet;

IF OBJECT_ID('tempDB..#HeatTime', 'U') IS NOT NULL
    DROP TABLE #HeatTime;

SELECT MAX([Entrant].[TimeToBeat]) AS MaxSwimTime
     , [Event].[EventID] AS EventID
     , [HeatIndividual].[HeatID] AS HeatID
INTO #HeatTime
FROM [SwimClubMeet].[dbo].[Entrant]
    INNER JOIN [HeatIndividual]
        ON [Entrant].[HeatID] = [HeatIndividual].[HeatID]
    INNER JOIN [Event]
        ON [HeatIndividual].[EventID] = [Event].[EventID]
WHERE [Entrant].[TimeToBeat] IS NOT NULL
      AND [Event].[SessionID] = 1
GROUP BY [Event].[EventID]
       , [HeatIndividual].[HeatID];

IF OBJECT_ID('tempDB..#TOTHeatTime', 'U') IS NOT NULL
    DROP TABLE #TOTHeatTime;

SELECT CONVERT(TIME, DATEADD(MILLISECOND, SUM(dbo.SwimTimeToMilliseconds(MaxSwimTime)), 0), 114) AS TOTEvSwimTime
     , EventID
INTO #TOTHeatTime
FROM #HeatTime
GROUP BY EventID

SELECT * FROM #TOTHeatTime;