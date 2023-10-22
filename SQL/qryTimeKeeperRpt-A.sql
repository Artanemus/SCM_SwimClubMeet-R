USE SwimClubMeet

DECLARE @HeatID AS INT
DECLARE @EventTypeID AS integer;

SET @HeatID = 65; --:HEATID
SET @EventTypeID =
(
    SELECT EventTypeID
    FROM [HeatIndividual]
        INNER JOIN [Event]
            ON [HeatIndividual].EventID = [Event].EventID
        INNER JOIN Distance
            ON [Event].DistanceID = Distance.DistanceID
    WHERE [HeatIndividual].HeatID = @HeatID
);

IF @EventTypeID = 1
BEGIN
    SELECT Event.EventID
         , Event.Caption AS cEvent
         , Distance.Caption AS cDistance
         , Stroke.Caption AS cStroke
         , HeatIndividual.HeatNum
         , HeatIndividual.HeatID
         , Entrant.Lane
         , CONCAT(Member.FirstName, ' ', UPPER(Member.LastName)) AS FNAME
	     , '' AS TeamName
         , 0 AS TeamNameID
         , CASE CAST([Entrant].[PersonalBest] AS DATETIME)
               WHEN NULL THEN
                   ''
               WHEN 0 THEN
                   ''
               ELSE
                   FORMAT(CAST([Entrant].[PersonalBest] AS DATETIME), 'mm:ss.fff')
           END AS PersonalBest
         , Event.EventNum
         , Event.SessionID
    FROM Event
        INNER JOIN Stroke
            ON Event.StrokeID = Stroke.StrokeID
        INNER JOIN Distance
            ON Event.DistanceID = Distance.DistanceID
        INNER JOIN HeatIndividual
            ON HeatIndividual.EventID = Event.EventID
        INNER JOIN Entrant
            ON Entrant.HeatID = HeatIndividual.HeatID
        LEFT JOIN Member
            ON Entrant.MemberID = Member.MemberID
    WHERE HeatIndividual.HeatID = @HeatID
    ORDER BY Event.EventNum
           , HeatIndividual.HeatNum
           , Entrant.Lane;
END
ELSE
BEGIN
    SELECT Event.EventID
         , Event.Caption AS cEvent
         , Distance.Caption AS cDistance
         , Stroke.Caption AS cStroke
         , HeatIndividual.HeatNum
         , HeatIndividual.HeatID
         , Team.Lane
         , CONCAT('(#', TeamEntrant.Lane, ') ', Member.FirstName, ' ', UPPER(Member.LastName)) AS FNAME
         , TeamName.Caption AS TeamName
         , TeamName.TeamNameID
         , CASE CAST([TeamEntrant].[PersonalBest] AS DATETIME)
               WHEN NULL THEN
                   ''
               WHEN 0 THEN
                   ''
               ELSE
                   FORMAT(CAST([TeamEntrant].[PersonalBest] AS DATETIME), 'mm:ss.fff')
           END AS PersonalBest
         , Event.EventNum
         , Event.SessionID
    FROM [Event]
        INNER JOIN Stroke
            ON Event.StrokeID = Stroke.StrokeID
        INNER JOIN Distance
            ON Event.DistanceID = Distance.DistanceID
        INNER JOIN HeatIndividual
            ON HeatIndividual.EventID = Event.EventID
        INNER JOIN Team
            ON HeatIndividual.HeatID = Team.HeatID
        INNER JOIN TeamEntrant
            ON Team.TeamID = TeamEntrant.TeamID
        LEFT JOIN TeamName
            ON Team.TeamNameID = TeamName.TeamNameID
        LEFT JOIN Member
            ON TeamEntrant.MemberID = Member.MemberID
    WHERE HeatIndividual.HeatID = @HeatID
          AND Team.TeamNameID IS NOT NULL
          AND TeamEntrant.MemberID IS NOT NULL
    ORDER BY Event.EventNum
           , HeatIndividual.HeatNum
           , Team.Lane
           , TeamEntrant.Lane;
END