USE SwimClubMeet;

DECLARE @EventID AS INT;

SET @EventID = 1; --:EVENTID;

/*
The CHARINDEX() function searches for a substring in a string, and returns the position. 
If the substring is not found, this function returns 0. 
Note: This function performs a case-insensitive search.
*/

-- Produces a list of nominees current not assigned a lane 
-- excludes members already placed in CLOSED Heats
-- excludes members in raced heats
-- 
-- Define the CTE expression name and column list.
WITH MembersInClosedHeats_CTE (
	EventID
	,MemberID
	)
AS (
	SELECT Event.EventID
		,Entrant.MemberID
	FROM Event
	INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.EventID
	INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID
	WHERE (
			HeatIndividual.HeatStatusID = 2
			OR HeatIndividual.HeatStatusID = 3
			)
		AND (Entrant.MemberID IS NOT NULL)
	)
SELECT 
	COUNT(Nominee.NomineeID) AS countNominees
	,Member.METADATA
	,Member.GenderID
FROM Nominee
LEFT OUTER JOIN Member ON Nominee.MemberID = Member.MemberID
LEFT OUTER JOIN MembersInClosedHeats_CTE AS MembersInClosedHeats_CTE_1 ON MembersInClosedHeats_CTE_1.MemberID = Nominee.MemberID
	AND MembersInClosedHeats_CTE_1.EventID = Nominee.EventID
WHERE (Nominee.EventID = @EventID)
	AND (MembersInClosedHeats_CTE_1.MemberID IS NULL)
GROUP BY Member.MembershipTypeID, Member.GenderID
ORDER BY GenderID DESC, MembershipTypeID DESC 