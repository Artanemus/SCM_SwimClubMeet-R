object MemberCheckData: TMemberCheckData
  Height = 480
  Width = 640
  object qryDataCheck: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ';'
      ''
      'DECLARE @SwimClubID AS Integer;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'SELECT [MemberID]'
      '      ,'#39'No firstname.'#39' as MSG'
      '  FROM [dbo].[Member]'
      'WHERE firstname IS NULL AND [SwimClubID] = @SwimCLubID'
      ''
      'UNION'
      ''
      'SELECT [MemberID]'
      '      ,'#39'No lastname.'#39' as MSG'
      '  FROM [dbo].[Member]'
      'WHERE lastname IS NULL  AND [SwimClubID] = @SwimCLubID'
      ''
      'UNION'
      ''
      'SELECT [MemberID]'
      '    ,'#39'Gender not given.'#39' as MSG'
      'FROM [dbo].[Member]'
      'WHERE GenderID IS NULL  AND [SwimClubID] = @SwimCLubID'
      ''
      'UNION'
      ''
      'SELECT [MemberID]'
      '      ,'#39'Swimming Club not assigned.'#39' as MSG'
      '  FROM [dbo].[Member]'
      'WHERE SwimClubID IS NULL '
      ''
      'SELECT [MemberID]'
      '      ,'#39'No date of birth.'#39' as MSG'
      '  FROM [dbo].[Member]'
      'WHERE DOB is null  AND [SwimClubID] = @SwimCLubID'
      ''
      'UNION'
      ''
      'SELECT [MemberID]'
      '      ,'#39'Archived or Active or Swimmer unknown.'#39' as MSG'
      '  FROM [dbo].[Member]'
      
        'WHERE IsArchived IS NULL OR IsActive IS NULL OR IsSwimmer IS NUL' +
        'L'
      ' AND [SwimClubID] = @SwimCLubID'
      ''
      'UNION'
      ''
      'SELECT [MemberID]'
      '      ,'#39'No membership number.'#39' as MSG'
      '  FROM [dbo].[Member]'
      'WHERE MembershipNum IS NULL  AND [SwimClubID] = @SwimCLubID'
      ''
      'ORDER BY MemberID DESC;'
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 96
    Top = 88
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object frxDBDataCheck: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryDataCheck
    BCDToCurrency = False
    Left = 216
    Top = 88
  end
  object frxReport1: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45451.646931747700000000
    ReportOptions.LastChange = 45454.454082048600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 360
    Top = 88
    Datasets = <
      item
        DataSet = frxDBDataCheck
        DataSetName = 'frxDS'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 4
      ColumnWidth = 48.975000000000000000
      ColumnPositions.Strings = (
        '0'
        '48.975'
        '97.95'
        '146.925')
      Frame.Typ = []
      MirrorMode = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 185.102481750000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 4.000000000000000000
          Top = 1.102350000000000000
          Width = 149.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Member'#39's Data - Check.')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 16.677180000000000000
        Top = 64.252010000000000000
        Width = 185.102481750000000000
        DataSet = frxDBDataCheck
        DataSetName = 'frxDS'
        RowCount = 0
        object frxDBDataset1MemberID: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 1.000000000000000000
          Top = 1.747990000000000000
          Width = 31.370130000000000000
          Height = 14.397650000000000000
          DataField = 'MemberID'
          DataSet = frxDBDataCheck
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."MemberID"]')
          ParentFont = False
        end
        object frxDSMSG: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 34.500000000000000000
          Top = 1.747990000000000000
          Width = 215.433210000000000000
          Height = 14.397650000000000000
          DataField = 'MSG'
          DataSet = frxDBDataCheck
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."MSG"]')
          ParentFont = False
        end
      end
    end
  end
  object frxCSVExport1: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ','
    OEMCodepage = False
    UTF8 = False
    OpenAfterExport = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 216
    Top = 168
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
    Left = 96
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
    Left = 360
    Top = 168
  end
end
