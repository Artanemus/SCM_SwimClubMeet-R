object SCMNom: TSCMNom
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 355
  Width = 424
  object qryIsMemberInEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EntrantID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @EventID AS INT;'
      'DECLARE @MemberID AS INT;'
      ''
      'SET @EventID = :EVENTID'
      'SET @MemberID = :MEMBERID;'
      ''
      'SELECT Entrant.EntrantID'
      'FROM Entrant'
      
        'INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.Hea' +
        'tID'
      'INNER JOIN Event ON HeatIndividual.EventID = Event.EventID'
      'WHERE Entrant.MemberID = @MemberID AND Event.EventID = @EventID')
    Left = 248
    Top = 112
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 266
      end
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 83
      end>
  end
  object qryEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EventID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Event'
    UpdateOptions.KeyFields = 'EventID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'SELECT [EventID]'
      '      ,[EventNum]'
      '      ,[SessionID]'
      '      ,[EventTypeID]'
      '      ,[StrokeID]'
      '      ,[DistanceID]'
      '      ,[EventStatusID]'
      '  FROM [SwimClubMeet].[dbo].[Event]'
      'WHERE [EventID] = :EVENTID')
    Left = 96
    Top = 104
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qryIsMemberNominated: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'NomineeID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet'
      'SELECT Nominee.NomineeID'
      'FROM Nominee'
      
        'WHERE Nominee.MemberID = :MEMBERID AND Nominee.EventID = :EVENTI' +
        'D')
    Left = 248
    Top = 168
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object cmdNominateMember: TFDCommand
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckUpdatable = False
    CommandText.Strings = (
      'USE [SwimClubMeet]'
      ''
      ''
      'INSERT INTO [dbo].[Nominee]'
      '           ([AutoBuildFlag]'
      '           ,[TTB]'
      '           ,[PB]'
      '           ,[MemberID]'
      '           ,[EventID]'
      '           ,[SeedTime])'
      '     VALUES'
      '           (0'
      '           ,NULL'
      '           ,NULL'
      '           ,:MemberID'
      '           ,:EventID'
      '           ,NULL)')
    ActiveStoredUsage = [auDesignTime]
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 56
    Top = 24
  end
  object qryHeat: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexesActive = False
    IndexFieldNames = 'HeatID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @MemberID AS INT'
      'DECLARE @EventID AS INT'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @EventID = :EVENTID;'
      ''
      'SELECT HeatIndividual.HeatID, HeatIndividual.HeatStatusID'
      'FROM [Event]'
      
        'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.Ev' +
        'entID'
      'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE [Event].EventID = @EventID'
      #9'AND (Entrant.MemberID = @MemberID)')
    Left = 96
    Top = 176
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 17
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 395
      end>
  end
  object cmdCleanLane: TFDCommand
    Connection = SCM.scmConnection
    CommandText.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @EntrantID AS INT'
      ''
      'SET @EntrantID = :ENTRANTID;'
      ''
      'UPDATE Entrant'
      '   SET [MemberID] = NULL'
      '      ,[RaceTime] = NULL'
      '      ,[TimeToBeat] = NULL'
      '      ,[PersonalBest] =NULL'
      '      ,[IsDisqualified] = 0'
      '      ,[IsScratched] = 0'
      'FROM Entrant'
      'WHERE EntrantID =  @EntrantID;')
    ActiveStoredUsage = [auDesignTime]
    ParamData = <
      item
        Name = 'ENTRANTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
    Left = 256
    Top = 24
  end
  object cmdDeleteNominee: TFDCommand
    Connection = SCM.scmConnection
    CommandText.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @MemberID AS INT;'
      'DECLARE @EventID AS INT;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @EventID = :EVENTID;'
      ''
      'DELETE FROM [dbo].[Nominee]'
      '      WHERE MemberID = @MemberID AND EventID = @EventID;'
      ';')
    ActiveStoredUsage = [auDesignTime]
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
    Left = 160
    Top = 24
  end
  object qryEntrant: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:mm.zz'
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ''
      'DECLARE @EntrantID INT'
      ''
      'SET @EntrantID = :ENTRANTID;'
      ''
      'SELECT [EntrantID]'
      '      ,[MemberID]'
      '      ,[Lane]'
      '      ,[RaceTime]'
      '      ,[TimeToBeat]'
      '      ,[PersonalBest]'
      '      ,[IsDisqualified]'
      '      ,[IsScratched]'
      '      ,Entrant.[HeatID]'
      ',HeatIndividual.EventID'
      ',HeatIndividual.HeatStatusID'
      ',HeatIndividual.HeatNum'
      ''
      '  FROM [dbo].[Entrant]'
      
        'INNER JOIN HeatIndividual on Entrant.HeatID = HeatIndividual.Hea' +
        'tID'
      'WHERE Entrant.EntrantID = @EntrantID')
    Left = 96
    Top = 248
    ParamData = <
      item
        Name = 'ENTRANTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2141
      end>
  end
  object qryGetEntrantID: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexesActive = False
    IndexFieldNames = 'EntrantID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @EventID AS INT'
      'DECLARE @MemberID AS INT'
      ''
      ''
      'SET @EventID = :EVENTID;'
      'SET @MemberID = :MEMBERID;'
      ''
      'SELECT Entrant.EntrantID'
      '--,HeatIndividual.EventID'
      '--,HeatIndividual.HeatID '
      'FROM Event '
      
        'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.Even' +
        'tID'
      'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE Event.EventID = @EventID AND Entrant.MemberID = @MemberID;')
    Left = 248
    Top = 224
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 189
      end
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 31
      end>
  end
end
