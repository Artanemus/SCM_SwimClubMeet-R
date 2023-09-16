object QTNotQualified: TQTNotQualified
  OnCreate = DataModuleCreate
  Height = 461
  Width = 404
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
    ReportOptions.LastChange = 45184.592208807900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      '  '
      '      '
      'end.')
    Left = 224
    Top = 32
    Datasets = <
      item
        DataSet = frxDSReport
        DataSetName = 'frxDS'
      end
      item
        DataSet = frxDBReportHeader
        DataSetName = 'frxDSHeader'
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
      Font.Name = 'Segoe UI'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 190.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Color = clNone
      Frame.ShadowColor = clNone
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 64.252010000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object FDQuery1cSwimClub: TfrxMemoView
          AllowVectorExport = True
          Width = 714.331170000000000000
          Height = 30.236240000000000000
          AutoWidth = True
          DataSet = frxDBReportHeader
          DataSetName = 'frxDSHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDSHeader."Caption"]')
          ParentFont = False
        end
        object FDQuery1NickName: TfrxMemoView
          AllowVectorExport = True
          Top = 22.677180000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          DataSet = frxDBReportHeader
          DataSetName = 'frxDSHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDSHeader."NickName"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Top = 45.354360000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Members that are swimming in events but are not qualified. (For ' +
              'the current session).')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Height = 58.354360000000000000
        ParentFont = False
        Top = 143.622140000000000000
        Width = 718.110700000000000000
        Condition = '<frxDS."DistanceID"> + (<frxDS."StrokeID"> * 100)'
        KeepTogether = True
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 11.661410000000000000
          Width = 705.212740000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object frxDSDistanceStr: TfrxMemoView
          AllowVectorExport = True
          Left = 6.559060000000000000
          Top = 13.118120000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."strDistance"]')
          ParentFont = False
        end
        object frxDSStrokeStr: TfrxMemoView
          AllowVectorExport = True
          Left = 78.370130000000000000
          Top = 13.118120000000000000
          Width = 166.740260000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."strStroke"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 511.000000000000000000
          Top = 15.377860000000000000
          Width = 100.988250000000000000
          Height = 40.397650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Personal Best'
            'for Qualification'
            'Distance')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 615.500000000000000000
          Top = 14.877860000000000000
          Width = 94.488250000000000000
          Height = 40.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Qualification'
            'Time'
            'Required')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 172.500000000000000000
          Top = 36.877860000000000000
          Width = 48.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Heat#')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 5.500000000000000000
          Top = 36.877860000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Swimmer')
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 410.000000000000000000
          Top = 28.877860000000000000
          Width = 72.488250000000000000
          Height = 26.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Qualification '
            'Distance')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        Height = 22.677180000000000000
        ParentFont = False
        Top = 222.992270000000000000
        Width = 718.110700000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object frxDSFName: TfrxMemoView
          AllowVectorExport = True
          Top = -3.000000000000000000
          Width = 179.283550000000000000
          Height = 22.677180000000000000
          DataField = 'FName'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FName"]')
        end
        object Memo2: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 520.500000000000000000
          Top = 1.346320000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."PB"]')
        end
        object frxDSQTime: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 615.000000000000000000
          Top = 1.346320000000000000
          Width = 92.870130000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."QTime"]')
        end
        object frxDSHeatNum: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 181.500000000000000000
          Top = 0.507730000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'HeatNum'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."HeatNum"]')
        end
        object frxDSstrQDistance: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 410.500000000000000000
          Top = 0.507730000000000000
          Width = 73.630180000000000000
          Height = 18.897650000000000000
          DataField = 'strQDistance'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."strQDistance"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 306.141930000000000000
        Width = 718.110700000000000000
        object TotalPages: TfrxMemoView
          AllowVectorExport = True
          Left = 266.456865000000000000
          Top = 1.889765000000010000
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
          Top = 3.779530000000020000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed On: [Date]')
        end
      end
    end
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'DistanceID;StrokeID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss:zzz'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SessionID AS INTEGER;'
      'SET @SessionID = :SESSIONID;'
      ''
      '-- Drop a temporary table called '#39'#QTemp'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#QTemp'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #QTemp;'
      ''
      
        '-- Create the temporary table from a physical table called '#39'Sess' +
        'ion'#39' in schema '#39'dbo'#39' in database '#39'SwimClubMeet'#39
      'SELECT [Session].SessionID'
      '     , [Event].EventID'
      '     , [Event].DistanceID'
      '     , [Event].StrokeID'
      '     , [HeatIndividual].[HeatID]'
      '     , [HeatIndividual].[HeatNum]'
      '     , [Entrant].MemberID'
      
        '     , dbo.PersonalBest([Member].MemberID, [Qualify].TrialDistID' +
        ', Event.StrokeID, Session.SessionStart) AS PB'
      '     , [Qualify].TrialTime AS QTime'
      '     , [Qualify].TrialDistID'
      'INTO #QTemp'
      'FROM [SwimClubMeet].[dbo].[Session]'
      '    INNER JOIN [Event]'
      '        ON [Session].SessionID = [Event].SessionID'
      '    INNER JOIN [HeatIndividual]'
      '        ON [Event].[EventID] = [HeatIndividual].[EventID]'
      '    INNER JOIN [Entrant]'
      '        ON [HeatIndividual].HeatID = [Entrant].HeatID'
      '    INNER JOIN [Member]'
      '        ON [Entrant].MemberID = [Member].MemberID'
      '    INNER JOIN [Qualify]'
      '        ON [Event].DistanceID = [Qualify].[QualifyDistID]'
      '           AND [Event].StrokeID = [Qualify].StrokeID'
      '    INNER JOIN [SwimClub]'
      '        ON [Session].SwimClubID = [SwimClub].[SwimClubID]'
      'WHERE [Session].SessionID = @SessionID'
      '      AND [Entrant].MemberID IS NOT NULL'
      '      AND [Qualify].LengthOfPool = [SwimClub].[LenOfPool]'
      '      AND [Member].[GenderID] = [Qualify].[GenderID];'
      ''
      'SELECT SessionID'
      '     , EventID'
      '     , #QTemp.[DistanceID]'
      '     , #QTemp.[StrokeID]'
      '     , HeatID'
      '     , HeatNum'
      '     , #QTemp.MemberID'
      '     , #QTemp.TrialDistID'
      '     , dbo.SwimTimeToString(PB) AS PB'
      '     , dbo.SwimTimeToString(QTime) AS QTime'
      '     , [Distance].Caption AS strDistance'
      '     , qDistance.Caption AS strQDistance'
      '     , [Stroke].Caption AS strStroke'
      '     , CONCAT(Member.FirstName, '#39' '#39', member.LastName) AS FName'
      'FROM #QTemp'
      '    INNER JOIN [Distance]'
      '        ON #QTemp.DistanceID = [Distance].DistanceID'
      '    INNER JOIN [Distance] AS qDistance'
      '        ON #QTemp.TrialDistID = qDistance.DistanceID'
      '    INNER JOIN [Stroke]'
      '        ON #QTemp.StrokeID = [Stroke].StrokeID'
      '    INNER JOIN [Member]'
      '        ON #QTemp.MemberID = [Member].MemberID'
      'WHERE PB IS NOT NULL'
      '      AND (PB > QTime)'
      ''
      ''
      ''
      '')
    Left = 96
    Top = 296
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 6
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
    Left = 224
    Top = 224
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
    Left = 224
    Top = 168
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
    Left = 224
    Top = 112
  end
  object frxDSReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SessionID=SessionID'
      'EventID=EventID'
      'DistanceID=DistanceID'
      'StrokeID=StrokeID'
      'HeatID=HeatID'
      'HeatNum=HeatNum'
      'MemberID=MemberID'
      'TrialDistID=TrialDistID'
      'PB=PB'
      'QTime=QTime'
      'strDistance=strDistance'
      'strQDistance=strQDistance'
      'strStroke=strStroke'
      'FName=FName')
    DataSet = qryReport
    BCDToCurrency = False
    Left = 224
    Top = 296
  end
  object frxDBReportHeader: TfrxDBDataset
    UserName = 'frxDSHeader'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SwimClubID=SwimClubID'
      'NickName=NickName'
      'Caption=Caption'
      'Email=Email'
      'ContactNum=ContactNum'
      'WebSite=WebSite'
      'NumOfLanes=NumOfLanes'
      'LenOfPool=LenOfPool'
      'StartOfSwimSeason=StartOfSwimSeason'
      'PoolTypeID=PoolTypeID'
      'SwimClubTypeID=SwimClubTypeID')
    DataSet = qryReportHeader
    BCDToCurrency = False
    Left = 224
    Top = 360
  end
  object qryReportHeader: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SwimClubID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss:zzz'
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
      'SELECT '
      #9#9' [SwimClubID]'
      #9#9',[NickName]'
      #9#9',[Caption]'
      #9#9',[Email]'
      #9#9',[ContactNum]'
      #9#9',[WebSite]'
      #9#9',[NumOfLanes]'
      #9#9',[LenOfPool]'
      #9#9',[StartOfSwimSeason]'
      #9#9',[PoolTypeID]'
      #9#9',[SwimClubTypeID]'
      '    '
      'FROM [SwimClubMeet].[dbo].[SwimClub] '
      ''
      'WHERE [SwimClubID] =  @SwimClubID;')
    Left = 96
    Top = 360
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
end
