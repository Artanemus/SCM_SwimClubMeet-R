USE SwimClubMeet;

DECLARE @MemberID AS integer;
DECLARE @SessionID AS integer;

SET @SessionID = 1; ---:SESSIONID; --100;
SET @MemberID = 100; --:MEMBERID; --3;

SELECT EventID
     , [Event].EventNum
     , [Event].SessionID
     , [Event].[EventTypeID]
     , [Event].StrokeID
     , [Event].DistanceID
     , [Event].EventStatusID
     , [Event].Caption
     , CAST(CASE
                WHEN (EXISTS
                      (
                          SELECT NomineeID
                          FROM Nominee
                          WHERE memberid = MemberID
                                AND EventID = EventID
                      )
                     ) THEN
                    1
                ELSE
                    0
            END AS BIT) AS IsNominated
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