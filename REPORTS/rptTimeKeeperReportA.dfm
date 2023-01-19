object TimeKeeperReportA: TTimeKeeperReportA
  OldCreateOrder = False
  Height = 389
  Width = 385
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
    ReportOptions.LastChange = 43480.811196088000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnPrintReport = frxReport1PrintReport
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
        Top = 211.653680000000000000
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
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed On: [Date]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."Lane"'
        object frxDScDistance: TfrxMemoView
          AllowVectorExport = True
          Top = 0.220470000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDS."cDistance"] [frxDS."cStroke"] - Heat# [frxDS."HeatNum"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object frxDScSwimClub: TfrxMemoView
          AllowVectorExport = True
          Left = 438.425480000000000000
          Width = 279.685220000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[frxDS."cSwimClub"] - [<frxDS."SessionStart"> #dddd dd mmm yyyy ' +
              'HH:MM AM/PM]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 15.118120000000000000
          Top = 23.897650000000000000
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
          Left = 71.811070000000000000
          Top = 23.897650000000000000
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
          Left = 287.244280000000000000
          Top = 23.897650000000000000
          Width = 154.960730000000000000
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
          Left = 457.323130000000000000
          Top = 23.897650000000000000
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
          Left = 529.134200000000000000
          Top = 23.897650000000000000
          Width = 83.149660000000000000
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
          Left = 619.842920000000000000
          Top = 23.897650000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'D')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 665.197280000000000000
          Top = 23.897650000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'S')
          ParentFont = False
          VAlign = vaBottom
        end
        object frxDScEvent: TfrxMemoView
          AllowVectorExport = True
          Left = 188.976500000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'cEvent'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."cEvent"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 64.252010000000000000
        Top = 86.929190000000000000
        Width = 718.110700000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        RowCount = 0
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 1.779530000000000000
          Top = 46.015770000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.TopLine.Style = fsDot
          Frame.TopLine.Width = 3.000000000000000000
        end
        object frxDSLane: TfrxMemoView
          AllowVectorExport = True
          Left = 15.118120000000000000
          Top = 1.779530000000000000
          Width = 49.133890000000000000
          Height = 34.015770000000000000
          DataField = 'Lane'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
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
          Left = 68.031540000000000000
          Top = 5.779530000000000000
          Width = 215.433210000000000000
          Height = 26.456710000000000000
          DataField = 'FNAME'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FNAME"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDSTime: TfrxMemoView
          AllowVectorExport = True
          Left = 287.244280000000000000
          Top = 1.779530000000000000
          Width = 154.960730000000000000
          Height = 37.795300000000000000
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
          Left = 457.323130000000000000
          Top = 1.779530000000000000
          Width = 71.811070000000000000
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
          Left = 532.913730000000000000
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
        object frxDSIsDisqualified: TfrxMemoView
          AllowVectorExport = True
          Left = 619.842920000000000000
          Top = 1.779530000000000000
          Width = 41.574830000000000000
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
        object frxDSIsScratched: TfrxMemoView
          AllowVectorExport = True
          Left = 665.197280000000000000
          Top = 1.779530000000000000
          Width = 41.574830000000000000
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
    end
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SessionID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Event'
    UpdateOptions.KeyFields = 'FNAME'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @HeatID AS INT'
      ''
      'SET @HeatID = :HEATID'
      ''
      'SELECT Event.EventID'
      #9',Event.Caption AS cEvent'
      #9',Distance.Caption AS cDistance'
      #9',Stroke.Caption AS cStroke'
      #9',HeatIndividual.HeatNum'
      #9',HeatIndividual.HeatID'
      #9',Entrant.Lane'
      #9',CONCAT ('
      #9#9'Member.FirstName'
      #9#9','#39' '#39
      #9#9',Upper(Member.LastName)'
      #9#9') AS FNAME'
      
        #9',Format(CAST(Entrant.RaceTime AS DATETIME), '#39'mm:ss.fff'#39') AS Rac' +
        'eTime'
      
        #9',Format(CAST(Entrant.TimeToBeat AS DATETIME), '#39'mm:ss.fff'#39') AS T' +
        'imeToBeat'
      #9',CASE CAST([Entrant].[PersonalBest] AS DATETIME)'
      #9#9'WHEN NULL'
      #9#9#9'THEN '#39#39
      #9#9'WHEN 0'
      #9#9#9'THEN '#39#39
      
        #9#9'ELSE Format(CAST([Entrant].[PersonalBest] AS DATETIME), '#39'mm:ss' +
        '.fff'#39')'
      #9#9'END AS PersonalBest'
      #9',Entrant.IsDisqualified'
      #9',Entrant.IsScratched'
      #9',Event.EventNum'
      #9',Session.SessionStart'
      #9',SwimClub.NickName'
      #9',SwimClub.Caption AS cSwimClub'
      #9',Event.SessionID'
      'FROM Event'
      'INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      'INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      
        'INNER JOIN HeatIndividual ON HeatIndividual.EventID = Event.Even' +
        'tID'
      'INNER JOIN Entrant ON Entrant.HeatID = HeatIndividual.HeatID'
      'LEFT JOIN Member ON Entrant.MemberID = Member.MemberID'
      'INNER JOIN Session ON Event.SessionID = Session.SessionID'
      'INNER JOIN SwimClub ON Session.SwimClubID = SwimClub.SwimClubID'
      'WHERE HeatIndividual.HeatID = @HeatID'
      'ORDER BY Event.EventNum'
      #9',HeatIndividual.HeatNum'
      #9',Entrant.Lane')
    Left = 160
    Top = 272
    ParamData = <
      item
        Name = 'HEATID'
        DataType = ftInteger
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
