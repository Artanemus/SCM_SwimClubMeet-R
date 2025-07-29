USE SwimClubMeet
GO

/*
 IMPORTANT : Original Entrant table must remain in place.

 An alternative method is to ...
	Rename the Entrant table to dbo.lane.
	Join dbo.Nominee on NomineeID. 
	Modify FKs 
	INSERT missing empty lanes.
 The method given below is perhaps a little easier.
*/

-- Drop temp tables if they exist
IF OBJECT_ID('tempdb..#LaneNumbers') IS NOT NULL
    DROP TABLE #LaneNumbers;
IF OBJECT_ID('tempdb..#CrossProduct') IS NOT NULL
    DROP TABLE #CrossProduct;

DECLARE @NumOfLanes INT;
DECLARE @SwimClubID INT;

SET @NumOfLanes = (
    SELECT NumOfLanes FROM dbo.SwimClub WHERE SwimClubID = 1
);

SET @SwimClubID = (
    SELECT SwimClubID FROM dbo.SwimClub WHERE SwimClubID = 1
);

-- Create and populate lane numbers using ROW_NUMBER()
SELECT TOP (@NumOfLanes) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS LaneNum
INTO #LaneNumbers
FROM sys.objects;

SELECT
    LN.LaneNum,
    H.HeatID,
	H.EventID,
    CAST(0 AS BIT) AS IsDisqualified,
    CAST(0 AS BIT) AS IsScratched
INTO #CrossProduct
FROM dbo.Heat H
CROSS JOIN #LaneNumbers LN;

-- Delete all existing lanes
DELETE FROM dbo.Lane;

-- Reset LaneID identity to start at 1
DBCC CHECKIDENT ('dbo.Lane', RESEED, 0);

-- Insert lanes for each heat from cross product
INSERT INTO dbo.Lane (LaneNum, HeatID, IsDisqualified, IsScratched)
SELECT
    CP.LaneNum,
    CP.HeatID,
    IsDisqualified,
    IsScratched
FROM
    #CrossProduct CP;

-- Assign NomineeID using the original assignment found in legacy table dbo.[Entrant]
UPDATE Lane
SET Lane.NomineeID = Nominee.NomineeID
FROM dbo.Lane
INNER JOIN Heat ON Lane.HeatID = Heat.HeatID
INNER JOIN [Event] ON Heat.EventID = [Event].EventID
INNER JOIN Nominee ON [Event].EventID = Nominee.EventID
INNER JOIN Entrant ON Lane.HeatID = Entrant.HeatID AND Lane.LaneNum = Entrant.Lane
INNER JOIN [Session] ON [Event].SessionID = [Session].SessionID
WHERE Entrant.MemberID = Nominee.MemberID
  AND Lane.NomineeID IS NULL;


UPDATE dbo.Lane
SET Lane.RaceTime = Entrant.RaceTime,
Lane.IsDisqualified = Entrant.IsDisqualified,
Lane.IsScratched = Entrant.IsScratched,
Lane.DisqualifyCodeID = Entrant.DisqualifyCodeID
FROM Lane
INNER JOIN Nominee ON Lane.NomineeID = Nominee.NomineeID
INNER JOIN Entrant ON Lane.HeatID = Entrant.HeatID AND Lane.LaneNum = Entrant.Lane
WHERE Entrant.MemberID = Nominee.MemberID; 

-- Clean up temp tables

DROP TABLE #LaneNumbers;
DROP TABLE #CrossProduct;