USE SwimClubMeet;

DECLARE @EventID AS INT;
DECLARE @SessionStart AS DATETIME;
DECLARE @Algorithm AS INT;
DECLARE @Calcdefault AS INT;
DECLARE @Percent AS FLOAT;
DECLARE @Age AS INT;
DECLARE @SwimmerCategoryID AS INT;
DECLARE @GenderID AS INT;
DECLARE @SwimClubID AS INT;

/*
if genderid, membershipid and age are o then these filters are ignored
*/
/*
		ds->ParamByName("EVENTID")->AsInteger = EventID;
		ds->ParamByName("SESSIONSTART")->AsDateTime = SCM->GetSessionStart();
		ds->ParamByName("ALGORITHM")->AsDateTime = prefHeatAlgorithm;
		ds->ParamByName("CALCDEFAULT")->AsInteger = prefUseDefRaceTime;
		ds->ParamByName("PERCENT")->AsFloat = prefRaceTimeTopPercent;
*/
SET @EventID = 2; --:EVENTID;--135
SET @SessionStart = GETDATE(); --:SESSIONSTART;-- GETDATE();
SET @Algorithm = 1; --:ALGORITHM;--1
SET @Calcdefault = 1; --:CALCDEFAULT;--1
SET @Percent = 50; --:PERCENT;--50
SET @GenderID = 0; --:GENDERID;--0
SET @SwimmerCategoryID = 0; --:SwimmerCategoryID;--0
SET @Age = 0; --:AGE;--0
SET @SwimClubID = 1;

IF @SessionStart IS NULL
    SET @SessionStart = GETDATE();

IF @SwimmerCategoryID IS NULL
    SET @SwimmerCategoryID = 0;    


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
     , [Nominee].[SeedTime]
     , [Member].[GenderID]
    , dbo.SwimmerAge(@SessionStart, Member.DOB) AS AGE
    , dbo.TimeToBeat(@Algorithm, @Calcdefault, @Percent, [Nominee].[MemberID], [Event].[DistanceID], [Event].[StrokeID], @SessionStart) AS TTB     
    , dbo.MembersSwimmerCategory([Nominee].[MemberID], @SwimClubId, @SessionStart) AS SwimmerCategoryID
    , dbo.PersonalBest([Nominee].[MemberID], [Event].[DistanceID], [Event].[StrokeID], @SessionStart) AS PB
INTO #NomineesInEvent
FROM [SwimClubMeet].[dbo].[Nominee]
    LEFT OUTER JOIN [SwimClubMeet].[dbo].[Member]
        ON [Nominee].[MemberID] = [Member].[MemberID]
    LEFT OUTER JOIN Event
        ON Nominee.EventID = Event.EventID
WHERE ([Nominee].[EventID] = @EventID);      

-- FINALLY
----------------------------------------------------------------------- 
-- FILTER OUT MEMBERS WHO HAVE RACED OR ARE IN HEATS THAT ARE CLOSED.
SELECT NomineeID
    , #NomineesInEvent.MemberID
    , SwimmerCategoryID
    , GenderID
    , AGE
    , PB
    , TTB
-- SEEDTIME IS USED TO INJECT DATA INTO THE ENTRANT RESORD
, SeedTime
-- If we use the TTB value below - it will not get evaluated .... 
--,dbo.TimeToBeat(@Algorithm, @Calcdefault, @Percent, Nominee.MemberID, Event.DistanceID, Event.StrokeID, @SessionStart) AS TTB
FROM #NomineesInEvent
LEFT OUTER JOIN Event
    ON #NomineesInEvent.EventID = Event.EventID
LEFT JOIN #MembersInClosedHeats
    ON #NomineesInEvent.MemberID = #MembersInClosedHeats.MemberID
        AND #NomineesInEvent.EventID = #MembersInClosedHeats.EventID
WHERE #MembersInClosedHeats.MemberID IS NULL
    AND #NomineesInEvent.EventID = @EventID
    AND (
        (
            @GenderID = 0
            AND GenderID > 0
            )
        OR (
            @GenderID > 0
            AND GenderID = @GenderID
            )
        )
    AND (
        (
            @SwimmerCategoryID = 0
            AND (
                (SwimmerCategoryID > 0)
                OR (SwimmerCategoryID IS NULL)
                )
            )
        OR (
            @SwimmerCategoryID > 0
            AND SwimmerCategoryID = @SwimmerCategoryID
            )
        )
    AND (
        (
            @Age = 0
            AND AGE > 0
            )
        OR (
            @Age > 0
            AND AGE = @Age
            )
        )
-- fastest swimmers first, TTB NULL is LAST
ORDER BY
    -- NULL LAST
    CASE 
        WHEN TTB IS NULL
            THEN 1
        ELSE 0
        END
    , TTB ASC;