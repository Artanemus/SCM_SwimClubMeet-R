object AutoBuildV2: TAutoBuildV2
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
      'DECLARE @SwimmerCategoryID AS INT;'
      'DECLARE @GenderID AS INT;'
      'DECLARE @SwimClubID AS INT;'
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
      'SET @Algorithm = :ALGORITHM;--1'
      'SET @Calcdefault = :CALCDEFAULT;--1'
      'SET @Percent = :PERCENT;--50'
      'SET @GenderID = :GENDERID;--0'
      'SET @SwimmerCategoryID = :SWIMMERCATEGORYID;--0'
      'SET @Age = :AGE; --0'
      'SET @SwimClubID = 1;'
      ''
      'SET @SessionStart = :SESSIONSTART;'
      ''
      'IF @SessionStart IS NULL'
      '    SET @SessionStart = GETDATE();'
      '    '
      'IF @SwimmerCategoryID IS NULL'
      '    SET @SwimmerCategoryID = 0;    '
      ''
      ''
      
        '-- LIST OF MEMBERS IN CLOSED OR RACED HEATS (FOR THE CURRENT EVE' +
        'NT)'
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#MembersInClosedHeats'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #MembersInClosedHeats;'
      '-- Create the temporary table '
      'SELECT Event.EventID'
      '     , Entrant.MemberID'
      'INTO #MembersInClosedHeats'
      'FROM [SwimClubMeet].[dbo].[Event]'
      '    INNER JOIN HeatIndividual'
      '        ON Event.EventID = HeatIndividual.EventID'
      '    INNER JOIN Entrant'
      '        ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE ('
      '          HeatIndividual.HeatStatusID = 2'
      '          OR HeatIndividual.HeatStatusID = 3'
      '      )'
      '      AND (Entrant.MemberID IS NOT NULL);'
      ''
      
        '-- LIST OF ALL NOMINEES FOR THE GIVEN EVENT AND THEIR PERSONAL D' +
        'ATA'
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#NomineesInEvent'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #NomineesInEvent;'
      '-- Create the temporary table'
      'SELECT [Nominee].[NomineeID]'
      '     , [Nominee].[EventID]'
      '     , [Nominee].[MemberID]'
      '     , [Nominee].[SeedTime]'
      '     , [Member].[GenderID]'
      '    , dbo.SwimmerAge(@SessionStart, Member.DOB) AS AGE'
      
        '    , dbo.TimeToBeat(@Algorithm, @Calcdefault, @Percent, [Nomine' +
        'e].[MemberID], [Event].[DistanceID], [Event].[StrokeID], @Sessio' +
        'nStart) AS TTB     '
      
        '    , dbo.MembersSwimmerCategory([Nominee].[MemberID], @SwimClub' +
        'Id, @SessionStart) AS SwimmerCategoryID'
      
        '    , dbo.PersonalBest([Nominee].[MemberID], [Event].[DistanceID' +
        '], [Event].[StrokeID], @SessionStart) AS PB'
      'INTO #NomineesInEvent'
      'FROM [SwimClubMeet].[dbo].[Nominee]'
      '    LEFT OUTER JOIN [SwimClubMeet].[dbo].[Member]'
      '        ON [Nominee].[MemberID] = [Member].[MemberID]'
      '    LEFT OUTER JOIN Event'
      '        ON Nominee.EventID = Event.EventID'
      'WHERE ([Nominee].[EventID] = @EventID);      '
      ''
      '-- FINALLY'
      
        '----------------------------------------------------------------' +
        '------- '
      
        '-- FILTER OUT MEMBERS WHO HAVE RACED OR ARE IN HEATS THAT ARE CL' +
        'OSED.'
      'SELECT NomineeID'
      '    , #NomineesInEvent.MemberID'
      '    , SwimmerCategoryID'
      '    , GenderID'
      '    , AGE'
      '    , PB'
      '    , TTB'
      '-- SEEDTIME IS USED TO INJECT DATA INTO THE ENTRANT RESORD'
      ', SeedTime'
      
        '-- If we use the TTB value below - it will not get evaluated ...' +
        '. '
      
        '--,dbo.TimeToBeat(@Algorithm, @Calcdefault, @Percent, Nominee.Me' +
        'mberID, Event.DistanceID, Event.StrokeID, @SessionStart) AS TTB'
      'FROM #NomineesInEvent'
      'LEFT OUTER JOIN Event'
      '    ON #NomineesInEvent.EventID = Event.EventID'
      'LEFT JOIN #MembersInClosedHeats'
      
        '    ON #NomineesInEvent.MemberID = #MembersInClosedHeats.MemberI' +
        'D'
      
        '        AND #NomineesInEvent.EventID = #MembersInClosedHeats.Eve' +
        'ntID'
      'WHERE #MembersInClosedHeats.MemberID IS NULL'
      '    AND #NomineesInEvent.EventID = @EventID'
      '    AND ('
      '        ('
      '            @GenderID = 0'
      '            AND GenderID > 0'
      '            )'
      '        OR ('
      '            @GenderID > 0'
      '            AND GenderID = @GenderID'
      '            )'
      '        )'
      '    AND ('
      '        ('
      '            @SwimmerCategoryID = 0'
      '            AND ('
      '                (SwimmerCategoryID > 0)'
      '                OR (SwimmerCategoryID IS NULL)'
      '                )'
      '            )'
      '        OR ('
      '            @SwimmerCategoryID > 0'
      '            AND SwimmerCategoryID = @SwimmerCategoryID'
      '            )'
      '        )'
      '    AND ('
      '        ('
      '            @Age = 0'
      '            AND AGE > 0'
      '            )'
      '        OR ('
      '            @Age > 0'
      '            AND AGE = @Age'
      '            )'
      '        )'
      '-- fastest swimmers first, TTB NULL is LAST'
      'ORDER BY'
      '    -- NULL LAST'
      '    CASE '
      '        WHEN TTB IS NULL'
      '            THEN 1'
      '        ELSE 0'
      '        END'
      '    , TTB ASC;')
    Left = 576
    Top = 24
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
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
        Name = 'SWIMMERCATEGORYID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'AGE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'SESSIONSTART'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
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
  object qryGenderSwimmerCATCount: TFDQuery
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
      'DECLARE @SwimClubID AS INT;'
      'DECLARE @SeedDate AS DATETIME;'
      ''
      'SET @EventID = :EVENTID;'
      'SET @SwimCLubID = 1;'
      ''
      'IF @SeedDate IS NULL'
      '    SET @SeedDate = GETDATE();'
      ''
      
        '-- LIST OF MEMBERS IN CLOSED OR RACED HEATS (FOR THE CURRENT EVE' +
        'NT)'
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#MembersInClosedHeats'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #MembersInClosedHeats;'
      '-- Create the temporary table '
      'SELECT Event.EventID'
      '     , Entrant.MemberID'
      'INTO #MembersInClosedHeats'
      'FROM [SwimClubMeet].[dbo].[Event]'
      '    INNER JOIN HeatIndividual'
      '        ON Event.EventID = HeatIndividual.EventID'
      '    INNER JOIN Entrant'
      '        ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE ('
      '          HeatIndividual.HeatStatusID = 2'
      '          OR HeatIndividual.HeatStatusID = 3'
      '      )'
      '      AND (Entrant.MemberID IS NOT NULL);'
      ''
      ''
      
        '-- LIST OF ALL NOMINEES FOR THE GIVEN EVENT AND THEIR SWIMMER CA' +
        'TEGORY '
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#NomineeCAT'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #NomineeCAT;'
      '-- Create the temporary table'
      'SELECT [Nominee].[NomineeID]'
      '     , [Nominee].[EventID]'
      '     , [Nominee].[MemberID]'
      '     , [Member].[GenderID]'
      
        '     , dbo.MembersSwimmerCategory([Member].[MemberID], @SwimClub' +
        'Id, @SeedDate) AS SwimmerCategoryID'
      'INTO #NomineeCAT'
      'FROM [SwimClubMeet].[dbo].[Nominee]'
      '    LEFT OUTER JOIN [SwimClubMeet].[dbo].[Member]'
      '        ON [Nominee].[MemberID] = [Member].[MemberID]'
      'WHERE ([Nominee].[EventID] = @EventID);'
      ''
      ''
      '-- FINALLY'
      
        '----------------------------------------------------------------' +
        '------- '
      
        '-- FILTER OUT MEMBERS WHO HAVE RACED OR ARE IN HEATS THAT ARE CL' +
        'OSED.'
      '-- return count, CAT and gender.'
      'SELECT COUNT(#NomineeCAT.NomineeID) AS countNominees'
      '     , #NomineeCAT.SwimmerCategoryID'
      '     , #NomineeCAT.GenderID'
      'FROM #NomineeCAT'
      '    LEFT OUTER JOIN #MembersInClosedHeats'
      '        ON #NomineeCAT.MemberID = #MembersInClosedHeats.MemberID'
      
        '           AND #NomineeCAT.EventID = #MembersInClosedHeats.Event' +
        'ID'
      'WHERE (#NomineeCAT.EventID = @EventID)'
      '      AND (#MembersInClosedHeats.MemberID IS NULL)'
      'GROUP BY SwimmerCategoryID'
      '       , #NomineeCAT.GenderID'
      'ORDER BY GenderID DESC'
      '       , SwimmerCategoryID DESC;'
      ''
      ''
      ''
      '')
    Left = 576
    Top = 80
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
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
      ''
      
        '-- LIST OF MEMBERS IN CLOSED OR RACED HEATS (FOR THE CURRENT EVE' +
        'NT)'
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#MembersInClosedHeats'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #MembersInClosedHeats;'
      '-- Create the temporary table '
      'SELECT Event.EventID'
      '     , Entrant.MemberID'
      'INTO #MembersInClosedHeats'
      'FROM [SwimClubMeet].[dbo].[Event]'
      '    INNER JOIN HeatIndividual'
      '        ON Event.EventID = HeatIndividual.EventID'
      '    INNER JOIN Entrant'
      '        ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE ('
      '          HeatIndividual.HeatStatusID = 2'
      '          OR HeatIndividual.HeatStatusID = 3'
      '      )'
      '      AND (Entrant.MemberID IS NOT NULL);'
      ''
      '-- FINALLY'
      
        '----------------------------------------------------------------' +
        '------- '
      
        '-- FILTER OUT MEMBERS WHO HAVE RACED OR ARE IN HEATS THAT ARE CL' +
        'OSED.'
      'SELECT COUNT(Nominee.NomineeID) AS countNominees'
      '     , Member.GenderID'
      'FROM Nominee'
      '    LEFT OUTER JOIN Member'
      '        ON Nominee.MemberID = Member.MemberID'
      '    LEFT OUTER JOIN #MembersInClosedHeats'
      '        ON #MembersInClosedHeats.MemberID = Nominee.MemberID'
      '           AND #MembersInClosedHeats.EventID = Nominee.EventID'
      'WHERE (Nominee.EventID = @EventID)'
      '      AND (#MembersInClosedHeats.MemberID IS NULL)'
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
        Value = 2
      end>
  end
  object qrySwimmerCATCount: TFDQuery
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
      'DECLARE @SwimClubID AS INT;'
      'DECLARE @SeedDate AS DATETIME;'
      ''
      'SET @EventID = :EVENTID;'
      'SET @SwimCLubID = 1;'
      ''
      'IF @SeedDate IS NULL'
      '    SET @SeedDate = GETDATE();'
      ''
      
        '-- LIST OF MEMBERS IN CLOSED OR RACED HEATS (FOR THE CURRENT EVE' +
        'NT)'
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#MembersInClosedHeats'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #MembersInClosedHeats;'
      '-- Create the temporary table '
      'SELECT Event.EventID'
      '     , Entrant.MemberID'
      'INTO #MembersInClosedHeats'
      'FROM [SwimClubMeet].[dbo].[Event]'
      '    INNER JOIN HeatIndividual'
      '        ON Event.EventID = HeatIndividual.EventID'
      '    INNER JOIN Entrant'
      '        ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE ('
      '          HeatIndividual.HeatStatusID = 2'
      '          OR HeatIndividual.HeatStatusID = 3'
      '      )'
      '      AND (Entrant.MemberID IS NOT NULL);'
      ''
      
        '-- LIST OF ALL NOMINEES FOR THE GIVEN EVENT AND THEIR SWIMMER CA' +
        'TEGORY '
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#NomineeCAT'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #NomineeCAT;'
      '-- Create the temporary table'
      'SELECT [Nominee].[NomineeID]'
      '     , [Nominee].[EventID]'
      '     , [Nominee].[MemberID]'
      
        '     , dbo.MembersSwimmerCategory([Member].[MemberID], @SwimClub' +
        'Id, @SeedDate) AS SwimmerCategoryID'
      'INTO #NomineeCAT'
      'FROM [SwimClubMeet].[dbo].[Nominee]'
      '    LEFT OUTER JOIN [SwimClubMeet].[dbo].[Member]'
      '        ON [Nominee].[MemberID] = [Member].[MemberID]'
      'WHERE ([Nominee].[EventID] = @EventID);      '
      ''
      ''
      '-- FINALLY'
      
        '----------------------------------------------------------------' +
        '------- '
      
        '-- FILTER OUT MEMBERS WHO HAVE RACED OR ARE IN HEATS THAT ARE CL' +
        'OSED.'
      '-- return count, CAT and gender.'
      'SELECT COUNT(#NomineeCAT.NomineeID) AS countNominees'
      '     , #NomineeCAT.SwimmerCategoryID'
      'FROM #NomineeCAT'
      '    LEFT OUTER JOIN #MembersInClosedHeats'
      '        ON #NomineeCAT.MemberID = #MembersInClosedHeats.MemberID'
      
        '           AND #NomineeCAT.EventID = #MembersInClosedHeats.Event' +
        'ID'
      'WHERE (#NomineeCAT.EventID = @EventID)'
      '      AND (#MembersInClosedHeats.MemberID IS NULL)'
      'GROUP BY SwimmerCategoryID'
      'ORDER BY SwimmerCategoryID DESC;'
      '')
    Left = 576
    Top = 128
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
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
      
        '-- LIST OF MEMBERS IN CLOSED OR RACED HEATS (FOR THE CURRENT EVE' +
        'NT)'
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#MembersInClosedHeats'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #MembersInClosedHeats;'
      '-- Create the temporary table '
      'SELECT Event.EventID'
      '     , Entrant.MemberID'
      'INTO #MembersInClosedHeats'
      'FROM [SwimClubMeet].[dbo].[Event]'
      '    INNER JOIN HeatIndividual'
      '        ON Event.EventID = HeatIndividual.EventID'
      '    INNER JOIN Entrant'
      '        ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE ('
      '          HeatIndividual.HeatStatusID = 2'
      '          OR HeatIndividual.HeatStatusID = 3'
      '      )'
      '      AND (Entrant.MemberID IS NOT NULL);'
      ''
      
        '-- LIST OF ALL NOMINEES FOR THE GIVEN EVENT AND THEIR PERSONAL D' +
        'ATA'
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#NomineesInEvent'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #NomineesInEvent;'
      '-- Create the temporary table'
      'SELECT [Nominee].[NomineeID]'
      '     , [Nominee].[EventID]'
      '     , [Nominee].[MemberID]'
      '     ,[Member].[DOB]'
      '    , dbo.SwimmerAge(@SessionStart, [Member].[DOB]) AS AGE'
      'INTO #NomineesInEvent'
      'FROM [SwimClubMeet].[dbo].[Nominee]'
      '    LEFT OUTER JOIN [SwimClubMeet].[dbo].[Member]'
      '        ON [Nominee].[MemberID] = [Member].[MemberID]'
      'WHERE ([Nominee].[EventID] = @EventID); '
      ''
      '-- FINALLY'
      
        '----------------------------------------------------------------' +
        '------- '
      
        '-- FILTER OUT MEMBERS WHO HAVE RACED OR ARE IN HEATS THAT ARE CL' +
        'OSED.'
      'SELECT '
      #9'COUNT(NomineeID) AS countNominees'
      #9',AGE'
      'FROM #NomineesInEvent'
      
        'LEFT OUTER JOIN #MembersInClosedHeats ON #MembersInClosedHeats.M' +
        'emberID = #NomineesInEvent.MemberID'
      #9'AND #MembersInClosedHeats.EventID = #NomineesInEvent.EventID'
      'WHERE (#NomineesInEvent.EventID = @EventID)'
      #9'AND (#MembersInClosedHeats.MemberID IS NULL)'
      'GROUP BY AGE'
      'ORDER BY AGE ASC'
      '')
    Left = 576
    Top = 296
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
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
      
        '-- LIST OF MEMBERS IN CLOSED OR RACED HEATS (FOR THE CURRENT EVE' +
        'NT)'
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#MembersInClosedHeats'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #MembersInClosedHeats;'
      '-- Create the temporary table '
      'SELECT Event.EventID'
      '     , Entrant.MemberID'
      'INTO #MembersInClosedHeats'
      'FROM [SwimClubMeet].[dbo].[Event]'
      '    INNER JOIN HeatIndividual'
      '        ON Event.EventID = HeatIndividual.EventID'
      '    INNER JOIN Entrant'
      '        ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE ('
      '          HeatIndividual.HeatStatusID = 2'
      '          OR HeatIndividual.HeatStatusID = 3'
      '      )'
      '      AND (Entrant.MemberID IS NOT NULL);'
      ''
      
        '-- LIST OF ALL NOMINEES FOR THE GIVEN EVENT AND THEIR PERSONAL D' +
        'ATA'
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#NomineesInEvent'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #NomineesInEvent;'
      '-- Create the temporary table'
      'SELECT [Nominee].[NomineeID]'
      '     , [Nominee].[EventID]'
      '     , [Nominee].[MemberID]'
      '     , [Member].[GenderID]'
      '     ,[Member].[DOB]'
      '    , dbo.SwimmerAge(@SessionStart, Member.DOB) AS AGE'
      'INTO #NomineesInEvent'
      'FROM [SwimClubMeet].[dbo].[Nominee]'
      '    LEFT OUTER JOIN [SwimClubMeet].[dbo].[Member]'
      '        ON [Nominee].[MemberID] = [Member].[MemberID]'
      'WHERE ([Nominee].[EventID] = @EventID);  '
      '    '
      '-- FINALLY'
      
        '----------------------------------------------------------------' +
        '------- '
      
        '-- FILTER OUT MEMBERS WHO HAVE RACED OR ARE IN HEATS THAT ARE CL' +
        'OSED.'
      'SELECT '
      #9'COUNT(NomineeID) AS countNominees'
      #9',GenderID'
      #9',AGE'
      'FROM #NomineesInEvent'
      
        'LEFT OUTER JOIN #MembersInClosedHeats ON #MembersInClosedHeats.M' +
        'emberID = #NomineesInEvent.MemberID'
      #9'AND #MembersInClosedHeats.EventID = #NomineesInEvent.EventID'
      'WHERE (#NomineesInEvent.EventID = @EventID)'
      #9'AND (#MembersInClosedHeats.MemberID IS NULL)'
      'GROUP BY GenderID, AGE'
      'ORDER BY GenderID DESC, AGE ASC;')
    Left = 576
    Top = 240
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
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
      
        '-- LIST OF MEMBERS IN CLOSED OR RACED HEATS (FOR THE CURRENT EVE' +
        'NT)'
      
        '----------------------------------------------------------------' +
        '----'
      '-- Drop a temporary table '
      'IF OBJECT_ID('#39'tempDB..#MembersInClosedHeats'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #MembersInClosedHeats;'
      '-- Create the temporary table '
      'SELECT Event.EventID'
      '     , Entrant.MemberID'
      'INTO #MembersInClosedHeats'
      'FROM [SwimClubMeet].[dbo].[Event]'
      '    INNER JOIN HeatIndividual'
      '        ON Event.EventID = HeatIndividual.EventID'
      '    INNER JOIN Entrant'
      '        ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE ('
      '          HeatIndividual.HeatStatusID = 2'
      '          OR HeatIndividual.HeatStatusID = 3'
      '      )'
      '      AND (Entrant.MemberID IS NOT NULL);'
      '     '
      'SELECT '
      #9'COUNT([Nominee].[NomineeID]) AS countNominees'
      'FROM [Nominee]'
      
        'LEFT OUTER JOIN #MembersInClosedHeats ON #MembersInClosedHeats.M' +
        'emberID = [Nominee].[MemberID]'
      #9'AND #MembersInClosedHeats.EventID = [Nominee].[EventID]'
      'WHERE ([Nominee].[EventID] = @EventID)'
      #9'AND (#MembersInClosedHeats.MemberID IS NULL)'
      '')
    Left = 576
    Top = 352
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
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
    Top = 240
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
        'D, SessionID, EventNum)'
      
        'VALUES (@Caption, @DistanceID, @StrokeID, 1, @SessionID, (@MaxEv' +
        'entNum+1));'
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
