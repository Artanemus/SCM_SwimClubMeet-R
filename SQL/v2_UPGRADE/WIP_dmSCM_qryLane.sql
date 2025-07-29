USE [SwimClubMeet]
GO

SELECT [LaneID]
      ,[LaneNum]
      ,[Lane].[RaceTime]
      ,[ClubRecord]
      ,[IsDisqualified]
      ,[IsScratched]
      ,[HeatID]
      ,[DisqualifyCodeID]
      ,[Lane].[TeamID]
      ,[Lane].[NomineeID]

     , CASE
           WHEN [Lane].[NomineeID] IS NOT NULL THEN
               CONCAT(
                        Member.FirstName
                       , ' '
                       , UPPER(Member.LastName)
                     )
           WHEN [Lane].[TeamID] IS NOT NULL THEN
           Team.TeamName

       END AS FullName
       , CASE

           WHEN [Lane].[NomineeID] IS NOT NULL THEN
               CONCAT(
				'('
                    ,     FORMAT(Nominee.AGE, '00')
                       , '.'
                       , dbo.SwimmerGenderToString(Nominee.MemberID)
					   ,')'
                     )
           WHEN [Lane].[TeamID] IS NOT NULL THEN
           Team.ABBREV

       END AS Stat
       
  FROM [dbo].[Lane]
  LEFT JOIN Nominee ON Lane.NomineeID = Nominee.NomineeID
  LEFT JOIN [Member] ON Nominee.MemberID = [Member].Memberid
  LEFT JOIN [Team] ON Lane.Teamid = Team.teamid

GO


