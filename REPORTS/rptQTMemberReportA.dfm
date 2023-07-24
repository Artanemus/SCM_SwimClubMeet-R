object QTMemberReportA: TQTMemberReportA
  OnCreate = DataModuleCreate
  Height = 350
  Width = 301
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'Lastname'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss:zzz'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @MemberID AS INT = 0'
      'DECLARE @DistanceID AS INT'
      'DECLARE @StrokeID AS INT = 0'
      ''
      'DECLARE @ClubName AS NVARCHAR(40)'
      'DECLARE @ClubNickName AS NVARCHAR(40)'
      ''
      '--SET @MemberID = 2;'
      '--SET @DistanceID = 2;'
      '--SET @StrokeID = 1;'
      ''
      'SET @ClubName = :CLUBNAME;'
      'SET @ClubNickName = :CLUBNICKNAME;'
      ''
      
        '--SELECT @ClubName = Caption FROM SwimClub WHERE SwimClub.SwimCl' +
        'ubID = 1;'
      
        '--SELECT @ClubNickName = NickName FROM SwimClub WHERE SwimClub.S' +
        'wimClubID = 1;'
      ''
      ''
      'WITH CTE AS (SELECT Entrant.MemberID'
      #9',Qualify.QualifyDistID'
      #9',Qualify.StrokeID'
      'FROM Distance'
      'INNER JOIN Qualify'
      'INNER JOIN Entrant'
      
        'INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.Hea' +
        'tID'
      
        'INNER JOIN Event ON HeatIndividual.EventID = Event.EventID ON Qu' +
        'alify.TrialDistID = Event.DistanceID'
      #9'AND Qualify.StrokeID = Event.StrokeID'
      #9'AND Qualify.TrialTime <= Entrant.RaceTime'
      
        #9'AND Qualify.TrialTime <= Entrant.RaceTime ON Distance.DistanceI' +
        'D = Qualify.QualifyDistID INNER JOIN Stroke ON Qualify.StrokeID ' +
        '= Stroke.StrokeID '
      #9
      
        #9'--WHERE (Qualify.StrokeID = 1) '#9'AND (Qualify.QualifyDistID = 2)' +
        ' '
      #9' '
      
        'GROUP BY Entrant.MemberID,Qualify.QualifyDistID,Qualify.StrokeID' +
        ')'
      ''
      ''
      'SELECT CTE.MemberID '
      ',CTE.QualifyDistID AS DistanceID'
      ',CTE.StrokeID'
      ',Distance.Caption AS DistanceStr'
      ', Stroke.Caption AS StrokeStr '
      
        ', CONCAT (Member.Firstname, '#39' '#39' , UPPER(Member.Lastname)) AS FNa' +
        'me '
      ', @ClubName AS ClubName'
      ', @ClubNickName AS ClubNickName'
      ', Member.Lastname'
      'FROM Member'
      'INNER JOIN CTE ON Member.MemberID = CTE.MemberID'
      'INNER JOIN Distance ON CTE.QualifyDistID = Distance.DistanceID'
      'INNER JOIN Stroke ON CTE.StrokeID = Stroke.StrokeID '
      'WHERE Member.IsActive = 1'
      'ORDER BY Member.LastName,CTE.QualifyDistID, CTE.StrokeID '
      ''
      #9
      '')
    Left = 160
    Top = 272
    ParamData = <
      item
        Name = 'CLUBNAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CLUBNICKNAME'
        DataType = ftString
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
  object frxDSReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryReport
    BCDToCurrency = False
    Left = 64
    Top = 272
  end
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
    ReportOptions.LastChange = 43796.537549027800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      '  '
      '      '
      'end.')
    Left = 160
    Top = 16
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
      Columns = 3
      ColumnWidth = 63.333333333333300000
      ColumnPositions.Strings = (
        '0'
        '63.3333333333333'
        '126.666666666667')
      Frame.Color = clNone
      Frame.ShadowColor = clNone
      Frame.Typ = []
      MirrorMode = []
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 143.622140000000000000
        Width = 239.370233333333200000
        Condition = 'frxDS."Lastname"'
        KeepTogether = True
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Top = 6.779530000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Fill.BackColor = cl3DLight
          Frame.Color = clNone
          Frame.Typ = []
        end
        object frxDSFName: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 6.779530000000000000
          Width = 215.433210000000000000
          Height = 18.897650000000000000
          DataField = 'FName'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FName"]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 64.252010000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object FDQuery1cSwimClub: TfrxMemoView
          AllowVectorExport = True
          Width = 714.331170000000000000
          Height = 30.236240000000000000
          AutoWidth = True
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
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
          Width = 714.331170000000000000
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
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Top = 41.574830000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'A list of events that each club member is qualified to swim.')
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
        Height = 15.118120000000000000
        ParentFont = False
        Top = 192.756030000000000000
        Width = 239.370233333333200000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object frxDSDistanceStr: TfrxMemoView
          AllowVectorExport = True
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          AutoWidth = True
          DataField = 'DistanceStr'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."DistanceStr"]')
          ParentFont = False
        end
        object frxDSStrokeStr: TfrxMemoView
          AllowVectorExport = True
          Left = 83.149660000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          AutoWidth = True
          DataField = 'StrokeStr'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."StrokeStr"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 268.346630000000000000
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
          Top = 3.779530000000020000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed On: [Date]')
        end
      end
    end
  end
end
