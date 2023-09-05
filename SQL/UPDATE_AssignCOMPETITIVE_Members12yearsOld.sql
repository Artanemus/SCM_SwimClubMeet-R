Use SwimClubMeet
GO
-- TO AID IN DEBUGGING AUTO-BUILD GROUP BY SWIMMERCATEGORY
-- Assign COMPETITIVE to members aged 12 years

-- CHECK WHERE
SELECT MemberID
, dbo.SwimmerAge(GETDATE(), [Member].DOB) AS DOB
, TAGS
FROM [Member]
WHERE 
dbo.SwimmerAge(GETDATE(), [Member].DOB) = 12
AND (TAGS IS NULL OR [Member].TAGS NOT LIKE '%COMP%');

-- MODIFY RECORDS
UPDATE [Member] 
SET TAGS = 'COMPETITIVE'
WHERE 
dbo.SwimmerAge(GETDATE(), [Member].DOB) = 12
AND (TAGS IS NULL OR [Member].TAGS NOT LIKE '%COMP%');

-- CHECK ALL DONE?
SELECT MemberID
, dbo.SwimmerAge(GETDATE(), [Member].DOB) AS DOB
, TAGS
FROM [Member]
WHERE 
dbo.SwimmerAge(GETDATE(), [Member].DOB) = 12;