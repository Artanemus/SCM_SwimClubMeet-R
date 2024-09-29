object ABRelayData: TABRelayData
  Height = 480
  Width = 640
  object FDCommandUpdateEntrant: TFDCommand
    Connection = SCM.scmConnection
    CommandText.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @MemberID AS Integer;'
      'DECLARE @ID AS Integer;'
      'DECLARE @TTB AS DateTime;'
      'DECLARE @PB AS DateTime;'
      'DECLARE @EventType AS integer;'
      ''
      'SET @MemberID = :MEMBERID;'
      
        'SET @ID = :ID;   -- TeamEntrant.TeamEntrantID or Entrant.Entrant' +
        'ID'
      'SET @TTB = :TTB;'
      'SET @PB = :PB;'
      'SET @EventType = :EVENTTYPE;'
      ''
      'IF (@EventType = 1)'
      'BEGIN'
      '   UPDATE [dbo].[Entrant]'
      '   SET [MemberID] = @MemberID'
      '      ,[RaceTime] = NULL'
      '      ,[TimeToBeat] = @TTB'
      '      ,[PersonalBest] = @PB'
      '      ,[IsDisqualified] = 0'
      '      ,[IsScratched] = 0'
      '      ,[DisqualifyCodeID] = NULL'
      '   WHERE EntrantID = @ID;'
      'END '
      'ELSE IF (@EventType = 2)'
      'BEGIN'
      '   UPDATE [dbo].[TeamEntrant]'
      '   SET [MemberID] = @MemberID'
      '      ,[RaceTime] = NULL'
      '      ,[TimeToBeat] = @TTB'
      '      ,[PersonalBest] = @PB'
      '      ,[IsDisqualified] = 0'
      '      ,[IsScratched] = 0'
      '      ,[DisqualifyCodeID] = NULL'
      '   WHERE TeamEntrantID = @ID;'
      'END'
      ''
      '')
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ID'
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TTB'
        DataType = ftTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PB'
        DataType = ftTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EVENTTYPE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    Left = 128
    Top = 40
  end
  object dsRNominee: TDataSource
    Left = 272
    Top = 152
  end
  object qryCountRNominee: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    FilterOptions = [foCaseInsensitive]
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvCheckReadOnly]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Nominee'
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      '-- NOTE: event type must be 2 (TEAM)'
      '-- find nominees in relay event.'
      '-- exclude raced and closed heats.'
      '--'
      '-- count nominees NO in event.'
      ''
      'DECLARE @EventID AS INT;'
      'SET @EventID = :EVENTID;'
      ''
      '-- Drop a temporary table called '#39'#tmpA'#39
      'IF OBJECT_ID('#39'tempDB..#tmpA'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmpA;'
      ''
      'CREATE TABLE #tmpA'
      '('
      '    MemberID INT'
      ')'
      ''
      '-- Members given a swimming lane in the given event '
      ''
      '    INSERT INTO #tmpA'
      '    SELECT TeamEntrant.MemberID'
      '    FROM [SwimClubMeet].[dbo].[HeatIndividual]'
      '        INNER JOIN Team'
      '            ON HeatIndividual.HeatID = Team.HeatID'
      '        INNER JOIN TeamEntrant'
      '            ON Team.TeamID = TeamEntrant.TeamID'
      '    WHERE HeatIndividual.EventID = @EventID '
      '    AND HeatIndividual.HeatStatusID <> 1;'
      ''
      'SELECT ISNULL(Count(NomineeID), 0) AS CountNominees'
      'FROM Nominee'
      '    LEFT OUTER JOIN #tmpA'
      '        ON #tmpA.MemberID = Nominee.MemberID'
      '    LEFT OUTER JOIN Member'
      '        ON Nominee.MemberID = Member.MemberID'
      'WHERE Nominee.EventID = @EventID'
      '      AND #tmpA.MemberID IS NULL ;'
      '')
    Left = 400
    Top = 48
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryTNum: TFDQuery
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      ''
      ''
      'DECLARE @TeamNumExists AS BIT;'
      'DECLARE @DistanceID AS INTEGER;'
      ''
      'SET @DistanceID = :DISTANCEID;'
      ''
      'IF EXISTS (SELECT * '
      '           FROM INFORMATION_SCHEMA.COLUMNS '
      '           WHERE TABLE_NAME = '#39'Distance'#39' '
      '           AND COLUMN_NAME = '#39'TeamNum'#39')'
      'BEGIN'
      '   SET @TeamNumExists = 1'
      'END'
      'ELSE'
      'BEGIN'
      '   SET @TeamNumExists = 0'
      'END'
      ''
      'SELECT '
      '  [ABREV], '
      #9'CASE '
      #9#9'WHEN @TeamNumExists = 1 THEN '#39'[TeamNum]'#39
      #9#9'ELSE 0'
      #9'END AS TNum'
      'FROM '
      '  [dbo].[Distance]'
      'WHERE '
      '  DistanceID = @DistanceID;'
      ''
      ''
      '')
    Left = 128
    Top = 232
    ParamData = <
      item
        Name = 'DISTANCEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryLastTeamNameID: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'DECLARE @EventID INTEGER;'
      'SET @EventID = :EVENTID;'
      ''
      'SELECT ISNULL(MAX(TeamNameID), 0) AS LastTeamNameID FROM Team '
      'INNER JOIN HeatIndividual on Team.HeatID = HeatIndividual.HeatID'
      'WHERE EventID = @EventID;')
    Left = 128
    Top = 304
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 65
      end>
  end
  object qryRNominee: TFDQuery
    IndexFieldNames = 'NomineeID'
    DetailFields = 'NomineeID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.Nominee'
    UpdateOptions.KeyFields = 'NomineeID'
    SQL.Strings = (
      '--USE SwimClubMeet'
      '--GO'
      ''
      'DECLARE @EventID AS INT;'
      'DECLARE @Algorithm INT;'
      'DECLARE @DistanceID AS INT;'
      'DECLARE @StrokeID AS INT;'
      'DECLARE @SessionStart DATETIME;'
      'DECLARE @ToggleName BIT;'
      'DECLARE @Order INT;'
      'DECLARE @CalcDefault INT;'
      'DECLARE @BottomPercent FLOAT;'
      'DECLARE @TopNumber INT;'
      ''
      'DECLARE @SQL NVARChar(MAX);'
      ''
      ''
      'SET @EventID = :EVENTID;'
      'SET @Algorithm = :ALGORITHM;'
      'SET @ToggleName = :TOGGLENAME;'
      'SET @CalcDefault = :CALCDEFAULT;'
      'SET @BottomPercent = :BOTTOMPERCENT;'
      'SET @DistanceID = :XDISTANCEID;'
      'SET @TopNumber = :TOPNUMBER;'
      ''
      'SET @StrokeID ='
      '('
      '    SELECT StrokeID FROM Event WHERE Event.EventID = @EventID'
      ');'
      ''
      'SET @SessionStart ='
      '('
      '    SELECT Session.SessionStart'
      '    FROM Event'
      '        INNER JOIN Session'
      '            ON Event.SessionID = Session.SessionID'
      '    WHERE Event.EventID = @EventID'
      ');'
      ''
      ''
      '-- Drop a temporary table called '#39'#tmpID'#39
      'IF OBJECT_ID('#39'tempDB..#tmpID'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmpID;'
      ''
      'CREATE TABLE #tmpID'
      '('
      '    MemberID INT'
      ')'
      ''
      '-- Members given a swimming lane in the given event '
      ''
      '    INSERT INTO #tmpID'
      '    SELECT TeamEntrant.MemberID'
      '    FROM [SwimClubMeet].[dbo].[HeatIndividual]'
      '        INNER JOIN Team'
      '            ON HeatIndividual.HeatID = Team.HeatID'
      '        INNER JOIN TeamEntrant'
      '            ON Team.TeamID = TeamEntrant.TeamID'
      '    WHERE HeatIndividual.EventID = @EventID'
      '    AND HeatIndividual.HeatStatusID <> 1;'
      '    '
      '    '
      '-- Construct dynamic SQL'
      ''
      'SELECT TOP (@TopNumber) '
      'Nominee.NomineeID,'
      '    Nominee.EventID,'
      '    Nominee.MemberID,'
      '    Member.GenderID,'
      '    dbo.SwimmerAge(@SessionStart, Member.DOB) AS AGE,'
      '    dbo.SwimmerGenderToString(Nominee.MemberID) AS Gender,'
      
        '    dbo.TimeToBeat(@Algorithm, @CalcDefault, @BottomPercent, Nom' +
        'inee.MemberID, @DistanceID, @StrokeID, @SessionStart) AS xTTB,'
      
        '    dbo.PersonalBest(Nominee.MemberID, @DistanceID, @StrokeID, @' +
        'SessionStart) AS xPB,'
      '    CASE '
      
        '        WHEN @ToggleName = 0 THEN SUBSTRING(CONCAT(UPPER([LastNa' +
        'me]), '#39' '#39', [FirstName]), 0, 30)'
      
        '        WHEN @ToggleName = 1 THEN SUBSTRING(CONCAT([FirstName], ' +
        #39' '#39', UPPER([LastName])), 0, 48)'
      '    END AS FName'
      'FROM Nominee'
      'LEFT OUTER JOIN #tmpID ON #tmpID.MemberID = Nominee.MemberID'
      'LEFT OUTER JOIN Member ON Nominee.MemberID = Member.MemberID'
      'WHERE Nominee.EventID = @EventID'
      'AND #tmpID.MemberID IS NULL'
      'ORDER BY TTB ASC;'
      '   '
      ' '
      '      '
      '')
    Left = 136
    Top = 152
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1506
      end
      item
        Name = 'ALGORITHM'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'TOGGLENAME'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'CALCDEFAULT'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'BOTTOMPERCENT'
        DataType = ftInteger
        ParamType = ptInput
        Value = 50
      end
      item
        Name = 'XDISTANCEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'TOPNUMBER'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1000
      end>
  end
  object cmdInsertTeamEntrant: TFDCommand
    Connection = SCM.scmConnection
    CommandText.Strings = (
      'DECLARE @MemberID AS INT;'
      'DECLARE @Lane AS INT;'
      'DECLARE @TeamID AS INT;'
      'DECLARE @PB AS TTIME;'
      'DECLARE @TTB AS TTIME;'
      'DECLARE @StrokeID AS INT;'
      'DECLARE @IsDisqualified AS BIT;'
      'DECLARE @IsScratched AS BIT;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @Lane = :LANE;'
      'SET @TeamID = :TEAMID;'
      'SET @PB = :PB;'
      'SET @TTB = :TTB;'
      'SET @StrokeID = :STROKEID;'
      'SET @IsDisqualified = :ISDISQUALIFIED;'
      'SET @IsScratched = :ISSCRATCHED;'
      ''
      ''
      ''
      'INSERT INTO dbo.TeamEntrant'
      
        '(MemberID, Lane, TeamID, PersonalBest, TimeToBeat, StrokeID, IsD' +
        'isqualified, IsScratched)'
      'VALUES'
      
        '(@MEMBERID, @LANE, @TEAMID, @PB, @TTB, @STROKEID, @ISDISQUALIFIE' +
        'D, @ISSCRATCHED);')
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'LANE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TEAMID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PB'
        DataType = ftTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TTB'
        DataType = ftTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'STROKEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ISDISQUALIFIED'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ISSCRATCHED'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end>
    Left = 408
    Top = 224
  end
end
