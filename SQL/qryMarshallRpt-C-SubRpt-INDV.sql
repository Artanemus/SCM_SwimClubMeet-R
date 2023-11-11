USE SwimClubMeet;

SELECT 
		[Entrant].[HeatID]
		,[Entrant].[EntrantID]
		,[Entrant].[Lane] AS lane
        , CONCAT(Member.FirstName, ' ', UPPER(Member.LastName)) AS FNAME
		,[Entrant].[RaceTime]
		,[Entrant].[TimeToBeat]
		,[Entrant].[IsDisqualified]
		,[Entrant].[IsScratched]
		,[Entrant].[DisqualifyCodeID]
FROM [SwimClubMeet].[dbo].[Entrant] 
INNER JOIN [SwimClubMeet].[dbo].Member ON Entrant.MemberID = Member.MemberID
ORDER BY HeatID, [Entrant].[Lane]