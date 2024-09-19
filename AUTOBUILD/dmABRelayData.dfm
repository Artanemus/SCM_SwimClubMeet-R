object ABRelayData: TABRelayData
  Height = 480
  Width = 640
  object FDCommandUpdateEntrant: TFDCommand
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
  object qryRelayNominee: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    FilterOptions = [foCaseInsensitive]
    Filter = '[FName] LIKE '#39'%b%'#39
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxMemberFName'
        Fields = 'FName'
      end
      item
        Active = True
        Name = 'idxMemberFNameDESC'
        Fields = 'FName'
        DescFields = 'FName'
        Options = [soDescNullLast, soDescending]
      end
      item
        Active = True
        Name = 'idxTTB'
        Fields = 'TTB'
      end
      item
        Active = True
        Name = 'idxTTBDESC'
        Fields = 'TTB'
        DescFields = 'TTB'
        Options = [soDescending]
      end
      item
        Active = True
        Name = 'idxPB'
        Fields = 'PB'
      end
      item
        Active = True
        Name = 'idxPBDESC'
        Fields = 'PB'
        DescFields = 'PB'
        Options = [soDescending]
      end
      item
        Active = True
        Name = 'idxAge'
        Fields = 'AGE'
      end
      item
        Active = True
        Name = 'idxAgeDESC'
        Fields = 'AGE'
        Options = [soDescNullLast, soDescending]
      end
      item
        Active = True
        Name = 'idxGender'
        Fields = 'GenderID'
      end
      item
        Active = True
        Name = 'idxGenderDESC'
        Fields = 'GenderID'
        Options = [soDescNullLast, soDescending]
      end>
    IndexName = 'idxMemberFName'
    DetailFields = 'MemberID'
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
      ''
      'SET @EventID = :EVENTID;'
      'SET @Algorithm = :ALGORITHM;'
      'SET @ToggleName = :TOGGLENAME;'
      'SET @CalcDefault = :CALCDEFAULT'
      'SET @BottomPercent = :BOTTOMPERCENT'
      'SET @DistanceID = :XDISTANCEID'
      'SET @TopNumber = :TOPNUMBER'
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
      '    AND HeatIndividual.HeatStatusID = 1;'
      '     '
      ''
      'SELECT TOP @TopNumber Nominee.EventID'
      '     , Nominee.MemberID'
      '     , Member.GenderID'
      '     , dbo.SwimmerAge(@SessionStart, Member.DOB) AS AGE'
      '     , dbo.SwimmerGenderToString(Member.MemberID) AS Gender'
      
        '     , dbo.TimeToBeat(@Algorithm, @CalcDefault, @BottomPercent, ' +
        'Member.MemberID, @DistanceID, @StrokeID, @SessionStart) AS TTB'
      
        '     , dbo.PersonalBest(Member.MemberID, @DistanceID, @StrokeID,' +
        ' @SessionStart) AS PB'
      '     , CASE'
      '           WHEN @ToggleName = 0 THEN'
      
        '               SUBSTRING(CONCAT(UPPER([LastName]), '#39', '#39', [FirstN' +
        'ame]), 0, 30)'
      '           WHEN @ToggleName = 1 THEN'
      
        '               SUBSTRING(CONCAT([FirstName], '#39', '#39', UPPER([LastNa' +
        'me])), 0, 48)'
      '       END AS FName'
      'FROM Nominee'
      '    LEFT OUTER JOIN #tmpID'
      '        ON #tmpID.MemberID = Nominee.MemberID'
      '    LEFT OUTER JOIN Member'
      '        ON Nominee.MemberID = Member.MemberID'
      'WHERE Nominee.EventID = @EventID'
      '      AND #tmpID.MemberID IS NULL '
      'ORDER BY TTB ASC      '
      '      ;'
      '')
    Left = 128
    Top = 152
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 65
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
        DataType = ftFloat
        ParamType = ptInput
        Value = 50.000000000000000000
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
  object dsRelayNominee: TDataSource
    DataSet = qryRelayNominee
    Left = 232
    Top = 152
  end
  object qryCountRNominee: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    FilterOptions = [foCaseInsensitive]
    Filter = '[FName] LIKE '#39'%b%'#39
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'idxMemberFName'
        Fields = 'FName'
      end
      item
        Active = True
        Name = 'idxMemberFNameDESC'
        Fields = 'FName'
        DescFields = 'FName'
        Options = [soDescNullLast, soDescending]
      end
      item
        Active = True
        Name = 'idxTTB'
        Fields = 'TTB'
      end
      item
        Active = True
        Name = 'idxTTBDESC'
        Fields = 'TTB'
        DescFields = 'TTB'
        Options = [soDescending]
      end
      item
        Active = True
        Name = 'idxPB'
        Fields = 'PB'
      end
      item
        Active = True
        Name = 'idxPBDESC'
        Fields = 'PB'
        DescFields = 'PB'
        Options = [soDescending]
      end
      item
        Active = True
        Name = 'idxAge'
        Fields = 'AGE'
      end
      item
        Active = True
        Name = 'idxAgeDESC'
        Fields = 'AGE'
        Options = [soDescNullLast, soDescending]
      end
      item
        Active = True
        Name = 'idxGender'
        Fields = 'GenderID'
      end
      item
        Active = True
        Name = 'idxGenderDESC'
        Fields = 'GenderID'
        Options = [soDescNullLast, soDescending]
      end>
    IndexName = 'idxMemberFName'
    DetailFields = 'MemberID'
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
      '    AND HeatIndividual.HeatStatusID = 1;'
      ''
      'SELECT Count(NomineeID) AS CountNominees'
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
end
