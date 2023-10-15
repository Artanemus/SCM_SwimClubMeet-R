object TimeKeeperReportB: TTimeKeeperReportB
  Height = 446
  Width = 442
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SessionID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Event'
    UpdateOptions.KeyFields = 'FNAME'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @HeatID as integer;'
      ''
      'SET @HeatID = :HEATID;'
      ''
      'SELECT'
      '  Event.EventID,'
      '  Distance.Caption AS cDistance,'
      '  Stroke.Caption AS cStroke,'
      '  HeatIndividual.HeatNum,'
      'HeatIndividual.HeatID,'
      '  Entrant.Lane,'
      
        '  Concat(Member.FirstName, '#39' '#39', Upper(Member.LastName)) AS FNAME' +
        ','
      
        'Format(CAST(Entrant.RaceTime AS DATETIME), '#39'mm:ss.fff'#39') AS RaceT' +
        'ime,'
      
        'Format(CAST(Entrant.TimeToBeat AS DATETIME), '#39'mm:ss.fff'#39') AS Tim' +
        'eToBeat,'
      ''
      'CASE CAST([Entrant].[PersonalBest] AS DATETIME)'
      '       WHEN NULL THEN '#39#39
      '       WHEN 0 THEN '#39#39
      
        '       ELSE Format(CAST([Entrant].[PersonalBest] AS DATETIME), '#39 +
        'mm:ss.fff'#39')'
      '       END AS PersonalBest,'
      ''
      
        '-- Format(CAST(Entrant.PersonalBest AS DATETIME), '#39'mm:ss.fff'#39') A' +
        'S PersonalBest,'
      '  Entrant.IsDisqualified,'
      '  Entrant.IsScratched,'
      '  Event.EventNum,'
      '  Session.SessionStart,'
      '  SwimClub.NickName,'
      '  SwimClub.Caption AS cSwimClub,'
      'Event.SessionID'
      'FROM'
      '  Event'
      '  INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      '  INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      
        '  INNER JOIN HeatIndividual ON HeatIndividual.EventID = Event.Ev' +
        'entID'
      '  INNER JOIN Entrant ON Entrant.HeatID = HeatIndividual.HeatID'
      '  LEFT JOIN Member ON Entrant.MemberID = Member.MemberID'
      '  INNER JOIN Session ON Event.SessionID = Session.SessionID'
      
        '  INNER JOIN SwimClub ON Session.SwimClubID = SwimClub.SwimClubI' +
        'D'
      'WHERE'
      '  HeatIndividual.HeatID = @HeatID'
      'ORDER BY'
      '  Event.EventNum,'
      '  HeatIndividual.HeatNum,'
      '  Entrant.Lane')
    Left = 160
    Top = 272
    ParamData = <
      item
        Name = 'HEATID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 276
      end>
  end
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
    Left = 160
    Top = 208
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
    Left = 160
    Top = 152
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
    Left = 160
    Top = 96
  end
  object frxDSReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryReport
    BCDToCurrency = False
    Left = 272
    Top = 272
  end
  object frxReport1: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43428.811813125000000000
    ReportOptions.LastChange = 43480.811662002300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnPrintReport = frxReport1PrintReport
    Left = 272
    Top = 48
    Datasets = <
      item
        DataSet = frxClubInfo
        DataSetName = 'frxClubInfo'
      end
      item
        DataSet = frxDSReport
        DataSetName = 'frxDS'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 283.464750000000000000
        Width = 718.110700000000000000
        object TotalPages: TfrxMemoView
          AllowVectorExport = True
          Left = 266.456865000000000000
          Top = 1.889765000000000000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Date: TfrxMemoView
          AllowVectorExport = True
          Top = 1.889765000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed On: [Date #d  dd MMM YYYY HH:MM AM/PM]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 13.177180000000000000
        Top = 98.267780000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."HeatNum"'
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 41.574830000000000000
        Top = 181.417440000000000000
        Width = 718.110700000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        RowCount = 0
        object frxDSLane: TfrxMemoView
          AllowVectorExport = True
          Left = 15.118120000000000000
          Top = 1.779530000000000000
          Width = 49.133890000000000000
          Height = 26.456710000000000000
          DataField = 'Lane'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."Lane"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDSFNAME: TfrxMemoView
          AllowVectorExport = True
          Left = 64.252010000000000000
          Top = 1.779530000000000000
          Width = 196.535560000000000000
          Height = 26.456710000000000000
          DataField = 'FNAME'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FNAME"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDSTime: TfrxMemoView
          AllowVectorExport = True
          Left = 265.067100000000000000
          Top = 1.779530000000000000
          Width = 212.358380000000000000
          Height = 34.015770000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 3.000000000000000000
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDSTimeToBet: TfrxMemoView
          AllowVectorExport = True
          Left = 485.984540000000000000
          Top = 1.779530000000000000
          Width = 68.031540000000000000
          Height = 26.456710000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."TimeToBeat"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDSPersonalBest: TfrxMemoView
          AllowVectorExport = True
          Left = 557.795610000000000000
          Top = 1.779530000000000000
          Width = 79.370130000000000000
          Height = 26.456710000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."PersonalBest"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDSIsScratched: TfrxMemoView
          AllowVectorExport = True
          Left = 645.417750000000000000
          Top = 1.779530000000000000
          Width = 61.354360000000000000
          Height = 26.456710000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          DisplayFormat.Kind = fkBoolean
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 3.000000000000000000
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 56.692950000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."EventID"'
        object frxDSHeatNum: TfrxMemoView
          AllowVectorExport = True
          Top = 26.456710000000000000
          Width = 714.331170000000000000
          Height = 26.456710000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            ' Heat# [frxDS."HeatNum"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDScDistance: TfrxMemoView
          AllowVectorExport = True
          Top = 0.220470000000000000
          Width = 714.331170000000000000
          Height = 22.677180000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."cDistance"] [frxDS."cStroke"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object frxDScSwimClub: TfrxMemoView
          AllowVectorExport = True
          Left = 283.500000000000000000
          Top = 40.177180000000000000
          Width = 433.712740000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSet = frxClubInfo
          DataSetName = 'frxClubInfo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              'Session: [<frxClubInfo."SessionStart">  #dDDD dd MMM YYYY HH:MM ' +
              'AM/PM]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Top = 3.779530000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataField = 'SwimClubName'
          DataSet = frxClubInfo
          DataSetName = 'frxClubInfo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxClubInfo."SwimClubName"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 136.063080000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."HeatNum"'
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 2.500000000000000000
          Top = 1.708410000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Lane')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 52.133890000000000000
          Top = 1.708410000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Entrant')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 271.346630000000000000
          Top = 1.708410000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RaceTime')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 470.086890000000000000
          Top = 1.708410000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'TTB')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 545.677490000000000000
          Top = 1.708410000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'PB')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 632.165740000000000000
          Top = 1.708410000000000000
          Width = 62.854360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DCODE')
          ParentFont = False
          VAlign = vaBottom
        end
      end
    end
  end
  object qryClubInfoRpt: TFDQuery
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
    Left = 56
    Top = 376
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
    DataSet = qryClubInfoRpt
    BCDToCurrency = False
    Left = 168
    Top = 376
  end
end
