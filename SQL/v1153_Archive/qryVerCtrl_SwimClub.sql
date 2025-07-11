Use SwimClubMeet;

DECLARE @SwimClubID AS INT;
SET @SwimClubID = 1; --:SWIMCLUBID

DECLARE @Major AS INT;
SET @Major = (SELECT Major FROM SwimClubMeet.dbo.SCMSystem WHERE SCMSystemID = 1);
DECLARE @Minor AS INT;
SET @Minor = (SELECT Major FROM SwimClubMeet.dbo.SCMSystem WHERE SCMSystemID = 1);

-- Drop a temporary table called '#TableName'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#TempSCMSwimClub', 'U') IS NOT NULL
DROP TABLE #TempSCMSwimClub
;

/* Get the data into a temp table */
    SELECT * INTO #TempSCMSwimClub
    FROM 
    SwimClub WHERE @SwimClubID = @SwimClubID;

/*
VERSION 1,1,5,0 AND 1,1,5,1 COMPATABILITY
*/

IF (@Major = 5) AND ((@Minor = 0) OR (@Minor = 1))
BEGIN
	/* Drop the columns that are not needed */
	IF COL_LENGTH('SwimClub','LogoDir') IS NOT NULL
	BEGIN
	/* Column does exist */
		ALTER TABLE #TempSCMSwimClub
		DROP COLUMN LogoDir
	END
	IF COL_LENGTH('SwimClub','LogoImg') IS NOT NULL
	BEGIN
	/* Column does exist */
		ALTER TABLE #TempSCMSwimClub
		DROP COLUMN LogoImg
	END
	IF COL_LENGTH('SwimClub','LogoType') IS NOT NULL
	BEGIN
	/* Column does exist */
		ALTER TABLE #TempSCMSwimClub
		DROP COLUMN LogoType
	END
END

SELECT * from #TempSCMSwimClub;