object MembersDetail: TMembersDetail
  Height = 547
  Width = 422
  object frxReport1: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43429.469572048600000000
    ReportOptions.LastChange = 43660.498981192100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 264
    Top = 296
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
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Fill.BackColor = 14479868
        Frame.Typ = []
        Height = 79.370130000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object frxDSNickName: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 21.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'NickName'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."NickName"]')
          ParentFont = False
        end
        object frxDScSwimClub: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'cSwimClub'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."cSwimClub"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 5.559060000000000000
          Top = 75.590600000000000000
          Width = 1039.370750000000000000
          StretchMode = smMaxHeight
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 4.000000000000000000
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 573.158010000000000000
          Top = 37.795300000000000000
          Width = 86.929190000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Membership'
            'Number')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 60.252010000000000000
          Top = 52.913420000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Member'#39's Name')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 291.023810000000000000
          Top = 52.913420000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'DOB')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 389.291590000000000000
          Top = 52.913420000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Age')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 502.677490000000000000
          Top = 52.913420000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Gender')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 449.764070000000000000
          Top = 52.913420000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Active')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 52.913420000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'ID')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 22.677180000000000000
          Width = 1024.252630000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Member'#39's age as of today.')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 241.889920000000000000
        Width = 1046.929810000000000000
        object Page: TfrxMemoView
          AllowVectorExport = True
          Left = 279.685220000000000000
          Top = 1.889765000000010000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            '[Page#] of [TotalPages#]')
        end
        object Date: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 3.779530000000020000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 158.740260000000000000
        Width = 1046.929810000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object frxDSMembershipNum: TfrxMemoView
          AllowVectorExport = True
          Left = 573.158010000000000000
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
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDS."MembershipNum"]')
          ParentFont = False
        end
        object frxDSFName: TfrxMemoView
          AllowVectorExport = True
          Left = 60.252010000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."ucFName"]')
        end
        object frxDSdtDOB: TfrxMemoView
          AllowVectorExport = True
          Left = 291.023810000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."DOB"]')
        end
        object frxDSAge: TfrxMemoView
          AllowVectorExport = True
          Left = 389.291590000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'Age'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."Age"]')
        end
        object frxDScGender: TfrxMemoView
          AllowVectorExport = True
          Left = 502.677490000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          DataField = 'cGender'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."cGender"]')
        end
        object frxDSMemberID: TfrxMemoView
          AllowVectorExport = True
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          DisplayFormat.FormatStr = '%4.4d'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."MemberID"]')
        end
        object CheckBox1: TfrxCheckBoxView
          AllowVectorExport = True
          Left = 460.500000000000000000
          Top = 0.759740000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          CheckColor = clBlack
          CheckStyle = csCheck
          DataField = 'IsActive'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
        end
      end
    end
  end
  object frxDSReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    FieldAliases.Strings = (
      'MemberID=MemberID'
      'FirstName=FirstName'
      'LastName=LastName'
      'MembershipNum=MembershipNum'
      'ucFName=ucFName'
      'DOB=DOB'
      'IsActive=IsActive'
      'Email=Email'
      'cGender=cGender'
      'GenderID=GenderID'
      'SwimClubID=SwimClubID'
      'cSwimClub=cSwimClub'
      'NickName=NickName'
      'Age=Age')
    DataSet = qryReport
    BCDToCurrency = False
    Left = 160
    Top = 296
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
    Left = 120
    Top = 136
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
    Left = 120
    Top = 72
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
    Left = 232
    Top = 80
  end
  object frxMailExport1: TfrxMailExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    CreationTime = 43430.596493773150000000
    DataOnly = False
    ShowExportDialog = True
    SmtpPort = 25
    UseIniFile = True
    TimeOut = 60
    ConfurmReading = False
    UseMAPI = SMTP
    MAPISendFlag = 0
    Left = 232
    Top = 136
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @SwimClubID as INT'
      'SET @SwimClubID = :SWIMCLUBID'
      ''
      'SELECT        Member.MemberID'
      ', Member.FirstName'
      ', Member.LastName'
      ', Member.MembershipNum'
      
        ', CONCAT(UPPER(Member.LastName), '#39', '#39', Member.FirstName)  AS ucF' +
        'Name'
      ', Member.DOB'
      ', Member.IsActive'
      ', Member.Email'
      '-- , Member.DoEmailSessionReport'
      ', Gender.Caption AS cGender'
      ', Member.GenderID'
      ', Member.SwimClubID'
      ', SwimClub.Caption AS cSwimClub'
      ', SwimClub.NickName'
      ', dbo.SwimmerAge(GETDATE(), Member.DOB) AS Age'
      ''
      'FROM            Member '
      
        'LEFT OUTER JOIN SwimClub ON Member.SwimClubID = SwimClub.SwimClu' +
        'bID '
      'LEFT OUTER JOIN Gender ON Member.GenderID = Gender.GenderID '
      'WHERE        (Member.SwimClubID = @SwimClubID )'
      'ORDER BY Member.LastName')
    Left = 64
    Top = 296
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
end
