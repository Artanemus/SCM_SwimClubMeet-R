USE SwimClubMeet;

DECLARE @SessionID AS INTEGER;
SET @SessionID = 2;

-- Drop a temporary table called '#QTemp'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#QTemp', 'U') IS NOT NULL
    DROP TABLE #QTemp;

-- Create the temporary table from a physical table called 'Session' in schema 'dbo' in database 'SwimClubMeet'
SELECT [Session].SessionID
     , [Event].EventID
     , [Event].DistanceID
     , [Event].StrokeID
     , [HeatIndividual].[HeatID]
     , [HeatIndividual].[HeatNum]
     , [Entrant].MemberID
     , dbo.PersonalBest([Member].MemberID, [Qualify].TrialDistID, Event.StrokeID, GETDATE()/*Session.SessionStart*/) AS PB
     , [Qualify].TrialTime AS QTime
     , [Qualify].TrialDistID
INTO #QTemp
FROM [SwimClubMeet].[dbo].[Session]
    INNER JOIN [Event]
        ON [Session].SessionID = [Event].SessionID
    INNER JOIN [HeatIndividual]
        ON [Event].[EventID] = [HeatIndividual].[EventID]
    INNER JOIN [Entrant]
        ON [HeatIndividual].HeatID = [Entrant].HeatID
    INNER JOIN [Member]
        ON [Entrant].MemberID = [Member].MemberID
    INNER JOIN [Qualify]
        ON [Event].DistanceID = [Qualify].[QualifyDistID]
           AND [Event].StrokeID = [Qualify].StrokeID
    INNER JOIN [SwimClub]
        ON [Session].SwimClubID = [SwimClub].[SwimClubID]
WHERE [Session].SessionID = @SessionID
      AND [Entrant].MemberID IS NOT NULL
      AND [Qualify].LengthOfPool = [SwimClub].[LenOfPool]
      AND [Member].[GenderID] = [Qualify].[GenderID];

SELECT SessionID
     , EventID
     , #QTemp.[DistanceID]
     , #QTemp.[StrokeID]
     , HeatID
     , HeatNum
     , #QTemp.MemberID
     , #QTemp.TrialDistID
     , dbo.SwimTimeToString(PB) AS strPB
     , dbo.SwimTimeToString(QTime) AS strQTime
     , [Distance].Caption AS strDistance
     , qDistance.Caption AS strQDistance
     , [Stroke].Caption AS strStroke
     , CONCAT(Member.FirstName, ' ', member.LastName) AS FName
FROM #QTemp
    INNER JOIN [Distance]
        ON #QTemp.DistanceID = [Distance].DistanceID
    INNER JOIN [Distance] AS qDistance
        ON #QTemp.TrialDistID = qDistance.DistanceID
    INNER JOIN [Stroke]
        ON #QTemp.StrokeID = [Stroke].StrokeID
    INNER JOIN [Member]
        ON #QTemp.MemberID = [Member].MemberID
WHERE PB IS NOT NULL
      AND (PB > QTime)




