-- ================================================
-- USE [SwimClubMeet]
-- GO

-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Artanemus
-- Create date: 2025/07/31
-- Description:	Signal the gender type of the given event.
-- =============================================
CREATE FUNCTION EventGenderType 
(
	-- Add the parameters for the function here
	@EventID int
)
RETURNS int
AS
BEGIN
    DECLARE @boysCount INT = 0;
    DECLARE @girlsCount INT = 0;
	DECLARE @Result INT = 0;
    -- Single query to get both boys and girls count
    SELECT
        @boysCount = SUM(CASE WHEN Member.GenderID = 1 THEN 1 ELSE 0 END),
        @girlsCount = SUM(CASE WHEN Member.GenderID = 2 THEN 1 ELSE 0 END)
    FROM [SwimClubMeet].[dbo].[Event]
    INNER JOIN Nominee ON [Event].EventID = Nominee.EventID
    INNER JOIN Member ON Nominee.MemberID = Member.MemberID
    WHERE [Event].EventID = @EventID;

    -- Determine the result based on counts
    IF @boysCount > 0 AND @girlsCount > 0
        SET @Result = 0; -- Both boys and girls event
    ELSE IF @boysCount > 0
        SET @Result = 1; -- Boys only event
    ELSE IF @girlsCount > 0
        SET @Result = -1; -- Girls only event
    ELSE
        SET @Result = 0; -- Default case, should not happen if data is consistent

	RETURN @Result; 
END
GO

