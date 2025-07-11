USE SwimClubMeet;

SELECT 
		[Team].[HeatID]
		,[Team].[TeamID]
		,[Team].[TeamNameID]
		,[TeamEntrant].[TeamEntrantID]
		,[Team].[Lane] AS lane
        ,[TeamName].Caption AS cTeamName
        ,[TeamEntrant].[Lane] AS SwimOrder
        , CONCAT(Member.FirstName, ' ', UPPER(Member.LastName)) AS FNAME
		,[Team].[RaceTime]
		,[Team].[TimeToBeat]
		,[Team].[IsDisqualified]
		,[Team].[IsScratched]
		,[Team].[DisqualifyCodeID]
FROM [SwimClubMeet].[dbo].[Team] 
INNER JOIN [SwimClubMeet].[dbo].TeamEntrant ON Team.TeamID = TeamEntrant.TeamID
LEFT JOIN [SwimClubMeet].[dbo].TeamName ON Team.TeamNameID = TeamName.TeamNameID
INNER JOIN [SwimClubMeet].[dbo].Member ON TeamEntrant.MemberID = Member.MemberID
ORDER BY HeatID, [Team].[Lane], [TeamEntrant].[Lane]

