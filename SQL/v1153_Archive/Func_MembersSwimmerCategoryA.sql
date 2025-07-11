SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ben Ambrose
-- Create date: 13/07/2023
-- Description:	Get the Swimming CATEGORY of the MEMBER
-- =============================================
CREATE OR ALTER FUNCTION [dbo].[MembersSwimmerCategory] 
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

    DECLARE @SwimClubTypeID AS INTEGER;
    SET @SwimClubTypeID = (SELECT @SwimClubTypeID FROM dbo.SwimClub WHERE SwimClubID = @SwimClubID);
    IF @SwimClubTypeID IS NULL SET @SwimClubTypeID = 1;    

	    -- Declare the table variable
    DECLARE @A TABLE (MemberID INT, AGE INT, TAGS nvarchar(max));
	DECLARE @B TABLE (ID INT, aMATCH INT);

    -- Insert data into the table variable
    INSERT INTO @A (MemberID, AGE, TAGS) 
    SELECT 
		[MemberID]
		, dbo.SwimmerAge(@SeedDate, member.DOB) AS AGE
		, [TAGS]

	FROM [SwimClubMeet].[dbo].[Member]
	WHERE MemberID = @MemberID AND SwimClubID = @SwimClubID	;


	INSERT INTO @B (ID, aMATCH)
	SELECT 
		[dbo].[SwimmerCategory].[SwimmerCategoryID] AS ID
		, CASE
            -- IF BOTH ARE NULL - MATCH
			WHEN (SwimmerCategory.TAG IS NULL)
				AND (TAGS IS NULL) THEN
				1 
            -- TAG FOUND IN META-DATA                
			-- If either the expressionToFind or expressionToSearch expression has a NULL value, CHARINDEX returns NULL.
			-- If CHARINDEX does not find expressionToFind within expressionToSearch, CHARINDEX returns 0.
			WHEN (CHARINDEX(SwimmerCategory.TAG, TAGS) > 0) THEN
				1 
			ELSE
				0 -- NO MATCH
		END AS aMATCH 

		FROM [dbo].[SwimmerCategory]
            
			INNER JOIN @A
				ON (AGE >= AgeFrom)
				   AND (AGE <= AgeTo)
        WHERE [dbo].[SwimmerCategory].[SwimClubID] = @SwimClubID
		-- Ordering here fails !!! ???


	SELECT TOP (1)  @Result = ID FROM @B  WHERE aMATCH = 1 ORDER BY aMATCH DESC; 


	-- Return the result of the function
	RETURN @Result

END
GO
