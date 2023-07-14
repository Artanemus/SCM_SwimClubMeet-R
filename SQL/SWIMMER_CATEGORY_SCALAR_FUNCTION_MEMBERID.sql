USE SwimClubMeet
GO

DECLARE @MemberID AS INTEGER;
SET @MemberID = 1; -- :MEMBERID;

DECLARE @SeedDate AS DATETIME;
SET @SeedDate = GETDATE();

DECLARE @SwimClubID AS INTEGER;
SET @SwimClubID = 1;

DECLARE @SwimClubTypeID AS INTEGER;
SET @SwimClubTypeID = (SELECT @SwimClubTypeID FROM dbo.SwimClub WHERE SwimClubID = @SwimClubID);
IF @SwimClubTypeID IS NULL SET @SwimClubTypeID = 1;

-- Drop a temporary table called '#A'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#A', 'U') IS NOT NULL
    DROP TABLE #A;
-- Create the temporary table from a physical table called 'Member' in schema 'dbo' in database 'SwimClubMeet'
SELECT [MemberID]
     --, [DOB]
     , dbo.SwimmerAge(@SeedDate, member.DOB) AS AGE
     --, [IsArchived]
     --, [IsActive]
     --, [IsSwimmer]
     , [TAGS]
     --, [SwimClubID]
     --, [GenderID]
INTO #A
FROM [SwimClubMeet].[dbo].[Member]
WHERE MemberID = @MemberID AND SwimClubID = @SwimClubID;


-- Drop a temporary table called '#B'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#B', 'U') IS NOT NULL
DROP TABLE #B
GO

-- Create the temporary table from a physical table called 'SwimmerCategory' in schema 'dbo' in database 'SwimClubMeet'
SELECT [SwimmerCategoryID]
     , CASE
           WHEN (SwimmerCategory.TAG IS NULL)
                AND (#A.TAGS IS NULL) THEN
               1 -- IF BOTH ARE NULL - MATCH
           -- If either the expressionToFind or expressionToSearch expression has a NULL value, CHARINDEX returns NULL.
           -- If CHARINDEX does not find expressionToFind within expressionToSearch, CHARINDEX returns 0.
           WHEN (CHARINDEX(SwimmerCategory.TAG, #A.TAGS) > 0) THEN
               1 -- TAG FOUND IN META-DATA
           ELSE
               0 -- NO MATCH
       END AS MATCH
INTO #B       
FROM [dbo].[SwimmerCategory]
    INNER JOIN #A
        ON (AGE >= AgeFrom)
           AND (AGE <= AgeTo)
ORDER BY MATCH DESC; -- MATCHES TO TOP OF LIST

SELECT TOP 1 [SwimmerCategoryID] FROM #B;

