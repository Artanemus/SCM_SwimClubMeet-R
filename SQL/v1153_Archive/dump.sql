--USE SwimClubMeet
--GO

DECLARE @EventID AS INT;
DECLARE @Algorithm INT;
DECLARE @DistanceID AS INT;
DECLARE @StrokeID AS INT;
DECLARE @SessionStart DATETIME;
DECLARE @ToggleName BIT;
DECLARE @Order INT;
DECLARE @CalcDefault INT;
DECLARE @BottomPercent FLOAT;
DECLARE @TopNumber INT;

DECLARE @SQL NVARChar(MAX);


SET @EventID = :EVENTID;
SET @Algorithm = :ALGORITHM;
SET @ToggleName = :TOGGLENAME;
SET @CalcDefault = :CALCDEFAULT;
SET @BottomPercent = :BOTTOMPERCENT;
SET @DistanceID = :XDISTANCEID;
SET @TopNumber = :TOPNUMBER;

SET @StrokeID =
(
    SELECT StrokeID FROM Event WHERE Event.EventID = @EventID
);

SET @SessionStart =
(
    SELECT Session.SessionStart
    FROM Event
        INNER JOIN Session
            ON Event.SessionID = Session.SessionID
    WHERE Event.EventID = @EventID
);


-- Drop a temporary table called '#tmpID'
IF OBJECT_ID('tempDB..#tmpID', 'U') IS NOT NULL
    DROP TABLE #tmpID;

CREATE TABLE #tmpID
(
    MemberID INT
)

-- Members given a swimming lane in the given event 

    INSERT INTO #tmpID
    SELECT TeamEntrant.MemberID
    FROM [SwimClubMeet].[dbo].[HeatIndividual]
        INNER JOIN Team
            ON HeatIndividual.HeatID = Team.HeatID
        INNER JOIN TeamEntrant
            ON Team.TeamID = TeamEntrant.TeamID
    WHERE HeatIndividual.EventID = @EventID
    AND HeatIndividual.HeatStatusID = 1;
    
    
-- Construct dynamic SQL

SELECT TOP (@TopNumber) 
Nominee.NomineeID,
    Nominee.EventID,
    Nominee.MemberID,
    Member.GenderID,
    dbo.SwimmerAge(@SessionStart, Member.DOB) AS AGE,
    dbo.SwimmerGenderToString(Nominee.MemberID) AS Gender,
    dbo.TimeToBeat(@Algorithm, @CalcDefault, @BottomPercent, Nominee.MemberID, @DistanceID, @StrokeID, @SessionStart) AS xTTB,
    dbo.PersonalBest(Nominee.MemberID, @DistanceID, @StrokeID, @SessionStart) AS xPB,
    CASE 
        WHEN @ToggleName = 0 THEN SUBSTRING(CONCAT(UPPER([LastName]), ' ', [FirstName]), 0, 30)
        WHEN @ToggleName = 1 THEN SUBSTRING(CONCAT([FirstName], ' ', UPPER([LastName])), 0, 48)
    END AS FName
FROM Nominee
LEFT OUTER JOIN #tmpID ON #tmpID.MemberID = Nominee.MemberID
LEFT OUTER JOIN Member ON Nominee.MemberID = Member.MemberID
WHERE Nominee.EventID = @EventID
AND #tmpID.MemberID IS NULL
ORDER BY TTB ASC;
   
 
      
