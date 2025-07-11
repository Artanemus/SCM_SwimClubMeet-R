Use SwimClubMeet;

DECLARE @Major AS INT;
SET @Major = (SELECT Major FROM SwimClubMeet.dbo.SCMSystem WHERE SCMSystemID = 1);
DECLARE @Minor AS INT;
SET @Minor = (SELECT Major FROM SwimClubMeet.dbo.SCMSystem WHERE SCMSystemID = 1);

-- Drop a temporary table called '#TableName'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#TempSCMEvent', 'U') IS NOT NULL
DROP TABLE #TempSCMEvent
;

/* Get the data into a temp table */
    SELECT * INTO #TempSCMEvent
    FROM 
    Event

/*
VERSION 1,1,5,0 AND 1,1,5,1 COMPATABILITY
*/

IF (@Major = 5) AND ((@Minor = 0) OR (@Minor = 1))
BEGIN
	/* Drop the columns that are not needed */
	IF COL_LENGTH('Event','ScheduleDT') IS NOT NULL
	BEGIN
	/* Column does exist */
		ALTER TABLE #TempSCMEvent
		DROP COLUMN ScheduleDT
	END
END


--SELECT * from #TempSCMEvent;

SELECT #TempSCMEvent.*,
	  qryNom.NomCount AS NomineeCount,
       qryEntrants.EntrantCount AS EntrantCount,
       Concat('#', #TempSCMEvent.EventNum, ' - ', Distance.Caption, ' ', Stroke.Caption) AS EventStr,
       Distance.Meters
FROM #TempSCMEvent
     LEFT OUTER JOIN Stroke ON Stroke.StrokeID = #TempSCMEvent.StrokeID
     LEFT OUTER JOIN Distance ON Distance.DistanceID = #TempSCMEvent.DistanceID
	
     LEFT JOIN (SELECT Count(Nominee.EventID) AS NomCount, EventID
                FROM Nominee
                GROUP BY  Nominee.EventID) qryNom ON qryNom.EventID = #TempSCMEvent.EventID 
     LEFT JOIN (SELECT Count(Entrant.EntrantID) AS EntrantCount,
                       HeatIndividual.EventID
                FROM Entrant
                     INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.HeatID
                WHERE        (Entrant.MemberID IS NOT NULL)
                GROUP BY HeatIndividual.EventID) qryEntrants ON qryEntrants.EventID = #TempSCMEvent.EventID


ORDER BY #TempSCMEvent.EventNum;

