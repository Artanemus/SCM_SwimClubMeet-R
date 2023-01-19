object QTTableReportA: TQTTableReportA
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 391
  Width = 319
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
    ReportOptions.LastChange = 43781.762864351800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      '  '
      
        '    Memo12.Memo.Clear();                                        ' +
        '                    '
      '    if <frxDS."IsShortCourse"> then '
      '    begin'
      
        '       Memo12.Memo.Add('#39'Qualification Times for short course eve' +
        'nts (SC)'#39');                                                     ' +
        '               '
      '    end'
      '    else'
      '    begin'
      
        '       Memo12.Memo.Add('#39'Qualification Times for long course even' +
        'ts (LC)'#39');                                                      ' +
        '              '
      '    end;'
      '      '
      'end.')
    Left = 160
    Top = 16
    Datasets = <
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
      Font.Name = 'Segoe UI'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Color = clNone
      Frame.ShadowColor = clNone
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 71.811070000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object FDQuery1cSwimClub: TfrxMemoView
          AllowVectorExport = True
          Width = 714.331170000000000000
          Height = 30.236240000000000000
          AutoWidth = True
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."ClubName"]')
          ParentFont = False
        end
        object FDQuery1NickName: TfrxMemoView
          AllowVectorExport = True
          Top = 22.677180000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."ClubNickName"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Top = 49.133890000000000000
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
            'Qualification Times for short course events (SC).')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 75.590600000000000000
        ParentFont = False
        Top = 151.181200000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."GenderID"'
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 10.779530000000000000
          Width = 706.772110000000000000
          Height = 60.472480000000000000
          Fill.BackColor = cl3DLight
          Frame.Color = clNone
          Frame.Typ = []
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 64.118120000000000000
          Width = 699.213050000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 20.661410000000000000
          Width = 94.488250000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'The distance to QUALIFY')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 113.385900000000000000
          Top = 20.661410000000000000
          Width = 94.488250000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Swimming Stroke')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 215.433210000000000000
          Top = 13.661410000000000000
          Width = 94.488250000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'The TRIAL distance')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 313.700990000000000000
          Top = 13.661410000000000000
          Width = 94.488250000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Gender')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 430.866420000000000000
          Top = 13.661410000000000000
          Width = 94.488250000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'The TIME the TRIAL distance must be completed')
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
        Top = 249.448980000000000000
        Width = 718.110700000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object frxDSQualifyDistance: TfrxMemoView
          AllowVectorExport = True
          Left = 34.015770000000000000
          Top = 2.000000000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          DataField = 'QualifyDistance'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."QualifyDistance"]')
          ParentFont = False
        end
        object frxDSTrialDistance: TfrxMemoView
          AllowVectorExport = True
          Left = 215.433210000000000000
          Top = 2.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'TrialDistance'
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
            '[frxDS."TrialDistance"]')
          ParentFont = False
        end
        object frxDSGenderID: TfrxMemoView
          AllowVectorExport = True
          Left = 313.700990000000000000
          Top = 2.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
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
            '[frxDS."GenderStr"]')
          ParentFont = False
        end
        object frxDSStroke: TfrxMemoView
          AllowVectorExport = True
          Left = 113.385900000000000000
          Top = 2.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'Stroke'
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
            '[frxDS."Stroke"]')
          ParentFont = False
        end
        object frxDSTrialTime: TfrxMemoView
          AllowVectorExport = True
          Left = 430.866420000000000000
          Top = 2.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'TrialTime'
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
            '[frxDS."TrialTime"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 332.598640000000000000
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
    IndexFieldNames = 'QualifyID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss:zzz'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @IsShortCourse AS BIT'
      'DECLARE @ClubName AS nvarchar(128)'
      'DECLARE @ClubNickName AS nvarchar(128)'
      ''
      'SET @IsShortCourse = :IsShortCourse;'
      'SET @ClubName = :ClubName;'
      'SET @ClubNickName = :ClubNickName;'
      ''
      'SELECT Qualify.QualifyID'
      #9',Qualify.TrialTime'
      #9',Qualify.IsShortCourse'
      #9',Qualify.GenderID'
      #9',Qualify.LengthOfPool'
      ',@ClubName AS ClubName'
      
        ',@ClubNickName AS ClubNickName'#9',QualifyDistance.Caption AS Quali' +
        'fyDistance'
      #9',TrialDistance.Caption AS TrialDistance'
      #9',Stroke.Caption AS Stroke'
      #9',CASE [GenderID]'
      #9#9'WHEN 1'
      #9#9#9'THEN '#39'M'#39
      #9#9'WHEN 2'
      #9#9#9'THEN '#39'F'#39
      #9#9'END AS GenderStr'
      ''
      ''
      'FROM Qualify'
      'INNER JOIN Stroke ON Qualify.StrokeID = Stroke.StrokeID'
      
        'INNER JOIN Distance AS TrialDistance ON Qualify.TrialDistID = Tr' +
        'ialDistance.DistanceID'
      
        'INNER JOIN Distance AS QualifyDistance ON Qualify.QualifyDistID ' +
        '= QualifyDistance.DistanceID'
      ''
      'WHERE (Qualify.IsShortCourse =  @IsShortCourse)'
      ''
      'ORDER BY'
      '  GenderID, Qualify.TrialDistID, Qualify.StrokeID ')
    Left = 160
    Top = 272
    ParamData = <
      item
        Name = 'ISSHORTCOURSE'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'CLUBNAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CLUBNICKNAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
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
    Left = 64
    Top = 272
  end
end
