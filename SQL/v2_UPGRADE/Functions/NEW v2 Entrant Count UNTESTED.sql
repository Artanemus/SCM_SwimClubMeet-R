SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 13/8/2019
-- Modified on: 05/09/2023 
-- 
-- Description:	Count the number of swimmers for an event.
-- Determines if event is INDV or TEAM.
-- =============================================
ALTER FUNCTION [dbo].[EntrantCount] (
    -- Add the parameters for the function here
    @EventID INT
    )
RETURNS INT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result INT;
	DECLARE @EventTypeID  INT;

	SET @EventTypeID = (SELECT EventTypeID FROM dbo.[Event] INNER JOIN [Distance] ON [Event].DistanceID = Distance.DistanceID WHERE [Event].EventID = @EventID);
	SET @Result = 0;

	--IF @EventTypeID IS NULL RETURN @Result; 

	IF ((@EventTypeID IS NULL) OR (@EventTypeID = 0)) SET @EventTypeID = 1; 

	IF @EventTypeID = 1
	BEGIN
		SELECT @Result = COUNT(DISTINCT Lane.NomineeID)
		FROM dbo.Lane
		INNER JOIN Nominee ON Lane.NomineeID = Nominee.NomineeID
		WHERE Nominee.MemberID IS NOT NULL
		AND Nominee.EventID = @EventID
	END;

	ELSE IF @EventTypeID = 2
	BEGIN
		SELECT @Result = COUNT(DISTINCT TeamLink.NomineeID)
		FROM dbo.TeamLink
		INNER JOIN Nominee ON TeamLink.NomineeID = Nominee.NomineeID
		INNER JOIN Lane ON TeamLink.TeamID = Lane.TeamID
		WHERE Nominee.EventID = @EventID
		AND Lane.TeamID IS NOT NULL
	END;

    -- Return the result of the function
    RETURN @Result;

END
GO
