SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 3/8/2019
-- Updated 16/5/2020
-- Description:	Get TimeToBeat 
-- algorithm 1 ... last known racetime
-- =============================================
CREATE FUNCTION [dbo].[TimeToBeat_1_ALT] (
	-- Add the parameters for the function here
	@MemberID INT,
	@DistanceID INT,
	@StrokeID INT,
	@SessionDate DATETIME = NULL
	)
RETURNS TIME
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result TIME

	-- use a default sessiontime
	IF @SessionDate IS NULL
		SET @SessionDate = GETDATE();

	-- Add the T-SQL statements to compute the return value here
	SELECT TOP (1) @Result = Entrant.RaceTime
	FROM Member
    INNER JOIN Entrant ON Member.MemberID = Entrant.MemberID
	INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.HeatID
	INNER JOIN Event ON HeatIndividual.EventID = Event.EventID
	INNER JOIN Session ON Event.SessionID = Session.SessionID
	WHERE (Entrant.RaceTime IS NOT NULL)
		AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020
		AND (Entrant.IsScratched <> 1) -- added 16/5/2020
		AND (Entrant.MemberID = @MEMBERID)
		AND (Session.SessionStart < @SESSIONDATE)
		AND Event.DistanceID = @DISTANCEID
		AND Event.StrokeID = @STROKEID
	ORDER BY Session.SessionStart DESC,
		Entrant.RaceTime ASC

	-- Return the result of the function
	RETURN @Result
END
GO
