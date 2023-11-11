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
    BCDToCurrency = False
    Left = 232
    Top = 328
  end
  object frxDBINDV: TfrxDBDataset
    UserName = 'frxINDV'
    CloseDataSource = False
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
    Datasets = <>
    Variables = <>
    Style = <>
  end
end
