USE [SwimClubMeet]
GO
/****** Object:  UserDefinedFunction [dbo].[SessionEntrantCount]    Script Date: 05/09/23 2:07:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 15/11/2019
-- Modified on: 05/09/2023
--
-- Description:	Count the number of swimmers for the session.
-- Determines if the event is INDV or TEAM.
-- =============================================
ALTER FUNCTION [dbo].[SessionEntrantCount] (
	-- Add the parameters for the function here
	@SessionID INT
	)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result INT
	DECLARE @EventTypeID  INT;

	SET @EventTypeID = (SELECT EventTypeID FROM dbo.[Event] 
		INNER JOIN [Distance] ON [Event].DistanceID = Distance.DistanceID 
		WHERE [Event].SessionID = @SessionID);

	SET @Result = 0;

	IF @EventTypeID IS NULL RETURN @Result; 

	IF @EventTypeID = 1
	BEGIN
		SELECT @Result = Count(Entrant.MemberID)
		FROM Entrant
		INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.HeatID
		INNER JOIN Event ON HeatIndividual.EventID = Event.EventID
		WHERE (Event.SessionID = @SessionID) AND
			(Entrant.MemberID IS NOT NULL) AND (Entrant.MemberID > 0)
	END;
	ELSE IF @EventTypeID = 2
	BEGIN
		SELECT @Result = Count(TeamEntrant.MemberID)
		FROM TeamEntrant
		INNER JOIN Team ON TeamEntrant.TeamID = Team.TeamID
		INNER JOIN HeatIndividual ON Team.HeatID = HeatIndividual.HeatID
		INNER JOIN Event ON HeatIndividual.EventID = Event.EventID
		WHERE (Event.SessionID = @SessionID) AND
			(TeamEntrant.MemberID IS NOT NULL) AND (TeamEntrant.MemberID > 0)
	END;

	-- Add the T-SQL statements to compute the return value here

	-- Return the result of the function
	RETURN @Result
END
