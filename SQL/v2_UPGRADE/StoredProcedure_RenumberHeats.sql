SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Artanemus
-- Create date: 2025/06/12
-- Description:	Renumber heats for a given EventID
-- =============================================
CREATE PROCEDURE dbo.RenumberHeats
    @EventID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;

    -- Use a cursor to iterate through ordered heats
    DECLARE HeatCursor CURSOR FOR
        SELECT HeatID
        FROM SwimClubMeet2.dbo.Heat
        WHERE EventID = @EventID
        ORDER BY 
            CASE WHEN HeatNum IS NULL THEN 0 ELSE 1 END, 
            HeatNum ASC;

    DECLARE @HeatID INT;

    OPEN HeatCursor;
    FETCH NEXT FROM HeatCursor INTO @HeatID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE SwimClubMeet2.dbo.Heat
        SET HeatNum = @i
        WHERE HeatID = @HeatID;

        SET @i = @i + 1;
        FETCH NEXT FROM HeatCursor INTO @HeatID;
    END

    CLOSE HeatCursor;
    DEALLOCATE HeatCursor;
END

GO

