object MembersSummary: TMembersSummary
  OldCreateOrder = False
  Height = 468
  Width = 474
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
    Left = 312
    Top = 312
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
      Columns = 3
      ColumnWidth = 63.333333333333300000
      ColumnPositions.Strings = (
        '0'
        '63.3333333333333'
        '126.666666666667')
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Fill.BackColor = 14479868
        Frame.Typ = []
        Height = 56.692950000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object frxDSNickName: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'NickName'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."NickName"]')
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
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."cSwimClub"]')
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
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 321.260050000000000000
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
          Top = 1.889765000000000000
          Width = 279.685220000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
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
        Fill.BackColor = 15395562
        Frame.Typ = []
        Height = 34.015770000000000000
        Top = 136.063080000000000000
        Width = 239.370233333333200000
        Condition = 'frxDS."MemberID"'
        KeepTogether = True
        object frxDSucFName: TfrxMemoView
          AllowVectorExport = True
          Top = 11.338590000000000000
          Width = 249.448980000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."ucFName"] ([frxDS."Age"])')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 68.031540000000000000
        Top = 192.756030000000000000
        Width = 239.370233333333200000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object frxDSDOB: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 22.677180000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            'DOB: [frxDS."DOB"]')
        end
        object frxDSIsActive: TfrxMemoView
          AllowVectorExport = True
          Left = 75.590600000000000000
          Top = 3.779529999999990000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            'Active: [frxDS."IsActive"]')
        end
        object frxDSMemberID: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 3.779529999999990000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          DisplayFormat.FormatStr = '%4.4d'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'ID: [frxDS."MemberID"]')
          ParentFont = False
        end
        object frxDSMembershipNum: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 45.354360000000000000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."MembershipNumStr"]')
        end
      end
    end
  end
  object frxDSReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryReport
    BCDToCurrency = False
    Left = 192
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
    Left = 208
    Top = 112
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
    Left = 208
    Top = 48
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
    Left = 296
    Top = 56
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'SELECT Member.MemberID'
      #9',CASE '
      #9#9'WHEN  Member.MembershipNum IS NULL'#9'THEN '#39#39
      
        #9#9'ELSE CONCAT('#39'Membership# '#39', CONVERT(nvarchar,Member.Membership' +
        'Num))'
      #9#9'END AS MembershipNumStr'
      #9',Member.FirstName'
      #9',Member.LastName'
      #9',CONCAT ('
      #9#9'UPPER(Member.LastName)'
      #9#9','#39', '#39
      #9#9',Member.FirstName'
      #9#9') AS ucFName'
      #9',Member.DOB'
      #9',Member.IsActive'
      #9',CASE '
      #9#9'WHEN  Member.MembershipDue IS NULL'#9'THEN '#39#39
      
        #9#9'ELSE CONCAT('#39'Membership Due '#39',CONVERT(nvarchar,Member.Membersh' +
        'ipDue))'
      #9#9'END AS MembershipDueStr'
      #9',Member.Email'
      #9'-- , Member.DoEmailSessionReport'
      #9',Gender.Caption AS cGender'
      #9',Member.GenderID'
      #9',Member.SwimClubID'
      #9',Member.MembershipTypeID'
      #9',MembershipType.Caption AS cMembershipTypeStr'
      #9',SwimClub.Caption AS cSwimClub'
      #9',SwimClub.NickName'
      #9',FLOOR(DATEDIFF(Day, DOB, GETDATE()) / 365.0) AS Age'
      ''
      'FROM Member'
      
        'LEFT OUTER JOIN SwimClub ON Member.SwimClubID = SwimClub.SwimClu' +
        'bID'
      'LEFT OUTER JOIN Gender ON Member.GenderID = Gender.GenderID'
      
        'LEFT OUTER JOIN MembershipType ON Member.MembershipTypeID = Memb' +
        'ershipType.MembershipTypeID'
      'WHERE (Member.SwimClubID = @SwimClubID )'
      'ORDER BY Member.LastName'
      ''
      ''
      '')
    Left = 64
    Top = 312
    ParamData = <
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
    Left = 296
    Top = 112
  end
end
