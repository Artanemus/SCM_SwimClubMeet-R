USE SwimClubMeet;

DECLARE @SwimClubID AS INT;
SET @SwimClubID = 1;

SELECT [SwimClubID]
     , [NickName]
     , [Caption]
     , [Email]
     , [ContactNum]
     , [WebSite]
     , [HeatAlgorithm]
     , [EnableTeamEvents]
     , [EnableSwimOThon]
     , [EnableExtHeatTypes]
     , [EnableMembershipStr]
     , [NumOfLanes]
     , [LenOfPool]
     , [StartOfSwimSeason]
     , [CreatedOn]
     , [LogoDir]
     , [LogoImg]
     , [LogoType]
FROM [SwimClubMeet].[dbo].[SwimClub]
WHERE [SwimClubID] = @SwimClubID;