USE [SwimClubMeet]
GO
/****** Object:  UserDefinedFunction [dbo].[EntrantCount]    Script Date: 05/09/23 2:12:44 PM ******/
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

	IF @EventTypeID IS NULL RETURN @Result; 

	IF @EventTypeID = 1
	BEGIN
		SELECT @Result = Count(Entrant.EntrantID)
		FROM Entrant
		INNER JOIN HeatIndividual
			ON Entrant.HeatID = HeatIndividual.HeatID
		WHERE (Entrant.MemberID IS NOT NULL) AND (Entrant.MemberID > 0)
		GROUP BY HeatIndividual.EventID
		HAVING HeatIndividual.EventID = @EventID
	END;

	ELSE IF @EventTypeID = 2
	BEGIN
		SELECT @Result = Count(TeamEntrant.TeamEntrantID)
		FROM TeamEntrant
		INNER JOIN Team
			ON TeamEntrant.TeamID = Team.TeamID
		INNER JOIN HeatIndividual
			ON Team.HeatID = HeatIndividual.HeatID
		WHERE (TeamEntrant.MemberID IS NOT NULL) AND (TeamEntrant.MemberID > 0)
		GROUP BY HeatIndividual.EventID
		HAVING HeatIndividual.EventID = @EventID
	END;

    -- Return the result of the function
    RETURN @Result;

END
