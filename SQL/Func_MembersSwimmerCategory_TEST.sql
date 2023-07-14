USE SwimClubMeet
GO

DECLARE @SeedDate AS DATETIME;

SET @SeedDate = GETDATE();

SELECT 
MemberID
, dbo.SwimmerAge(@SeedDate, member.DOB) AS AGE
, dbo.MembersSwimmerCategory(MemberID, 1, @SeedDate) AS CATID

FROM Member
INNER JOIN [dbo].[SwimmerCategory] ON 
