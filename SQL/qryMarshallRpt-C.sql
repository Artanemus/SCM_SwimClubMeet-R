USE SwimClubMeet;

DECLARE @EventID AS integer;

SET @EventID = 65; --:EVENTID;


    SELECT HeatIndividual.HeatID
         , HeatIndividual.HeatNum
         , CONCAT(Distance.Caption, ' ', Stroke.Caption) AS cDistanceStroke
         , Event.EventNum
         , FORMAT(Event.EventNum, '00') AS EventNumStr
         , Event.Caption AS cEvent
         , '' AS TeamName
         , 0 AS TeamNameID
         , HeatIndividual.EventID
    FROM HeatIndividual
        INNER JOIN Event
            ON HeatIndividual.EventID = Event.EventID
        INNER JOIN Distance
            ON Event.DistanceID = Distance.DistanceID
        INNER JOIN Stroke
            ON Event.StrokeID = Stroke.StrokeID
    WHERE HeatIndividual.EventID = @EventID
    ORDER BY HeatIndividual.HeatNum
