object CORE: TCORE
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 874
  Width = 1135
  object dsSwimClub: TDataSource
    DataSet = qrySwimClub
    Left = 112
    Top = 40
  end
  object dsSession: TDataSource
    DataSet = qrySession
    Left = 240
    Top = 72
  end
  object dsEvent: TDataSource
    DataSet = qryEvent
    Left = 240
    Top = 128
  end
  object dsHeat: TDataSource
    DataSet = qryHeat
    Left = 368
    Top = 216
  end
  object qrySession: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Name = 'idxSortDESC'
        Fields = 'SwimClubID;SessionStart'
        DescFields = 'SessionStart'
        Options = [soDescNullLast]
      end
      item
        Name = 'idxSortASC'
        Fields = 'SwimClubID;SessionStart'
      end
      item
        Active = True
        Selected = True
        Name = 'mcSwimClub_DESC'
        Fields = 'SwimClubID'
        DescFields = 'SwimClubID'
      end>
    IndexName = 'mcSwimClub_DESC'
    MasterSource = dsSwimClub
    MasterFields = 'SwimClubID'
    DetailFields = 'SwimClubID'
    UpdateOptions.AssignedValues = [uvEInsert]
    UpdateOptions.UpdateTableName = 'SwimClubMeet2..Session'
    UpdateOptions.KeyFields = 'SessionID'
    SQL.Strings = (
      'USE SwimClubMeet2;'
      ''
      'DECLARE @Toggle AS BIT'
      'SET @Toggle = :TOGGLE'
      ''
      'if @Toggle = 0'
      ''
      'SELECT Session.SessionID, '
      'Session.SessionStart, '
      'Session.SwimClubID, '
      'Session.SessionStatusID, '
      'Session.ClosedDT, '
      'SessionStatus.Caption AS Status, '
      'Session.Caption'
      'FROM [dbo].[Session] '
      
        'LEFT OUTER JOIN SessionStatus ON Session.SessionStatusID = Sessi' +
        'onStatus.SessionStatusID'
      'ORDER BY Session.SessionStart DESC'
      ''
      'else'
      ''
      'SELECT Session.SessionID, '
      'Session.SessionStart, '
      'Session.SwimClubID, '
      'Session.SessionStatusID,  '
      'Session.ClosedDT, '
      'SessionStatus.Caption AS Status, '
      'Session.Caption'
      'FROM [dbo].[Session] '
      
        'LEFT OUTER JOIN SessionStatus ON Session.SessionStatusID = Sessi' +
        'onStatus.SessionStatusID'
      'WHERE Session.SessionStatusID = 1'
      'ORDER BY Session.SessionStart DESC'
      '')
    Left = 176
    Top = 72
    ParamData = <
      item
        Name = 'TOGGLE'
        DataType = ftBoolean
        ParamType = ptInput
        Value = False
      end>
    object qrySessionSessionID: TFDAutoIncField
      FieldName = 'SessionID'
      Origin = 'SessionID'
      ProviderFlags = [pfInWhere, pfInKey]
      Visible = False
    end
    object qrySessionSwimClubID: TIntegerField
      FieldName = 'SwimClubID'
      Origin = 'SwimClubID'
      Visible = False
    end
    object qrySessionSessionStatusID: TIntegerField
      FieldName = 'SessionStatusID'
      Origin = 'SessionStatusID'
      Visible = False
    end
    object qrySessionSessionStart: TSQLTimeStampField
      DisplayLabel = 'Session Date'
      DisplayWidth = 17
      FieldName = 'SessionStart'
      Origin = 'SessionStart'
      DisplayFormat = 'dd/mm/YY HH:nn'
      EditMask = '!90/00/00 90:00;1;0'
    end
    object qrySessionStatus: TWideStringField
      DisplayWidth = 9
      FieldName = 'Status'
      Origin = 'Status'
      Visible = False
      Size = 32
    end
    object qrySessionCaption: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 46
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 128
    end
    object qrySessionClosedDT: TSQLTimeStampField
      FieldName = 'ClosedDT'
      Origin = 'ClosedDT'
      Visible = False
    end
  end
  object qryEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'mcSession_DESC'
        Fields = 'SessionID'
        DescFields = 'SessionID'
      end>
    IndexName = 'mcSession_DESC'
    MasterSource = dsSession
    MasterFields = 'SessionID'
    DetailFields = 'SessionID'
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'hh:nn'
    UpdateOptions.UpdateTableName = 'SwimClubMeet2..Event'
    UpdateOptions.KeyFields = 'EventID'
    SQL.Strings = (
      'USE SwimClubMeet2;'
      ''
      'SELECT [Event].[EventID]'
      '     , [Event].[EventNum]'
      '     , [Event].[Caption]'
      '     , [Event].[ScheduleDT]'
      '      ,[Event].[RallyOpenDT]'
      '      ,[Event].[RallyCloseDT]'
      '      ,[Event].[OpenDT]'
      '     , [Event].[CloseDT]'
      '     , [Event].[SessionID]'
      '     , [Event].[StrokeID]'
      '     , [Event].[DistanceID]'
      '     , [Event].[EventStatusID]'
      '     , [Event].[RoundID]'
      '     , [Event].[GenderID]'
      '     , [Event].[EventCategoryID]'
      '     , [Event].[ParalympicTypeID]'
      
        '     , NomineeCount --, dbo.NomineeCount([Event].[EventID]) AS N' +
        'omineeCount'
      
        '     , EntrantCount --, dbo.EntrantCount([Event].[EventID]) AS E' +
        'ntrantCount'
      '     , SUBSTRING('
      
        '       CONCAT('#39'#'#39', Event.EventNum, '#39' - '#39', Distance.Caption, '#39' '#39',' +
        ' Stroke.Caption)'
      '         ,0,24) AS ShortCaption'
      '     , Distance.EventTypeID'
      'FROM dbo.[Event]'
      '    LEFT OUTER JOIN Stroke'
      '        ON Stroke.StrokeID = Event.StrokeID'
      '    LEFT OUTER JOIN Distance'
      '        ON Distance.DistanceID = Event.DistanceID'
      'ORDER BY Event.EventNum;'
      ''
      '')
    Left = 176
    Top = 128
    object qryEventEventID: TFDAutoIncField
      FieldName = 'EventID'
      Origin = 'EventID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryEventEventNum: TIntegerField
      DisplayLabel = ' Ev#'
      DisplayWidth = 5
      FieldName = 'EventNum'
      Origin = 'EventNum'
    end
    object qryEventCaption: TWideStringField
      DisplayLabel = 'Event Description'
      DisplayWidth = 60
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 128
    end
    object qryEventShortCaption: TWideStringField
      FieldName = 'ShortCaption'
      Origin = 'ShortCaption'
      ReadOnly = True
      Required = True
      Size = 273
    end
    object qryEventScheduleDT: TTimeField
      DisplayLabel = 'SCHED'
      DisplayWidth = 12
      FieldName = 'ScheduleDT'
      Origin = 'ScheduleDT'
      DisplayFormat = 'hh:nn'
    end
    object qryEventRallyOpenDT: TSQLTimeStampField
      DisplayLabel = 'Rally Begin'
      DisplayWidth = 12
      FieldName = 'RallyOpenDT'
      Origin = 'RallyOpenDT'
      DisplayFormat = 'hh:nn'
    end
    object qryEventRallyCloseDT: TSQLTimeStampField
      DisplayLabel = 'Rally End'
      DisplayWidth = 12
      FieldName = 'RallyCloseDT'
      Origin = 'RallyCloseDT'
      DisplayFormat = 'hh:nn'
    end
    object qryEventOpenDT: TSQLTimeStampField
      DisplayLabel = 'Open'
      DisplayWidth = 12
      FieldName = 'OpenDT'
      Origin = 'OpenDT'
      DisplayFormat = 'hh:nn'
    end
    object qryEventCloseDT: TSQLTimeStampField
      DisplayLabel = 'Close'
      DisplayWidth = 12
      FieldName = 'CloseDT'
      Origin = 'CloseDT'
      DisplayFormat = 'hh:nn'
    end
    object qryEventSessionID: TIntegerField
      FieldName = 'SessionID'
      Origin = 'SessionID'
    end
    object qryEventStrokeID: TIntegerField
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
    end
    object qryEventDistanceID: TIntegerField
      FieldName = 'DistanceID'
      Origin = 'DistanceID'
    end
    object qryEventEventStatusID: TIntegerField
      FieldName = 'EventStatusID'
      Origin = 'EventStatusID'
    end
    object qryEventRoundID: TIntegerField
      FieldName = 'RoundID'
      Origin = 'RoundID'
    end
    object qryEventGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
    end
    object qryEventParalympicTypeID: TIntegerField
      FieldName = 'ParalympicTypeID'
      Origin = 'ParalympicTypeID'
    end
    object qryEventEventTypeID: TIntegerField
      FieldName = 'EventTypeID'
      Origin = 'EventTypeID'
    end
    object qryEventNomineeCount: TIntegerField
      FieldName = 'NomineeCount'
      Origin = 'NomineeCount'
      ReadOnly = True
    end
    object qryEventEntrantCount: TIntegerField
      FieldName = 'EntrantCount'
      Origin = 'EntrantCount'
      ReadOnly = True
    end
    object LookUpStroke: TStringField
      DisplayLabel = 'Stroke'
      DisplayWidth = 14
      FieldKind = fkLookup
      FieldName = 'luStroke'
      LookupDataSet = tblStroke
      LookupKeyFields = 'StrokeID'
      LookupResultField = 'Caption'
      KeyFields = 'StrokeID'
      LookupCache = True
      Lookup = True
    end
    object LookUpDistance: TStringField
      DisplayLabel = 'Distance'
      DisplayWidth = 12
      FieldKind = fkLookup
      FieldName = 'luDistance'
      LookupDataSet = tblDistance
      LookupKeyFields = 'DistanceID'
      LookupResultField = 'Caption'
      KeyFields = 'DistanceID'
      LookupCache = True
      Lookup = True
    end
    object LookUpEventTypeID: TIntegerField
      FieldKind = fkLookup
      FieldName = 'luEventTypeID'
      LookupDataSet = tblDistance
      LookupKeyFields = 'DistanceID'
      LookupResultField = 'EventTypeID'
      KeyFields = 'DistanceID'
      Lookup = True
    end
  end
  object qryHeat: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'mcEvent_DESC'
        Fields = 'EventID'
        DescFields = 'EventID'
      end>
    IndexName = 'mcEvent_DESC'
    MasterFields = 'EventID'
    DetailFields = 'EventID'
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet2..Heat'
    UpdateOptions.KeyFields = 'HeatID'
    SQL.Strings = (
      'USE SwimClubMeet2;'
      ''
      'SELECT [Heat].[HeatID]'
      '      ,[Heat].[HeatNum]'
      '      ,[Heat].[Caption]'
      '      ,[Heat].[ScheduleDT]'
      '      ,[Heat].[RallyOpenDT]'
      '      ,[Heat].[RallyCloseDT]'
      '      ,[Heat].[OpenDT]'
      '      ,[Heat].[CloseDT]'
      '      ,[Heat].[EventID]'
      '      ,[Heat].[HeatTypeID]'
      '      ,[Heat].[HeatStatusID]'
      '  ,[HeatStatus].[Caption] AS cStatus -- redundant?'
      
        '  ,[Event].[StrokeID] -- need to paint coloured circle in gridHe' +
        'at.'
      ''
      'FROM'
      '  [SwimClubMeet2].[dbo].[Heat]'
      
        '  LEFT JOIN HeatStatus ON Heat.HeatStatusID = HeatStatus.HeatSta' +
        'tusID'
      
        '  INNER JOIN [dbo].[Event] ON [Heat].[EventID] = [Event].[EventI' +
        'D]'
      '  WHERE [Heat].[EventID] = 1672'
      '  '
      'ORDER BY'
      '  Heat.HeatNum'
      '    ')
    Left = 296
    Top = 216
    object qryHeatHeatID: TFDAutoIncField
      FieldName = 'HeatID'
      Origin = 'HeatID'
      ProviderFlags = [pfInWhere, pfInKey]
      Visible = False
    end
    object qryHeatEventID: TIntegerField
      FieldName = 'EventID'
      Origin = 'EventID'
      Visible = False
    end
    object qryHeatHeatTypeID: TIntegerField
      FieldName = 'HeatTypeID'
      Origin = 'HeatTypeID'
      Visible = False
    end
    object qryHeatHeatStatusID: TIntegerField
      FieldName = 'HeatStatusID'
      Origin = 'HeatStatusID'
      Visible = False
    end
    object qryHeatHeatNum: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Heat#'
      DisplayWidth = 6
      FieldName = 'HeatNum'
      Origin = 'HeatNum'
      ReadOnly = True
    end
    object qryHeatcStatus: TWideStringField
      DisplayLabel = 'Status'
      DisplayWidth = 12
      FieldName = 'cStatus'
      Origin = 'cStatus'
      ReadOnly = True
      Size = 60
    end
    object qryHeatCloseDT: TSQLTimeStampField
      FieldName = 'CloseDT'
      Origin = 'CloseDT'
      Visible = False
    end
    object qryHeatStrokeID: TIntegerField
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
    end
  end
  object qrySwimClub: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SwimClubID'
    UpdateOptions.UpdateTableName = 'SwimClubMeet2..SwimClub'
    UpdateOptions.KeyFields = 'SwimClubID'
    SQL.Strings = (
      'USE SwimClubMeet2;'
      ''
      'SELECT [SwimClubID]'
      '      ,[NickName]'
      '      ,[Caption]'
      '      ,[Email]'
      '      ,[ContactNum]'
      '      ,[WebSite]'
      '      ,[HeatAlgorithm]'
      '      ,[EnableSimpleDisqualification]'
      '      ,[NumOfLanes]'
      '      ,[DefTeamSize]'
      '      ,[LenOfPool]'
      '      ,[StartOfSwimSeason]'
      '      ,[CreatedOn]'
      '      ,[LogoDir]'
      '      ,[LogoImg]'
      '      ,[LogoType]'
      '      ,[PoolTypeID]'
      '      ,[SwimClubTypeID]'
      '  FROM [dbo].[SwimClub];'
      ''
      ''
      ''
      '')
    Left = 48
    Top = 40
  end
  object qryLane: TFDQuery
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'mcHeat_DESC'
        Fields = 'HeatID'
        DescFields = 'HeatID'
      end>
    IndexName = 'mcHeat_DESC'
    MasterSource = dsHeat
    MasterFields = 'HeatID'
    DetailFields = 'HeatID'
    UpdateOptions.UpdateTableName = 'SwimClubMeet2.dbo.Lane'
    UpdateOptions.KeyFields = 'LaneID'
    SQL.Strings = (
      'SELECT [LaneID]'
      '      ,[LaneNum]'
      '      ,[Lane].[RaceTime]'
      '      ,[ClubRecord]'
      '      ,[IsDisqualified]'
      '      ,[IsScratched]'
      '      ,[HeatID]'
      '      ,[DisqualifyCodeID]'
      '      ,[Lane].[TeamID]'
      '      ,[Lane].[NomineeID]'
      ''
      '     , CASE'
      '           WHEN [Lane].[NomineeID] IS NOT NULL THEN'
      '               CONCAT('
      '                        Member.FirstName'
      '                       , '#39' '#39
      '                       , UPPER(Member.LastName)'
      '                     )'
      '           WHEN [Lane].[TeamID] IS NOT NULL THEN'
      '           Team.TeamName'
      ''
      '       END AS FullName'
      '       , CASE'
      ''
      '           WHEN [Lane].[NomineeID] IS NOT NULL THEN'
      '               CONCAT('
      '                         FORMAT(Nominee.AGE, '#39'00'#39')'
      '                       , '#39'.'#39
      
        '                       , dbo.SwimmerGenderToString(Nominee.Membe' +
        'rID)'
      '                     )'
      '           WHEN [Lane].[TeamID] IS NOT NULL THEN'
      '           Team.ABBREV'
      ''
      '       END AS Stat'
      '       '
      '  FROM [dbo].[Lane]'
      '  LEFT JOIN Nominee ON Lane.NomineeID = Nominee.NomineeID'
      '  LEFT JOIN [Member] ON Nominee.MemberID = [Member].Memberid'
      '  LEFT JOIN [Team] ON Lane.Teamid = Team.teamid')
    Left = 416
    Top = 248
  end
  object dsLane: TDataSource
    DataSet = qryLane
    Left = 480
    Top = 248
  end
  object qryNominee: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'mcEvent_DESC'
        Fields = 'EventID'
        DescFields = 'EventID'
      end>
    IndexName = 'mcEvent_DESC'
    MasterSource = dsEvent
    MasterFields = 'EventID'
    DetailFields = 'EventID'
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn.ss.zzz'
    UpdateOptions.UpdateTableName = 'SwimClubMeet2..Nominee'
    UpdateOptions.KeyFields = 'NomineeID'
    SQL.Strings = (
      'USE [SwimClubMeet2];'
      ''
      'SELECT [NomineeID]'
      '      ,[AGE]'
      '      ,[TTB]'
      '      ,[PB]'
      '      ,[IsEntrant]'
      '      ,[SeedTime]'
      '      ,[AutoBuildFlag]'
      '      ,[EventID]'
      '      ,[Nominee].[MemberID]'
      '      ,[SwimClubID]'
      '      ,SUBSTRING(CONCAT ('
      #9'[FirstName]'
      #9','#39', '#39
      #9',UPPER([LastName])'
      #9'), 0, 48) AS FullName      '
      '  FROM [SwimClubMeet2].[dbo].[Nominee]'
      
        '  LEFT JOIN [Member] ON [Nominee].[MemberID] = [Member].[MemberI' +
        'D];'
      '')
    Left = 296
    Top = 160
  end
  object dsNominee: TDataSource
    DataSet = qryNominee
    Left = 368
    Top = 160
  end
  object qryTeam: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'mcLane_DESC'
        Fields = 'LaneID'
        DescFields = 'LaneID'
      end>
    IndexName = 'mcLane_DESC'
    MasterSource = dsLane
    MasterFields = 'LaneID'
    DetailFields = 'LaneID'
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEInsert, uvCheckRequired]
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet2.dbo.Team'
    UpdateOptions.KeyFields = 'TeamID'
    SQL.Strings = (
      '-- Format of TTime occurs in OnGetText() '#39'nn:ss.zzz'#39
      ''
      'USE SwimClubMeet2'
      ''
      'SELECT Team.TeamID'
      '     , Team.Caption'
      '     , Team.TeamName'
      '     , Team.ABBREV'
      '     , Team.TimeToBeat'
      'FROM Team'
      ''
      ''
      '')
    Left = 528
    Top = 392
  end
  object dsTeam: TDataSource
    DataSet = qryTeam
    Left = 616
    Top = 392
  end
  object dsSplitTime: TDataSource
    Left = 616
    Top = 336
  end
  object dsWatchTime: TDataSource
    Left = 616
    Top = 280
  end
  object qrySplitTime: TFDQuery
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'mcLane_DESC'
        Fields = 'LaneID'
        DescFields = 'LaneID'
      end>
    IndexName = 'mcLane_DESC'
    MasterSource = dsLane
    MasterFields = 'LaneID'
    DetailFields = 'LaneID'
    SQL.Strings = (
      'SELECT [SplitTimeID]'
      '      ,[WatchNum]'
      '      ,[Caption]'
      '      ,[Time]'
      '      ,[LaneID]'
      '  FROM [dbo].[SplitTime]'
      ''
      'GO'
      ''
      '')
    Left = 528
    Top = 336
  end
  object qryWatchTime: TFDQuery
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'mcLane_DESC'
        Fields = 'LaneID'
        DescFields = 'LaneID'
      end>
    IndexName = 'mcLane_DESC'
    MasterSource = dsLane
    MasterFields = 'LaneID'
    DetailFields = 'LaneID'
    SQL.Strings = (
      ''
      ''
      'SELECT [WatchTimeID]'
      '      ,[WatchNum]'
      '      ,[Caption]'
      '      ,[Time]'
      '      ,[LaneID]'
      '  FROM [dbo].[WatchTime]'
      ''
      'GO'
      ''
      '')
    Left = 528
    Top = 280
  end
  object qryTeamLink: TFDQuery
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'mcTeam_DESC'
        Fields = 'TeamID'
        DescFields = 'TeamID'
      end>
    IndexName = 'mcTeam_DESC'
    MasterSource = dsTeam
    MasterFields = 'TeamID'
    DetailFields = 'TeamID'
    Left = 680
    Top = 424
  end
  object dsTeamLink: TDataSource
    DataSet = qryTeamLink
    Left = 768
    Top = 424
  end
  object tblStroke: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'StrokeID'
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.UpdateTableName = 'SwimClubMeet2..Stroke'
    UpdateOptions.KeyFields = 'StrokeID'
    TableName = 'SwimClubMeet2..Stroke'
    Left = 88
    Top = 592
  end
  object tblDistance: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'DistanceID'
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.UpdateTableName = 'SwimClubMeet2..Distance'
    UpdateOptions.KeyFields = 'DistanceID'
    TableName = 'SwimClubMeet2..Distance'
    Left = 88
    Top = 640
  end
  object luStroke: TDataSource
    DataSet = tblStroke
    Left = 192
    Top = 592
  end
  object luDistance: TDataSource
    DataSet = tblDistance
    Left = 192
    Top = 640
  end
end
