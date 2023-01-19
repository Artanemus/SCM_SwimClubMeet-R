object EventReportB: TEventReportB
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 365
  Width = 279
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
    ReportOptions.LastChange = 43501.725641678200000000
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
      EndlessWidth = True
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 68.031540000000000000
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
        object frxDSSessionStart: TfrxMemoView
          AllowVectorExport = True
          Left = 404.409710000000000000
          Top = 22.677180000000000000
          Width = 306.141930000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              'Session Date: [<frxDS."SessionStart"> #dddd dd mmm yyyy HH:MM AM' +
              '/PM]')
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
        Height = 30.236240000000000000
        ParentFont = False
        Top = 147.401670000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."SessionID"'
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 8.456710000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Event #')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 60.472480000000000000
          Top = 8.456710000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Distance')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 133.842610000000000000
          Top = 8.456710000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Stroke')
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 506.457020000000000000
          Top = 8.456710000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Nominees')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 574.488560000000000000
          Top = 8.456710000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Entrants')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 642.520100000000000000
          Top = 8.456710000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Heats')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 238.110390000000000000
          Top = 8.456710000000000000
          Width = 245.669450000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Event Description')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 49.133890000000000000
        Top = 200.315090000000000000
        Width = 718.110700000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        RowCount = 0
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Top = 2.000000000000000000
          Width = 52.913420000000000000
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
            '[<frxDS."EventNum"> #n%3.0g]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 68.031540000000000000
          Top = 2.000000000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'cDistance'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDS."cDistance"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 133.842610000000000000
          Top = 2.000000000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          DataField = 'cStroke'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."cStroke"]')
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 506.457020000000000000
          Top = 2.000000000000000000
          Width = 60.472426300000000000
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
            
              '[IIF(<frxDS."NomineeCount"> = 0 ,0,<frxDS."NomineeCount">) #n%3.' +
              '0g]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 574.488560000000000000
          Top = 2.000000000000000000
          Width = 60.472426300000000000
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
            
              '[IIF(<frxDS."EntrantCount"> = 0 ,0,<frxDS."EntrantCount">) #n%3.' +
              '0g]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 642.520100000000000000
          Top = 2.000000000000000000
          Width = 60.472426300000000000
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
            '[frxDS."HeatCount" #n%3.0g]')
          ParentFont = False
        end
        object frxDScEvent: TfrxMemoView
          AllowVectorExport = True
          Left = 238.110390000000000000
          Top = 2.000000000000000000
          Width = 245.669450000000000000
          Height = 18.897650000000000000
          DataField = 'cEvent'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."cEvent"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 483.779840000000000000
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
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 359.055350000000000000
        Width = 718.110700000000000000
        Columns = 3
        ColumnWidth = 238.110236220472000000
        ColumnGap = 3.779527559055120000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        RowCount = 0
        object frxDSNominee: TfrxMemoView
          AllowVectorExport = True
          Left = 29.472480000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FNAME"]')
          Formats = <
            item
            end
            item
            end>
        end
        object frxDSRaceTime: TfrxMemoView
          AllowVectorExport = True
          Left = 167.299320000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."RaceTime"]')
        end
        object frxDSLane: TfrxMemoView
          AllowVectorExport = True
          Left = 2.779530000000000000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."Lane" #n%2.0f]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 64.252010000000000000
        Top = 272.126160000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."HeatNum"'
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Top = 11.338590000000000000
          Width = 718.110700000000000000
          Height = 30.236240000000000000
          Fill.BackColor = cl3DLight
          Frame.Color = clNone
          Frame.Typ = []
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'HEAT : [frxDS."HeatNum"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 1.779530000000000000
          Top = 37.795300000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 166.039476670000000000
          Top = 42.614203330000000000
          Width = 69.291383330000000000
          Height = 13.858276670000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RaceTime')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Left = 29.472480000000000000
          Top = 42.354360000000000000
          Width = 133.543393330000000000
          Height = 13.858276670000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Entrant')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 0.740156670000000000
          Top = 42.354360000000000000
          Width = 27.716553330000000000
          Height = 13.858276670000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Lane')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 407.189240000000000000
          Top = 41.834673330000000000
          Width = 69.291383330000000000
          Height = 13.858276670000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RaceTime')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          AllowVectorExport = True
          Left = 270.622243330000000000
          Top = 41.574830000000000000
          Width = 133.543393330000000000
          Height = 13.858276670000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Entrant')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 241.889920000000000000
          Top = 41.574830000000000000
          Width = 27.716553330000000000
          Height = 13.858276670000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Lane')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 649.079160000000000000
          Top = 41.834673330000000000
          Width = 69.291383330000000000
          Height = 13.858276670000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RaceTime')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          AllowVectorExport = True
          Left = 512.512163330000000000
          Top = 41.574830000000000000
          Width = 133.543393330000000000
          Height = 13.858276670000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Entrant')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          AllowVectorExport = True
          Left = 483.779840000000000000
          Top = 41.574830000000000000
          Width = 27.716553330000000000
          Height = 13.858276670000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Lane')
          ParentFont = False
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = 482.000310000000000000
          Top = 37.015770000000000000
          Height = 71.811070000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
          Frame.Width = 2.000000000000000000
        end
        object Line3: TfrxLineView
          AllowVectorExport = True
          Left = 240.110390000000000000
          Top = 37.795300000000000000
          Height = 71.811070000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
          Frame.Width = 2.000000000000000000
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 404.409710000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexesActive = False
    IndexFieldNames = 'EventID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayTime]
    FormatOptions.FmtDisplayDateTime = 'dd mmm YYYY'
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID AS INT;'
      ''
      'SET @EventID = :EVENTID;'
      ''
      ''
      'SELECT Event.EventID'
      '        ,dbo.EntrantCount(Event.EventID) AS EntrantCount'
      #9',dbo.NomineeCount(Event.EventID) AS NomineeCount'
      #9',qryHeatCount.HeatCount'
      #9',SUBSTRING(CONCAT ('
      #9#9'Upper(Member.LastName)'
      #9#9','#39', '#39
      #9#9',Member.FirstName'
      #9#9'),0,30) AS FName'
      #9',Member.MemberID'
      #9',Session.SessionStart'
      #9',Event.EventNum'
      #9',Event.SessionID'
      ',Entrant.HeatID'
      ',dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTime'
      #9',SUBSTRING(Distance.Caption, 0, 8) AS cDistance'
      #9',SUBSTRING(Stroke.Caption, 0, 12) AS cStroke'
      #9',HeatIndividual.HeatNum'
      #9',Entrant.Lane'
      #9',SwimClub.NickName'
      #9',SwimClub.Caption AS cSwimClub'
      #9',Event.Caption AS cEvent'
      'FROM Event'
      
        'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.Even' +
        'tID'
      'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      'INNER JOIN Member ON Entrant.MemberID = Member.MemberID'
      'INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      'INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      'INNER JOIN Session ON Session.SessionID = Event.SessionID'
      'INNER JOIN SwimClub ON Session.SwimClubID = SwimClub.SwimClubID'
      'LEFT JOIN ('
      #9'SELECT EventID'
      #9#9',Count(HeatID) AS HeatCount'
      #9'FROM HeatIndividual'
      #9'GROUP BY EventID'
      #9') AS qryHeatCount ON qryHeatCount.EventID = Event.EventID'
      'WHERE Event.EventID = @EventID'
      'ORDER BY  HeatNum, Lane;')
    Left = 160
    Top = 272
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 20
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
