object MarshallReportB: TMarshallReportB
  Height = 450
  Width = 442
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
    ReportOptions.LastChange = 45214.562654930600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure GroupHeader3OnAfterCalcHeight(Sender: TfrxComponent);'
      'begin'
      '    If  ( <frxDS."TeamNameID"> = 0) then'
      '    begin                '
      '      GroupHeader3.Height := 0.0;'
      
        '      // clipping not working - perform manually                ' +
        '                                                                ' +
        '            '
      '      Memo5.Visible := false;'
      
        '      //Memo4.Visible := false;                                 ' +
        '                       '
      '      Memo1.Visible := false;'
      '      Memo8.Visible := false;'
      
        '     // Memo9.Visible := false;                                 ' +
        '                       '
      '      frxDSTeamName.Visible := false;'
      '    end;              '
      'end;'
      ''
      ''
      'procedure frxDSLaneOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    If  ( <frxDS."TeamNameID"> = 0) then'
      
        '    TfrxMemoView(Sender).Visible := true else TfrxMemoView(Sende' +
        'r).Visible := false;                                            ' +
        '                                                                ' +
        '      '
      'end;'
      ''
      'procedure frxDSFNAMEOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    If  ( <frxDS."TeamNameID"> <> 0) then'
      
        '      TfrxMemoView(Sender).Left := frxDSLane.Left;              ' +
        '                                                      '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnPrintReport = frxReport1PrintReport
    Left = 272
    Top = 40
    Datasets = <
      item
        DataSet = frxClubInfo
        DataSetName = 'frxClubInfo'
      end
      item
        DataSet = frxSessionReport
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
      ColumnWidth = 95.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 64.177180000000000000
        Top = 245.669450000000000000
        Width = 718.110700000000000000
        OnAfterCalcHeight = 'GroupHeader3OnAfterCalcHeight'
        Condition = 'frxDS."TeamNameID"'
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 8.000000000000000000
          Top = 12.389610000000000000
          Width = 115.956710000000000000
          Height = 27.397650000000000000
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'LANE [frxDS."Lane" #n00]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDSTeamName: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 373.500000000000000000
          Top = 7.000000000000000000
          Width = 335.559060000000000000
          Height = 37.897650000000000000
          DataSet = frxSessionReport
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
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 134.000000000000000000
          Top = 8.118120000000000000
          Width = 232.818897637795000000
          Height = 37.795300000000000000
          DataSet = frxSessionReport
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
      end
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
          Left = 510.236550000000000000
          Top = 22.677180000000000000
          Width = 204.094620000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSet = frxClubInfo
          DataSetName = 'frxClubInfo'
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
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = cl3DLight
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 36.515770000000000000
        ParentFont = False
        Top = 124.724490000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."EventID"'
        KeepTogether = True
        object Shape2: TfrxShapeView
          AllowVectorExport = True
          Left = 1.500000000000000000
          Top = 3.000000000000000000
          Width = 119.000000000000000000
          Height = 29.720470000000000000
          Frame.Typ = []
        end
        object frxDSEventNumStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 6.500000000000000000
          Top = 5.500000000000000000
          Width = 112.130180000000000000
          Height = 27.397650000000000000
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'EVENT [frxDS."EventNumStr" #n00]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 122.956710000000000000
          Top = 9.224490000000000000
          Width = 256.842610000000000000
          Height = 18.897650000000000000
          DataField = 'cDistanceStroke'
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."cDistanceStroke"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 435.051330000000000000
          Top = 9.224490000000000000
          Width = 274.937230000000000000
          Height = 18.897650000000000000
          DataField = 'cEvent'
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDS."cEvent"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 41.574830000000000000
        Top = 332.598640000000000000
        Width = 718.110700000000000000
        Columns = 2
        ColumnWidth = 351.496062992126000000
        ColumnGap = 7.559055118110240000
        DataSet = frxSessionReport
        DataSetName = 'frxDS'
        RowCount = 0
        object frxDSLane: TfrxMemoView
          AllowVectorExport = True
          Left = 150.842610000000000000
          Top = 12.279530000000000000
          Width = 26.456710000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'frxDSLaneOnBeforePrint'
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."Lane" #n00]')
          ParentFont = False
        end
        object frxDSFNAME: TfrxMemoView
          AllowVectorExport = True
          Left = 179.137910000000000000
          Top = 12.779530000000000000
          Width = 169.299320000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'frxDSFNAMEOnBeforePrint'
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            ' [frxDS."FNAME"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 0.779530000000000000
          Top = 2.000000000000000000
          Width = 147.401670000000000000
          Height = 37.795300000000000000
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 2.000000000000000000
          Frame.LeftLine.Width = 1.000000000000000000
          Frame.TopLine.Width = 1.000000000000000000
          Frame.RightLine.Width = 1.000000000000000000
          Frame.BottomLine.Width = 1.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 4.000000000000000000
          Top = 26.858070000000000000
          Width = 138.988250000000000000
          Height = 11.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Split')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 468.661720000000000000
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
          Top = 1.889765000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed On: [Date] [Time]')
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 35.854330710000000000
        Top = 185.196970000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."HeatNum"'
        KeepTogether = True
        object frxDSHeatCount: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 8.779530000000000000
          Width = 176.826840000000000000
          Height = 19.897650000000000000
          DataSet = frxSessionReport
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'HEAT [frxDS."HeatNum" #n%2.0f]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = 4.000000000000000000
          Top = 32.303030000000000000
          Width = 702.500000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 11.338590000000000000
        Top = 396.850650000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object qryReport: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'HeatNum'
    Connection = SCM.scmConnection
    UpdateOptions.KeyFields = 'HeatID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID as integer;'
      'DECLARE @EventTypeID as integer;'
      ''
      'SET @EventID = :EVENTID;'
      'SET @EventTypeID = (SELECT EventTypeID FROM [EVENT] '
      
        '    INNER JOIN Distance ON [Event].DistanceID = Distance.Distanc' +
        'eID'
      '    WHERE EventID = @EventID);'
      ''
      'IF @EventTypeID = 1     '
      '    BEGIN'
      '        SELECT'
      '        Heat.HeatID,'
      '        Heat.HeatNum,'
      
        '        Concat (Distance.Caption, '#39' '#39', Stroke.Caption) AS cDista' +
        'nceStroke,'
      '        Event.EventNum,'
      '        FORMAT(Event.EventNum, '#39'00'#39') AS EventNumStr,'
      '        Event.Caption AS cEvent,'
      '        Entrant.Lane,'
      
        '        Concat(Member.FirstName, '#39' '#39', Upper(Member.LastName)) AS' +
        ' FNAME,'
      '        '#39#39' AS TeamName,'
      '        0 AS TeamNameID,'
      '        Heat.EventID'
      '        FROM'
      '        Heat'
      
        '        INNER JOIN Event ON Heat.EventID = Event.Event' +
        'ID'
      
        '        INNER JOIN Distance ON Event.DistanceID = Distance.Dista' +
        'nceID'
      '        INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      
        '        INNER JOIN Entrant ON Entrant.HeatID = Heat.He' +
        'atID'
      '        LEFT JOIN Member ON Entrant.MemberID = Member.MemberID'
      '        WHERE'
      '        Heat.EventID = @EventID'
      '        ORDER BY'
      '        Heat.HeatNum,'
      '        Entrant.Lane;'
      '  END'
      ''
      '  ELSE '
      '    BEGIN'
      '        SELECT'
      '        Heat.HeatID,'
      '        Heat.HeatNum,'
      
        '        Concat (Distance.Caption, '#39' RELAY '#39', Stroke.Caption) AS ' +
        'cDistanceStroke,'
      '        Event.EventNum,'
      '        FORMAT(Event.EventNum, '#39'00'#39') AS EventNumStr,'
      '        Event.Caption AS cEvent,'
      '        Team.Lane,'
      
        '        Concat('#39'(#'#39',TeamEntrant.Lane,'#39') '#39',Member.FirstName, '#39' '#39',' +
        ' Upper(Member.LastName)) AS FNAME,'
      '        TeamName.Caption AS TeamName,'
      '        TeamName.TeamNameID,'
      '        Heat.EventID'
      '        FROM'
      '        Heat'
      
        '        INNER JOIN Event ON Heat.EventID = Event.Event' +
        'ID'
      
        '        INNER JOIN Distance ON Event.DistanceID = Distance.Dista' +
        'nceID'
      '        INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      '        INNER JOIN Team ON Heat.HeatID = Team.HeatID'
      
        '        INNER JOIN TeamEntrant ON Team.TeamID = TeamEntrant.Team' +
        'ID'
      
        '        LEFT JOIN TeamName ON Team.TeamNameID = TeamName.TeamNam' +
        'eID'
      
        '        LEFT JOIN Member ON TeamEntrant.MemberID = Member.Member' +
        'ID'
      '        WHERE'
      
        '        Heat.EventID = @EventID AND Team.TeamNameID IS' +
        ' NOT NULL AND TeamEntrant.MemberID IS NOT NULL'
      '        ORDER BY'
      '        Heat.HeatNum,'
      '        Team.Lane,'
      '        TeamEntrant.Lane;'
      '    END'
      ''
      ''
      ''
      ''
      '')
    Left = 136
    Top = 280
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 65
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
  object frxSessionReport: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    FieldAliases.Strings = (
      'HeatID=HeatID'
      'HeatNum=HeatNum'
      'cDistanceStroke=cDistanceStroke'
      'EventNum=EventNum'
      'EventNumStr=EventNumStr'
      'cEvent=cEvent'
      'Lane=Lane'
      'FNAME=FNAME'
      'TeamName=TeamName'
      'TeamNameID=TeamNameID'
      'EventID=EventID')
    DataSet = qryReport
    BCDToCurrency = False
    Left = 264
    Top = 280
  end
  object qryClubInfoRpt: TFDQuery
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
    Left = 136
    Top = 368
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
    Left = 264
    Top = 368
  end
end
