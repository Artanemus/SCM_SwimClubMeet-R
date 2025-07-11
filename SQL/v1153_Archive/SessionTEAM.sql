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
     , Team.Lane
     , TeamName.Caption AS TeamNameStr
     , dbo.SwimmerGenderToString(Member.MemberID) AS GENDER
     , dbo.SwimmerAge(Session.SessionStart, DOB) AS Age
     --, dbo.RaceTimeDIFF(Team.RaceTime, Entrant.PersonalBest) AS DIFF
     , dbo.SwimTimeToString(Team.RaceTime) AS RaceTime
     --, dbo.SwimTimeToString(Entrant.PersonalBest) AS PersonalBest
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
    INNER JOIN Team
        ON Team.HeatID = HeatIndividual.HeatID
    INNER JOIN TeamName
        ON TeamName.TeamNameID = Team.TeamNameID
    INNER JOIN TeamEntrant
        ON TeamEntrant.TeamID = Team.TeamID
    LEFT JOIN Member
        ON TeamEntrant.MemberID = Member.MemberID
WHERE (Session.SessionID = @SID)
      AND Member.MemberID IS NOT NULL
      AND Team.TeamNameID IS NOT NULL
ORDER BY EventNum
       , HeatNum
       , Lane;
