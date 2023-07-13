USE SwimClubMeet;

DECLARE @SeedDate AS DATETIME;
SET @SeedDate = GETDATE();

-- Drop a temporary table called '#MemberAge'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#MemberAge', 'U') IS NOT NULL
DROP TABLE #MemberAge
;
-- CURRENTLY ON ONE TAG KNOWN - COMPETITIVE
SELECT MemberID
    , dbo.SwimmerAge(@SeedDate, member.DOB) AS AGE
    , CASE 
    WHEN (CHARINDEX('COMPETITIVE',Member.TAG ) > 0)  THEN 1 -- COMPETITIVE (case insensitive)
    ELSE 2
    END AS TAG 
    , CASE 
    WHEN (CHARINDEX('COMPETITIVE',[SwimmerCategory].[ABREV] ) > 0)  THEN 1 
    ELSE 2
    END AS TAG2     
    , SwimmerCategoryID
    , AgeFrom 
,CASE WHEN AgeTo IS NULL THEN 99 ELSE AgeTO END AS AgeTo  
INTO #MemberAge
FROM [SwimClubMeet].[dbo].[Member], [SwimmerCategory];

-- Assign a swimming category to each member based on age and TAG
SELECT MemberID, SwimmerCategoryID
FROM [#MemberAge]
WHERE (AGE >= AgeFrom) AND (AGE <= AgeTo) AND (TAG = TAG2)
GROUP BY MemberID, SwimmerCategoryID


