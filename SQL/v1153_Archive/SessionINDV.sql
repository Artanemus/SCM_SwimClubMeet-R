USE SwimClubMeet;

DECLARE @SID AS INT
SET @SID = 1; --:SID;


SELECT Session.SessionID
     , Event.EventID
     , Event.Caption AS cEvent
     , CAST(Session.SessionStart AS DATE) AS SessionDate
     , SUBSTRING(Stroke.Caption, 0, 16) AS StrokeStr
     , SUBSTRING(Distance.Caption, 0, 10) AS DistanceStr
     , Event.EventNum
     , HeatIndividual.HeatNum
     , Entrant.Lane
     , dbo.SwimmerGenderToString(Member.MemberID) AS GENDER
     , dbo.SwimmerAge(Session.SessionStart, DOB) AS Age
     , dbo.RaceTimeDIFF(Entrant.RaceTime, Entrant.PersonalBest) AS DIFF
     , dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTime
     , dbo.SwimTimeToString(Entrant.PersonalBest) AS PersonalBest
     , CONCAT(Member.FirstName, ' ', UPPER(Member.LastName)) AS FNAME
FROM [Session]
    INNER JOIN [Event]
        ON [Session].SessionID = [Event].[SessionID]
    INNER JOIN [HeatIndividual]
        ON [Event].[EventID] = [HeatIndividual].EventID
    INNER JOIN Distance
        ON Event.DistanceID = Distance.DistanceID
    INNER JOIN Stroke
        ON Event.StrokeID = Stroke.StrokeID
    INNER JOIN Entrant
        ON Entrant.HeatID = HeatIndividual.HeatID
    LEFT JOIN Member
        ON Entrant.MemberID = Member.MemberID
WHERE (Session.SessionID = @SID)
      AND Member.MemberID IS NOT NULL
ORDER BY EventNum
       , HeatNum
       , Lane
;
