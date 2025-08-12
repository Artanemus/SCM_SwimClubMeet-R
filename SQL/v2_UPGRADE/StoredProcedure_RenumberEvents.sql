SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Artanemus
-- Create date: 2025/06/12
-- Description:	Renumber events for a given SessionID
-- =============================================
CREATE PROCEDURE dbo.RenumberEvents
    @SessionID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;

    DECLARE EventCursor CURSOR FOR
        SELECT EventID
        FROM SwimClubMeet2.dbo.Event
        WHERE SessionID = @SessionID
        ORDER BY 
            CASE WHEN EventNum IS NULL THEN 0 ELSE 1 END,
            EventNum ASC;

    DECLARE @EventID INT;

    OPEN EventCursor;
    FETCH NEXT FROM EventCursor INTO @EventID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE SwimClubMeet2.dbo.Event
        SET EventNum = @i
        WHERE EventID = @EventID;

        SET @i = @i + 1;
        FETCH NEXT FROM EventCursor INTO @EventID;
    END

    CLOSE EventCursor;
    DEALLOCATE EventCursor;
END

GO
