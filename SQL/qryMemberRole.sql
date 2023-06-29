SET IDENTITY_INSERT [dbo].[MemberRole] ON
GO

INSERT INTO [dbo].[MemberRole]
(
    MemberRoleID
  , [Caption]
  , [IsActive]
  , [IsArchived]
)
VALUES
(1, 'President', 1, 0)
, (2, 'Vice President', 1, 0)
, (3, 'Secretary', 1, 0)
, (4, 'Registrar', 1, 0)
, (5, 'Treasurer', 1, 0)
, (6, 'Race Secretary', 1, 0)
, (7, 'Committee Member', 1, 0)
, (8, 'Volunteer Coordinator', 1, 0)
, (9, 'Public Officer', 1, 0)
, (10, 'Swimmer', 1, 0)
, (11, 'Parent', 1, 0)
, (12, 'Coach')
, (13, 'Life Member', 1, 0)
, (14, 'Misc. Contact', 1, 0)
GO

SET IDENTITY_INSERT [dbo].[MemberRole] OFF
GO

