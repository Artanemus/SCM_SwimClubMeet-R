USE SwimClubMeet;

DECLARE @HeatID INT;
SET @HeatID = 1295;
-- Drop a temporary table called '#tmpheat'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#tmpheat', 'U') IS NOT NULL
DROP TABLE #tmpheat
;
-- Create the temporary table from a physical table called 'HeatID' in schema 'dbo' in database 'SwimClubMeet'
SELECT HeatID, HeatNum, EventID
INTO #tmpheat
FROM [SwimClubMeet].[dbo].[HeatIndividual]
WHERE [HeatID] = @HeatID;

SELECT [HeatIndividual].[HeatID] 
FROM [HeatIndividual] INNER JOIN #tmpheat on [HeatIndividual].[EventID] = #tmpheat.[EventID]
WHERE [HeatIndividual].[HeatNum] = #tmpheat.HeatNum + 1;