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
-- 
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
	DECLARE @Ent  INT;
	DECLARE @TeamEnt INT;

	SET @Ent = (SELECT Count(Lane.NomineeID)
	FROM Lane
	INNER JOIN Heat ON Lane.HeatID = Heat.HeatID
	INNER JOIN Event ON Heat.EventID = Event.EventID
	INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID

	WHERE (Lane.NomineeID IS NOT NULL) 
		AND (Lane.NomineeID > 0) 
		AND	(Event.SessionID = @SessionID) 
		AND (Distance.EventTypeID = 1));

	-- Get the number of team entrants
	SET @TeamEnt = (SELECT Count(TeamLink.NomineeID)
	FROM Lane
	INNER JOIN Team ON Lane.TeamID = Team.TeamID
	INNER JOIN TeamLink ON Team.TeamID = TeamLink.TeamID
	INNER JOIN Nominee ON TeamLink.NomineeID = Nominee.NomineeID
	INNER JOIN [Event] ON Nominee.EventID = [Event].EventID
	INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID
	WHERE Lane.TeamID IS NOT NULL 
		AND ([Event].SessionID = @SessionID)
		AND (Distance.EventTypeID = 2)); 

	SET @Result = @Ent + @TeamEnt;

	-- Return the result of the function
	RETURN @Result
END
GO
