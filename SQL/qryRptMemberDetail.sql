USE SwimClubMeet;

DECLARE @MemberID AS INT
DECLARE @SwimClubID AS INT

SET @MemberID = NULL; --:MEMBERID
SET @SwimClubID = 1; --:SWIMCLUBID

IF (@MemberID IS NULL)
   OR (@MemberID = 0)
    SELECT Member.MemberID
         , Member.MembershipNum
         , Member.FirstName
         , Member.LastName
         , CONCAT(UPPER(Member.LastName), ', ', Member.FirstName) AS FName
         , Member.DOB
         , Member.IsActive
         , Member.MembershipDue
         , Member.Email
         -- , Member.DoEmailSessionReport
         , Gender.Caption AS GenderStr
         , Member.GenderID
         , Member.SwimClubID
         , Member.MembershipTypeID
         , MembershipType.Caption AS cMembershipTypeStr
         , SwimClub.Caption AS ClubName
         , SwimClub.NickName AS ClubNickName
         , dbo.SwimmerAge(GETDATE(), Member.DOB) AS AGE
    FROM Member
        LEFT OUTER JOIN SwimClub
            ON Member.SwimClubID = SwimClub.SwimClubID
        LEFT OUTER JOIN Gender
            ON Member.GenderID = Gender.GenderID
        LEFT OUTER JOIN MembershipType
            ON Member.MembershipTypeID = MembershipType.MembershipTypeID
        LEFT OUTER JOIN ContactNum
            ON Member.MemberID = ContactNUm.MemberID
    WHERE (Member.SwimClubID = @SwimClubID)
    ORDER BY Member.LastName;
ELSE
    SELECT Member.MemberID
         , Member.MembershipNum
         , Member.FirstName
         , Member.LastName
         , CONCAT(UPPER(Member.LastName), ', ', Member.FirstName) AS FName
         , Member.DOB
         , Member.IsActive
         , Member.MembershipDue
         , Member.Email
         -- , Member.DoEmailSessionReport
         , Gender.Caption AS GenderStr
         , Member.GenderID
         , Member.SwimClubID
         , Member.MembershipTypeID
         , MembershipType.Caption AS cMembershipTypeStr
         , SwimClub.Caption AS ClubName
         , SwimClub.NickName AS ClubNickName
         , dbo.SwimmerAge(GETDATE(), Member.DOB) AS AGE
    FROM Member
        LEFT OUTER JOIN SwimClub
            ON Member.SwimClubID = SwimClub.SwimClubID
        LEFT OUTER JOIN Gender
            ON Member.GenderID = Gender.GenderID
        LEFT OUTER JOIN MembershipType
            ON Member.MembershipTypeID = MembershipType.MembershipTypeID
        LEFT OUTER JOIN ContactNum
            ON Member.MemberID = ContactNUm.MemberID
    WHERE (Member.SwimClubID = @SwimClubID)
    --AND (MemberID = @MemberID)
    ORDER BY Member.LastName;
