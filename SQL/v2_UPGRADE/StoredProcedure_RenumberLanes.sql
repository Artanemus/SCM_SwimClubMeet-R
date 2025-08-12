SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Artanemus
-- Create date: 2025/06/12
-- Description:	Renumber lanes for a given HeatID
-- =============================================
CREATE PROCEDURE dbo.RenumberLanes
    @HeatID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;

    DECLARE LaneCursor CURSOR FOR
        SELECT LaneID
        FROM SwimClubMeet2.dbo.Lane
        WHERE HeatID = @HeatID
        ORDER BY 
            CASE WHEN LaneNum IS NULL THEN 0 ELSE 1 END,
            LaneNum ASC;

    DECLARE @LaneID INT;

    OPEN LaneCursor;
    FETCH NEXT FROM LaneCursor INTO @LaneID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE SwimClubMeet2.dbo.Lane
        SET LaneNum = @i
        WHERE LaneID = @LaneID;

        SET @i = @i + 1;
        FETCH NEXT FROM LaneCursor INTO @LaneID;
    END

    CLOSE LaneCursor;
    DEALLOCATE LaneCursor;
END
