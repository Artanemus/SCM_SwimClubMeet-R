object MemberHistory: TMemberHistory
  OldCreateOrder = False
  Height = 570
  Width = 479
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
    ReportOptions.LastChange = 43785.427352372700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      '        '
      'end.')
    Left = 272
    Top = 80
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
      Columns = 2
      ColumnWidth = 94.000000000000000000
      ColumnPositions.Strings = (
        '0'
        '95')
      Frame.Color = clNone
      Frame.ShadowColor = clNone
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 60.472480000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object FDQuery1cSwimClub: TfrxMemoView
          AllowVectorExport = True
          Width = 718.110236220472000000
          Height = 30.236240000000000000
          AutoWidth = True
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'segoe UI'
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
          Width = 718.110236220472000000
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
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 275.905690000000000000
        Width = 355.275820000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        RowCount = 0
        object frxDSCaption: TfrxMemoView
          AllowVectorExport = True
          Top = 0.779529999999966000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."DistanceStr"]')
          ParentFont = False
        end
        object frxDSLongCaption: TfrxMemoView
          AllowVectorExport = True
          Left = 81.456710000000000000
          Top = 0.779530000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          StretchMode = smActualHeight
          DataField = 'StrokeStr'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."StrokeStr"]')
          ParentFont = False
        end
        object frxDSAgeFrom: TfrxMemoView
          AllowVectorExport = True
          Left = 210.165430000000000000
          Top = 0.779530000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          DataField = 'RaceTime'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."RaceTime"]')
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
        Height = 64.252010000000000000
        ParentFont = False
        Top = 139.842610000000000000
        Width = 355.275820000000000000
        Condition = 'frxDS."MemberID"'
        object frxDSFName: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 347.716760000000000000
          Height = 30.236240000000000000
          DataField = 'FName'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FName"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 34.881880000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Distance')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 77.677180000000000000
          Top = 34.881880000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Stroke')
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 3.559060000000000000
          Top = 58.795300000000000000
          Width = 351.495850630000000000
          Fill.BackColor = clBlack
          Frame.Typ = []
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 207.874150000000000000
          Top = 35.236240000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Race Time')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 14671839
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 226.771800000000000000
        Width = 355.275820000000000000
        Condition = 'frxDS."SessionStart"'
        object frxDSAgeTo: TfrxMemoView
          AllowVectorExport = True
          Left = 6.070810000000000000
          Top = 2.220470000000000000
          Width = 343.937230000000000000
          Height = 22.677180000000000000
          DataField = 'SessionStart'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."SessionStart"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 359.055350000000000000
        Width = 718.110700000000000000
        object TotalPages: TfrxMemoView
          AllowVectorExport = True
          Top = 1.102350000000000000
          Width = 642.519685039370000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
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
          Top = 2.992115000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed On: [Date]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime]
    FormatOptions.FmtDisplayDateTime = 'dd DDDD MMMM YYYY'
    FormatOptions.FmtDisplayDate = 'DDDD MMMM YYYY'
    FormatOptions.FmtDisplayTime = 'nn:ss:zzz'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @MemberID AS INT'
      'DECLARE @SwimClubID AS INT'
      ''
      'SET @MemberID = :MEMBERID'
      'SET @SwimClubID = :SWIMCLUBID'
      ''
      'SELECT Stroke.Caption AS StrokeStr'
      #9',Distance.Caption AS DistanceStr'
      #9',Entrant.RaceTime'
      #9',Member.FirstName + '#39' '#39' + UPPER(Member.LastName) AS FName'
      #9',Session.SessionStart'
      #9',Member.MemberID'
      #9',Member.MembershipNum'
      #9',SwimClub.Caption AS ClubName'
      #9',SwimClub.NickName AS ClubNickName'
      'FROM Member'
      'INNER JOIN Entrant ON Member.MemberID = Entrant.MemberID'
      
        'INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.Hea' +
        'tID'
      'INNER JOIN Event ON HeatIndividual.EventID = Event.EventID'
      'INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      'INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      'INNER JOIN Session ON Event.SessionID = Session.SessionID'
      'INNER JOIN SwimClub ON Member.SwimClubID = SwimClub.SwimClubID'
      
        'WHERE (Member.SwimClubID = @SwimClubID) AND (Member.MemberID = @' +
        'MemberID)'
      'ORDER BY SessionStart DESC, DistanceStr'#9',StrokeStr')
    Left = 88
    Top = 80
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 27
      end
      item
        Name = 'SWIMCLUBID'
        ParamType = ptInput
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
    Top = 272
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
    Top = 216
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
    Top = 160
  end
  object frxDSReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryReport
    BCDToCurrency = False
    Left = 160
    Top = 80
  end
end
