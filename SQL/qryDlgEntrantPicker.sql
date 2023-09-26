USE SwimClubMeet;

DECLARE @EventID AS INT;
DECLARE @Algorithm INT;
DECLARE @DistanceID AS INT;
DECLARE @StrokeID AS INT;
DECLARE @SessionStart DATETIME;
DECLARE @ToggleName BIT;
DECLARE @Order INT;
DECLARE @CalcDefault INT;
DECLARE @BottomPercent FLOAT;
DECLARE @EventType AS INT;

SET @EventID = 10; --:EVENTID;
SET @Algorithm = 1; --:ALGORITHM;
SET @ToggleName = 1; --:TOGGLENAME;
SET @CalcDefault = 1; --:CALCDEFAULT
SET @BottomPercent = 50; --:BOTTOMPERCENT
SET @EventType = 1; --:EVENTTYPE

SET @DistanceID =
(
    SELECT DistanceID FROM Event WHERE Event.EventID = @EventID
);
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
  --,TeamEntrant.TeamEntrantID AS ID
  , EventID INT
)

-- Members given a swimming lane in the given event 
IF @EventType = 1
BEGIN
    INSERT INTO #tmpID
    SELECT Entrant.MemberID
         --,Entrant.EntrantID  AS ID
         , HeatIndividual.EventID
    FROM [SwimClubMeet].[dbo].[HeatIndividual]
        INNER JOIN Entrant
            ON Entrant.HeatID = HeatIndividual.HeatID
    WHERE HeatIndividual.EventID = @EventID;
END
ELSE
BEGIN

    INSERT INTO #tmpID
    SELECT TeamEntrant.MemberID
         --,TeamEntrant.TeamEntrantID AS ID
         , HeatIndividual.EventID
    FROM [SwimClubMeet].[dbo].[HeatIndividual]
        INNER JOIN Team
            ON HeatIndividual.HeatID = Team.HeatID
        INNER JOIN TeamEntrant
            ON Team.TeamID = TeamEntrant.TeamID
    WHERE HeatIndividual.EventID = @EventID;
END


SELECT Nominee.EventID
     , Nominee.MemberID
     , Member.GenderID
     --,tmpID.ID
     , dbo.SwimmerAge(@SessionStart, Member.DOB) AS AGE
     , dbo.SwimmerGenderToString(Member.MemberID) AS Gender
     , dbo.TimeToBeat(@Algorithm, @CalcDefault, @BottomPercent, Member.MemberID, @DistanceID, @StrokeID, @SessionStart) AS TTB
     , dbo.PersonalBest(Member.MemberID, @DistanceID, @StrokeID, @SessionStart) AS PB
     , CASE
           WHEN @ToggleName = 0 THEN
               SUBSTRING(CONCAT(UPPER([LastName]), ', ', [FirstName]), 0, 30)
           WHEN @ToggleName = 1 THEN
               SUBSTRING(CONCAT([FirstName], ', ', UPPER([LastName])), 0, 48)
       END AS FName
FROM Nominee
    LEFT OUTER JOIN #tmpID
        ON #tmpID.MemberID = Nominee.MemberID
    LEFT OUTER JOIN Member
        ON Nominee.MemberID = Member.MemberID
WHERE Nominee.EventID = @EventID
      AND #tmpID.MemberID IS NULL;
