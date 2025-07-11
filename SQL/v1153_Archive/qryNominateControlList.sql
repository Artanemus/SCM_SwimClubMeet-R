USE SwimClubMeet;

DECLARE @MemberID AS integer;
DECLARE @SessionID AS integer;

SET @SessionID = 100;
SET @MemberID = 3;

SELECT EventID
     , [Event].EventNum
     , [Event].SessionID
     , [Event].[EventTypeID]
     , [Event].StrokeID
     , [Event].DistanceID
     , [Event].EventStatusID
     , [Event].Caption
     , dbo.IsMemberNominated(memberid, eventid) AS IsNominated
     , dbo.IsMemberQualified(memberid, GETDATE(), [Event].DistanceID, [Event].StrokeID) AS IsQualified
     , CONCAT(distance.Caption, ' ', stroke.Caption) AS DistStrokeStr
FROM [event]
   , [Member]
   , stroke
   , distance
WHERE Memberid = @MemberID
      AND SessionID = @SessionID
      AND [stroke].StrokeID = [Event].StrokeID
      AND [Distance].DistanceID = [Event].DistanceID
ORDER BY [Event].SessionID
       , [Event].EventNum
