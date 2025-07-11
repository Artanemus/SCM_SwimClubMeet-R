USE SwimClubMeet;

DECLARE @EntA AS INT;
DECLARE @EntB AS INT;

SET @EntA = 10628; --10628;
SET @EntB = 10631; --10368;


IF (@EntA = @EntB)
BEGIN
    GOTO SKIP;
END;


-- Drop a temporary table called '#tmpEntA'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#tmpEntA', 'U') IS NOT NULL
DROP TABLE #tmpEntA;

-- Create the temporary table from a physical table called 'Entrant' in schema 'dbo' in database 'SwimClubMeet'
SELECT TOP 1 *
INTO #tmpEntA
FROM [SwimClubMeet].[dbo].[Entrant]
WHERE EntrantID = @EntA

-- Drop a temporary table called '#tmpEntB'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#tmpEntB', 'U') IS NOT NULL
DROP TABLE #tmpEntB;

-- Create the temporary table from a physical table called 'Entrant' in schema 'dbo' in database 'SwimClubMeet'
SELECT TOP 1 *
INTO #tmpEntB
FROM [SwimClubMeet].[dbo].[Entrant]
WHERE EntrantID = @EntB

IF(NOT EXISTS(SELECT 1 FROM #tmpEntA))
BEGIN
  GOTO SKIP;
END;

IF(NOT EXISTS(SELECT 1 FROM #tmpEntB))
BEGIN
  GOTO SKIP;
END;


UPDATE [SwimClubMeet].[dbo].[Entrant] 
SET
		 [MemberID]=#tmpEntB.MemberID
		,[RaceTime]=#tmpEntB.RaceTime
		,[TimeToBeat]=#tmpEntB.TimeToBeat
		,[PersonalBest]=#tmpEntB.PersonalBest
		,[IsDisqualified]=#tmpEntB.IsDisqualified
		,[IsScratched]=#tmpEntB.IsScratched
FROM Entrant, #tmpEntA, #tmpEntB
WHERE [Entrant].[EntrantID] = @EntA;


UPDATE [SwimClubMeet].[dbo].[Entrant] 
SET
		 [MemberID]=#tmpEntA.MemberID
		,[RaceTime]=#tmpEntA.RaceTime
		,[TimeToBeat]=#tmpEntA.TimeToBeat
		,[PersonalBest]=#tmpEntA.PersonalBest
		,[IsDisqualified]=#tmpEntA.IsDisqualified
		,[IsScratched]=#tmpEntA.IsDisqualified
FROM Entrant, #tmpEntA, #tmpEntB		
WHERE [Entrant].[EntrantID] = @EntB;

SKIP:

