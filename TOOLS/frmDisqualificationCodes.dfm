object DisqualificationCodes: TDisqualificationCodes
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FINA Disqualification Codes'
  ClientHeight = 891
  ClientWidth = 838
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'DisqualificationCodes'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 18
  object frxPreview1: TfrxPreview
    Left = 0
    Top = 0
    Width = 838
    Height = 829
    Align = alClient
    ActiveFrameColor = clNone
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    OutlineVisible = False
    OutlineWidth = 120
    ThumbnailVisible = False
    FindFmVisible = False
    UseReportHints = True
    HideScrolls = False
    ExplicitWidth = 842
    ExplicitHeight = 830
  end
  object Panel1: TPanel
    Left = 0
    Top = 829
    Width = 838
    Height = 62
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      838
      62)
    object btnPrintPDF: TButton
      Left = 627
      Top = 16
      Width = 80
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Print PDF'
      TabOrder = 0
      OnClick = btnPrintPDFClick
      ExplicitLeft = 631
    end
    object btnClose: TButton
      Left = 713
      Top = 16
      Width = 80
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Close'
      Default = True
      TabOrder = 1
      OnClick = btnCloseClick
      ExplicitLeft = 717
    end
  end
  object frxReport1: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    Preview = frxPreview1
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45061.461690324100000000
    ReportOptions.LastChange = 45061.461690324100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 200
    Top = 248
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDS'
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
      Columns = 2
      ColumnWidth = 95.000000000000000000
      ColumnPositions.Strings = (
        '0'
        '95')
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Height = 38.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Gradient2: TfrxGradientView
          AllowVectorExport = True
          Left = 2.666666670000000000
          Top = 1.769016670000000000
          Width = 693.154916670000000000
          Height = 36.230983330000000000
          BeginColor = clSkyBlue
          EndColor = clWhite
          Style = gsHorizontal
          Frame.Typ = []
          Color = 16245970
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 8.000000000000000000
          Top = 7.102350000000000000
          Width = 365.821583330000000000
          Height = 24.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'FINA Swimming Disqualification Codes')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 38.677180000000000000
        Top = 117.165430000000000000
        Width = 359.055350000000000000
        Condition = 'frxDBDS."DisqualifyTypeID"'
        KeepTogether = True
        object Gradient1: TfrxGradientView
          AllowVectorExport = True
          Left = 3.333333340000000000
          Top = 10.834570010000000000
          Width = 351.154916670000000000
          Height = 28.897650000000000000
          BeginColor = clMoneyGreen
          EndColor = clWhite
          Style = gsHorizontal
          Frame.Typ = []
          Color = 14675423
        end
        object frxDBDSTypeStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 6.666666670000000000
          Top = 16.619356670000000000
          Width = 342.630180000000000000
          Height = 18.897650000000000000
          DataField = 'TypeStr'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDS."TypeStr"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 43.495980010000000000
        Top = 177.637910000000000000
        Width = 359.055350000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDS'
        KeepTogether = True
        RowCount = 0
        Stretched = True
        object frxDBDSABREV: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 5.333333330000000000
          Top = 3.264996670000000000
          Width = 48.504020000000000000
          Height = 20.230983330000000000
          CanShrink = True
          StretchMode = smActualHeight
          AutoWidth = True
          DataField = 'ABREV'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDS."ABREV"]')
          WordBreak = True
        end
        object frxDBDSCodeStr1: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 55.333333330000000000
          Top = 3.264996670000000000
          Width = 299.296846670000000000
          Height = 38.230983340000000000
          CanShrink = True
          Clipped = False
          DataField = 'CodeStr'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDS'
          Frame.Typ = []
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            '[frxDBDS."CodeStr"]')
          WordBreak = True
        end
      end
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDS'
    CloseDataSource = False
    DataSet = qryDisqualifyCode
    BCDToCurrency = False
    Left = 264
    Top = 328
  end
  object qryDisqualifyCode: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'DisqualifyCodeID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'SELECT DisqualifyCodeID'
      ', DisqualifyCode.DisqualifyTypeID'
      ', DisqualifyCode.Caption AS CodeStr'
      ',DisqualifyCode.ABREV'
      ',DisqualifyType.Caption AS TypeStr'
      ' FROM dbo.DisqualifyCode'
      
        'LEFT JOIN dbo.DisqualifyType ON DisqualifyCode.DisqualifyTypeID ' +
        '= DisqualifyType.DisqualifyTypeID'
      'ORDER BY DisqualifyCode.DisqualifyTypeID'
      ';')
    Left = 144
    Top = 328
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
    Left = 400
    Top = 256
  end
end
