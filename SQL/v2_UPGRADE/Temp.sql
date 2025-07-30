USE [SwimClubMeet]
go

-- Role Alter SQL

CREATE ROLE SCM_Guest AUTHORIZATION dbo
go
CREATE ROLE SCM_Administrator AUTHORIZATION dbo
go
CREATE ROLE SCM_Marshall AUTHORIZATION dbo
go

-- Alter Procedure SQL

GRANT EXECUTE ON dbo.IsMemberQualified TO SCM_Administrator
go
GRANT EXECUTE ON dbo.IsMemberQualified TO SCM_Guest
go
GRANT EXECUTE ON dbo.IsMemberQualified TO SCM_Marshall
go
EXEC sp_rename 'EntrantScore','EntrantSco_07302025052956000',OBJECT
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 28/08/2022
-- Modified on: 30/07/2025
-- Description:	Get the entrants score for a given place.
-- =============================================
CREATE FUNCTION [dbo].[EntrantScore] 
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
go
IF OBJECT_ID('dbo.EntrantScore') IS NOT NULL
     DROP FUNCTION dbo.EntrantSco_07302025052956000
ELSE 
     EXEC sp_rename 'EntrantSco_07302025052956000','EntrantScore',OBJECT
go
GRANT EXECUTE ON dbo.EntrantScore TO SCM_Administrator
go
GRANT EXECUTE ON dbo.EntrantScore TO SCM_Guest
go
GRANT EXECUTE ON dbo.EntrantScore TO SCM_Marshall
go
GRANT EXECUTE ON dbo.EntrantScore TO SCM_Administrator
go
GRANT EXECUTE ON dbo.EntrantScore TO SCM_Guest
go
GRANT EXECUTE ON dbo.EntrantScore TO SCM_Marshall
go
SET QUOTED_IDENTIFIER OFF
go
SET ANSI_NULLS OFF
go
IF EXISTS (select * from syscomments where id = object_id('dbo.EventGenderType') and texttype & 4 = 0)
BEGIN
    DROP FUNCTION dbo.EventGenderType
    IF OBJECT_ID('dbo.EventGenderType') IS NOT NULL
        PRINT '<<< FAILED DROPPING FUNCTION dbo.EventGenderType >>>'
    ELSE
        PRINT '<<< DROPPED FUNCTION dbo.EventGenderType >>>'
END
go
CREATE FUNCTION dbo.EventGenderType(@AEventID INT)
RETURNS INT
AS
BEGIN
    DECLARE @boysCount INT = 0;
    DECLARE @girlsCount INT = 0;

    -- Single query to get both boys and girls count
    SELECT
        @boysCount = SUM(CASE WHEN M.GenderID = 1 THEN 1 ELSE 0 END),
        @girlsCount = SUM(CASE WHEN M.GenderID = 2 THEN 1 ELSE 0 END)
    FROM [SwimClubMeet].[dbo].[Event] E
    INNER JOIN Heat HI ON E.EventID = HI.EventID
    INNER JOIN Entrant En ON HI.HeatID = En.HeatID
    INNER JOIN Member M ON En.MemberID = M.MemberID
    WHERE E.EventID = @AEventID;

    -- Determine the result based on counts
    IF @boysCount > 0 AND @girlsCount > 0
        RETURN 0; -- Both boys and girls event
    ELSE IF @boysCount > 0
        RETURN 1; -- Boys only event
    ELSE IF @girlsCount > 0
        RETURN -1; -- Girls only event
    ELSE
        RETURN 0; -- Default case, should not happen if data is consistent
END
go
IF OBJECT_ID('dbo.EventGenderType') IS NOT NULL
    PRINT '<<< CREATED FUNCTION dbo.EventGenderType >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION dbo.EventGenderType >>>'
go
SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
