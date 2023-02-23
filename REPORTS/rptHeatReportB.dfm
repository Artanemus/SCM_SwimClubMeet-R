object HeatReportB: THeatReportB
  OnCreate = DataModuleCreate
  Height = 363
  Width = 284
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
    ReportOptions.LastChange = 43434.512179675900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
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
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object FDQuery1cSwimClub: TfrxMemoView
          AllowVectorExport = True
          Width = 400.630180000000000000
          Height = 30.236240000000000000
          AutoWidth = True
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."cSwimClub"]')
          ParentFont = False
        end
        object FDQuery1NickName: TfrxMemoView
          AllowVectorExport = True
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSetName = 'FDQuery1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."NickName"]')
        end
        object FDQuery1SessionStart: TfrxMemoView
          AllowVectorExport = True
          Left = 506.457020000000000000
          Top = 22.677180000000000000
          Width = 204.094620000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              'Session Date : [frxDS."SessionStart" #dddd mmm dd yyyy HH:MM AM/' +
              'PM]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 15461355
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 41.574830000000000000
        ParentFont = False
        Top = 124.724490000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."SessionID"'
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 3.000000000000000000
          Width = 476.220780000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            
              'Event:[frxDS."EventNum" #n%3.0f] - [frxDS."cDistance"] [frxDS."c' +
              'Stroke"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object frxDScEvent: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 21.897650000000000000
          Width = 400.630180000000000000
          Height = 15.118120000000000000
          DataField = 'cEvent'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."cEvent"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 73.811070000000000000
        Top = 188.976500000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."HeatNum"'
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Top = 10.338590000000000000
          Width = 718.110700000000000000
          Height = 52.913420000000000000
          Fill.BackColor = cl3DLight
          Frame.Color = clNone
          Frame.ShadowColor = clNone
          Frame.Typ = [ftBottom]
          Frame.TopLine.Style = fsDot
          Frame.BottomLine.Style = fsDash
          Frame.BottomLine.Width = 10.000000000000000000
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 37.795300000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Lane')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 49.133890000000000000
          Top = 37.795300000000000000
          Width = 230.551330000000000000
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
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 279.685220000000000000
          Top = 37.795300000000000000
          Width = 34.015770000000000000
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
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 313.700990000000000000
          Top = 37.795300000000000000
          Width = 45.354360000000000000
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
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Top = 15.118120000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Heat#')
          ParentFont = False
        end
        object frxDSHeatNum1: TfrxMemoView
          AllowVectorExport = True
          Left = 49.133890000000000000
          Top = 15.118120000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."HeatNum" #n%2.0f]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 585.827150000000000000
          Top = 6.559060000000000000
          Width = 75.590600000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Disqualified')
          ParentFont = False
          Rotation = 33
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 619.842920000000000000
          Top = 6.559060000000000000
          Width = 75.590600000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Scratched')
          ParentFont = False
          Rotation = 33
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 510.236550000000000000
          Top = 8.559060000000000000
          Width = 75.590600000000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Personal Best')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 434.645950000000000000
          Top = 8.000000000000000000
          Width = 75.590600000000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Time to Beat')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 359.055350000000000000
          Top = 8.000000000000000000
          Width = 75.590600000000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Race'
            'Time')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 287.244280000000000000
        Width = 718.110700000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        RowCount = 0
        object FDQuery1FNAME: TfrxMemoView
          AllowVectorExport = True
          Left = 49.133890000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FNAME"]')
          ParentFont = False
        end
        object FDQuery1Lane: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."Lane"]')
          ParentFont = False
        end
        object FDQuery1Time: TfrxMemoView
          AllowVectorExport = True
          Left = 359.055350000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."RaceTime"]')
          ParentFont = False
        end
        object frxDSAGE: TfrxMemoView
          AllowVectorExport = True
          Left = 313.700990000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          DataField = 'AGE'
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
            '[frxDS."AGE"]')
          ParentFont = False
        end
        object frxDSGENDER: TfrxMemoView
          AllowVectorExport = True
          Left = 279.685220000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataField = 'GENDER'
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
            '[frxDS."GENDER"]')
          ParentFont = False
        end
        object frxDSTimeToBet: TfrxMemoView
          AllowVectorExport = True
          Left = 434.645950000000000000
          Width = 75.590600000000000000
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
            '[frxDS."TimeToBeat"]')
          ParentFont = False
        end
        object frxDSPersonalBest: TfrxMemoView
          AllowVectorExport = True
          Left = 510.236550000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'PersonalBest'
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
        end
        object frxDSIsDisqualified: TfrxMemoView
          AllowVectorExport = True
          Left = 585.827150000000000000
          Width = 41.574830000000000000
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
            '[IIF(<frxDS."IsDisqualified">, '#39'X'#39', '#39' '#39' )]')
          ParentFont = False
        end
        object frxDSIsScratched: TfrxMemoView
          AllowVectorExport = True
          Left = 627.401980000000000000
          Width = 41.574830000000000000
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
            '[IIF(<frxDS."IsScratched">, '#39'X'#39', '#39' '#39')]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 408.189240000000000000
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
          Top = 1.889765000000010000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed On: [Date]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 328.819110000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SessionID'
    Connection = SCM.scmConnection
    SQL.Strings = (
      'SELECT'
      '  Event.EventNum,'
      '  Event.Caption AS cEvent,'
      '  Distance.Caption AS cDistance,'
      '  Stroke.Caption AS cStroke,'
      '  HeatIndividual.HeatNum,'
      '  HeatStatus.Caption AS cStatus,'
      '  Entrant.Lane,'
      
        '  Concat(Member.FirstName, '#39' '#39', Upper(Member.LastName)) AS FNAME' +
        ','
      '  Session.SessionStart,'
      '  SwimClub.NickName,'
      '  SwimClub.Caption AS cSwimClub,'
      '  Event.SessionID,'
      'dbo.SwimmerAge(Session.SessionStart, Member.DOB) AS AGE,'
      'dbo.SwimmerGenderToString(Member.MemberID) AS GENDER,'
      'dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTime,'
      'dbo.SwimTimeToString(Entrant.TimeToBeat) AS TimeToBeat,'
      'dbo.SwimTimeToString(Entrant.PersonalBest) AS PersonalBest,'
      
        '--  Format(CAST(Entrant.RaceTime AS DATETIME), '#39'mm:ss.fff'#39') AS R' +
        'aceTime,'
      
        '--  Format(CAST(Entrant.TimeToBeat AS DATETIME), '#39'mm:ss.fff'#39') AS' +
        ' TimeToBeat,'
      
        '--  Format(CAST(Entrant.PersonalBest AS DATETIME), '#39'mm:ss.fff'#39') ' +
        'AS PersonalBest,'
      '  Entrant.IsDisqualified,'
      '  Entrant.IsScratched'
      ''
      ''
      ''
      'FROM'
      '  HeatIndividual'
      
        '  INNER JOIN HeatStatus ON HeatIndividual.HeatStatusID = HeatSta' +
        'tus.HeatStatusID'
      '  INNER JOIN Event ON HeatIndividual.EventID = Event.EventID'
      '  INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      '  INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      '  LEFT JOIN Entrant ON Entrant.HeatID = HeatIndividual.HeatID'
      '  INNER JOIN Member ON Entrant.MemberID = Member.MemberID'
      '  INNER JOIN Session ON Event.SessionID = Session.SessionID'
      
        '  INNER JOIN SwimClub ON Session.SwimClubID = SwimClub.SwimClubI' +
        'D'
      'WHERE'
      '  HeatIndividual.EventID = :EVENTID'
      'ORDER BY'
      '  HeatIndividual.HeatNum,'
      '  Entrant.Lane')
    Left = 160
    Top = 272
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 135
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
