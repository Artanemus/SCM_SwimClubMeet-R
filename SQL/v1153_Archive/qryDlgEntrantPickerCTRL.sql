USE SwimClubMeet

DECLARE @EventID INT;
DECLARE @Algorithm INT;
DECLARE @DistanceID INT;
DECLARE @StrokeID INT;
DECLARE @SessionStart DATETIME;
DECLARE @ToggleName BIT;
DECLARE @Order INT;
DECLARE @CalcDefault INT;
DECLARE @BottomPercent FLOAT;
DECLARE @EventType INT;

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
  , GenderID INT
)

IF @EventType = 1
BEGIN
    INSERT INTO #tmpID
    SELECT Entrant.MemberID
         , Member.GenderID
    FROM Entrant
        INNER JOIN HeatIndividual
            ON Entrant.HeatID = HeatIndividual.HeatID
        INNER JOIN Event
            ON HeatIndividual.EventID = Event.EventID
        INNER JOIN Session
            ON Event.SessionID = Session.SessionID
        INNER JOIN Member
            ON Entrant.MemberID = Member.MemberID
    WHERE (HeatIndividual.EventID = @EventID)
          AND (Entrant.MemberID IS NOT NULL);
END
ELSE
BEGIN
    INSERT INTO #tmpID
    SELECT TeamEntrant.MemberID
         , Member.GenderID
    FROM TeamEntrant
        INNER JOIN TEAM
            ON TeamEntrant.TeamID = Team.TeamID
        INNER JOIN HeatIndividual
            ON Team.HeatID = HeatIndividual.HeatID
        INNER JOIN Event
            ON HeatIndividual.EventID = Event.EventID
        INNER JOIN Session
            ON Event.SessionID = Session.SessionID
        INNER JOIN Member
            ON TeamEntrant.MemberID = Member.MemberID
    WHERE (HeatIndividual.EventID = @EventID)
          AND (TeamEntrant.MemberID IS NOT NULL);
END

-- ALL OTHER Members who have not been placed in the current selected event
SELECT Member.MemberID
     , Member.GenderID
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
FROM Member
    LEFT OUTER JOIN #tmpID
        ON #tmpID.MemberID = Member.MemberID
WHERE #tmpID.MemberID IS NULL
      AND Member.IsActive = 1