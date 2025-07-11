USE SwimClubMeet;

DECLARE @EventID AS INT;
DECLARE @SwimClubID AS INT;
DECLARE @SeedDate AS DATETIME;

SET @EventID = 2; --:EVENTID;
SET @SwimCLubID = 1;

IF @SeedDate IS NULL
    SET @SeedDate = GETDATE();

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


-- LIST OF ALL NOMINEES FOR THE GIVEN EVENT AND THEIR SWIMMER CATEGORY 
--------------------------------------------------------------------
-- Drop a temporary table 
IF OBJECT_ID('tempDB..#NomineesInEvent', 'U') IS NOT NULL
    DROP TABLE #NomineesInEvent;
-- Create the temporary table
SELECT [Nominee].[NomineeID]
     , [Nominee].[EventID]
     , [Nominee].[MemberID]
     , [Member].[GenderID]
     , dbo.MembersSwimmerCategory([Member].[MemberID], @SwimClubId, @SeedDate) AS SwimmerCategoryID
INTO #NomineesInEvent
FROM [SwimClubMeet].[dbo].[Nominee]
    LEFT OUTER JOIN [SwimClubMeet].[dbo].[Member]
        ON [Nominee].[MemberID] = [Member].[MemberID]
WHERE ([Nominee].[EventID] = @EventID);


-- FINALLY
----------------------------------------------------------------------- 
-- FILTER OUT MEMBERS WHO HAVE RACED OR ARE IN HEATS THAT ARE CLOSED.
-- return count, CAT and gender.
SELECT COUNT(#NomineesInEvent.NomineeID) AS countNominees
     , #NomineesInEvent.SwimmerCategoryID
     , #NomineesInEvent.GenderID
FROM #NomineesInEvent
    LEFT OUTER JOIN #MembersInClosedHeats
        ON #NomineesInEvent.MemberID = #MembersInClosedHeats.MemberID
           AND #NomineesInEvent.EventID = #MembersInClosedHeats.EventID
WHERE (#NomineesInEvent.EventID = @EventID)
      AND (#MembersInClosedHeats.MemberID IS NULL)
GROUP BY SwimmerCategoryID
       , #NomineesInEvent.GenderID
ORDER BY GenderID DESC
       , SwimmerCategoryID DESC;



