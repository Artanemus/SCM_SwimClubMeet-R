object QTSessionReportA: TQTSessionReportA
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 351
  Width = 272
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
    ReportOptions.LastChange = 44217.607293993050000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
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
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 71.811070000000000000
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
            '[frxDS."cSwimClub"]')
          ParentFont = False
        end
        object FDQuery1NickName: TfrxMemoView
          AllowVectorExport = True
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSetName = 'FDQuery1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."NickName"]')
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 495.118430000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Fill.BackColor = 13296895
          Memo.UTF8W = (
            'Qualified for 50m')
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 495.118430000000000000
          Top = 22.677180000000000000
          Width = 102.047244090000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Fill.BackColor = 13434828
          Memo.UTF8W = (
            'Qualified for 100m')
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 495.118430000000000000
          Top = 45.354360000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Fill.BackColor = 13434879
          Memo.UTF8W = (
            'Qualified for 200m')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 604.724800000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Fill.BackColor = 16774348
          Memo.UTF8W = (
            'Qualified for 400m')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 604.724800000000000000
          Top = 22.677180000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Fill.BackColor = 13408511
          Memo.UTF8W = (
            'Qualified for 1000m')
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Top = 49.133890000000000000
          Width = 721.890230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Qualification details for this session.')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 15461355
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 34.015770000000000000
        ParentFont = False
        Top = 151.181200000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."SessionID"'
        object FDQuery1SessionStart: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 472.441250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            
              'Session Date : [frxDS."SessionStart" #dDDD dd MMM YYYY HH:MM AM/' +
              'PM]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 27.118120000000000000
          Width = 699.213050000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Top = 253.228510000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."EventID"'
        KeepTogether = True
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 275.905690000000000000
        Width = 718.110700000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 41.574830000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSetName = 'FDQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            
              'Event:[frxDS."EventNum"] - [frxDS."cDistance"] [frxDS."cStroke"]' +
              ' ')
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
        object FDQuery1Time: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Width = 90.708720000000000000
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
            '[IIF(<frxDS."RaceTime"> = 0 , '#39' '#39',<frxDS."RaceTimeStr">)]')
          ParentFont = False
          Highlights = <
            item
              ApplyFont = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              Condition = '((<frxDS."Q"> = 1) and (<frxDS."QualifyDistID"> = 2))'
              FillType = ftBrush
              Fill.BackColor = 13296895
              Frame.Typ = []
            end
            item
              ApplyFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              Condition = '((<frxDS."Q"> = 1) and (<frxDS."QualifyDistID"> = 3))'
              FillType = ftBrush
              Fill.BackColor = 13434828
              Frame.Typ = []
            end
            item
              ApplyFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              Condition = '((<frxDS."Q"> = 1) and (<frxDS."QualifyDistID"> = 4))'
              FillType = ftBrush
              Fill.BackColor = 13434879
              Frame.Typ = []
            end
            item
              ApplyFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              Condition = '((<frxDS."Q"> = 1) and (<frxDS."QualifyDistID"> = 5))'
              FillType = ftBrush
              Fill.BackColor = 16774348
              Frame.Typ = []
            end
            item
              ApplyFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              Condition = '((<frxDS."Q"> = 1) and (<frxDS."QualifyDistID"> = 6))'
              FillType = ftBrush
              Fill.BackColor = 13408511
              Frame.Typ = []
            end>
        end
        object frxDSDIFF: TfrxMemoView
          AllowVectorExport = True
          Left = 480.000310000000000000
          Width = 94.488250000000000000
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
          Memo.UTF8W = (
            '[IIF(<frxDS."DIFF"> = 0,'#39' '#39',<frxDS."DIFF">)]')
          ParentFont = False
        end
        object frxDSPersonalBest: TfrxMemoView
          AllowVectorExport = True
          Left = 385.512060000000000000
          Width = 94.488250000000000000
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
          Memo.UTF8W = (
            
              '[IIF(<frxDS."PersonalBest"> = 0 , '#39' '#39',<frxDS."PersonalBestStr">)' +
              ']')
          ParentFont = False
          Highlights = <
            item
              ApplyFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              Condition = 
                'IIF(((<frxDS."QPB"> = 1) and (<frxDS."QualifyDistID"> = 2)),1,0)' +
                ' = 1'
              FillType = ftBrush
              Fill.BackColor = 13296895
              Frame.Typ = []
            end
            item
              ApplyFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              Condition = 
                'IIF(((<frxDS."QPB"> = 1) and (<frxDS."QualifyDistID"> = 3)),1,0)' +
                ' = 1'
              FillType = ftBrush
              Fill.BackColor = 13434828
              Frame.Typ = []
            end
            item
              ApplyFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              Condition = 
                'IIF(((<frxDS."QPB"> = 1) and (<frxDS."QualifyDistID"> = 4)),1,0)' +
                ' = 1'
              FillType = ftBrush
              Fill.BackColor = 13434879
              Frame.Typ = []
            end
            item
              ApplyFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              Condition = 
                'IIF(((<frxDS."QPB"> = 1) and (<frxDS."QualifyDistID"> = 5)),1,0)' +
                ' = 1'
              FillType = ftBrush
              Fill.BackColor = 16774348
              Frame.Typ = []
            end
            item
              ApplyFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              Condition = 
                'IIF(((<frxDS."QPB"> = 1) and (<frxDS."QualifyDistID"> = 6)),1,0)' +
                ' = 1'
              FillType = ftBrush
              Fill.BackColor = 13408511
              Frame.Typ = []
            end>
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 355.275820000000000000
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
      object GroupHeader4: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = cl3DLight
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 207.874150000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."MemberID"'
        KeepTogether = True
        OutlineText = 'frxDS."MemberID"'
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 272.126160000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FNAME"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Width = 90.708720000000000000
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
            'RaceTime')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 476.220780000000000000
          Width = 98.267780000000000000
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
            'DIFF')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 385.512060000000000000
          Width = 90.708720000000000000
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
            'PB')
          ParentFont = False
        end
      end
    end
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SessionID'
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @SessionID AS INT'
      ''
      'SET @SessionID = :SESSIONID;'
      ''
      'SELECT DISTINCT Member.MemberID'
      #9',Session.SessionStart'
      #9',Session.SessionID'
      #9',Entrant.RaceTime'
      #9',Entrant.PersonalBest'
      #9',Entrant.TimeToBeat'
      #9',CASE CAST([Entrant].[PersonalBest] AS DATETIME)'
      #9#9'WHEN NULL'
      #9#9#9'THEN NULL'
      #9#9'WHEN 0'
      #9#9#9'THEN NULL'
      
        #9#9'ELSE DATEDIFF(millisecond, Entrant.RaceTime, Entrant.PersonalB' +
        'est) / 1000.0'
      #9#9'END AS DIFF'
      #9',dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTimeStr'
      
        #9',dbo.SwimTimeToString([Entrant].[PersonalBest]) AS PersonalBest' +
        'Str'
      #9',CONCAT ('
      #9#9'Member.FirstName'
      #9#9','#39' '#39
      #9#9',Upper(Member.LastName)'
      #9#9','#39' ('#39
      #9#9',dbo.SwimmerAge(Session.SessionStart, Member.DOB)'
      #9#9','#39')'#39
      #9#9') AS FNAME'
      #9',Event.EventID'
      #9',Event.EventNum'
      #9',HeatIndividual.HeatNum'
      #9',Stroke.Caption AS cStroke'
      #9',Distance.Caption AS cDistance'
      #9',Entrant.Lane'
      #9',Entrant.IsDisqualified'
      #9',Entrant.IsScratched'
      #9',SwimClub.NickName'
      #9',SwimClub.Caption AS cSwimClub'
      
        #9'-- Based on racetime ... indicates if the swimmer is qualified ' +
        'to swim the next distance for that stroke'
      #9',CASE '
      #9#9'WHEN (Qualify.TrialTime > Entrant.RaceTime)'
      #9#9#9'THEN 0'
      #9#9'WHEN (Qualify.TrialTime <= Entrant.RaceTime)'
      #9#9#9'THEN 1'
      #9#9'ELSE 0'
      #9#9'END AS Q'
      
        #9'-- Based on PB ... indicates if the swimmer is qualified to swi' +
        'm the next distance for that stroke'
      #9',CASE '
      #9#9'WHEN (Entrant.PersonalBest) IS NULL'
      #9#9#9'THEN 0'
      #9#9'WHEN (Qualify.TrialTime > Entrant.PersonalBest)'
      #9#9#9'THEN 0'
      #9#9'WHEN (Qualify.TrialTime <= Entrant.PersonalBest)'
      #9#9#9'THEN 1'
      #9#9'ELSE 0'
      #9#9'END AS QPB'
      #9'-- distance qualified for'
      #9',Qualify.QualifyDistID'
      
        #9'-- must appear in the SELECT list as ORDER and DISTINCT are exp' +
        'liciantly linked'
      #9',Member.LastName'
      #9',Member.FirstName'
      #9',Distance.DistanceID'
      #9',Stroke.StrokeID'
      'FROM Member'
      'INNER JOIN Entrant ON Entrant.MemberID = Member.MemberID'
      
        'INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.Hea' +
        'tID'
      'INNER JOIN Event ON HeatIndividual.EventID = Event.EventID'
      'INNER JOIN Session ON Event.SessionID = Session.SessionID'
      'INNER JOIN SwimClub ON Session.SwimClubID = SwimClub.SwimClubID'
      'INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      'INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      'LEFT OUTER JOIN Qualify ON Event.StrokeID = Qualify.StrokeID'
      #9'AND Event.DistanceID = Qualify.TrialDistID'
      'WHERE (Session.SessionID = @SessionID)'
      'ORDER BY Member.LastName'
      #9',Member.FirstName'
      #9',Distance.DistanceID'
      #9',Stroke.StrokeID')
    Left = 160
    Top = 272
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 29
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
end
