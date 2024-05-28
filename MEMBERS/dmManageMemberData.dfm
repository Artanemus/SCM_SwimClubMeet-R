object ManageMemberData: TManageMemberData
  OnCreate = DataModuleCreate
  Height = 738
  Width = 897
  object tblContactNumType: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'ContactNumTypeID'
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..ContactNumType'
    TableName = 'SwimClubMeet..ContactNumType'
    Left = 184
    Top = 552
    object tblContactNumTypeContactNumTypeID: TFDAutoIncField
      FieldName = 'ContactNumTypeID'
      Origin = 'ContactNumTypeID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tblContactNumTypeCaption: TWideStringField
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 30
    end
  end
  object tblStroke: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'StrokeID'
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Stroke'
    TableName = 'SwimClubMeet..Stroke'
    Left = 184
    Top = 392
  end
  object tblDistance: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'DistanceID'
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Distance'
    TableName = 'SwimClubMeet..Distance'
    Left = 184
    Top = 440
  end
  object dsMember: TDataSource
    DataSet = qryMember
    Left = 272
    Top = 120
  end
  object qryMember: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    AfterInsert = qryMemberAfterInsert
    AfterPost = qryMemberAfterPost
    BeforeDelete = qryMemberBeforeDelete
    BeforeScroll = qryMemberBeforeScroll
    AfterScroll = qryMemberAfterScroll
    IndexFieldNames = 'SwimClubID'
    MasterSource = dsSwimClub
    MasterFields = 'SwimClubID'
    DetailFields = 'SwimClubID'
    FormatOptions.AssignedValues = [fvStrsTrim2Len]
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ''
      'DECLARE @HideInActive BIT;'
      'DECLARE @HideArchived BIT;'
      'DECLARE @HideNonSwimmers BIT;'
      'DECLARE @SwimClubID INTEGER;'
      ''
      'SET @HideInActive = :HIDE_INACTIVE;'
      'SET @HideArchived = :HIDE_ARCHIVED;'
      'SET @HideNonSwimmers = :HIDE_NONSWIMMERS;'
      'SET @SwimClubID = :SWIMCLUBID; '
      ''
      'SELECT [MemberID],'
      '       [MembershipNum],'
      '       [MembershipStr],'
      '       [FirstName],'
      '       [LastName],'
      '       [DOB],'
      '       [IsActive],'
      '       IsSwimmer,'
      '       IsArchived,'
      '       [Email],'
      '       [GenderID],'
      '       [SwimClubID],'
      
        '       CONCAT(Member.FirstName, '#39' '#39', UPPER(Member.LastName)) AS ' +
        'FName,'
      '       HouseID,'
      '       CreatedOn,'
      '       ArchivedOn,'
      '       TAGS'
      'FROM [dbo].[Member]'
      'WHERE (IsActive >= CASE'
      '                       WHEN @HideInActive = 1 THEN'
      '                           1'
      '                       ELSE'
      '                           0'
      '                   END'
      '      )'
      '      AND (IsArchived <= CASE'
      '                             WHEN @HideArchived = 1 THEN'
      '                                 0'
      '                             ELSE'
      '                                 1'
      '                         END'
      '          )'
      '      AND (IsSwimmer >= CASE'
      '                            WHEN @HideNonSwimmers = 1 THEN'
      '                                1'
      '                            ELSE'
      '                                0'
      '                        END'
      '          )'
      '-- mitigates NULL booleans'
      '      OR'
      '      ('
      '          IsArchived IS NULL'
      '          AND @HideArchived = 0'
      '      )'
      '      OR'
      '      ('
      '          IsActive IS NULL'
      '          AND @HideInActive = 0'
      '      )'
      '      OR'
      '      ('
      '          IsSwimmer IS NULL'
      '          AND @HideNonSwimmers = 0'
      '      );'
      ''
      ''
      ''
      '')
    Left = 200
    Top = 120
    ParamData = <
      item
        Name = 'HIDE_INACTIVE'
        DataType = ftBoolean
        ParamType = ptInput
        Value = False
      end
      item
        Name = 'HIDE_ARCHIVED'
        DataType = ftBoolean
        ParamType = ptInput
        Value = False
      end
      item
        Name = 'HIDE_NONSWIMMERS'
        DataType = ftBoolean
        ParamType = ptInput
        Value = False
      end
      item
        Name = 'SWIMCLUBID'
        DataType = ftAutoInc
        ParamType = ptInput
        Value = 1
      end>
    object qryMemberMemberID: TFDAutoIncField
      Alignment = taCenter
      DisplayLabel = 'ID'
      DisplayWidth = 4
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryMemberMembershipNum: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'Num#'
      DisplayWidth = 4
      FieldName = 'MembershipNum'
      Origin = 'MembershipNum'
    end
    object qryMemberMembershipStr: TWideStringField
      FieldName = 'MembershipStr'
      Origin = 'MembershipStr'
      Size = 24
    end
    object qryMemberFirstName: TWideStringField
      DisplayLabel = 'First Name'
      DisplayWidth = 18
      FieldName = 'FirstName'
      Origin = 'FirstName'
      Size = 128
    end
    object qryMemberLastName: TWideStringField
      DisplayLabel = 'Last Name'
      DisplayWidth = 18
      FieldName = 'LastName'
      Origin = 'LastName'
      Size = 128
    end
    object qryMemberFName: TWideStringField
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Required = True
      Visible = False
      Size = 257
    end
    object qryMemberDOB: TSQLTimeStampField
      DisplayWidth = 12
      FieldName = 'DOB'
      Origin = 'DOB'
      OnGetText = qryMemberDOBGetText
      OnSetText = qryMemberDOBSetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object qryMemberIsActive: TBooleanField
      Alignment = taCenter
      DisplayLabel = 'Active'
      FieldName = 'IsActive'
      Origin = 'IsActive'
    end
    object qryMemberIsSwimmer: TBooleanField
      FieldName = 'IsSwimmer'
      Origin = 'IsSwimmer'
    end
    object qryMemberIsArchived: TBooleanField
      FieldName = 'IsArchived'
      Origin = 'IsArchived'
    end
    object qryMemberEmail: TWideStringField
      DisplayWidth = 50
      FieldName = 'Email'
      Origin = 'Email'
      Size = 256
    end
    object qryMemberSwimClubID: TIntegerField
      FieldName = 'SwimClubID'
      Origin = 'SwimClubID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object qryMemberCreatedOn: TSQLTimeStampField
      FieldName = 'CreatedOn'
      Origin = 'CreatedOn'
    end
    object qryMemberArchivedOn: TSQLTimeStampField
      FieldName = 'ArchivedOn'
      Origin = 'ArchivedOn'
    end
    object qryMemberGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
      Visible = False
    end
    object qryMemberluGender: TStringField
      DisplayLabel = 'Gender'
      DisplayWidth = 12
      FieldKind = fkLookup
      FieldName = 'luGender'
      LookupDataSet = tblGender
      LookupKeyFields = 'GenderID'
      LookupResultField = 'Caption'
      KeyFields = 'GenderID'
      Lookup = True
    end
    object qryMemberluHouse: TStringField
      DisplayLabel = 'House'
      DisplayWidth = 14
      FieldKind = fkLookup
      FieldName = 'luHouse'
      LookupDataSet = tblHouse
      LookupKeyFields = 'HouseID'
      LookupResultField = 'Caption'
      KeyFields = 'HouseID'
      Lookup = True
    end
    object qryMemberHouseID: TIntegerField
      DisplayLabel = 'House'
      DisplayWidth = 14
      FieldName = 'HouseID'
      Origin = 'HouseID'
      Visible = False
    end
    object qryMemberTAGS: TWideMemoField
      FieldName = 'TAGS'
      Origin = 'TAGS'
      BlobType = ftWideMemo
    end
  end
  object tblGender: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'GenderID'
    Connection = SCM.scmConnection
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Gender'
    TableName = 'SwimClubMeet..Gender'
    Left = 184
    Top = 344
  end
  object dsGender: TDataSource
    DataSet = tblGender
    Left = 272
    Top = 392
  end
  object dsHouse: TDataSource
    DataSet = tblHouse
    Left = 272
    Top = 344
  end
  object tblHouse: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HouseID'
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.UpdateTableName = 'SwimClubMeet..House'
    TableName = 'SwimClubMeet..House'
    Left = 184
    Top = 496
  end
  object dsContactNum: TDataSource
    DataSet = qryContactNum
    Left = 136
    Top = 216
  end
  object qryContactNum: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'mcMember_ContactNum'
        Fields = 'MemberID;ContactNumID'
        DescFields = 'ContactNumID'
      end>
    IndexName = 'mcMember_ContactNum'
    MasterSource = dsMember
    MasterFields = 'MemberID'
    DetailFields = 'MemberID'
    UpdateOptions.UpdateTableName = 'SwimClubMeet..ContactNum'
    UpdateOptions.KeyFields = 'ContactNumID'
    SQL.Strings = (
      'USE [SwimClubMeet];'
      ''
      'SELECT ContactNum.ContactNumID'
      #9',ContactNum.Number'
      #9',ContactNum.ContactNumTypeID'
      #9',ContactNum.MemberID'
      'FROM ContactNum;')
    Left = 136
    Top = 160
    object qryContactNumContactNumID: TFDAutoIncField
      FieldName = 'ContactNumID'
      Origin = 'ContactNumID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryContactNumNumber: TWideStringField
      FieldName = 'Number'
      Origin = 'Number'
      Size = 30
    end
    object qryContactNumContactNumTypeID: TIntegerField
      FieldName = 'ContactNumTypeID'
      Origin = 'ContactNumTypeID'
    end
    object qryContactNumMemberID: TIntegerField
      FieldName = 'MemberID'
      Origin = 'MemberID'
    end
    object qryContactNumlu: TStringField
      FieldKind = fkLookup
      FieldName = 'luContactNumType'
      LookupDataSet = tblContactNumType
      LookupKeyFields = 'ContactNumTypeID'
      LookupResultField = 'Caption'
      KeyFields = 'ContactNumTypeID'
      Lookup = True
    end
  end
  object qrySwimClub: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SwimClubID'
    UpdateOptions.UpdateTableName = 'SwimClubMeet..SwimClub'
    UpdateOptions.KeyFields = 'SwimClubID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      ''
      'DECLARE @SwimClubID AS Integer;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'SELECT [SwimClubID],'
      '       [NickName],'
      '       [Caption],'
      '       [Email],'
      '       [ContactNum],'
      '       [WebSite],'
      '       [HeatAlgorithm],'
      '       [EnableTeamEvents],'
      '       [EnableSwimOThon],'
      '       [EnableExtHeatTypes],'
      '       [EnableMembershipStr],'
      '       [NumOfLanes],'
      '       [LenOfPool],'
      '       [StartOfSwimSeason],'
      '       [CreatedOn],'
      
        '       SUBSTRING(CONCAT(SwimClub.Caption, '#39' ('#39', SwimClub.NickNam' +
        'e, '#39')'#39'), 0, 60) AS DetailStr'
      'FROM SwimCLub'
      'WHERE Swimclub.SwimClubID = 1;')
    Left = 200
    Top = 40
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsSwimClub: TDataSource
    DataSet = qrySwimClub
    Left = 272
    Top = 40
  end
  object qryFindMember: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Filter = '(GenderID = 1 OR GenderID = 2) AND (IsActive = TRUE)'
    IndexFieldNames = 'MemberID'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'SELECT        '
      'Member.FirstName'
      ', Member.LastName'
      ', Member.MemberID'
      ', Member.GenderID'
      ', Member.MembershipNum'
      ', FORMAT(Member.DOB, '#39'dd/MM/yyyy'#39') AS dtDOB'
      ', Member.IsActive'
      ', Gender.Caption AS cGender'
      ', Member.IsSwimmer'
      ', CONCAT(UPPER([LastName]), '#39', '#39', Member.FirstName ) AS FName'
      ', DATEDIFF ( year , [DOB], GETDATE() ) AS Age'
      'FROM            Member '
      'LEFT OUTER JOIN'
      
        '                         SwimClub ON Member.SwimClubID = SwimClu' +
        'b.SwimClubID '
      'LEFT OUTER JOIN'
      
        '                         Gender ON Member.GenderID = Gender.Gend' +
        'erID'
      #9#9#9#9#9'ORDER BY Member.LastName')
    Left = 624
    Top = 96
    object qryFindMemberMemberID: TFDAutoIncField
      Alignment = taCenter
      DisplayLabel = '  ID'
      DisplayWidth = 5
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ProviderFlags = [pfInWhere, pfInKey]
      DisplayFormat = '0000'
    end
    object qryFindMemberMembershipNum: TIntegerField
      DisplayLabel = 'Num#'
      DisplayWidth = 6
      FieldName = 'MembershipNum'
      Origin = 'MembershipNum'
      DisplayFormat = '##00'
    end
    object qryFindMemberFName: TWideStringField
      DisplayLabel = 'Member'#39's Name'
      DisplayWidth = 160
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Required = True
      Size = 258
    end
    object qryFindMemberdtDOB: TWideStringField
      Alignment = taCenter
      DisplayLabel = '  DOB'
      DisplayWidth = 11
      FieldName = 'dtDOB'
      Origin = 'dtDOB'
      ReadOnly = True
      Size = 4000
    end
    object qryFindMemberAge: TIntegerField
      Alignment = taCenter
      DisplayWidth = 3
      FieldName = 'Age'
      Origin = 'Age'
      ReadOnly = True
      DisplayFormat = '#0'
    end
    object qryFindMemberIsActive: TBooleanField
      DisplayLabel = 'Active'
      DisplayWidth = 6
      FieldName = 'IsActive'
      Origin = 'IsActive'
    end
    object qryFindMembercGender: TWideStringField
      DisplayLabel = 'Gender'
      DisplayWidth = 7
      FieldName = 'cGender'
      Origin = 'cGender'
    end
    object qryFindMemberFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'FirstName'
      Visible = False
      Size = 128
    end
    object qryFindMemberLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'LastName'
      Visible = False
      Size = 128
    end
    object qryFindMemberGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
      Visible = False
    end
    object qryFindMemberIsSwimmer: TBooleanField
      FieldName = 'IsSwimmer'
      Origin = 'IsSwimmer'
    end
  end
  object dsFindMember: TDataSource
    DataSet = qryFindMember
    Left = 710
    Top = 96
  end
  object qAssertMemberID: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'SELECT MemberID, MembershipNum FROM Member WHERE SwimClubID = 1')
    Left = 624
    Top = 184
  end
  object qryEntrantDataCount: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @MemberID as INTEGER;'
      'SET @MemberID = :MEMBERID; -- 57;'
      ''
      'SELECT Count(EntrantID) as TOT '
      'FROM Entrant '
      'WHERE MemberID = @MemberID AND '
      
        '(RaceTime IS NOT NULL OR (dbo.SwimTimeToMilliseconds(RaceTime) >' +
        ' 0))'
      ';')
    Left = 624
    Top = 248
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 57
      end>
  end
  object cmdFixNullBooleans: TFDCommand
    CommandText.Strings = (
      'USE SwimClubMeet;'
      ''
      'UPDATE [SwimClubMeet].[dbo].[Member]'
      'SET IsActive = CASE'
      '                   WHEN IsActive IS NULL THEN'
      '                       1'
      '                   ELSE'
      '                       IsActive'
      '               END'
      '  , [IsArchived] = CASE'
      '                       WHEN IsArchived IS NULL THEN'
      '                           0'
      '                       ELSE'
      '                           IsArchived'
      '                   END'
      '  , [IsSwimmer] = CASE'
      '                      WHEN IsSwimmer IS NULL THEN'
      '                          1'
      '                      ELSE'
      '                          IsSwimmer'
      '                  END'
      'WHERE IsArchived IS NULL'
      '      OR IsActive IS NULL'
      '      OR IsSwimmer IS NULL'
      ''
      ';')
    ActiveStoredUsage = []
    Left = 624
    Top = 336
  end
  object dsMemberPB: TDataSource
    DataSet = qryMemberPB
    Left = 585
    Top = 496
  end
  object qryMemberPB: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ';'
      ''
      'DECLARE @memberid as int'
      'SET @memberid = :MEMBERID'
      ''
      'SELECT DISTINCT Member.MemberID'
      #9',Distance.DistanceID'
      #9',Stroke.StrokeID'
      
        #9',dbo.PersonalBest(MemberID, DistanceID, StrokeID, GETDATE()) AS' +
        ' PB'
      #9',('
      #9#9'CONCAT ('
      #9#9#9'distance.caption'
      #9#9#9','#39' '#39
      #9#9#9',stroke.caption'
      #9#9#9')'
      #9#9') AS EventStr'
      'FROM Distance'
      'CROSS JOIN Stroke'
      'CROSS JOIN Member'
      
        'WHERE Member.MemberID = @memberid AND dbo.PersonalBest(MemberID,' +
        ' DistanceID, StrokeID, GETDATE()) IS NOT NULL'
      'ORDER BY MemberID'
      #9',DistanceID'
      #9',StrokeID'
      #9',PB ASC'
      ';')
    Left = 497
    Top = 496
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryMemberPBEventStr: TWideStringField
      FieldName = 'EventStr'
      Origin = 'EventStr'
      ReadOnly = True
      Required = True
      Size = 257
    end
    object qryMemberPBPB: TTimeField
      FieldName = 'PB'
      Origin = 'PB'
      ReadOnly = True
      DisplayFormat = 'nn:ss.zzz'
    end
    object qryMemberPBMemberID: TFDAutoIncField
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ProviderFlags = [pfInWhere, pfInKey]
      Visible = False
    end
    object qryMemberPBDistanceID: TFDAutoIncField
      FieldName = 'DistanceID'
      Origin = 'DistanceID'
      Visible = False
    end
    object qryMemberPBStrokeID: TFDAutoIncField
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
      Visible = False
    end
  end
  object qryMemberRoleLnk: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    BeforePost = qryMemberRoleLnkBeforePost
    OnNewRecord = qryMemberRoleLnkNewRecord
    IndexFieldNames = 'MemberID'
    MasterSource = dsMember
    MasterFields = 'MemberID'
    DetailFields = 'MemberID'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.MemberRoleLink'
    UpdateOptions.KeyFields = 'MemberRoleID;MemberID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      '--DECLARE @MemberID AS INTEGER;'
      '--SET @MemberID = 1; --:MEMBERID'
      ''
      'SELECT [MemberRoleLink].[MemberRoleID]'
      '     , [MemberRoleLink].[MemberID]'
      '     , [MemberRoleLink].[CreatedOn]'
      '     , [MemberRoleLink].[IsActive]'
      '     , [MemberRoleLink].[IsArchived]'
      '     , [MemberRoleLink].[StartOn]'
      '     , [MemberRoleLink].[EndOn]'
      '     '
      'FROM MemberRoleLink'
      '    --INNER JOIN [MemberRole]'
      
        '        --ON [MemberRoleLink].[MemberRoleID] = [MemberRole].[Mem' +
        'berRoleID]'
      '--WHERE [MemberRoleLink].[MemberID] = @MemberID;')
    Left = 328
    Top = 160
    object qryMemberRoleLnkMemberRoleID: TIntegerField
      FieldName = 'MemberRoleID'
      Origin = 'MemberRoleID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryMemberRoleLnkMemberID: TIntegerField
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryMemberRoleLnkCreatedOn: TSQLTimeStampField
      FieldName = 'CreatedOn'
      Origin = 'CreatedOn'
    end
    object qryMemberRoleLnkIsActive: TBooleanField
      FieldName = 'IsActive'
      Origin = 'IsActive'
      Required = True
    end
    object qryMemberRoleLnkIsArchived: TBooleanField
      FieldName = 'IsArchived'
      Origin = 'IsArchived'
      Required = True
    end
    object qryMemberRoleLnkluMemberRoleStr: TStringField
      FieldKind = fkLookup
      FieldName = 'luMemberRoleStr'
      LookupDataSet = tblMemberRole
      LookupKeyFields = 'MemberRoleID'
      LookupResultField = 'Caption'
      KeyFields = 'MemberRoleID'
      Required = True
      Lookup = True
    end
    object qryMemberRoleLnkElectedOn: TSQLTimeStampField
      FieldName = 'StartOn'
      Origin = 'ElectedOn'
      OnGetText = qryMemberRoleLnkElectedOnGetText
    end
    object qryMemberRoleLnkRetiredOn: TSQLTimeStampField
      FieldName = 'EndOn'
      Origin = 'RetiredOn'
    end
  end
  object dsMemberRoleLnk: TDataSource
    DataSet = qryMemberRoleLnk
    Left = 328
    Top = 216
  end
  object tblMemberRole: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberRoleID'
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'SwimClubMeet.dbo.MemberRole'
    Left = 184
    Top = 608
  end
  object dsMemberEvents: TDataSource
    DataSet = qryMemberEvents
    Left = 448
    Top = 216
  end
  object qryMemberEvents: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    MasterSource = dsMember
    MasterFields = 'MemberID'
    DetailFields = 'MemberID'
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'EventID'
    SQL.Strings = (
      'SELECT '
      'Event.EventID'
      ',Entrant.MemberID '
      ',Concat(Member.FirstName, '#39' '#39', Member.LastName) AS FName'
      ',Concat(Distance.Caption, '#39' '#39', Stroke.Caption) AS EventStr'
      ',Entrant.RaceTime'
      ', CONVERT(VARCHAR(11), Session.SessionStart, 106) AS EventDate '
      ''
      'FROM Event'
      'INNER JOIN Session ON Event.SessionID = Session.SessionID'
      'INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      'INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      
        'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.Even' +
        'tID'
      'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      'INNER JOIN Member ON Entrant.MemberID = Member.MemberID'
      'WHERE RaceTime IS NOT NULL'
      
        'ORDER BY Session.SessionStart ASC, dbo.Distance.Meters, dbo.Stro' +
        'ke.StrokeID'
      ';')
    Left = 448
    Top = 160
    object qryMemberEventsEventID: TFDAutoIncField
      DisplayWidth = 5
      FieldName = 'EventID'
      Origin = 'EventID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryMemberEventsMemberID: TIntegerField
      DisplayWidth = 5
      FieldName = 'MemberID'
      Origin = 'MemberID'
    end
    object qryMemberEventsFName: TWideStringField
      DisplayWidth = 20
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Required = True
      Size = 257
    end
    object qryMemberEventsEventStr: TWideStringField
      DisplayWidth = 18
      FieldName = 'EventStr'
      Origin = 'EventStr'
      ReadOnly = True
      Required = True
      Size = 257
    end
    object qryMemberEventsRaceTime: TTimeField
      FieldName = 'RaceTime'
      Origin = 'RaceTime'
      DisplayFormat = 'nn:ss.zzz'
    end
    object qryMemberEventsEventDate: TStringField
      FieldName = 'EventDate'
      Origin = 'EventDate'
      ReadOnly = True
      Size = 11
    end
  end
  object qryChart: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime]
    FormatOptions.FmtDisplayDateTime = 'dd/mmm/yyyy'
    SQL.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @StrokeID AS INT;'
      'DECLARE @DistanceID AS INT;'
      'DECLARE @MemberID AS INT;'
      'DECLARE @DoCurrSeason AS BIT;'
      'DECLARE @MaxRecords AS INT;'
      ''
      'SET @StrokeID = :STROKEID;'
      'SET @DistanceID = :DISTANCEID;'
      'SET @MemberID = :MEMBERID;'
      'SET @DoCurrSeason = :DOCURRSEASON;'
      'SET @MaxRecords = :MAXRECORDS;'
      ''
      'IF OBJECT_ID('#39'tempdb..#charttemp'#39') IS NOT NULL'
      '    DROP TABLE #charttemp;'
      '    '
      'IF @MaxRecords IS NULL SET @MaxRecords = 26;'
      ''
      ''
      
        'SELECT TOP (@MaxRecords) [dbo].[SwimTimeToString](Entrant.RaceTi' +
        'me) AS RaceTimeAsString'
      #9',(DATEPART(MILLISECOND, Entrant.RaceTime) / 1000.0) '
      '                + (DATEPART(SECOND, Entrant.RaceTime)) '
      
        '                + (DATEPART(MINUTE, Entrant.RaceTime) * 60.0) AS' +
        ' Seconds'
      ''
      #9',Session.SessionStart'
      #9',Distance.Caption AS cDistance'
      #9',Stroke.Caption AS cStroke'
      ''
      'INTO #charttemp'
      'FROM Entrant'
      
        'INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.Hea' +
        'tID'
      'INNER JOIN Event ON HeatIndividual.EventID = Event.EventID'
      'INNER JOIN Session ON Event.SessionID = Session.SessionID'
      'INNER JOIN SwimClub ON Session.SwimClubID = SwimClub.SwimClubID'
      'INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      'INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      'WHERE (Event.StrokeID = @StrokeID)'
      #9'AND (Event.DistanceID = @DistanceID) '
      '        AND (Entrant.MemberID = @MemberID) '
      '        AND Entrant.RaceTime IS NOT NULL'
      #9#9'-- playing it extra careful'
      #9#9'AND CONVERT(time(0), Entrant.RaceTime) > '#39'00:00:00'#39
      '        AND ('
      
        '           (@DoCurrSeason = 1 AND Session.SessionStart >= SwimCl' +
        'ub.StartOfSwimSeason)'
      '           OR'
      '           (@DoCurrSeason = 0)'
      #9#9' )'
      '        '
      'ORDER BY SessionStart DESC;'
      ''
      'SELECT '
      #9'RaceTimeAsString'
      #9',Seconds'
      #9',SessionStart'
      #9',cDistance'
      #9',cStroke'
      
        ',ROW_NUMBER()OVER (PARTITION BY 1  ORDER BY SessionStart ) AS Ch' +
        'artX'
      'FROM'
      '#charttemp'
      'ORDER BY SessionStart ASC;'
      '')
    Left = 496
    Top = 592
    ParamData = <
      item
        Name = 'STROKEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end
      item
        Name = 'DISTANCEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 9
      end
      item
        Name = 'DOCURRSEASON'
        DataType = ftBoolean
        ParamType = ptInput
        Value = False
      end
      item
        Name = 'MAXRECORDS'
        DataType = ftInteger
        ParamType = ptInput
        Value = 26
      end>
  end
  object dsChart: TDataSource
    DataSet = qryChart
    Left = 560
    Top = 592
  end
  object tblSwimClub: TFDTable
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SwimClubID'
    DetailFields = 'SwimClubID'
    Connection = SCM.scmConnection
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    TableName = 'SwimClubMeet..SwimClub'
    Left = 184
    Top = 672
  end
  object dsluSwimClub: TDataSource
    DataSet = tblSwimClub
    Left = 280
    Top = 672
  end
end
