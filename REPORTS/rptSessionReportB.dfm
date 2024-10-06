object SessionReportB: TSessionReportB
  OnCreate = DataModuleCreate
  Height = 394
  Width = 281
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
    ReportOptions.LastChange = 44122.577764872700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
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
            '[frxDS."cSwimClub"]')
          ParentFont = False
        end
        object FDQuery1NickName: TfrxMemoView
          AllowVectorExport = True
          Top = 22.677180000000000000
          Width = 355.275820000000000000
          Height = 18.897650000000000000
          DataSetName = 'FDQuery1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."NickName"]')
        end
        object FDQuery1SessionStart: TfrxMemoView
          AllowVectorExport = True
          Left = 383.512060000000000000
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
            
              'Session Date : [frxDS."SessionStart" #dDDD dd MMM YYYY HH:MM AM/' +
              'PM]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 41.574830000000000000
        ParentFont = False
        Top = 124.724490000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."SessionID"'
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 1.779530000000000000
          Top = 27.118120000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Top = 241.889920000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."EventID"'
        KeepTogether = True
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 264.567100000000000000
        Width = 718.110700000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object frxDScEventDetails: TfrxMemoView
          AllowVectorExport = True
          Left = 147.622140000000000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          DataField = 'cEventDetails'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDS."cEventDetails"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 3.574830000000000000
          Width = 143.622140000000000000
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
            
              '[frxDS."EventNum" #n%2.0f]: [frxDS."cDistance"] [frxDS."cStroke"' +
              ']')
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
        object FDQuery1Lane: TfrxMemoView
          AllowVectorExport = True
          Left = 393.055350000000000000
          Width = 37.795300000000000000
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
            '[frxDS."Lane" #n%3.0f]')
          ParentFont = False
        end
        object FDQuery1Time: TfrxMemoView
          AllowVectorExport = True
          Left = 434.189240000000000000
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
          HideZeros = True
          Memo.UTF8W = (
            '[IIF(<frxDS."RaceTime"> = 0 , 0,<frxDS."RaceTimeStr">)]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 351.480520000000000000
          Width = 41.574830000000000000
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
            '[frxDS."HeatNum" #n%3.0f]')
          ParentFont = False
        end
        object frxDSDIFF: TfrxMemoView
          AllowVectorExport = True
          Left = 619.386210000000000000
          Width = 60.988250000000000000
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
          HideZeros = True
          Memo.UTF8W = (
            '[frxDS."DIFF"]')
          ParentFont = False
        end
        object frxDSPersonalBest: TfrxMemoView
          AllowVectorExport = True
          Left = 524.897960000000000000
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
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 370.393940000000000000
        Width = 718.110700000000000000
        object Date: TfrxMemoView
          AllowVectorExport = True
          Left = 473.332870000000000000
          Top = 0.389765000000000000
          Width = 243.444960000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed On: [Date]')
          ParentFont = False
        end
        object TotalPages: TfrxMemoView
          AllowVectorExport = True
          Left = 2.956865000000000000
          Top = 0.389765000000000000
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
      end
      object GroupHeader4: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 31.515770000000000000
        Top = 188.976500000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."MemberID"'
        KeepTogether = True
        OutlineText = 'frxDS."MemberID"'
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Top = 4.000000000000000000
          Width = 718.110700000000000000
          Height = 22.677180000000000000
          Fill.BackColor = cl3DLight
          Fill.ForeColor = clNone
          Frame.Color = clNone
          Frame.Typ = []
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 5.000000000000000000
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
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 351.480520000000000000
          Top = 5.000000000000000000
          Width = 41.574830000000000000
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
            'Heat')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 393.055350000000000000
          Top = 5.000000000000000000
          Width = 37.795300000000000000
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
            'Lane')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 434.189240000000000000
          Top = 5.000000000000000000
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
          Left = 615.606680000000000000
          Top = 5.000000000000000000
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
          Left = 524.897960000000000000
          Top = 5.000000000000000000
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
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 4.118120000000000000
        Top = 306.141930000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SessionID'
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @SID AS INT'
      ''
      'SET @SID = :SID;'
      ''
      'SELECT Member.MemberID'
      #9',dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTimeStr'
      #9',dbo.SwimTimeToString(Entrant.TimeToBeat) AS TimeToBeatStr'
      
        #9',dbo.SwimTimeToString([Entrant].[PersonalBest]) AS PersonalBest' +
        'Str'
      '/*'#9',CASE '
      #9#9'WHEN dbo.SwimTimeToMilliseconds([Entrant].[PersonalBest]) = 0'
      #9#9#9'THEN NULL'
      #9#9'WHEN dbo.SwimTimeToMilliseconds([Entrant].[RaceTime]) = 0'
      #9#9#9'THEN NULL'
      
        #9#9'ELSE DATEDIFF(millisecond, Entrant.RaceTime, Entrant.PersonalB' +
        'est) / 1000.0'
      #9#9'END AS DIFF'
      '*/                '#9
      '        ,CASE '
      
        '        WHEN dbo.RaceTimeDIFF(Entrant.RaceTime, Entrant.Personal' +
        'Best) = 0 THEN '#39#39
      
        '        ELSE FORMAT(dbo.RaceTimeDIFF(Entrant.RaceTime, Entrant.P' +
        'ersonalBest), '#39'N2'#39')'
      '        END AS DIFF '
      #9',Session.SessionStart'
      #9',Session.SessionID'
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
      '        ,Event.Caption AS cEventDetails'
      #9',HeatIndividual.HeatNum'
      #9',Stroke.Caption AS cStroke'
      #9',Distance.Caption AS cDistance'
      #9',Entrant.Lane'
      #9',Entrant.IsDisqualified'
      #9',Entrant.IsScratched'
      #9',SwimClub.NickName'
      #9',SwimClub.Caption AS cSwimClub'
      #9',Entrant.RaceTime'
      #9',Entrant.PersonalBest'
      #9',Entrant.TimeToBeat'
      'FROM Member'
      'INNER JOIN Entrant ON Entrant.MemberID = Member.MemberID'
      
        'INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.Hea' +
        'tID'
      'INNER JOIN Event ON HeatIndividual.EventID = Event.EventID'
      'INNER JOIN Session ON Event.SessionID = Session.SessionID'
      'INNER JOIN SwimClub ON Session.SwimClubID = SwimClub.SwimClubID'
      'INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      'INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      'WHERE (Session.SessionID = @SID)'
      'ORDER BY Member.LastName'
      #9',Member.FirstName'
      #9',Distance.DistanceID'
      '')
    Left = 160
    Top = 272
    ParamData = <
      item
        Name = 'SID'
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
    FieldAliases.Strings = (
      'MemberID=MemberID'
      'RaceTimeStr=RaceTimeStr'
      'TimeToBeatStr=TimeToBeatStr'
      'PersonalBestStr=PersonalBestStr'
      'DIFF=DIFF'
      'SessionStart=SessionStart'
      'SessionID=SessionID'
      'FNAME=FNAME'
      'EventID=EventID'
      'EventNum=EventNum'
      'cEventDetails=cEventDetails'
      'HeatNum=HeatNum'
      'cStroke=cStroke'
      'cDistance=cDistance'
      'Lane=Lane'
      'IsDisqualified=IsDisqualified'
      'IsScratched=IsScratched'
      'NickName=NickName'
      'cSwimClub=cSwimClub'
      'RaceTime=RaceTime'
      'PersonalBest=PersonalBest'
      'TimeToBeat=TimeToBeat')
    DataSet = qryReport
    BCDToCurrency = False
    Left = 64
    Top = 272
  end
end
