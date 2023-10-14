USE SwimClubMeet;

DECLARE @EventID as integer;
DECLARE @EventTypeID as integer;

SET @EventID = 65; --:EVENTID;
SET @EventTypeID = (SELECT EventTypeID FROM [EVENT] 
    INNER JOIN Distance ON [Event].DistanceID = Distance.DistanceID
    WHERE EventID = @EventID);

IF @EventTypeID = 1     
    BEGIN
        SELECT
        HeatIndividual.HeatID,
        HeatIndividual.HeatNum,
        Distance.Caption AS cDistance,
        Stroke.Caption AS cStroke,
        Event.EventNum,
        Event.Caption AS cEvent,
        Entrant.Lane,
        Concat(Member.FirstName, ' ', Upper(Member.LastName)) AS FNAME,
        '' AS TEAMName,
        HeatIndividual.EventID
        FROM
        HeatIndividual
        INNER JOIN Event ON HeatIndividual.EventID = Event.EventID
        INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID
        INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID
        INNER JOIN Entrant ON Entrant.HeatID = HeatIndividual.HeatID
        LEFT JOIN Member ON Entrant.MemberID = Member.MemberID
        WHERE
        HeatIndividual.EventID = @EventID
        ORDER BY
        HeatIndividual.HeatNum,
        Entrant.Lane
    END;
ELSE
    BEGIN
        SELECT
        HeatIndividual.HeatID,
        HeatIndividual.HeatNum,
        Concat (Distance.Caption, ' RELAY ') AS cDistance,
        Stroke.Caption AS cStroke,
        Event.EventNum,
        Event.Caption AS cEvent,
        Team.Lane,
        Concat(Member.FirstName, ' ', Upper(Member.LastName)) AS FNAME,
        TeamName.Caption AS TEAMName,
        HeatIndividual.EventID
        FROM
        HeatIndividual
        INNER JOIN Event ON HeatIndividual.EventID = Event.EventID
        INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID
        INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID
        INNER JOIN Team ON HeatIndividual.HeatID = Team.HeatID
        INNER JOIN TeamEntrant ON Team.TeamID = TeamEntrant.TeamID
        LEFT JOIN TeamName ON Team.TeamNameID = TeamName.TeamNameID
        LEFT JOIN Member ON TeamEntrant.MemberID = Member.MemberID
        WHERE
        HeatIndividual.EventID = @EventID AND Team.TeamNameID IS NOT NULL AND TeamEntrant.MemberID IS NOT NULL
        ORDER BY
        HeatIndividual.HeatNum,
        Team.Lane,
        TeamEntrant.Lane
    END;




