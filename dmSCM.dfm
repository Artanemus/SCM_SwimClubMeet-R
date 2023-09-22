object SCM: TSCM
  OnCreate = DataModuleCreate
  Height = 748
  Width = 1376
  object scmConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=MSSQL_SwimClubMeet')
    ConnectedStoredUsage = [auDesignTime]
    Connected = True
    LoginPrompt = False
    AfterDisconnect = scmConnectionAfterDisconnect
    Left = 80
    Top = 32
  end
  object dsSwimClub: TDataSource
    DataSet = qrySwimClub
    Left = 112
    Top = 96
  end
  object dsSession: TDataSource
    DataSet = qrySession
    Left = 112
    Top = 200
  end
  object dsEvent: TDataSource
    DataSet = qryEvent
    Left = 112
    Top = 256
  end
  object tblStroke: TFDTable
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'StrokeID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Stroke'
    UpdateOptions.KeyFields = 'StrokeID'
    TableName = 'SwimClubMeet..Stroke'
    Left = 744
    Top = 72
  end
  object tblGender: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'GenderID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'Gender'
    UpdateOptions.KeyFields = 'GenderID'
    TableName = 'Gender'
    Left = 744
    Top = 264
  end
  object tblDistance: TFDTable
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'DistanceID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Distance'
    UpdateOptions.KeyFields = 'DistanceID'
    TableName = 'SwimClubMeet..Distance'
    Left = 744
    Top = 120
  end
  object luStroke: TDataSource
    DataSet = tblStroke
    Left = 848
    Top = 72
  end
  object luGender: TDataSource
    DataSet = tblGender
    Left = 848
    Top = 264
  end
  object luDistance: TDataSource
    DataSet = tblDistance
    Left = 848
    Top = 120
  end
  object tblEventType: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EventTypeID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..EventType'
    UpdateOptions.KeyFields = 'EventTypeID'
    TableName = 'SwimClubMeet..EventType'
    Left = 744
    Top = 168
  end
  object luEventType: TDataSource
    DataSet = tblEventType
    Left = 848
    Top = 168
  end
  object dsHeat: TDataSource
    DataSet = qryHeat
    Left = 112
    Top = 312
  end
  object tblHeatType: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HeatTypeID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..HeatType'
    UpdateOptions.KeyFields = 'HeatTypeID'
    TableName = 'SwimClubMeet..HeatType'
    Left = 744
    Top = 312
  end
  object luHeatType: TDataSource
    DataSet = tblHeatType
    Left = 848
    Top = 312
  end
  object dsMember: TDataSource
    DataSet = qryMember
    Left = 280
    Top = 96
  end
  object tblEventStatus: TFDTable
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'EventStatusID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..EventStatus'
    UpdateOptions.KeyFields = 'EventStatusID'
    TableName = 'SwimClubMeet..EventStatus'
    Left = 744
    Top = 216
  end
  object luEventStatus: TDataSource
    DataSet = tblEventStatus
    Left = 848
    Top = 216
  end
  object qryNominateEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SessionID;EventID'
    MasterSource = dsSession
    MasterFields = 'SessionID'
    DetailFields = 'SessionID'
    Connection = scmConnection
    UpdateOptions.KeyFields = 'EventID'
    SQL.Strings = (
      'SELECT EventID'
      #9',EventNum'
      #9',Event.SessionID'
      #9',EventTypeID'
      #9',Event.StrokeID'
      #9',Event.DistanceID'
      #9',EventStatusID'
      #9',CONCAT ('
      #9#9'Distance.Caption'
      #9#9','#39' '#39
      #9#9',Stroke.Caption '
      #9#9') AS DistStrokeStr'
      #9',CONCAT ('
      #9#9'Distance.Caption'
      #9#9','#39' '#39
      #9#9',Stroke.Caption '
      #9#9') AS EventStr'
      ',[Event].Caption '
      'FROM event'
      'JOIN Stroke ON Stroke.StrokeID = Event.StrokeID'
      'JOIN Distance ON Distance.DistanceID = Event.DistanceID'
      'ORDER BY Event.SessionID')
    Left = 207
    Top = 200
  end
  object dsNomateEvent: TDataSource
    DataSet = qryNominateEvent
    Left = 287
    Top = 200
  end
  object luHeatStatus: TDataSource
    DataSet = tblHeatStatus
    Left = 848
    Top = 360
  end
  object luSessionStatus: TDataSource
    DataSet = tblSessionStatus
    Left = 848
    Top = 24
  end
  object tblSessionStatus: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SessionStatusID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..SessionStatus'
    UpdateOptions.KeyFields = 'SessionStatusID'
    TableName = 'SwimClubMeet..SessionStatus'
    Left = 744
    Top = 24
  end
  object tblHeatStatus: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HeatStatusID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..HeatStatus'
    UpdateOptions.KeyFields = 'HeatStatusID'
    TableName = 'SwimClubMeet..HeatStatus'
    Left = 744
    Top = 360
  end
  object qryEntrant: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    BeforeInsert = qryEvTypeBeforeInsert
    AfterScroll = qryEntrantAfterScroll
    IndexFieldNames = 'HeatID'
    MasterSource = dsHeat
    MasterFields = 'HeatID'
    DetailFields = 'HeatID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEInsert, uvCheckRequired]
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Entrant'
    UpdateOptions.KeyFields = 'EntrantID'
    SQL.Strings = (
      '-- Format of TTime occurs in OnGetText() '#39'nn:ss.zzz'#39
      ''
      'USE SwimClubMeet'
      ''
      'DECLARE @SwimClubID AS INT;'
      'SET @SwimClubID = 1;'
      ''
      'SELECT Entrant.EntrantID'
      '     , Entrant.HeatID'
      '     , Entrant.Lane'
      '     , Entrant.RaceTime'
      '     , Entrant.TimeToBeat'
      '     , Entrant.IsDisqualified'
      '     , Entrant.IsScratched'
      '     , Entrant.MemberID'
      '     , Entrant.PersonalBest'
      '     , CASE'
      '           WHEN Member.MemberID IS NOT NULL THEN'
      '               CONCAT('
      
        '                         FORMAT(dbo.SwimmerAge(Session.SessionSt' +
        'art, Member.DOB), '#39'00'#39')'
      '                       , '#39'.'#39
      
        '                       , dbo.SwimmerGenderToString(Member.Member' +
        'ID)'
      '                       , '#39'  '#39
      '                       , Member.FirstName'
      '                       , '#39' '#39
      '                       , UPPER(Member.LastName)'
      '                     )'
      '       END AS FullName'
      '     , DisqualifyCode.ABREV AS DCode'
      '     , Entrant.DisqualifyCodeID'
      
        '     , dbo.MembersSwimmerCategory(Entrant.MemberID, @SwimClubID,' +
        ' Session.SessionStart) AS CATID'
      'FROM Entrant'
      '    LEFT OUTER JOIN Member'
      '        ON Entrant.MemberID = Member.MemberID'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN Event'
      '        ON HeatIndividual.EventID = Event.EventID'
      '    INNER JOIN Session'
      '        ON Event.SessionID = Session.SessionID'
      '    LEFT OUTER JOIN DisqualifyCode'
      
        '        ON Entrant.DisqualifyCodeID = DisqualifyCode.DisqualifyC' +
        'odeID'
      'ORDER BY Entrant.Lane'
      ''
      ''
      '')
    Left = 48
    Top = 376
    object qryEntrantHeatID: TIntegerField
      FieldName = 'HeatID'
      Origin = 'HeatID'
      Required = True
      Visible = False
    end
    object qryEntrantEntrantID: TFDAutoIncField
      FieldName = 'EntrantID'
      Origin = 'EntrantID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object qryEntrantMemberID: TIntegerField
      FieldName = 'MemberID'
      Origin = 'MemberID'
      Visible = False
    end
    object qryEntrantLane: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Lane#'
      DisplayWidth = 6
      FieldName = 'Lane'
      Origin = 'Lane'
      ReadOnly = True
      DisplayFormat = '00'
    end
    object qryEntrantFullName: TWideStringField
      DisplayLabel = 'Entrant'#39's Name'
      DisplayWidth = 34
      FieldName = 'FullName'
      Origin = 'FullName'
      ReadOnly = True
      Size = 257
    end
    object qryEntrantTIME: TTimeField
      Alignment = taRightJustify
      DisplayWidth = 10
      FieldName = 'RaceTime'
      Origin = 'RaceTime'
      OnGetText = qryEntrantTIMEGetText
      OnSetText = qryEntrantTIMESetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
    object qryEntrantTimeToBeat: TTimeField
      Alignment = taRightJustify
      DisplayWidth = 10
      FieldName = 'TimeToBeat'
      Origin = 'TimeToBeat'
      ReadOnly = True
      OnGetText = qryEntrantTIMEGetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
    object qryEntrantPersonalBest: TTimeField
      Alignment = taRightJustify
      DisplayWidth = 10
      FieldName = 'PersonalBest'
      Origin = 'PersonalBest'
      ReadOnly = True
      OnGetText = qryEntrantTIMEGetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
    object qryEntrantIsScratched: TBooleanField
      Alignment = taCenter
      DisplayLabel = ' S'
      DisplayWidth = 3
      FieldName = 'IsScratched'
      Origin = 'IsScratched'
    end
    object qryEntrantIsDisqualified: TBooleanField
      Alignment = taCenter
      DisplayLabel = ' D'
      DisplayWidth = 3
      FieldName = 'IsDisqualified'
      Origin = 'IsDisqualified'
    end
    object qryEntrantDisqualifyCodeID: TIntegerField
      FieldName = 'DisqualifyCodeID'
      Origin = 'DisqualifyCodeID'
      Visible = False
    end
    object qryEntrantDCode: TWideStringField
      FieldName = 'DCode'
      Origin = 'DCode'
      ReadOnly = True
      Size = 8
    end
    object qryEntrantluSwimmerCAT: TStringField
      DisplayLabel = 'Category'
      DisplayWidth = 9
      FieldKind = fkLookup
      FieldName = 'luCategory'
      LookupDataSet = tblSwimmerCAT
      LookupKeyFields = 'SwimmerCategoryID'
      LookupResultField = 'ABREV'
      KeyFields = 'CATID'
      Lookup = True
    end
    object qryEntrantCATID: TIntegerField
      DisplayWidth = 5
      FieldName = 'CATID'
      Origin = 'CATID'
      ReadOnly = True
      Visible = False
    end
  end
  object dsEntrant: TDataSource
    DataSet = qryEntrant
    Left = 112
    Top = 376
  end
  object qrySession: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    BeforePost = qrySessionBeforePost
    AfterPost = qrySessionAfterPost
    AfterDelete = qrySessionAfterDelete
    AfterScroll = qrySessionAfterScroll
    OnNewRecord = qrySessionNewRecord
    MasterSource = dsSwimClub
    MasterFields = 'SwimClubID'
    DetailFields = 'SwimClubID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Session'
    UpdateOptions.KeyFields = 'SessionID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @Toggle AS BIT'
      'SET @Toggle = :TOGGLE'
      ''
      'if @Toggle = 0'
      ''
      
        'SELECT Session.SessionID, Session.SessionStart, Session.SwimClub' +
        'ID, Session.SessionStatusID, Session.ClosedDT, SessionStatus.Cap' +
        'tion AS Status, Session.Caption'
      'FROM Session '
      
        'LEFT OUTER JOIN SessionStatus ON Session.SessionStatusID = Sessi' +
        'onStatus.SessionStatusID'
      'ORDER BY Session.SessionStart DESC'
      ''
      'else'
      ''
      
        'SELECT Session.SessionID, Session.SessionStart, Session.SwimClub' +
        'ID, Session.SessionStatusID,  Session.ClosedDT, SessionStatus.Ca' +
        'ption AS Status, Session.Caption'
      'FROM Session '
      
        'LEFT OUTER JOIN SessionStatus ON Session.SessionStatusID = Sessi' +
        'onStatus.SessionStatusID'
      'WHERE Session.SessionStatusID = 1'
      'ORDER BY Session.SessionStart DESC'
      '')
    Left = 48
    Top = 200
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
      ReadOnly = True
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
      OnGetText = qrySessionSessionStartGetText
      OnSetText = qrySessionSessionStartSetText
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
  object qryFName: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      ''
      'SELECT'
      'Member.MemberID,'
      
        '  SubString(Concat(Upper(Member.LastName), '#39', '#39', Member.FirstNam' +
        'e), 0, 60) AS FName'
      ''
      'FROM'
      '  Member'
      ''
      'ORDER BY'
      '  Member.LastName')
    Left = 744
    Top = 416
  end
  object luFName: TDataSource
    DataSet = qryFName
    Left = 848
    Top = 416
  end
  object qryEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    AfterInsert = qryEventAfterInsert
    BeforeEdit = qryEventBeforeEdit
    BeforePost = qryEventBeforePost
    AfterPost = qryEventAfterPost
    AfterDelete = qryEventAfterDelete
    AfterScroll = qryEventAfterScroll
    OnNewRecord = qryEventNewRecord
    IndexFieldNames = 'SessionID'
    MasterSource = dsSession
    MasterFields = 'SessionID'
    DetailFields = 'SessionID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'hh:nn'
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Event'
    UpdateOptions.KeyFields = 'EventID'
    SQL.Strings = (
      'Use SwimClubMeet;'
      ''
      'SELECT '
      '       [Event].[EventID]'
      '      ,[Event].[EventNum]'
      '      ,[Event].[Caption]'
      '      ,[Event].[ClosedDT]'
      '      ,[Event].[ScheduleDT]'
      '      ,[Event].[SessionID]'
      '      ,[Event].[StrokeID]'
      '      ,[Event].[DistanceID]'
      '      ,[Event].[EventStatusID],'
      '       qryNom.NomCount AS NomineeCount,'
      '       qryEntrants.EntrantCount AS EntrantCount,'
      
        '       Concat('#39'#'#39', Event.EventNum, '#39' - '#39', Distance.Caption, '#39' '#39',' +
        ' Stroke.Caption) AS EventStr,'
      '       Distance.Meters,'
      '       Distance.ABREV,'
      '       Distance.EventTypeID'
      'FROM Event'
      '     LEFT OUTER JOIN Stroke ON Stroke.StrokeID = Event.StrokeID'
      
        '     LEFT OUTER JOIN Distance ON Distance.DistanceID = Event.Dis' +
        'tanceID'
      #9
      
        '     LEFT JOIN (SELECT Count(Nominee.EventID) AS NomCount, Event' +
        'ID'
      '                FROM Nominee'
      
        '                GROUP BY  Nominee.EventID) qryNom ON qryNom.Even' +
        'tID = Event.EventID '
      '     LEFT JOIN (SELECT Count(Entrant.EntrantID) AS EntrantCount,'
      '                       HeatIndividual.EventID'
      '                FROM Entrant'
      
        '                     INNER JOIN HeatIndividual ON Entrant.HeatID' +
        ' = HeatIndividual.HeatID'
      '                WHERE        (Entrant.MemberID IS NOT NULL)'
      
        '                GROUP BY HeatIndividual.EventID) qryEntrants ON ' +
        'qryEntrants.EventID = Event.EventID'
      ''
      ''
      'ORDER BY Event.EventNum;'
      ''
      '/*'
      'DECLARE @Major AS INT;'
      
        'SET @Major = (SELECT Major FROM SwimClubMeet.dbo.SCMSystem WHERE' +
        ' SCMSystemID = 1);'
      'DECLARE @Minor AS INT;'
      
        'SET @Minor = (SELECT Major FROM SwimClubMeet.dbo.SCMSystem WHERE' +
        ' SCMSystemID = 1);'
      ''
      '-- Drop a temporary table called '#39'#TableName'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#TempSCMEvent'#39', '#39'U'#39') IS NOT NULL'
      'DROP TABLE #TempSCMEvent'
      ';'
      ''
      '-- Get the data into a temp table '
      '    SELECT * INTO #TempSCMEvent'
      '    FROM '
      '    Event'
      ''
      ''
      '-- VERSION 1,1,5,0 AND 1,1,5,1 COMPATABILITY'
      ''
      ''
      'IF (@Major = 5) AND ((@Minor = 0) OR (@Minor = 1))'
      'BEGIN'
      #9'-- Drop the columns that are not needed '
      #9'IF COL_LENGTH('#39'Event'#39','#39'ScheduleDT'#39') IS NOT NULL'
      #9'BEGIN'
      #9'-- Column does exist '
      #9#9'ALTER TABLE #TempSCMEvent'
      #9#9'DROP COLUMN ScheduleDT'
      #9'END'
      'END'
      ''
      ''
      '--SELECT * from #TempSCMEvent;'
      ''
      'SELECT #TempSCMEvent.*,'
      '       qryNom.NomCount AS NomineeCount,'
      '       qryEntrants.EntrantCount AS EntrantCount,'
      
        '       Concat('#39'#'#39', #TempSCMEvent.EventNum, '#39' - '#39', Distance.Capti' +
        'on, '#39' '#39', Stroke.Caption) AS EventStr,'
      '       Distance.Meters'
      'FROM #TempSCMEvent'
      
        '     LEFT OUTER JOIN Stroke ON Stroke.StrokeID = #TempSCMEvent.S' +
        'trokeID'
      
        '     LEFT OUTER JOIN Distance ON Distance.DistanceID = #TempSCME' +
        'vent.DistanceID'
      #9
      
        '     LEFT JOIN (SELECT Count(Nominee.EventID) AS NomCount, Event' +
        'ID'
      '                FROM Nominee'
      
        '                GROUP BY  Nominee.EventID) qryNom ON qryNom.Even' +
        'tID = #TempSCMEvent.EventID '
      '     LEFT JOIN (SELECT Count(Entrant.EntrantID) AS EntrantCount,'
      '                       HeatIndividual.EventID'
      '                FROM Entrant'
      
        '                     INNER JOIN HeatIndividual ON Entrant.HeatID' +
        ' = HeatIndividual.HeatID'
      '                WHERE        (Entrant.MemberID IS NOT NULL)'
      
        '                GROUP BY HeatIndividual.EventID) qryEntrants ON ' +
        'qryEntrants.EventID = #TempSCMEvent.EventID'
      ''
      ''
      'ORDER BY #TempSCMEvent.EventNum;'
      '*/')
    Left = 48
    Top = 256
    object qryEventEventID: TFDAutoIncField
      Alignment = taLeftJustify
      DisplayWidth = 4
      FieldName = 'EventID'
      Origin = 'EventID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object qryEventSessionID: TIntegerField
      DisplayWidth = 4
      FieldName = 'SessionID'
      Origin = 'SessionID'
      Visible = False
    end
    object qryEventStrokeID: TIntegerField
      DisplayWidth = 4
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
      Visible = False
    end
    object qryEventDistanceID: TIntegerField
      DisplayWidth = 4
      FieldName = 'DistanceID'
      Origin = 'DistanceID'
      Visible = False
      OnValidate = qryEventDistanceIDValidate
    end
    object qryEventEventTypeID: TIntegerField
      FieldName = 'EventTypeID'
      Origin = 'EventTypeID'
      Visible = False
    end
    object qryEventEventNum: TIntegerField
      Alignment = taCenter
      DisplayLabel = ' Ev#'
      DisplayWidth = 5
      FieldName = 'EventNum'
      Origin = 'EventNum'
      ReadOnly = True
    end
    object qryEventluDistance: TStringField
      DisplayLabel = 'Distance'
      DisplayWidth = 12
      FieldKind = fkLookup
      FieldName = 'luDistance'
      LookupDataSet = tblDistance
      LookupKeyFields = 'DistanceID'
      LookupResultField = 'Caption'
      KeyFields = 'DistanceID'
      Lookup = True
    end
    object qryEventluStroke: TStringField
      DisplayLabel = 'Stroke'
      DisplayWidth = 14
      FieldKind = fkLookup
      FieldName = 'luStroke'
      LookupDataSet = tblStroke
      LookupKeyFields = 'StrokeID'
      LookupResultField = 'Caption'
      KeyFields = 'StrokeID'
      Lookup = True
    end
    object qryEventCaption: TWideStringField
      DisplayLabel = 'Event Description'
      DisplayWidth = 60
      FieldName = 'Caption'
      Origin = 'Caption'
      Visible = False
      Size = 128
    end
    object qryEventEventStatusID: TIntegerField
      Alignment = taCenter
      DisplayLabel = ' '
      DisplayWidth = 3
      FieldName = 'EventStatusID'
      Origin = 'EventStatusID'
      ReadOnly = True
      OnGetText = qryEventEventStatusIDGetText
    end
    object qryEventluEventStatus: TStringField
      DisplayLabel = 'Status'
      DisplayWidth = 9
      FieldKind = fkLookup
      FieldName = 'luEventStatus'
      LookupDataSet = tblEventStatus
      LookupKeyFields = 'EventStatusID'
      LookupResultField = 'Caption'
      KeyFields = 'EventStatusID'
      Visible = False
      Lookup = True
    end
    object qryEventNomineeCount: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Nom#'
      DisplayWidth = 5
      FieldName = 'NomineeCount'
      Origin = 'NomineeCount'
      ReadOnly = True
      DisplayFormat = '00'
    end
    object qryEventEntrantCount: TIntegerField
      Alignment = taCenter
      DisplayLabel = ' Ent#'
      DisplayWidth = 5
      FieldName = 'EntrantCount'
      Origin = 'EntrantCount'
      ReadOnly = True
      DisplayFormat = '00'
    end
    object qryEventClosedDT: TSQLTimeStampField
      FieldName = 'ClosedDT'
      Origin = 'ClosedDT'
      Visible = False
    end
    object qryEventEventStr: TWideStringField
      DisplayWidth = 40
      FieldName = 'EventStr'
      Origin = 'EventStr'
      ReadOnly = True
      Required = True
      Visible = False
      Size = 273
    end
    object qryEventMeters: TIntegerField
      FieldName = 'Meters'
      Origin = 'Meters'
      Visible = False
    end
    object qryEventScheduleDT: TTimeField
      DisplayLabel = 'SCHED'
      DisplayWidth = 12
      FieldName = 'ScheduleDT'
      Origin = 'ScheduleDT'
      Visible = False
      OnGetText = qryEventScheduleDTGetText
      OnSetText = qryEventScheduleDTSetText
      DisplayFormat = 'hh:nn'
      EditMask = '!90:00;1;_'
    end
    object qryEventABREV: TWideStringField
      FieldName = 'ABREV'
      Origin = 'ABREV'
      Visible = False
      Size = 8
    end
  end
  object qryFNameEllipse: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @EventID AS INT'
      ''
      'SET @EventID = :EVENTID'
      ''
      'SELECT Nominee.MemberID'
      #9',SubString(CONCAT ('
      #9#9#9'Upper(Member.LastName)'
      #9#9#9','#39', '#39
      #9#9#9',Member.FirstName'
      #9#9#9'), 0, 30) AS FName'
      'FROM Event'
      'INNER JOIN Nominee ON Event.EventID = Nominee.EventID'
      'INNER JOIN Member ON Nominee.MemberID = Member.MemberID'
      'WHERE (Nominee.MemberID IS NOT NULL)'
      #9'AND Event.EventID = @EventID'
      'ORDER BY Member.LastName')
    Left = 744
    Top = 584
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 395
      end>
  end
  object dsFNameEllipse: TDataSource
    DataSet = qryFNameEllipse
    Left = 848
    Top = 584
  end
  object qryMember: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'MemberID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'SELECT * FROM Member ORDER BY [LastName]')
    Left = 224
    Top = 96
  end
  object qryContactNum: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    Indexes = <
      item
        Active = True
        Name = 'mcMember_ContactNum'
        Fields = 'MemberID'
        DescFields = 'MemberID'
      end>
    IndexFieldNames = 'ContactNumID'
    MasterSource = dsMember
    MasterFields = 'MemberID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..ContactNumType'
    UpdateOptions.KeyFields = 'ContactNumID'
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ''
      ''
      'SELECT ContactNum.ContactNumID'
      #9',ContactNum.Number'
      #9',ContactNum.ContactNumTypeID'
      #9',ContactNum.MemberID'
      #9',ContactNumType.Caption'
      'FROM ContactNum'
      
        'INNER JOIN ContactNumType ON ContactNum.ContactNumTypeID = Conta' +
        'ctNumType.ContactNumTypeID')
    Left = 384
    Top = 96
  end
  object dsContactNum: TDataSource
    DataSet = qryContactNum
    Left = 472
    Top = 96
  end
  object qryNominee: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
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
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Nominee'
    UpdateOptions.KeyFields = 'NomineeID'
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ''
      ''
      'SELECT [NomineeID]'
      '      ,[TTB]'
      '      ,[PB]'
      '      ,[SeedTime]'
      '      ,[AutoBuildFlag]'
      '      ,[EventID]'
      '      ,[MemberID]'
      '  FROM [dbo].[Nominee]')
    Left = 208
    Top = 256
  end
  object dsNominee: TDataSource
    DataSet = qryNominee
    Left = 288
    Top = 256
  end
  object qryCountHeatsNotClosed: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @EventID AS INT'
      'SET @EventID = :EVENTID'
      ''
      'SELECT        COUNT(HeatStatusID) AS CountStatus'
      'FROM            HeatIndividual'
      'WHERE        (EventID = @EventID ) AND (HeatStatusID < 3)')
    Left = 1152
    Top = 64
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 238
      end>
  end
  object qryCountEventsNotClosed: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @SessionID AS INT'
      'SET @SessionID = :SESSIONID'
      ''
      'SELECT        COUNT(EventStatusID) AS CountStatus'
      'FROM            Event'
      'WHERE        (SessionID = @SessionID ) AND (EventStatusID < 2)')
    Left = 1152
    Top = 128
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 26
      end>
  end
  object dsIsQualified: TDataSource
    DataSet = qryIsQualifiedALT
    Left = 1304
    Top = 176
  end
  object luHouse: TDataSource
    DataSet = tblHouse
    Left = 848
    Top = 640
  end
  object tblHouse: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HouseID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..House'
    UpdateOptions.KeyFields = 'HouseID'
    TableName = 'SwimClubMeet..House'
    Left = 744
    Top = 640
  end
  object qryNominateMembers: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    AfterScroll = qryNominateMembersAfterScroll
    FilterOptions = [foCaseInsensitive]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxFName'
        Fields = 'FName'
      end
      item
        Active = True
        Name = 'idxMemberID'
        Fields = 'MemberID'
      end>
    IndexName = 'idxFName'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SessionStart AS DATETIME;'
      'DECLARE @Toggle AS BIT;'
      ''
      'SET @SessionStart = :SESSIONSTART;'
      'SET @Toggle = :TOGGLE;'
      ''
      'if @SessionStart IS NULL SET @SessionStart = GetDate();'
      ''
      ''
      'SELECT'
      'CASE '
      '    WHEN @Toggle = 0 THEN'
      #9'   CONCAT ('
      #9#9#9'   SUBSTRING(CONCAT ('
      #9#9#9#9#9'   UPPER([LastName])'
      #9#9#9#9#9'   ,'#39', '#39
      #9#9#9#9#9'   ,[FirstName]'
      #9#9#9#9#9'   ), 0, 30)'
      #9#9#9'   ,'#39' ('#39
      #9#9#9'   ,dbo.SwimmerAge(@SessionStart, DOB)'
      #9#9#9'   ,'#39')'#39
      #9#9#9'   )'
      '    WHEN @Toggle = 1 THEN'
      #9'   CONCAT ('
      #9#9#9'   SUBSTRING(CONCAT ('
      #9#9#9#9#9'   [FirstName]'
      #9#9#9#9#9'   ,'#39', '#39
      #9#9#9#9#9'   ,UPPER([LastName])'
      #9#9#9#9#9'   ), 0, 30)'
      #9#9#9'   ,'#39' ('#39
      #9#9#9'   ,dbo.SwimmerAge(@SessionStart, DOB)'
      #9#9#9'   ,'#39')'#39
      #9#9#9'   )  '
      'END  AS FName'
      #9',Member.MemberID'
      '        ,Member.GenderID'
      ',SUBSTRING(CONCAT ('
      #9#9#9#9#9'   [FirstName]'
      #9#9#9#9#9'   ,'#39', '#39
      #9#9#9#9#9'   ,UPPER([LastName])'
      #9#9#9#9#9'   ), 0, 48) AS FullName'
      ''
      'FROM Member'
      
        'WHERE (Member.IsArchived <> 1) AND (Member.IsActive = 1) AND (Me' +
        'mber.IsSwimmer = 1)'
      'Order by FName;')
    Left = 88
    Top = 616
    ParamData = <
      item
        Name = 'SESSIONSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TOGGLE'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end>
    object qryNominateMembersMemberID: TFDAutoIncField
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ReadOnly = True
      Visible = False
    end
    object qryNominateMembersFName: TWideStringField
      DisplayLabel = 'Member'#39's Name'
      DisplayWidth = 32
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Size = 128
    end
    object qryNominateMembersGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
      Visible = False
    end
    object qryNominateMembersFullName: TWideStringField
      FieldName = 'FullName'
      Origin = 'FullName'
      ReadOnly = True
      Visible = False
      Size = 48
    end
  end
  object dsNominateMembers: TDataSource
    DataSet = qryNominateMembers
    Left = 216
    Top = 616
  end
  object qryIsQualified: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SwimClubID AS INT;-- required (NULL returns no records)'
      
        'DECLARE @SessionStart AS DATETIME;-- required (sets cut-off rang' +
        'e, ie. PersonalBest '#39'as of'#39' up to and including the is date.)'
      
        'DECLARE @DistanceID AS INT;-- required (the Qualifying distance ' +
        'to check for qualification)'
      'DECLARE @StrokeID AS INT;-- required (the swimming stroke)'
      ''
      'DECLARE @MemberID AS INT;'
      ''
      '-- CALCULATED VARIABLES'
      
        'DECLARE @IsShortCourse AS BIT;-- calculated (important - uses Sw' +
        'imClubID)'
      
        'DECLARE @GenderID AS INT;-- calculated (important - qualificatio' +
        'n table splits MALE and FEMALE)'
      ''
      'SET @SessionStart = :SESSIONSTART'
      'SET @SwimClubID = :SWIMCLUBID;'
      'SET @MemberID = :MEMBERID;'
      ''
      'IF @SessionStart IS NULL'
      #9'SET @SessionStart = GetDate();'
      ''
      'SET @DistanceID = :DISTANCEID;'
      'SET @StrokeID = :STROKEID;'
      ''
      ''
      '-- as yet - not implemented in current release'
      '--SET @IsShortCourse = db0.IsPoolShortCourse(@SwimClubID);'
      ''
      '-- any thing under 50 meters is a shortcourse'
      'SET @IsShortCourse = ('
      #9#9'SELECT CASE '
      #9#9#9#9'WHEN [SwimClub].[LenOfPool] >= 50'
      #9#9#9#9#9'THEN 0'
      #9#9#9#9'ELSE 1'
      #9#9#9#9'END'
      #9#9'FROM SwimClub'
      #9#9'WHERE SwimClubID = @SwimClubID'
      #9#9');'
      ''
      '-- DROP TABLE IF EXISTS'
      'IF OBJECT_ID('#39'tempdb..#tblMember'#39', '#39'U'#39') IS NOT NULL'
      #9'DROP TABLE #tblMember;'
      ''
      '-- Member data and stroke ... distance'
      '-- tempory table to join member, PB and stroke/distance'
      'SELECT @DistanceID AS DistanceID'
      #9',@StrokeID AS StrokeID'
      #9',MemberID'
      #9',GenderID'
      #9',dbo.PersonalBest(MemberID, ('
      #9#9#9'SELECT TrialDistID'
      #9#9#9'FROM Qualify'
      #9#9#9'WHERE (Qualify.StrokeID = @StrokeID)'
      #9#9#9#9'AND (Qualify.QualifyDistID = @DistanceID)'
      #9#9#9#9'AND (Qualify.IsShortCourse = @IsShortCourse)'
      #9#9#9#9'AND (Qualify.GenderID = Member.GenderID)'
      #9#9#9'), @StrokeID, @SessionStart) AS TrialTimePB'
      #9',IsActive'
      'INTO #tblMember'
      'FROM Member'
      ''
      ''
      ''
      ''
      '-- OUTPUTS MemberID and treu/false if qualified'
      'SELECT #tblMember.[MemberID]'
      #9'--'#9',#tblMember.TrialTimePB'
      #9'--'#9',TrialTime'
      
        #9'--,IIF(#tblMember.TrialTimePB <= TrialTime, 1, 0) AS IsQualifie' +
        'd'
      'FROM [dbo].Qualify'
      
        'INNER JOIN #tblMember ON Qualify.QualifyDistID = #tblMember.Dist' +
        'anceID'
      #9'AND Qualify.StrokeID = #tblMember.StrokeID'
      'WHERE #tblMember.[IsActive] = 1'
      '        AND #tblMember.MemberID = @MemberID'
      #9'AND [dbo].Qualify.IsShortCourse = @IsShortCourse'
      #9'AND Qualify.StrokeID = @StrokeID'
      #9'AND Qualify.GenderID = #tblMember.GenderID'
      'AND IIF(#tblMember.TrialTimePB <= TrialTime, 1, 0) = 1')
    Left = 1304
    Top = 64
    ParamData = <
      item
        Name = 'SESSIONSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 6
      end
      item
        Name = 'DISTANCEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end
      item
        Name = 'STROKEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qryHeat: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    AfterInsert = qryHeatAfterInsert
    AfterPost = qryHeatAfterPost
    AfterDelete = qryHeatAfterDelete
    AfterScroll = qryHeatAfterScroll
    OnNewRecord = qryHeatNewRecord
    IndexFieldNames = 'EventID'
    MasterSource = dsEvent
    MasterFields = 'EventID'
    DetailFields = 'EventID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..HeatIndividual'
    UpdateOptions.KeyFields = 'HeatID'
    SQL.Strings = (
      'SELECT'
      '  HeatIndividual.HeatID,'
      '  HeatIndividual.HeatNum,'
      '  HeatIndividual.EventID,'
      '  HeatIndividual.HeatTypeID,'
      '  HeatIndividual.HeatStatusID,'
      '  HeatIndividual.ClosedDT,'
      '  HeatStatus.Caption AS cStatus'
      ''
      'FROM'
      '  HeatIndividual'
      
        '  INNER JOIN HeatStatus ON HeatIndividual.HeatStatusID = HeatSta' +
        'tus.HeatStatusID'
      'ORDER BY'
      '  HeatIndividual.HeatNum')
    Left = 48
    Top = 312
    object qryHeatHeatID: TFDAutoIncField
      FieldName = 'HeatID'
      Origin = 'HeatID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
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
    object qryHeatClosedDT: TSQLTimeStampField
      FieldName = 'ClosedDT'
      Origin = 'ClosedDT'
      Visible = False
    end
  end
  object qryIsQualifiedALT: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EntrantID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'EntrantID'
    SQL.Strings = (
      'DECLARE @QualifyDistID AS INT'
      'DECLARE @StrokeID AS INT'
      'DECLARE @MemberID AS INT'
      'DECLARE @IsShortCourse AS BIT'
      'DECLARE @GenderID AS INT'
      ''
      'SET @QualifyDistID = :QUALIFYDISTID; --2;'
      'SET @StrokeID = :STROKEID; --1;'
      'SET @MemberID = :MEMBERID; --9;'
      'SET @IsShortCourse = :ISSHORTCOURSE; --1;'
      'SET @GenderID = :GENDERID; --1;'
      ''
      ''
      'SELECT TOP (1) Entrant.RaceTime'
      #9',Qualify.TrialTime'
      ',EntrantID'
      'FROM Entrant'
      
        'INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.Hea' +
        'tID'
      'INNER JOIN Event ON HeatIndividual.EventID = Event.EventID'
      'INNER JOIN Qualify ON Event.DistanceID = Qualify.TrialDistID'
      #9'AND Event.StrokeID = Qualify.StrokeID'
      'WHERE (Entrant.IsDisqualified = 0)'
      #9'AND (Entrant.IsScratched = 0)'
      #9'AND (Entrant.RaceTime IS NOT NULL)'
      #9'AND (Event.StrokeID = @StrokeID)'
      #9'AND (Entrant.MemberID = @MemberID)'
      #9'AND (Qualify.QualifyDistID = @QualifyDistID)'
      #9'AND (Qualify.IsShortCourse = @IsShortCourse)'
      #9'AND (Qualify.GenderID = @GenderID)'
      'ORDER BY Entrant.RaceTime')
    Left = 1304
    Top = 120
    ParamData = <
      item
        Name = 'QUALIFYDISTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end
      item
        Name = 'STROKEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 9
      end
      item
        Name = 'ISSHORTCOURSE'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'GENDERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qryRenumberLanes: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HeatID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.UpdateTableName = 'SwimClubMeet..HeatIndividual'
    UpdateOptions.KeyFields = 'aID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      ''
      'DECLARE @HeatID AS INTEGER;'
      'DECLARE @EventTypeID AS INTEGER;'
      ''
      'SET @HeatID = :HEATID;'
      
        'SET @EventTypeID = (SELECT TOP 1 EventTypeID FROM HeatIndividual' +
        ' '
      #9'INNER JOIN [Event] ON HeatIndividual.EventID = [Event].EventID'
      
        #9'INNER JOIN [Distance] ON [Event].DistanceID = [Distance].Distan' +
        'ceID'
      #9');'
      ''
      'IF @EventTypeID = 2'
      ''
      'SELECT Team.TimeToBeat, CASE '
      '      WHEN (Team.TeamNameID IS NULL) THEN 2 '
      
        '      WHEN (CAST(CAST(Team.TimeToBeat AS DATETIME) AS FLOAT) = 0' +
        ') THEN 1 '
      '      ELSE 0 END AS mySort, Team.Lane '
      '      ,TeamID as aID'
      '      FROM Team WHERE Team.HeatID = 182'
      #9'  ORDER BY mySort, timetobeat;'
      'ELSE'
      ''
      'SELECT Entrant.TimeToBeat, CASE '
      '      WHEN (Entrant.MemberID IS NULL) THEN 2 '
      
        '      WHEN (CAST(CAST(Entrant.TimeToBeat AS DATETIME) AS FLOAT) ' +
        '= 0) THEN 1 '
      '      ELSE 0 END AS mySort, Entrant.Lane '
      '      ,EntrantID as aID'
      '      FROM Entrant WHERE Entrant.HeatID = 182'
      #9'  ORDER BY mySort, timetobeat;'
      ';'
      ''
      '/*'
      'DECLARE @EventID int;'
      'SET @EventID = :EVENTID;'
      ''
      
        'SELECT HeatID, HeatNum FROM HeatIndividual WHERE EventID = @Even' +
        'tID'
      ''
      
        '-- order by case when col is null then 2 else 1 end, col asc|des' +
        'c -- i.e. nulls last'
      ''
      
        'ORDER BY CASE WHEN HeatNum IS NULL then 2 else 1 end, HeatNum AS' +
        'C;'
      '*/')
    Left = 1064
    Top = 544
    ParamData = <
      item
        Name = 'HEATID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 182
      end>
  end
  object qrySwimClub: TFDQuery
    Active = True
    IndexFieldNames = 'SwimClubID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..SwimClub'
    UpdateOptions.KeyFields = 'SwimClubID'
    SQL.Strings = (
      'Use SwimClubMeet;'
      ''
      'DECLARE @SwimClubID AS INT;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'DECLARE @Major AS INT;'
      
        'SET @Major = (SELECT Major FROM SwimClubMeet.dbo.SCMSystem WHERE' +
        ' SCMSystemID = 1);'
      'DECLARE @Minor AS INT;'
      
        'SET @Minor = (SELECT Major FROM SwimClubMeet.dbo.SCMSystem WHERE' +
        ' SCMSystemID = 1);'
      ''
      '-- Drop a temporary table called '#39'#TableName'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#TempSCMSwimClub'#39', '#39'U'#39') IS NOT NULL'
      'DROP TABLE #TempSCMSwimClub'
      ';'
      ''
      '/* Get the data into a temp table */'
      '    SELECT * INTO #TempSCMSwimClub'
      '    FROM '
      '    SwimClub WHERE @SwimClubID = @SwimClubID;'
      ''
      '/*'
      'VERSION 1,1,5,0 AND 1,1,5,1 COMPATABILITY'
      '*/'
      ''
      'IF (@Major = 5) AND ((@Minor = 0) OR (@Minor = 1))'
      'BEGIN'
      #9'/* Drop the columns that are not needed */'
      #9'IF COL_LENGTH('#39'SwimClub'#39','#39'LogoDir'#39') IS NOT NULL'
      #9'BEGIN'
      #9'/* Column does exist */'
      #9#9'ALTER TABLE #TempSCMSwimClub'
      #9#9'DROP COLUMN LogoDir'
      #9'END'
      #9'IF COL_LENGTH('#39'SwimClub'#39','#39'LogoImg'#39') IS NOT NULL'
      #9'BEGIN'
      #9'/* Column does exist */'
      #9#9'ALTER TABLE #TempSCMSwimClub'
      #9#9'DROP COLUMN LogoImg'
      #9'END'
      #9'IF COL_LENGTH('#39'SwimClub'#39','#39'LogoType'#39') IS NOT NULL'
      #9'BEGIN'
      #9'/* Column does exist */'
      #9#9'ALTER TABLE #TempSCMSwimClub'
      #9#9'DROP COLUMN LogoType'
      #9'END'
      'END'
      ''
      'SELECT * from #TempSCMSwimClub;'
      '')
    Left = 48
    Top = 96
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qrySwapEntrants: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EntA AS INT;'
      'DECLARE @EntB AS INT;'
      ''
      'SET @EntA = :ENTRANTIDA; --10367;'
      'SET @EntB = :ENTRANTIDB; --10368;'
      ''
      ''
      'IF (@EntA = @EntB)'
      'BEGIN'
      '    GOTO SKIP;'
      'END;'
      ''
      ''
      '-- Drop a temporary table called '#39'#tmpEntA'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#tmpEntA'#39', '#39'U'#39') IS NOT NULL'
      'DROP TABLE #tmpEntA;'
      ''
      
        '-- Create the temporary table from a physical table called '#39'Entr' +
        'ant'#39' in schema '#39'dbo'#39' in database '#39'SwimClubMeet'#39
      'SELECT TOP 1 *'
      'INTO #tmpEntA'
      'FROM [SwimClubMeet].[dbo].[Entrant]'
      'WHERE EntrantID = @EntA'
      ''
      '-- Drop a temporary table called '#39'#tmpEntB'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#tmpEntB'#39', '#39'U'#39') IS NOT NULL'
      'DROP TABLE #tmpEntB;'
      ''
      
        '-- Create the temporary table from a physical table called '#39'Entr' +
        'ant'#39' in schema '#39'dbo'#39' in database '#39'SwimClubMeet'#39
      'SELECT TOP 1 *'
      'INTO #tmpEntB'
      'FROM [SwimClubMeet].[dbo].[Entrant]'
      'WHERE EntrantID = @EntB'
      ''
      'IF(NOT EXISTS(SELECT 1 FROM #tmpEntA))'
      'BEGIN'
      '  GOTO SKIP;'
      'END;'
      ''
      'IF(NOT EXISTS(SELECT 1 FROM #tmpEntB))'
      'BEGIN'
      '  GOTO SKIP;'
      'END;'
      ''
      ''
      'UPDATE [SwimClubMeet].[dbo].[Entrant] '
      'SET'
      #9#9' [MemberID]=#tmpEntB.MemberID'
      #9#9',[RaceTime]=#tmpEntB.RaceTime'
      #9#9',[TimeToBeat]=#tmpEntB.TimeToBeat'
      #9#9',[PersonalBest]=#tmpEntB.PersonalBest'
      #9#9',[IsDisqualified]=#tmpEntB.IsDisqualified'
      #9#9',[IsScratched]=#tmpEntB.IsScratched'
      #9#9',[DisqualifyCodeID]=#tmpEntB.DisqualifyCodeID    '
      'FROM Entrant, #tmpEntA, #tmpEntB'
      'WHERE [Entrant].[EntrantID] = @EntA;'
      ''
      ''
      'UPDATE [SwimClubMeet].[dbo].[Entrant] '
      'SET'
      #9#9' [MemberID]=#tmpEntA.MemberID'
      #9#9',[RaceTime]=#tmpEntA.RaceTime'
      #9#9',[TimeToBeat]=#tmpEntA.TimeToBeat'
      #9#9',[PersonalBest]=#tmpEntA.PersonalBest'
      #9#9',[IsDisqualified]=#tmpEntA.IsDisqualified'
      #9#9',[IsScratched]=#tmpEntA.IsDisqualified'
      #9#9',[DisqualifyCodeID]=#tmpEntA.DisqualifyCodeID'
      'FROM Entrant, #tmpEntA, #tmpEntB'#9#9
      'WHERE [Entrant].[EntrantID] = @EntB;'
      ''
      'SKIP:'
      '')
    Left = 992
    Top = 64
    ParamData = <
      item
        Name = 'ENTRANTIDA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ENTRANTIDB'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryGetNextHeat: TFDQuery
    IndexFieldNames = 'HeatID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @HeatID INT;'
      'SET @HeatID = :HEATID; --1295;'
      '-- Drop a temporary table called '#39'#tmpheat'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#tmpheat'#39', '#39'U'#39') IS NOT NULL'
      'DROP TABLE #tmpheat'
      ';'
      
        '-- Create the temporary table from a physical table called '#39'Heat' +
        'ID'#39' in schema '#39'dbo'#39' in database '#39'SwimClubMeet'#39
      'SELECT HeatID, HeatNum, EventID'
      'INTO #tmpheat'
      'FROM [SwimClubMeet].[dbo].[HeatIndividual]'
      'WHERE [HeatID] = @HeatID;'
      ''
      'SELECT [HeatIndividual].[HeatID] '
      
        'FROM [HeatIndividual] INNER JOIN #tmpheat on [HeatIndividual].[E' +
        'ventID] = #tmpheat.[EventID]'
      'WHERE [HeatIndividual].[HeatNum] = #tmpheat.HeatNum + 1;')
    Left = 1064
    Top = 456
    ParamData = <
      item
        Name = 'HEATID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryGetPrevHeat: TFDQuery
    IndexFieldNames = 'HeatID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @HeatID INT;'
      'SET @HeatID = :HEATID; --1296;'
      '-- Drop a temporary table called '#39'#tmpheat'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#tmpheat'#39', '#39'U'#39') IS NOT NULL'
      'DROP TABLE #tmpheat'
      ';'
      
        '-- Create the temporary table from a physical table called '#39'Heat' +
        'ID'#39' in schema '#39'dbo'#39' in database '#39'SwimClubMeet'#39
      'SELECT HeatID, HeatNum, EventID'
      'INTO #tmpheat'
      'FROM [SwimClubMeet].[dbo].[HeatIndividual]'
      'WHERE [HeatID] = @HeatID;'
      ''
      'SELECT [HeatIndividual].[HeatID] '
      
        'FROM [HeatIndividual] INNER JOIN #tmpheat on [HeatIndividual].[E' +
        'ventID] = #tmpheat.[EventID]'
      'WHERE [HeatIndividual].[HeatNum] = #tmpheat.HeatNum - 1;')
    Left = 1160
    Top = 456
    ParamData = <
      item
        Name = 'HEATID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryNominateControlList: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SessionID;EventNum'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'EventID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @MemberID AS integer;'
      'DECLARE @SessionID AS integer;'
      ''
      'SET @SessionID = :SESSIONID; --100;'
      'SET @MemberID = :MEMBERID; --3;'
      ''
      'SELECT EventID'
      '     , [Event].EventNum'
      '     , [Event].SessionID'
      '     , [Distance].[EventTypeID]'
      '     , [Event].StrokeID'
      '     , [Event].DistanceID'
      '     , [Event].EventStatusID'
      '     , [Event].Caption'
      '     , CAST(CASE'
      '                WHEN (EXISTS'
      '                      ('
      '                          SELECT NomineeID'
      '                          FROM Nominee'
      '                          WHERE Memberid = @MemberID'
      '                                AND EventID = [Event].EventID'
      '                      )'
      '                     ) THEN'
      '                    1'
      '                ELSE'
      '                    0'
      '            END AS BIT) AS IsNominated'
      
        '     , dbo.IsMemberQualified(memberid, GETDATE(), [Event].Distan' +
        'ceID, [Event].StrokeID) AS IsQualified'
      
        '     , CONCAT(distance.Caption, '#39' '#39', stroke.Caption) AS DistStro' +
        'keStr'
      'FROM [event]'
      '   , [Member]'
      '   , stroke'
      '   , distance'
      'WHERE Memberid = @MemberID'
      '      AND SessionID = @SessionID'
      '      AND [stroke].StrokeID = [Event].StrokeID'
      '      AND [Distance].DistanceID = [Event].DistanceID'
      'ORDER BY [Event].SessionID'
      '       , [Event].EventNum')
    Left = 88
    Top = 680
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 78
      end>
    object qryNominateControlListEventID: TFDAutoIncField
      FieldName = 'EventID'
      Origin = 'EventID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryNominateControlListEventNum: TIntegerField
      FieldName = 'EventNum'
      Origin = 'EventNum'
    end
    object qryNominateControlListSessionID: TIntegerField
      FieldName = 'SessionID'
      Origin = 'SessionID'
    end
    object qryNominateControlListEventTypeID: TIntegerField
      FieldName = 'EventTypeID'
      Origin = 'EventTypeID'
    end
    object qryNominateControlListStrokeID: TIntegerField
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
    end
    object qryNominateControlListDistanceID: TIntegerField
      FieldName = 'DistanceID'
      Origin = 'DistanceID'
    end
    object qryNominateControlListEventStatusID: TIntegerField
      FieldName = 'EventStatusID'
      Origin = 'EventStatusID'
    end
    object qryNominateControlListCaption: TWideStringField
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 128
    end
    object qryNominateControlListIsNominated: TBooleanField
      FieldName = 'IsNominated'
      Origin = 'IsNominated'
      ReadOnly = True
    end
    object qryNominateControlListIsQualified: TBooleanField
      FieldName = 'IsQualified'
      Origin = 'IsQualified'
      ReadOnly = True
    end
    object qryNominateControlListDistStrokeStr: TWideStringField
      FieldName = 'DistStrokeStr'
      Origin = 'DistStrokeStr'
      ReadOnly = True
      Required = True
      Size = 257
    end
  end
  object dsNominateControlList: TDataSource
    AutoEdit = False
    DataSet = qryNominateControlList
    Left = 216
    Top = 680
  end
  object qrySCMSystem: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    Connection = scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'SELECT * FROM SCMSystem WHERE SCMSystemID = 1;')
    Left = 288
    Top = 24
  end
  object tblDisqualifyCode: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'DisqualifyCodeID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    TableName = 'SwimClubMeet.dbo.DisqualifyCode'
    Left = 744
    Top = 472
  end
  object luDisqualifyCode: TDataSource
    DataSet = tblDisqualifyCode
    Left = 848
    Top = 472
  end
  object tblSwimmerCAT: TFDTable
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SwimmerCategoryID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'SwimmerCategoryID'
    TableName = 'SwimClubMeet.dbo.SwimmerCategory'
    Left = 744
    Top = 528
  end
  object luSwimmerCAT: TDataSource
    DataSet = tblSwimmerCAT
    Left = 848
    Top = 528
  end
  object qryTeam: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    BeforeInsert = qryEvTypeBeforeInsert
    AfterScroll = qryTeamAfterScroll
    IndexFieldNames = 'HeatID'
    MasterSource = dsHeat
    MasterFields = 'HeatID'
    DetailFields = 'HeatID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEInsert, uvCheckRequired]
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.Team'
    UpdateOptions.KeyFields = 'TeamID'
    SQL.Strings = (
      '-- Format of TTime occurs in OnGetText() '#39'nn:ss.zzz'#39
      ''
      'USE SwimClubMeet'
      ''
      'SELECT Team.TeamID'
      '     , Team.HeatID'
      '     , Team.Lane'
      '     , Team.RaceTime'
      '     , Team.TimeToBeat'
      '     , Team.IsDisqualified'
      '     , Team.IsScratched'
      '     , Team.TeamNameID'
      '     , CASE'
      '           WHEN Team.TeamNameID IS NOT NULL THEN'
      '               TeamName.Caption'
      '       END AS TeamName     '
      '       , DisqualifyCode.ABREV AS DCode'
      '     , Team.DisqualifyCodeID'
      'FROM Team'
      '    LEFT OUTER JOIN TeamName'
      '        ON Team.TeamNameID = TeamName.TeamNameID'
      '    LEFT OUTER JOIN DisqualifyCode'
      
        '        ON Team.DisqualifyCodeID = DisqualifyCode.DisqualifyCode' +
        'ID'
      'ORDER BY Team.Lane'
      ''
      ''
      '')
    Left = 272
    Top = 376
    object qryTeamTeamID: TFDAutoIncField
      FieldName = 'TeamID'
      Origin = 'TeamID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object IntegerField1: TIntegerField
      FieldName = 'HeatID'
      Origin = 'HeatID'
      Required = True
      Visible = False
    end
    object qryTeamTeamNameID: TIntegerField
      FieldName = 'TeamNameID'
      Origin = 'TeamNameID'
      Visible = False
    end
    object IntegerField3: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Lane#'
      DisplayWidth = 6
      FieldName = 'Lane'
      Origin = 'Lane'
      ReadOnly = True
      DisplayFormat = '00'
    end
    object qryTeamTeamName: TWideStringField
      FieldName = 'TeamName'
      Origin = 'TeamName'
      ReadOnly = True
      Size = 60
    end
    object TimeField1: TTimeField
      Alignment = taRightJustify
      DisplayWidth = 10
      FieldName = 'RaceTime'
      Origin = 'RaceTime'
      OnGetText = qryEntrantTIMEGetText
      OnSetText = qryEntrantTIMESetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
    object TimeField2: TTimeField
      Alignment = taRightJustify
      DisplayWidth = 10
      FieldName = 'TimeToBeat'
      Origin = 'TimeToBeat'
      ReadOnly = True
      OnGetText = qryEntrantTIMEGetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
    object BooleanField1: TBooleanField
      Alignment = taCenter
      DisplayLabel = ' S'
      DisplayWidth = 3
      FieldName = 'IsScratched'
      Origin = 'IsScratched'
    end
    object BooleanField2: TBooleanField
      Alignment = taCenter
      DisplayLabel = ' D'
      DisplayWidth = 3
      FieldName = 'IsDisqualified'
      Origin = 'IsDisqualified'
    end
    object IntegerField4: TIntegerField
      FieldName = 'DisqualifyCodeID'
      Origin = 'DisqualifyCodeID'
      Visible = False
    end
    object WideStringField2: TWideStringField
      FieldName = 'DCode'
      Origin = 'DCode'
      ReadOnly = True
      Size = 8
    end
  end
  object dsTeam: TDataSource
    DataSet = qryTeam
    Left = 328
    Top = 376
  end
  object qryTeamEntrant: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    BeforeInsert = qryEvTypeBeforeInsert
    AfterScroll = qryTeamEntrantAfterScroll
    IndexFieldNames = 'TeamID'
    MasterSource = dsTeam
    MasterFields = 'TeamID'
    DetailFields = 'TeamID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEInsert, uvCheckRequired]
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.TeamEntrant'
    UpdateOptions.KeyFields = 'TeamEntrantID'
    SQL.Strings = (
      '-- Format of TTime occurs in OnGetText() '#39'nn:ss.zzz'#39
      ''
      'USE SwimClubMeet'
      ''
      'SELECT TeamEntrant.TeamEntrantID'
      '     , TeamEntrant.TeamID'
      '     , TeamEntrant.SwimOrder'
      '     , TeamEntrant.RaceTime'
      '     , TeamEntrant.TimeToBeat'
      '     , TeamEntrant.MemberID'
      '     , TeamEntrant.PersonalBest'
      '     , CASE'
      '           WHEN Member.MemberID IS NOT NULL THEN'
      '               CONCAT('
      
        '                         FORMAT(dbo.SwimmerAge(Session.SessionSt' +
        'art, Member.DOB), '#39'00'#39')'
      '                       , '#39'.'#39
      
        '                       , dbo.SwimmerGenderToString(Member.Member' +
        'ID)'
      '                       , '#39'  '#39
      '                       , Member.FirstName'
      '                       , '#39' '#39
      '                       , UPPER(Member.LastName)'
      '                     )'
      '       END AS FullName'
      '     , TeamEntrant.StrokeID'
      'FROM TeamEntrant'
      '    LEFT OUTER JOIN Member'
      '        ON TeamEntrant.MemberID = Member.MemberID'
      '    INNER JOIN Team'
      '        ON TeamEntrant.TeamID = Team.TeamID'
      '    INNER JOIN HeatIndividual'
      '        ON Team.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN Event'
      '        ON HeatIndividual.EventID = Event.EventID'
      '    INNER JOIN Session'
      '        ON Event.SessionID = Session.SessionID'
      'ORDER BY TeamEntrant.SwimOrder'
      ''
      ''
      '')
    Left = 216
    Top = 432
    object qryTeamEntrantTeamEntrantID: TFDAutoIncField
      FieldName = 'TeamEntrantID'
      Origin = 'TeamEntrantID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object qryTeamEntrantTeamID: TIntegerField
      FieldName = 'TeamID'
      Origin = 'TeamID'
      Visible = False
    end
    object IntegerField5: TIntegerField
      FieldName = 'MemberID'
      Origin = 'MemberID'
      Visible = False
    end
    object qryTeamEntrantSwimOrder: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Swim Order'
      FieldName = 'SwimOrder'
      Origin = 'SwimOrder'
    end
    object WideStringField1: TWideStringField
      DisplayLabel = 'Entrant'#39's Name'
      DisplayWidth = 34
      FieldName = 'FullName'
      Origin = 'FullName'
      ReadOnly = True
      Size = 257
    end
    object TimeField3: TTimeField
      Alignment = taRightJustify
      DisplayWidth = 10
      FieldName = 'RaceTime'
      Origin = 'RaceTime'
      Visible = False
      OnGetText = qryEntrantTIMEGetText
      OnSetText = qryEntrantTIMESetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
    object TimeField4: TTimeField
      Alignment = taRightJustify
      DisplayWidth = 10
      FieldName = 'TimeToBeat'
      Origin = 'TimeToBeat'
      ReadOnly = True
      Visible = False
      OnGetText = qryEntrantTIMEGetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
    object TimeField5: TTimeField
      Alignment = taRightJustify
      DisplayWidth = 10
      FieldName = 'PersonalBest'
      Origin = 'PersonalBest'
      ReadOnly = True
      Visible = False
      OnGetText = qryEntrantTIMEGetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
    object qryTeamEntrantStrokeID: TIntegerField
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
      Visible = False
    end
    object qryTeamEntrantluStroke: TStringField
      DisplayLabel = 'Stroke'
      DisplayWidth = 16
      FieldKind = fkLookup
      FieldName = 'luStroke'
      LookupDataSet = tblStroke
      LookupKeyFields = 'StrokeID'
      LookupResultField = 'Caption'
      KeyFields = 'StrokeID'
      Lookup = True
    end
  end
  object dsTeamEntrant: TDataSource
    DataSet = qryTeamEntrant
    Left = 272
    Top = 432
  end
  object qrySplit: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EntrantID'
    MasterSource = dsEntrant
    MasterFields = 'EntrantID'
    DetailFields = 'EntrantID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEInsert, uvCheckRequired]
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.Split'
    UpdateOptions.KeyFields = 'SplitID'
    SQL.Strings = (
      '-- Format of TTime occurs in OnGetText() '#39'nn:ss.zzz'#39
      ''
      'USE SwimClubMeet'
      ''
      'SELECT Split.SplitID'
      '     , Split.EntrantID'
      '     , Split.SplitTime'
      ''
      'FROM Split'
      'ORDER BY SplitTime ASC;'
      ''
      ''
      '')
    Left = 48
    Top = 432
    object qrySplitSplitID: TFDAutoIncField
      FieldName = 'SplitID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object qrySplitEntrantID: TIntegerField
      FieldName = 'EntrantID'
      Visible = False
    end
    object qrySplitSplitTime: TTimeField
      Alignment = taRightJustify
      FieldName = 'SplitTime'
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
  end
  object dsSplit: TDataSource
    DataSet = qrySplit
    Left = 112
    Top = 432
  end
  object qrySwapTeams: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @IDA AS INT;'
      'DECLARE @IDB AS INT;'
      ''
      'SET @IDA = :TEAMIDA; --10367;'
      'SET @IDB = :TEAMIDB; --10368;'
      ''
      ''
      'IF (@IDA = @IDB)'
      'BEGIN'
      '    GOTO SKIP;'
      'END;'
      ''
      ''
      '-- Drop a temporary table called '#39'#tmpEntA'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#tmpEntA'#39', '#39'U'#39') IS NOT NULL'
      'DROP TABLE #tmpEntA;'
      ''
      
        '-- Create the temporary table from the physical table [Team] in ' +
        'schema '#39'dbo'#39' in database '#39'SwimClubMeet'#39
      'SELECT TOP 1 *'
      'INTO #tmpEntA'
      'FROM [SwimClubMeet].[dbo].[Team]'
      'WHERE TeamID = @IDA'
      ''
      '-- Drop a temporary table called '#39'#tmpEntB'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#tmpEntB'#39', '#39'U'#39') IS NOT NULL'
      'DROP TABLE #tmpEntB;'
      ''
      
        '-- Create the temporary table from the physical table [Team] in ' +
        'schema '#39'dbo'#39' in database '#39'SwimClubMeet'#39
      'SELECT TOP 1 *'
      'INTO #tmpEntB'
      'FROM [SwimClubMeet].[dbo].[Team]'
      'WHERE TeamID = @IDB'
      ''
      'IF(NOT EXISTS(SELECT 1 FROM #tmpEntA))'
      'BEGIN'
      '  GOTO SKIP;'
      'END;'
      ''
      'IF(NOT EXISTS(SELECT 1 FROM #tmpEntB))'
      'BEGIN'
      '  GOTO SKIP;'
      'END;'
      ''
      'UPDATE [SwimClubMeet].[dbo].[Team] '
      'SET'
      #9#9' [TeamNameID]=#tmpEntB.TeamNameID'
      #9#9',[RaceTime]=#tmpEntB.RaceTime'
      #9#9',[TimeToBeat]=#tmpEntB.TimeToBeat'
      #9#9',[IsDisqualified]=#tmpEntB.IsDisqualified'
      #9#9',[IsScratched]=#tmpEntB.IsScratched'
      #9#9',[DisqualifyCodeID]=#tmpEntB.DisqualifyCodeID'
      'FROM Team, #tmpEntA, #tmpEntB'
      'WHERE [Team].[TeamID] = @IDA;'
      ''
      'UPDATE [SwimClubMeet].[dbo].[Team] '
      'SET'
      #9#9' [TeamNameID]=#tmpEntA.TeamNameID'
      #9#9',[RaceTime]=#tmpEntA.RaceTime'
      #9#9',[TimeToBeat]=#tmpEntA.TimeToBeat'
      #9#9',[IsDisqualified]=#tmpEntA.IsDisqualified'
      #9#9',[IsScratched]=#tmpEntA.IsDisqualified'
      #9#9',[DisqualifyCodeID]=#tmpEntA.DisqualifyCodeID'
      'FROM Team, #tmpEntA, #tmpEntB'#9#9
      'WHERE [Team].[TeamID] = @IDB;'
      ''
      'SKIP:'
      '')
    Left = 992
    Top = 128
    ParamData = <
      item
        Name = 'TEAMIDA'
        ParamType = ptInput
      end
      item
        Name = 'TEAMIDB'
        ParamType = ptInput
      end>
  end
  object qryTeamSplit: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'TeamID'
    MasterSource = dsTeam
    MasterFields = 'TeamID'
    DetailFields = 'TeamID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEInsert, uvCheckRequired]
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.TeamSplit'
    UpdateOptions.KeyFields = 'TeamSplitID'
    SQL.Strings = (
      '-- Format of TTime occurs in OnGetText() '#39'nn:ss.zzz'#39
      ''
      'USE SwimClubMeet'
      ''
      'SELECT TeamSplit.TeamSplitID'
      '     , TeamSplit.TeamID'
      '     , TeamSplit.SplitTime'
      ''
      'FROM TeamSplit'
      'ORDER BY SplitTime ASC;'
      ''
      ''
      '')
    Left = 328
    Top = 432
    object qryTeamSplitTeamSplitID: TFDAutoIncField
      FieldName = 'TeamSplitID'
      Origin = 'TeamSplitID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object qryTeamSplitTeamID: TIntegerField
      FieldName = 'TeamID'
      Origin = 'TeamID'
      Visible = False
    end
    object qryTeamSplitSplitTime: TTimeField
      FieldName = 'SplitTime'
      Origin = 'SplitTime'
      DisplayFormat = 'nn:ss.zzz'
    end
  end
  object dsTeamSplit: TDataSource
    DataSet = qryTeamSplit
    Left = 384
    Top = 432
  end
end
