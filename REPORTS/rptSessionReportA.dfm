object SessionReportA: TSessionReportA
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 696
  Width = 939
  object frxXLSExport1: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 64
    Top = 136
  end
  object frxHTMLExport1: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 64
    Top = 80
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 64
    Top = 24
  end
  object qryClubInfo: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SwimClubID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'IF @SwimClubID IS NULL'
      '    SET @SwimClubID = 1;'
      ''
      'SELECT SwimClub.[SwimClubID]'
      '     , [NickName]'
      '     , SwimClub.[Caption] AS SwimClubName'
      '     , [NumOfLanes]'
      '     , [LenOfPool]'
      '     , [StartOfSwimSeason]'
      '     --,[PoolTypeID]'
      '     --,[SwimClubTypeID]'
      '     , [Session].[Caption] AS SessionTitle'
      '     , [SessionStart]'
      'FROM SwimClub'
      '    INNER JOIN Session'
      '        ON SwimClub.SwimClubID = [Session].[SwimClubID]'
      'WHERE SwimClub.[SwimClubID] = @SwimClubID;')
    Left = 488
    Top = 48
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object frxClubInfo: TfrxDBDataset
    UserName = 'frxClubInfo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SwimClubID=SwimClubID'
      'NickName=NickName'
      'SwimClubName=SwimClubName'
      'NumOfLanes=NumOfLanes'
      'LenOfPool=LenOfPool'
      'StartOfSwimSeason=StartOfSwimSeason'
      'SessionTitle=SessionTitle'
      'SessionStart=SessionStart')
    DataSet = qryClubInfo
    BCDToCurrency = False
    Left = 576
    Top = 48
  end
  object qrySession: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SessionID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.MaxBcdPrecision = 16
    FormatOptions.FmtDisplayTime = 'mm:ss.zz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    SQL.Strings = (
      '--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!'
      ''
      'USE SwimClubMeet'
      ';'
      ''
      'DECLARE @SessionID AS INTEGER;'
      'SET @SessionID = :SESSIONID;'
      ''
      'SELECT '
      #9#9'[SwimClubID]'
      #9#9' ,[SessionID]'
      #9#9',[Caption]'
      #9#9',[SessionStart]'
      #9#9',[ClosedDT]'
      #9#9',[SessionStatusID]'
      '    '
      'FROM [SwimClubMeet].[dbo].[Session] '
      'WHERE [SessionID] = @SessionID'
      'ORDER BY SwimClubID, SessionID'
      ';'
      ''
      ''
      '')
    Left = 488
    Top = 112
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qryEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SessionID;EventID'
    MasterSource = dsSession
    MasterFields = 'SessionID'
    DetailFields = 'SessionID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.MaxBcdPrecision = 16
    FormatOptions.FmtDisplayTime = 'mm:ss.zz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    SQL.Strings = (
      'USE SwimClubMeet'
      ';'
      ''
      'SELECT [SessionID]'
      '     , [EventID]'
      '     , [EventNum]'
      '     , CASE'
      '           WHEN'
      '           ('
      '               [Event].[Caption] IS NULL'
      '               AND Distance.EventTypeID = 1'
      '           ) THEN'
      '               '#39'INDIVIDUAL EVENT'#39
      '           WHEN'
      '           ('
      '               [Event].[Caption] IS NULL'
      '               AND Distance.EventTypeID = 2'
      '           ) THEN'
      '               '#39'TEAM EVENT - RELAY'#39
      '           ELSE'
      '               [Event].[Caption]'
      '       END AS EventSTR'
      ''
      '     --,[Event].[Caption] AS EventStr'
      '     , [ClosedDT]'
      '     , [ScheduleDT]'
      '     , [Event].[StrokeID]'
      '     , [Event].[DistanceID]'
      '     , [EventStatusID]'
      '     , SUBSTRING(Stroke.Caption, 0, 16) AS StrokeStr'
      '     , SUBSTRING(Distance.Caption, 0, 10) AS DistanceStr'
      
        '     , CONCAT('#39'Event '#39', EventNum, '#39' - '#39', SUBSTRING(Distance.Capt' +
        'ion, 0, 10)'
      
        '             , '#39' '#39', SUBSTRING(Stroke.Caption, 0, 16)) AS EventDe' +
        'scription'
      'FROM [SwimClubMeet].[dbo].[Event]'
      '    INNER JOIN Distance'
      '        ON Event.DistanceID = Distance.DistanceID'
      '    INNER JOIN Stroke'
      '        ON Event.StrokeID = Stroke.StrokeID'
      'ORDER BY SessionID'
      '       , EventNum'
      '       ;')
    Left = 488
    Top = 168
  end
  object dsSession: TDataSource
    DataSet = qrySession
    Left = 576
    Top = 112
  end
  object dsEvent: TDataSource
    DataSet = qryEvent
    Left = 576
    Top = 168
  end
  object dsHeat: TDataSource
    DataSet = qryHeat
    Left = 576
    Top = 224
  end
  object qryHeat: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'EventID;HeatID'
    MasterSource = dsEvent
    MasterFields = 'EventID'
    DetailFields = 'EventID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.MaxBcdPrecision = 16
    FormatOptions.FmtDisplayTime = 'mm:ss.zz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    SQL.Strings = (
      '--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!'
      ''
      'USE SwimClubMeet'
      ';'
      'SELECT '
      #9#9'[EventID]'
      #9#9' ,[HeatID]'
      #9#9',[HeatNum]'
      #9#9',[Caption]'
      #9#9',[ScheduleDT]'
      #9#9',[ClosedDT]'
      #9#9',[HeatTypeID]'
      #9#9',[HeatStatusID]'
      'FROM [SwimClubMeet].[dbo].[HeatIndividual] '
      ';'
      ''
      ''
      '')
    Left = 488
    Top = 224
  end
  object frxdsSession: TfrxDBDataset
    UserName = 'frxdsSession'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SwimClubID=SwimClubID'
      'SessionID=SessionID'
      'Caption=Caption'
      'SessionStart=SessionStart'
      'ClosedDT=ClosedDT'
      'SessionStatusID=SessionStatusID')
    DataSource = dsSession
    BCDToCurrency = False
    Left = 664
    Top = 112
  end
  object frxdsEvent: TfrxDBDataset
    UserName = 'frxdsEvent'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SessionID=SessionID'
      'EventID=EventID'
      'EventNum=EventNum'
      'EventSTR=EventStr'
      'ClosedDT=ClosedDT'
      'ScheduleDT=ScheduleDT'
      'StrokeID=StrokeID'
      'DistanceID=DistanceID'
      'EventStatusID=EventStatusID'
      'StrokeStr=StrokeStr'
      'DistanceStr=DistanceStr'
      'EventDescription=EventDescription')
    DataSource = dsEvent
    BCDToCurrency = False
    Left = 664
    Top = 168
  end
  object frxdsHeat: TfrxDBDataset
    UserName = 'frxdsHeat'
    CloseDataSource = False
    FieldAliases.Strings = (
      'EventID=EventID'
      'HeatID=HeatID'
      'HeatNum=HeatNum'
      'Caption=Caption'
      'ScheduleDT=ScheduleDT'
      'ClosedDT=ClosedDT'
      'HeatTypeID=HeatTypeID'
      'HeatStatusID=HeatStatusID')
    DataSource = dsHeat
    BCDToCurrency = False
    Left = 664
    Top = 224
  end
  object qryEntrant: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'HeatID;EntrantID'
    MasterSource = dsHeat
    MasterFields = 'HeatID'
    DetailFields = 'HeatID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.MaxBcdPrecision = 16
    FormatOptions.FmtDisplayTime = 'nn:ss.zz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    SQL.Strings = (
      'USE SwimClubMeet'
      ';'
      ''
      'DECLARE @SessionDate AS DATETIME;'
      'SET @SessionDate = :SESSIONDATE;'
      ''
      #9'-- use a default sessiontime'
      #9'IF @SessionDate IS NULL'
      #9#9'SET @SessionDate = GETDATE();'
      ''
      'SELECT '
      #9#9'[HeatID]'
      #9#9' ,[EntrantID]'
      #9#9',[Lane]'
      #9',dbo.SwimTimeToString(RaceTime) AS RaceTime'
      #9',dbo.SwimTimeToString(TimeToBeat) AS TimeToBeat'
      #9',dbo.SwimTimeToString(PersonalBest) AS PersonalBest'
      #9#9',[IsDisqualified]'
      #9#9',[IsScratched]'
      #9#9',[DisqualifyCodeID]'
      #9#9',[Entrant].[MemberID]'
      #9',dbo.SwimmerGenderToString(Member.MemberID) AS GENDER'
      #9',dbo.SwimmerAge(@SessionDate, DOB) AS Age'
      
        #9',dbo.RaceTimeDIFF(Entrant.RaceTime, Entrant.PersonalBest) AS DI' +
        'FF   '
      #9',CONCAT ('
      #9#9'Member.FirstName'
      #9#9','#39' '#39
      #9#9',UPPER(Member.LastName)'
      #9#9') AS FNAME'
      '    '
      'FROM [SwimClubMeet].[dbo].[Entrant] '
      'INNER JOIN MEMBER ON ENTRANT.MEMBERID = MEMBER.MEMBERID'
      'WHERE ENTRANT.MEMBERID IS NOT NULL'
      ';'
      ''
      '')
    Left = 488
    Top = 288
    ParamData = <
      item
        Name = 'SESSIONDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsEntrant: TDataSource
    DataSet = qryEntrant
    Left = 576
    Top = 288
  end
  object frxdsEntrant: TfrxDBDataset
    UserName = 'frxdsEntrant'
    CloseDataSource = False
    FieldAliases.Strings = (
      'HeatID=HeatID'
      'EntrantID=EntrantID'
      'Lane=Lane'
      'RaceTime=RaceTime'
      'TimeToBeat=TimeToBeat'
      'PersonalBest=PersonalBest'
      'IsDisqualified=IsDisqualified'
      'IsScratched=IsScratched'
      'DisqualifyCodeID=DisqualifyCodeID'
      'MemberID=MemberID'
      'GENDER=GENDER'
      'Age=Age'
      'DIFF=DIFF'
      'FNAME=FNAME')
    DataSource = dsEntrant
    BCDToCurrency = False
    Left = 664
    Top = 288
  end
  object frxReport2: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45291.435444351900000000
    ReportOptions.LastChange = 45291.435444351900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 792
    Top = 416
    Datasets = <
      item
        DataSet = frxClubInfo
        DataSetName = 'frxClubInfo'
      end
      item
        DataSet = frxdsEntrant
        DataSetName = 'frxdsEntrant'
      end
      item
        DataSet = frxdsEvent
        DataSetName = 'frxdsEvent'
      end
      item
        DataSet = frxdsHeat
        DataSetName = 'frxdsHeat'
      end
      item
        DataSet = frxdsSession
        DataSetName = 'frxdsSession'
      end
      item
        DataSet = frxdsTEAM
        DataSetName = 'frxdsTEAM'
      end
      item
        DataSet = frxdsTeamEntrant
        DataSetName = 'frxdsTeamEntrant'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      VGuides.Strings = (
        '75.5'
        '310'
        '396.5'
        '473.5'
        '548.5'
        '344.5'
        '623.5'
        '38.5'
        '14'
        '706')
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 56.736240000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object frxdsSwimClubCaption: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 14.000000000000000000
          Width = 382.500000000000000000
          Height = 27.397650000000000000
          DataField = 'SwimClubName'
          DataSet = frxClubInfo
          DataSetName = 'frxClubInfo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxClubInfo."SwimClubName"]')
          ParentFont = False
        end
        object frxdsSwimClubNickName: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 14.000000000000000000
          Top = 21.000000000000000000
          Width = 382.500000000000000000
          Height = 18.897650000000000000
          DataField = 'NickName'
          DataSet = frxClubInfo
          DataSetName = 'frxClubInfo'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxClubInfo."NickName"]')
        end
        object frxdsSessionCaption: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 14.000000000000000000
          Top = 36.838590000000000000
          Width = 509.630180000000000000
          Height = 18.897650000000000000
          DataSet = frxdsSession
          DataSetName = 'frxdsSession'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Session [frxdsSession."Caption"]')
          ParentFont = False
        end
        object frxClubInfoSessionStart: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 530.629870000000000000
          Top = 37.338590000000000000
          Width = 175.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxClubInfo
          DataSetName = 'frxClubInfo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Session Date [frxClubInfo."SessionStart"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 9.177180000000000000
        Top = 136.063080000000000000
        Width = 718.110700000000000000
        DataSet = frxdsSession
        DataSetName = 'frxdsSession'
        RowCount = 0
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Fill.BackColor = 15724527
        Frame.Typ = []
        Height = 28.877860000000000000
        Top = 166.299320000000000000
        Width = 718.110700000000000000
        DataSet = frxdsEvent
        DataSetName = 'frxdsEvent'
        KeepTogether = True
        RowCount = 0
        object frxdsEventEventNum: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 13.500000000000000000
          Top = 3.980210000000000000
          Width = 320.870130000000000000
          Height = 18.897650000000000000
          DataField = 'EventDescription'
          DataSet = frxdsEvent
          DataSetName = 'frxdsEvent'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsEvent."EventDescription"]')
          ParentFont = False
        end
        object frxdsEventEventStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 339.500000000000000000
          Top = 3.877860000000000000
          Width = 374.630180000000000000
          Height = 18.897650000000000000
          DataField = 'EventStr'
          DataSet = frxdsEvent
          DataSetName = 'frxdsEvent'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdsEvent."EventStr"]')
          ParentFont = False
        end
      end
      object SubdetailData1: TfrxSubdetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 25.677180000000000000
        Top = 219.212740000000000000
        Width = 718.110700000000000000
        DataSet = frxdsHeat
        DataSetName = 'frxdsHeat'
        KeepTogether = True
        RowCount = 0
        object frxdsHeatHeatNum: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 38.500000000000000000
          Top = 5.625850000000000000
          Width = 231.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxdsHeat
          DataSetName = 'frxdsHeat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Heat [frxdsHeat."HeatNum"]')
          ParentFont = False
        end
      end
      object DataBand41: TfrxDataBand4
        FillType = ftBrush
        Frame.Typ = []
        Height = 20.397650000000000000
        Top = 317.480520000000000000
        Width = 718.110700000000000000
        DataSet = frxdsEntrant
        DataSetName = 'frxdsEntrant'
        KeepTogether = True
        RowCount = 0
        object frxdsEntrantLane: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 38.500000000000000000
          Top = 1.500000000000000000
          Width = 37.000000000000000000
          Height = 18.897650000000000000
          DataField = 'Lane'
          DataSet = frxdsEntrant
          DataSetName = 'frxdsEntrant'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdsEntrant."Lane"]')
          ParentFont = False
        end
        object frxdsEntrantRaceTime: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 396.500000000000000000
          Top = 1.500000000000000000
          Width = 77.000000000000000000
          Height = 18.897650000000000000
          DataField = 'RaceTime'
          DataSet = frxdsEntrant
          DataSetName = 'frxdsEntrant'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsEntrant."RaceTime"]')
        end
        object frxdsEntrantPersonalBest: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 473.500000000000000000
          Top = 1.500000000000000000
          Width = 75.000000000000000000
          Height = 18.897650000000000000
          DataField = 'PersonalBest'
          DataSet = frxdsEntrant
          DataSetName = 'frxdsEntrant'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsEntrant."PersonalBest"]')
        end
        object frxdsEntrantFNAME: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 75.500000000000000000
          Top = 1.500000000000000000
          Width = 234.500000000000000000
          Height = 18.897650000000000000
          DataField = 'FNAME'
          DataSet = frxdsEntrant
          DataSetName = 'frxdsEntrant'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsEntrant."FNAME"]')
        end
        object frxdsEntrantDIFF: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 548.500000000000000000
          Top = 1.500000000000000000
          Width = 75.000000000000000000
          Height = 18.897650000000000000
          DataField = 'DIFF'
          DataSet = frxdsEntrant
          DataSetName = 'frxdsEntrant'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsEntrant."DIFF"]')
        end
        object frxdsEntrantGENDER: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 310.000000000000000000
          Top = 1.500000000000000000
          Width = 34.500000000000000000
          Height = 18.897650000000000000
          DataField = 'GENDER'
          DataSet = frxdsEntrant
          DataSetName = 'frxdsEntrant'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdsEntrant."GENDER"]')
          ParentFont = False
        end
        object frxdsEntrantAge: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 344.500000000000000000
          Top = 1.519480000000000000
          Width = 52.000000000000000000
          Height = 18.897650000000000000
          DataField = 'Age'
          DataSet = frxdsEntrant
          DataSetName = 'frxdsEntrant'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdsEntrant."Age"]')
          ParentFont = False
        end
      end
      object DataBand42: TfrxDataBand4
        FillType = ftBrush
        Frame.Typ = []
        Height = 25.677180000000000000
        Top = 389.291590000000000000
        Width = 718.110700000000000000
        DataSet = frxdsTEAM
        DataSetName = 'frxdsTEAM'
        KeepTogether = True
        RowCount = 0
        object frxdsTEAMTeamNameStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 75.500000000000000000
          Top = 4.917130000000000000
          Width = 234.500000000000000000
          Height = 18.897650000000000000
          DataField = 'TeamNameStr'
          DataSet = frxdsTEAM
          DataSetName = 'frxdsTEAM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsTEAM."TeamNameStr"]')
          ParentFont = False
        end
        object frxdsTEAMLane: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 38.500000000000000000
          Top = 4.917130000000000000
          Width = 37.000000000000000000
          Height = 18.897650000000000000
          DataSet = frxdsTEAM
          DataSetName = 'frxdsTEAM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Lane [frxdsTEAM."Lane"]')
          ParentFont = False
        end
        object frxdsTEAMRaceTime: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 310.000000000000000000
          Top = 4.917130000000000000
          Width = 238.500000000000000000
          Height = 18.897650000000000000
          DataSet = frxdsTEAM
          DataSetName = 'frxdsTEAM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Racetime [frxdsTEAM."RaceTime"]')
          ParentFont = False
        end
      end
      object DataBand51: TfrxDataBand5
        FillType = ftBrush
        Frame.Typ = []
        Height = 20.677180000000000000
        Top = 487.559370000000000000
        Width = 718.110700000000000000
        DataSet = frxdsTeamEntrant
        DataSetName = 'frxdsTeamEntrant'
        KeepTogether = True
        RowCount = 0
        object frxdsTeamEntrantFNAME: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 75.500000000000000000
          Top = 0.783240000000000000
          Width = 234.500000000000000000
          Height = 18.897650000000000000
          DataField = 'FNAME'
          DataSet = frxdsTeamEntrant
          DataSetName = 'frxdsTeamEntrant'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsTeamEntrant."FNAME"]')
        end
        object frxdsTeamEntrantLane: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 37.500000000000000000
          Top = 0.783240000000000000
          Width = 38.000000000000000000
          Height = 18.897650000000000000
          DataField = 'Lane'
          DataSet = frxdsTeamEntrant
          DataSetName = 'frxdsTeamEntrant'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdsTeamEntrant."Lane"]')
          ParentFont = False
        end
        object frxdsTeamEntrantStrokeStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 623.500000000000000000
          Top = 0.783240000000000000
          Width = 82.500000000000000000
          Height = 18.897650000000000000
          DataField = 'StrokeStr'
          DataSet = frxdsTeamEntrant
          DataSetName = 'frxdsTeamEntrant'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsTeamEntrant."StrokeStr"]')
        end
        object frxdsTeamEntrantRaceTime: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 396.000000000000000000
          Top = 0.783240000000000000
          Width = 77.500000000000000000
          Height = 18.897650000000000000
          DataField = 'RaceTime'
          DataSet = frxdsTeamEntrant
          DataSetName = 'frxdsTeamEntrant'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsTeamEntrant."RaceTime"]')
        end
        object frxdsTeamEntrantPersonalBest: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 473.500000000000000000
          Top = 0.783240000000000000
          Width = 75.000000000000000000
          Height = 18.897650000000000000
          DataField = 'PersonalBest'
          DataSet = frxdsTeamEntrant
          DataSetName = 'frxdsTeamEntrant'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsTeamEntrant."PersonalBest"]')
        end
        object frxdsTeamEntrantDIFF: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 548.500000000000000000
          Top = 0.440630000000000000
          Width = 75.000000000000000000
          Height = 18.897650000000000000
          DataField = 'DIFF'
          DataSet = frxdsTeamEntrant
          DataSetName = 'frxdsTeamEntrant'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsTeamEntrant."DIFF"]')
        end
        object frxdsTeamEntrantAge: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 344.500000000000000000
          Top = 0.440630000000000000
          Width = 52.000000000000000000
          Height = 18.897650000000000000
          DataField = 'Age'
          DataSet = frxdsTeamEntrant
          DataSetName = 'frxdsTeamEntrant'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdsTeamEntrant."Age"]')
          ParentFont = False
        end
        object frxdsTeamEntrantGENDER: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 310.000000000000000000
          Top = 0.440630000000000000
          Width = 34.500000000000000000
          Height = 18.897650000000000000
          DataField = 'GENDER'
          DataSet = frxdsTeamEntrant
          DataSetName = 'frxdsTeamEntrant'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxdsTeamEntrant."GENDER"]')
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 27.677180000000000000
        Top = 268.346630000000000000
        Width = 718.110700000000000000
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 37.866110000000000000
          Top = 6.712430000000000000
          Width = 37.633890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Lane')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 75.500000000000000000
          Top = 6.712430000000000000
          Width = 234.500000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Swimmer')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 396.673470000000000000
          Top = 6.712430000000000000
          Width = 76.826530000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RaceTime')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 310.000000000000000000
          Top = 6.712430000000000000
          Width = 34.500000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'M/F')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 343.760050000000000000
          Top = 6.712430000000000000
          Width = 52.739950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Age')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 548.500000000000000000
          Top = 6.712430000000000000
          Width = 75.000000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DIFF')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 473.500000000000000000
          Top = 6.712430000000000000
          Width = 75.000000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'PB')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 8.177180000000000000
        Top = 359.055350000000000000
        Width = 718.110700000000000000
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 25.397650000000000000
        Top = 438.425480000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 32.500000000000000000
          Top = 6.500000000000000000
          Width = 43.000000000000000000
          Height = 16.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Order')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 396.500000000000000000
          Top = 6.500000000000000000
          Width = 77.000000000000000000
          Height = 17.177180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'SplitTime')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 473.500000000000000000
          Top = 6.500000000000000000
          Width = 75.000000000000000000
          Height = 17.177180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'PB')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 75.500000000000000000
          Top = 6.500000000000000000
          Width = 234.500000000000000000
          Height = 17.177180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Swimmer')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Left = 548.500000000000000000
          Top = 6.500000000000000000
          Width = 75.000000000000000000
          Height = 17.177180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DIFF')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 344.500000000000000000
          Top = 6.500000000000000000
          Width = 52.000000000000000000
          Height = 17.177180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Age')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 310.000000000000000000
          Top = 6.500000000000000000
          Width = 34.500000000000000000
          Height = 17.177180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'M/F')
          ParentFont = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 5.677180000000000000
        Top = 532.913730000000000000
        Width = 718.110700000000000000
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 600.945270000000000000
        Width = 718.110700000000000000
        object Page: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 14.000000000000000000
          Top = 1.952380000000000000
          Width = 175.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          Formats = <
            item
            end
            item
            end>
        end
        object Date1: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 555.000000000000000000
          Top = 2.054730000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 635.500000000000000000
          Top = 2.054730000000000000
          Width = 70.500000000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            '[Time]')
        end
      end
    end
  end
  object qryTEAM: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'HeatID;TeamID'
    MasterSource = dsHeat
    MasterFields = 'HeatID'
    DetailFields = 'HeatID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    SQL.Strings = (
      'USE SwimClubMeet'
      ';'
      ''
      'SELECT  '
      'HeatID'
      ',TeamID'
      ',Lane'
      #9',dbo.SwimTimeToString(RaceTime) AS RaceTime'
      #9',dbo.SwimTimeToString(TimeToBeat) AS TimeToBeat'
      ''
      ',IsDisqualified'
      ',IsScratched'
      ',DisqualifyCodeID'
      ',Team.TeamNameID'
      ',TeamName.Caption AS TeamNameStr'
      'FROM SwimClubMeet.dbo.Team'
      'INNER JOIN TeamName ON Team.TeamNameID = TeamName.TeamNameID'
      'WHERE Team.TeamNameID IS NOT NULL'
      'ORDER BY HeatID, Lane'
      ';')
    Left = 488
    Top = 352
  end
  object dsTEAM: TDataSource
    DataSet = qryTEAM
    Left = 576
    Top = 352
  end
  object frxdsTEAM: TfrxDBDataset
    UserName = 'frxdsTEAM'
    CloseDataSource = False
    FieldAliases.Strings = (
      'HeatID=HeatID'
      'TeamID=TeamID'
      'Lane=Lane'
      'RaceTime=RaceTime'
      'TimeToBeat=TimeToBeat'
      'IsDisqualified=IsDisqualified'
      'IsScratched=IsScratched'
      'DisqualifyCodeID=DisqualifyCodeID'
      'TeamNameID=TeamNameID'
      'TeamNameStr=TeamNameStr')
    DataSource = dsTEAM
    BCDToCurrency = False
    Left = 664
    Top = 352
  end
  object qryTeamEntrant: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'TeamID;TeamEntrantID'
    MasterSource = dsTEAM
    MasterFields = 'TeamID'
    DetailFields = 'TeamID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    SQL.Strings = (
      'USE SwimClubMeet'
      ';'
      ''
      'DECLARE @SessionDate AS DATETIME;'
      'SET @SessionDate = :SESSIONDATE;'
      ''
      #9'-- use a default sessiontime'
      #9'IF @SessionDate IS NULL'
      #9#9'SET @SessionDate = GETDATE();'
      ''
      ''
      'SELECT  '
      'TeamID'
      ',TeamEntrantID'
      ',Lane'
      #9',dbo.SwimTimeToString(RaceTime) AS RaceTime'
      #9',dbo.SwimTimeToString(TimeToBeat) AS TimeToBeat'
      #9',dbo.SwimTimeToString(PersonalBest) AS PersonalBest'
      ',IsDisqualified'
      ',IsScratched'
      ',DisqualifyCodeID'
      ',TeamEntrant.MemberID'
      ',Concat(Member.FirstName, '#39' '#39' , UPPER(Member.LastName)) AS FNAME'
      #9',dbo.SwimmerGenderToString(Member.MemberID) AS GENDER'
      #9',dbo.SwimmerAge(@SessionDate, DOB) AS Age'
      
        #9',dbo.RaceTimeDIFF(TeamEntrant.RaceTime, TeamEntrant.PersonalBes' +
        't) AS DIFF   '
      ''
      ',TeamEntrant.StrokeID'
      ',Stroke.Caption AS StrokeStr'
      'FROM SwimClubMeet.dbo.TeamEntrant'
      'INNER JOIN Member ON TeamEntrant.MemberID = Member.MemberID'
      'LEFT JOIN Stroke ON TeamEntrant.StrokeID = Stroke.StrokeID'
      'WHERE TeamEntrant.MemberID IS NOT NULL'
      'ORDER BY TeamID, Lane'
      ';')
    Left = 488
    Top = 416
    ParamData = <
      item
        Name = 'SESSIONDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsTeamEntrant: TDataSource
    DataSet = qryTeamEntrant
    Left = 576
    Top = 416
  end
  object frxdsTeamEntrant: TfrxDBDataset
    UserName = 'frxdsTeamEntrant'
    CloseDataSource = False
    FieldAliases.Strings = (
      'TeamID=TeamID'
      'TeamEntrantID=TeamEntrantID'
      'Lane=Lane'
      'RaceTime=RaceTime'
      'TimeToBeat=TimeToBeat'
      'PersonalBest=PersonalBest'
      'IsDisqualified=IsDisqualified'
      'IsScratched=IsScratched'
      'DisqualifyCodeID=DisqualifyCodeID'
      'MemberID=MemberID'
      'FNAME=FNAME'
      'GENDER=GENDER'
      'Age=Age'
      'DIFF=DIFF'
      'StrokeID=StrokeID'
      'StrokeStr=StrokeStr')
    DataSource = dsTeamEntrant
    BCDToCurrency = False
    Left = 664
    Top = 416
  end
end
