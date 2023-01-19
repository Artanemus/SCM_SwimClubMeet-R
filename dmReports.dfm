object RPTS: TRPTS
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 762
  Width = 845
  object qryMemABS: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxMemberScore'
        Fields = 'GenderID;TotalScore;MemberID'
        DescFields = 'GenderID;TotalScore'
        Options = [soDescNullLast]
      end>
    IndexName = 'idxMemberScore'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.KeyFields = 'EntrantID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      'DECLARE @DoEvent AS BIT;'
      'DECLARE @DoLockedSession AS BIT;'
      ''
      ''
      'SET @SDate = :DTSTART; --'#39'2022-01-27'#39'; -- '
      'SET @EDate = :DTEND; -- '#39'2022-01-28'#39'; -- '
      'SET @DoEvent = :DOEVENT;'
      'SET @DoLockedSession = :DOLOCKEDSESSION;'
      ''
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp1'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp1;'
      ''
      '-- CALCULATE PLACE'
      'SELECT Entrant.MemberID,'
      '       Entrant.EntrantID,'
      '       [Event].StrokeID,'
      '       [Event].DistanceID,'
      '       CASE @DoEvent'
      '           WHEN 1 THEN'
      
        '               dbo.ABSEventPlace([Event].[EventID], Entrant.Memb' +
        'erID)'
      '           WHEN 0 THEN'
      
        '               dbo.ABSHeatPlace([HeatIndividual].[HeatID], Entra' +
        'nt.MemberID)'
      '           ELSE'
      '               0'
      '       END AS Place'
      'INTO #tmp1'
      'FROM Entrant'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN [Event]'
      '        ON HeatIndividual.EventID = [Event].EventID'
      '    INNER JOIN [Session]'
      '        ON [Event].SessionID = Session.SessionID'
      'WHERE [Session].SessionStart >= @SDate'
      '      AND [Session].SessionStart <= @EDate'
      '      AND Entrant.MemberID IS NOT NULL'
      '      AND [Session].SessionStatusID <= (CASE'
      
        '                                            WHEN @DoLockedSessio' +
        'n = 1 THEN'
      '                                                2'
      '                                            ELSE'
      '                                                1'
      '                                        END'
      '                                       );'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp2'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp2;'
      ''
      '-- GATHER UP ALL THE EVENT TYPES AND CALCULATE A SUBTOTAL '
      'SELECT #tmp1.StrokeID,'
      '       #tmp1.DistanceID,'
      '       #tmp1.MemberID,'
      
        '       SUM(dbo.EntrantScore(#tmp1.EntrantID, ScorePoints.Points)' +
        ') AS SubTotal'
      'INTO #tmp2'
      'FROM #tmp1'
      '    LEFT JOIN ScorePoints'
      '        ON #tmp1.Place = ScorePoints.Place'
      'GROUP BY #tmp1.MemberID,'
      '         #tmp1.DistanceID,'
      '         #tmp1.StrokeID;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp3'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp3;'
      ''
      '-- CALCULATE TOTAL-SCORE'
      'SELECT #tmp2.MemberID,'
      '       SUM(#tmp2.SubTotal) AS TotalScore'
      'INTO #tmp3'
      'FROM #tmp2'
      'GROUP BY #tmp2.MemberID;'
      ''
      '-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT '
      'SELECT #tmp2.MemberID,'
      '       #tmp2.StrokeID,'
      '       #tmp2.DistanceID,'
      '       #tmp2.SubTotal,'
      '       #tmp3.TotalScore,'
      '       Member.GenderID,'
      '       Gender.Caption AS GenderStr,'
      
        '       SUBSTRING(CONCAT(FirstName, '#39' '#39', UPPER(LastName)), 0, 50)' +
        ' AS MemberNameStr,'
      
        '       SUBSTRING(CONCAT(Distance.Caption, '#39' '#39', Stroke.Caption), ' +
        '0, 50) AS DistStrokeStr'
      'FROM #tmp2'
      '    INNER JOIN #tmp3'
      '        ON #tmp2.MemberID = #tmp3.MemberID'
      '    INNER JOIN Member'
      '        ON #tmp2.MemberID = Member.MemberID'
      '    INNER JOIN Stroke'
      '        ON #tmp2.StrokeID = Stroke.StrokeID'
      '    INNER JOIN Distance'
      '        ON #tmp2.DistanceID = Distance.DistanceID'
      '    INNER JOIN Gender'
      '        ON Member.GenderID = Gender.GenderID'
      '-- NOTE: final sort index applied in FireDAC        '
      'ORDER BY MemberID DESC;'
      ''
      'DROP TABLE #tmp3;'
      'DROP TABLE #tmp2;'
      'DROP TABLE #tmp1;'
      ''
      ''
      ''
      '')
    Left = 520
    Top = 139
    ParamData = <
      item
        Name = 'DTSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DTEND'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44589d
      end
      item
        Name = 'DOEVENT'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'DOLOCKEDSESSION'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end>
  end
  object qryHouseABS: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxHouse'
        Fields = 'HouseID;HouseScore'
        DescFields = 'HouseID'
      end>
    IndexName = 'idxHouse'
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      'DECLARE @DoEvent AS BIT;'
      'DECLARE @DoLockedSession AS BIT;'
      ''
      'SET @SDate = :DTSTART; --'#39'2022-01-27'#39'; -- '
      'SET @EDate = :DTEND; --'#39'2022-01-28'#39'; -- '
      'SET @DoEvent = :DOEVENT;'
      'SET @DoLockedSession = :DOLOCKEDSESSION;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp1'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp1;'
      ''
      '-- build an ordered list of entrants with placings'
      '-- MEMBERS THAT ARE SCRATCH OR DISQUALIFIED score zero'
      '-- by the scalar function ...'
      'SELECT Entrant.MemberID,'
      '       Entrant.EntrantID,'
      '       CASE @DoEvent'
      '           WHEN 1 THEN'
      
        '               dbo.ABSEventPlace([Event].[EventID], Entrant.Memb' +
        'erID)'
      '           WHEN 0 THEN'
      
        '               dbo.ABSHeatPlace([HeatIndividual].[HeatID], Entra' +
        'nt.MemberID)'
      '           ELSE'
      '               0'
      '       END AS Place'
      'INTO #tmp1'
      'FROM Entrant'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN Event'
      '        ON HeatIndividual.EventID = Event.EventID'
      '    INNER JOIN [Session]'
      '        ON Event.SessionID = [Session].SessionID'
      'WHERE [Session].SessionStart >= @SDate'
      '      AND [Session].SessionStart <= @EDate'
      '      AND Entrant.MemberID IS NOT NULL'
      '      AND [Session].SessionStatusID <= (CASE'
      
        '                                           WHEN @DoLockedSession' +
        ' = 1 THEN'
      '                                               2'
      '                                           ELSE'
      '                                               1'
      '                                       END);      '
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp2'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp2;'
      ''
      '-- Builds a table with members idS'
      '-- + a score for each placing....'
      'SELECT #tmp1.MemberID,'
      
        '       dbo.EntrantScore(#tmp1.EntrantID, ScorePoints.Points) AS ' +
        'Points'
      'INTO #tmp2'
      'FROM #tmp1'
      '    LEFT JOIN ScorePoints'
      '        ON #tmp1.Place = ScorePoints.Place'
      'ORDER BY MemberID ASC;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp3'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp3;'
      ''
      '-- Tot-up the member'#39's scores - grouped by House'
      'SELECT Member.HouseID,'
      '       SUM(#tmp2.Points) AS HouseScore'
      'INTO #tmp3'
      'FROM #tmp2'
      '    INNER JOIN Member'
      '        ON #tmp2.MemberID = Member.MemberID'
      'GROUP BY Member.HouseID;'
      ''
      '-- JOIN ALL THE BITS ON HOUSE - INTO A  SINGLE TABLE '
      '-- ready for reporting'
      'SELECT #tmp3.HouseID,'
      '       #tmp3.HouseScore,'
      '       House.Caption,'
      '       House.Motto,'
      '       House.Color,'
      '       House.LogoImg'
      'FROM #tmp3'
      '    INNER JOIN House'
      '        ON #tmp3.HouseID = House.HouseID'
      'ORDER BY #tmp3.HouseScore ASC;'
      ''
      'DROP TABLE #tmp3;'
      'DROP TABLE #tmp2;'
      'DROP TABLE #tmp1;'
      ''
      ''
      ''
      '')
    Left = 64
    Top = 128
    ParamData = <
      item
        Name = 'DTSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DTEND'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44589d
      end
      item
        Name = 'DOEVENT'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'DOLOCKEDSESSION'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end>
  end
  object frxMemABS: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43878.671749803200000000
    ReportOptions.LastChange = 44796.591145289300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}')
    Left = 688
    Top = 139
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = frxDSMemABS
        DataSetName = 'Detail'
      end>
    Variables = <
      item
        Name = ' LeaderBoard'
        Value = Null
      end
      item
        Name = 'IsModeABS'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '2),'#39'ABSOLUTE'#39','#39'DIVISION'#39')'
      end
      item
        Name = 'IsModeEVENT'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '3) ,'#39'EVENT'#39','#39'HEAT'#39')'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 277.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      EndlessHeight = True
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 77.335961670000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 6.666666670000000000
          Width = 294.803340000000000000
          Height = 30.236240000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 6.666666670000000000
          Top = 25.566945000000000000
          Width = 294.803340000000000000
          Height = 22.677180000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 703.871352960000000000
          Top = 2.244603710000000000
          Width = 331.653680000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeStr"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 450.942486670000000000
          Top = 2.223098330000000000
          Width = 143.622140000000000000
          Height = 46.021026660000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          GapY = -0.800000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTRANTS'
            'LEADERBOARD')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 705.741961670000000000
          Top = 25.566945000000000000
          Width = 329.137910000000000000
          Height = 22.677180000000000000
          DataField = 'ModeSubStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeSubStr"]')
          ParentFont = False
        end
        object dsHeaderRangeStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 5.955318340000000000
          Top = 42.879251670000000000
          Width = 1027.296846670000000000
          Height = 26.456710000000000000
          DataField = 'RangeStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsHeader."RangeStr"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 6.847711670000000000
          Top = 71.792671660000000000
          Width = 1028.032160000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 7.897650000000000000
        Top = 328.819110000000000000
        Width = 1046.929810000000000000
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 15268095
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 222.992270000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."MemberID"'
        KeepTogether = True
        object MembersName: TfrxMemoView
          AllowVectorExport = True
          Left = 76.149660000000000000
          Top = 1.889765000000000000
          Width = 393.071120000000000000
          Height = 26.456710000000000000
          DataField = 'MemberNameStr'
          DataSet = frxDSMemABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."MemberNameStr"]')
          ParentFont = False
        end
        object TotalPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 2.354360000000000000
          Top = 1.889765000000000000
          Width = 68.031540000000000000
          Height = 26.456710000000000000
          DataField = 'TotalScore'
          DataSet = frxDSMemABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            '[Detail."TotalScore"]')
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
        Height = 30.236240000000000000
        ParentFont = False
        Top = 275.905690000000000000
        Width = 1046.929810000000000000
        Columns = 6
        ColumnWidth = 162.519685039370000000
        DataSet = frxDSMemABS
        DataSetName = 'Detail'
        KeepTogether = True
        RowCount = 0
        object DistanceStroke: TfrxMemoView
          AllowVectorExport = True
          Left = 1.779530000000000000
          Top = 4.000000000000000000
          Width = 119.127396670000000000
          Height = 22.677180000000000000
          DataField = 'DistStrokeStr'
          DataSet = frxDSMemABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            '[Detail."DistStrokeStr"]')
          ParentFont = False
        end
        object frxDSPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 117.417440000000000000
          Top = 4.000000000000000000
          Width = 37.795300000000000000
          Height = 22.677180000000000000
          DataField = 'SubTotal'
          DataSet = frxDSMemABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Fill.Style = bsClear
          HAlign = haCenter
          Memo.UTF8W = (
            '[Detail."SubTotal"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 396.850650000000000000
        Width = 1046.929810000000000000
        object MemoH3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed on ')
          ParentFont = False
        end
        object PrintedOnDate: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object MemoH4: TfrxMemoView
          AllowVectorExport = True
          Left = 691.653990000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 42.010513330000000000
        Top = 158.740260000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."GenderID"'
        object frxDSEventCaption: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 0.666666660000000000
          Top = 9.000000000000000000
          Width = 396.073593340000000000
          Height = 30.236240000000000000
          DataField = 'GenderStr'
          DataSet = frxDSMemABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."GenderStr"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDSMemABS: TfrxDBDataset
    UserName = 'Detail'
    CloseDataSource = False
    DataSet = qryMemABS
    BCDToCurrency = False
    Left = 608
    Top = 139
  end
  object qryRptHeader: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SwimClubID AS INTEGER;'
      'DECLARE @RangeStr AS NVARCHAR(120);'
      'DECLARE @ModeStr AS NVARCHAR(50);'
      'DECLARE @ModeSubStr AS NVARCHAR(50);'
      ''
      'SET @SwimClubID = 1; -- :SWIMCLUBID'
      'SET @RangeStr = :RANGESTR;'
      'SET @ModeStr = :MODESTR;'
      'SET @ModeSubStr = :MODESUBSTR;'
      ''
      
        '-- Select rows from a Table or View '#39'[SwimClub]'#39' in schema '#39'[dbo' +
        ']'#39
      'SELECT SwimClubID,'
      '@RangeStr AS RangeStr,'
      '@ModeStr AS ModeStr,'
      '@ModeSubStr AS ModeSubStr,'
      '       SUBSTRING(Caption, 0, 50) AS ClubName,'
      '       SUBSTRING(NickName, 0, 50) AS ClubNickName,'
      
        '       FORMAT(StartOfSwimSeason, '#39'ddd dd MMM yyyy'#39') AS SeasonSta' +
        'rt'
      'FROM [dbo].[SwimClub]'
      'WHERE SwimClubID = @SwimClubID;')
    Left = 80
    Top = 32
    ParamData = <
      item
        Name = 'RANGESTR'
        DataType = ftString
        ParamType = ptInput
        Value = 'ERR'
      end
      item
        Name = 'MODESTR'
        DataType = ftString
        ParamType = ptInput
        Value = 'ERR'
      end
      item
        Name = 'MODESUBSTR'
        DataType = ftString
        ParamType = ptInput
        Value = 'ERR'
      end>
  end
  object frxDBDSRptHeader: TfrxDBDataset
    UserName = 'dsHeader'
    CloseDataSource = False
    DataSet = qryRptHeader
    BCDToCurrency = False
    Left = 200
    Top = 32
  end
  object DSHouseABS: TfrxDBDataset
    UserName = 'Detail'
    CloseDataSource = False
    DataSet = qryHouseABS
    BCDToCurrency = False
    Left = 136
    Top = 128
  end
  object frxHouseABS: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44076.451311944500000000
    ReportOptions.LastChange = 44091.577845381900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}')
    OnBeforePrint = frxHouseABSBeforePrint
    Left = 208
    Top = 128
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = DSHouseABS
        DataSetName = 'Detail'
      end>
    Variables = <
      item
        Name = ' LeaderBoard'
        Value = Null
      end
      item
        Name = 'IsModeABS'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '2),'#39'ABSOLUTE'#39','#39'DIVISION'#39')'
      end
      item
        Name = 'IsModeEVENT'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '3) ,'#39'EVENT'#39','#39'HEAT'#39')'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 277.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      EndlessHeight = True
      EndlessWidth = True
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 79.104978340000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object SCM_HeaderCaption: TfrxMemoView
          AllowVectorExport = True
          Left = 8.711348330000000000
          Top = 1.102350000000000000
          Width = 294.803340000000000000
          Height = 30.236240000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object SCM_HeaderNickName: TfrxMemoView
          AllowVectorExport = True
          Left = 8.711348330000000000
          Top = 26.669295000000000000
          Width = 294.803340000000000000
          Height = 22.677180000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
          ParentFont = False
        end
        object MemoH2: TfrxMemoView
          AllowVectorExport = True
          Left = 707.916034620000000000
          Top = 3.346953710000000000
          Width = 329.653680000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeStr"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 452.987168330000000000
          Top = 3.325448330000000000
          Width = 143.622140000000000000
          Height = 46.021026660000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          GapY = -0.800000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'HOUSE'
            'LEADERBOARD')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 707.786643330000000000
          Top = 26.669295000000000000
          Width = 329.137910000000000000
          Height = 22.677180000000000000
          DataField = 'ModeSubStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeSubStr"]')
          ParentFont = False
        end
        object dsHeaderRangeStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 8.000000000000000000
          Top = 43.981601670000000000
          Width = 1028.630180000000000000
          Height = 26.456710000000000000
          DataField = 'RangeStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsHeader."RangeStr"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 8.892393330000000000
          Top = 73.126005000000000000
          Width = 1028.032160000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 147.401670000000000000
        ParentFont = False
        Top = 196.535560000000000000
        Width = 1046.929810000000000000
        DataSet = DSHouseABS
        DataSetName = 'Detail'
        RowCount = 0
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 15.897650000000000000
          Width = 1012.914040000000000000
          Height = 113.385900000000000000
          Fill.BackColor = clBtnFace
          Frame.Typ = []
        end
        object Shape2: TfrxShapeView
          AllowVectorExport = True
          Left = 198.653680000000000000
          Top = 78.456710000000000000
          Width = 445.984540000000000000
          Height = 11.338590000000000000
          Curve = 4
          Fill.BackColor = cl3DLight
          Frame.Typ = []
          Shape = skRoundRectangle
        end
        object frxDSColor: TfrxMemoView
          AllowVectorExport = True
          Left = 213.763915000000000000
          Top = 26.338590000000000000
          Width = 408.189240000000000000
          Height = 49.133890000000000000
          DataField = 'Caption'
          DataSet = DSHouseABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -32
          Font.Name = 'Segoe UI Semibold'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."Caption"]')
          ParentFont = False
        end
        object frxDSTOT: TfrxMemoView
          Anchors = [fraTop, fraRight]
          AllowVectorExport = True
          Left = 621.064901850000000000
          Top = 26.338590000000000000
          Width = 395.864908150000000000
          Height = 90.708720000000000000
          AutoWidth = True
          DataSet = DSHouseABS
          DataSetName = 'Detail'
          DisplayFormat.FormatStr = '%2.1f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -64
          Font.Name = 'Segoe UI Semibold'
          Font.Style = []
          Frame.Typ = []
          Frame.Width = 2.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Detail."HouseScore"]')
          ParentFont = False
          WordWrap = False
        end
        object Picture1: TfrxPictureView
          AllowVectorExport = True
          Left = 33.677180000000000000
          Top = 1.338590000000000000
          Width = 164.409453700000000000
          Height = 145.637600000000000000
          OnBeforePrint = 'Picture1OnBeforePrint'
          DataField = 'LogoImg'
          DataSet = DSHouseABS
          DataSetName = 'Detail'
          Frame.Typ = []
          HightQuality = False
          Transparent = True
          TransparentColor = clWhite
        end
        object frxHouseABSEventMotto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 215.433210000000000000
          Top = 92.488250000000000000
          Width = 408.189240000000000000
          Height = 49.133890000000000000
          DataField = 'Motto'
          DataSet = DSHouseABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."Motto"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118120000000000000
        Top = 158.740260000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."HouseID"'
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 404.409710000000000000
        Width = 1046.929810000000000000
        object MemoH3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed on ')
          ParentFont = False
        end
        object PrintedOnDate: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object MemoH4: TfrxMemoView
          AllowVectorExport = True
          Left = 691.653990000000000000
          Width = 347.716760000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
        end
      end
    end
  end
  object qryMemREL: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Name = 'idxDivision'
        Fields = 'GenderID;AgeTo;ScoreDivisionID;TotalScore'
        DescFields = 'GenderID;AgeTo;TotalScore'
        Options = [soDescNullLast]
      end>
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SeedDate AS DATETIME;'
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      'DECLARE @DoEvent AS BIT;'
      'DECLARE @DoLockedSession AS BIT;'
      ''
      'SET @SeedDate = :AGESEEDDATE; --'#39'2021-08-01'#39'; --'
      'SET @SDate = :DTSTART; --'#39'2022-01-27'#39'; -- '
      'SET @EDate = :DTEND; --'#39'2022-01-28'#39'; -- '
      'SET @DoEvent = :DOEVENT;'
      'SET @DoLockedSession = :DOLOCKEDSESSION;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp4'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp4;'
      ''
      '-- build a list of divisions with it'#39's members'
      'SELECT ScoreDivisionID,'
      '       MemberID'
      'INTO #tmp4'
      'FROM ScoreDivision'
      '    LEFT JOIN Member'
      '        ON ScoreDivision.GenderID = Member.GenderID'
      'WHERE dbo.SwimmerAge(@SeedDate, member.DOB) >= AgeFrom'
      '      AND dbo.SwimmerAge(@SeedDate, member.DOB) <= AgeTo;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp1'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp1;'
      ''
      '-- CALCULATE PLACE'
      'SELECT ScoreDivisionID,'
      '       Entrant.MemberID,'
      '       Entrant.EntrantID,'
      '       [Event].StrokeID,'
      '       [Event].DistanceID,'
      '       CASE @DoEvent'
      '           WHEN 1 THEN'
      
        '               dbo.RELEventPlace([Event].[EventID], Entrant.Memb' +
        'erID, #tmp4.ScoreDivisionID, @SeedDate)'
      '           WHEN 0 THEN'
      
        '               dbo.RELHeatPlace([HeatIndividual].[HeatID], Entra' +
        'nt.MemberID, ScoreDivisionID, @SeedDate)'
      '           ELSE'
      '               0'
      '       END AS Place'
      'INTO #tmp1'
      'FROM #tmp4'
      '    INNER JOIN Entrant'
      '        ON #tmp4.MemberID = Entrant.MemberID'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN Event'
      '        ON HeatIndividual.EventID = [Event].EventID'
      '    INNER JOIN Session'
      '        ON Event.SessionID = Session.SessionID'
      'WHERE Session.SessionStart >= @SDate'
      '      AND Session.SessionStart <= @EDate'
      '      AND Entrant.MemberID IS NOT NULL'
      '      AND [Session].SessionStatusID <= (CASE'
      
        '                                           WHEN @DoLockedSession' +
        ' = 1 THEN'
      '                                               2'
      '                                           ELSE'
      '                                               1'
      '                                       END);'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp2'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp2;'
      ''
      '-- GATHER UP ALL THE EVENT TYPES AND CALCULATE A SUBTOTAL '
      'SELECT #tmp1.ScoreDivisionID,'
      '       #tmp1.MemberID,'
      '       #tmp1.DistanceID,'
      '       #tmp1.StrokeID,'
      
        '       SUM(dbo.EntrantScore(#tmp1.EntrantID, ScorePoints.Points)' +
        ') AS SubTotal'
      'INTO #tmp2'
      'FROM #tmp1'
      '    LEFT JOIN ScorePoints'
      '        ON #tmp1.Place = ScorePoints.Place'
      'GROUP BY #tmp1.ScoreDivisionID,'
      '         #tmp1.MemberID,'
      '         #tmp1.DistanceID,'
      '         #tmp1.StrokeID;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp3'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp3;'
      ''
      '-- CALCULATE TOTAL-SCORE'
      'SELECT #tmp2.ScoreDivisionID,'
      '       #tmp2.MemberID,'
      '       SUM(#tmp2.SubTotal) AS TotalScore'
      'INTO #tmp3'
      'FROM #tmp2'
      'GROUP BY #tmp2.ScoreDivisionID,'
      '         #tmp2.MemberID;'
      ''
      '-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT '
      'SELECT #tmp2.ScoreDivisionID,'
      '       #tmp2.MemberID,'
      '       #tmp2.DistanceID,'
      '       #tmp2.StrokeID,'
      '       #tmp3.TotalScore,'
      '       #tmp2.SubTotal,'
      
        '       SUBSTRING(CONCAT(FirstName, '#39' '#39', UPPER(LastName)), 0, 50)' +
        ' AS MemberNameStr,'
      
        '       SUBSTRING(CONCAT(Distance.Caption, '#39' '#39', Stroke.Caption), ' +
        '0, 50) AS DistStrokeStr,'
      '       ScoreDivision.Caption AS DivisionStr,'
      '       ScoreDivision.GenderID,'
      '       ScoreDivision.AgeTo,'
      '       Gender.Caption AS GenderStr'
      'FROM #tmp2'
      '    INNER JOIN #tmp3'
      '        ON #tmp2.ScoreDivisionID = #tmp3.ScoreDivisionID'
      '           AND #tmp2.MemberID = #tmp3.MemberID'
      '    INNER JOIN Member'
      '        ON #tmp2.MemberID = Member.MemberID'
      '    INNER JOIN Stroke'
      '        ON #tmp2.StrokeID = Stroke.StrokeID'
      '    INNER JOIN Distance'
      '        ON #tmp2.DistanceID = Distance.DistanceID'
      '    INNER JOIN ScoreDivision'
      '        ON #tmp2.ScoreDivisionID = ScoreDivision.ScoreDivisionID'
      '    INNER JOIN Gender'
      '        ON Member.GenderID = Gender.GenderID'
      '-- NOTE: final sort index applied in FireDAC '
      'ORDER BY #tmp2.MemberID;'
      ''
      'DROP TABLE #tmp3;'
      'DROP TABLE #tmp2;'
      'DROP TABLE #tmp1;'
      'DROP TABLE #tmp4;'
      ''
      ''
      ''
      '')
    Left = 520
    Top = 192
    ParamData = <
      item
        Name = 'AGESEEDDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44409d
      end
      item
        Name = 'DTSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DTEND'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44589d
      end
      item
        Name = 'DOEVENT'
        DataType = ftBoolean
        ParamType = ptInput
        Value = False
      end
      item
        Name = 'DOLOCKEDSESSION'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end>
  end
  object frxDSMemREL: TfrxDBDataset
    UserName = 'Detail'
    CloseDataSource = False
    DataSet = qryMemREL
    BCDToCurrency = False
    Left = 608
    Top = 192
  end
  object frxMemREL: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43878.671749803200000000
    ReportOptions.LastChange = 44807.516166365700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}')
    Left = 688
    Top = 195
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = frxDSMemREL
        DataSetName = 'Detail'
      end>
    Variables = <
      item
        Name = ' LeaderBoard'
        Value = Null
      end
      item
        Name = 'IsModeABS'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '2),'#39'ABSOLUTE'#39','#39'DIVISION'#39')'
      end
      item
        Name = 'IsModeEVENT'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '3) ,'#39'EVENT'#39','#39'HEAT'#39')'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 277.000000000000000000
      ColumnPositions.Strings = (
        '0')
      DataSet = frxDBDSRptHeader
      DataSetName = 'dsHeader'
      Frame.Typ = []
      EndlessHeight = True
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 76.438311670000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.333333340000000000
          Top = 0.435683330000000000
          Width = 294.803340000000000000
          Height = 30.236240000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 7.333333340000000000
          Top = 26.002628330000000000
          Width = 294.803340000000000000
          Height = 22.677180000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 704.538019630000000000
          Top = 2.680287040000000000
          Width = 331.653680000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeStr"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 451.609153340000000000
          Top = 2.658781660000000000
          Width = 143.622140000000000000
          Height = 46.021026660000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          GapY = -0.800000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTRANTS'
            'LEADERBOARD')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 706.408628340000000000
          Top = 26.002628330000000000
          Width = 329.137910000000000000
          Height = 22.677180000000000000
          DataField = 'ModeSubStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeSubStr"]')
          ParentFont = False
        end
        object dsHeaderRangeStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 7.955318340000000000
          Top = 43.314935000000000000
          Width = 1027.296846670000000000
          Height = 26.456710000000000000
          DataField = 'RangeStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsHeader."RangeStr"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 7.514378340000000000
          Top = 72.459338330000000000
          Width = 1028.032160000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 325.039580000000000000
        Width = 1046.929810000000000000
        Columns = 5
        ColumnWidth = 207.874015748031000000
        DataSet = frxDSMemREL
        DataSetName = 'Detail'
        KeepTogether = True
        RowCount = 0
        object frxDBDataset1RaceTime: TfrxMemoView
          AllowVectorExport = True
          Left = 169.417440000000000000
          Top = 1.000000000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataField = 'SubTotal'
          DataSet = frxDSMemREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Detail."SubTotal"]')
          ParentFont = False
        end
        object frxDBDataset1EventStr: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 166.063080000000000000
          Height = 18.897650000000000000
          DataField = 'DistStrokeStr'
          DataSet = frxDSMemREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            '[Detail."DistStrokeStr"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 275.905690000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."MemberID"'
        object frxDBDataset1FirstName: TfrxMemoView
          AllowVectorExport = True
          Left = 68.031540000000000000
          Top = 2.000000000000000000
          Width = 215.433210000000000000
          Height = 18.897650000000000000
          DataField = 'MemberNameStr'
          DataSet = frxDSMemREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."MemberNameStr"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object frxDBDataset1TotalPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 2.779530000000000000
          Top = 3.000000000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          DataField = 'TotalScore'
          DataSet = frxDSMemREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Detail."TotalScore"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = cl3DLight
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 222.992270000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."ScoreDivisionID"'
        KeepTogether = True
        object frxDBDataset1DivisionStr: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 351.496290000000000000
          Height = 22.677180000000000000
          DataField = 'DivisionStr'
          DataSet = frxDSMemREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."DivisionStr"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 11.338590000000000000
        Top = 370.393940000000000000
        Width = 1046.929810000000000000
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 442.205010000000000000
        Visible = False
        Width = 1046.929810000000000000
        object MemoH3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed on ')
          ParentFont = False
        end
        object PrintedOnDate: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object MemoH4: TfrxMemoView
          AllowVectorExport = True
          Left = 691.653990000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 43.726963340000000000
        Top = 154.960730000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."GenderID"'
        object frxDSEventCaption: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 2.000000000000000000
          Top = 6.157390000000000000
          Width = 406.073593340000000000
          Height = 30.236240000000000000
          DataField = 'GenderStr'
          DataSet = frxDSMemREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."GenderStr"]')
          ParentFont = False
        end
      end
    end
  end
  object qryHouseREL: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxHouse'
        Fields = 'HouseScore'
        DescFields = 'HouseScore'
      end>
    IndexName = 'idxHouse'
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SeedDate AS DATETIME;'
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      'DECLARE @DoEvent AS BIT;'
      'DECLARE @DoLockedSession AS BIT;'
      ''
      'SET @SeedDate = :AGESEEDDATE; --'#39'2021-08-01'#39'; --'
      'SET @SDate = :DTSTART; --'#39'2022-01-27'#39'; -- '
      'SET @EDate = :DTEND; --'#39'2022-01-28'#39'; -- '
      'SET @DoEvent = :DOEVENT;'
      'SET @DoLockedSession = :DOLOCKEDSESSION;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp4'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp4;'
      ''
      '-- build a list of division with it'#39's members'
      'SELECT ScoreDivisionID,'
      '       MemberID'
      'INTO #tmp4'
      'FROM ScoreDivision'
      '    LEFT JOIN Member'
      '        ON ScoreDivision.GenderID = Member.GenderID'
      'WHERE dbo.SwimmerAge(@SeedDate, member.DOB) >= AgeFrom'
      '      AND dbo.SwimmerAge(@SeedDate, member.DOB) <= AgeTo;'
      ''
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp1'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp1;'
      ''
      
        '-- build an ordered list of entrants - calculate placement - wit' +
        'hin specified session'
      'SELECT #tmp4.MemberID,'
      '       Entrant.EntrantID,'
      '       CASE @DoEvent'
      '           WHEN 1 THEN'
      
        '               dbo.RELEventPlace([Event].[EventID], Entrant.Memb' +
        'erID, #tmp4.ScoreDivisionID, @SeedDate)'
      '           WHEN 0 THEN'
      
        '               dbo.RELHeatPlace([HeatIndividual].[HeatID], Entra' +
        'nt.MemberID, ScoreDivisionID, @SeedDate)'
      '           ELSE'
      '               0'
      '       END AS Place'
      'INTO #tmp1'
      'FROM #tmp4'
      '    INNER JOIN Entrant'
      '        ON #tmp4.MemberID = Entrant.MemberID'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN [Event]'
      '        ON HeatIndividual.EventID = [Event].EventID'
      '    INNER JOIN [Session]'
      '        ON [Event].SessionID = [Session].SessionID'
      ''
      'WHERE [Session].SessionStart >= @SDate'
      '      AND [Session].SessionStart <= @EDate'
      '      AND Entrant.MemberID IS NOT NULL'
      '      AND [Session].SessionStatusID <= (CASE'
      
        '                                           WHEN @DoLockedSession' +
        ' = 1 THEN'
      '                                               2'
      '                                           ELSE'
      '                                               1'
      '                                       END);'
      ''
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp2'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp2;'
      ''
      '-- Calculate a score for each record in #tmp1'
      'SELECT #tmp1.MemberID,'
      
        '       dbo.EntrantScore(#tmp1.EntrantID, ScorePoints.Points) AS ' +
        'Points'
      'INTO #tmp2'
      'FROM #tmp1'
      '    LEFT JOIN ScorePoints'
      '        ON #tmp1.Place = ScorePoints.Place'
      'ORDER BY MemberID ASC;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp3'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp3;'
      ''
      '-- Collapse the list - grouped on House and tot score'
      'SELECT Member.HouseID,'
      '       SUM(#tmp2.Points) AS HouseScore'
      'INTO #tmp3'
      'FROM #tmp2'
      '    INNER JOIN Member'
      '        ON #tmp2.MemberID = Member.MemberID'
      'GROUP BY Member.HouseID;'
      ''
      '-- JOIN ALL THE BITS ON HOUSE - INTO A  SINGLE TABLE '
      '-- ready for reporting'
      'SELECT #tmp3.HouseID,'
      '       #tmp3.HouseScore,'
      '       House.Caption,'
      '       House.Motto,'
      '       House.Color,'
      '       House.LogoImg'
      'FROM #tmp3'
      '    INNER JOIN House'
      '        ON #tmp3.HouseID = House.HouseID'
      'ORDER BY HouseScore DESC;'
      ''
      'DROP TABLE #tmp3;'
      'DROP TABLE #tmp2;'
      'DROP TABLE #tmp1;'
      'DROP TABLE #tmp4;'
      ''
      ''
      ''
      '')
    Left = 64
    Top = 176
    ParamData = <
      item
        Name = 'AGESEEDDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44409d
      end
      item
        Name = 'DTSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DTEND'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44589d
      end
      item
        Name = 'DOEVENT'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'DOLOCKEDSESSION'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end>
  end
  object DSHouseREL: TfrxDBDataset
    UserName = 'Detail'
    CloseDataSource = False
    DataSet = qryHouseREL
    BCDToCurrency = False
    Left = 136
    Top = 176
  end
  object frxHouseREL: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44076.451311944500000000
    ReportOptions.LastChange = 44091.577845381900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}')
    OnBeforePrint = frxHouseRELBeforePrint
    Left = 208
    Top = 176
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = DSHouseREL
        DataSetName = 'Detail'
      end>
    Variables = <
      item
        Name = ' LeaderBoard'
        Value = Null
      end
      item
        Name = 'IsModeABS'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '2),'#39'ABSOLUTE'#39','#39'DIVISION'#39')'
      end
      item
        Name = 'IsModeEVENT'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '3) ,'#39'EVENT'#39','#39'HEAT'#39')'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 277.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      EndlessHeight = True
      EndlessWidth = True
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 79.771645000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object SCM_HeaderCaption: TfrxMemoView
          AllowVectorExport = True
          Left = 8.044681670000000000
          Top = 0.435683330000000000
          Width = 294.803340000000000000
          Height = 30.236240000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object SCM_HeaderNickName: TfrxMemoView
          AllowVectorExport = True
          Left = 8.044681670000000000
          Top = 26.002628330000000000
          Width = 294.803340000000000000
          Height = 22.677180000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
          ParentFont = False
        end
        object MemoH2: TfrxMemoView
          AllowVectorExport = True
          Left = 707.249367960000000000
          Top = 2.680287040000000000
          Width = 329.653680000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeStr"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 452.320501670000000000
          Top = 2.658781660000000000
          Width = 143.622140000000000000
          Height = 46.021026660000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          GapY = -0.800000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'HOUSE'
            'LEADERBOARD')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 707.119976670000000000
          Top = 26.002628330000000000
          Width = 329.137910000000000000
          Height = 22.677180000000000000
          DataField = 'ModeSubStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeSubStr"]')
          ParentFont = False
        end
        object dsHeaderRangeStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 7.333333340000000000
          Top = 43.314935000000000000
          Width = 1028.630180000000000000
          Height = 26.456710000000000000
          DataField = 'RangeStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsHeader."RangeStr"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 8.225726670000000000
          Top = 72.459338330000000000
          Width = 1028.032160000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 147.401670000000000000
        ParentFont = False
        Top = 196.535560000000000000
        Width = 1046.929810000000000000
        DataSet = DSHouseREL
        DataSetName = 'Detail'
        RowCount = 0
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 15.897650000000000000
          Width = 1012.914040000000000000
          Height = 113.385900000000000000
          Fill.BackColor = clBtnFace
          Frame.Typ = []
        end
        object Shape2: TfrxShapeView
          AllowVectorExport = True
          Left = 198.653680000000000000
          Top = 78.456710000000000000
          Width = 445.984540000000000000
          Height = 11.338590000000000000
          Curve = 4
          Fill.BackColor = cl3DLight
          Frame.Typ = []
          Shape = skRoundRectangle
        end
        object frxDSColor: TfrxMemoView
          AllowVectorExport = True
          Left = 213.763915000000000000
          Top = 26.338590000000000000
          Width = 408.189240000000000000
          Height = 49.133890000000000000
          DataField = 'Caption'
          DataSet = DSHouseREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -32
          Font.Name = 'Segoe UI Semibold'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."Caption"]')
          ParentFont = False
        end
        object frxDSTOT: TfrxMemoView
          Anchors = [fraTop, fraRight]
          AllowVectorExport = True
          Left = 628.225555930000000000
          Top = 26.338590000000000000
          Width = 394.013056290000000000
          Height = 90.708720000000000000
          AutoWidth = True
          DataField = 'HouseScore'
          DataSet = DSHouseREL
          DataSetName = 'Detail'
          DisplayFormat.FormatStr = '%2.1f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -64
          Font.Name = 'Segoe UI Semibold'
          Font.Style = []
          Frame.Typ = []
          Frame.Width = 2.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Detail."HouseScore"]')
          ParentFont = False
          WordWrap = False
        end
        object Picture1: TfrxPictureView
          AllowVectorExport = True
          Left = 33.677180000000000000
          Top = 1.338590000000000000
          Width = 164.409453700000000000
          Height = 145.637600000000000000
          OnBeforePrint = 'Picture1OnBeforePrint'
          DataField = 'LogoImg'
          DataSet = DSHouseREL
          DataSetName = 'Detail'
          Frame.Typ = []
          HightQuality = False
          Transparent = True
          TransparentColor = clWhite
        end
        object frxHouseABSEventMotto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 215.433210000000000000
          Top = 92.488250000000000000
          Width = 408.189240000000000000
          Height = 49.133890000000000000
          DataField = 'Motto'
          DataSet = DSHouseREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."Motto"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118120000000000000
        Top = 158.740260000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."HouseID"'
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 404.409710000000000000
        Width = 1046.929810000000000000
        object MemoH3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed on ')
          ParentFont = False
        end
        object PrintedOnDate: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object MemoH4: TfrxMemoView
          AllowVectorExport = True
          Left = 691.653990000000000000
          Width = 347.716760000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
        end
      end
    end
  end
  object qrySessABS: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxSessABS'
        Fields = 'GenderID;EventID;EventNum;Place'
        DescFields = 'GenderID;Place'
      end>
    IndexName = 'idxSessABS'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.KeyFields = 'EntrantID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      ''
      'SET @SDate = :DTSTART; --'#39'2022-01-27'#39'; -- '
      'SET @EDate = :DTEND; --'#39'2022-01-28'#39'; -- '
      ''
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp1'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp1;'
      ''
      '-- CALCULATE PLACE'
      'SELECT [Event].EventID,'
      '       Entrant.MemberID,'
      '       Entrant.EntrantID,'
      
        '       dbo.ABSEventPlace([Event].[EventID], Entrant.MemberID) AS' +
        ' Place'
      'INTO #tmp1'
      'FROM Entrant'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN Event'
      '        ON HeatIndividual.EventID = Event.EventID'
      '    INNER JOIN Session'
      '        ON Event.SessionID = Session.SessionID'
      'WHERE Session.SessionStart >= @SDate'
      '      AND Session.SessionStart <= @EDate'
      '      AND Entrant.MemberID IS NOT NULL;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp2'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp2;'
      ''
      '-- CALCULATE SCORE'
      'SELECT #tmp1.EventID,'
      '       #tmp1.MemberID,'
      '       #tmp1.EntrantID,'
      '       #tmp1.Place,'
      '       dbo.EntrantScore(#tmp1.EntrantID, #tmp1.Place) AS Points'
      'INTO #tmp2'
      'FROM #tmp1'
      '    LEFT JOIN ScorePoints'
      '        ON #tmp1.Place = ScorePoints.Place   '
      'ORDER BY MemberID ASC;'
      ''
      ''
      '-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT '
      'SELECT #tmp2.EventID,'
      '       #tmp2.MemberID,'
      '       #tmp2.EntrantID,'
      '       #tmp2.Place,'
      '       #tmp2.Points,'
      
        '       SUBSTRING(CONCAT(FirstName, '#39' '#39', UPPER(LastName)), 0, 50)' +
        ' AS MemberNameStr,'
      '       SUBSTRING('
      '                    CONCAT('
      '                              '#39'['#39','
      '                              FORMAT(Event.SessionID, '#39'#####'#39'),'
      '                              '#39'.'#39','
      '                              FORMAT(Event.EventNum, '#39'###'#39'),'
      '                              '#39'] '#39','
      '                              Distance.Caption,'
      '                              '#39' '#39','
      '                              Stroke.Caption'
      '                          ),'
      '                    0,'
      '                    50'
      '                ) AS DistStrokeStr,'
      '       [Event].EventNum,'
      '       dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTime,'
      '       Entrant.IsDisqualified,'
      '       Entrant.IsScratched,'
      '       Gender.GenderID,'
      '       Gender.Caption'
      'FROM #tmp2'
      '    INNER JOIN Member'
      '        ON #tmp2.MemberID = Member.MemberID'
      '     INNER JOIN Event'
      '        ON #tmp2.EventID = Event.EventID'
      '    INNER JOIN Stroke'
      '        ON Event.StrokeID = Stroke.StrokeID'
      '    INNER JOIN Distance'
      '        ON Event.DistanceID = Distance.DistanceID  '
      '    INNER JOIN Entrant'
      '        ON #tmp2.EntrantID = Entrant.EntrantID '
      '    INNER JOIN Gender'
      '        ON Member.GenderID = Gender.GenderID'
      'ORDER BY Gender.GenderID DESC'
      ''
      'DROP TABLE #tmp2;'
      'DROP TABLE #tmp1;'
      ''
      ''
      ''
      '')
    Left = 56
    Top = 400
    ParamData = <
      item
        Name = 'DTSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DTEND'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44589d
      end>
  end
  object DSSessABS: TfrxDBDataset
    UserName = 'Detail'
    CloseDataSource = False
    DataSet = qrySessABS
    BCDToCurrency = False
    Left = 136
    Top = 400
  end
  object frxSessABS: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43878.671749803200000000
    ReportOptions.LastChange = 44796.591145289300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}')
    Left = 216
    Top = 400
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = DSSessABS
        DataSetName = 'Detail'
      end>
    Variables = <
      item
        Name = ' LeaderBoard'
        Value = Null
      end
      item
        Name = 'IsModeABS'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '2),'#39'ABSOLUTE'#39','#39'DIVISION'#39')'
      end
      item
        Name = 'IsModeEVENT'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '3) ,'#39'EVENT'#39','#39'HEAT'#39')'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 277.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      EndlessHeight = True
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 60.472480000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object SCM_HeaderCaption: TfrxMemoView
          AllowVectorExport = True
          Left = 7.378015000000000000
          Top = 0.889765000000000000
          Width = 294.803340000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object SCM_HeaderNickName: TfrxMemoView
          AllowVectorExport = True
          Left = 7.378015000000000000
          Top = 26.456710000000000000
          Width = 294.803340000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
          ParentFont = False
        end
        object MemoH2: TfrxMemoView
          AllowVectorExport = True
          Left = 823.937540000000000000
          Top = 3.779530000000000000
          Width = 211.653680000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Place given on ABSOLUTE for each EVENT')
          ParentFont = False
        end
        object LineH1: TfrxLineView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 52.913420000000000000
          Width = 1028.032160000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 451.653835000000000000
          Top = 3.779530000000000000
          Width = 143.622140000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'EVENTS'
            'LEADERBOARD')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 857.953310000000000000
          Top = 26.456710000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Entrant.Place.Score')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 313.700990000000000000
        Width = 1046.929810000000000000
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 15268095
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 196.535560000000000000
        Width = 1046.929810000000000000
        Condition = 'frxEvDSEvent."EventID"'
        KeepTogether = True
        object MembersName: TfrxMemoView
          AllowVectorExport = True
          Left = 0.559060000000000000
          Top = 1.889765000000000000
          Width = 393.071120000000000000
          Height = 26.456710000000000000
          DataField = 'DistStrokeStr'
          DataSet = DSSessABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."DistStrokeStr"]')
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
        Height = 40.240569090000000000
        ParentFont = False
        Top = 249.448980000000000000
        Width = 1046.929810000000000000
        Columns = 5
        ColumnWidth = 207.874015748031000000
        DataSet = DSSessABS
        DataSetName = 'Detail'
        KeepTogether = True
        RowCount = 0
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 2.559060000000000000
          Top = 2.133890000000000000
          Width = 201.883717450000000000
          Height = 37.038942900000000000
          Frame.Typ = []
        end
        object DistanceStroke: TfrxMemoView
          AllowVectorExport = True
          Left = 1.779530000000000000
          Top = 1.000000000000000000
          Width = 132.283550000000000000
          Height = 22.677180000000000000
          DataField = 'MemberNameStr'
          DataSet = DSSessABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."MemberNameStr"]')
          ParentFont = False
        end
        object frxDSPlace: TfrxMemoView
          AllowVectorExport = True
          Left = 134.181200000000000000
          Top = 1.000000000000000000
          Width = 34.015770000000000000
          Height = 22.677180000000000000
          DataField = 'Place'
          DataSet = DSSessABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[Detail."Place"]')
          ParentFont = False
        end
        object frxDSPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 164.417440000000000000
          Top = 1.000000000000000000
          Width = 37.795300000000000000
          Height = 22.677180000000000000
          DataField = 'Points'
          DataSet = DSSessABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Fill.Style = bsClear
          HAlign = haCenter
          Memo.UTF8W = (
            '[Detail."Points"]')
          ParentFont = False
        end
        object frxEvDSEventRaceTime: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 2.779530000000000000
          Top = 21.236240000000000000
          Width = 110.035560000000000000
          Height = 15.118120000000000000
          DataField = 'RaceTime'
          DataSet = DSSessABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Fill.Style = bsClear
          GapY = -2.000000000000000000
          Memo.UTF8W = (
            '[Detail."RaceTime"]')
          ParentFont = False
        end
        object frxEvDSEventIsDisqualified: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 156.333333330000000000
          Top = 18.410636670000000000
          Width = 20.908163330000000000
          Height = 18.897650000000000000
          DataSet = DSSessABS
          DataSetName = 'Detail'
          Frame.Typ = []
          Memo.UTF8W = (
            '[IIF(<frxEvDSEvent."IsDisqualified">,'#39'D'#39','#39#39')]')
        end
        object Memo3: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 179.500000000000000000
          Top = 18.243970000000000000
          Width = 20.908163330000000000
          Height = 18.897650000000000000
          DataSet = DSSessABS
          DataSetName = 'Detail'
          Frame.Typ = []
          Memo.UTF8W = (
            '[IIF(<frxEvDSEvent."IsScratched">,'#39'S'#39','#39#39')]')
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 393.071120000000000000
        Width = 1046.929810000000000000
        object MemoH3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed on ')
          ParentFont = False
        end
        object PrintedOnDate: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object MemoH4: TfrxMemoView
          AllowVectorExport = True
          Left = 691.653990000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 32.177180000000000000
        Top = 139.842610000000000000
        Width = 1046.929810000000000000
        Condition = 'frxEvDSEvent."GenderID"'
        object frxEvDSEventCaption: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.500000000000000000
          Top = 1.157390000000000000
          Width = 238.240260000000000000
          Height = 26.897650000000000000
          DataSet = DSSessABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[UpperCase(<frxEvDSEvent."Caption">)]')
          ParentFont = False
        end
      end
      object Memo4: TfrxMemoView
        AllowVectorExport = True
        Left = 8.711348330000000000
        Top = 465.333333330000000000
        Width = 294.803340000000000000
        Height = 30.236240000000000000
        DataField = 'ClubName'
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        Frame.Typ = []
        Memo.UTF8W = (
          '[dsHeader."ClubName"]')
        ParentFont = False
      end
      object Memo5: TfrxMemoView
        AllowVectorExport = True
        Left = 8.711348330000000000
        Top = 490.900278330000000000
        Width = 294.803340000000000000
        Height = 22.677180000000000000
        DataField = 'ClubNickName'
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Frame.Typ = []
        Memo.UTF8W = (
          '[dsHeader."ClubNickName"]')
        ParentFont = False
      end
      object Memo6: TfrxMemoView
        AllowVectorExport = True
        Left = 707.916034620000000000
        Top = 467.577937040000000000
        Width = 329.653680000000000000
        Height = 22.677180000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Frame.Typ = []
        HAlign = haRight
        Memo.UTF8W = (
          '[dsHeader."ModeStr"]')
        ParentFont = False
      end
      object Memo7: TfrxMemoView
        AllowVectorExport = True
        Left = 452.987168330000000000
        Top = 467.556431660000000000
        Width = 143.622140000000000000
        Height = 46.021026660000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        Frame.Typ = []
        GapY = -0.800000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          'HOUSE'
          'LEADERBOARD')
        ParentFont = False
      end
      object Memo8: TfrxMemoView
        AllowVectorExport = True
        Left = 707.786643330000000000
        Top = 490.900278330000000000
        Width = 329.137910000000000000
        Height = 22.677180000000000000
        DataField = 'ModeSubStr'
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Frame.Typ = []
        HAlign = haRight
        Memo.UTF8W = (
          '[dsHeader."ModeSubStr"]')
        ParentFont = False
      end
      object dsHeaderRangeStr: TfrxMemoView
        IndexTag = 1
        AllowVectorExport = True
        Left = 8.000000000000000000
        Top = 508.212585000000000000
        Width = 1028.630180000000000000
        Height = 26.456710000000000000
        DataField = 'RangeStr'
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        Frame.Typ = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[dsHeader."RangeStr"]')
        ParentFont = False
      end
      object Line1: TfrxLineView
        AllowVectorExport = True
        Left = 8.892393330000000000
        Top = 537.356988330000000000
        Width = 1028.032160000000000000
        Color = clBlack
        Frame.Typ = [ftTop]
        Frame.Width = 2.000000000000000000
      end
    end
  end
  object frxSessREL: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44076.532221643500000000
    ReportOptions.LastChange = 44091.578086157400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}')
    Left = 216
    Top = 448
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = DSSessREL
        DataSetName = 'Detail'
      end>
    Variables = <
      item
        Name = ' LeaderBoard'
        Value = Null
      end
      item
        Name = 'IsModeABS'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '2),'#39'ABSOLUTE'#39','#39'DIVISION'#39')'
      end
      item
        Name = 'IsModeEVENT'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '3) ,'#39'EVENT'#39','#39'HEAT'#39')'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 277.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      EndlessHeight = True
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 60.472480000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo19: TfrxMemoView
          AllowVectorExport = True
          Left = 7.333333330000000000
          Top = 3.102350000000000000
          Width = 294.803340000000000000
          Height = 30.236240000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 7.333333330000000000
          Top = 28.669295000000000000
          Width = 294.803340000000000000
          Height = 22.677180000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 759.226191660000000000
          Top = 5.992115000000000000
          Width = 276.320346670000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Place given on RELATIVE TO DIVISION for each EVENT')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 7.514378330000000000
          Top = 55.126005000000000000
          Width = 1028.032160000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 451.609153330000000000
          Top = 5.992115000000000000
          Width = 143.622140000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'EVENTS'
            'LEADERBOARD')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 857.908628330000000000
          Top = 28.669295000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Entrant.Place.Score')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = clBtnFace
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Height = 26.456710000000000000
        ParentFont = False
        Top = 260.787570000000000000
        Width = 1046.929810000000000000
        Condition = 'SessRELEvent."EventID"'
        KeepTogether = True
        object frxDSEventStr: TfrxMemoView
          AllowVectorExport = True
          Top = 4.000000000000000000
          Width = 340.157700000000000000
          Height = 18.897650000000000000
          DataField = 'DistStrokeStr'
          DataSet = DSSessREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."DistStrokeStr"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 40.677180000000000000
        Top = 309.921460000000000000
        Width = 1046.929810000000000000
        Columns = 4
        ColumnWidth = 253.228346456693000000
        ColumnGap = 7.559055118110240000
        DataSet = DSSessREL
        DataSetName = 'Detail'
        KeepTogether = True
        RowCount = 0
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 1.333333330000000000
          Top = 1.335806670000000000
          Width = 250.934446670000000000
          Height = 37.795300000000000000
          Frame.Typ = []
        end
        object frxEventSingleFNAME: TfrxMemoView
          AllowVectorExport = True
          Left = 4.000000000000000000
          Top = 1.000000000000000000
          Width = 174.694496200000000000
          Height = 18.897650000000000000
          DataSet = DSSessREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[<SessRELEvent."MemberNameStr">] ([<SessRELEvent."TotalScore">])')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object SessRELEventIsDisqualified: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 184.000000000000000000
          Top = 18.602349530000000000
          Width = 24.574830000000000000
          Height = 18.897650000000000000
          DataSet = DSSessREL
          DataSetName = 'Detail'
          Frame.Typ = []
          Memo.UTF8W = (
            '[IIF(<SessRELEvent."IsDisqualified">,'#39'D'#39','#39#39')]')
        end
        object SessRELEventIsScratched: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 213.833333330000000000
          Top = 18.245206670000000000
          Width = 25.574830000000000000
          Height = 18.897650000000000000
          DataSet = DSSessREL
          DataSetName = 'Detail'
          Frame.Typ = []
          Memo.UTF8W = (
            '[IIF(<SessRELEvent."IsScratched">,'#39'S'#39','#39#39')]')
        end
        object SessRELEventPlace: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 184.047619040000000000
          Top = 1.911873330000000000
          Width = 29.155844290000000000
          Height = 18.897650000000000000
          DataSet = DSSessREL
          DataSetName = 'Detail'
          DisplayFormat.FormatStr = '%2.0f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = []
          GapY = -2.000000000000000000
          Memo.UTF8W = (
            '[SessRELEvent."Place"]')
        end
        object SessRELEventPoints: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 214.000000000000000000
          Top = 2.078540000000000000
          Width = 36.870130000000000000
          Height = 18.897650000000000000
          DataSet = DSSessREL
          DataSetName = 'Detail'
          DisplayFormat.FormatStr = '%2.1f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = []
          GapY = -2.000000000000000000
          Memo.UTF8W = (
            '[SessRELEvent."Points"]')
        end
        object SessRELEventRaceTime: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 5.000000000000000000
          Top = 16.078540000000000000
          Width = 141.988250000000000000
          Height = 18.897650000000000000
          DataField = 'RaceTime'
          DataSet = DSSessREL
          DataSetName = 'Detail'
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."RaceTime"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 8.064316670000000000
        Top = 400.630180000000000000
        Width = 1046.929810000000000000
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = 7.500000000000000000
          Top = 2.347556670000000000
          Width = 1028.032160000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 468.661720000000000000
        Visible = False
        Width = 1046.929810000000000000
        object MemoH3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed on ')
          ParentFont = False
        end
        object PrintedOnDate: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object MemoH4: TfrxMemoView
          AllowVectorExport = True
          Left = 691.653990000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 13492222
        Frame.Typ = []
        Height = 37.795300000000000000
        Top = 200.315090000000000000
        Width = 1046.929810000000000000
        Condition = 'SessRELEvent."ScoreDivisionID"'
        object frxEvDSRELEventDivisionStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.333333330000000000
          Width = 400.630180000000000000
          Height = 24.118120000000000000
          DataField = 'DivisionStr'
          DataSet = DSSessREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."DivisionStr"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 4.367656190000000000
        Top = 374.173470000000000000
        Width = 1046.929810000000000000
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 36.677180000000000000
        Top = 139.842610000000000000
        Width = 1046.929810000000000000
        Condition = 'SessRELEvent."GenderID"'
        object SessRELEventCaption: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 2.000000010000000000
          Top = 4.824056660000000000
          Width = 203.406926670000000000
          Height = 28.230983330000000000
          DataField = 'Caption'
          DataSet = DSSessREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."Caption"]')
          ParentFont = False
        end
      end
      object SCM_HeaderCaption: TfrxMemoView
        AllowVectorExport = True
        Left = 6.044681660000000000
        Top = 517.333333330000000000
        Width = 294.803340000000000000
        Height = 30.236240000000000000
        DataField = 'ClubName'
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        Frame.Typ = []
        Memo.UTF8W = (
          '[dsHeader."ClubName"]')
        ParentFont = False
      end
      object SCM_HeaderNickName: TfrxMemoView
        AllowVectorExport = True
        Left = 6.044681660000000000
        Top = 542.900278330000000000
        Width = 294.803340000000000000
        Height = 22.677180000000000000
        DataField = 'ClubNickName'
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Frame.Typ = []
        Memo.UTF8W = (
          '[dsHeader."ClubNickName"]')
        ParentFont = False
      end
      object MemoH2: TfrxMemoView
        AllowVectorExport = True
        Left = 705.249367950000000000
        Top = 519.577937040000000000
        Width = 329.653680000000000000
        Height = 22.677180000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Frame.Typ = []
        HAlign = haRight
        Memo.UTF8W = (
          '[dsHeader."ModeStr"]')
        ParentFont = False
      end
      object Memo5: TfrxMemoView
        AllowVectorExport = True
        Left = 450.320501660000000000
        Top = 519.556431660000000000
        Width = 143.622140000000000000
        Height = 46.021026660000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        Frame.Typ = []
        GapY = -0.800000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          'HOUSE'
          'LEADERBOARD')
        ParentFont = False
      end
      object Memo6: TfrxMemoView
        AllowVectorExport = True
        Left = 705.119976660000000000
        Top = 542.900278330000000000
        Width = 329.137910000000000000
        Height = 22.677180000000000000
        DataField = 'ModeSubStr'
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Frame.Typ = []
        HAlign = haRight
        Memo.UTF8W = (
          '[dsHeader."ModeSubStr"]')
        ParentFont = False
      end
      object dsHeaderRangeStr: TfrxMemoView
        IndexTag = 1
        AllowVectorExport = True
        Left = 5.333333330000000000
        Top = 560.212585000000000000
        Width = 1028.630180000000000000
        Height = 26.456710000000000000
        DataField = 'RangeStr'
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        Frame.Typ = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[dsHeader."RangeStr"]')
        ParentFont = False
      end
      object Line3: TfrxLineView
        AllowVectorExport = True
        Left = 6.225726660000000000
        Top = 589.356988330000000000
        Width = 1028.032160000000000000
        Color = clBlack
        Frame.Typ = [ftTop]
        Frame.Width = 2.000000000000000000
      end
    end
  end
  object qrySessREL: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxSessREL'
        Fields = 'GenderID;AgeTo;ScoreDivisionID;EventID;Place'
        DescFields = 'GenderID;AgeTo'
      end>
    IndexName = 'idxSessREL'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.KeyFields = 'EntrantID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SeedDate AS DATETIME;'
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      ''
      'SET @SeedDate = :AGESEEDDATE; --'#39'2021-08-01'#39'; --'
      'SET @SDate = :DTSTART; --'#39'2022-01-27'#39'; -- '
      'SET @EDate = :DTEND; -- '#39'2022-01-28'#39'; -- '
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp4'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp4;'
      ''
      '-- build a list of division with it'#39's members'
      'SELECT ScoreDivisionID,'
      '       MemberID'
      'INTO #tmp4'
      'FROM ScoreDivision'
      '    LEFT JOIN Member'
      '        ON ScoreDivision.GenderID = Member.GenderID'
      'WHERE dbo.SwimmerAge(@SeedDate, member.DOB) >= AgeFrom'
      '      AND dbo.SwimmerAge(@SeedDate, member.DOB) <= AgeTo;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp1'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp1;'
      ''
      '-- CALCULATE PLACE'
      'SELECT ScoreDivisionId,'
      '       [Event].EventID,'
      '       Entrant.MemberID,'
      '       Entrant.EntrantID,'
      
        '       dbo.RELEventPlace([Event].[EventID], Entrant.MemberID, Sc' +
        'oreDivisionID, @SeedDate) AS Place'
      'INTO #tmp1'
      'FROM #tmp4'
      '    INNER JOIN Entrant'
      '        ON #tmp4.MemberID = Entrant.MemberID'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN Event'
      '        ON HeatIndividual.EventID = [Event].EventID'
      '    INNER JOIN Session'
      '        ON Event.SessionID = Session.SessionID'
      'WHERE Session.SessionStart >= @SDate'
      '      AND Session.SessionStart <= @EDate'
      '      AND Entrant.MemberID IS NOT NULL;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp2'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp2;'
      ''
      '-- CALCULATE POINTS'
      'SELECT #tmp1.ScoreDivisionID,'
      '       #tmp1.MemberID,'
      '       #tmp1.EventID,'
      '       #tmp1.Place,'
      '       #tmp1.EntrantID,'
      '       dbo.EntrantScore(#tmp1.EntrantID, #tmp1.Place) AS Points'
      'INTO #tmp2'
      'FROM #tmp1'
      '    LEFT JOIN ScorePoints'
      '        ON #tmp1.Place = ScorePoints.Place'
      'ORDER BY MemberID ASC;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp3'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp3;'
      ''
      '-- CALCULATE TOTAL-SCORE'
      'SELECT #tmp2.ScoreDivisionID,'
      '       #tmp2.MemberID,'
      '       SUM(#tmp2.Points) AS TotalScore'
      'INTO #tmp3'
      'FROM #tmp2'
      'GROUP BY #tmp2.ScoreDivisionID,'
      '         #tmp2.MemberID;'
      ''
      '-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT '
      'SELECT #tmp2.ScoreDivisionID,'
      '       #tmp2.MemberID,'
      '       #tmp2.EventID,'
      '       #tmp3.TotalScore,'
      '       #tmp2.Place,'
      '       #tmp2.Points,'
      
        '       SUBSTRING(CONCAT(FirstName, '#39' '#39', UPPER(LastName)), 0, 50)' +
        ' AS MemberNameStr,'
      '       SUBSTRING('
      '                    CONCAT('
      '                              '#39'['#39','
      '                              FORMAT(Event.SessionID, '#39'#####'#39'),'
      '                              '#39'.'#39','
      '                              FORMAT(Event.EventNum, '#39'###'#39'),'
      '                              '#39'] '#39','
      '                              Distance.Caption,'
      '                              '#39' '#39','
      '                              Stroke.Caption'
      '                          ),'
      '                    0,'
      '                    50'
      '                ) AS DistStrokeStr,'
      '       ScoreDivision.Caption AS DivisionStr,'
      '       ScoreDivision.GenderID,'
      '       ScoreDivision.AgeTo,'
      '       dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTime,'
      '       Entrant.IsDisqualified,'
      '       Entrant.IsScratched,'
      '       Gender.Caption'
      ''
      'FROM #tmp2'
      '    INNER JOIN #tmp3'
      '        ON #tmp2.ScoreDivisionID = #tmp3.ScoreDivisionID'
      '           AND #tmp2.MemberID = #tmp3.MemberID'
      '    INNER JOIN Member'
      '        ON #tmp2.MemberID = Member.MemberID'
      '    INNER JOIN Event'
      '        ON #tmp2.EventID = [Event].EventID'
      '    INNER JOIN Stroke'
      '        ON Event.StrokeID = Stroke.StrokeID'
      '    INNER JOIN Distance'
      '        ON Event.DistanceID = Distance.DistanceID'
      '    INNER JOIN ScoreDivision'
      '        ON #tmp2.ScoreDivisionID = ScoreDivision.ScoreDivisionID'
      '            INNER JOIN Gender'
      '        ON Member.GenderID = Gender.GenderID'
      '    INNER JOIN Entrant'
      '        ON #tmp2.EntrantID = Entrant.EntrantID'
      ''
      ''
      '-- NOTE: final sort index applied in FireDAC '
      'ORDER BY #tmp2.EventID;'
      ''
      'DROP TABLE #tmp3;'
      'DROP TABLE #tmp2;'
      'DROP TABLE #tmp1;'
      ''
      ''
      ''
      '')
    Left = 56
    Top = 448
    ParamData = <
      item
        Name = 'AGESEEDDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44409d
      end
      item
        Name = 'DTSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DTEND'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44589d
      end>
  end
  object DSSessREL: TfrxDBDataset
    UserName = 'Detail'
    CloseDataSource = False
    DataSet = qrySessREL
    BCDToCurrency = False
    Left = 136
    Top = 448
  end
  object qryEventABS: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxEventABS'
        Fields = 'GenderID;DistanceID;StrokeID;TotalScore'
        DescFields = 'GenderID;TotalScore'
      end>
    IndexName = 'idxEventABS'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.KeyFields = 'EntrantID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      'DECLARE @DoEvent AS BIT;'
      'DECLARE @DoLockedSession AS BIT;'
      ''
      'SET @SDate = :DTSTART; --'#39'2022-01-27'#39'; -- '
      'SET @EDate = :DTEND; --'#39'2022-01-28'#39'; -- '
      'SET @DoEvent = :DOEVENT;'
      'SET @DoLockedSession = :DOLOCKEDSESSION;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp1'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp1;'
      ''
      '-- CALCULATE PLACE'
      'SELECT Entrant.MemberID,'
      '       Entrant.EntrantID,'
      '       [Event].StrokeID,'
      '       [Event].DistanceID,'
      '       CASE @DoEvent'
      '           WHEN 1 THEN'
      
        '               dbo.ABSEventPlace([Event].[EventID], Entrant.Memb' +
        'erID)'
      '               WHEN 0 THEN'
      
        '               dbo.ABSHeatPlace([HeatIndividual].[HeatID], Entra' +
        'nt.MemberID)'
      '           ELSE 0'
      '       END AS Place'
      'INTO #tmp1'
      'FROM Entrant'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN [Event]'
      '        ON HeatIndividual.EventID = [Event].EventID'
      '    INNER JOIN [Session]'
      '        ON [Event].SessionID = [Session].SessionID'
      'WHERE [Session].SessionStart >= @SDate'
      '      AND [Session].SessionStart <= @EDate'
      '      AND Entrant.MemberID IS NOT NULL'
      '      AND [Session].SessionStatusID <= (CASE'
      
        '                                           WHEN @DoLockedSession' +
        ' = 1 THEN'
      '                                               2'
      '                                           ELSE'
      '                                               1'
      '                                       END); '
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp2'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp2;'
      ''
      '-- CALCULATE POINTS'
      'SELECT #tmp1.StrokeID,'
      '       #tmp1.DistanceID,'
      '       #tmp1.MemberID,'
      '       dbo.EntrantScore(#tmp1.EntrantID, #tmp1.Place) AS Points'
      'INTO #tmp2'
      'FROM #tmp1'
      '    LEFT JOIN ScorePoints'
      '        ON #tmp1.Place = ScorePoints.Place'
      'ORDER BY MemberID ASC;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp3'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp3;'
      ''
      '-- CALCULATE TOTAL-SCORE'
      'SELECT #tmp2.MemberID,'
      '       #tmp2.StrokeID,'
      '       #tmp2.DistanceID,'
      '       SUM(#tmp2.Points) AS TotalScore'
      'INTO #tmp3'
      'FROM #tmp2'
      'GROUP BY #tmp2.MemberID,'
      '         #tmp2.StrokeID,'
      '         #tmp2.DistanceID;'
      ''
      '-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT '
      'SELECT #tmp3.StrokeID,'
      '       #tmp3.DistanceID,'
      '       #tmp3.TotalScore,'
      
        '       SUBSTRING(CONCAT(FirstName, '#39' '#39', UPPER(LastName)), 0, 50)' +
        ' AS MemberNameStr,'
      
        '       SUBSTRING(CONCAT(Distance.Caption, '#39' '#39', Stroke.Caption), ' +
        '0, 50) AS DistStrokeStr,'
      '       Gender.GenderID,'
      '       Gender.Caption AS GenderStr'
      'FROM #tmp3'
      '    INNER JOIN Member'
      '        ON #tmp3.MemberID = Member.MemberID'
      '    INNER JOIN Stroke'
      '        ON #tmp3.StrokeID = Stroke.StrokeID'
      '    INNER JOIN Distance'
      '        ON #tmp3.DistanceID = Distance.DistanceID'
      '    INNER JOIN Gender'
      '        ON Member.GenderID = Gender.GenderID'
      'ORDER BY StrokeID ASC,'
      '         DistanceID ASC;'
      ''
      'DROP TABLE #tmp3;'
      'DROP TABLE #tmp2;'
      'DROP TABLE #tmp1;'
      ''
      ''
      ''
      '')
    Left = 64
    Top = 256
    ParamData = <
      item
        Name = 'DTSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DTEND'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44589d
      end
      item
        Name = 'DOEVENT'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'DOLOCKEDSESSION'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end>
  end
  object DSEventABS: TfrxDBDataset
    UserName = 'Detail'
    CloseDataSource = False
    DataSet = qryEventABS
    BCDToCurrency = False
    Left = 136
    Top = 256
  end
  object frxEventABS: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43878.671749803200000000
    ReportOptions.LastChange = 44796.591145289300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}')
    Left = 216
    Top = 256
    Datasets = <
      item
        DataSet = DSEventABS
        DataSetName = 'Detail'
      end
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end>
    Variables = <
      item
        Name = ' LeaderBoard'
        Value = Null
      end
      item
        Name = 'IsModeABS'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '2),'#39'ABSOLUTE'#39','#39'DIVISION'#39')'
      end
      item
        Name = 'IsModeEVENT'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '3) ,'#39'EVENT'#39','#39'HEAT'#39')'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 277.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      EndlessHeight = True
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 77.335961670000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.378014990000000000
          Width = 294.803340000000000000
          Height = 30.236240000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 7.378014990000000000
          Top = 25.566945000000000000
          Width = 294.803340000000000000
          Height = 22.677180000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 706.582701280000000000
          Top = 2.244603710000000000
          Width = 329.653680000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeStr"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 451.653834990000000000
          Top = 2.223098330000000000
          Width = 143.622140000000000000
          Height = 46.021026660000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          GapY = -0.800000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'EVENTS'
            'LEADERBOARD')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 706.453309990000000000
          Top = 25.566945000000000000
          Width = 329.137910000000000000
          Height = 22.677180000000000000
          DataField = 'ModeSubStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeSubStr"]')
          ParentFont = False
        end
        object dsHeaderRangeStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 6.666666660000000000
          Top = 42.879251670000000000
          Width = 1028.630180000000000000
          Height = 26.456710000000000000
          DataField = 'RangeStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsHeader."RangeStr"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 7.559059990000000000
          Top = 70.459338330000000000
          Width = 1028.032160000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 355.275820000000000000
        Width = 1046.929810000000000000
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 15268095
        Frame.Typ = []
        Height = 24.029343450000000000
        Top = 264.567100000000000000
        Width = 1046.929810000000000000
        Condition = 'DSEventABS."StrokeID"'
        KeepTogether = True
        object MembersName: TfrxMemoView
          AllowVectorExport = True
          Left = 0.559060000000000000
          Top = 1.889765000000000000
          Width = 393.071120000000000000
          Height = 19.560158280000000000
          DataField = 'DistStrokeStr'
          DataSet = DSEventABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          GapY = -2.000000000000000000
          Memo.UTF8W = (
            '[Detail."DistStrokeStr"]')
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
        Height = 23.054712900000000000
        ParentFont = False
        Top = 309.921460000000000000
        Width = 1046.929810000000000000
        Columns = 5
        ColumnWidth = 207.874015748031000000
        DataSet = DSEventABS
        DataSetName = 'Detail'
        KeepTogether = True
        RowCount = 0
        object Shape2: TfrxShapeView
          AllowVectorExport = True
          Left = 3.103448280000000000
          Top = 1.662529310000000000
          Width = 201.883717450000000000
          Height = 18.141292900000000000
          Frame.Typ = []
        end
        object DistanceStroke: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          DataSet = DSEventABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[DSEventABS."MemberNameStr"]')
          ParentFont = False
        end
        object frxDSPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 166.486405510000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          DataField = 'TotalScore'
          DataSet = DSEventABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Fill.Style = bsClear
          HAlign = haCenter
          Memo.UTF8W = (
            '[Detail."TotalScore"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 434.645950000000000000
        Width = 1046.929810000000000000
        object MemoH3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed on ')
          ParentFont = False
        end
        object PrintedOnDate: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object MemoH4: TfrxMemoView
          AllowVectorExport = True
          Left = 691.653990000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 12.332352420000000000
        Top = 230.551330000000000000
        Width = 1046.929810000000000000
        Condition = 'DSEventABS."DistanceID"'
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 48.677180000000000000
        Top = 158.740260000000000000
        Width = 1046.929810000000000000
        Condition = 'DSEventABS."GenderID"'
        object DSEventABSCaption: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 2.666666660000000000
          Top = 8.824056660000000000
          Width = 284.073593330000000000
          Height = 28.230983330000000000
          DataSet = DSEventABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[UpperCase(<DSEventABS."GenderStr">)]')
          ParentFont = False
        end
      end
    end
  end
  object frxEventREL: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44076.532221643500000000
    ReportOptions.LastChange = 44091.578086157400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}')
    Left = 216
    Top = 304
    Datasets = <
      item
        DataSet = DSEventREL
        DataSetName = 'Detail'
      end
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end>
    Variables = <
      item
        Name = ' LeaderBoard'
        Value = Null
      end
      item
        Name = 'IsModeABS'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '2),'#39'ABSOLUTE'#39','#39'DIVISION'#39')'
      end
      item
        Name = 'IsModeEVENT'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '3) ,'#39'EVENT'#39','#39'HEAT'#39')'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 277.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      EndlessHeight = True
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 77.335961670000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object SCM_HeaderCaption: TfrxMemoView
          AllowVectorExport = True
          Left = 4.711348330000000000
          Width = 294.803340000000000000
          Height = 30.236240000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object SCM_HeaderNickName: TfrxMemoView
          AllowVectorExport = True
          Left = 4.711348330000000000
          Top = 25.566945000000000000
          Width = 294.803340000000000000
          Height = 22.677180000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
          ParentFont = False
        end
        object MemoH2: TfrxMemoView
          AllowVectorExport = True
          Left = 703.916034620000000000
          Top = 2.244603710000000000
          Width = 329.653680000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeStr"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 448.987168330000000000
          Top = 2.223098330000000000
          Width = 143.622140000000000000
          Height = 46.021026660000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          GapY = -0.800000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'EVENTS'
            'LEADERBOARD')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 703.786643330000000000
          Top = 25.566945000000000000
          Width = 329.137910000000000000
          Height = 22.677180000000000000
          DataField = 'ModeSubStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeSubStr"]')
          ParentFont = False
        end
        object dsHeaderRangeStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 4.000000000000000000
          Top = 42.879251670000000000
          Width = 1028.630180000000000000
          Height = 26.456710000000000000
          DataField = 'RangeStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsHeader."RangeStr"]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = 4.892393330000000000
          Top = 71.126005000000000000
          Width = 1028.032160000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = clBtnFace
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Height = 3.888117590000000000
        ParentFont = False
        Top = 283.464750000000000000
        Visible = False
        Width = 1046.929810000000000000
        Condition = 'Detail."DistanceID"'
        KeepTogether = True
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 27.343846660000000000
        Top = 355.275820000000000000
        Width = 1046.929810000000000000
        Columns = 4
        ColumnWidth = 253.228346456693000000
        ColumnGap = 7.559055118110240000
        DataSet = DSEventREL
        DataSetName = 'Detail'
        KeepTogether = True
        RowCount = 0
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 1.333333330000000000
          Top = 0.335806670000000000
          Width = 250.934446670000000000
          Height = 22.677180000000000000
          Frame.Typ = []
        end
        object frxEventSingleFNAME: TfrxMemoView
          AllowVectorExport = True
          Left = 4.000000000000000000
          Width = 161.837353340000000000
          Height = 18.897650000000000000
          DataField = 'MemberNameStr'
          DataSet = DSEventREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."MemberNameStr"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object frxDSPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 204.902395170000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          DataSet = DSEventREL
          DataSetName = 'Detail'
          DisplayFormat.FormatStr = '%2.1f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DSEventREL."TotalScore"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 472.441250000000000000
        Visible = False
        Width = 1046.929810000000000000
        object MemoH3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed on ')
          ParentFont = False
        end
        object PrintedOnDate: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object MemoH4: TfrxMemoView
          AllowVectorExport = True
          Left = 691.653990000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 13492222
        Frame.Typ = []
        Height = 37.795300000000000000
        Top = 222.992270000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."ScoreDivisionID"'
        object frxEvDSRELEventDivisionStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.333333330000000000
          Width = 400.630180000000000000
          Height = 24.118120000000000000
          DataField = 'DivisionStr'
          DataSet = DSEventREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."DivisionStr"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 8.510513330000000000
        Top = 404.409710000000000000
        Width = 1046.929810000000000000
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 21.987524830000000000
        Top = 309.921460000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."StrokeID"'
        object frxDSEventStr: TfrxMemoView
          AllowVectorExport = True
          Left = 2.758620690000000000
          Top = 1.073006550000000000
          Width = 340.157700000000000000
          Height = 18.897650000000000000
          DataField = 'DistStrokeStr'
          DataSet = DSEventREL
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."DistStrokeStr"]')
          ParentFont = False
        end
      end
      object GroupHeader4: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 42.677180000000000000
        Top = 158.740260000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."GenderID"'
        object DSEventABSCaption: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 2.666666670000000000
          Top = 7.170376670000000000
          Width = 284.073593330000000000
          Height = 28.230983330000000000
          DataSet = DSEventABS
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[UpperCase(<Detail."GenderStr">)]')
          ParentFont = False
        end
      end
    end
  end
  object qryEventREL: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxEventREL'
        Fields = 'GenderID;AgeTo;ScoreDivisionID;DistanceID;StrokeID;TotalScore'
        DescFields = 'GenderID;AgeTo;TotalScore'
      end>
    IndexName = 'idxEventREL'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.KeyFields = 'EntrantID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SeedDate AS DATETIME;'
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      'DECLARE @DoEvent AS BIT;'
      'DECLARE @DoLockedSession AS BIT;'
      ''
      'SET @SeedDate = :AGESEEDDATE; --'#39'2021-08-01'#39'; --'
      'SET @SDate = :DTSTART; --'#39'2022-01-27'#39'; -- '
      'SET @EDate = :DTEND; --'#39'2022-01-28'#39'; -- '
      'SET @DoEvent = :DOEVENT;'
      'SET @DoLockedSession = :DOLOCKEDSESSION;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp4'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp4;'
      ''
      '-- build a list of division with it'#39's members'
      'SELECT ScoreDivisionID,'
      '       MemberID'
      'INTO #tmp4'
      'FROM ScoreDivision'
      '    LEFT JOIN Member'
      '        ON ScoreDivision.GenderID = Member.GenderID'
      'WHERE dbo.SwimmerAge(@SeedDate, member.DOB) >= AgeFrom'
      '      AND dbo.SwimmerAge(@SeedDate, member.DOB) <= AgeTo;'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp1'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp1;'
      ''
      '-- CALCULATE PLACE'
      'SELECT ScoreDivisionID,'
      '       [Event].DistanceID,'
      '       [Event].StrokeID,'
      '       #tmp4.MemberID,'
      '       Entrant.EntrantID,'
      '       CASE @DoEvent'
      '       WHEN 1 THEN'
      
        '       dbo.RELEventPlace([Event].[EventID], Entrant.MemberID, Sc' +
        'oreDivisionID, @SeedDate)'
      '       WHEN 0 THEN'
      
        '       dbo.RELHeatPlace([HeatIndividual].[HeatID], Entrant.Membe' +
        'rID, ScoreDivisionID, @SeedDate)'
      '       ELSE 0'
      '       END AS Place'
      'INTO #tmp1'
      'FROM #tmp4'
      '    INNER JOIN Entrant'
      '        ON #tmp4.MemberID = Entrant.MemberID'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN [Event]'
      '        ON HeatIndividual.EventID = [Event].EventID'
      '    INNER JOIN [Session]'
      '        ON Event.SessionID = [Session].SessionID'
      'WHERE [Session].SessionStart >= @SDate'
      '      AND [Session].SessionStart <= @EDate'
      '      AND Entrant.MemberID IS NOT NULL'
      '      AND [Session].SessionStatusID <= (CASE'
      
        '                                           WHEN @DoLockedSession' +
        ' = 1 THEN'
      '                                               2'
      '                                           ELSE'
      '                                               1'
      '                                       END);'
      ''
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp2'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp2;'
      ''
      '-- CALCULATE POINTS'
      'SELECT #tmp1.ScoreDivisionID,'
      '       #tmp1.MemberID,'
      '       #tmp1.DistanceID,'
      '       #tmp1.StrokeID,'
      '       dbo.EntrantScore(#tmp1.EntrantID, #tmp1.Place) AS Points'
      'INTO #tmp2'
      'FROM #tmp1'
      '    LEFT JOIN ScorePoints'
      '        ON #tmp1.Place = ScorePoints.Place'
      'ORDER BY MemberID ASC;'
      ''
      ''
      ''
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp3'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp3;'
      ''
      '-- CALCULATE TOTAL-SCORE'
      'SELECT #tmp2.ScoreDivisionID,'
      '       #tmp2.StrokeID,'
      '       #tmp2.DistanceID,'
      '       #tmp2.MemberID,'
      '       SUM(#tmp2.Points) AS TotalScore'
      'INTO #tmp3'
      'FROM #tmp2'
      'GROUP BY #tmp2.ScoreDivisionID,'
      '         #tmp2.StrokeID,'
      '         #tmp2.DistanceID,'
      '         #tmp2.MemberID;'
      ''
      ''
      '-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT '
      'SELECT ScoreDivision.GenderID,'
      '       ScoreDivision.AgeTo,'
      '       #tmp3.StrokeID,'
      '       #tmp3.DistanceID,'
      '       #tmp3.ScoreDivisionID,'
      '       #tmp3.TotalScore,'
      '       ScoreDivision.Caption AS DivisionStr,'
      
        '       SUBSTRING(CONCAT(FirstName, '#39' '#39', UPPER(LastName)), 0, 50)' +
        ' AS MemberNameStr,'
      
        '       SUBSTRING(CONCAT(Distance.Caption, '#39' '#39', Stroke.Caption), ' +
        '0, 50) AS DistStrokeStr,'
      '       Gender.Caption AS GenderStr'
      'FROM #tmp3'
      '    INNER JOIN Member'
      '        ON #tmp3.MemberID = Member.MemberID'
      '    INNER JOIN Stroke'
      '        ON #tmp3.StrokeID = Stroke.StrokeID'
      '    INNER JOIN Distance'
      '        ON #tmp3.DistanceID = Distance.DistanceID'
      '    INNER JOIN ScoreDivision'
      '        ON #tmp3.ScoreDivisionID = ScoreDivision.ScoreDivisionID'
      '    INNER JOIN Gender'
      '        ON Member.GenderID = Gender.GenderID'
      '-- NOTE: final sort index applied in FireDAC '
      'ORDER BY GenderID DESC,'
      '         AgeTo DESC,'
      '         ScoreDivisionID DESC;'
      ''
      'DROP TABLE #tmp3;'
      'DROP TABLE #tmp2;'
      'DROP TABLE #tmp1;'
      'DROP TABLE #tmp4;'
      ''
      ''
      ''
      '')
    Left = 64
    Top = 304
    ParamData = <
      item
        Name = 'AGESEEDDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44562d
      end
      item
        Name = 'DTSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DTEND'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44589d
      end
      item
        Name = 'DOEVENT'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'DOLOCKEDSESSION'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end>
  end
  object DSEventREL: TfrxDBDataset
    UserName = 'Detail'
    CloseDataSource = False
    DataSet = qryEventREL
    BCDToCurrency = False
    Left = 136
    Top = 304
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
    Transparency = True
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
    Left = 352
    Top = 160
  end
  object frxMemABSUno: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43878.671749803200000000
    ReportOptions.LastChange = 44796.591145289300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}')
    Left = 688
    Top = 19
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = frxDSMemABSUno
        DataSetName = 'Detail'
      end>
    Variables = <
      item
        Name = ' LeaderBoard'
        Value = Null
      end
      item
        Name = 'IsModeABS'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '2),'#39'ABSOLUTE'#39','#39'DIVISION'#39')'
      end
      item
        Name = 'IsModeEVENT'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '3) ,'#39'EVENT'#39','#39'HEAT'#39')'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 277.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      EndlessHeight = True
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 77.139146670000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object SCM_HeaderCaption: TfrxMemoView
          AllowVectorExport = True
          Left = 7.378015000000000000
          Top = 0.889765000000000000
          Width = 294.803340000000000000
          Height = 30.236240000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object SCM_HeaderNickName: TfrxMemoView
          AllowVectorExport = True
          Left = 7.378015000000000000
          Top = 26.456710000000000000
          Width = 294.803340000000000000
          Height = 22.677180000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
          ParentFont = False
        end
        object MemoH2: TfrxMemoView
          AllowVectorExport = True
          Left = 706.582701290000000000
          Top = 3.134368710000000000
          Width = 329.653680000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeStr"]')
          ParentFont = False
        end
        object LineH1: TfrxLineView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 72.913420000000000000
          Width = 1028.032160000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 451.653835000000000000
          Top = 3.112863330000000000
          Width = 143.622140000000000000
          Height = 46.021026660000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          GapY = -0.800000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTRANTS'
            'LEADERBOARD')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 706.453310000000000000
          Top = 26.456710000000000000
          Width = 329.137910000000000000
          Height = 22.677180000000000000
          DataField = 'ModeSubStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeSubStr"]')
          ParentFont = False
        end
        object dsHeaderRangeStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 6.666666670000000000
          Top = 43.769016670000000000
          Width = 1028.630180000000000000
          Height = 26.456710000000000000
          DataField = 'RangeStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsHeader."RangeStr"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 7.897650000000000000
        Top = 340.157700000000000000
        Width = 1046.929810000000000000
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 15268095
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 219.212740000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."MemberID"'
        KeepTogether = True
        object MembersName: TfrxMemoView
          AllowVectorExport = True
          Left = 76.149660000000000000
          Top = 1.889765000000000000
          Width = 393.071120000000000000
          Height = 26.456710000000000000
          DataField = 'MemberNameStr'
          DataSet = frxDSMemABSUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."MemberNameStr"]')
          ParentFont = False
        end
        object TotalPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 2.354360000000000000
          Top = 1.889765000000000000
          Width = 68.031540000000000000
          Height = 26.456710000000000000
          DataField = 'TotalScore'
          DataSet = frxDSMemABSUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            '[Detail."TotalScore"]')
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
        Height = 43.478175480000000000
        ParentFont = False
        Top = 272.126160000000000000
        Width = 1046.929810000000000000
        Columns = 5
        ColumnWidth = 207.874015748031000000
        DataSet = frxDSMemABSUno
        DataSetName = 'Detail'
        KeepTogether = True
        RowCount = 0
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 1.000000000000000000
          Top = 1.491960000000000000
          Width = 194.488250000000000000
          Height = 39.897650000000000000
          Frame.Typ = []
        end
        object DistanceStroke: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 3.354838710000000000
          Width = 128.450216670000000000
          Height = 22.677180000000000000
          DataSet = frxDSMemABSUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."DistStrokeStr"]')
          ParentFont = False
        end
        object frxDSPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 133.498085160000000000
          Top = 2.919354840000000000
          Width = 57.795300000000000000
          Height = 23.677180000000000000
          DataSet = frxDSMemABSUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Fill.Style = bsClear
          HAlign = haCenter
          Memo.UTF8W = (
            '[Detail."Place"] : [Detail."Score"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object frxMemABSEvUnoRaceTime: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.290322580000000000
          Top = 21.298411610000000000
          Width = 90.488250000000000000
          Height = 18.897650000000000000
          DataField = 'RaceTime'
          DataSet = frxDSMemABSUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."RaceTime"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 408.189240000000000000
        Width = 1046.929810000000000000
        object MemoH3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed on ')
          ParentFont = False
        end
        object PrintedOnDate: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object MemoH4: TfrxMemoView
          AllowVectorExport = True
          Left = 691.653990000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 42.010513330000000000
        Top = 154.960730000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."GenderID"'
        object frxDSEventCaption: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 0.666666660000000000
          Top = 9.000000000000000000
          Width = 396.073593340000000000
          Height = 30.236240000000000000
          DataField = 'Caption'
          DataSet = frxDSMemABSUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."Caption"]')
          ParentFont = False
        end
      end
    end
  end
  object qryMemABSUno: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxMemberScore'
        Fields = 'GenderID;TotalScore;MemberID'
        DescFields = 'GenderID;TotalScore'
        Options = [soDescNullLast]
      end>
    IndexName = 'idxMemberScore'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.KeyFields = 'EntrantID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      'DECLARE @DoEvent AS BIT;'
      'DECLARE @DoLockedSession AS BIT;'
      ''
      'SET @SDate = :DTSTART; --'#39'2022-02-10'#39'; -- '
      'SET @EDate = :DTEND; --'#39'2022-02-10'#39'; -- '
      'SET @DoEvent = :DOEVENT;'
      'SET @DoLockedSession = :DOLOCKEDSESSION;'
      ''
      '-- NOT REQUIRED ... '
      '-- Prior to calling here '
      
        '-- End date has been recoded to be one hour more than start date' +
        '.'
      ''
      '-- Midnight floor of current date'
      'SET @SDate = CONVERT(DATETIME, DATEDIFF(DAY, 0, @SDate))'
      '-- Ceiling'
      
        'SET @EDate = CONVERT(DATETIME, DATEDIFF(DAY, 0, DATEADD(d, 1, @E' +
        'Date)))'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp1'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp1;'
      ''
      '-- CALCULATE PLACE'
      'SELECT Entrant.MemberID,'
      '       Entrant.EntrantID,'
      '       Entrant.RaceTime,'
      '       [Event].StrokeID,'
      '       [Event].DistanceID,'
      '       [Event].Caption AS EventDetailStr, '
      '       CASE @DoEvent'
      '           WHEN 1 THEN'
      
        '               dbo.ABSEventPlace([Event].[EventID], Entrant.Memb' +
        'erID)'
      '           WHEN 0 THEN'
      
        '               dbo.ABSHeatPlace([HeatIndividual].[HeatID], Entra' +
        'nt.MemberID)'
      '           ELSE'
      '               0'
      '       END AS Place'
      'INTO #tmp1'
      'FROM Entrant'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN [Event]'
      '        ON HeatIndividual.EventID = [Event].EventID'
      '    INNER JOIN [Session]'
      '        ON [Event].SessionID = [Session].SessionID'
      'WHERE [Session].SessionStart >= @SDate'
      '      AND [Session].SessionStart <= @EDate'
      '      AND Entrant.MemberID IS NOT NULL'
      '      AND [Session].SessionStatusID <= (CASE'
      
        '                                            WHEN @DoLockedSessio' +
        'n = 1 THEN'
      '                                                2'
      '                                            ELSE'
      '                                                1'
      '                                        END'
      '                                       );'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp2'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp2;'
      ''
      '-- CACLUATE A SCORE BASED ON PLACE '
      'SELECT #tmp1.StrokeID,'
      '       #tmp1.DistanceID,'
      '       #tmp1.EntrantID,'
      '       #tmp1.MemberID,'
      '       dbo.EntrantScore(#tmp1.EntrantID, #tmp1.Place) AS Score'
      'INTO #tmp2'
      'FROM #tmp1'
      '    LEFT JOIN ScorePoints'
      '        ON #tmp1.Place = ScorePoints.Place'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp3'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp3;'
      ''
      '-- CALCULATE TOTAL-SCORE'
      'SELECT #tmp2.MemberID,'
      '       SUM(#tmp2.Score) AS TotalScore'
      'INTO #tmp3'
      'FROM #tmp2'
      'GROUP BY #tmp2.MemberID;'
      ''
      '-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT '
      'SELECT #tmp2.StrokeID,'
      '       #tmp2.DistanceID,'
      '       Member.GenderID,'
      '       Member.MemberID,'
      '       Gender.Caption,'
      
        '       SUBSTRING(CONCAT(Member.FirstName, '#39' '#39', UPPER(Member.Last' +
        'Name)), 0, 50) AS MemberNameStr,'
      
        '       SUBSTRING(CONCAT(Distance.Caption, '#39' '#39', Stroke.Caption), ' +
        '0, 50) AS DistStrokeStr,'
      '       dbo.SwimTimeToString(#tmp1.RaceTime) AS RaceTime,'
      '       #tmp1.Place,'
      '       #tmp2.Score,'
      '       #tmp3.TotalScore,'
      '       #tmp1.EventDetailStr'
      'FROM #tmp2'
      '    INNER JOIN #tmp1'
      '        ON #tmp2.EntrantID = #tmp1.EntrantID'
      '    INNER JOIN Member'
      '        ON #tmp1.MemberID = Member.MemberID'
      '    INNER JOIN #tmp3'
      '        ON #tmp1.MemberID = #tmp3.MemberID'
      '    INNER JOIN Stroke'
      '        ON #tmp2.StrokeID = Stroke.StrokeID'
      '    INNER JOIN Distance'
      '        ON #tmp2.DistanceID = Distance.DistanceID'
      '    INNER JOIN Gender'
      '        ON Member.GenderID = Gender.GenderID'
      ''
      '-- NOTE: final sort index applied in FireDAC        '
      'ORDER BY Member.MemberID DESC;'
      ''
      'DROP TABLE #tmp3;'
      'DROP TABLE #tmp2;'
      'DROP TABLE #tmp1;'
      ''
      ''
      ''
      '')
    Left = 520
    Top = 19
    ParamData = <
      item
        Name = 'DTSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DTEND'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DOEVENT'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'DOLOCKEDSESSION'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end>
  end
  object frxDSMemABSUno: TfrxDBDataset
    UserName = 'Detail'
    CloseDataSource = False
    DataSet = qryMemABSUno
    BCDToCurrency = False
    Left = 608
    Top = 19
  end
  object frxMemRELUno: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43878.671749803200000000
    ReportOptions.LastChange = 44796.591145289300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.'
      '{'
      '**********Script from parent report**********'
      'begin'
      ''
      'end.'
      '}')
    Left = 688
    Top = 67
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = frxDSMemRELUno
        DataSetName = 'Detail'
      end>
    Variables = <
      item
        Name = ' LeaderBoard'
        Value = Null
      end
      item
        Name = 'IsModeABS'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '2),'#39'ABSOLUTE'#39','#39'DIVISION'#39')'
      end
      item
        Name = 'IsModeEVENT'
        Value = 
          'IIF((<frxHeader."ScoreMode"> = 1) OR (<frxHeader."ScoreMode"> = ' +
          '3) ,'#39'EVENT'#39','#39'HEAT'#39')'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 277.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      EndlessHeight = True
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 81.104978330000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 8.000000000000000000
          Top = 0.435683330000000000
          Width = 294.803340000000000000
          Height = 30.236240000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 8.000000000000000000
          Top = 26.002628330000000000
          Width = 294.803340000000000000
          Height = 22.677180000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 707.204686290000000000
          Top = 2.680287040000000000
          Width = 329.653680000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeStr"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 452.275820000000000000
          Top = 2.658781660000000000
          Width = 143.622140000000000000
          Height = 46.021026660000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          GapY = -0.800000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTRANTS'
            'LEADERBOARD')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 707.075295000000000000
          Top = 26.002628330000000000
          Width = 329.137910000000000000
          Height = 22.677180000000000000
          DataField = 'ModeSubStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsHeader."ModeSubStr"]')
          ParentFont = False
        end
        object dsHeaderRangeStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 7.955318330000000000
          Top = 42.648268330000000000
          Width = 1027.296846670000000000
          Height = 26.456710000000000000
          DataField = 'RangeStr'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsHeader."RangeStr"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 8.181045000000000000
          Top = 72.459338330000000000
          Width = 1028.032160000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 7.897650000000000000
        Top = 396.850650000000000000
        Width = 1046.929810000000000000
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = 15268095
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 226.771800000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."MemberID"'
        KeepTogether = True
        object MembersName: TfrxMemoView
          AllowVectorExport = True
          Left = 76.149660000000000000
          Top = 1.889765000000000000
          Width = 393.071120000000000000
          Height = 26.456710000000000000
          DataField = 'MemberNameStr'
          DataSet = frxDSMemRELUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."MemberNameStr"]')
          ParentFont = False
        end
        object TotalPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 2.354360000000000000
          Top = 1.889765000000000000
          Width = 68.031540000000000000
          Height = 26.456710000000000000
          DataField = 'TotalScore'
          DataSet = frxDSMemRELUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            '[Detail."TotalScore"]')
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
        Height = 43.478175480000000000
        ParentFont = False
        Top = 328.819110000000000000
        Width = 1046.929810000000000000
        Columns = 5
        ColumnWidth = 207.874015748031000000
        DataSet = frxDSMemRELUno
        DataSetName = 'Detail'
        KeepTogether = True
        RowCount = 0
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 1.000000000000000000
          Top = 1.491960000000000000
          Width = 194.488250000000000000
          Height = 39.897650000000000000
          Frame.Typ = []
        end
        object DistanceStroke: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 3.354838710000000000
          Width = 128.450216670000000000
          Height = 22.677180000000000000
          DataSet = frxDSMemRELUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."DistStrokeStr"]')
          ParentFont = False
        end
        object frxDSPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 133.498085160000000000
          Top = 2.919354840000000000
          Width = 57.795300000000000000
          Height = 23.677180000000000000
          DataSet = frxDSMemRELUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Fill.Style = bsClear
          HAlign = haCenter
          Memo.UTF8W = (
            '[Detail."Place"] : [Detail."Score"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object frxMemABSEvUnoRaceTime: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.290322580000000000
          Top = 21.298411610000000000
          Width = 90.488250000000000000
          Height = 18.897650000000000000
          DataSet = frxDSMemRELUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."RaceTime"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 464.882190000000000000
        Width = 1046.929810000000000000
        object MemoH3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed on ')
          ParentFont = False
        end
        object PrintedOnDate: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object MemoH4: TfrxMemoView
          AllowVectorExport = True
          Left = 691.653990000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 42.010513330000000000
        Top = 162.519790000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."GenderID"'
        object frxDSEventCaption: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 0.666666660000000000
          Top = 9.000000000000000000
          Width = 396.073593340000000000
          Height = 30.236240000000000000
          DataSet = frxDSMemRELUno
          DataSetName = 'Detail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Detail."GenderStr"]')
          ParentFont = False
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 27.343846670000000000
        Top = 279.685220000000000000
        Width = 1046.929810000000000000
        Condition = 'Detail."ScoreDivisionID"'
        object MemABSUnoDivisionStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 2.666666670000000000
          Top = 1.894866670000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'DivisionStr'
          DataSet = frxDSMemRELUno
          DataSetName = 'Detail'
          Frame.Typ = []
          GapY = -0.800000000000000000
          Memo.UTF8W = (
            '[Detail."DivisionStr"]')
        end
      end
    end
  end
  object qryMemRELUno: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxDivision'
        Fields = 'GenderID;TotalScore;AgeTo;ScoreDivisionID'
        DescFields = 'GenderID;AgeTo;TotalScore'
        Options = [soDescNullLast]
      end>
    IndexName = 'idxDivision'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.KeyFields = 'EntrantID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SeedDate AS DATETIME;'
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      'DECLARE @DoEvent AS BIT;'
      'DECLARE @DoLockedSession AS BIT;'
      ''
      'SET @SeedDate = :AGESEEDDATE;'
      'SET @SDate = :DTSTART;'
      'SET @EDate = :DTEND;'
      'SET @DoEvent = :DOEVENT;'
      'SET @DoLockedSession = :DOLOCKEDSESSION;'
      ''
      '-- NOT REQUIRED ... '
      '-- Prior to calling here '
      
        '-- End date has been recoded to be one hour more than start date' +
        '.'
      ''
      '-- Midnight floor of current date'
      'SET @SDate = CONVERT(DATETIME, DATEDIFF(DAY, 0, @SDate))'
      '-- Ceiling'
      
        'SET @EDate = CONVERT(DATETIME, DATEDIFF(DAY, 0, DATEADD(d, 1, @E' +
        'Date)))'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp4'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp4;'
      ''
      '-- build a list of divisions with it'#39's members'
      'SELECT ScoreDivisionID,'
      '       MemberID'
      'INTO #tmp4'
      'FROM ScoreDivision'
      '    LEFT JOIN Member'
      '        ON ScoreDivision.GenderID = Member.GenderID'
      'WHERE dbo.SwimmerAge(@SeedDate, member.DOB) >= AgeFrom'
      '      AND dbo.SwimmerAge(@SeedDate, member.DOB) <= AgeTo;'
      ''
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp1'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp1;'
      ''
      '-- CALCULATE PLACE'
      'SELECT ScoreDivisionID,'
      '       Entrant.MemberID,'
      '       Entrant.EntrantID,'
      '       Entrant.RaceTime,'
      '       [Event].StrokeID,'
      '       [Event].DistanceID,'
      '       [Event].Caption AS EventDetailStr,'
      '       CASE @DoEvent'
      '           WHEN 1 THEN'
      
        '               dbo.RELEventPlace([Event].[EventID], Entrant.Memb' +
        'erID, #tmp4.ScoreDivisionID, @SeedDate)'
      '           WHEN 0 THEN'
      
        '               dbo.RELHeatPlace([HeatIndividual].[HeatID], Entra' +
        'nt.MemberID, ScoreDivisionID, @SeedDate)'
      '           ELSE'
      '               0'
      '       END AS Place'
      'INTO #tmp1'
      'FROM #tmp4'
      '    INNER JOIN Entrant'
      '        ON #tmp4.MemberID = Entrant.MemberID'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    INNER JOIN [Event]'
      '        ON HeatIndividual.EventID = [Event].EventID'
      '    INNER JOIN [Session]'
      '        ON [Event].SessionID = [Session].SessionID'
      'WHERE [Session].SessionStart >= @SDate'
      '      AND [Session].SessionStart <= @EDate'
      '      AND Entrant.MemberID IS NOT NULL'
      '      AND [Session].SessionStatusID <= (CASE'
      
        '                                            WHEN @DoLockedSessio' +
        'n = 1 THEN'
      '                                                2'
      '                                            ELSE'
      '                                                1'
      '                                        END'
      '                                       );'
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp2'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp2;'
      ''
      '-- CACLUATE A SCORE BASED ON PLACE '
      'SELECT #tmp1.ScoreDivisionID,'
      '       #tmp1.MemberID,'
      '       #tmp1.EntrantID,'
      '       #tmp1.RaceTime,'
      '       #tmp1.StrokeID,'
      '       #tmp1.DistanceID,'
      '       #tmp1.EventDetailStr,'
      '       #tmp1.Place,'
      '       dbo.EntrantScore(#tmp1.EntrantID, #tmp1.Place) AS Score'
      'INTO #tmp2'
      'FROM #tmp1'
      '    LEFT JOIN ScorePoints'
      '        ON #tmp1.Place = ScorePoints.Place'
      ''
      ''
      'IF OBJECT_ID('#39'tempdb..#tmp3'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmp3;'
      ''
      '-- CALCULATE TOTAL-SCORE'
      'SELECT #tmp2.MemberID,'
      '       SUM(#tmp2.Score) AS TotalScore'
      'INTO #tmp3'
      'FROM #tmp2'
      'GROUP BY #tmp2.MemberID;'
      ''
      '-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT '
      'SELECT #tmp2.ScoreDivisionID,'
      '       #tmp2.MemberID,'
      '       #tmp2.StrokeID,'
      '       #tmp2.DistanceID,'
      '       #tmp3.TotalScore,'
      
        '       SUBSTRING(CONCAT(FirstName, '#39' '#39', UPPER(LastName)), 0, 50)' +
        ' AS MemberNameStr,'
      
        '       SUBSTRING(CONCAT(Distance.Caption, '#39' '#39', Stroke.Caption), ' +
        '0, 50) AS DistStrokeStr,'
      '       ScoreDivision.Caption AS DivisionStr,'
      '       ScoreDivision.GenderID,'
      '       ScoreDivision.AgeTo,'
      '       Gender.Caption AS GenderStr,'
      '       dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTime,'
      '       #tmp2.Place,'
      '       #tmp2.Score'
      '        --[Event].Caption AS EventDetailStr'
      'FROM #tmp2'
      '    INNER JOIN #tmp3'
      '        ON #tmp2.MemberID = #tmp3.MemberID'
      '    INNER JOIN Member'
      '        ON #tmp2.MemberID = Member.MemberID'
      '    INNER JOIN Stroke'
      '        ON #tmp2.StrokeID = Stroke.StrokeID'
      '    INNER JOIN Distance'
      '        ON #tmp2.DistanceID = Distance.DistanceID'
      '    INNER JOIN ScoreDivision'
      '        ON #tmp2.ScoreDivisionID = ScoreDivision.ScoreDivisionID'
      '    INNER JOIN Gender'
      '        ON Member.GenderID = Gender.GenderID'
      '    INNER JOIN Entrant'
      '        ON #tmp2.EntrantID = Entrant.EntrantID'
      
        '    --JOIN [Event] ON #tmp2.StrokeID = [Event].StrokeID AND #tmp' +
        '2.DistanceID = [Event].DistanceID'
      ''
      '-- NOTE: final sort index applied in FireDAC        '
      'ORDER BY GenderID DESC;'
      ''
      'DROP TABLE #tmp3;'
      'DROP TABLE #tmp2;'
      'DROP TABLE #tmp1;'
      'DROP TABLE #tmp4;'
      ''
      ''
      ''
      '')
    Left = 520
    Top = 67
    ParamData = <
      item
        Name = 'AGESEEDDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44409d
      end
      item
        Name = 'DTSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DTEND'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 44588d
      end
      item
        Name = 'DOEVENT'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'DOLOCKEDSESSION'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end>
  end
  object frxDSMemRELUno: TfrxDBDataset
    UserName = 'Detail'
    CloseDataSource = False
    DataSet = qryMemRELUno
    BCDToCurrency = False
    Left = 608
    Top = 67
  end
  object qryGetSessionCount: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      'DECLARE @SwimClubID AS INTEGER;'
      ''
      ''
      'SET @SDate = :SDATE; --'#39'2021-01-01'#39';'
      'SET @EDate = :EDATE; --'#39'2022-01-20'#39';'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'WITH myCTE'
      'AS (SELECT COUNT(*) AS RowsInView'
      '    FROM [dbo].[Session]'
      '    WHERE [Session].SessionStart >= @SDate'
      
        '          AND [Session].SessionStart <= @EDate AND [Session].Swi' +
        'mClubID = @SwimClubID)'
      'SELECT myCTE.RowsInView AS SessionCount'
      'FROM myCTE;')
    Left = 512
    Top = 304
    ParamData = <
      item
        Name = 'SDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qryGetStartOfSession: TFDQuery
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SessionID AS INTEGER;'
      'SET @SessionID = :SESSIONID;'
      ''
      
        '-- Select rows from a Table or View '#39'[Session]'#39' in schema '#39'[dbo]' +
        #39
      'SELECT SessionStart'
      'FROM [dbo].[Session]'
      'WHERE SessionID = @SessionID;')
    Left = 504
    Top = 368
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 70
      end>
  end
  object dsGetStartOfSession: TDataSource
    DataSet = qryGetStartOfSession
    Left = 624
    Top = 368
  end
  object qryABSREL_A: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexesActive = False
    IndexFieldNames = 'ScoreDivisionID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime]
    FormatOptions.FmtDisplayDateTime = 'dd mmm YYYY HH:MM'
    FormatOptions.FmtDisplayDate = 'dd mmm YYYYY'
    FormatOptions.FmtDisplayTime = 'nn:mm.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'ScoreDivisionID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SessionID AS INT;'
      'DECLARE @SessionStart AS DATETIME;'
      'SET @SessionID = :SESSIONID; --9;'
      'SET @SessionStart = GETDATE();'
      'IF @SessionStart IS NULL SET @SessionStart = GETDATE();'
      ''
      ''
      ''
      
        '/* A list of divisions and the swimclub members that qualify for' +
        ' those division */'
      'IF OBJECT_ID('#39'tempdb..#tempDivMember'#39') IS NOT NULL'
      '    DROP TABLE #tempDivMember;'
      ''
      'SELECT Member.MemberID'
      '    , ScoreDivisionID'
      'INTO #tempDivMember'
      'FROM ScoreDivision'
      'JOIN Member'
      '    ON ScoreDivision.GenderID = Member.GenderID'
      'WHERE dbo.SwimmerAge(@SessionStart, Member.DOB) <= AgeTo'
      '    AND dbo.SwimmerAge(@SessionStart, Member.DOB) >= AgeFrom;'
      ''
      ''
      
        '/* A list of '#39'CLOSED'#39' events for the SESSION and the members who' +
        ' participated in those events */'
      '-- ABSOLUTE PLACE WITHIN EVENT/HEAT'
      'IF OBJECT_ID('#39'tempdb..#tempTblA'#39') IS NOT NULL'
      '    DROP TABLE #tempTblA;'
      ''
      'SELECT'
      ' [Event].EventID '
      '  ,Entrant.MemberID '
      ' ,HeatIndividual.HeatID'
      
        ', dbo.ABSEventPlace([Event].EventID, Entrant.MemberID) AS ABSEve' +
        'ntPlace'
      
        ', dbo.ABSHeatPlace(HeatIndividual.HeatID, Entrant.MemberID) AS A' +
        'BSHeatPlace'
      'INTO #tempTblA'
      'FROM [Event] '
      
        'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.Ev' +
        'entID'
      'LEFT JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE [Event].SessionID = @SessionID'
      '    -- AND [Event].EventStatusID = 2'
      '    AND Entrant.MemberID IS NOT NULL'
      'AND (Entrant.RaceTime IS NOT NULL)'
      #9#9'    AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020'
      #9#9'    AND (Entrant.IsScratched <> 1) '#9'-- added 16/5/2020    '
      ';'
      ''
      ''
      
        '-- JOIN Event members on divmembers - find the RELATIVE PLACE wi' +
        'thin the division for the EVENT/HEAT'
      'IF OBJECT_ID('#39'tempdb..#tempTblB'#39') IS NOT NULL'
      '    DROP TABLE #tempTblB;'
      'SELECT'
      '#tempTblA.EventID'
      ',#tempTblA.MemberID'
      ',#tempDivMember.ScoreDivisionID AS DivisionID'
      ',#tempTblA.ABSEventPlace'
      ',#tempTblA.ABSHeatPlace '
      
        ', dbo.RELEventPlace([#tempTblA].EventID, #tempTblA.MemberID, #te' +
        'mpDivMember.ScoreDivisionID, @SessionStart) AS RELEventPlace'
      
        ', dbo.RELHeatPlace([#tempTblA].HeatID, #tempTblA.MemberID, #temp' +
        'DivMember.ScoreDivisionID, @SessionStart) AS RELHeatPlace'
      'INTO #tempTblB'
      'FROM #tempDivMember'
      
        'INNER JOIN #tempTblA ON [#tempDivMember].MemberID = [#tempTblA].' +
        'MemberID'
      ''
      '/* FINALLY'
      'Find Scores'
      'Build data for FastReport'
      ' */'
      ''
      'SELECT '
      '#tempTblB.MemberID'
      
        ', CONCAT(Member.FirstName, '#39' '#39' , UPPER(Member.LastName)) AS FNAM' +
        'E'
      ', #tempTblB.DivisionID'
      ', ScoreDivision.GenderID'
      ', Gender.Caption AS GenderStr'
      ', ScoreDivision.Caption AS DivisionStr'
      ', #tempTblB.EventID'
      ', [Event].SessionID'
      ', [Event].Caption AS EventStr'
      ', Distance.Caption AS DistanceStr'
      ', Stroke.Caption AS StrokeStr'
      ', ABSEventPlace'
      ', sp1.Points AS ABSEventPoints'
      ', ABSHeatPlace'
      ', sp2.Points AS ABSHeatPoints'
      ', RELEventPlace'
      ', sp3.Points AS RELEventPoints'
      ', RELHeatPlace'
      ', sp4.Points AS RELHeatPoints'
      ''
      'FROM #tempTblB'
      
        'INNER JOIN ScorePoints AS sp1 ON #tempTblB.ABSEventPlace = sp1.P' +
        'lace'
      
        'INNER JOIN ScorePoints AS sp2 ON #tempTblB.ABSHeatPlace = sp2.Pl' +
        'ace'
      
        'INNER JOIN ScorePoints AS sp3 ON #tempTblB.RELEventPlace = sp3.P' +
        'lace'
      
        'INNER JOIN ScorePoints AS sp4 ON #tempTblB.RELHeatPlace = sp4.Pl' +
        'ace'
      'INNER JOIN [Event] ON #tempTblB.EventID = [Event].EventID'
      'INNER JOIN Distance ON [Event].DistanceID = Distance.DistanceID'
      'INNER JOIN Stroke ON [Event].StrokeID = Stroke.StrokeID'
      'INNER JOIN Member ON #tempTblB.MemberID = Member.MemberID'
      
        'INNER JOIN ScoreDivision ON #tempTblB.DivisionID = ScoreDivision' +
        '.ScoreDivisionID'
      'INNER JOIN Gender ON ScoreDivision.GenderID = Gender.GenderID'
      ''
      'ORDER BY DivisionID, MemberID'
      ';'
      ''
      ''
      '')
    Left = 464
    Top = 560
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 9
      end>
  end
  object frxDBABSREL_A: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryABSREL_A
    BCDToCurrency = False
    Left = 560
    Top = 560
  end
  object frxABSREL_A: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43429.469572048600000000
    ReportOptions.LastChange = 43445.669209351900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 648
    Top = 560
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = frxDBABSREL_A
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
      Columns = 1
      ColumnWidth = 190.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 105.826840000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object frxDScSwimClub: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 1.779530000000000000
          Top = 46.590600000000000000
          Width = 714.331170000000000000
          StretchMode = smMaxHeight
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 4.000000000000000000
        end
        object frxDBDataset2NickName: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
        end
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 188.976500000000000000
          Top = 52.913420000000000000
          Width = 192.756030000000000000
          Height = 26.456710000000000000
          Fill.BackColor = cl3DLight
          Frame.Typ = []
        end
        object Shape2: TfrxShapeView
          AllowVectorExport = True
          Left = 434.645950000000000000
          Top = 52.913420000000000000
          Width = 192.756030000000000000
          Height = 26.456710000000000000
          Fill.BackColor = cl3DLight
          Frame.Typ = []
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 188.976500000000000000
          Top = 56.692950000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'EVENT')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 434.645950000000000000
          Top = 56.692950000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'HEAT')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 188.976500000000000000
          Top = 83.149660000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'ABSOLUTE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 279.685220000000000000
          Top = 83.149660000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATIVE')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 434.645950000000000000
          Top = 83.149660000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'ABSOLUTE')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 525.354670000000000000
          Top = 83.149660000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATIVE')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 461.102660000000000000
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
        Height = 30.236240000000000000
        Top = 185.196970000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."DivisionID"'
        KeepTogether = True
        object frxDSDivisionStr: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'DivisionStr'
          DataSet = frxDBABSREL_A
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."DivisionStr"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 291.023810000000000000
        Width = 718.110700000000000000
        DataSet = frxDBABSREL_A
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object frxDSEventStr: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_A
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."DistanceStr"] [frxDS."StrokeStr"]')
        end
        object frxDSABSplace: TfrxMemoView
          AllowVectorExport = True
          Left = 188.976500000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_A
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDS."ABSEventPlace"] ')
          ParentFont = False
        end
        object frxDSABSPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 222.992270000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_A
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDS."ABSEventPoints">  #n%2.1f]')
          ParentFont = False
        end
        object frxDSABSplaceH: TfrxMemoView
          AllowVectorExport = True
          Left = 434.645950000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_A
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."ABSHeatPlace"]')
          ParentFont = False
        end
        object frxDSABSPointsH: TfrxMemoView
          AllowVectorExport = True
          Left = 468.661720000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_A
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDS."ABSHeatPoints">  #n%2.1f]')
          ParentFont = False
        end
        object frxDSRELplace: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_A
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."RELEventPlace"]')
          ParentFont = False
        end
        object frxDSRELPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 328.819110000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_A
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDS."RELEventPoints">  #n%2.1f]')
          ParentFont = False
        end
        object frxDSRELplaceH: TfrxMemoView
          AllowVectorExport = True
          Left = 532.913730000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_A
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."RELHeatPlace"]')
          ParentFont = False
        end
        object frxDSRELPointsH: TfrxMemoView
          AllowVectorExport = True
          Left = 566.929500000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_A
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDS."RELHeatPoints">  #n%2.1f]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 238.110390000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."MemberID"'
        object Shape3: TfrxShapeView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 7.559059999999990000
          Width = 718.110700000000000000
          Height = 22.677180000000000000
          Fill.BackColor = cl3DLight
          Frame.Typ = []
        end
        object frxDSucFName1: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 10.338590000000000000
          Width = 411.968770000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_A
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FName"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 188.976500000000000000
          Top = 11.338590000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Place')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Top = 11.338590000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Place')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 434.645950000000000000
          Top = 11.338590000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Place')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 532.913730000000000000
          Top = 11.338590000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Place')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 468.661720000000000000
          Top = 11.338590000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Points')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 566.929500000000000000
          Top = 11.338590000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Points')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 222.992270000000000000
          Top = 11.338590000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Points')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 328.819110000000000000
          Top = 11.338590000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Points')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 377.953000000000000000
        Width = 718.110700000000000000
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 332.598640000000000000
        Width = 718.110700000000000000
        object SysMemo1: TfrxSysMemoView
          AllowVectorExport = True
          Left = 222.992270000000000000
          Top = 3.000000000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDS."ABSEventPoints">,MasterData1)  #n%4.1f]')
          ParentFont = False
        end
        object SysMemo2: TfrxSysMemoView
          AllowVectorExport = True
          Left = 328.819110000000000000
          Top = 1.000000000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDS."RELEventPoints">,MasterData1)  #n%4.1f]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = 188.976500000000000000
          Top = 3.000000000000000000
          Width = 75.590600000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          AllowVectorExport = True
          Left = 287.244280000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          AllowVectorExport = True
          Left = 427.086890000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line5: TfrxLineView
          AllowVectorExport = True
          Left = 525.354670000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object SysMemo3: TfrxSysMemoView
          AllowVectorExport = True
          Left = 468.661720000000000000
          Top = 1.000000000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDS."ABSHeatPoints">,MasterData1)  #n%4.1f]')
          ParentFont = False
        end
        object SysMemo4: TfrxSysMemoView
          AllowVectorExport = True
          Left = 566.929500000000000000
          Top = 1.000000000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDS."RELHeatPoints">,MasterData1)  #n%4.1f]')
          ParentFont = False
        end
      end
    end
  end
  object frxABSREL_B: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43429.469572048600000000
    ReportOptions.LastChange = 43445.669209351900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 648
    Top = 632
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = frxDBABSREL_B
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
      Columns = 1
      ColumnWidth = 190.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 105.826840000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object frxDScSwimClub: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 1.779530000000000000
          Top = 46.590600000000000000
          Width = 714.331170000000000000
          StretchMode = smMaxHeight
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 4.000000000000000000
        end
        object frxDBDataset2NickName: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
        end
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 325.039580000000000000
          Top = 52.913420000000000000
          Width = 192.756030000000000000
          Height = 26.456710000000000000
          Fill.BackColor = cl3DLight
          Frame.Typ = []
        end
        object Shape2: TfrxShapeView
          AllowVectorExport = True
          Left = 525.354670000000000000
          Top = 52.913420000000000000
          Width = 192.756030000000000000
          Height = 26.456710000000000000
          Fill.BackColor = cl3DLight
          Frame.Typ = []
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 325.039580000000000000
          Top = 56.692950000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'EVENT')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 525.354670000000000000
          Top = 56.692950000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'HEAT')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 325.039580000000000000
          Top = 83.149660000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'ABSOLUTE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 415.748300000000000000
          Top = 83.149660000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATIVE')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 525.354670000000000000
          Top = 83.149660000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'ABSOLUTE')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 616.063390000000000000
          Top = 83.149660000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATIVE')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 411.968770000000000000
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
        Height = 34.015770000000000000
        Top = 185.196970000000000000
        Width = 718.110700000000000000
        Condition = '<frxDS."DistanceID"> + <frxDS."StrokeID">'
        KeepTogether = True
        object frxDSDivisionStr: TfrxMemoView
          AllowVectorExport = True
          Left = -3.779530000000000000
          Top = 3.779530000000000000
          Width = 612.283860000000000000
          Height = 26.456710000000000000
          DataSet = frxDBABSREL_B
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."DistanceStr"] [frxDS."StrokeStr"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 294.803340000000000000
        Width = 718.110700000000000000
        DataSet = frxDBABSREL_B
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object frxDSEventStr: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_B
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FNAME"]')
        end
        object frxDSABSplace: TfrxMemoView
          AllowVectorExport = True
          Left = 332.598640000000000000
          Top = 3.779530000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_B
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDS."ABSEventPlace"] ')
          ParentFont = False
        end
        object frxDSABSPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 366.614410000000000000
          Top = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_B
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDS."ABSEventPoints">  #n%3.1f]')
          ParentFont = False
        end
        object frxDSABSplaceH: TfrxMemoView
          AllowVectorExport = True
          Left = 540.472790000000000000
          Top = 3.779530000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_B
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."ABSHeatPlace"]')
          ParentFont = False
        end
        object frxDSABSPointsH: TfrxMemoView
          AllowVectorExport = True
          Left = 574.488560000000000000
          Top = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_B
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDS."ABSHeatPoints">  #n%3.1f]')
          ParentFont = False
        end
        object frxDSRELplace: TfrxMemoView
          AllowVectorExport = True
          Left = 438.425480000000000000
          Top = 3.779530000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_B
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."RELEventPlace"]')
          ParentFont = False
        end
        object frxDSRELPoints: TfrxMemoView
          AllowVectorExport = True
          Left = 472.441250000000000000
          Top = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_B
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDS."RELEventPoints">  #n%3.1f]')
          ParentFont = False
        end
        object frxDSRELplaceH: TfrxMemoView
          AllowVectorExport = True
          Left = 638.740570000000000000
          Top = 3.779530000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_B
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."RELHeatPlace"]')
          ParentFont = False
        end
        object frxDSRELPointsH: TfrxMemoView
          AllowVectorExport = True
          Left = 672.756340000000000000
          Top = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_B
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDS."RELHeatPoints">  #n%3.1f]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 241.889920000000000000
        Width = 718.110700000000000000
        Condition = 'frxDS."DivisionID"'
        object Shape3: TfrxShapeView
          AllowVectorExport = True
          Left = 0.779530000000000000
          Top = 7.338590000000000000
          Width = 718.110700000000000000
          Height = 22.677180000000000000
          Fill.BackColor = cl3DLight
          Frame.Typ = []
        end
        object frxDSucFName1: TfrxMemoView
          AllowVectorExport = True
          Left = 0.779530000000000000
          Top = 10.118120000000000000
          Width = 423.307360000000000000
          Height = 18.897650000000000000
          DataSet = frxDBABSREL_B
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."DivisionStr"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 332.598640000000000000
          Top = 12.118120000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Place')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 438.425480000000000000
          Top = 12.118120000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Place')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 540.472790000000000000
          Top = 12.118120000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Place')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 638.740570000000000000
          Top = 12.118120000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Place')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 574.488560000000000000
          Top = 12.118120000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Points')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 672.756340000000000000
          Top = 12.118120000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Points')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 366.614410000000000000
          Top = 12.118120000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Points')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 472.441250000000000000
          Top = 12.118120000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Points')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118120000000000000
        Top = 336.378170000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object frxDBABSREL_B: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryABSREL_B
    BCDToCurrency = False
    Left = 560
    Top = 632
  end
  object qryABSREL_B: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexesActive = False
    IndexFieldNames = 'ScoreDivisionID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime]
    FormatOptions.FmtDisplayDateTime = 'dd mmm YYYY HH:MM'
    FormatOptions.FmtDisplayDate = 'dd mmm YYYYY'
    FormatOptions.FmtDisplayTime = 'nn:mm.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'ScoreDivisionID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SessionID AS INT;'
      'DECLARE @SessionStart AS DATETIME;'
      'SET @SessionID = :SESSIONID; --9;'
      'SET @SessionStart = GETDATE();'
      'IF @SessionStart IS NULL SET @SessionStart = GETDATE();'
      ''
      ''
      ''
      
        '/* A list of divisions and the swimclub members that qualify for' +
        ' those division */'
      'IF OBJECT_ID('#39'tempdb..#tempDivMember'#39') IS NOT NULL'
      '    DROP TABLE #tempDivMember;'
      ''
      'SELECT Member.MemberID'
      '    , ScoreDivisionID'
      'INTO #tempDivMember'
      'FROM ScoreDivision'
      'JOIN Member'
      '    ON ScoreDivision.GenderID = Member.GenderID'
      'WHERE dbo.SwimmerAge(@SessionStart, Member.DOB) <= AgeTo'
      '    AND dbo.SwimmerAge(@SessionStart, Member.DOB) >= AgeFrom;'
      ''
      ''
      
        '/* A list of '#39'CLOSED'#39' events for the SESSION and the members who' +
        ' participated in those events */'
      '-- ABSOLUTE PLACE WITHIN EVENT/HEAT'
      'IF OBJECT_ID('#39'tempdb..#tempTblA'#39') IS NOT NULL'
      '    DROP TABLE #tempTblA;'
      ''
      'SELECT'
      ' [Event].EventID '
      '  ,Entrant.MemberID '
      ' ,HeatIndividual.HeatID'
      
        ', dbo.ABSEventPlace([Event].EventID, Entrant.MemberID) AS ABSEve' +
        'ntPlace'
      
        ', dbo.ABSHeatPlace(HeatIndividual.HeatID, Entrant.MemberID) AS A' +
        'BSHeatPlace'
      'INTO #tempTblA'
      'FROM [Event] '
      
        'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.Ev' +
        'entID'
      'LEFT JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE [Event].SessionID = @SessionID'
      '    -- AND [Event].EventStatusID = 2'
      '    AND Entrant.MemberID IS NOT NULL'
      'AND (Entrant.RaceTime IS NOT NULL)'
      #9#9'    AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020'
      #9#9'    AND (Entrant.IsScratched <> 1) '#9'-- added 16/5/2020    '
      ';'
      ''
      ''
      
        '-- JOIN Event members on divmembers - find the RELATIVE PLACE wi' +
        'thin the division for the EVENT/HEAT'
      'IF OBJECT_ID('#39'tempdb..#tempTblB'#39') IS NOT NULL'
      '    DROP TABLE #tempTblB;'
      'SELECT'
      '#tempTblA.EventID'
      ',#tempTblA.MemberID'
      ',#tempDivMember.ScoreDivisionID AS DivisionID'
      ',#tempTblA.ABSEventPlace'
      ',#tempTblA.ABSHeatPlace '
      
        ', dbo.RELEventPlace([#tempTblA].EventID, #tempTblA.MemberID, #te' +
        'mpDivMember.ScoreDivisionID, @SessionStart) AS RELEventPlace'
      
        ', dbo.RELHeatPlace([#tempTblA].HeatID, #tempTblA.MemberID, #temp' +
        'DivMember.ScoreDivisionID, @SessionStart) AS RELHeatPlace'
      'INTO #tempTblB'
      'FROM #tempDivMember'
      
        'INNER JOIN #tempTblA ON [#tempDivMember].MemberID = [#tempTblA].' +
        'MemberID'
      ''
      '/* FINALLY'
      'Find Scores'
      'Build data for FastReport'
      ' */'
      ''
      'SELECT '
      '#tempTblB.MemberID'
      
        ', CONCAT(Member.FirstName, '#39' '#39' , UPPER(Member.LastName)) AS FNAM' +
        'E'
      ', #tempTblB.DivisionID'
      ', ScoreDivision.GenderID'
      ', Gender.Caption AS GenderStr'
      ', ScoreDivision.Caption AS DivisionStr'
      ', #tempTblB.EventID'
      ', [Event].SessionID'
      ', [Event].Caption AS EventStr'
      ', [Event].DistanceID'
      ', Distance.Caption AS DistanceStr'
      ', [Event].StrokeID'
      ', Stroke.Caption AS StrokeStr'
      ', ABSEventPlace'
      ', sp1.Points AS ABSEventPoints'
      ', ABSHeatPlace'
      ', sp2.Points AS ABSHeatPoints'
      ', RELEventPlace'
      ', sp3.Points AS RELEventPoints'
      ', RELHeatPlace'
      ', sp4.Points AS RELHeatPoints'
      ''
      'FROM #tempTblB'
      
        'INNER JOIN ScorePoints AS sp1 ON #tempTblB.ABSEventPlace = sp1.P' +
        'lace'
      
        'INNER JOIN ScorePoints AS sp2 ON #tempTblB.ABSHeatPlace = sp2.Pl' +
        'ace'
      
        'INNER JOIN ScorePoints AS sp3 ON #tempTblB.RELEventPlace = sp3.P' +
        'lace'
      
        'INNER JOIN ScorePoints AS sp4 ON #tempTblB.RELHeatPlace = sp4.Pl' +
        'ace'
      'INNER JOIN [Event] ON #tempTblB.EventID = [Event].EventID'
      'INNER JOIN Distance ON [Event].DistanceID = Distance.DistanceID'
      'INNER JOIN Stroke ON [Event].StrokeID = Stroke.StrokeID'
      'INNER JOIN Member ON #tempTblB.MemberID = Member.MemberID'
      
        'INNER JOIN ScoreDivision ON #tempTblB.DivisionID = ScoreDivision' +
        '.ScoreDivisionID'
      'INNER JOIN Gender ON ScoreDivision.GenderID = Gender.GenderID'
      ''
      'ORDER BY DistanceID, StrokeID,  DivisionID, ABSEventPlace ASC'
      ';'
      ''
      ''
      '')
    Left = 464
    Top = 632
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 9
      end>
  end
end
