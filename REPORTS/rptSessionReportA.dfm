object SessionReportA: TSessionReportA
  OnCreate = DataModuleCreate
  Height = 394
  Width = 377
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
    ReportOptions.LastChange = 43795.665452800900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 216
    Top = 32
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
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object FDQuery1cSwimClub: TfrxMemoView
          AllowVectorExport = True
          Width = 400.630180000000000000
          Height = 30.236240000000000000
          AutoWidth = True
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."ClubName"]')
          ParentFont = False
        end
        object FDQuery1NickName: TfrxMemoView
          AllowVectorExport = True
          Top = 22.677180000000000000
          Width = 377.953000000000000000
          Height = 18.897650000000000000
          DataSetName = 'FDQuery1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."ClubNickName"]')
        end
        object FDQuery1SessionStart: TfrxMemoView
          AllowVectorExport = True
          Left = 381.732530000000000000
          Top = 22.677180000000000000
          Width = 332.598640000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              'Session Date : [frxDS."SessionDate" #dDDD dd MMM YYYY HH:MM AM/P' +
              'M]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 15461355
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 124.724490000000000000
        Visible = False
        Width = 718.110700000000000000
        Condition = 'frxDS."SessionID"'
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 13816530
        Frame.Typ = []
        Height = 52.913420000000000000
        Top = 173.858380000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."EventID"'
        KeepTogether = True
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 30.236240000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Lane')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 64.252010000000000000
          Top = 30.236240000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Swimmer')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 381.732530000000000000
          Top = 30.236240000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RaceTime')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 7.559060000000000000
          Width = 321.260050000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            
              'Event: [frxDS."EventNum"] - [frxDS."DistanceStr"] [frxDS."Stroke' +
              'Str"] ')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Top = 30.236240000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'M/F')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 328.819110000000000000
          Top = 30.236240000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Age')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 532.913730000000000000
          Top = 30.236240000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DIFF')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 457.323130000000000000
          Top = 30.236240000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'PB')
          ParentFont = False
        end
        object frxDScEvent: TfrxMemoView
          AllowVectorExport = True
          Left = 343.937230000000000000
          Top = 7.559060000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          DataField = 'cEvent'
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
            '[frxDS."cEvent"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 302.362400000000000000
        Width = 718.110700000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        RowCount = 0
        object FDQuery1FNAME: TfrxMemoView
          AllowVectorExport = True
          Left = 64.252010000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FNAME"]')
          ParentFont = False
        end
        object FDQuery1Lane: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."Lane" #n%2.0f]')
          ParentFont = False
        end
        object frxDSGENDER: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataField = 'GENDER'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."GENDER"]')
          ParentFont = False
        end
        object frxDSAge: TfrxMemoView
          AllowVectorExport = True
          Left = 328.819110000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataField = 'Age'
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
            '[frxDS."Age"]')
          ParentFont = False
        end
        object frxDSRaceTimeStr: TfrxMemoView
          AllowVectorExport = True
          Left = 381.732530000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."RaceTime"]')
        end
        object frxDSPersonalBestStr: TfrxMemoView
          AllowVectorExport = True
          Left = 457.323130000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."PersonalBest"]')
        end
        object frxDSDIFF: TfrxMemoView
          AllowVectorExport = True
          Left = 532.913730000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxDS."DIFF" #n%3.2f]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 423.307360000000000000
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
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 249.448980000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."HeatNum"'
        KeepTogether = True
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 5.779530000000000000
          Top = 2.779530000000000000
          Width = 94.488250000000000000
          Height = 22.677180000000000000
          Frame.Typ = []
          Frame.Width = 2.000000000000000000
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 12.000000000000000000
          Top = 5.000000000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Heat#')
          ParentFont = False
        end
        object frxDSHeatNum1: TfrxMemoView
          AllowVectorExport = True
          Left = 61.133890000000000000
          Top = 5.000000000000000000
          Width = 45.354360000000000000
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
            '[frxDS."HeatNum" #n%2.0f]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 343.937230000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SessionID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.MaxBcdPrecision = 16
    FormatOptions.FmtDisplayTime = 'mm:ss.zz'
    SQL.Strings = (
      '--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!'
      ''
      'USE SwimClubMeet'
      ''
      'DECLARE @SID AS INT'
      ''
      ''
      'SET @SID = :SID;'
      ''
      ''
      'SELECT Session.SessionID'
      #9',Event.EventID'
      #9',Event.Caption AS cEvent'
      #9',CAST(Session.SessionStart AS DATE) AS SessionDate'
      #9',SUBSTRING(Stroke.Caption, 0, 16) AS StrokeStr'
      #9',SUBSTRING(Distance.Caption, 0, 10) AS DistanceStr'
      '        ,Event.EventNum'
      #9',HeatIndividual.HeatNum'
      #9',Entrant.Lane'
      #9',dbo.SwimmerGenderToString(Member.MemberID) AS GENDER'
      #9',dbo.SwimmerAge(Session.SessionStart, DOB) AS Age'
      
        #9',dbo.RaceTimeDIFF(Entrant.RaceTime, Entrant.PersonalBest) AS DI' +
        'FF'
      #9',dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTime'
      #9',dbo.SwimTimeToString(Entrant.PersonalBest) AS PersonalBest'
      #9',CONCAT ('
      #9#9'Member.FirstName'
      #9#9','#39' '#39
      #9#9',UPPER(Member.LastName)'
      #9#9') AS FNAME'
      #9',SwimClub.Caption AS ClubName'
      #9',SwimClub.NickName AS ClubNickName'
      'FROM Session'
      
        'LEFT OUTER JOIN SwimClub ON Session.SwimClubID = SwimClub.SwimCl' +
        'ubID'
      'FULL OUTER JOIN Entrant'
      'LEFT OUTER JOIN Member ON Entrant.MemberID = Member.MemberID'
      
        'RIGHT OUTER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividu' +
        'al.HeatID'
      'FULL OUTER JOIN Stroke'
      'RIGHT OUTER JOIN Distance'
      
        'RIGHT OUTER JOIN Event ON Distance.DistanceID = Event.DistanceID' +
        ' ON Stroke.StrokeID = Event.StrokeID ON HeatIndividual.EventID =' +
        ' Event.EventID ON Session.SessionID = Event.SessionID WHERE (Ses' +
        'sion.SessionID = @SID)'
      #9'AND Member.MemberID IS NOT NULL ORDER BY EventNum'
      #9',HeatNum'
      #9',Lane'
      ''
      '')
    Left = 200
    Top = 272
    ParamData = <
      item
        Name = 'SID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
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
    Left = 72
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
    Left = 72
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
    Left = 72
    Top = 96
  end
  object frxDSReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryReport
    BCDToCurrency = False
    Left = 72
    Top = 272
  end
end
