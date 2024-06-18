object MemberHouse: TMemberHouse
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object qryMinHouse: TFDQuery
    Connection = SCM.scmConnection
    SQL.Strings = (
      '-- Drop a temporary table called '#39'#tmpHouse'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#tmpHouse'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmpHouse'
      ';'
      ''
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      
        '-- Create the temporary table from a physical table called '#39'tmpH' +
        'ouse'#39' in schema '#39'dbo'#39' in database '#39'DatabaseName'#39
      'SELECT COUNT(MemberID) AS countMembers'
      '     , [Member].HouseID'
      'INTO #tmpHouse'
      'FROM dbo.Member'
      '    LEFT JOIN House'
      '        ON member.HouseID = House.HouseID'
      'WHERE ([Member].IsActive = 1)'
      '      AND ([Member].IsSwimmer = 1)'
      '      AND ([Member].IsArchived = 0)'
      '      AND [Member].SwimClubID = @SwimClubID'
      'GROUP BY [Member].HouseID;'
      ''
      'SELECT MIN(countMembers) AS myMAX'
      '     , [House].HouseID'
      '     , [House].Caption'
      'FROM #tmpHouse'
      '    LEFT JOIN House'
      '        ON #tmpHouse.HouseID = House.HouseID'
      'GROUP BY [House].Caption, [House].HouseID;')
    Left = 80
    Top = 56
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qryMinHouseAGE: TFDQuery
    Connection = SCM.scmConnection
    SQL.Strings = (
      '-- Drop a temporary table called '#39'#tmpHouse'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#tmpHouse'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmpHouse'
      ';'
      ''
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = :SWIMCLUBID;'
      'DECLARE @AGE AS INTEGER;'
      'SET @AGE = :AGE;'
      'DECLARE @SessionDate AS DATE;'
      'SET @SessionDate = :SESSIONDATE;'
      ''
      
        '-- Create the temporary table from a physical table called '#39'tmpH' +
        'ouse'#39' in schema '#39'dbo'#39' in database '#39'DatabaseName'#39
      'SELECT COUNT(MemberID) AS countMembers'
      '     , [Member].HouseID'
      'INTO #tmpHouse'
      'FROM dbo.Member'
      '    LEFT JOIN House'
      '        ON member.HouseID = House.HouseID'
      'WHERE ([Member].IsActive = 1)'
      '      AND ([Member].IsSwimmer = 1)'
      '      AND ([Member].IsArchived = 0)'
      '      AND [Member].SwimClubID = @SwimClubID'
      '      AND (dbo.SwimmerAge(@SessionDate,[Member].DOB) = @AGE)'
      'GROUP BY [Member].HouseID;'
      ''
      'SELECT MIN(countMembers) AS myMAX'
      '     , [House].HouseID'
      '     , [House].Caption'
      'FROM #tmpHouse'
      '    LEFT JOIN House'
      '        ON #tmpHouse.HouseID = House.HouseID'
      'GROUP BY [House].Caption, [House].HouseID;')
    Left = 80
    Top = 144
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'AGE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 12
      end
      item
        Name = 'SESSIONDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 0d
      end>
  end
end
