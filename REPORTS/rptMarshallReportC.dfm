object MarshallReportC: TMarshallReportC
  Height = 480
  Width = 640
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
      'SET @EventID = 65; --:EVENTID;'
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
      
        'INNER JOIN [SwimClubMeet].[dbo].Member ON Entrant.MemberID = Mem' +
        'ber.MemberID'
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
    Top = 328
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
      'begin'
      ''
      'end.')
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
    Variables = <>
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
        Top = 430.866420000000000000
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
        Height = 22.677180000000000000
        Top = 181.417440000000000000
        Width = 740.409927000000000000
        Condition = 'frxMain."HeatNum"'
        object frxDSHeatCount: TfrxMemoView
          AllowVectorExport = True
          Left = 3.279530000000000000
          Top = -1.295300000000000000
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
          Top = 22.228200000000000000
          Width = 702.500000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 257.008040000000000000
        Width = 740.409927000000000000
        ToNRows = 0
        ToNRowsMode = rmCount
        object SubreportINDV: TfrxSubreport
          AllowVectorExport = True
          Left = 4.500000000000000000
          Top = 2.078540000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReport1.Page2
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 302.362400000000000000
        Width = 740.409927000000000000
        ToNRows = 0
        ToNRowsMode = rmCount
        object SubreportTEAM: TfrxSubreport
          AllowVectorExport = True
          Left = 4.500000000000000000
          Top = 3.224180000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReport1.Page3
        end
      end
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 5.677180000000000000
        Top = 226.771800000000000000
        Width = 740.409927000000000000
        DataSet = frxDBMain
        DataSetName = 'frxMain'
        RowCount = 0
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 347.716760000000000000
        Width = 740.409927000000000000
        DataSet = frxDBINDV
        DataSetName = 'frxINDV'
        RowCount = 0
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
      Frame.Typ = []
      MirrorMode = []
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 740.409927000000000000
        Condition = 'frxINDV."lane"'
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 64.252010000000000000
        Width = 740.409927000000000000
        DataSet = frxDBINDV
        DataSetName = 'frxINDV'
        RowCount = 0
        object frxINDVlane: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 4.000000000000000000
          Top = 2.747990000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'lane'
          DataSet = frxDBINDV
          DataSetName = 'frxINDV'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxINDV."lane"]')
        end
        object frxINDVFNAME: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 88.000000000000000000
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
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object GroupHeader4: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 740.409927000000000000
        Condition = 'frxTEAM."lane"'
        object frxTEAMTeamNameID: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 86.000000000000000000
          Top = 1.602350000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'TeamNameID'
          DataSet = frxDBTEAM
          DataSetName = 'frxTEAM'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxTEAM."TeamNameID"]')
        end
        object frxTEAMlane: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.500000000000000000
          Top = 1.102350000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'lane'
          DataSet = frxDBTEAM
          DataSetName = 'frxTEAM'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxTEAM."lane"]')
        end
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 102.047310000000000000
        Width = 740.409927000000000000
        DataSet = frxDBTEAM
        DataSetName = 'frxTEAM'
        RowCount = 0
        object frxTEAMcTeamName: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 88.500000000000000000
          Top = 1.747990000000000000
          Width = 177.630180000000000000
          Height = 18.897650000000000000
          DataField = 'cTeamName'
          DataSet = frxDBTEAM
          DataSetName = 'frxTEAM'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxTEAM."cTeamName"]')
        end
        object frxTEAMSwimOrder: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.500000000000000000
          Top = 1.747990000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'SwimOrder'
          DataSet = frxDBTEAM
          DataSetName = 'frxTEAM'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxTEAM."SwimOrder"]')
        end
      end
      object GroupHeader5: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 14.177180000000000000
        Top = 64.252010000000000000
        Width = 740.409927000000000000
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
