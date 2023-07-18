USE SwimClubMeet;

DECLARE @EventID AS INT;
DECLARE @SwimClubID AS INT;
DECLARE @SeedDate AS DATETIME;

SET @EventID = 2; --:EVENTID;
SET @SwimCLubID = 1;
SET @SeedDate = GETDATE();

-- Produces a list of nominees current not assigned a lane 
-- excludes members already placed in CLOSED Heats
-- excludes members in raced heats

-- Drop a temporary table called '#MembersInClosedHeats'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#MembersInClosedHeats', 'U') IS NOT NULL
    DROP TABLE #MembersInClosedHeats;
-- Create the temporary table from a 
-- physical table called 'Event' in schema 'dbo' in database 'SwimClubMeet'
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

SELECT COUNT(Nominee.NomineeID) AS countNominees
     , dbo.MembersSwimmerCategory(Member.MemberID, @SwimClubId, @SeedDate) AS SwimmerCategoryID
     , Member.GenderID
FROM Nominee
    LEFT OUTER JOIN Member
        ON Nominee.MemberID = Member.MemberID
    LEFT OUTER JOIN #MembersInClosedHeats
        ON #MembersInClosedHeats.MemberID = Nominee.MemberID
           AND #MembersInClosedHeats.EventID = Nominee.EventID
WHERE (Nominee.EventID = @EventID)
      AND (#MembersInClosedHeats.MemberID IS NULL)
GROUP BY dbo.MembersSwimmerCategory(Member.MemberID, @SwimClubId, @SeedDate)
       , Member.GenderID
ORDER BY GenderID DESC
       , SwimmerCategoryID DESC



