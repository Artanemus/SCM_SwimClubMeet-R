object MemberDetail: TMemberDetail
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
    ReportOptions.LastChange = 44966.624022395800000000
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
        DataSet = frxDBHistory
        DataSetName = 'frxDBHistory'
      end
      item
        DataSet = frxDBPB
        DataSetName = 'frxDBPB'
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
      LeftMargin = 40.000000000000000000
      RightMargin = 40.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 95.000000000000000000
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
        Height = 49.133890000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 491.338900000000000000
        object frxDSNickName: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'ClubNickName'
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
          DataField = 'ClubName'
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
          Align = baWidth
          AllowVectorExport = True
          Top = 48.590600000000000000
          Width = 491.338900000000000000
          StretchMode = smMaxHeight
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 4.000000000000000000
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 680.315400000000000000
        Width = 491.338900000000000000
        object Page: TfrxMemoView
          Align = baCenter
          AllowVectorExport = True
          Left = 166.299320000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            '[Page#] of [TotalPages#]')
        end
        object Date: TfrxMemoView
          Align = baLeft
          AllowVectorExport = True
          Top = 2.000000000000000000
          Width = 157.271800000000000000
          Height = 14.897650000000000000
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
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 49.456710000000000000
        Top = 128.504020000000000000
        Width = 491.338900000000000000
        Condition = 'frxDS."MemberID"'
        KeepTogether = True
        object Shape1: TfrxShapeView
          Align = baWidth
          AllowVectorExport = True
          Top = 12.436920000000000000
          Width = 491.338900000000000000
          Height = 21.397650000000000000
          Fill.BackColor = cl3DLight
          Frame.Color = clNone
          Frame.Typ = []
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 2.153680000000000000
          Top = 13.500000000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          DataField = 'MemberID'
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
          Memo.UTF8W = (
            '[frxDS."MemberID"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 151.685220000000000000
          Top = 10.500000000000000000
          Width = 219.630180000000000000
          Height = 26.456710000000000000
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
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 29.677180000000000000
        Top = 340.157700000000000000
        Width = 491.338900000000000000
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 32.000000000000000000
          Top = 7.751700000000000000
          Width = 124.563080000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Contact numbers ...')
          ParentFont = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.677180000000000000
        Top = 438.425480000000000000
        Width = 491.338900000000000000
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 32.500000000000000000
          Top = 7.000000000000000000
          Width = 103.563080000000000000
          Height = 22.677180000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Personal Best ...')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 290.000000000000000000
          Top = 17.176870000000000000
          Width = 61.988250000000000000
          Height = 11.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Qualified')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 117.357760000000000000
        Top = 200.315090000000000000
        Width = 491.338900000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        RowCount = 0
        object frxDSDOB: TfrxMemoView
          AllowVectorExport = True
          Left = 100.460730000000000000
          Top = 20.334260000000000000
          Width = 78.208720000000000000
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
          Left = 56.090600000000000000
          Top = 20.334260000000000000
          Width = 35.031540000000000000
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
          Left = 49.618120000000000000
          Top = 58.751596670000000000
          Width = 41.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Active')
          ParentFont = False
        end
        object CheckBox1: TfrxCheckBoxView
          AllowVectorExport = True
          Left = 100.460730000000000000
          Top = 58.011440000000000000
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
          Left = 100.460730000000000000
          Top = 38.688620000000000000
          Width = 74.740260000000000000
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
        object frxDSMembershipNum: TfrxMemoView
          AllowVectorExport = True
          Left = 100.460730000000000000
          Top = 1.042980000000000000
          Width = 78.106370000000000000
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
          Left = 1.074830000000000000
          Top = 1.042980000000000000
          Width = 90.047310000000000000
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
          Left = 100.960730000000000000
          Top = 77.720160000000000000
          Width = 227.130180000000000000
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
          Left = 52.488250000000000000
          Top = 77.720160000000000000
          Width = 38.633890000000000000
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
          Left = 16.838590000000000000
          Top = 96.617810000000000000
          Width = 74.283550000000000000
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
        object frxDSCreatedOn: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 101.000000000000000000
          Top = 96.617810000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'CreatedOn'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."CreatedOn"]')
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = 97.000000000000000000
          Top = 1.125850000000000000
          Height = 114.381880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 393.071120000000000000
        Width = 491.338900000000000000
        DataSet = frxDBContacts
        DataSetName = 'frxDBContacts'
        RowCount = 0
        object frxDBContactsContactNumID: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 130.500000000000000000
          Top = 1.141620000000000000
          Width = 222.370130000000000000
          Height = 18.897650000000000000
          DataField = 'Number'
          DataSet = frxDBContacts
          DataSetName = 'frxDBContacts'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBContacts."Number"]')
        end
        object frxDBContactsCaption: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 34.500000000000000000
          Top = 1.141620000000000000
          Width = 93.610390000000000000
          Height = 18.897650000000000000
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
            '[frxDBContacts."Caption"] :')
          ParentFont = False
        end
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 491.338900000000000000
        Width = 491.338900000000000000
        DataSet = frxDBPB
        DataSetName = 'frxDBPB'
        RowCount = 0
        object frxDBPBEventStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 31.500000000000000000
          Top = -0.000310000000000005
          Width = 154.630180000000000000
          Height = 18.897650000000000000
          DataField = 'EventStr'
          DataSet = frxDBPB
          DataSetName = 'frxDBPB'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBPB."EventStr"]')
        end
        object frxDBPBPB: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 189.000000000000000000
          Top = -0.000310000000000005
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'PB'
          DataSet = frxDBPB
          DataSetName = 'frxDBPB'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBPB."PB"]')
        end
        object CheckBox2: TfrxCheckBoxView
          AllowVectorExport = True
          Left = 304.000000000000000000
          Top = -0.236550000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          CheckColor = clBlack
          CheckStyle = csCheck
          DataField = 'IsQualified'
          DataSet = frxDBPB
          DataSetName = 'frxDBPB'
          Frame.Typ = []
        end
      end
      object Header4: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 42.177180000000000000
        Top = 532.913730000000000000
        Width = 491.338900000000000000
        object Shape2: TfrxShapeView
          AllowVectorExport = True
          Left = 0.500000000000000000
          Top = 18.645330000000000000
          Width = 388.425170000000000000
          Height = 21.397650000000000000
          Fill.BackColor = cl3DLight
          Frame.Color = clNone
          Frame.Typ = []
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 2.500000000000000000
          Top = 19.000000000000000000
          Width = 103.563080000000000000
          Height = 22.677180000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'History ...')
          ParentFont = False
        end
      end
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 597.165740000000000000
        Width = 491.338900000000000000
        DataSet = frxDBHistory
        DataSetName = 'frxDBHistory'
        RowCount = 0
        object frxDBHistoryEventStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 4.500000000000000000
          Top = 1.495670000000000000
          Width = 155.630180000000000000
          Height = 18.897650000000000000
          DataField = 'EventStr'
          DataSet = frxDBHistory
          DataSetName = 'frxDBHistory'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBHistory."EventStr"]')
        end
        object frxDBHistoryRT: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 163.500000000000000000
          Top = 1.495670000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'RT'
          DataSet = frxDBHistory
          DataSetName = 'frxDBHistory'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBHistory."RT"]')
        end
        object frxDBHistoryEventDate: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 261.500000000000000000
          Top = 1.495670000000000000
          Width = 167.130180000000000000
          Height = 18.897650000000000000
          DataField = 'EventDate'
          DataSet = frxDBHistory
          DataSetName = 'frxDBHistory'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBHistory."EventDate"]')
        end
      end
    end
  end
  object frxDSReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryReport
    BCDToCurrency = False
    Left = 216
    Top = 264
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
    Left = 152
    Top = 160
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
    Left = 152
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
    Left = 264
    Top = 72
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'MemberID'
    Connection = FDConnection1
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @MemberID AS INT'
      'DECLARE @SwimClubID AS INT'
      ''
      'SET @MemberID = :MEMBERID'
      'SET @SwimClubID = :SWIMCLUBID'
      ''
      '    SELECT Member.MemberID'
      '         , Member.MembershipNum'
      '         , Member.FirstName'
      '         , Member.LastName'
      
        '         , CONCAT(Member.FirstName, '#39' '#39',  UPPER(Member.LastName)' +
        ' ) AS FName'
      '         , Member.DOB'
      '         , Member.IsActive'
      '         , Member.Email'
      '         -- , Member.DoEmailSessionReport'
      '         , Gender.Caption AS GenderStr'
      '         , Member.GenderID'
      '         , Member.SwimClubID'
      '         , SwimClub.Caption AS ClubName'
      '         , SwimClub.NickName AS ClubNickName'
      '         , dbo.SwimmerAge(GETDATE(), Member.DOB) AS AGE'
      ', Member.CreatedOn'
      '    FROM Member'
      '        LEFT OUTER JOIN SwimClub'
      '            ON Member.SwimClubID = SwimClub.SwimClubID'
      '        LEFT OUTER JOIN Gender'
      '            ON Member.GenderID = Gender.GenderID'
      '    WHERE '
      ' -- (Member.SwimClubID = @SwimClubID) AND '
      ' (Member.MemberID = @MemberID)'
      '    ORDER BY Member.LastName;')
    Left = 72
    Top = 264
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
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
    Top = 168
  end
  object qryMemberContacts: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'ContactNumID'
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
      'SELECT ContactNum.ContactNumID'
      #9',ContactNum.Number'
      #9',ContactNum.MemberID'
      #9',ContactNumType.Caption'
      'FROM ContactNum'
      
        'INNER JOIN ContactNumType ON ContactNum.ContactNumTypeID = Conta' +
        'ctNumType.ContactNumTypeID'
      ''
      'WHERE MemberID = @MemberID')
    Left = 72
    Top = 320
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object frxDBContacts: TfrxDBDataset
    UserName = 'frxDBContacts'
    CloseDataSource = False
    DataSet = qryMemberContacts
    BCDToCurrency = False
    Left = 216
    Top = 320
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=MSSQL_SwimClubMeet')
    ConnectedStoredUsage = [auDesignTime]
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 16
  end
  object qryPB: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'MemberID'
    Connection = FDConnection1
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ';'
      ''
      'DECLARE @memberid as int'
      'SET @memberid = :MEMBERID'
      ''
      'SELECT DISTINCT Member.MemberID'
      #9',Distance.DistanceID'
      #9',Stroke.StrokeID'
      
        #9',dbo.PersonalBest(MemberID, DistanceID, StrokeID, GETDATE()) AS' +
        ' PB'
      #9',('
      #9#9'CONCAT ('
      #9#9#9'distance.caption'
      #9#9#9','#39' '#39
      #9#9#9',stroke.caption'
      #9#9#9')'
      #9#9') AS EventStr'
      
        ', CAST(dbo.IsMemberQualified(Member.MemberID, GetDATE(),Distance' +
        '.DistanceID,Stroke.StrokeID)AS BIT) AS IsQualified '
      'FROM Distance'
      'CROSS JOIN Stroke'
      'CROSS JOIN Member'
      
        'WHERE Member.MemberID = @memberid AND dbo.PersonalBest(MemberID,' +
        ' DistanceID, StrokeID, GETDATE()) IS NOT NULL'
      'ORDER BY MemberID'
      #9',DistanceID'
      #9',StrokeID'
      #9',PB ASC'
      ';')
    Left = 73
    Top = 376
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qryPBEventStr: TWideStringField
      FieldName = 'EventStr'
      Origin = 'EventStr'
      ReadOnly = True
      Required = True
      Size = 257
    end
    object qryPBPB: TTimeField
      FieldName = 'PB'
      Origin = 'PB'
      ReadOnly = True
      DisplayFormat = 'nn:ss.zzz'
    end
    object qryPBMemberID: TFDAutoIncField
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object qryPBDistanceID: TFDAutoIncField
      FieldName = 'DistanceID'
      Origin = 'DistanceID'
      ReadOnly = True
      Visible = False
    end
    object qryPBStrokeID: TFDAutoIncField
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
      ReadOnly = True
      Visible = False
    end
    object qryPBIsQualified: TBooleanField
      FieldName = 'IsQualified'
      Origin = 'IsQualified'
      ReadOnly = True
    end
  end
  object frxDBPB: TfrxDBDataset
    UserName = 'frxDBPB'
    CloseDataSource = False
    FieldAliases.Strings = (
      'EventStr=EventStr'
      'PB=PB'
      'MemberID=MemberID'
      'DistanceID=DistanceID'
      'StrokeID=StrokeID'
      'IsQualified=IsQualified')
    DataSet = qryPB
    BCDToCurrency = False
    Left = 216
    Top = 376
  end
  object qryHistory: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @MemberID AS INTEGER'
      'SET @MemberID = :MEMBERID'
      'DECLARE @SwimClubID AS INTEGER'
      'SET @SwimClubID = :SWIMCLUBID'
      ''
      'SELECT Member.MemberID'
      '     , CONCAT(Distance.Caption, '#39' '#39', Stroke.Caption) AS EventStr'
      '     , dbo.SwimTimeToString(RaceTime) AS RT'
      
        '     , FORMAT(Session.SessionStart, '#39'ddd dd MMM yyyy'#39') AS EventD' +
        'ate'
      'FROM Member'
      '    LEFT JOIN Entrant'
      '        ON Member.MemberID = Entrant.MemberID'
      '    LEFT JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    LEFT JOIN [Event]'
      '        ON HeatIndividual.EventID = [Event].[EventID]'
      '    LEFT JOIN [Session]'
      '        ON [Event].SessionID = [Session].SessionID'
      '    LEFT JOIN Distance'
      '        ON [Event].[DistanceID] = Distance.DistanceID'
      '    LEFT JOIN Stroke'
      '        ON [Event].[StrokeID] = Stroke.StrokeID'
      'WHERE Member.MemberID = @MemberID'
      '      AND RaceTime IS NOT NULL'
      '      AND IsDisqualified <> 1'
      '      AND IsScratched <> 1'
      '      AND Session.SwimClubID = @SwimClubID'
      '    ORDER BY SessionStart DESC')
    Left = 72
    Top = 440
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object frxDBHistory: TfrxDBDataset
    UserName = 'frxDBHistory'
    CloseDataSource = False
    FieldAliases.Strings = (
      'MemberID=MemberID'
      'EventStr=EventStr'
      'RT=RT'
      'EventDate=EventDate')
    DataSet = qryHistory
    BCDToCurrency = False
    Left = 216
    Top = 440
  end
end
