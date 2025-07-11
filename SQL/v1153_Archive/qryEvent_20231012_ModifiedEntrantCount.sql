USE SwimClubMeet;

IF OBJECT_ID('tempdb..#TempTable') IS NOT NULL
    DROP TABLE #TempTable;

SELECT EventID
     , SUM(Count) AS TotalCount
INTO #TempTable
FROM
(
    SELECT HeatIndividual.EventID
         , COUNT(Entrant.EntrantID) AS Count
    FROM Entrant
        INNER JOIN HeatIndividual
            ON Entrant.HeatID = HeatIndividual.HeatID
    WHERE MemberID IS NOT NULL            
    GROUP BY HeatIndividual.EventID
    UNION ALL
    SELECT HeatIndividual.EventID
         , COUNT(TeamEntrant.TeamEntrantID) AS Count
    FROM TeamEntrant
        INNER JOIN Team
            ON TeamEntrant.TeamID = Team.TeamID
        INNER JOIN HeatIndividual
            ON Team.HeatID = HeatIndividual.HeatID
    WHERE MemberID IS NOT NULL
    GROUP BY HeatIndividual.EventID
) AS Counts
GROUP BY EventID;


SELECT [Event].[EventID]
     , [Event].[EventNum]
     , [Event].[Caption]
     , [Event].[ClosedDT]
     , [Event].[ScheduleDT]
     , [Event].[SessionID]
     , [Event].[StrokeID]
     , [Event].[DistanceID]
     , [Event].[EventStatusID]
     , qryNom.NomCount AS NomineeCount
     , #TempTable.TotalCount AS EntrantCount
     , CONCAT('#', Event.EventNum, ' - ', Distance.Caption, ' ', Stroke.Caption) AS EventStr
     , Distance.Meters
     , Distance.ABREV
     , Distance.EventTypeID
FROM Event
    LEFT OUTER JOIN Stroke
        ON Stroke.StrokeID = Event.StrokeID
    LEFT OUTER JOIN Distance
        ON Distance.DistanceID = Event.DistanceID
    LEFT JOIN
    (
        SELECT COUNT(Nominee.EventID) AS NomCount
             , EventID
        FROM Nominee
        GROUP BY Nominee.EventID
    ) qryNom
        ON qryNom.EventID = Event.EventID
    LEFT JOIN #TempTable
        ON #TempTable.EventID = Event.EventID
ORDER BY Event.EventNum;