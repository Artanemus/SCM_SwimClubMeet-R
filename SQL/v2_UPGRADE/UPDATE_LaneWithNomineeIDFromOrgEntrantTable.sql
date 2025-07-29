USE SwimClubMeet
GO

UPDATE Lane
SET Lane.NomineeID = Nominee.NomineeID
FROM dbo.Lane
INNER JOIN Heat ON Lane.HeatID = Heat.HeatID
INNER JOIN [Event] ON Heat.EventID = [Event].EventID
INNER JOIN Nominee ON [Event].EventID = Nominee.EventID
INNER JOIN Entrant ON Lane.HeatID = Entrant.HeatID AND Lane.LaneNum = Entrant.Lane
INNER JOIN [Session] ON [Event].SessionID = [Session].SessionID
WHERE Entrant.MemberID = Nominee.MemberID
  AND Lane.NomineeID IS NULL