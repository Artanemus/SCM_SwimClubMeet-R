object ManageMemberData: TManageMemberData
  OnCreate = DataModuleCreate
  Height = 639
  Width = 665
  object tblContactNumType: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'ContactNumTypeID'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..ContactNumType'
    TableName = 'SwimClubMeet..ContactNumType'
    Left = 56
    Top = 496
    object tblContactNumTypeContactNumTypeID: TFDAutoIncField
      FieldName = 'ContactNumTypeID'
      Origin = 'ContactNumTypeID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
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
    Left = 56
    Top = 400
  end
  object tblDistance: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'DistanceID'
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Distance'
    TableName = 'SwimClubMeet..Distance'
    Left = 56
    Top = 448
  end
  object dsMember: TDataSource
    DataSet = qryMember
    Left = 160
    Top = 120
  end
  object qryMember: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    AfterInsert = qryMemberAfterInsert
    BeforeDelete = qryMemberBeforeDelete
    AfterDelete = qryMemberAfterDelete
    AfterScroll = qryMemberAfterScroll
    IndexFieldNames = 'SwimClubID;MemberID'
    MasterSource = dsSwimClub
    MasterFields = 'SwimClubID'
    DetailFields = 'SwimClubID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvStrsTrim2Len]
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'SwimClubID;MemberID'
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
      '       dbo.SwimmerAge(GETDATE(), [DOB]) AS SwimmerAge,'
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
      '       ABREV,'
      '       METADATA'
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
    Left = 56
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
      ReadOnly = True
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
      DisplayFormat = 'dd/mm/yyyy'
    end
    object qryMemberSwimmerAge: TIntegerField
      DisplayLabel = 'Age'
      DisplayWidth = 4
      FieldName = 'SwimmerAge'
      Origin = 'SwimmerAge'
      ReadOnly = True
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
    object qryMemberABREV: TWideStringField
      FieldName = 'ABREV'
      Origin = 'ABREV'
      Size = 13
    end
    object qryMemberMETADATA: TWideMemoField
      FieldName = 'METADATA'
      Origin = 'METADATA'
      OnGetText = qryMemberMETADATAGetText
      OnSetText = qryMemberMETADATASetText
      BlobType = ftWideMemo
    end
  end
  object tblGender: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'GenderID'
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Gender'
    TableName = 'SwimClubMeet..Gender'
    Left = 56
    Top = 352
  end
  object dsGender: TDataSource
    DataSet = tblGender
    Left = 160
    Top = 352
  end
  object dsHouse: TDataSource
    DataSet = tblHouse
    Left = 160
    Top = 304
  end
  object tblHouse: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HouseID'
    UpdateOptions.UpdateTableName = 'SwimClubMeet..House'
    TableName = 'SwimClubMeet..House'
    Left = 56
    Top = 304
  end
  object dsContactNum: TDataSource
    DataSet = qryContactNum
    Left = 160
    Top = 168
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
    Left = 56
    Top = 168
    object qryContactNumContactNumID: TFDAutoIncField
      FieldName = 'ContactNumID'
      Origin = 'ContactNumID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
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
    Left = 56
    Top = 72
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
    Left = 160
    Top = 72
  end
  object qryFindMember: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Filter = '(GenderID = 1 OR GenderID = 2) AND (IsActive = TRUE)'
    IndexFieldNames = 'MemberID'
    Connection = SCM.scmConnection
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
    Left = 400
    Top = 80
    object qryFindMemberMemberID: TFDAutoIncField
      Alignment = taCenter
      DisplayLabel = '  ID'
      DisplayWidth = 5
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
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
    Left = 486
    Top = 80
  end
  object qAssertMemberID: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    SQL.Strings = (
      'SELECT MemberID, MembershipNum FROM Member WHERE SwimClubID = 1')
    Left = 400
    Top = 168
  end
  object qryEntrantDataCount: TFDQuery
    ActiveStoredUsage = [auDesignTime]
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
      'SELECT Count(EntrantID) as TOT FROM Entrant WHERE'
      
        'MemberID = @MemberID AND (RaceTime IS NOT NULL OR (dbo.SwimTimeT' +
        'oMilliseconds(RaceTime) > 0));')
    Left = 400
    Top = 232
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
    Left = 400
    Top = 320
  end
  object dsMemberPB: TDataSource
    DataSet = qryMemberPB
    Left = 489
    Top = 408
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
    Left = 401
    Top = 408
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
      ReadOnly = True
      Visible = False
    end
    object qryMemberPBDistanceID: TFDAutoIncField
      FieldName = 'DistanceID'
      Origin = 'DistanceID'
      ReadOnly = True
      Visible = False
    end
    object qryMemberPBStrokeID: TFDAutoIncField
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
      ReadOnly = True
      Visible = False
    end
  end
  object qryMemberRoleLnk: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    OnNewRecord = qryMemberRoleLnkNewRecord
    IndexFieldNames = 'MemberRoleID;MemberID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.MemberRoleLink'
    UpdateOptions.KeyFields = 'MemberRoleID;MemberID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @MemberID AS INTEGER;'
      'SET @MemberID = 1; --:MEMBERID'
      ''
      'SELECT [MemberRoleLink].[MemberRoleID]'
      '     , [MemberRoleLink].[MemberID]'
      '     , [MemberRoleLink].[CreatedOn]'
      '     , [MemberRoleLink].[IsActive]'
      '     , [MemberRoleLink].[IsArchived]'
      'FROM MemberRoleLink'
      '    --INNER JOIN [MemberRole]'
      
        '        --ON [MemberRoleLink].[MemberRoleID] = [MemberRole].[Mem' +
        'berRoleID]'
      'WHERE [MemberRoleLink].[MemberID] = @MemberID;')
    Left = 56
    Top = 240
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
      OnChange = qryMemberRoleLnkluMemberRoleStrChange
      Lookup = True
    end
  end
  object dsMemberRoleLnk: TDataSource
    DataSet = qryMemberRoleLnk
    Left = 160
    Top = 240
  end
  object tblMemberRole: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberRoleID'
    Connection = SCM.scmConnection
    TableName = 'SwimClubMeet.dbo.MemberRole'
    Left = 56
    Top = 552
  end
end
