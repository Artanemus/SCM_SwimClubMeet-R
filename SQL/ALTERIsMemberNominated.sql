SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ben Ambrose
-- Create date: 25/05/2022
-- Description:	Is the member nominated for the event
-- =============================================
ALTER FUNCTION [dbo].[IsMemberNominated]
(
    -- Add the parameters for the function here
    @MemberID INT
  , @EventID INT
)
RETURNS BIT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result BIT;
    DECLARE @Count AS INTEGER;

    SELECT @Count =
    (
        SELECT COUNT(dbo.nominee.NomineeID) AS NOM
        FROM Nominee
        WHERE memberid = @MemberID
              AND EventID = @EventID
    );

    IF @Count = 0
        SELECT @Result = 0;
    ELSE
        SELECT @Result = 1;

    -- Return the result of the function
    RETURN @Result

END
GO
