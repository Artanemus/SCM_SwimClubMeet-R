object NominateReportA: TNominateReportA
  OnCreate = DataModuleCreate
  Height = 422
  Width = 246
  object frxReport1: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43429.469572048600000000
    ReportOptions.LastChange = 43433.892619490700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 104
    Top = 24
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
        Height = 49.133890000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object frxDSNickName: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 20.897650000000000000
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
          Top = 43.590600000000000000
          Width = 714.331170000000000000
          StretchMode = smMaxHeight
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 4.000000000000000000
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 472.441250000000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Nominations.')
          ParentFont = False
        end
        object frxDSSessionStart: TfrxMemoView
          AllowVectorExport = True
          Left = 427.086890000000000000
          Top = 20.897650000000000000
          Width = 287.244280000000000000
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
            'Session: [frxDS."SessionStart" #dDDD dd MMM YYYY HH:MM AM/PM]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 257.008040000000000000
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
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 128.504020000000000000
        Width = 239.370233333333200000
        Condition = 'frxDS."MemberID"'
        KeepTogether = True
        object frxDSucFName: TfrxMemoView
          AllowVectorExport = True
          Top = 7.559059999999990000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15395562
          Memo.UTF8W = (
            '[frxDS."FName"] ([frxDS."Age"])')
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
        Height = 18.897650000000000000
        Top = 177.637910000000000000
        Width = 239.370233333333200000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object frxDScDistance: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 230.551330000000000000
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
            '[frxDS."cDistance"] : [frxDS."cStroke"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDSReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = True
    DataSet = qryReport
    BCDToCurrency = False
    Left = 40
    Top = 104
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
    Left = 40
    Top = 272
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
    Left = 40
    Top = 208
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
    Left = 144
    Top = 208
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexesActive = False
    IndexFieldNames = 'SessionID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime, fvStrsTrim2Len]
    FormatOptions.FmtDisplayDateTime = 'dd mmm YYYY  HH:MM'
    FormatOptions.FmtDisplayDate = 'dd/mm/YYYY '
    FormatOptions.FmtDisplayTime = 'nn:mm.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'SessionID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @SessionID AS INT'
      ''
      'SET @SessionID = :SESSIONID'
      ''
      'SELECT SwimClub.Caption AS CSwimClub'
      #9',SwimClub.NickName'
      #9',Session.SessionID'
      #9',Nominee.MemberID'
      #9',SUBSTRING(CONCAT ('
      #9#9#9'Upper(Member.LastName)'
      #9#9#9','#39', '#39
      #9#9#9',Member.FirstName'
      #9#9#9'), 0, 40) AS FName'
      #9',dbo.SwimmerAge(Session.SessionStart,Member.DOB) AS Age'
      #9',Distance.Caption AS cDistance'
      #9',Stroke.Caption AS cStroke'
      #9',Session.SessionStart'
      'FROM Session'
      'INNER JOIN Event ON Session.SessionID = Event.SessionID'
      'INNER JOIN Nominee ON Event.EventID = Nominee.EventID'
      'LEFT JOIN SwimClub ON Session.SwimClubID = SwimClub.SwimClubID'
      'LEFT JOIN Member ON Nominee.MemberID = Member.MemberID'
      'LEFT JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      'LEFT JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      'WHERE Session.SessionID = @SessionID'
      'ORDER BY Member.LastName'
      #9',Member.FirstName'
      #9',Distance.DistanceID'
      '')
    Left = 144
    Top = 104
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 9
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
    Left = 144
    Top = 272
  end
end
