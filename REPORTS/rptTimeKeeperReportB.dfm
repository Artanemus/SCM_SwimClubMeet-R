object TimeKeeperReportB: TTimeKeeperReportB
  Height = 549
  Width = 442
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SessionID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Event'
    UpdateOptions.KeyFields = 'FNAME'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @HeatID AS INT'
      'DECLARE @EventTypeID AS integer;'
      ''
      'SET @HeatID = :HEATID'
      'SET @EventTypeID ='
      '('
      '    SELECT EventTypeID'
      '    FROM [HeatIndividual]'
      '        INNER JOIN [Event]'
      '            ON [HeatIndividual].EventID = [Event].EventID'
      '        INNER JOIN Distance'
      '            ON [Event].DistanceID = Distance.DistanceID'
      '    WHERE [HeatIndividual].HeatID = @HeatID'
      ');'
      ''
      'IF @EventTypeID = 1'
      'BEGIN'
      '    SELECT Event.EventID'
      '         , Event.Caption AS cEvent'
      '         , Distance.Caption AS cDistance'
      '         , Stroke.Caption AS cStroke'
      '         , HeatIndividual.HeatNum'
      '         , HeatIndividual.HeatID'
      '         , Entrant.Lane'
      
        '         , CONCAT(Member.FirstName, '#39' '#39', UPPER(Member.LastName))' +
        ' AS FNAME'
      #9'     , '#39#39' AS TeamName'
      '         , 0 AS TeamNameID'
      '         , CASE CAST([Entrant].[PersonalBest] AS DATETIME)'
      '               WHEN NULL THEN'
      '                   '#39#39
      '               WHEN 0 THEN'
      '                   '#39#39
      '               ELSE'
      
        '                   FORMAT(CAST([Entrant].[PersonalBest] AS DATET' +
        'IME), '#39'mm:ss.fff'#39')'
      '           END AS PersonalBest'
      '         , Event.EventNum'
      '         , Event.SessionID'
      '    FROM Event'
      '        INNER JOIN Stroke'
      '            ON Event.StrokeID = Stroke.StrokeID'
      '        INNER JOIN Distance'
      '            ON Event.DistanceID = Distance.DistanceID'
      '        INNER JOIN HeatIndividual'
      '            ON HeatIndividual.EventID = Event.EventID'
      '        INNER JOIN Entrant'
      '            ON Entrant.HeatID = HeatIndividual.HeatID'
      '        LEFT JOIN Member'
      '            ON Entrant.MemberID = Member.MemberID'
      '    WHERE HeatIndividual.HeatID = @HeatID'
      '    ORDER BY Event.EventNum'
      '           , HeatIndividual.HeatNum'
      '           , Entrant.Lane;'
      'END'
      'ELSE'
      'BEGIN'
      '    SELECT Event.EventID'
      '         , Event.Caption AS cEvent'
      '         , Distance.Caption AS cDistance'
      '         , Stroke.Caption AS cStroke'
      '         , HeatIndividual.HeatNum'
      '         , HeatIndividual.HeatID'
      '         , Team.Lane'
      
        '         , CONCAT('#39'(#'#39', TeamEntrant.Lane, '#39') '#39', Member.FirstName' +
        ', '#39' '#39', UPPER(Member.LastName)) AS FNAME'
      '         , TeamName.Caption AS TeamName'
      '         , TeamName.TeamNameID'
      '         , CASE CAST([TeamEntrant].[PersonalBest] AS DATETIME)'
      '               WHEN NULL THEN'
      '                   '#39#39
      '               WHEN 0 THEN'
      '                   '#39#39
      '               ELSE'
      
        '                   FORMAT(CAST([TeamEntrant].[PersonalBest] AS D' +
        'ATETIME), '#39'mm:ss.fff'#39')'
      '           END AS PersonalBest'
      '         , Event.EventNum'
      '         , Event.SessionID'
      '    FROM [Event]'
      '        INNER JOIN Stroke'
      '            ON Event.StrokeID = Stroke.StrokeID'
      '        INNER JOIN Distance'
      '            ON Event.DistanceID = Distance.DistanceID'
      '        INNER JOIN HeatIndividual'
      '            ON HeatIndividual.EventID = Event.EventID'
      '        INNER JOIN Team'
      '            ON HeatIndividual.HeatID = Team.HeatID'
      '        INNER JOIN TeamEntrant'
      '            ON Team.TeamID = TeamEntrant.TeamID'
      '        LEFT JOIN TeamName'
      '            ON Team.TeamNameID = TeamName.TeamNameID'
      '        LEFT JOIN Member'
      '            ON TeamEntrant.MemberID = Member.MemberID'
      '    WHERE HeatIndividual.HeatID = @HeatID'
      '          AND Team.TeamNameID IS NOT NULL'
      '          AND TeamEntrant.MemberID IS NOT NULL'
      '    ORDER BY Event.EventNum'
      '           , HeatIndividual.HeatNum'
      '           , Team.Lane'
      '           , TeamEntrant.Lane;'
      'END')
    Left = 160
    Top = 328
    ParamData = <
      item
        Name = 'HEATID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 276
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
      'EventID=EventID'
      'cEvent=cEvent'
      'cDistance=cDistance'
      'cStroke=cStroke'
      'HeatNum=HeatNum'
      'HeatID=HeatID'
      'Lane=Lane'
      'FNAME=FNAME'
      'TeamName=TeamName'
      'TeamNameID=TeamNameID'
      'PersonalBest=PersonalBest'
      'EventNum=EventNum'
      'SessionID=SessionID')
    DataSet = qryReport
    BCDToCurrency = False
    Left = 272
    Top = 328
  end
  object qryClubInfoRpt: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SwimClubID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'IF @SwimClubID IS NULL'
      '    SET @SwimClubID = 1;'
      ''
      'SELECT SwimClub.[SwimClubID]'
      '     , [NickName]'
      '     , SwimClub.[Caption] AS SwimClubName'
      '     , [NumOfLanes]'
      '     , [LenOfPool]'
      '     , [StartOfSwimSeason]'
      '     --,[PoolTypeID]'
      '     --,[SwimClubTypeID]'
      '     , [Session].[Caption] AS SessionTitle'
      '     , [SessionStart]'
      'FROM SwimClub'
      '    INNER JOIN Session'
      '        ON SwimClub.SwimClubID = [Session].[SwimClubID]'
      'WHERE SwimClub.[SwimClubID] = @SwimClubID;')
    Left = 160
    Top = 408
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object frxClubInfo: TfrxDBDataset
    UserName = 'frxClubInfo'
    CloseDataSource = False
    DataSet = qryClubInfoRpt
    BCDToCurrency = False
    Left = 272
    Top = 408
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
    ReportOptions.LastChange = 43480.811662002300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure GroupHeader3OnAfterCalcHeight(Sender: TfrxComponent);'
      'begin'
      '  if  <frxDS."TeamNameID"> = 0 then      '
      '  begin'
      '      GroupHeader3.Height := 0.0;'
      
        '      // hide all frx components in bar                         ' +
        '                                                                ' +
        '                                                                ' +
        '  '
      '      Memo7.Visible := false;'
      
        '      Memo9.Visible := false;                                   ' +
        '                     '
      
        '      Memo8.Visible := false;                                   ' +
        '                     '
      '      frxDSTeamName.Visible := false;'
      
        '      Line3.Visible := false;                                   ' +
        '                     '
      '  end;'
      'end;'
      ''
      'procedure frxDSLaneOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if  <frxDS."TeamNameID"> = 0 then      '
      '    TfrxMemoView(Sender).Visible := true '
      '  else '
      
        '  // hide the lane number - this is displayed in GroupHeader3   ' +
        '                                                                ' +
        '                                                              '
      '    TfrxMemoView(Sender).Visible := false;'
      'end;'
      ''
      ''
      'procedure Line1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if  <frxDS."TeamNameID"> = 0 then      '
      '    TfrxMemoView(Sender).Visible := true '
      '  else'
      
        '// hide the dashed line - not needed here.                      ' +
        '                                                                ' +
        '          '
      '    TfrxMemoView(Sender).Visible := false;'
      'end;'
      ''
      'procedure Line2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if  <frxDS."TeamNameID"> = 0 then      '
      '    TfrxMemoView(Sender).Visible := true '
      '  else'
      
        '// hide the dashed line - not needed here.                      ' +
        '                                                                ' +
        '          '
      '    TfrxMemoView(Sender).Visible := false;'
      'end;'
      '  '
      'begin'
      ''
      'end.')
    OnPrintReport = frxReport1PrintReport
    Left = 312
    Top = 40
    Datasets = <
      item
        DataSet = frxClubInfo
        DataSetName = 'frxClubInfo'
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
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
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
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 404.409710000000000000
        Width = 718.110700000000000000
        object TotalPages: TfrxMemoView
          AllowVectorExport = True
          Left = 266.456865000000000000
          Top = 1.889765000000000000
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
          Top = 1.889765000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed On: [Date]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 0.645640000000000000
        Top = 275.905690000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."Lane"'
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 45.252010000000000000
        Top = 298.582870000000000000
        Width = 718.110700000000000000
        DataSet = frxDSReport
        DataSetName = 'frxDS'
        RowCount = 0
        object frxDSLane: TfrxMemoView
          AllowVectorExport = True
          Left = 15.118120000000000000
          Top = 1.779530000000000000
          Width = 49.133890000000000000
          Height = 34.015770000000000000
          OnBeforePrint = 'frxDSLaneOnBeforePrint'
          DataField = 'Lane'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."Lane"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDSFNAME: TfrxMemoView
          AllowVectorExport = True
          Left = 68.031540000000000000
          Top = 5.779530000000000000
          Width = 215.433210000000000000
          Height = 26.456710000000000000
          DataField = 'FNAME'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FNAME"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDSTime: TfrxMemoView
          AllowVectorExport = True
          Left = 287.244280000000000000
          Top = 1.779530000000000000
          Width = 232.696970000000000000
          Height = 40.295300000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 2.000000000000000000
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDSPersonalBest: TfrxMemoView
          AllowVectorExport = True
          Left = 529.913730000000000000
          Top = 6.779530000000000000
          Width = 83.149660000000000000
          Height = 26.456710000000000000
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
            '[frxDS."PersonalBest"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDSIsDisqualified: TfrxMemoView
          AllowVectorExport = True
          Left = 620.842920000000000000
          Top = 1.779530000000000000
          Width = 81.413420000000000000
          Height = 41.574830000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          DisplayFormat.Kind = fkBoolean
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 2.000000000000000000
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 44.354360000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object FDQuery1cSwimClub: TfrxMemoView
          AllowVectorExport = True
          Width = 400.630180000000000000
          Height = 30.236240000000000000
          AutoWidth = True
          DataField = 'SwimClubName'
          DataSet = frxClubInfo
          DataSetName = 'frxClubInfo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxClubInfo."SwimClubName"]')
          ParentFont = False
        end
        object FDQuery1NickName: TfrxMemoView
          AllowVectorExport = True
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'NickName'
          DataSet = frxClubInfo
          DataSetName = 'frxClubInfo'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxClubInfo."NickName"]')
        end
        object FDQuery1SessionStart: TfrxMemoView
          AllowVectorExport = True
          Left = 417.236550000000000000
          Top = 22.677180000000000000
          Width = 297.094620000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSet = frxClubInfo
          DataSetName = 'frxClubInfo'
          DisplayFormat.FormatStr = 'mmmm dd, yyyy, hh:mm am/pm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              'Session Date : [frxClubInfo."SessionStart" #d DDD dd MMM YYYY HH' +
              ':MM AM/PM]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 53.677180000000000000
        Top = 124.724490000000000000
        Width = 718.110700000000000000
        object frxDScDistance: TfrxMemoView
          AllowVectorExport = True
          Left = 2.500000000000000000
          Top = 1.074830000000000000
          Width = 336.476500000000000000
          Height = 24.397650000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            
              'Event: [frxDS."EventNum"]  Heat: [frxDS."HeatNum"] - [frxDS."cDi' +
              'stance"] [frxDS."cStroke"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object frxDScEvent: TfrxMemoView
          AllowVectorExport = True
          Left = 344.476500000000000000
          Top = 1.354360000000000000
          Width = 372.130180000000000000
          Height = 18.897650000000000000
          DataField = 'cEvent'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDS."cEvent"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 13.118120000000000000
          Top = 29.488250000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Lane')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 69.811070000000000000
          Top = 29.488250000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Entrant')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 529.134200000000000000
          Top = 29.488250000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Personal Best')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 618.842920000000000000
          Top = 29.488250000000000000
          Width = 82.413420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DCODE')
          ParentFont = False
          VAlign = vaBottom
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = 3.500000000000000000
          Top = 50.716450000000000000
          Width = 710.551640000000000000
          OnBeforePrint = 'Line2OnBeforePrint'
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 54.177180000000000000
        Top = 200.315090000000000000
        Width = 718.110700000000000000
        OnAfterCalcHeight = 'GroupHeader3OnAfterCalcHeight'
        Condition = 'frxDS."TeamNameID"'
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 5.500000000000000000
          Top = 9.889610000000000000
          Width = 45.901670000000000000
          Height = 37.795300000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 8.000000000000000000
          Top = 14.389610000000000000
          Width = 39.456710000000000000
          Height = 27.397650000000000000
          DataField = 'Lane'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."Lane"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 55.000000000000000000
          Top = 10.118120000000000000
          Width = 166.401670000000000000
          Height = 37.795300000000000000
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object frxDSTeamName: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 224.000000000000000000
          Top = 9.125850000000000000
          Width = 236.059060000000000000
          Height = 37.897650000000000000
          DataField = 'TeamName'
          DataSet = frxDSReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."TeamName"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          AllowVectorExport = True
          Left = 3.000000000000000000
          Top = 4.125850000000000000
          Width = 710.551640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
