object MarshallReportC: TMarshallReportC
  Height = 480
  Width = 393
  object qryMain: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'HeatID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'HeatID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID AS integer;'
      ''
      'SET @EventID = :EVENTID;  -- 65 TEAM 62 INDV'
      ''
      ''
      '    SELECT HeatIndividual.HeatID'
      '         , HeatIndividual.HeatNum'
      
        '         , CONCAT(Distance.Caption, '#39' '#39', Stroke.Caption) AS cDis' +
        'tanceStroke'
      '         , Event.EventNum'
      '         , FORMAT(Event.EventNum, '#39'00'#39') AS EventNumStr'
      '         , Event.Caption AS cEvent'
      '         , '#39#39' AS TeamName'
      '         , 0 AS TeamNameID'
      '         , HeatIndividual.EventID'
      '    FROM HeatIndividual'
      '        INNER JOIN Event'
      '            ON HeatIndividual.EventID = Event.EventID'
      '        INNER JOIN Distance'
      '            ON Event.DistanceID = Distance.DistanceID'
      '        INNER JOIN Stroke'
      '            ON Event.StrokeID = Stroke.StrokeID'
      '    WHERE HeatIndividual.EventID = @EventID'
      '    ORDER BY HeatIndividual.HeatNum')
    Left = 48
    Top = 232
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 65
      end>
  end
  object frxDBMain: TfrxDBDataset
    UserName = 'frxMain'
    CloseDataSource = False
    FieldAliases.Strings = (
      'HeatID=HeatID'
      'HeatNum=HeatNum'
      'cDistanceStroke=cDistanceStroke'
      'EventNum=EventNum'
      'EventNumStr=EventNumStr'
      'cEvent=cEvent'
      'TeamName=TeamName'
      'TeamNameID=TeamNameID'
      'EventID=EventID')
    DataSource = dsMain
    BCDToCurrency = False
    Left = 232
    Top = 232
  end
  object qryTEAM: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'HeatID'
    MasterSource = dsMain
    MasterFields = 'HeatID'
    DetailFields = 'HeatID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'HeatID;TeamID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'SELECT '
      #9#9'[Team].[HeatID]'
      #9#9',[Team].[TeamID]'
      #9#9',[Team].[TeamNameID]'
      #9#9',[TeamEntrant].[TeamEntrantID]'
      #9#9',[Team].[Lane] AS lane'
      '        ,[TeamName].Caption AS cTeamName'
      '        ,[TeamEntrant].[Lane] AS SwimOrder'
      
        '        , CONCAT(Member.FirstName, '#39' '#39', UPPER(Member.LastName)) ' +
        'AS FNAME'
      #9#9',[Team].[RaceTime]'
      #9#9',[Team].[TimeToBeat]'
      #9#9',[Team].[IsDisqualified]'
      #9#9',[Team].[IsScratched]'
      #9#9',[Team].[DisqualifyCodeID]'
      'FROM [SwimClubMeet].[dbo].[Team] '
      
        'INNER JOIN [SwimClubMeet].[dbo].TeamEntrant ON Team.TeamID = Tea' +
        'mEntrant.TeamID'
      
        'LEFT JOIN [SwimClubMeet].[dbo].TeamName ON Team.TeamNameID = Tea' +
        'mName.TeamNameID'
      
        'INNER JOIN [SwimClubMeet].[dbo].Member ON TeamEntrant.MemberID =' +
        ' Member.MemberID'
      'ORDER BY HeatID, [Team].[Lane], [TeamEntrant].[Lane]')
    Left = 48
    Top = 320
  end
  object qryINDV: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'HeatID'
    MasterSource = dsMain
    MasterFields = 'HeatID'
    DetailFields = 'HeatID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'HeatID;EntrantID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'SELECT '
      #9#9'[Entrant].[HeatID]'
      #9#9',[Entrant].[EntrantID]'
      #9#9',[Entrant].[Lane] AS lane'
      
        '        , CONCAT(Member.FirstName, '#39' '#39', UPPER(Member.LastName)) ' +
        'AS FNAME'
      #9#9',[Entrant].[RaceTime]'
      #9#9',[Entrant].[TimeToBeat]'
      #9#9',[Entrant].[IsDisqualified]'
      #9#9',[Entrant].[IsScratched]'
      #9#9',[Entrant].[DisqualifyCodeID]'
      'FROM [SwimClubMeet].[dbo].[Entrant] '
      
        'LEFT JOIN [SwimClubMeet].[dbo].Member ON Entrant.MemberID = Memb' +
        'er.MemberID'
      'ORDER BY HeatID, [Entrant].[Lane]')
    Left = 48
    Top = 400
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 144
    Top = 232
  end
  object frxDBTEAM: TfrxDBDataset
    UserName = 'frxTEAM'
    CloseDataSource = False
    FieldAliases.Strings = (
      'HeatID=HeatID'
      'TeamID=TeamID'
      'TeamNameID=TeamNameID'
      'TeamEntrantID=TeamEntrantID'
      'lane=lane'
      'cTeamName=cTeamName'
      'SwimOrder=SwimOrder'
      'FNAME=FNAME'
      'RaceTime=RaceTime'
      'TimeToBeat=TimeToBeat'
      'IsDisqualified=IsDisqualified'
      'IsScratched=IsScratched'
      'DisqualifyCodeID=DisqualifyCodeID')
    DataSet = qryTEAM
    BCDToCurrency = False
    Left = 232
    Top = 320
  end
  object frxDBINDV: TfrxDBDataset
    UserName = 'frxINDV'
    CloseDataSource = False
    FieldAliases.Strings = (
      'HeatID=HeatID'
      'EntrantID=EntrantID'
      'lane=lane'
      'FNAME=FNAME'
      'RaceTime=RaceTime'
      'TimeToBeat=TimeToBeat'
      'IsDisqualified=IsDisqualified'
      'IsScratched=IsScratched'
      'DisqualifyCodeID=DisqualifyCodeID')
    DataSet = qryINDV
    BCDToCurrency = False
    Left = 232
    Top = 400
  end
  object frxReport1: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45241.622454375000000000
    ReportOptions.LastChange = 45241.622454375000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '  '
      ''
      'procedure MasterData4OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     Set ('#39'CurrHeatID'#39', <frxMain."HeatID">);  '
      'end;'
      ''
      'procedure MasterData3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     Set ('#39'CurrLaneNum'#39', <frxTEAM."lane">);  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnPrintReport = frxReport1PrintReport
    Left = 232
    Top = 64
    Datasets = <
      item
        DataSet = frxClubInfo
        DataSetName = 'frxClubInfo'
      end
      item
        DataSet = frxDBINDV
        DataSetName = 'frxINDV'
      end
      item
        DataSet = frxDBMain
        DataSetName = 'frxMain'
      end
      item
        DataSet = frxDBTEAM
        DataSetName = 'frxTEAM'
      end>
    Variables = <
      item
        Name = ' SubReportVariables'
        Value = Null
      end
      item
        Name = 'CurrHeatID'
        Value = ''
      end
      item
        Name = 'CurrLaneNum'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
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
        Width = 740.409927000000000000
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
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 321.260050000000000000
        Width = 740.409927000000000000
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
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 35.051020000000000000
        Top = 124.724490000000000000
        Width = 740.409927000000000000
        Condition = 'frxMain."EventID"'
        object Shape2: TfrxShapeView
          AllowVectorExport = True
          Left = 3.500000000000000000
          Top = 2.000000000000000000
          Width = 119.000000000000000000
          Height = 29.720470000000000000
          Frame.Typ = []
        end
        object frxDSEventNumStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 8.500000000000000000
          Top = 4.500000000000000000
          Width = 112.130180000000000000
          Height = 27.397650000000000000
          DataSet = frxDBMain
          DataSetName = 'frxMain'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'EVENT [frxMain."EventNumStr" #n00]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 124.956710000000000000
          Top = 8.224490000000000000
          Width = 256.842610000000000000
          Height = 18.897650000000000000
          DataSet = frxDBMain
          DataSetName = 'frxMain'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxMain."cDistanceStroke"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 437.051330000000000000
          Top = 8.224490000000000000
          Width = 274.937230000000000000
          Height = 18.897650000000000000
          DataSet = frxDBMain
          DataSetName = 'frxMain'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxMain."cEvent"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 33.523500000000000000
        Top = 181.417440000000000000
        Width = 740.409927000000000000
        Condition = 'frxMain."HeatNum"'
        object frxDSHeatCount: TfrxMemoView
          AllowVectorExport = True
          Left = 3.279530000000000000
          Top = 9.000000000000000000
          Width = 176.826840000000000000
          Height = 19.897650000000000000
          DataSet = frxDBMain
          DataSetName = 'frxMain'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'HEAT [frxMain."HeatNum" #n%2.0f]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = 3.000000000000000000
          Top = 32.523500000000000000
          Width = 702.500000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 23.405380000000000000
        Top = 238.110390000000000000
        Width = 740.409927000000000000
        OnBeforePrint = 'MasterData4OnBeforePrint'
        DataSet = frxDBMain
        DataSetName = 'frxMain'
        RowCount = 0
        object SubreportTEAM: TfrxSubreport
          AllowVectorExport = True
          Left = 32.000000000000000000
          Top = 1.507730000000000000
          Width = 44.988250000000000000
          Height = 8.897650000000000000
          Page = frxReport1.Page3
        end
        object SubreportINDV: TfrxSubreport
          AllowVectorExport = True
          Left = 32.000000000000000000
          Top = 12.991960000000000000
          Width = 45.488250000000000000
          Height = 9.070866141732280000
          Page = frxReport1.Page2
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 97.950000000000000000
      Frame.Typ = []
      MirrorMode = []
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 740.409927000000000000
        Columns = 2
        ColumnWidth = 340.157480314961000000
        ColumnGap = 18.897637795275600000
        DataSet = frxDBINDV
        DataSetName = 'frxINDV'
        Filter = '<frxINDV."HeatID"> = <CurrHeatID>'
        RowCount = 0
        object frxINDVlane: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 4.000000000000000000
          Top = 2.747990000000000000
          Width = 36.870130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBINDV
          DataSetName = 'frxINDV'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxINDV."lane" #n00]')
        end
        object frxINDVFNAME: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 42.500000000000000000
          Top = 2.747990000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'FNAME'
          DataSet = frxDBINDV
          DataSetName = 'frxINDV'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxINDV."FNAME"]')
        end
      end
    end
    object Page3: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 20.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 92.950000000000000000
      Frame.Typ = []
      MirrorMode = []
      object GroupHeader4: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 42.397650000000000000
        Top = 18.897650000000000000
        Width = 702.614627000000000000
        Condition = 'frxTEAM."lane"'
        object frxTEAMTeamNameID: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 71.500000000000000000
          Top = 6.602350000000000000
          Width = 406.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBTEAM
          DataSetName = 'frxTEAM'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxTEAM."cTeamName"]')
        end
        object frxTEAMlane: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.000000000000000000
          Top = 6.602350000000000000
          Width = 66.870130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBTEAM
          DataSetName = 'frxTEAM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'LANE [frxTEAM."lane" #n00]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 5.000000000000000000
          Top = 26.500000000000000000
          Width = 63.488250000000000000
          Height = 12.397650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Swim-Order')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 70.000000000000000000
          Top = 26.500000000000000000
          Width = 120.988250000000000000
          Height = 12.397650000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Entrant')
          ParentFont = False
        end
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 20.409400000000000000
        Top = 105.826840000000000000
        Width = 702.614627000000000000
        OnBeforePrint = 'MasterData3OnBeforePrint'
        ColumnWidth = 302.362204724409000000
        ColumnGap = 18.897637795275600000
        DataSet = frxDBTEAM
        DataSetName = 'frxTEAM'
        Filter = '<frxTEAM."HeatID"> = <CurrHeatID>'
        RowCount = 0
        object Memo3: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 71.000000000000000000
          Top = 0.511750000000000000
          Width = 244.630180000000000000
          Height = 18.897650000000000000
          DataSet = frxDBTEAM
          DataSetName = 'frxTEAM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            ' [frxTEAM."FNAME"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 37.500000000000000000
          Top = 0.511750000000000000
          Width = 31.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBTEAM
          DataSetName = 'frxTEAM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxTEAM."SwimOrder" #n00]')
          ParentFont = False
        end
      end
      object GroupHeader5: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 1.397650000000000000
        Top = 83.149660000000000000
        Width = 702.614627000000000000
        Condition = 'frxTEAM."SwimOrder"'
      end
    end
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
    Left = 48
    Top = 160
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
    Left = 232
    Top = 160
  end
end
