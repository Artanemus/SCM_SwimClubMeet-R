-- ================================================
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
-- Author:		Ben Ambrose
-- Create date: 13/07/2023
-- Description:	Get the Swimming CAT of the MEMBER
-- =============================================
CREATE FUNCTION SwimmerCategoryOfMember 
(
	-- Add the parameters for the function here
	@MemberID int
	,@SwimClubID int
	,@SeedDate DateTime
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int;

	IF @SwimClubID IS NULL SET @SwimClubID = 1;

	IF @SeedDate IS NULL SET @SeedDate = GETDATE();

	SET @Result = 0;

	IF @MemberID IS NULL RETURN @Result;

	    -- Declare the table variable
    DECLARE @A TABLE (MemberID INT, AGE INT, TAGS nvarchar(max));
	DECLARE @B TABLE (CategoryID INT, aMATCH INT);

    -- Insert data into the table variable
    INSERT INTO @A (MemberID, AGE, TAGS) 
    SELECT 
		[MemberID]
		, dbo.SwimmerAge(@SeedDate, member.DOB) AS AGE
		, [TAGS]

	FROM [SwimClubMeet].[dbo].[Member]
	WHERE MemberID = @MemberID AND SwimClubID = @SwimClubID	;


	INSERT INTO @B (CategoryID, aMATCH)
	SELECT 
		[dbo].[SwimmerCategory].[SwimmerCategoryID]
		, CASE
			WHEN (SwimmerCategory.TAG IS NULL)
				AND (TAGS IS NULL) THEN
				1 -- IF BOTH ARE NULL - MATCH
			-- If either the expressionToFind or expressionToSearch expression has a NULL value, CHARINDEX returns NULL.
			-- If CHARINDEX does not find expressionToFind within expressionToSearch, CHARINDEX returns 0.
			WHEN (CHARINDEX(SwimmerCategory.TAG, TAGS) > 0) THEN
				1 -- TAG FOUND IN META-DATA
			ELSE
				0 -- NO MATCH
		END AS aMATCH 

		FROM [dbo].[SwimmerCategory]
			INNER JOIN @A
				ON (AGE >= AgeFrom)
				   AND (AGE <= AgeTo)
		ORDER BY aMATCH DESC;


	SELECT TOP (1)  @Result = CategoryID FROM @B;


	-- Return the result of the function
	RETURN @Result

END
GO

