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
-- Author:		Artanemus
-- Create date: 2025-07-16
-- Description:	Calculate a Gender Prefix
-- =============================================
CREATE FUNCTION GenderPrefix 
(
	-- Add the parameters for the function here
	@EventID int
)
RETURNS nvarchar(1)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nvarchar(1)
	DECLARE @Boys int;
	DECLARE @GIRLS int;
	DECLARE @Prefix nvarchar(1);

	SET @Result = '';
	SET @Prefix = '';

	SET @Boys = (SELECT COUNT(NomineeID) 
		FROM dbo.Nominee
		INNER JOIN Member ON Nominee.MemberID = Member.MemberID
		WHERE Member.GenderID = 1 AND EventID = @EventID) ;

	SET @Girls = (SELECT COUNT(NomineeID) 
		FROM dbo.Nominee
		INNER JOIN Member ON Nominee.MemberID = Member.MemberID
		WHERE Member.GenderID = 2 AND EventID = @EventID);

	IF @Boys > 0 AND @Girls > 0
		SET @Prefix = 'X';
	ELSE IF @Boys > 0
		SET @Prefix = 'M';
	ELSE IF @Girls > 0
		SET @Prefix = 'F';
	ELSE
		SET @Prefix = '';


	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = @Prefix;

	-- Return the result of the function
	RETURN @Result

END
GO

