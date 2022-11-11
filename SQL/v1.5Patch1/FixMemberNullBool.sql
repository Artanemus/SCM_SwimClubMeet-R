USE SwimClubMeet;

UPDATE [SwimClubMeet].[dbo].[Member]
SET IsActive = CASE
                   WHEN IsActive IS NULL THEN
                       1
                   ELSE
                       IsActive
               END
  , [IsArchived] = CASE
                       WHEN IsArchived IS NULL THEN
                           0
                       ELSE
                           IsArchived
                   END
  , [IsSwimmer] = CASE
                      WHEN IsSwimmer IS NULL THEN
                          1
                      ELSE
                          IsSwimmer
                  END
WHERE IsArchived IS NULL
      OR IsActive IS NULL
      OR IsSwimmer IS NULL