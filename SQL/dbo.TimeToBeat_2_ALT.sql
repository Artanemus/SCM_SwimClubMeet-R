SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 3/8/2019
-- Updated 16/5/2020
-- 
-- Description:	Get the timeToBeat for a given member
-- Use the average of the 3 fastest race times.
-- =============================================
CREATE FUNCTION [dbo].[TimeToBeat_2_ALT] (
	-- Add the parameters for the function here
	@MemberID INT,
	@DistanceID INT,
	@StrokeID INT,
	@SessionDate DATETIME
	)
RETURNS TIME
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result TIME;
	DECLARE @tmpFloat FLOAT;

	-- very specific criteria 
	-- only pull a short list of racetime 
	-- not ordered
	WITH tmpTable
	AS (
		SELECT TOP (3) [Event].DistanceID,
			[Event].StrokeID,
			Entrant.RaceTime,
			Entrant.MemberID
		FROM Member
        INNER JOIN Entrant ON Member.MemberID = Entrant.MemberID
		INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.HeatID
		INNER JOIN [Event] ON HeatIndividual.EventID = [Event].EventID
		INNER JOIN [Session] ON [Event].SessionID = [Session].SessionID
		WHERE (Entrant.RaceTime IS NOT NULL)
			AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020
			AND (Entrant.IsScratched <> 1) -- added 16/5/2020
			AND (Entrant.MemberID = @MEMBERID)
			AND ([Session].SessionStart < @SESSIONDATE)
			AND [Event].DistanceID = @DISTANCEID
			AND [Event].StrokeID = @STROKEID
		-- ErStudio VALIDATION ERROR - doesn't understand TOP + ORDER BY
		-- ACCEPTED BY MS SQL - TOP is permitted in CTE table when ORDER BY is included
		ORDER BY Entrant.RaceTime ASC
		)
	-- Add the T-SQL statements to compute the return value here
	-- combination of TOP (3) and ORDER BY means AVG works only on the three best racetimes
	SELECT @tmpFloat = avg(CAST(CAST(tmpTable.RaceTime AS DATETIME) AS FLOAT))
	FROM tmpTable

	SET @Result = CAST(CAST(@tmpFloat AS DATETIME) AS TIME)

	-- Return the result of the function
	RETURN @Result
END
GO
