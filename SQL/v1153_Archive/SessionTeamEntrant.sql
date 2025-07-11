USE SwimClubMeet
;

SELECT [TeamEntrant].[TeamEntrantID]
        , [TeamEntrant].[TeamID]
      , [TeamEntrant].[Lane]
      , [TeamEntrant].[RaceTime] AS SplitTime
      , [TeamEntrant].[TimeToBeat]
      , [TeamEntrant].[PersonalBest]
      , [TeamEntrant].[IsDisqualified]
      , [TeamEntrant].[IsScratched]
      , [TeamEntrant].[DisqualifyCodeID]
      , [TeamEntrant].[MemberID]
      , [StrokeID]
      , [TeamEntrant].[TeamID]
     , TeamEntrant.Lane AS SwimOrder
     , dbo.SwimmerGenderToString(Member.MemberID) AS GENDER
--     , dbo.SwimmerAge(Session.SessionStart, DOB) AS Age
     , dbo.RaceTimeDIFF(TeamEntrant.RaceTime, TeamEntrant.PersonalBest) AS DIFF
     , dbo.SwimTimeToString(TeamEntrant.RaceTime) AS SplitTimeStr
     , dbo.SwimTimeToString(TeamEntrant.PersonalBest) AS PersonalBestStr
     , CONCAT(Member.FirstName, ' ', UPPER(Member.LastName)) AS FNAME

FROM [SwimClubMeet].[dbo].[TeamEntrant]
    INNER JOIN Team ON TeamEntrant.TeamID = Team.TeamID
    LEFT JOIN Member
    ON TeamEntrant.MemberID = Member.MemberID
WHERE Member.MemberID IS NOT NULL AND Team.TeamNameID IS NOT NULL
ORDER BY [TeamEntrant].TeamID, [TeamEntrant].Lane;



