USE SwimClubMeet;

DECLARE @HeatID as integer;

SET @HeatID = :HEATID;

SELECT
  Event.EventID,
  Event.Caption AS cEvent,
  Distance.Caption AS cDistance,
  Stroke.Caption AS cStroke,
  HeatIndividual.HeatNum,
HeatIndividual.HeatID,
  Entrant.Lane,
  Concat(Member.FirstName, ' ', Upper(Member.LastName)) AS FNAME,
Format(CAST(Entrant.RaceTime AS DATETIME), 'mm:ss.fff') AS RaceTime,
Format(CAST(Entrant.TimeToBeat AS DATETIME), 'mm:ss.fff') AS TimeToBeat,

CASE CAST([Entrant].[PersonalBest] AS DATETIME)
       WHEN NULL THEN ''
       WHEN 0 THEN ''
       ELSE Format(CAST([Entrant].[PersonalBest] AS DATETIME), 'mm:ss.fff')
       END AS PersonalBest,

-- Format(CAST(Entrant.PersonalBest AS DATETIME), 'mm:ss.fff') AS PersonalBest,
  Entrant.IsDisqualified,
  Entrant.IsScratched,
  Event.EventNum,
  Session.SessionStart,
  SwimClub.NickName,
  SwimClub.Caption AS cSwimClub,
Event.SessionID
FROM
  Event
  INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID
  INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID
  INNER JOIN HeatIndividual ON HeatIndividual.EventID = Event.EventID
  INNER JOIN Entrant ON Entrant.HeatID = HeatIndividual.HeatID
  LEFT JOIN Member ON Entrant.MemberID = Member.MemberID
  INNER JOIN Session ON Event.SessionID = Session.SessionID
  INNER JOIN SwimClub ON Session.SwimClubID = SwimClub.SwimClubID
WHERE
  HeatIndividual.HeatID = @HeatID
ORDER BY
  Event.EventNum,
  HeatIndividual.HeatNum,
  Entrant.Lane