SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 28/08/2022
-- Description:	Get the entrants score for a given place.
-- =============================================
ALTER FUNCTION [dbo].[EntrantScore] 
(
	@NomineeID int, 
	@Place int
)
RETURNS float
AS
BEGIN
	DECLARE @Result float;

	WITH CTE_POINTS (NomineeID, Points) 
	AS (

	SELECT NomineeID,
		   CASE
			   WHEN (RaceTime IS NULL) OR (IsDisqualified = 1) OR (IsScratched = 1) THEN 0
			   ELSE
				   ScorePoints.Points
		   END AS Points
	FROM Lane
		INNER JOIN ScorePoints
			ON ScorePoints.Place = @Place
	WHERE NomineeID = @NomineeID)

	SELECT @Result = (SELECT Points FROM CTE_POINTS);

	RETURN @Result

END
GO
