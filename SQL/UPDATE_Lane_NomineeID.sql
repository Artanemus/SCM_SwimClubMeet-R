USE SwimClubMeet
GO

SELECT LaneID,
	[Session].SessionID,
	[Event].EventNum,
	Heat.HeatNum,
	Lane.LaneNum,
	Lane.NomineeID,
	[Nominee].NomineeID
FROM dbo.Lane
INNER JOIN Heat on Lane.HeatID = Heat.HeatID
INNER JOIN [Event] on Heat.EventID = [Event].EventID
INNER JOIN Nominee on [Event].EventID = Nominee.EventID
INNER JOIN Entrant on Lane.HeatID = Entrant.HeatID AND Lane.LaneNum = Entrant.Lane
INNER JOIN [Session] on [Event].SessionID = [Session].SessionID 
WHERE Entrant.MemberID = Nominee.MemberID -- AND [Session].SessionID = 139
ORDER BY [Session].SessionID, [Event].EventID, Heat.HeatID, LaneNum 


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
-- AND [Session].SessionID = 139 -- Uncomment to filter by session if needed