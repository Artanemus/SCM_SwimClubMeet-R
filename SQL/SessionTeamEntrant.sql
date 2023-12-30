USE SwimClubMeet

--DECLARE @SID AS INT
--SET @SID = 1; --:SID;


SELECT [TeamEntrantID]
        ,TeamEntrant.TeamID
      ,[Lane]
      ,[RaceTime]
      ,[TimeToBeat]
      ,[PersonalBest]
      ,[IsDisqualified]
      ,[IsScratched]
      ,[DisqualifyCodeID]
      ,[MemberID]
      ,[StrokeID]
      ,[TeamEntrant].[TeamID]
  FROM [SwimClubMeet].[dbo].[TeamEntrant]

SELECT TeamEntrantID
     , TeamEntrant.Lane AS SwimOrder
     , dbo.SwimmerGenderToString(Member.MemberID) AS GENDER
--     , dbo.SwimmerAge(Session.SessionStart, DOB) AS Age
     --, dbo.RaceTimeDIFF(Team.RaceTime, Entrant.PersonalBest) AS DIFF
--     , dbo.SwimTimeToString(Team.RaceTime) AS RaceTime
     --, dbo.SwimTimeToString(Entrant.PersonalBest) AS PersonalBest
     , CONCAT(Member.FirstName, ' ', UPPER(Member.LastName)) AS FNAME
FROM [TeamEntrant]
    INNER JOIN Team ON TeamEntrant.TeamID = Team.TeamID
    LEFT JOIN Member
        ON TeamEntrant.MemberID = Member.MemberID
WHERE Member.MemberID IS NOT NULL AND Team.TeamNameID IS NOT NULL
ORDER BY [TeamEntrant].TeamID, [TeamEntrant].Lane;



