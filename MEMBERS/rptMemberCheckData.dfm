object DataModule1: TDataModule1
  Height = 480
  Width = 640
  object qryDataCheck: TFDQuery
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ';'
      ''
      'SELECT [MemberID]'
      '      ,'#39'No firstname.'#39' as MSG'
      '  FROM [dbo].[Member]'
      'WHERE firstname IS NULL'
      ''
      'UNION'
      ''
      'SELECT [MemberID]'
      '      ,'#39'No lastname.'#39' as MSG'
      '  FROM [dbo].[Member]'
      'WHERE lastname IS NULL'
      ''
      'UNION'
      ''
      'SELECT [MemberID]'
      '    ,'#39'Gender not given.'#39' as MSG'
      'FROM [dbo].[Member]'
      'WHERE GenderID IS NULL'
      ''
      'UNION'
      ''
      'SELECT [MemberID]'
      '      ,'#39'Swimming Club not assigned.'#39' as MSG'
      '  FROM [dbo].[Member]'
      'WHERE SwimClubID IS NULL'
      ''
      'SELECT [MemberID]'
      '      ,'#39'No date of birth.'#39' as MSG'
      '  FROM [dbo].[Member]'
      'WHERE DOB is null'
      ''
      'UNION'
      ''
      'SELECT [MemberID]'
      '      ,'#39'Archived or Active or Swimmer unknown.'#39' as MSG'
      '  FROM [dbo].[Member]'
      
        'WHERE IsArchived IS NULL OR IsActive IS NULL OR IsSwimmer IS NUL' +
        'L'
      ''
      'UNION'
      ''
      'SELECT [MemberID]'
      '      ,'#39'No membership number.'#39' as MSG'
      '  FROM [dbo].[Member]'
      'WHERE MembershipNum IS NULL'
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
  end
  object frxDBDataCheck: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = qryDataCheck
    BCDToCurrency = False
    Left = 216
    Top = 88
  end
  object frxReport1: TfrxReport
    Version = '6.6.11'
    DataSet = frxDBDataCheck
    DataSetName = 'frxDBDataset1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45451.646931747690000000
    ReportOptions.LastChange = 45451.646931747690000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 360
    Top = 88
    Datasets = <>
    Variables = <>
    Style = <>
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
