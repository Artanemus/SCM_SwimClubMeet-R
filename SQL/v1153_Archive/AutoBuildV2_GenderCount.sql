USE SwimClubMeet;

DECLARE @EventID AS INT;

SET @EventID = 2; --:EVENTID;


-- LIST OF MEMBERS IN CLOSED OR RACED HEATS (FOR THE CURRENT EVENT)
--------------------------------------------------------------------
-- Drop a temporary table 
IF OBJECT_ID('tempDB..#MembersInClosedHeats', 'U') IS NOT NULL
    DROP TABLE #MembersInClosedHeats;
-- Create the temporary table 
SELECT Event.EventID
     , Entrant.MemberID
INTO #MembersInClosedHeats
FROM [SwimClubMeet].[dbo].[Event]
    INNER JOIN HeatIndividual
        ON Event.EventID = HeatIndividual.EventID
    INNER JOIN Entrant
        ON HeatIndividual.HeatID = Entrant.HeatID
WHERE (
          HeatIndividual.HeatStatusID = 2
          OR HeatIndividual.HeatStatusID = 3
      )
      AND (Entrant.MemberID IS NOT NULL);

-- FINALLY
----------------------------------------------------------------------- 
-- FILTER OUT MEMBERS WHO HAVE RACED OR ARE IN HEATS THAT ARE CLOSED.
SELECT COUNT(Nominee.NomineeID) AS countNominees
     , Member.GenderID
FROM Nominee
    LEFT OUTER JOIN Member
        ON Nominee.MemberID = Member.MemberID
    LEFT OUTER JOIN #MembersInClosedHeats
        ON #MembersInClosedHeats.MemberID = Nominee.MemberID
           AND #MembersInClosedHeats.EventID = Nominee.EventID
WHERE (Nominee.EventID = @EventID)
      AND (#MembersInClosedHeats.MemberID IS NULL)
GROUP BY Member.GenderID
ORDER BY GenderID DESC;
