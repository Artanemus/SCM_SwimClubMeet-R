object AutoBuildV2: TAutoBuildV2
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 501
  Width = 773
  object qryHeatsToDelete: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HeatID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..HeatIndividual'
    UpdateOptions.KeyFields = 'HeatID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID AS INT'
      'SET @EventID = :EVENTID;'
      ''
      'SELECT HeatIndividual.HeatID'
      ',HeatIndividual.HeatStatusID'
      'FROM HeatIndividual'
      'WHERE HeatIndividual.EventID = @EventID'
      'AND HeatIndividual.HeatStatusID = 1;')
    Left = 88
    Top = 24
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 497
      end>
  end
  object qryNominees: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexesActive = False
    IndexFieldNames = 'NomineeID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'NN:SS.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'NomineeID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID AS INT;'
      'DECLARE @SessionStart AS DATETIME;'
      'DECLARE @Algorithm AS INT;'
      'DECLARE @Calcdefault AS INT;'
      'DECLARE @Percent AS FLOAT;'
      'DECLARE @Age AS INT;'
      'DECLARE @MembershipTypeID AS INT;'
      'DECLARE @GenderID AS INT;'
      ''
      '/*'
      
        'if genderid, membershipid and age are o then these filters are i' +
        'gnored'
      '*/'
      '/*'
      #9#9'ds->ParamByName("EVENTID")->AsInteger = EventID;'
      
        #9#9'ds->ParamByName("SESSIONSTART")->AsDateTime = SCM->GetSessionS' +
        'tart();'
      #9#9'ds->ParamByName("ALGORITHM")->AsDateTime = prefHeatAlgorithm;'
      
        #9#9'ds->ParamByName("CALCDEFAULT")->AsInteger = prefUseDefRaceTime' +
        ';'
      #9#9'ds->ParamByName("PERCENT")->AsFloat = prefRaceTimeTopPercent;'
      '*/'
      'SET @EventID = :EVENTID;--135'
      'SET @SessionStart = :SESSIONSTART;-- GETDATE();'
      'SET @Algorithm = :ALGORITHM;--1'
      'SET @Calcdefault = :CALCDEFAULT;--1'
      'SET @Percent = :PERCENT;--50'
      'SET @GenderID = :GENDERID;--0'
      'SET @MembershipTypeID = :MEMBERSHIPTYPEID;--0'
      'SET @Age = :AGE;--0'
      ''
      'IF @SessionStart IS NULL'
      '    SET @SessionStart = GETDATE();'
      ''
      '-- Produces a list of nominees current not assigned a lane '
      '-- excludes members already placed in CLOSED Heats'
      '-- excludes members in raced heats'
      '-- '
      '-- Define the CTE expression name and column list.'
      'WITH MembersInClosedHeats_CTE ('
      '    EventID'
      '    , MemberID'
      '    )'
      'AS'
      '    -- Define the CTE query. '
      '    ('
      '    SELECT Event.EventID'
      '        , Entrant.MemberID'
      '    FROM Event'
      '    INNER JOIN HeatIndividual'
      '        ON Event.EventID = HeatIndividual.EventID'
      '    INNER JOIN Entrant'
      '        ON HeatIndividual.HeatID = Entrant.HeatID'
      '    --INNER JOIN Member ON Entrant.MemberID = Member.MemberID'
      '    WHERE ('
      '            HeatIndividual.HeatStatusID = 2'
      '            OR HeatIndividual.HeatStatusID = 3'
      '            )'
      '        AND Entrant.MemberID IS NOT NULL'
      '    )'
      '    --'
      '    -- MULTI CTE JOINED WITH COMMA'
      '    --'
      '    ,'
      '    --'
      'Member_CTE ('
      '    MemberID'
      '    , MembershipTypeID'
      '    , GenderID'
      '    , AGE'
      '    , TTB'
      '    )'
      'AS ('
      '    SELECT Member.MemberID'
      '        , MembershipTypeID'
      '        , GenderID'
      '        , dbo.SwimmerAge(@SessionStart, Member.DOB) AS AGE'
      
        '        , dbo.TimeToBeat(@Algorithm, @Calcdefault, @Percent, Mem' +
        'ber.MemberID, Event.DistanceID, Event.StrokeID, @SessionStart) A' +
        'S TTB'
      '    FROM Member'
      '    LEFT OUTER JOIN Nominee'
      '        ON Member.MemberID = Nominee.MemberID'
      '    LEFT OUTER JOIN Event'
      '        ON Nominee.EventID = Event.EventID'
      '    WHERE Nominee.EventID = @EventID'
      '    )'
      '--'#9
      '-- Define the outer query referencing the CTE name.'
      '--'
      'SELECT Nominee.NomineeID'
      '    , Nominee.MemberID'
      '    , Member_CTE.MembershipTypeID'
      '    , Member_CTE.GenderID'
      '    , Member_CTE.AGE'
      
        '    , dbo.PersonalBest(Nominee.MemberID, Event.DistanceID, Event' +
        '.StrokeID, @SessionStart) AS PB'
      '    , Member_CTE.TTB'
      
        '-- If we use the TTB value below - it will not get evaluated ...' +
        '. '
      
        '--,dbo.TimeToBeat(@Algorithm, @Calcdefault, @Percent, Nominee.Me' +
        'mberID, Event.DistanceID, Event.StrokeID, @SessionStart) AS TTB'
      'FROM Nominee'
      'LEFT OUTER JOIN Member_CTE'
      '    ON Nominee.MemberID = Member_CTE.MemberID'
      'LEFT OUTER JOIN Event'
      '    ON Nominee.EventID = Event.EventID'
      'LEFT JOIN MembersInClosedHeats_CTE'
      '    ON MembersInClosedHeats_CTE.MemberID = Nominee.MemberID'
      '        AND MembersInClosedHeats_CTE.EventID = Nominee.EventID'
      'WHERE MembersInClosedHeats_CTE.MemberID IS NULL'
      '    AND Nominee.EventID = @EventID'
      '    AND ('
      '        ('
      '            @GenderID = 0'
      '            AND Member_CTE.GenderID > 0'
      '            )'
      '        OR ('
      '            @GenderID > 0'
      '            AND Member_CTE.GenderID = @GenderID'
      '            )'
      '        )'
      '    AND ('
      '        ('
      '            @MembershipTypeID = 0'
      '            AND ('
      '                (Member_CTE.MembershipTypeID > 0)'
      '                OR (Member_CTE.MembershipTypeID IS NULL)'
      '                )'
      '            )'
      '        OR ('
      '            @MembershipTypeID > 0'
      '            AND Member_CTE.MembershipTypeID = @MembershipTypeID'
      '            )'
      '        )'
      '    AND ('
      '        ('
      '            @Age = 0'
      '            AND Member_CTE.AGE > 0'
      '            )'
      '        OR ('
      '            @Age > 0'
      '            AND Member_CTE.AGE = @Age'
      '            )'
      '        )'
      '-- fastest swimmers first, TTB NULL is LAST'
      'ORDER BY'
      '    -- NULL LAST'
      '    CASE '
      '        WHEN Member_CTE.TTB IS NULL'
      '            THEN 1'
      '        ELSE 0'
      '        END'
      '    , Member_CTE.TTB ASC;')
    Left = 576
    Top = 24
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 835
      end
      item
        Name = 'SESSIONSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ALGORITHM'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'CALCDEFAULT'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'PERCENT'
        DataType = ftFloat
        ParamType = ptInput
        Value = 50.000000000000000000
      end
      item
        Name = 'GENDERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'MEMBERSHIPTYPEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'AGE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
  end
  object qryRenumberHeats: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexesActive = False
    IndexFieldNames = 'HeatID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..HeatIndividual'
    UpdateOptions.KeyFields = 'HeatID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID AS INT'
      'SET @EventID = :EVENTID;'
      ''
      'SELECT HeatIndividual.HeatID'
      ',HeatIndividual.HeatNum'
      'FROM HeatIndividual'
      'WHERE HeatIndividual.EventID = @EventID'
      '-- NULL LAST'
      
        'ORDER BY (CASE WHEN HeatNum IS NULL THEN 1 ELSE 0 END), HeatNum ' +
        'ASC;'
      ''
      '-- DEPRECIATED 15/03/2022'
      '-- ORDER BY HeatIndividual.HeatID ASC;')
    Left = 184
    Top = 24
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 497
      end>
  end
  object qryGenderMemberTypeCount: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID AS INT;'
      ''
      'SET @EventID = :EVENTID;'
      ''
      '-- Produces a list of nominees current not assigned a lane '
      '-- excludes members already placed in CLOSED Heats'
      '-- excludes members in raced heats'
      '-- '
      '-- Define the CTE expression name and column list.'
      'WITH MembersInClosedHeats_CTE ('
      #9'EventID'
      #9',MemberID'
      #9')'
      'AS ('
      #9'SELECT Event.EventID'
      #9#9',Entrant.MemberID'
      #9'FROM Event'
      
        #9'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.Eve' +
        'ntID'
      #9'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      #9'WHERE ('
      #9#9#9'HeatIndividual.HeatStatusID = 2'
      #9#9#9'OR HeatIndividual.HeatStatusID = 3'
      #9#9#9')'
      #9#9'AND (Entrant.MemberID IS NOT NULL)'
      #9')'
      'SELECT '
      #9'COUNT(Nominee.NomineeID) AS countNominees'
      #9',Member.MembershipTypeID'
      #9',Member.GenderID'
      'FROM Nominee'
      'LEFT OUTER JOIN Member ON Nominee.MemberID = Member.MemberID'
      
        'LEFT OUTER JOIN MembersInClosedHeats_CTE AS MembersInClosedHeats' +
        '_CTE_1 ON MembersInClosedHeats_CTE_1.MemberID = Nominee.MemberID'
      #9'AND MembersInClosedHeats_CTE_1.EventID = Nominee.EventID'
      'WHERE (Nominee.EventID = @EventID)'
      #9'AND (MembersInClosedHeats_CTE_1.MemberID IS NULL)'
      'GROUP BY Member.MembershipTypeID, Member.GenderID'
      'ORDER BY GenderID DESC, MembershipTypeID DESC '
      '')
    Left = 576
    Top = 80
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 135
      end>
  end
  object qryGenderCount: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID AS INT;'
      ''
      'SET @EventID = :EVENTID;'
      ''
      '-- Produces a list of nominees current not assigned a lane '
      '-- excludes members already placed in CLOSED Heats'
      '-- excludes members in raced heats'
      '-- '
      '-- Define the CTE expression name and column list.'
      'WITH MembersInClosedHeats_CTE ('
      #9'EventID'
      #9',MemberID'
      #9')'
      'AS ('
      #9'SELECT Event.EventID'
      #9#9',Entrant.MemberID'
      #9'FROM Event'
      
        #9'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.Eve' +
        'ntID'
      #9'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      #9'WHERE ('
      #9#9#9'HeatIndividual.HeatStatusID = 2'
      #9#9#9'OR HeatIndividual.HeatStatusID = 3'
      #9#9#9')'
      #9#9'AND (Entrant.MemberID IS NOT NULL)'
      #9')'
      'SELECT '
      #9'COUNT(Nominee.NomineeID) AS countNominees'
      #9',Member.GenderID'
      'FROM Nominee'
      'LEFT OUTER JOIN Member ON Nominee.MemberID = Member.MemberID'
      
        'LEFT OUTER JOIN MembersInClosedHeats_CTE AS MembersInClosedHeats' +
        '_CTE_1 ON MembersInClosedHeats_CTE_1.MemberID = Nominee.MemberID'
      #9'AND MembersInClosedHeats_CTE_1.EventID = Nominee.EventID'
      'WHERE (Nominee.EventID = @EventID)'
      #9'AND (MembersInClosedHeats_CTE_1.MemberID IS NULL)'
      'GROUP BY Member.GenderID'
      'ORDER BY GenderID DESC;'
      '')
    Left = 576
    Top = 184
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 135
      end>
  end
  object qryMemberTypeCount: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID AS INT;'
      ''
      'SET @EventID = :EVENTID;'
      ''
      '-- Produces a list of nominees current not assigned a lane '
      '-- excludes members already placed in CLOSED Heats'
      '-- excludes members in raced heats'
      '-- '
      '-- Define the CTE expression name and column list.'
      'WITH MembersInClosedHeats_CTE ('
      #9'EventID'
      #9',MemberID'
      #9')'
      'AS ('
      #9'SELECT Event.EventID'
      #9#9',Entrant.MemberID'
      #9'FROM Event'
      
        #9'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.Eve' +
        'ntID'
      #9'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      #9'WHERE ('
      #9#9#9'HeatIndividual.HeatStatusID = 2'
      #9#9#9'OR HeatIndividual.HeatStatusID = 3'
      #9#9#9')'
      #9#9'AND (Entrant.MemberID IS NOT NULL)'
      #9')'
      'SELECT '
      #9'COUNT(Nominee.NomineeID) AS countNominees'
      #9',Member.MembershipTypeID'
      'FROM Nominee'
      'LEFT OUTER JOIN Member ON Nominee.MemberID = Member.MemberID'
      
        'LEFT OUTER JOIN MembersInClosedHeats_CTE AS MembersInClosedHeats' +
        '_CTE_1 ON MembersInClosedHeats_CTE_1.MemberID = Nominee.MemberID'
      #9'AND MembersInClosedHeats_CTE_1.EventID = Nominee.EventID'
      'WHERE (Nominee.EventID = @EventID)'
      #9'AND (MembersInClosedHeats_CTE_1.MemberID IS NULL)'
      'GROUP BY Member.MembershipTypeID'
      'ORDER BY Member.MembershipTypeID DESC;'
      '')
    Left = 576
    Top = 128
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 135
      end>
  end
  object qryAgeCount: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @EventID AS INT'
      'DECLARE @SessionStart AS DATETIME'
      ''
      'SET @EventID = :EVENTID;'
      'SET @SessionStart = :SESSIONSTART;'
      ''
      'IF @SessionStart IS NULL'
      #9'SET @SessionStart = GETDATE();'
      ''
      '-- Produces a list of nominees current not assigned a lane '
      '-- excludes members already placed in CLOSED Heats'
      '-- excludes members in raced heats'
      '-- '
      '-- Define the CTE expression name and column list.'
      'WITH MembersInClosedHeats_CTE ('
      #9'EventID'
      #9',MemberID'
      #9')'
      'AS ('
      #9'SELECT Event.EventID'
      #9#9',Entrant.MemberID'
      #9'FROM Event'
      
        #9'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.Eve' +
        'ntID'
      #9'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      #9'WHERE ('
      #9#9#9'HeatIndividual.HeatStatusID = 2'
      #9#9#9'OR HeatIndividual.HeatStatusID = 3'
      #9#9#9')'
      #9#9'AND (Entrant.MemberID IS NOT NULL)'
      #9')'
      'SELECT '
      #9'COUNT(Nominee.NomineeID) AS countNominees'
      #9',dbo.SwimmerAge(@SessionStart, Member.DOB) AS AGE'
      'FROM Nominee'
      'LEFT OUTER JOIN Member ON Nominee.MemberID = Member.MemberID'
      
        'LEFT OUTER JOIN MembersInClosedHeats_CTE AS MembersInClosedHeats' +
        '_CTE_1 ON MembersInClosedHeats_CTE_1.MemberID = Nominee.MemberID'
      #9'AND MembersInClosedHeats_CTE_1.EventID = Nominee.EventID'
      'WHERE (Nominee.EventID = @EventID)'
      #9'AND (MembersInClosedHeats_CTE_1.MemberID IS NULL)'
      'GROUP BY dbo.SwimmerAge(@SessionStart, Member.DOB)'
      'ORDER BY AGE ASC'
      '')
    Left = 576
    Top = 296
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 135
      end
      item
        Name = 'SESSIONSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryGenderAgeCount: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID AS INT;'
      'DECLARE @SessionStart AS DATETIME;'
      ''
      'SET @EventID = :EVENTID;'
      'SET @SessionStart = :SESSIONSTART;'
      ''
      'IF @SessionStart IS NULL'
      #9'SET @SessionStart = GETDATE();'
      ''
      '-- Produces a list of nominees current not assigned a lane '
      '-- excludes members already placed in CLOSED Heats'
      '-- excludes members in raced heats'
      '-- '
      '-- Define the CTE expression name and column list.'
      'WITH MembersInClosedHeats_CTE ('
      #9'EventID'
      #9',MemberID'
      #9')'
      'AS ('
      #9'SELECT Event.EventID'
      #9#9',Entrant.MemberID'
      #9'FROM Event'
      
        #9'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.Eve' +
        'ntID'
      #9'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      #9'WHERE ('
      #9#9#9'HeatIndividual.HeatStatusID = 2'
      #9#9#9'OR HeatIndividual.HeatStatusID = 3'
      #9#9#9')'
      #9#9'AND (Entrant.MemberID IS NOT NULL)'
      #9')'
      'SELECT '
      #9'COUNT(Nominee.NomineeID) AS countNominees'
      #9',Member.GenderID'
      #9',dbo.SwimmerAge(@SessionStart, Member.DOB) AS AGE'
      'FROM Nominee'
      'LEFT OUTER JOIN Member ON Nominee.MemberID = Member.MemberID'
      
        'LEFT OUTER JOIN MembersInClosedHeats_CTE AS MembersInClosedHeats' +
        '_CTE_1 ON MembersInClosedHeats_CTE_1.MemberID = Nominee.MemberID'
      #9'AND MembersInClosedHeats_CTE_1.EventID = Nominee.EventID'
      'WHERE (Nominee.EventID = @EventID)'
      #9'AND (MembersInClosedHeats_CTE_1.MemberID IS NULL)'
      
        'GROUP BY dbo.SwimmerAge(@SessionStart, Member.DOB), Member.Gende' +
        'rID'
      'ORDER BY GenderID DESC, AGE ASC;'
      '')
    Left = 576
    Top = 240
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 135
      end
      item
        Name = 'SESSIONSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryGenericCount: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @EventID AS INT'
      ''
      'SET @EventID = :EVENTID;'
      ''
      '-- Produces a list of nominees current not assigned a lane '
      '-- excludes members already placed in CLOSED Heats'
      '-- excludes members in raced heats'
      '-- '
      '-- Define the CTE expression name and column list.'
      'WITH MembersInClosedHeats_CTE ('
      #9'EventID'
      #9',MemberID'
      #9')'
      'AS ('
      #9'SELECT Event.EventID'
      #9#9',Entrant.MemberID'
      #9'FROM Event'
      
        #9'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.Eve' +
        'ntID'
      #9'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      #9'WHERE ('
      #9#9#9'HeatIndividual.HeatStatusID = 2'
      #9#9#9'OR HeatIndividual.HeatStatusID = 3'
      #9#9#9')'
      #9#9'AND (Entrant.MemberID IS NOT NULL)'
      #9')'
      'SELECT '
      #9'COUNT(Nominee.NomineeID) AS countNominees'
      'FROM Nominee'
      'LEFT OUTER JOIN Member ON Nominee.MemberID = Member.MemberID'
      
        'LEFT OUTER JOIN MembersInClosedHeats_CTE AS MembersInClosedHeats' +
        '_CTE_1 ON MembersInClosedHeats_CTE_1.MemberID = Nominee.MemberID'
      #9'AND MembersInClosedHeats_CTE_1.EventID = Nominee.EventID'
      'WHERE (Nominee.EventID = @EventID)'
      #9'AND (MembersInClosedHeats_CTE_1.MemberID IS NULL)'
      '')
    Left = 576
    Top = 352
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 135
      end>
  end
  object qryHeatMaxSeedNumber: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID AS INT;'
      ''
      'SET @EventID = :EVENTID; -- 135'
      ''
      
        'SELECT MAX(HeatNum) AS HeatMaxSeedNumber FROM HeatIndividual WHE' +
        'RE HeatIndividual.EventID = @EventID ;')
    Left = 144
    Top = 88
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 135
      end>
  end
  object tbl_ABHeat: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HeatID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..HeatIndividual'
    UpdateOptions.KeyFields = 'HeatID'
    TableName = 'SwimClubMeet..HeatIndividual'
    Left = 104
    Top = 184
  end
  object tbl_ABEntrant: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EntrantID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Entrant'
    UpdateOptions.KeyFields = 'EntrantID'
    TableName = 'SwimClubMeet..Entrant'
    Left = 104
    Top = 232
  end
  object qrySourceEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      ''
      'DECLARE @EventID AS INT'
      ''
      'SET @EventID = :EVENTID;'
      ''
      'SELECT '
      '[Event].EventID'
      ',Entrant.MemberID'
      ',Member.GenderID'
      ',[Event].SessionID '
      ',[Event].EventNum'
      ',[Event].StrokeID'
      ',[Event].DistanceID'
      ',[Event].Caption'
      'FROM [Event]'
      
        '--INNER JOIN Distance ON [Event].DistanceID = Distance.DistanceI' +
        'D'
      '--INNER JOIN Stroke ON [Event].StrokeID = Stroke.StrokeID'
      
        'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.Ev' +
        'entID'
      'LEFT JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      'LEFT JOIN Member ON Entrant.MemberID = Member.MemberID'
      'WHERE [Event].EventID = @EventID'
      '    AND Entrant.MemberID IS NOT NULL'
      '    AND (Entrant.RaceTime IS NOT NULL)'
      #9#9'    AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020'
      #9#9'    AND (Entrant.IsScratched <> 1) '#9'-- added 16/5/2020    ')
    Left = 360
    Top = 136
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 95
      end>
  end
  object qryNomineeCountExt: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;;'
      ''
      'DECLARE @EventID AS INT'
      ''
      'SET @EventID = :EVENTID; -- 92;'
      ''
      '-- Produces a list of qualified nominees in the SOURCE event'
      '-- Ignore open, raced, closed status'
      '--'
      '-- Define the CTE expression name and column list.'
      'WITH FinalsNominees_CTE ('
      '    EventID'
      '    , MemberID'
      '    )'
      'AS ('
      '    SELECT [Event].EventID'
      '        , Entrant.MemberID'
      '    FROM Event'
      '    INNER JOIN HeatIndividual'
      '        ON [Event].EventID = HeatIndividual.EventID'
      '    INNER JOIN Entrant'
      '        ON HeatIndividual.HeatID = Entrant.HeatID'
      '    WHERE ('
      '            Entrant.MemberID IS NOT NULL'
      '            AND (Entrant.RaceTime IS NOT NULL)'
      '            AND (Entrant.IsDisqualified <> 1)'
      '            AND (Entrant.IsScratched <> 1)'
      '            AND [Event].EventID = @EventID'
      '            )'
      '    )'
      'SELECT COUNT(FinalsNominees_CTE.MemberID) AS NomineeCountExt'
      'FROM [Event]'
      'INNER JOIN FinalsNominees_CTE'
      '    ON [Event].EventID = FinalsNominees_CTE.EventID'
      'WHERE [Event].EventID = @EventID')
    Left = 360
    Top = 80
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 92
      end>
  end
  object qryNomineesExt: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexesActive = False
    IndexFieldNames = 'NomineeID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'NN:SS.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'NomineeID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @destEventID AS INT;'
      'DECLARE @srcEventID AS INT;'
      'DECLARE @SessionStart AS DATETIME;'
      'DECLARE @GenderID AS INT;'
      ''
      'SET @destEventID = :DESTEVENTID; --524'
      'SET @srcEventID = :SRCEVENTID; --95 '
      'SET @SessionStart = :SESSIONSTART; -- GETDATE();'
      'SET @GenderID = :GENDERID; --0'
      ''
      'IF @SessionStart IS NULL'
      '    SET @SessionStart = GETDATE();'
      ''
      '/*'
      'FOR FINALS, SEMI FINALS, QUARTER FINALS'
      'Prior to running this query ...'
      ''
      'A preliminary event has been run and the '
      'racetimes have been entered.'
      ''
      'This preliminary can have many heats.'
      ''
      'From this event, either a Quarter, Semi or Final'
      'is created (the destination event).'
      ''
      'The racetimes are the new TTBs.'
      ''
      'The number of nominees that can enter into'
      'the destination event must be limited.'
      ''
      'For example : if the pool has 8 lanes but '
      'prefExcludeOutsideLanes = true, then'
      'FINAL has a MAX of 6 nominees.'
      'SEMI-FINAL has a MAX of 12 nominees. (two heats)'
      'etc.'
      ''
      'Prior to calling here, the draw is set '
      'by restricting the number of nominees'
      'entered in the destination event.'
      ''
      '*/'
      '-- Produces a list of qualified members and there racetimes '
      '-- from the source event. Include the racetime as TTB.'
      '-- '
      '-- Define the CTE expression name and column list.'
      'WITH MembersTTB_CTE ('
      '    MemberID'
      '    , GenderID'
      '    , RaceTime'
      '    )'
      'AS ('
      '    SELECT Entrant.MemberID'
      '        , GenderID'
      '        , RaceTime'
      '    FROM HeatIndividual'
      '    LEFT JOIN Entrant'
      '        ON HeatIndividual.HeatID = Entrant.HeatID'
      '    LEFT JOIN Member'
      '        ON Entrant.MemberID = Member.MemberID'
      '    WHERE HeatIndividual.EventID = @srcEventID'
      '        AND Entrant.MemberID IS NOT NULL'
      '        AND (Entrant.RaceTime IS NOT NULL)'
      '        AND (Entrant.IsDisqualified <> 1)'
      '        AND (Entrant.IsScratched <> 1)'
      '    )'
      '--'#9
      '-- Define the outer query referencing the CTE name.'
      '--'
      'SELECT Nominee.NomineeID'
      '    , Nominee.MemberID'
      '    , MembersTTB_CTE.GenderID'
      
        '    , dbo.PersonalBest(Nominee.MemberID, Event.DistanceID, Event' +
        '.StrokeID, @SessionStart) AS PB'
      '    , MembersTTB_CTE.RaceTime AS TTB'
      'FROM Nominee'
      'LEFT OUTER JOIN Event'
      '    ON Nominee.EventID = Event.EventID'
      'LEFT JOIN MembersTTB_CTE'
      '    ON Nominee.MemberID = MembersTTB_CTE.MemberID'
      'WHERE Nominee.EventID = @destEventID'
      '    -- ONLY Gender will be filtered'
      '    AND ('
      '        ('
      '            @GenderID = 0'
      '            AND MembersTTB_CTE.GenderID > 0'
      '            )'
      '        OR ('
      '            @GenderID > 0'
      '            AND MembersTTB_CTE.GenderID = @GenderID'
      '            )'
      '        )'
      '-- fastest swimmers first, TTB NULL is LAST, TTB zero is last'
      'ORDER BY'
      '    -- NULL timetobeat is empty '
      '    CASE '
      '        WHEN TTB IS NULL'
      '            THEN 2'
      '        ELSE 1'
      '        END'
      '    -- the timetobeat is zero'
      '    , CASE '
      '        WHEN (CONVERT(FLOAT, CONVERT(DATETIME, TTB)) = 0)'
      '            THEN 1'
      '        ELSE 0'
      '        END'
      '    -- a valid time'
      '    , TTB ASC;')
    Left = 360
    Top = 24
    ParamData = <
      item
        Name = 'DESTEVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 524
      end
      item
        Name = 'SRCEVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 95
      end
      item
        Name = 'SESSIONSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'GENDERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
  end
  object qryInsertEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @Caption AS NVARCHAR(80);'
      'DECLARE @DistanceID AS INT;'
      'DECLARE @StrokeID AS INT;'
      'DECLARE @SessionID AS INT;'
      'DECLARE @MaxEventNum AS INT;'
      ''
      'SET @Caption = :CAPTION;'
      'SET @DistanceID = :DISTANCEID;'
      'SET @StrokeID = :STROKEID;'
      'SET @SessionID = :SESSIONID;'
      ''
      
        'SET @MaxEventNum = (SELECT MAX([Event].EventNum) FROM [Event] WH' +
        'ERE [Event].SessionID = @SessionID);'
      ''
      
        'INSERT INTO [Event] (Caption, DistanceID, StrokeID, EventStatusI' +
        'D, SessionID, EventNum, EventTypeID)'
      
        'VALUES (@Caption, @DistanceID, @StrokeID, 1, @SessionID, (@MaxEv' +
        'entNum+1), 1);'
      ''
      ''
      ' '
      '')
    Left = 360
    Top = 192
    ParamData = <
      item
        Name = 'CAPTION'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DISTANCEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'STROKEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryUnplaced: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @EventID AS INT'
      ''
      'SET @EventID = :EVENTID;'
      ''
      'SELECT '
      'dbo.NomineeCount(@EventID) AS NomCount'
      ',dbo.EntrantCount(@EventID) AS EntCount'
      ';')
    Left = 352
    Top = 360
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 835
      end>
  end
end
