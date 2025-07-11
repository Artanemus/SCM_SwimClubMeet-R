USE SwimClubMeet

DECLARE @EventID AS INT
DECLARE @SessionStart AS DATETIME

SET @EventID = 2; --:EVENTID;
SET @SessionStart = NULL; --:SESSIONSTART;

IF @SessionStart IS NULL
	SET @SessionStart = GETDATE();

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

-- LIST OF ALL NOMINEES FOR THE GIVEN EVENT AND THEIR PERSONAL DATA
--------------------------------------------------------------------
-- Drop a temporary table 
IF OBJECT_ID('tempDB..#NomineesInEvent', 'U') IS NOT NULL
    DROP TABLE #NomineesInEvent;
-- Create the temporary table
SELECT [Nominee].[NomineeID]
     , [Nominee].[EventID]
     , [Nominee].[MemberID]
     ,[Member].[DOB]
    , dbo.SwimmerAge(@SessionStart, [Member].[DOB]) AS AGE
INTO #NomineesInEvent
FROM [SwimClubMeet].[dbo].[Nominee]
    LEFT OUTER JOIN [SwimClubMeet].[dbo].[Member]
        ON [Nominee].[MemberID] = [Member].[MemberID]
WHERE ([Nominee].[EventID] = @EventID); 

-- FINALLY
----------------------------------------------------------------------- 
-- FILTER OUT MEMBERS WHO HAVE RACED OR ARE IN HEATS THAT ARE CLOSED.
SELECT 
	COUNT(NomineeID) AS countNominees
	,AGE
FROM #NomineesInEvent
LEFT OUTER JOIN #MembersInClosedHeats ON #MembersInClosedHeats.MemberID = #NomineesInEvent.MemberID
	AND #MembersInClosedHeats.EventID = #NomineesInEvent.EventID
WHERE (#NomineesInEvent.EventID = @EventID)
	AND (#MembersInClosedHeats.MemberID IS NULL)
GROUP BY AGE
ORDER BY AGE ASC
