USE SwimClubMeet;
--SELECT COUNT(NomineeID) AS COUNT FROM Nominee WHERE MemberID = 1 AND EventID = 1; 

SELECT Count(MemberID) FROM [SwimClubMeet].[dbo].Nominee
INNER JOIN [SwimClubMeet].[dbo].[Event] ON [SwimClubMeet].[dbo].Nominee.EventID = [SwimClubMeet].[dbo].[Event].EventID
WHERE SessionID = 1 AND MemberID = 1;