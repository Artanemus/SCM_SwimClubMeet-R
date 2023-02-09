USE SwimClubMeet;

DECLARE @MemberID AS INT
DECLARE @SwimClubID AS INT

SET @MemberID = 1 -- :MEMBERID
SET @SwimClubID = 1 -- :SWIMCLUBID

    SELECT Member.MemberID
         , Member.MembershipNum
         , Member.FirstName
         , Member.LastName
         , CONCAT(Member.FirstName, ' ',  UPPER(Member.LastName) ) AS FName
         , Member.DOB
         , Member.IsActive
         , Member.MembershipDue
         , Member.Email
         -- , Member.DoEmailSessionReport
         , Gender.Caption AS GenderStr
         , Member.GenderID
         , Member.SwimClubID
         , SwimClub.Caption AS ClubName
         , SwimClub.NickName AS ClubNickName
         , dbo.SwimmerAge(GETDATE(), Member.DOB) AS AGE
, Member.CreatedOn
    FROM Member
        LEFT OUTER JOIN SwimClub
            ON Member.SwimClubID = SwimClub.SwimClubID
        LEFT OUTER JOIN Gender
            ON Member.GenderID = Gender.GenderID
    WHERE 
 -- (Member.SwimClubID = @SwimClubID) AND 
 (Member.MemberID = @MemberID)
    ORDER BY Member.LastName;