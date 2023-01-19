object MarshallReportB: TMarshallReportB
  OldCreateOrder = False
  Height = 450
  Width = 442
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
    OnPrintReport = frxReport1PrintReport
    Left = 272
    Top = 40
    Datasets = <
      item
        DataSet = frxSessionReport
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
      ColumnWidth = 95.000000000000000000
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
          Left = 510.236550000000000000
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
            
              'Session Date : [frxDS."SessionStart" #d DDD dd MMM YYYY HH:MM AM' +
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
        Height = 34.015770000000000000
        ParentFont = False
        Top = 124.724490000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."EventID"'
        KeepTogether = True
        object frxDScDistance: TfrxMemoView
          AllowVectorExport = True
          Left = 7.456710000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDS."cDistance"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDScEvent: TfrxMemoView
          AllowVectorExport = True
          Left = 238.110390000000000000
          Top = 3.779530000000000000
          Width = 434.645950000000000000
          Height = 18.897650000000000000
          DataField = 'cEvent'
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."cEvent"]')
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 86.929190000000000000
          Top = 3.779530000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ' [frxDS."cStroke"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 41.574830000000000000
        Top = 249.448980000000000000
        Width = 718.110700000000000000
        Columns = 2
        ColumnWidth = 351.496062992126000000
        ColumnGap = 7.559055118110240000
        DataSet = frxSessionReport
        DataSetName = 'frxDS'
        RowCount = 0
        object frxDSLane: TfrxMemoView
          AllowVectorExport = True
          Left = 150.842610000000000000
          Top = 10.779530000000000000
          Width = 26.456710000000000000
          Height = 18.897650000000000000
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."Lane" #n%2.0f]')
          ParentFont = False
        end
        object frxDSFNAME: TfrxMemoView
          AllowVectorExport = True
          Left = 175.637910000000000000
          Top = 10.779530000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            ' [frxDS."FNAME"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 0.779530000000000000
          Top = 2.000000000000000000
          Width = 147.401670000000000000
          Height = 37.795300000000000000
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 385.512060000000000000
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
          Top = 1.889765000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed On: [Date] [Time]')
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 45.354360000000000000
        Top = 181.417440000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."HeatNum"'
        KeepTogether = True
        object frxDSHeatCount: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 4.779530000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'HEAT: [frxDS."HeatNum" #n%2.0f]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 147.401670000000000000
          Top = 25.456710000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Lane')
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 181.417440000000000000
          Top = 25.456710000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Entrant')
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 4.338590000000000000
          Top = 25.456710000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'RaceTime')
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 505.897960000000000000
          Top = 26.456710000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Lane')
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 539.913730000000000000
          Top = 26.456710000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Entrant')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 362.834880000000000000
          Top = 26.456710000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'RaceTime')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 11.338590000000000000
        Top = 313.700990000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HeatNum'
    Connection = SCM.scmConnection
    UpdateOptions.KeyFields = 'HeatID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID as integer;'
      'SET @EventID = :EVENTID;'
      ''
      'SELECT'
      '  HeatIndividual.HeatID,'
      '  HeatIndividual.HeatNum,'
      '  Distance.Caption AS cDistance,'
      '  Stroke.Caption AS cStroke,'
      '  Event.EventNum,'
      '  Event.Caption AS cEvent,'
      '  Entrant.Lane,'
      
        '  Concat(Member.FirstName, '#39' '#39', Upper(Member.LastName)) AS FNAME' +
        ','
      '  SwimClub.NickName,'
      '  SwimClub.Caption AS cSwimClub,'
      '  Session.SessionStart,'
      '  Event.SessionID,'
      '  HeatIndividual.EventID'
      'FROM'
      '  HeatIndividual'
      '  INNER JOIN Event ON HeatIndividual.EventID = Event.EventID'
      '  INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      '  INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      '  INNER JOIN Entrant ON Entrant.HeatID = HeatIndividual.HeatID'
      '  LEFT JOIN Member ON Entrant.MemberID = Member.MemberID'
      '  INNER JOIN Session ON Event.SessionID = Session.SessionID'
      
        '  INNER JOIN SwimClub ON Session.SwimClubID = SwimClub.SwimClubI' +
        'D'
      'WHERE'
      '  HeatIndividual.EventID = @EventID'
      'ORDER BY'
      '  HeatIndividual.HeatNum,'
      '  Entrant.Lane')
    Left = 136
    Top = 280
    ParamData = <
      item
        Name = 'EVENTID'
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
  object frxSessionReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryReport
    BCDToCurrency = False
    Left = 264
    Top = 280
  end
end
