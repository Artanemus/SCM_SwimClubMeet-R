object Core: TCore
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
      end>
    IndexFieldNames = 'SwimClubID'
    MasterSource = dsSwimClub
    MasterFields = 'SwimClubID'
    DetailFields = 'SwimClubID'
    Connection = SCM.scmConnection
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
    IndexFieldNames = 'SessionID'
    MasterSource = dsSession
    MasterFields = 'SessionID'
    DetailFields = 'SessionID'
    Connection = SCM.scmConnection
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
      '     , dbo.NomineeCount([Event].[EventID]) AS NomineeCount'
      '     , dbo.EntrantCount([Event].[EventID]) AS EntrantCount'
      
        '     , CONCAT('#39'#'#39', Event.EventNum, '#39' - '#39', Distance.Caption, '#39' '#39',' +
        ' Stroke.Caption) AS ShortCaption'
      '--     , Distance.Meters'
      '--     , Distance.ABREV'
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
  end
  object qryHeat: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EventID'
    MasterSource = dsEvent
    MasterFields = 'EventID'
    DetailFields = 'EventID'
    Connection = SCM.scmConnection
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
      '  ,[HeatStatus].[Caption] AS cStatus'
      ''
      'FROM'
      '  [SwimClubMeet2].[dbo].[Heat]'
      
        '  INNER JOIN HeatStatus ON Heat.HeatStatusID = HeatStatus.HeatSt' +
        'atusID'
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
  end
  object qrySwimClub: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SwimClubID'
    Connection = SCM.scmConnection
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
      '      ,[EnableTeamEvents]'
      '      ,[EnableSwimOThon]'
      '      ,[EnableExtHeatTypes]'
      '      ,[EnableMembershipStr]'
      '      ,[EnableSimpleDisqualification]'
      '      ,[NumOfLanes]'
      '      ,[NumOfSwimmersInTEAMS]'
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
    object qrySwimClubSwimClubID: TFDAutoIncField
      FieldName = 'SwimClubID'
      Origin = 'SwimClubID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qrySwimClubNickName: TWideStringField
      FieldName = 'NickName'
      Origin = 'NickName'
      Size = 128
    end
    object qrySwimClubCaption: TWideStringField
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 128
    end
    object qrySwimClubEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'Email'
      Size = 128
    end
    object qrySwimClubContactNum: TWideStringField
      FieldName = 'ContactNum'
      Origin = 'ContactNum'
      Size = 30
    end
    object qrySwimClubWebSite: TWideStringField
      FieldName = 'WebSite'
      Origin = 'WebSite'
      Size = 256
    end
    object qrySwimClubHeatAlgorithm: TIntegerField
      FieldName = 'HeatAlgorithm'
      Origin = 'HeatAlgorithm'
    end
    object qrySwimClubEnableTeamEvents: TBooleanField
      FieldName = 'EnableTeamEvents'
      Origin = 'EnableTeamEvents'
      Required = True
    end
    object qrySwimClubEnableSwimOThon: TBooleanField
      FieldName = 'EnableSwimOThon'
      Origin = 'EnableSwimOThon'
      Required = True
    end
    object qrySwimClubEnableExtHeatTypes: TBooleanField
      FieldName = 'EnableExtHeatTypes'
      Origin = 'EnableExtHeatTypes'
      Required = True
    end
    object qrySwimClubEnableMembershipStr: TBooleanField
      FieldName = 'EnableMembershipStr'
      Origin = 'EnableMembershipStr'
      Required = True
    end
    object qrySwimClubEnableSimpleDisqualification: TBooleanField
      FieldName = 'EnableSimpleDisqualification'
      Origin = 'EnableSimpleDisqualification'
      Required = True
    end
    object qrySwimClubNumOfLanes: TIntegerField
      FieldName = 'NumOfLanes'
      Origin = 'NumOfLanes'
    end
    object qrySwimClubNumOfSwimmersInTEAMS: TIntegerField
      FieldName = 'NumOfSwimmersInTEAMS'
      Origin = 'NumOfSwimmersInTEAMS'
    end
    object qrySwimClubLenOfPool: TIntegerField
      FieldName = 'LenOfPool'
      Origin = 'LenOfPool'
    end
    object qrySwimClubStartOfSwimSeason: TSQLTimeStampField
      FieldName = 'StartOfSwimSeason'
      Origin = 'StartOfSwimSeason'
    end
    object qrySwimClubCreatedOn: TSQLTimeStampField
      FieldName = 'CreatedOn'
      Origin = 'CreatedOn'
    end
    object qrySwimClubLogoDir: TMemoField
      FieldName = 'LogoDir'
      Origin = 'LogoDir'
      BlobType = ftMemo
      Size = 2147483647
    end
    object qrySwimClubLogoImg: TBlobField
      FieldName = 'LogoImg'
      Origin = 'LogoImg'
    end
    object qrySwimClubLogoType: TWideStringField
      FieldName = 'LogoType'
      Origin = 'LogoType'
      Size = 5
    end
    object qrySwimClubPoolTypeID: TIntegerField
      FieldName = 'PoolTypeID'
      Origin = 'PoolTypeID'
    end
    object qrySwimClubSwimClubTypeID: TIntegerField
      FieldName = 'SwimClubTypeID'
      Origin = 'SwimClubTypeID'
    end
  end
  object qryLane: TFDQuery
    IndexFieldNames = 'HeatID'
    MasterSource = dsHeat
    MasterFields = 'HeatID'
    DetailFields = 'HeatID'
    Connection = SCM.scmConnection
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
        Name = 'mcEvent_Nominee'
        Fields = 'EventID'
        DescFields = 'EventID'
      end>
    IndexName = 'mcEvent_Nominee'
    MasterSource = dsEvent
    MasterFields = 'EventID'
    Connection = SCM.scmConnection
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
      '      ,[MemberID]'
      '      ,[SwimClubID]'
      '  FROM [SwimClubMeet2].[dbo].[Nominee]'
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
    IndexFieldNames = 'TeamID'
    MasterSource = dsLane
    MasterFields = 'TeamID'
    DetailFields = 'TeamID'
    Connection = SCM.scmConnection
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
      '    LEFT OUTER JOIN TeamName'
      '        ON Team.TeamNameID = TeamName.TeamNameID'
      'ORDER BY Team.Lane'
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
    Connection = SCM.scmConnection
    Left = 528
    Top = 336
  end
  object qryWatchTime: TFDQuery
    Connection = SCM.scmConnection
    Left = 528
    Top = 280
  end
  object qryTeamLink: TFDQuery
    IndexFieldNames = 'TeamID'
    MasterSource = dsTeam
    MasterFields = 'TeamID'
    DetailFields = 'TeamID'
    Connection = SCM.scmConnection
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
    Active = True
    IndexFieldNames = 'StrokeID'
    Connection = SCM.scmConnection
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.UpdateTableName = 'SwimClubMeet2..Stroke'
    UpdateOptions.KeyFields = 'StrokeID'
    TableName = 'SwimClubMeet2..Stroke'
    Left = 88
    Top = 592
  end
  object tblDistance: TFDTable
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'DistanceID'
    Connection = SCM.scmConnection
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
  object SVGEvStatusList: TSVGIconVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'TabSheetHeatsImages_HeatClosed'
        Name = 'TabSheetHeatsImages_HeatClosed'
      end
      item
        CollectionIndex = 1
        CollectionName = 'TabSheetHeatsImages_HeatOpen'
        Name = 'TabSheetHeatsImages_HeatOpen'
      end>
    ImageCollection = SVGCoreCollection
    Left = 512
    Top = 624
  end
  object SVGCoreCollection: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'TabSheetHeatsImages_HeatClosed'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8" /><sodipodi:namedview'#10'     id="namedview6"'#10'     pagecolor=' +
          '"#ffffff"'#10'     bordercolor="#666666"'#10'     borderopacity="1.0"'#10'  ' +
          '   inkscape:showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10' ' +
          '    inkscape:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1' +
          'd1"'#10'     showgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:c' +
          'x="587.875"'#10'     inkscape:cy="92.125001"'#10'     inkscape:window-wi' +
          'dth="2560"'#10'     inkscape:window-height="1377"'#10'     inkscape:wind' +
          'ow-x="-8"'#10'     inkscape:window-y="-8"'#10'     inkscape:window-maxim' +
          'ized="1"'#10'     inkscape:current-layer="layer36"'#10'     showguides="' +
          'true"><inkscape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"' +
          #10'       height="48"'#10'       id="page783"'#10'       inkscape:label="H' +
          'eatClosed"'#10'       inkscape:export-filename="..\HeatNavigator\Hea' +
          'tClosed.png"'#10'       inkscape:export-xdpi="96"'#10'       inkscape:ex' +
          'port-ydpi="96"'#10'       margin="0"'#10'       bleed="0" /></sodipodi:n' +
          'amedview><g'#10'     inkscape:groupmode="layer"'#10'     id="layer25"'#10'  ' +
          '   inkscape:label="HeatStatusCollection"'#10'     style="display:inl' +
          'ine"'#10'     transform="translate(-2030)"><g'#10'       inkscape:groupm' +
          'ode="layer"'#10'       id="layer28"'#10'       inkscape:label="OpenRaced' +
          'Closed"><path'#10'         d="m 2054,47.04049 q -4.7369,0 -8.9538,-1' +
          '.814438 -4.217,-1.814439 -7.3652,-4.953706 -3.1483,-3.139267 -4.' +
          '968,-7.344156 -1.8196,-4.204889 -1.8196,-8.92819 0,-4.780902 1.8' +
          '196,-8.985791 1.8197,-4.20489 4.968,-7.3153553 3.1483,-3.110466 ' +
          '7.3652,-4.9249054 4.2169,-1.814438 8.9538,-1.814438 4.7946,0 9.0' +
          '116,1.814438 4.217,1.8144394 7.3363,4.9249054 3.1194,3.1104653 4' +
          '.9391,7.3153553 1.8196,4.204889 1.8196,8.985791 0,4.723301 -1.81' +
          '96,8.92819 -1.8197,4.204889 -4.9391,7.344156 -3.1194,3.139267 -7' +
          '.3363,4.953706 -4.2169,1.814438 -9.0116,1.814438 z m 0,-3.456073' +
          ' q 8.2028,0 13.9218,-5.731322 5.7189,-5.731321 5.7189,-13.853094' +
          ' 0,-8.179374 -5.7189,-13.881895 -5.719,-5.7025223 -13.9218,-5.70' +
          '25223 -8.145,0 -13.8929,5.7025223 -5.7476,5.702521 -5.7476,13.88' +
          '1895 0,8.121773 5.7476,13.853094 5.7479,5.731322 13.8929,5.73132' +
          '2 z M 2054,24 Z"'#10'         id="path2-3-0-5"'#10'         style="displ' +
          'ay:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1' +
          '.15368;stroke-opacity:1" /><ellipse'#10'         style="display:inli' +
          'ne;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1.7;stro' +
          'ke-dashoffset:0.8406;stroke-opacity:1;stop-color:#000000"'#10'      ' +
          '   id="path1571"'#10'         cx="2054"'#10'         cy="24"'#10'         rx' +
          '="19.775764"'#10'         ry="19.719078" /></g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_HeatOpen'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8" /><sodipodi:namedview'#10'     id="namedview6"'#10'     pagecolor=' +
          '"#ffffff"'#10'     bordercolor="#666666"'#10'     borderopacity="1.0"'#10'  ' +
          '   inkscape:showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10' ' +
          '    inkscape:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1' +
          'd1"'#10'     showgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:c' +
          'x="587.875"'#10'     inkscape:cy="92.125001"'#10'     inkscape:window-wi' +
          'dth="2560"'#10'     inkscape:window-height="1377"'#10'     inkscape:wind' +
          'ow-x="-8"'#10'     inkscape:window-y="-8"'#10'     inkscape:window-maxim' +
          'ized="1"'#10'     inkscape:current-layer="layer36"'#10'     showguides="' +
          'true"><inkscape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"' +
          #10'       height="48"'#10'       id="page703"'#10'       inkscape:label="H' +
          'eatOpen"'#10'       inkscape:export-filename="..\HeatNavigator\HeatO' +
          'pen.png"'#10'       inkscape:export-xdpi="96"'#10'       inkscape:export' +
          '-ydpi="96"'#10'       margin="0"'#10'       bleed="0" /></sodipodi:named' +
          'view><g'#10'     inkscape:groupmode="layer"'#10'     id="layer25"'#10'     i' +
          'nkscape:label="HeatStatusCollection"'#10'     style="display:inline"' +
          #10'     transform="translate(-1914)"><g'#10'       inkscape:groupmode=' +
          '"layer"'#10'       id="layer28"'#10'       inkscape:label="OpenRacedClos' +
          'ed"><path'#10'         d="m 1938,47.04049 q -4.7369,0 -8.9538,-1.814' +
          '438 -4.217,-1.814439 -7.3652,-4.953706 -3.1483,-3.139267 -4.968,' +
          '-7.344156 -1.8196,-4.204889 -1.8196,-8.92819 0,-4.780902 1.8196,' +
          '-8.985791 1.8197,-4.20489 4.968,-7.315356 3.1483,-3.1104661 7.36' +
          '52,-4.9249051 4.2169,-1.814438 8.9538,-1.814438 4.7946,0 9.0116,' +
          '1.814438 4.217,1.814439 7.3363,4.9249051 3.1194,3.110466 4.9391,' +
          '7.315356 1.8196,4.204889 1.8196,8.985791 0,4.723301 -1.8196,8.92' +
          '819 -1.8197,4.204889 -4.9391,7.344156 -3.1194,3.139267 -7.3363,4' +
          '.953706 -4.2169,1.814438 -9.0116,1.814438 z m 0,-3.456073 q 8.20' +
          '28,0 13.9218,-5.731322 5.7189,-5.731322 5.7189,-13.853095 0,-8.1' +
          '79374 -5.7189,-13.881895 -5.719,-5.7025221 -13.9218,-5.7025221 -' +
          '8.145,0 -13.8929,5.7025221 -5.7476,5.702521 -5.7476,13.881895 0,' +
          '8.121773 5.7476,13.853095 5.7479,5.731322 13.8929,5.731322 z M 1' +
          '938,24 Z"'#10'         id="path2-3-0-9"'#10'         style="display:inli' +
          'ne;stroke-width:1.15368" /></g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_HeatRaced'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8" /><sodipodi:namedview'#10'     id="namedview6"'#10'     pagecolor=' +
          '"#ffffff"'#10'     bordercolor="#666666"'#10'     borderopacity="1.0"'#10'  ' +
          '   inkscape:showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10' ' +
          '    inkscape:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1' +
          'd1"'#10'     showgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:c' +
          'x="587.875"'#10'     inkscape:cy="92.125001"'#10'     inkscape:window-wi' +
          'dth="2560"'#10'     inkscape:window-height="1377"'#10'     inkscape:wind' +
          'ow-x="-8"'#10'     inkscape:window-y="-8"'#10'     inkscape:window-maxim' +
          'ized="1"'#10'     inkscape:current-layer="layer36"'#10'     showguides="' +
          'true"><inkscape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"' +
          #10'       height="48"'#10'       id="page781"'#10'       inkscape:label="H' +
          'eatRaced"'#10'       inkscape:export-filename="..\HeatNavigator\Heat' +
          'Raced.png"'#10'       inkscape:export-xdpi="96"'#10'       inkscape:expo' +
          'rt-ydpi="96"'#10'       margin="0"'#10'       bleed="0" /></sodipodi:nam' +
          'edview><g'#10'     inkscape:groupmode="layer"'#10'     id="layer25"'#10'    ' +
          ' inkscape:label="HeatStatusCollection"'#10'     style="display:inlin' +
          'e"'#10'     transform="translate(-1972)"><g'#10'       inkscape:groupmod' +
          'e="layer"'#10'       id="layer28"'#10'       inkscape:label="OpenRacedCl' +
          'osed"><path'#10'         d="m 1996,47.04049 q -4.7369,0 -8.9538,-1.8' +
          '14438 -4.217,-1.814439 -7.3652,-4.953706 -3.1483,-3.139267 -4.96' +
          '8,-7.344156 -1.8196,-4.204889 -1.8196,-8.92819 0,-4.780902 1.819' +
          '6,-8.985791 1.8197,-4.20489 4.968,-7.315356 3.1483,-3.1104661 7.' +
          '3652,-4.9249051 4.2169,-1.81443795 8.9538,-1.81443795 4.7946,0 9' +
          '.0116,1.81443795 4.217,1.814439 7.3363,4.9249051 3.1194,3.110466' +
          ' 4.9391,7.315356 1.8196,4.204889 1.8196,8.985791 0,4.723301 -1.8' +
          '196,8.92819 -1.8197,4.204889 -4.9391,7.344156 -3.1194,3.139267 -' +
          '7.3363,4.953706 -4.2169,1.814438 -9.0116,1.814438 z m 0,-3.45607' +
          '3 q 8.2028,0 13.9218,-5.731322 5.7189,-5.731322 5.7189,-13.85309' +
          '5 0,-8.179374 -5.7189,-13.881895 -5.719,-5.7025221 -13.9218,-5.7' +
          '025221 -8.145,0 -13.8929,5.7025221 -5.7476,5.702521 -5.7476,13.8' +
          '81895 0,8.121773 5.7476,13.853095 5.7479,5.731322 13.8929,5.7313' +
          '22 z M 1996,24 Z"'#10'         id="path2-3-0-0"'#10'         style="disp' +
          'lay:inline;stroke-width:1.15368" /><path'#10'         style="display' +
          ':inline;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px' +
          ';stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"'#10'   ' +
          '      d="M 1996,4.4155829 V 43.584417 c 0,0 -19.6405,0.873921 -1' +
          '9.6405,-19.584417 C 1976.3595,3.3223126 1996,4.4155829 1996,4.41' +
          '55829"'#10'         id="path865"'#10'         sodipodi:nodetypes="ccsc" ' +
          '/></g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_StrokeFS'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8" /><sodipodi:namedview'#10'     id="namedview6"'#10'     pagecolor=' +
          '"#ffffff"'#10'     bordercolor="#666666"'#10'     borderopacity="1.0"'#10'  ' +
          '   inkscape:showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10' ' +
          '    inkscape:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1' +
          'd1"'#10'     showgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:c' +
          'x="587.875"'#10'     inkscape:cy="92.125001"'#10'     inkscape:window-wi' +
          'dth="2560"'#10'     inkscape:window-height="1377"'#10'     inkscape:wind' +
          'ow-x="-8"'#10'     inkscape:window-y="-8"'#10'     inkscape:window-maxim' +
          'ized="1"'#10'     inkscape:current-layer="layer36"'#10'     showguides="' +
          'true"><inkscape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"' +
          #10'       height="48"'#10'       id="page681"'#10'       inkscape:label="S' +
          'trokeFS"'#10'       inkscape:export-filename="..\HeatNavigator\Strok' +
          'eFS.png"'#10'       inkscape:export-xdpi="96"'#10'       inkscape:export' +
          '-ydpi="96"'#10'       margin="0"'#10'       bleed="0" /></sodipodi:named' +
          'view><g'#10'     inkscape:groupmode="layer"'#10'     id="layer31"'#10'     i' +
          'nkscape:label="STROKES UPDATED"'#10'     transform="translate(-406,-' +
          '48)"><g'#10'       inkscape:groupmode="layer"'#10'       id="layer30"'#10'  ' +
          '     inkscape:label="FS"'#10'       style="display:inline"><path'#10'   ' +
          '      d="m 410.70763,95.040485 q -1.49912,0 -2.62346,-1.15202 -1' +
          '.12434,-1.15202 -1.12434,-2.68806 V 52.79959 q 0,-1.536032 1.124' +
          '34,-2.688057 1.12434,-1.152024 2.62346,-1.152024 h 37.4781 q 1.4' +
          '9912,0 2.62346,1.152024 1.12434,1.152025 1.12434,2.688057 v 38.4' +
          '00815 q 0,1.53604 -1.12434,2.68806 -1.12434,1.15202 -2.62346,1.1' +
          '5202 z m 0,-3.84008 h 37.4781 V 52.79959 h -37.4781 z"'#10'         ' +
          'id="path1677-81"'#10'         style="display:inline;stroke-width:1.2' +
          '6455"'#10'         transform="translate(0.5533)" /><text'#10'         xm' +
          'l:space="preserve"'#10'         style="font-size:38.894px;line-heigh' +
          't:1.25;font-family:sans-serif;display:inline;fill:#afe9c6;fill-o' +
          'pacity:1;stroke:#000000;stroke-width:1.508;stroke-dasharray:none' +
          ';stroke-opacity:1"'#10'         x="499.39459"'#10'         y="72.854645"' +
          #10'         id="text1826-2"'#10'         transform="matrix(0.82274929,' +
          '0,0,1.2154371,0.5533,0)"><tspan'#10'           sodipodi:role="line"'#10 +
          '           id="tspan1824-1"'#10'           x="499.39459"'#10'           ' +
          'y="72.854645"'#10'           style="font-style:normal;font-variant:n' +
          'ormal;font-weight:900;font-stretch:normal;font-size:38.894px;fon' +
          't-family:'#39'Segoe UI'#39';-inkscape-font-specification:'#39'Segoe UI, Heav' +
          'y'#39';font-variant-ligatures:normal;font-variant-caps:normal;font-v' +
          'ariant-numeric:normal;font-variant-east-asian:normal;fill:#afe9c' +
          '6;fill-opacity:1;stroke:#000000;stroke-width:1.508;stroke-dashar' +
          'ray:none;stroke-opacity:1">FS</tspan></text></g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_StrokeBK'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8" /><sodipodi:namedview'#10'     id="namedview6"'#10'     pagecolor=' +
          '"#ffffff"'#10'     bordercolor="#666666"'#10'     borderopacity="1.0"'#10'  ' +
          '   inkscape:showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10' ' +
          '    inkscape:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1' +
          'd1"'#10'     showgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:c' +
          'x="587.875"'#10'     inkscape:cy="92.125001"'#10'     inkscape:window-wi' +
          'dth="2560"'#10'     inkscape:window-height="1377"'#10'     inkscape:wind' +
          'ow-x="-8"'#10'     inkscape:window-y="-8"'#10'     inkscape:window-maxim' +
          'ized="1"'#10'     inkscape:current-layer="layer36"'#10'     showguides="' +
          'true"><inkscape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"' +
          #10'       height="48"'#10'       id="page685"'#10'       inkscape:label="S' +
          'trokeBK"'#10'       inkscape:export-filename="..\HeatNavigator\Strok' +
          'eBK.png"'#10'       inkscape:export-xdpi="96"'#10'       inkscape:export' +
          '-ydpi="96"'#10'       margin="0"'#10'       bleed="0" /></sodipodi:named' +
          'view><g'#10'     inkscape:groupmode="layer"'#10'     id="layer31"'#10'     i' +
          'nkscape:label="STROKES UPDATED"'#10'     transform="translate(-522,-' +
          '48)"><g'#10'       inkscape:groupmode="layer"'#10'       id="layer33"'#10'  ' +
          '     inkscape:label="BK"><path'#10'         d="m 527.26095,95.04049 ' +
          'q -1.49912,0 -2.62346,-1.152024 -1.12434,-1.152024 -1.12434,-2.6' +
          '88058 V 52.799592 q 0,-1.536033 1.12434,-2.688057 1.12434,-1.152' +
          '025 2.62346,-1.152025 h 37.4781 q 1.49912,0 2.62346,1.152025 1.1' +
          '2434,1.152024 1.12434,2.688057 v 38.400816 q 0,1.536034 -1.12434' +
          ',2.688058 -1.12434,1.152024 -2.62346,1.152024 z m 0,-3.840082 h ' +
          '37.4781 V 52.799592 h -37.4781 z"'#10'         id="path1677-6-4"'#10'   ' +
          '      style="stroke-width:1.26455" /><text'#10'         xml:space="p' +
          'reserve"'#10'         style="font-size:34.4505px;line-height:1.25;fo' +
          'nt-family:sans-serif;fill:#e9afaf;fill-opacity:1;stroke:#000000;' +
          'stroke-width:1.33572;stroke-dasharray:none;stroke-opacity:1"'#10'   ' +
          '      x="727.60181"'#10'         y="64.051971"'#10'         id="text1826' +
          '-3-1"'#10'         transform="scale(0.72500809,1.379295)"><tspan'#10'   ' +
          '        sodipodi:role="line"'#10'           id="tspan1824-2-3"'#10'     ' +
          '      x="727.60181"'#10'           y="64.051971"'#10'           style="f' +
          'ont-style:normal;font-variant:normal;font-weight:900;font-stretc' +
          'h:normal;font-size:34.4505px;font-family:'#39'Segoe UI'#39';-inkscape-fo' +
          'nt-specification:'#39'Segoe UI, Heavy'#39';font-variant-ligatures:normal' +
          ';font-variant-caps:normal;font-variant-numeric:normal;font-varia' +
          'nt-east-asian:normal;fill:#e9afaf;fill-opacity:1;stroke:#000000;' +
          'stroke-width:1.33572;stroke-dasharray:none;stroke-opacity:1">BK<' +
          '/tspan></text></g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_StrokeBS'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8" /><sodipodi:namedview'#10'     id="namedview6"'#10'     pagecolor=' +
          '"#ffffff"'#10'     bordercolor="#666666"'#10'     borderopacity="1.0"'#10'  ' +
          '   inkscape:showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10' ' +
          '    inkscape:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1' +
          'd1"'#10'     showgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:c' +
          'x="587.875"'#10'     inkscape:cy="92.125001"'#10'     inkscape:window-wi' +
          'dth="2560"'#10'     inkscape:window-height="1377"'#10'     inkscape:wind' +
          'ow-x="-8"'#10'     inkscape:window-y="-8"'#10'     inkscape:window-maxim' +
          'ized="1"'#10'     inkscape:current-layer="layer36"'#10'     showguides="' +
          'true"><inkscape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"' +
          #10'       height="48"'#10'       id="page683"'#10'       inkscape:label="S' +
          'trokeBS"'#10'       inkscape:export-filename="..\HeatNavigator\Strok' +
          'eBS.png"'#10'       inkscape:export-xdpi="96"'#10'       inkscape:export' +
          '-ydpi="96"'#10'       margin="0"'#10'       bleed="0" /></sodipodi:named' +
          'view><g'#10'     inkscape:groupmode="layer"'#10'     id="layer31"'#10'     i' +
          'nkscape:label="STROKES UPDATED"'#10'     transform="translate(-464,-' +
          '48)"><g'#10'       inkscape:groupmode="layer"'#10'       id="layer32"'#10'  ' +
          '     inkscape:label="BS"'#10'       transform="translate(0.17475,0.0' +
          '51885)"><path'#10'         d="m 469.0862,94.988605 q -1.49912,0 -2.6' +
          '2346,-1.152024 -1.12434,-1.152024 -1.12434,-2.688058 V 52.747706' +
          ' q 0,-1.536032 1.12434,-2.688057 1.12434,-1.152024 2.62346,-1.15' +
          '2024 h 37.4781 q 1.49912,0 2.62346,1.152024 1.12434,1.152025 1.1' +
          '2434,2.688057 v 38.400817 q 0,1.536034 -1.12434,2.688058 -1.1243' +
          '4,1.152024 -2.62346,1.152024 z m 0,-3.840082 h 37.4781 V 52.7477' +
          '06 h -37.4781 z"'#10'         id="path1677-8-6"'#10'         style="stro' +
          'ke-width:1.26455" /><text'#10'         xml:space="preserve"'#10'        ' +
          ' style="font-size:35.8277px;line-height:1.25;font-family:sans-se' +
          'rif;fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:1.38' +
          '944;stroke-dasharray:none;stroke-opacity:1"'#10'         x="620.3232' +
          '4"'#10'         y="66.880112"'#10'         id="text1826-9-6"'#10'         tr' +
          'ansform="scale(0.75522408,1.3241103)"><tspan'#10'           sodipodi' +
          ':role="line"'#10'           id="tspan1824-7-0"'#10'           x="620.323' +
          '24"'#10'           y="66.880112"'#10'           style="font-style:normal' +
          ';font-variant:normal;font-weight:900;font-stretch:normal;font-si' +
          'ze:35.8277px;font-family:'#39'Segoe UI'#39';-inkscape-font-specification' +
          ':'#39'Segoe UI, Heavy'#39';font-variant-ligatures:normal;font-variant-ca' +
          'ps:normal;font-variant-numeric:normal;font-variant-east-asian:no' +
          'rmal;fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:1.3' +
          '8944;stroke-dasharray:none;stroke-opacity:1">BR</tspan></text></' +
          'g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_StrokeBF'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8" /><sodipodi:namedview'#10'     id="namedview6"'#10'     pagecolor=' +
          '"#ffffff"'#10'     bordercolor="#666666"'#10'     borderopacity="1.0"'#10'  ' +
          '   inkscape:showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10' ' +
          '    inkscape:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1' +
          'd1"'#10'     showgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:c' +
          'x="587.875"'#10'     inkscape:cy="92.125001"'#10'     inkscape:window-wi' +
          'dth="2560"'#10'     inkscape:window-height="1377"'#10'     inkscape:wind' +
          'ow-x="-8"'#10'     inkscape:window-y="-8"'#10'     inkscape:window-maxim' +
          'ized="1"'#10'     inkscape:current-layer="layer36"'#10'     showguides="' +
          'true"><inkscape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"' +
          #10'       height="48"'#10'       id="page687"'#10'       inkscape:label="S' +
          'trokeBF"'#10'       inkscape:export-filename="..\HeatNavigator\Strok' +
          'eBF.png"'#10'       inkscape:export-xdpi="96"'#10'       inkscape:export' +
          '-ydpi="96"'#10'       margin="0"'#10'       bleed="0" /></sodipodi:named' +
          'view><g'#10'     inkscape:groupmode="layer"'#10'     id="layer31"'#10'     i' +
          'nkscape:label="STROKES UPDATED"'#10'     transform="translate(-580,-' +
          '48)"><g'#10'       inkscape:groupmode="layer"'#10'       id="layer34"'#10'  ' +
          '     inkscape:label="BF"><path'#10'         d="m 585.34608,95.040506' +
          ' q -1.49912,0 -2.62346,-1.152024 -1.12434,-1.152024 -1.12434,-2.' +
          '688058 V 52.799608 q 0,-1.536033 1.12434,-2.688058 1.12434,-1.15' +
          '2024 2.62346,-1.152024 h 37.4781 q 1.49912,0 2.62346,1.152024 1.' +
          '12434,1.152025 1.12434,2.688058 v 38.400816 q 0,1.536034 -1.1243' +
          '4,2.688058 -1.12434,1.152024 -2.62346,1.152024 z m 0,-3.840082 h' +
          ' 37.4781 V 52.799608 h -37.4781 z"'#10'         id="path1677-1-5"'#10'  ' +
          '       style="stroke-width:1.26455" /><text'#10'         xml:space="' +
          'preserve"'#10'         style="font-size:36.7533px;line-height:1.25;f' +
          'ont-family:sans-serif;fill:#e9ddaf;fill-opacity:1;stroke:#000000' +
          ';stroke-width:1.425;stroke-dasharray:none;stroke-opacity:1"'#10'    ' +
          '     x="755.61359"'#10'         y="68.483673"'#10'         id="text1826-' +
          '91-3"'#10'         transform="scale(0.77557023,1.2893739)"><tspan'#10'  ' +
          '         sodipodi:role="line"'#10'           id="tspan1824-9-5"'#10'    ' +
          '       x="755.61359"'#10'           y="68.483673"'#10'           style="' +
          'font-style:normal;font-variant:normal;font-weight:900;font-stret' +
          'ch:normal;font-size:36.7533px;font-family:'#39'Segoe UI'#39';-inkscape-f' +
          'ont-specification:'#39'Segoe UI, Heavy'#39';font-variant-ligatures:norma' +
          'l;font-variant-caps:normal;font-variant-numeric:normal;font-vari' +
          'ant-east-asian:normal;fill:#e9ddaf;fill-opacity:1;stroke:#000000' +
          ';stroke-width:1.425;stroke-dasharray:none;stroke-opacity:1">BF</' +
          'tspan></text></g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_StrokeIM'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8"><mask'#10'       maskUnits="userSpaceOnUse"'#10'       id="mask363' +
          '8-4"><path'#10'         style="fill:#ffffff;fill-opacity:1;stroke:no' +
          'ne;stroke-width:0.995918px;stroke-linecap:butt;stroke-linejoin:m' +
          'iter;stroke-opacity:1"'#10'         d="m 965.5527,16.252457 -0.0706,' +
          '16.496134 h -34.72342 l -0.0682,-16.337365 z"'#10'         id="path3' +
          '640-4" /></mask><mask'#10'       maskUnits="userSpaceOnUse"'#10'       i' +
          'd="mask3879-0"><path'#10'         style="fill:#ffffff;fill-opacity:1' +
          ';stroke:none;stroke-width:0.995918px;stroke-linecap:butt;stroke-' +
          'linejoin:miter;stroke-opacity:1"'#10'         d="m 1000.4149,16.2524' +
          '57 -0.071,16.496134 h -34.72337 l -0.0682,-16.337365 z"'#10'        ' +
          ' id="path3881-1" /></mask><mask'#10'       maskUnits="userSpaceOnUse' +
          '"'#10'       id="mask4336-2"><path'#10'         style="fill:#ffffff;fill' +
          '-opacity:1;stroke:none;stroke-width:0.98773px;stroke-linecap:but' +
          't;stroke-linejoin:miter;stroke-opacity:1"'#10'         d="M 999.7535' +
          '2,-0.03367105 999.68431,16.477347 H 965.55998 L 965.49289,0.1252' +
          '4158 Z"'#10'         id="path4338-9" /></mask></defs><sodipodi:named' +
          'view'#10'     id="namedview6"'#10'     pagecolor="#ffffff"'#10'     borderco' +
          'lor="#666666"'#10'     borderopacity="1.0"'#10'     inkscape:showpagesha' +
          'dow="2"'#10'     inkscape:pageopacity="0.0"'#10'     inkscape:pagechecke' +
          'rboard="0"'#10'     inkscape:deskcolor="#d1d1d1"'#10'     showgrid="fals' +
          'e"'#10'     inkscape:zoom="4"'#10'     inkscape:cx="587.875"'#10'     inksca' +
          'pe:cy="92.125001"'#10'     inkscape:window-width="2560"'#10'     inkscap' +
          'e:window-height="1377"'#10'     inkscape:window-x="-8"'#10'     inkscape' +
          ':window-y="-8"'#10'     inkscape:window-maximized="1"'#10'     inkscape:' +
          'current-layer="layer36"'#10'     showguides="true"><inkscape:page'#10'  ' +
          '     x="0"'#10'       y="0"'#10'       width="48"'#10'       height="48"'#10'   ' +
          '    id="page689"'#10'       inkscape:label="StrokeIM"'#10'       inkscap' +
          'e:export-filename="..\HeatNavigator\StrokeIM.png"'#10'       inkscap' +
          'e:export-xdpi="96"'#10'       inkscape:export-ydpi="96"'#10'       margi' +
          'n="0"'#10'       bleed="0" /></sodipodi:namedview><g'#10'     inkscape:g' +
          'roupmode="layer"'#10'     id="layer31"'#10'     inkscape:label="STROKES ' +
          'UPDATED"'#10'     transform="translate(-638,-48)"><g'#10'       inkscape' +
          ':groupmode="layer"'#10'       id="layer35"'#10'       inkscape:label="IM' +
          '"'#10'       transform="translate(-1.08939,-0.478445)"><path'#10'       ' +
          '  d="m 644.35034,95.518935 q -1.49912,0 -2.62346,-1.152024 -1.12' +
          '434,-1.152024 -1.12434,-2.688058 V 53.278036 q 0,-1.536032 1.124' +
          '34,-2.688057 1.12434,-1.152024 2.62346,-1.152024 h 37.4781 q 1.4' +
          '9912,0 2.62346,1.152024 1.12434,1.152025 1.12434,2.688057 v 38.4' +
          '00817 q 0,1.536034 -1.12434,2.688058 -1.12434,1.152024 -2.62346,' +
          '1.152024 z m 0,-3.840082 h 37.4781 V 53.278036 h -37.4781 z"'#10'   ' +
          '      id="path1677-2-8"'#10'         style="stroke-width:1.26455" />' +
          '<text'#10'         xml:space="preserve"'#10'         style="font-size:35' +
          '.9858px;line-height:1.25;font-family:sans-serif;fill:#afe9c6;fil' +
          'l-opacity:1;stroke:#000000;stroke-width:1.39524;stroke-dasharray' +
          ':none;stroke-opacity:1"'#10'         x="852.09442"'#10'         y="67.23' +
          '0682"'#10'         id="text1826-8-7"'#10'         transform="scale(0.756' +
          '8054,1.3213436)"><tspan'#10'           sodipodi:role="line"'#10'        ' +
          '   id="tspan1824-24-8"'#10'           x="852.09442"'#10'           y="67' +
          '.230682"'#10'           style="font-style:normal;font-variant:normal' +
          ';font-weight:900;font-stretch:normal;font-size:35.9858px;font-fa' +
          'mily:'#39'Segoe UI'#39';-inkscape-font-specification:'#39'Segoe UI, Heavy'#39';f' +
          'ont-variant-ligatures:normal;font-variant-caps:normal;font-varia' +
          'nt-numeric:normal;font-variant-east-asian:normal;fill:#afe9c6;fi' +
          'll-opacity:1;stroke:#000000;stroke-width:1.39524;stroke-dasharra' +
          'y:none;stroke-opacity:1">IM</tspan></text><text'#10'         xml:spa' +
          'ce="preserve"'#10'         style="font-size:32.6591px;line-height:1.' +
          '25;font-family:sans-serif;fill:#e9ddaf;fill-opacity:1;stroke:#00' +
          '0000;stroke-width:1.26626;stroke-dasharray:none;stroke-opacity:1' +
          '"'#10'         x="938.86609"'#10'         y="27.697002"'#10'         id="tex' +
          't1826-8-2-0"'#10'         transform="matrix(0.83389371,0,0,1.4559359' +
          ',-138.04486,48.509777)"'#10'         mask="url(#mask3638-4)"><tspan'#10 +
          '           sodipodi:role="line"'#10'           id="tspan1824-24-9-6"' +
          #10'           x="938.86609"'#10'           y="27.697002"'#10'           st' +
          'yle="font-style:normal;font-variant:normal;font-weight:900;font-' +
          'stretch:normal;font-size:32.6591px;font-family:'#39'Segoe UI'#39';-inksc' +
          'ape-font-specification:'#39'Segoe UI, Heavy'#39';font-variant-ligatures:' +
          'normal;font-variant-caps:normal;font-variant-numeric:normal;font' +
          '-variant-east-asian:normal;fill:#e9ddaf;fill-opacity:1;stroke:#0' +
          '00000;stroke-width:1.26626;stroke-dasharray:none;stroke-opacity:' +
          '1">IM</tspan></text><text'#10'         xml:space="preserve"'#10'        ' +
          ' style="font-size:32.6591px;line-height:1.25;font-family:sans-se' +
          'rif;fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:1.26' +
          '626;stroke-dasharray:none;stroke-opacity:1"'#10'         x="938.8660' +
          '9"'#10'         y="27.697002"'#10'         id="text1826-8-1-9"'#10'         ' +
          'transform="matrix(0.85682424,0,0,1.4822189,-160.73671,47.771337)' +
          '"'#10'         mask="url(#mask3879-0)"><tspan'#10'           sodipodi:ro' +
          'le="line"'#10'           id="tspan1824-24-3-3"'#10'           x="938.866' +
          '09"'#10'           y="27.697002"'#10'           style="font-style:normal' +
          ';font-variant:normal;font-weight:900;font-stretch:normal;font-si' +
          'ze:32.6591px;font-family:'#39'Segoe UI'#39';-inkscape-font-specification' +
          ':'#39'Segoe UI, Heavy'#39';font-variant-ligatures:normal;font-variant-ca' +
          'ps:normal;font-variant-numeric:normal;font-variant-east-asian:no' +
          'rmal;fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:1.2' +
          '6626;stroke-dasharray:none;stroke-opacity:1">IM</tspan></text><t' +
          'ext'#10'         xml:space="preserve"'#10'         style="font-size:32.6' +
          '591px;line-height:1.25;font-family:sans-serif;display:inline;fil' +
          'l:#e9afaf;fill-opacity:1;stroke:#000000;stroke-width:1.26626;str' +
          'oke-dasharray:none;stroke-opacity:1"'#10'         x="938.86609"'#10'    ' +
          '     y="27.697002"'#10'         id="text1826-8-3-1"'#10'         transfo' +
          'rm="matrix(0.8589631,0,0,1.4305987,-162.82191,48.621134)"'#10'      ' +
          '   mask="url(#mask4336-2)"><tspan'#10'           sodipodi:role="line' +
          '"'#10'           id="tspan1824-24-4-9"'#10'           x="938.86609"'#10'    ' +
          '       y="27.697002"'#10'           style="font-style:normal;font-va' +
          'riant:normal;font-weight:900;font-stretch:normal;font-size:32.65' +
          '91px;font-family:'#39'Segoe UI'#39';-inkscape-font-specification:'#39'Segoe ' +
          'UI, Heavy'#39';font-variant-ligatures:normal;font-variant-caps:norma' +
          'l;font-variant-numeric:normal;font-variant-east-asian:normal;fil' +
          'l:#e9afaf;fill-opacity:1;stroke:#000000;stroke-width:1.26626;str' +
          'oke-dasharray:none;stroke-opacity:1">IM</tspan></text></g></g></' +
          'svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_StrokeFSRelay'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8" /><sodipodi:namedview'#10'     id="namedview6"'#10'     pagecolor=' +
          '"#ffffff"'#10'     bordercolor="#666666"'#10'     borderopacity="1.0"'#10'  ' +
          '   inkscape:showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10' ' +
          '    inkscape:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1' +
          'd1"'#10'     showgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:c' +
          'x="587.875"'#10'     inkscape:cy="92.125001"'#10'     inkscape:window-wi' +
          'dth="2560"'#10'     inkscape:window-height="1377"'#10'     inkscape:wind' +
          'ow-x="-8"'#10'     inkscape:window-y="-8"'#10'     inkscape:window-maxim' +
          'ized="1"'#10'     inkscape:current-layer="layer36"'#10'     showguides="' +
          'true"><inkscape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"' +
          #10'       height="48"'#10'       id="page1"'#10'       margin="0"'#10'       b' +
          'leed="0"'#10'       inkscape:label="StrokeFSRelay" /></sodipodi:name' +
          'dview><g'#10'     inkscape:groupmode="layer"'#10'     id="layer31"'#10'     ' +
          'inkscape:label="STROKES UPDATED"'#10'     transform="translate(-406,' +
          '-103.5)"><g'#10'       inkscape:groupmode="layer"'#10'       id="layer30' +
          '"'#10'       inkscape:label="FS"'#10'       style="display:inline"><path' +
          #10'         d="m 411.19046,150.52895 q -1.49912,0 -2.62346,-1.1520' +
          '2 -1.12434,-1.15202 -1.12434,-2.68806 v -38.40082 q 0,-1.53603 1' +
          '.12434,-2.68806 1.12434,-1.15202 2.62346,-1.15202 h 37.4781 q 1.' +
          '49912,0 2.62346,1.15202 1.12434,1.15203 1.12434,2.68806 v 38.400' +
          '82 q 0,1.53604 -1.12434,2.68806 -1.12434,1.15202 -2.62346,1.1520' +
          '2 z m 0,-3.84008 h 37.4781 v -38.40082 h -37.4781 z"'#10'         id' +
          '="path1677-81-9"'#10'         style="display:inline;stroke-width:1.2' +
          '6455" /><circle'#10'         style="display:inline;fill:#ff7f2a;stro' +
          'ke-width:4.69081;stroke-miterlimit:0;stroke-dashoffset:0.8406;pa' +
          'int-order:markers stroke fill"'#10'         id="path6"'#10'         cx="' +
          '420.5"'#10'         cy="117.51047"'#10'         r="13"'#10'         inkscape' +
          ':label="Circle-RELAY" /><text'#10'         xml:space="preserve"'#10'    ' +
          '     style="font-size:38.894px;line-height:1.25;font-family:sans' +
          '-serif;display:inline;fill:#afe9c6;fill-opacity:1;stroke:#000000' +
          ';stroke-width:1.508;stroke-dasharray:none;stroke-opacity:1"'#10'    ' +
          '     x="499.98145"'#10'         y="118.50774"'#10'         id="text1826-' +
          '2-8"'#10'         transform="scale(0.82274929,1.2154371)"><tspan'#10'   ' +
          '        sodipodi:role="line"'#10'           id="tspan1824-1-1"'#10'     ' +
          '      x="499.98145"'#10'           y="118.50774"'#10'           style="f' +
          'ont-style:normal;font-variant:normal;font-weight:900;font-stretc' +
          'h:normal;font-size:38.894px;font-family:'#39'Segoe UI'#39';-inkscape-fon' +
          't-specification:'#39'Segoe UI, Heavy'#39';font-variant-ligatures:normal;' +
          'font-variant-caps:normal;font-variant-numeric:normal;font-varian' +
          't-east-asian:normal;fill:#afe9c6;fill-opacity:1;stroke:#000000;s' +
          'troke-width:1.508;stroke-dasharray:none;stroke-opacity:1">FS</ts' +
          'pan></text></g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_StrokeBKRelay'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8" /><sodipodi:namedview'#10'     id="namedview6"'#10'     pagecolor=' +
          '"#ffffff"'#10'     bordercolor="#666666"'#10'     borderopacity="1.0"'#10'  ' +
          '   inkscape:showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10' ' +
          '    inkscape:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1' +
          'd1"'#10'     showgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:c' +
          'x="587.875"'#10'     inkscape:cy="92.125001"'#10'     inkscape:window-wi' +
          'dth="2560"'#10'     inkscape:window-height="1377"'#10'     inkscape:wind' +
          'ow-x="-8"'#10'     inkscape:window-y="-8"'#10'     inkscape:window-maxim' +
          'ized="1"'#10'     inkscape:current-layer="layer36"'#10'     showguides="' +
          'true"><inkscape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"' +
          #10'       height="48"'#10'       id="page3"'#10'       margin="0"'#10'       b' +
          'leed="0"'#10'       inkscape:label="StrokeBKRelay" /></sodipodi:name' +
          'dview><g'#10'     inkscape:groupmode="layer"'#10'     id="layer31"'#10'     ' +
          'inkscape:label="STROKES UPDATED"'#10'     transform="translate(-522,' +
          '-105.5)"><g'#10'       inkscape:groupmode="layer"'#10'       id="layer33' +
          '"'#10'       inkscape:label="BK"><path'#10'         d="m 527.26095,152.5' +
          '4049 q -1.49912,0 -2.62346,-1.15202 -1.12434,-1.15203 -1.12434,-' +
          '2.68806 v -38.40082 q 0,-1.53603 1.12434,-2.68806 1.12434,-1.152' +
          '02 2.62346,-1.15202 h 37.4781 q 1.49912,0 2.62346,1.15202 1.1243' +
          '4,1.15203 1.12434,2.68806 v 38.40082 q 0,1.53603 -1.12434,2.6880' +
          '6 -1.12434,1.15202 -2.62346,1.15202 z m 0,-3.84008 h 37.4781 v -' +
          '38.40082 h -37.4781 z"'#10'         id="path1677-6-4-9"'#10'         sty' +
          'le="stroke-width:1.26455" /><circle'#10'         style="display:inli' +
          'ne;fill:#ff7f2a;stroke-width:4.69081;stroke-miterlimit:0;stroke-' +
          'dashoffset:0.8406;paint-order:markers stroke fill"'#10'         id="' +
          'path6-2"'#10'         cx="536.5"'#10'         cy="119.4375"'#10'         r="' +
          '13"'#10'         inkscape:label="Circle-RELAY" /><text'#10'         xml:' +
          'space="preserve"'#10'         style="font-size:34.4505px;line-height' +
          ':1.25;font-family:sans-serif;fill:#e9afaf;fill-opacity:1;stroke:' +
          '#000000;stroke-width:1.33572;stroke-dasharray:none;stroke-opacit' +
          'y:1"'#10'         x="727.60181"'#10'         y="105.73994"'#10'         id="' +
          'text1826-3-1-8"'#10'         transform="scale(0.72500807,1.379295)">' +
          '<tspan'#10'           sodipodi:role="line"'#10'           id="tspan1824-' +
          '2-3-3"'#10'           x="727.60181"'#10'           y="105.73994"'#10'       ' +
          '    style="font-style:normal;font-variant:normal;font-weight:900' +
          ';font-stretch:normal;font-size:34.4505px;font-family:'#39'Segoe UI'#39';' +
          '-inkscape-font-specification:'#39'Segoe UI, Heavy'#39';font-variant-liga' +
          'tures:normal;font-variant-caps:normal;font-variant-numeric:norma' +
          'l;font-variant-east-asian:normal;fill:#e9afaf;fill-opacity:1;str' +
          'oke:#000000;stroke-width:1.33572;stroke-dasharray:none;stroke-op' +
          'acity:1">BK</tspan></text></g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_StrokeBRRelay'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8" /><sodipodi:namedview'#10'     id="namedview6"'#10'     pagecolor=' +
          '"#ffffff"'#10'     bordercolor="#666666"'#10'     borderopacity="1.0"'#10'  ' +
          '   inkscape:showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10' ' +
          '    inkscape:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1' +
          'd1"'#10'     showgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:c' +
          'x="587.875"'#10'     inkscape:cy="92.125001"'#10'     inkscape:window-wi' +
          'dth="2560"'#10'     inkscape:window-height="1377"'#10'     inkscape:wind' +
          'ow-x="-8"'#10'     inkscape:window-y="-8"'#10'     inkscape:window-maxim' +
          'ized="1"'#10'     inkscape:current-layer="layer36"'#10'     showguides="' +
          'true"><inkscape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"' +
          #10'       height="48"'#10'       id="page2"'#10'       margin="0"'#10'       b' +
          'leed="0"'#10'       inkscape:label="StrokeBRRelay" /></sodipodi:name' +
          'dview><g'#10'     inkscape:groupmode="layer"'#10'     id="layer31"'#10'     ' +
          'inkscape:label="STROKES UPDATED"'#10'     transform="translate(-464.' +
          '75,-104.5)"><g'#10'       inkscape:groupmode="layer"'#10'       id="laye' +
          'r32"'#10'       inkscape:label="BS"'#10'       transform="translate(0.17' +
          '475,0.051885)"><path'#10'         d="m 469.83619,151.48864 q -1.4991' +
          '2,0 -2.62346,-1.15202 -1.12434,-1.15202 -1.12434,-2.68806 v -38.' +
          '40081 q 0,-1.53604 1.12434,-2.68806 1.12434,-1.15202 2.62346,-1.' +
          '15202 h 37.4781 q 1.49912,0 2.62346,1.15202 1.12434,1.15202 1.12' +
          '434,2.68806 v 38.40081 q 0,1.53604 -1.12434,2.68806 -1.12434,1.1' +
          '5202 -2.62346,1.15202 z m 0,-3.84008 h 37.4781 v -38.40081 h -37' +
          '.4781 z"'#10'         id="path1677-8-6-0"'#10'         style="stroke-wid' +
          'th:1.26455" /><circle'#10'         style="display:inline;fill:#ff7f2' +
          'a;stroke-width:4.69081;stroke-miterlimit:0;stroke-dashoffset:0.8' +
          '406;paint-order:markers stroke fill"'#10'         id="path6-4"'#10'     ' +
          '    cx="479.07526"'#10'         cy="118.38562"'#10'         r="13"'#10'     ' +
          '    inkscape:label="Circle-RELAY" /><text'#10'         xml:space="pr' +
          'eserve"'#10'         style="font-size:35.8277px;line-height:1.25;fon' +
          't-family:sans-serif;fill:#afdde9;fill-opacity:1;stroke:#000000;s' +
          'troke-width:1.38944;stroke-dasharray:none;stroke-opacity:1"'#10'    ' +
          '     x="621.31628"'#10'         y="109.55031"'#10'         id="text1826-' +
          '9-6-5"'#10'         transform="scale(0.75522409,1.3241103)"><tspan'#10' ' +
          '          sodipodi:role="line"'#10'           id="tspan1824-7-0-6"'#10' ' +
          '          x="621.31628"'#10'           y="109.55031"'#10'           styl' +
          'e="font-style:normal;font-variant:normal;font-weight:900;font-st' +
          'retch:normal;font-size:35.8277px;font-family:'#39'Segoe UI'#39';-inkscap' +
          'e-font-specification:'#39'Segoe UI, Heavy'#39';font-variant-ligatures:no' +
          'rmal;font-variant-caps:normal;font-variant-numeric:normal;font-v' +
          'ariant-east-asian:normal;fill:#afdde9;fill-opacity:1;stroke:#000' +
          '000;stroke-width:1.38944;stroke-dasharray:none;stroke-opacity:1"' +
          '>BR</tspan></text></g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_StrokeBFRelay'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8" /><sodipodi:namedview'#10'     id="namedview6"'#10'     pagecolor=' +
          '"#ffffff"'#10'     bordercolor="#666666"'#10'     borderopacity="1.0"'#10'  ' +
          '   inkscape:showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10' ' +
          '    inkscape:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1' +
          'd1"'#10'     showgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:c' +
          'x="587.875"'#10'     inkscape:cy="92.125001"'#10'     inkscape:window-wi' +
          'dth="2560"'#10'     inkscape:window-height="1377"'#10'     inkscape:wind' +
          'ow-x="-8"'#10'     inkscape:window-y="-8"'#10'     inkscape:window-maxim' +
          'ized="1"'#10'     inkscape:current-layer="layer36"'#10'     showguides="' +
          'true"><inkscape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"' +
          #10'       height="48"'#10'       id="page4"'#10'       margin="0"'#10'       b' +
          'leed="0"'#10'       inkscape:label="StrokeBFRelay" /></sodipodi:name' +
          'dview><g'#10'     inkscape:groupmode="layer"'#10'     id="layer31"'#10'     ' +
          'inkscape:label="STROKES UPDATED"'#10'     transform="translate(-579.' +
          '625,-105.5)"><g'#10'       inkscape:groupmode="layer"'#10'       id="lay' +
          'er34"'#10'       inkscape:label="BF"><path'#10'         d="m 584.88595,1' +
          '52.54049 q -1.49912,0 -2.62346,-1.15202 -1.12434,-1.15203 -1.124' +
          '34,-2.68806 v -38.40082 q 0,-1.53603 1.12434,-2.68806 1.12434,-1' +
          '.15202 2.62346,-1.15202 h 37.4781 q 1.49912,0 2.62346,1.15202 1.' +
          '12434,1.15203 1.12434,2.68806 v 38.40082 q 0,1.53603 -1.12434,2.' +
          '68806 -1.12434,1.15202 -2.62346,1.15202 z m 0,-3.84008 h 37.4781' +
          ' v -38.40082 h -37.4781 z"'#10'         id="path1677-1-5-4"'#10'        ' +
          ' style="stroke-width:1.26455" /><circle'#10'         style="display:' +
          'inline;fill:#ff7f2a;stroke-width:4.69081;stroke-miterlimit:0;str' +
          'oke-dashoffset:0.8406;paint-order:markers stroke fill"'#10'         ' +
          'id="path6-8"'#10'         cx="594.125"'#10'         cy="119.5"'#10'         ' +
          'r="13"'#10'         inkscape:label="Circle-RELAY" /><text'#10'         x' +
          'ml:space="preserve"'#10'         style="font-size:36.7533px;line-hei' +
          'ght:1.25;font-family:sans-serif;fill:#e9ddaf;fill-opacity:1;stro' +
          'ke:#000000;stroke-width:1.425;stroke-dasharray:none;stroke-opaci' +
          'ty:1"'#10'         x="755.02032"'#10'         y="113.07894"'#10'         id=' +
          '"text1826-91-3-6"'#10'         transform="scale(0.77557023,1.2893739' +
          ')"><tspan'#10'           sodipodi:role="line"'#10'           id="tspan18' +
          '24-9-5-5"'#10'           x="755.02032"'#10'           y="113.07894"'#10'    ' +
          '       style="font-style:normal;font-variant:normal;font-weight:' +
          '900;font-stretch:normal;font-size:36.7533px;font-family:'#39'Segoe U' +
          'I'#39';-inkscape-font-specification:'#39'Segoe UI, Heavy'#39';font-variant-l' +
          'igatures:normal;font-variant-caps:normal;font-variant-numeric:no' +
          'rmal;font-variant-east-asian:normal;fill:#e9ddaf;fill-opacity:1;' +
          'stroke:#000000;stroke-width:1.425;stroke-dasharray:none;stroke-o' +
          'pacity:1">BF</tspan></text></g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_StrokeIMRelay'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   sodipo' +
          'di:docname="TabSheetHeatsImages.svg"'#10'   xml:space="preserve"'#10'   ' +
          'inkscape:version="1.3 (0e150ed6c4, 2023-07-21)"'#10'   inkscape:expo' +
          'rt-batch-path="..\SVG_UI_Collection"'#10'   inkscape:export-batch-na' +
          'me="TabSheetHeatsImages"'#10'   xmlns:inkscape="http://www.inkscape.' +
          'org/namespaces/inkscape"'#10'   xmlns:sodipodi="http://sodipodi.sour' +
          'ceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns="http://www.w3.org/2000' +
          '/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg"><defs'#10'     id="d' +
          'efs8"><mask'#10'       maskUnits="userSpaceOnUse"'#10'       id="mask433' +
          '6-2-3"><path'#10'         style="fill:#ffffff;fill-opacity:1;stroke:' +
          'none;stroke-width:0.98773px;stroke-linecap:butt;stroke-linejoin:' +
          'miter;stroke-opacity:1"'#10'         d="M 999.75352,-0.03367105 999.' +
          '68431,16.477347 H 965.55998 L 965.49289,0.12524158 Z"'#10'         i' +
          'd="path4338-9-5" /></mask><mask'#10'       maskUnits="userSpaceOnUse' +
          '"'#10'       id="mask3879-0-0"><path'#10'         style="fill:#ffffff;fi' +
          'll-opacity:1;stroke:none;stroke-width:0.995918px;stroke-linecap:' +
          'butt;stroke-linejoin:miter;stroke-opacity:1"'#10'         d="m 1000.' +
          '4149,16.252457 -0.071,16.496134 h -34.72337 l -0.0682,-16.337365' +
          ' z"'#10'         id="path3881-1-8" /></mask><mask'#10'       maskUnits="' +
          'userSpaceOnUse"'#10'       id="mask3638-4-4"><path'#10'         style="f' +
          'ill:#ffffff;fill-opacity:1;stroke:none;stroke-width:0.995918px;s' +
          'troke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"'#10'     ' +
          '    d="m 965.5527,16.252457 -0.0706,16.496134 h -34.72342 l -0.0' +
          '682,-16.337365 z"'#10'         id="path3640-4-5" /></mask></defs><so' +
          'dipodi:namedview'#10'     id="namedview6"'#10'     pagecolor="#ffffff"'#10' ' +
          '    bordercolor="#666666"'#10'     borderopacity="1.0"'#10'     inkscape' +
          ':showpageshadow="2"'#10'     inkscape:pageopacity="0.0"'#10'     inkscap' +
          'e:pagecheckerboard="0"'#10'     inkscape:deskcolor="#d1d1d1"'#10'     sh' +
          'owgrid="false"'#10'     inkscape:zoom="4"'#10'     inkscape:cx="587.875"' +
          #10'     inkscape:cy="92.125001"'#10'     inkscape:window-width="2560"'#10 +
          '     inkscape:window-height="1377"'#10'     inkscape:window-x="-8"'#10' ' +
          '    inkscape:window-y="-8"'#10'     inkscape:window-maximized="1"'#10'  ' +
          '   inkscape:current-layer="layer36"'#10'     showguides="true"><inks' +
          'cape:page'#10'       x="0"'#10'       y="0"'#10'       width="48"'#10'       hei' +
          'ght="48"'#10'       id="page5"'#10'       margin="0"'#10'       bleed="0"'#10'  ' +
          '     inkscape:label="StrokeIMRelay" /></sodipodi:namedview><g'#10'  ' +
          '   inkscape:groupmode="layer"'#10'     id="layer31"'#10'     inkscape:la' +
          'bel="STROKES UPDATED"'#10'     transform="translate(-638,-106.25)"><' +
          'g'#10'       inkscape:groupmode="layer"'#10'       id="layer35"'#10'       i' +
          'nkscape:label="IM"'#10'       transform="translate(-1.08939,-0.47844' +
          '5)"><path'#10'         d="m 644.35034,153.76893 q -1.49912,0 -2.6234' +
          '6,-1.15202 -1.12434,-1.15201 -1.12434,-2.68806 v -38.40081 q 0,-' +
          '1.53604 1.12434,-2.68806 1.12434,-1.15203 2.62346,-1.15203 h 37.' +
          '4781 q 1.49912,0 2.62346,1.15203 1.12434,1.15202 1.12434,2.68806' +
          ' v 38.40081 q 0,1.53605 -1.12434,2.68806 -1.12434,1.15202 -2.623' +
          '46,1.15202 z m 0,-3.84008 h 37.4781 v -38.40081 h -37.4781 z"'#10'  ' +
          '       id="path1677-2-8-3"'#10'         style="stroke-width:1.26455"' +
          ' /><circle'#10'         style="display:inline;fill:#ff7f2a;stroke-wi' +
          'dth:4.69081;stroke-miterlimit:0;stroke-dashoffset:0.8406;paint-o' +
          'rder:markers stroke fill"'#10'         id="path6-6"'#10'         cx="653' +
          '.58942"'#10'         cy="120.60344"'#10'         r="13"'#10'         inkscap' +
          'e:label="Circle-RELAY" /><text'#10'         xml:space="preserve"'#10'   ' +
          '      style="font-size:35.9858px;line-height:1.25;font-family:sa' +
          'ns-serif;fill:#afe9c6;fill-opacity:1;stroke:#000000;stroke-width' +
          ':1.39524;stroke-dasharray:none;stroke-opacity:1"'#10'         x="852' +
          '.09442"'#10'         y="111.3146"'#10'         id="text1826-8-7-7"'#10'     ' +
          '    transform="scale(0.75680542,1.3213436)"><tspan'#10'           so' +
          'dipodi:role="line"'#10'           id="tspan1824-24-8-8"'#10'           x' +
          '="852.09442"'#10'           y="111.3146"'#10'           style="font-styl' +
          'e:normal;font-variant:normal;font-weight:900;font-stretch:normal' +
          ';font-size:35.9858px;font-family:'#39'Segoe UI'#39';-inkscape-font-speci' +
          'fication:'#39'Segoe UI, Heavy'#39';font-variant-ligatures:normal;font-va' +
          'riant-caps:normal;font-variant-numeric:normal;font-variant-east-' +
          'asian:normal;fill:#afe9c6;fill-opacity:1;stroke:#000000;stroke-w' +
          'idth:1.39524;stroke-dasharray:none;stroke-opacity:1">IM</tspan><' +
          '/text><text'#10'         xml:space="preserve"'#10'         style="font-s' +
          'ize:32.6591px;line-height:1.25;font-family:sans-serif;fill:#e9dd' +
          'af;fill-opacity:1;stroke:#000000;stroke-width:1.26626;stroke-das' +
          'harray:none;stroke-opacity:1"'#10'         x="938.86609"'#10'         y=' +
          '"27.697002"'#10'         id="text1826-8-2-0-4"'#10'         transform="m' +
          'atrix(0.83389371,0,0,1.4559359,-138.04486,106.75978)"'#10'         m' +
          'ask="url(#mask3638-4-4)"><tspan'#10'           sodipodi:role="line"'#10 +
          '           id="tspan1824-24-9-6-6"'#10'           x="938.86609"'#10'    ' +
          '       y="27.697002"'#10'           style="font-style:normal;font-va' +
          'riant:normal;font-weight:900;font-stretch:normal;font-size:32.65' +
          '91px;font-family:'#39'Segoe UI'#39';-inkscape-font-specification:'#39'Segoe ' +
          'UI, Heavy'#39';font-variant-ligatures:normal;font-variant-caps:norma' +
          'l;font-variant-numeric:normal;font-variant-east-asian:normal;fil' +
          'l:#e9ddaf;fill-opacity:1;stroke:#000000;stroke-width:1.26626;str' +
          'oke-dasharray:none;stroke-opacity:1">IM</tspan></text><text'#10'    ' +
          '     xml:space="preserve"'#10'         style="font-size:32.6591px;li' +
          'ne-height:1.25;font-family:sans-serif;fill:#afdde9;fill-opacity:' +
          '1;stroke:#000000;stroke-width:1.26626;stroke-dasharray:none;stro' +
          'ke-opacity:1"'#10'         x="938.86609"'#10'         y="27.697002"'#10'    ' +
          '     id="text1826-8-1-9-5"'#10'         transform="matrix(0.85682424' +
          ',0,0,1.4822189,-160.73671,106.02134)"'#10'         mask="url(#mask38' +
          '79-0-0)"><tspan'#10'           sodipodi:role="line"'#10'           id="t' +
          'span1824-24-3-3-4"'#10'           x="938.86609"'#10'           y="27.697' +
          '002"'#10'           style="font-style:normal;font-variant:normal;fon' +
          't-weight:900;font-stretch:normal;font-size:32.6591px;font-family' +
          ':'#39'Segoe UI'#39';-inkscape-font-specification:'#39'Segoe UI, Heavy'#39';font-' +
          'variant-ligatures:normal;font-variant-caps:normal;font-variant-n' +
          'umeric:normal;font-variant-east-asian:normal;fill:#afdde9;fill-o' +
          'pacity:1;stroke:#000000;stroke-width:1.26626;stroke-dasharray:no' +
          'ne;stroke-opacity:1">IM</tspan></text><text'#10'         xml:space="' +
          'preserve"'#10'         style="font-size:32.6591px;line-height:1.25;f' +
          'ont-family:sans-serif;display:inline;fill:#e9afaf;fill-opacity:1' +
          ';stroke:#000000;stroke-width:1.26626;stroke-dasharray:none;strok' +
          'e-opacity:1"'#10'         x="938.86609"'#10'         y="27.697002"'#10'     ' +
          '    id="text1826-8-3-1-0"'#10'         transform="matrix(0.8589631,0' +
          ',0,1.4305987,-162.82191,106.87114)"'#10'         mask="url(#mask4336' +
          '-2-3)"><tspan'#10'           sodipodi:role="line"'#10'           id="tsp' +
          'an1824-24-4-9-7"'#10'           x="938.86609"'#10'           y="27.69700' +
          '2"'#10'           style="font-style:normal;font-variant:normal;font-' +
          'weight:900;font-stretch:normal;font-size:32.6591px;font-family:'#39 +
          'Segoe UI'#39';-inkscape-font-specification:'#39'Segoe UI, Heavy'#39';font-va' +
          'riant-ligatures:normal;font-variant-caps:normal;font-variant-num' +
          'eric:normal;font-variant-east-asian:normal;fill:#e9afaf;fill-opa' +
          'city:1;stroke:#000000;stroke-width:1.26626;stroke-dasharray:none' +
          ';stroke-opacity:1">IM</tspan></text></g></g></svg>'#10
      end
      item
        IconName = 'TabSheetHeatsImages_RELAY_DOT'
        SVGText = 
          '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'#10'<svg'#10'   h' +
          'eight="48"'#10'   width="48"'#10'   version="1.1"'#10'   id="svg4"'#10'   xml:sp' +
          'ace="preserve"'#10'   xmlns="http://www.w3.org/2000/svg"'#10'   xmlns:sv' +
          'g="http://www.w3.org/2000/svg"><defs'#10'     id="defs8" /><g'#10'     i' +
          'd="layer36"'#10'     transform="translate(-701.65186,-107.37794)"><c' +
          'ircle'#10'       style="display:inline;opacity:0.585502;fill:#ff7f2a' +
          ';stroke-width:8.65996;stroke-miterlimit:0;stroke-dashoffset:0.84' +
          '06;paint-order:markers stroke fill"'#10'       id="path6-89"'#10'       ' +
          'cx="725.65179"'#10'       cy="131.37793"'#10'       r="24" /><text'#10'     ' +
          '  xml:space="preserve"'#10'       style="font-style:normal;font-vari' +
          'ant:normal;font-weight:bold;font-stretch:normal;font-size:50.035' +
          '5px;line-height:1.25;font-family:'#39'Segoe UI'#39';-inkscape-font-speci' +
          'fication:'#39'Segoe UI Bold'#39';fill:#5c1c06;fill-opacity:1;stroke-widt' +
          'h:0.938167"'#10'       x="723.53979"'#10'       y="146.19522"'#10'       id=' +
          '"text6"'#10'       transform="scale(0.98084826,1.0195257)"><tspan'#10'  ' +
          '       id="tspan6"'#10'         x="723.53979"'#10'         y="146.19522"' +
          #10'         style="font-style:normal;font-variant:normal;font-weig' +
          'ht:bold;font-stretch:normal;font-size:50.0355px;font-family:'#39'Seg' +
          'oe UI'#39';-inkscape-font-specification:'#39'Segoe UI Bold'#39';fill:#5c1c06' +
          ';fill-opacity:1;stroke-width:0.938167">R</tspan></text></g></svg' +
          '>'#10
      end>
    Left = 512
    Top = 568
  end
end
