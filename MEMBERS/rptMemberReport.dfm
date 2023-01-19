object MemberReport: TMemberReport
  OldCreateOrder = False
  Height = 533
  Width = 570
  object frxReport1: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43429.469572048600000000
    ReportOptions.LastChange = 43660.481920925900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 408
    Top = 80
    Datasets = <
      item
        DataSet = frxDBContacts
        DataSetName = 'frxDBContacts'
      end
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
      ColumnWidth = 63.333333333333300000
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Fill.BackColor = 14479868
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'segoe UI'
        Font.Style = []
        Height = 56.692950000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object frxDSNickName: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."ClubNickName"]')
        end
        object frxDScSwimClub: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 400.630180000000000000
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
            '[frxDS."ClubName"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 1.779530000000000000
          Top = 55.590600000000000000
          Width = 714.331170000000000000
          StretchMode = smMaxHeight
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 4.000000000000000000
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 35.015770000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Member'#39's age is calcuated as of '#39'today'#39'.')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 521.575140000000000000
        Width = 718.110700000000000000
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
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed on: [Date] [Time]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Height = 188.976500000000000000
        ParentFont = False
        Top = 181.417440000000000000
        Width = 718.110700000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        RowCount = 0
        object frxDSDOB: TfrxMemoView
          AllowVectorExport = True
          Left = 154.960730000000000000
          Top = 7.559060000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'DOB'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."DOB"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 75.590600000000000000
          Top = 7.559060000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'DOB')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 15.118120000000000000
          Top = 28.976396670000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Is active member')
          ParentFont = False
        end
        object CheckBox1: TfrxCheckBoxView
          AllowVectorExport = True
          Left = 154.960730000000000000
          Top = 28.236240000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          CheckColor = clBlack
          CheckStyle = csCheck
          DataField = 'IsActive'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
        end
        object frxDSGenderStr: TfrxMemoView
          AllowVectorExport = True
          Left = 154.960730000000000000
          Top = 50.913420000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataField = 'GenderStr'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."GenderStr"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 50.393733330000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Gender')
          ParentFont = False
        end
        object frxDScMembershipTypeStr: TfrxMemoView
          AllowVectorExport = True
          Left = 154.960730000000000000
          Top = 71.811070000000000000
          Width = 400.630180000000000000
          Height = 22.677180000000000000
          DataField = 'cMembershipTypeStr'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."cMembershipTypeStr"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Membership type')
          ParentFont = False
        end
        object frxDSMembershipNum: TfrxMemoView
          AllowVectorExport = True
          Left = 154.960730000000000000
          Top = 96.267780000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          DataField = 'MembershipNum'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."MembershipNum"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 41.574830000000000000
          Top = 96.267780000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Membership #')
          ParentFont = False
        end
        object frxDSEmail: TfrxMemoView
          AllowVectorExport = True
          Left = 154.960730000000000000
          Top = 117.944960000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'Email'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."Email"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 117.165430000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Email')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 139.842610000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Date joined')
          ParentFont = False
        end
        object frxDSMembershipDue: TfrxMemoView
          AllowVectorExport = True
          Left = 155.181200000000000000
          Top = 161.299320000000000000
          Width = 272.126160000000000000
          Height = 18.897650000000000000
          DataField = 'MembershipDue'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."MembershipDue"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 15.118120000000000000
          Top = 161.299320000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Membership due')
          ParentFont = False
        end
        object frxDSAGE: TfrxMemoView
          AllowVectorExport = True
          Left = 245.669450000000000000
          Top = 7.559060000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'AGE: [frxDS."AGE"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 15329769
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 136.063080000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."MemberID"'
        KeepTogether = True
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 71.811070000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'FName'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FName"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Top = 2.000000000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          DisplayFormat.FormatStr = '0000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDS."MemberID"]')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 438.425480000000000000
        Width = 718.110700000000000000
        DataSet = frxDBContacts
        DataSetName = 'frxDBContacts'
        Filter = '<frxDS."MemberID"> = <frxDBContacts."MemberID">'
        RowCount = 0
        object frxDBContactsNumber: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          DataField = 'Number'
          DataSet = frxDBContacts
          DataSetName = 'frxDBContacts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBContacts."Number"]')
          ParentFont = False
        end
        object frxDBContactsCaption: TfrxMemoView
          AllowVectorExport = True
          Left = 241.889920000000000000
          Width = 309.921460000000000000
          Height = 18.897650000000000000
          DataField = 'Caption'
          DataSet = frxDBContacts
          DataSetName = 'frxDBContacts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBContacts."Caption"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 393.071120000000000000
        Width = 718.110700000000000000
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 18.897650000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Contact numbers ...')
          ParentFont = False
        end
      end
    end
  end
  object frxDSReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryReport
    BCDToCurrency = False
    Left = 200
    Top = 312
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
    Left = 192
    Top = 144
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
    Left = 192
    Top = 80
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
    Left = 264
    Top = 80
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    Connection = FDConnection1
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @MemberID AS INT'
      'DECLARE @SwimClubID AS INT'
      ''
      'SET @MemberID = :MEMBERID'
      'SET @SwimClubID = :SWIMCLUBID'
      ''
      'IF (@MemberID IS NULL) OR (@MemberID = 0)'
      #9'SELECT Member.MemberID'
      #9#9',Member.MembershipNum'
      #9#9',Member.FirstName'
      #9#9',Member.LastName'
      #9#9',CONCAT ('
      #9#9#9'UPPER(Member.LastName)'
      #9#9#9','#39', '#39
      #9#9#9',Member.FirstName'
      #9#9#9') AS FName'
      #9#9',Member.DOB'
      #9#9',Member.IsActive'
      #9#9',Member.MembershipDue'
      #9#9',Member.Email'
      #9#9'-- , Member.DoEmailSessionReport'
      #9#9',Gender.Caption AS GenderStr'
      #9#9',Member.GenderID'
      #9#9',Member.SwimClubID'
      #9#9',Member.MembershipTypeID'
      #9#9',MembershipType.Caption AS cMembershipTypeStr'
      #9#9',SwimClub.Caption AS ClubName'
      #9#9',SwimClub.NickName AS ClubNickName'
      #9#9',dbo.SwimmerAge(GETDATE(), Member.DOB) AS AGE'
      #9'FROM Member'
      
        #9'LEFT OUTER JOIN SwimClub ON Member.SwimClubID = SwimClub.SwimCl' +
        'ubID'
      #9'LEFT OUTER JOIN Gender ON Member.GenderID = Gender.GenderID'
      
        #9'LEFT OUTER JOIN MembershipType ON Member.MembershipTypeID = Mem' +
        'bershipType.MembershipTypeID'
      #9'WHERE (Member.SwimClubID = 1)'
      #9'ORDER BY Member.LastName;'
      'ELSE'
      #9'SELECT Member.MemberID'
      #9#9',Member.MembershipNum'
      #9#9',Member.FirstName'
      #9#9',Member.LastName'
      #9#9',CONCAT ('
      #9#9#9'UPPER(Member.LastName)'
      #9#9#9','#39', '#39
      #9#9#9',Member.FirstName'
      #9#9#9') AS FName'
      #9#9',Member.DOB'
      #9#9',Member.IsActive'
      #9#9',Member.MembershipDue'
      #9#9',Member.Email'
      #9#9'-- , Member.DoEmailSessionReport'
      #9#9',Gender.Caption AS GenderStr'
      #9#9',Member.GenderID'
      #9#9',Member.SwimClubID'
      #9#9',Member.MembershipTypeID'
      #9#9',MembershipType.Caption AS cMembershipTypeStr'
      #9#9',SwimClub.Caption AS ClubName'
      #9#9',SwimClub.NickName AS ClubNickName'
      #9#9',dbo.SwimmerAge(GETDATE(), Member.DOB) AS AGE'
      #9'FROM Member'
      
        #9'LEFT OUTER JOIN SwimClub ON Member.SwimClubID = SwimClub.SwimCl' +
        'ubID'
      #9'LEFT OUTER JOIN Gender ON Member.GenderID = Gender.GenderID'
      
        #9'LEFT OUTER JOIN MembershipType ON Member.MembershipTypeID = Mem' +
        'bershipType.MembershipTypeID'
      #9'WHERE (Member.SwimClubID = 1)'
      #9#9'AND (MemberID = @MemberID)'
      #9'ORDER BY Member.LastName;'
      ''
      ''
      ''
      '')
    Left = 72
    Top = 312
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
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
    Left = 264
    Top = 144
  end
  object qryMemberContacts: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    Connection = FDConnection1
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @MemberID AS INT'
      ''
      '-- SET @MemberID = :MEMBERID;'
      ''
      'SELECT ContactNum.ContactNumID'
      #9',ContactNum.Number'
      #9',ContactNum.MemberID'
      #9',ContactNumType.Caption'
      'FROM ContactNum'
      
        'INNER JOIN ContactNumType ON ContactNum.ContactNumTypeID = Conta' +
        'ctNumType.ContactNumTypeID'
      ''
      '-- WHERE MemberID = @MemberID')
    Left = 72
    Top = 392
  end
  object frxDBContacts: TfrxDBDataset
    UserName = 'frxDBContacts'
    CloseDataSource = False
    DataSet = qryMemberContacts
    BCDToCurrency = False
    Left = 200
    Top = 392
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=MSSQL_SwimClubMeet')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 16
  end
end
