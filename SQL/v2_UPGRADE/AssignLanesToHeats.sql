USE SwimClubMeet
GO

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

-- Create temporary table for lane numbers
CREATE TABLE #LaneNumbers (LaneNum INT);

-- Insert lane numbers 1 to @NumOfLanes
DECLARE @i INT = 1;
WHILE @i <= @NumOfLanes
BEGIN
    INSERT INTO #LaneNumbers (LaneNum) VALUES (@i);
    SET @i = @i + 1;
END;

-- Create temporary table for cross product
CREATE TABLE #CrossProduct (
    LaneNum INT,
    HeatID INT,
    IsDisqualified BIT,
    IsScratched BIT
);

-- Insert cross product of heats and lane numbers
INSERT INTO #CrossProduct (LaneNum, HeatID, IsDisqualified, IsScratched)
SELECT
    LN.LaneNum,
    H.HeatID,
    0 AS IsDisqualified,
    0 AS IsScratched
FROM
    dbo.Heat H
    CROSS JOIN #LaneNumbers LN;

-- Uncomment the following line to see the cross product result
-- This is useful for debugging purposes
-- SELECT * FROM #CrossProduct;


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

-- Clean up temp tables
DROP TABLE #LaneNumbers;
DROP TABLE #CrossProduct;