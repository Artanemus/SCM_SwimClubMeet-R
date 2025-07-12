SET IDENTITY_INSERT [dbo].[PoolType] ON;

INSERT INTO [dbo].[PoolType]
(
    [PoolTypeID]
  , [Caption]
  , [ShortCaption]
  , [ABREV]
  , [LenOfPool]
  , [IsArchived]
  , [IsActive]
)
VALUES
(1, N'Short Course Meters', 'ShortCourse', N'SCM',25.0, 0, 1)
, (2, N'Long Course', 'LongCourse', N'LCM',50.0, 0, 1)
, (3, N'Short Course Yards', 'ShortCourseY', N'SCY',22.86, 0, 1)
, (4, N'Long Course Yards', 'LongCourseY', N'LSCY', 100.584, 0, 1)
GO

SET IDENTITY_INSERT [dbo].[PoolType] OFF;