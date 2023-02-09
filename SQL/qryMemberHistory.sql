USE SwimClubMeet;
DECLARE @MemberID AS INTEGER
SET @MemberID = 1; --:MEMBERID
DECLARE @SwimClubID AS INTEGER
SET @SwimClubID = 1; --:SWIMCLUBID

SELECT Member.MemberID
     , CONCAT(Distance.Caption, ' ', Stroke.Caption) AS EventStr
     , dbo.SwimTimeToString(RaceTime) AS RT
     , FORMAT(Session.SessionStart, 'ddd dd MMM yyyy') AS EventDate
FROM Member
    LEFT JOIN Entrant
        ON Member.MemberID = Entrant.MemberID
    LEFT JOIN HeatIndividual
        ON Entrant.HeatID = HeatIndividual.HeatID
    LEFT JOIN [Event]
        ON HeatIndividual.EventID = [Event].[EventID]
    LEFT JOIN [Session]
        ON [Event].SessionID = [Session].SessionID
    LEFT JOIN Distance
        ON [Event].[DistanceID] = Distance.DistanceID
    LEFT JOIN Stroke
        ON [Event].[StrokeID] = Stroke.StrokeID
WHERE Member.MemberID = @MemberID
      AND RaceTime IS NOT NULL
      AND IsDisqualified <> 1
      AND IsScratched <> 1
      AND Session.SwimClubID = @SwimClubID
    ORDER BY SessionStart DESC
;
