object EntrantPicker: TEntrantPicker
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Quick-Pick Nominee ...'
  ClientHeight = 702
  ClientWidth = 829
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 19
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 829
    Height = 702
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 825
    ExplicitHeight = 701
    DesignSize = (
      829
      702)
    object VirtualImage2: TVirtualImage
      Left = 8
      Top = 12
      Width = 34
      Height = 39
      ImageCollection = ImageCollection1
      ImageWidth = 0
      ImageHeight = 0
      ImageIndex = 0
      ImageName = 'Search'
    end
    object DBGrid1: TDBGrid
      Left = 8
      Top = 64
      Width = 697
      Height = 623
      Anchors = [akLeft, akTop, akBottom]
      DataSource = dsQuickPick
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnTitleClick = DBGrid1TitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'FName'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TTB'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PB'
          Width = 114
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'AGE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Gender'
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MemberID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'EventID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'GenderID'
          Visible = False
        end>
    end
    object btnPost: TButton
      Left = 711
      Top = 64
      Width = 106
      Height = 35
      Caption = 'Post'
      ModalResult = 1
      TabOrder = 2
      OnClick = btnPostClick
    end
    object btnCancel: TButton
      Left = 711
      Top = 105
      Width = 106
      Height = 35
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 3
      OnClick = btnCancelClick
    end
    object btnToggleName: TButton
      Left = 711
      Top = 146
      Width = 106
      Height = 35
      Caption = 'Toggle Name'
      TabOrder = 4
      OnClick = btnToggleNameClick
    end
    object Nominate_Edit: TEdit
      Left = 48
      Top = 18
      Width = 249
      Height = 27
      TabOrder = 0
      OnChange = Nominate_EditChange
    end
  end
  object qryQuickPick: TFDQuery
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
      'DECLARE @SessionID AS INT;'
      'DECLARE @DistanceID AS INT;'
      'DECLARE @StrokeID AS INT;'
      'DECLARE @Algorithm INT;'
      'DECLARE @SessionStart DATETIME;'
      'DECLARE @ToggleName BIT;'
      'DECLARE @Order INT;'
      'DECLARE @CalcDefault INT;'
      'DECLARE @BottomPercent FLOAT;'
      'DECLARE @EventType AS INT;'
      ''
      'SET @EventID = :EVENTID;'
      'SET @SessionID = ('
      #9#9'SELECT SessionID'
      #9#9'FROM Event'
      #9#9'WHERE Event.EventID = @EventID'
      #9#9');'
      'SET @DistanceID = ('
      #9#9'SELECT DistanceID'
      #9#9'FROM Event'
      #9#9'WHERE Event.EventID = @EventID'
      #9#9');'
      'SET @StrokeID = ('
      #9#9'SELECT StrokeID'
      #9#9'FROM Event'
      #9#9'WHERE Event.EventID = @EventID'
      #9#9');'
      'SET @Algorithm = :ALGORITHM;'
      'SET @ToggleName = :TOGGLENAME;'
      'SET @CalcDefault = :CALCDEFAULT'
      'SET @BottomPercent = :BOTTOMPERCENT;'
      'SET @EventType = :EVENTTYPE;'
      'SET @SessionStart = ('
      '       SELECT Session.SessionStart'
      '       FROM Event '
      '       INNER JOIN Session ON Event.SessionID = Session.SessionID'
      '       WHERE Event.EventID = @EventID);'
      ''
      ''
      '-- Drop a temporary table called '#39'#tmpID'#39
      '-- Drop the table if it already exists'
      ''
      'IF OBJECT_ID('#39'tempDB..#tmpID'#39', '#39'U'#39') IS NOT NULL'
      'DROP TABLE #tmpID;'
      ''
      'CREATE TABLE #tmpID'
      '('
      '    MemberID INT'
      '    --,TeamEntrant.TeamEntrantID AS ID'
      '    ,EventID INT   '
      ')'
      ''
      '-- Members given a swimming lane in the given event '
      'IF @EventType = 1'
      'BEGIN'
      '    INSERT INTO #tmpID'
      '    SELECT Entrant.MemberID'
      #9#9'--,Entrant.EntrantID  AS ID'
      #9#9',HeatIndividual.EventID'
      '    FROM [SwimClubMeet].[dbo].[HeatIndividual]'
      #9'INNER JOIN Entrant ON Entrant.HeatID = HeatIndividual.HeatID'
      #9'WHERE HeatIndividual.EventID = @EventID;'
      'END '
      'ELSE'
      'BEGIN '
      ''
      '    INSERT INTO #tmpID'
      #9'SELECT TeamEntrant.MemberID'
      #9#9'--,TeamEntrant.TeamEntrantID AS ID'
      #9#9',HeatIndividual.EventID'
      #9'FROM [SwimClubMeet].[dbo].[HeatIndividual]'
      #9'INNER JOIN Team ON HeatIndividual.HeatID = Team.HeatID '
      #9'INNER JOIN TeamEntrant ON Team.TeamID = TeamEntrant.TeamID'
      #9'WHERE HeatIndividual.EventID = @EventID;'
      'END'
      ' '
      ' '
      'SELECT Nominee.EventID'
      #9',Nominee.MemberID'
      '        ,Member.GenderID'
      #9'--,tmpID.ID'
      #9',dbo.SwimmerAge(@SessionStart, Member.DOB) AS AGE'
      #9',dbo.SwimmerGenderToString(Member.MemberID) AS Gender'
      
        #9',dbo.TimeToBeat(@Algorithm, @CalcDefault, @BottomPercent, Membe' +
        'r.MemberID, @DistanceID, @StrokeID, @SessionStart) AS TTB'
      
        #9',dbo.PersonalBest(Member.MemberID, @DistanceID, @StrokeID, @Ses' +
        'sionStart) AS PB'
      #9',CASE '
      #9#9'WHEN @ToggleName = 0'
      #9#9#9'THEN SUBSTRING(CONCAT ('
      #9#9#9#9#9#9'UPPER([LastName])'
      #9#9#9#9#9#9','#39', '#39
      #9#9#9#9#9#9',[FirstName]'
      #9#9#9#9#9#9'), 0, 30)'
      #9#9'WHEN @ToggleName = 1'
      #9#9#9'THEN SUBSTRING(CONCAT ('
      #9#9#9#9#9#9'[FirstName]'
      #9#9#9#9#9#9','#39', '#39
      #9#9#9#9#9#9',UPPER([LastName])'
      #9#9#9#9#9#9'), 0, 48)'
      #9#9'END AS FName'
      'FROM Nominee'
      'LEFT OUTER JOIN #tmpID ON #tmpID.MemberID = Nominee.MemberID'
      'LEFT OUTER JOIN Member ON Nominee.MemberID = Member.MemberID'
      'WHERE Nominee.EventID = @EventID'
      #9'AND #tmpID.MemberID IS NULL;'
      '')
    Left = 152
    Top = 216
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 356
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
        Name = 'EVENTTYPE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qryQuickPickFName: TWideStringField
      DisplayLabel = 'Nominees'
      DisplayWidth = 30
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Size = 60
    end
    object qryQuickPickTTB: TTimeField
      Alignment = taCenter
      DisplayLabel = 'TimeToBeat'
      DisplayWidth = 12
      FieldName = 'TTB'
      Origin = 'TTB'
      ReadOnly = True
      DisplayFormat = 'nn:ss.zzz'
    end
    object qryQuickPickPB: TTimeField
      Alignment = taCenter
      DisplayLabel = 'Personal Best'
      DisplayWidth = 12
      FieldName = 'PB'
      Origin = 'PB'
      ReadOnly = True
      DisplayFormat = 'nn:ss.zzz'
    end
    object qryQuickPickAGE: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = '  AGE'
      DisplayWidth = 5
      FieldName = 'AGE'
      Origin = 'AGE'
      ReadOnly = True
      DisplayFormat = '##0'
    end
    object qryQuickPickGender: TWideStringField
      Alignment = taCenter
      DisplayWidth = 9
      FieldName = 'Gender'
      Origin = 'Gender'
      ReadOnly = True
      Size = 2
    end
    object qryQuickPickMemberID: TIntegerField
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryQuickPickEventID: TIntegerField
      FieldName = 'EventID'
      Origin = 'EventID'
    end
    object qryQuickPickGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
    end
  end
  object dsQuickPick: TDataSource
    DataSet = qryQuickPick
    Left = 240
    Top = 216
  end
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
      'ELSE'
      'BEGIN'
      '   UPDATE [dbo].[TeamEntrant]'
      '   SET [MemberID] = @MemberID'
      '      ,[RaceTime] = NULL'
      '      ,[TimeToBeat] = @TTB'
      '      ,[PersonalBest] = @PB'
      '--      ,[IsDisqualified] = 0'
      '--      ,[IsScratched] = 0'
      '--      ,[DisqualifyCodeID] = NULL'
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
    Left = 152
    Top = 128
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Search'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000002A1494441546843ED99E151D6401086
              5F2AD00EC00A900A900A1C2B502B102A502A102A502B502B502AD00EB403A002
              9867E696593249EE2E7BE14B66727FC27CDC77B7CFBDEFEE6D604F2B1F7B2B8F
              5F1BC0AE15DC1458B302AF25BD92F4323D8DE546D25F49BF25FD4C3FCFC639C5
              426F257D927450181520EF25FD2F9C5F35AD06E0B9A4EF9DD3AED9EC54D265CD
              174AE6960260932FC92EB6EEADA4AFC9229C2E270DA4598A2736F383F9A8D16C
              940010D4AF4EF05792DE15D8821CF921E9998B181550A3C928012078026170EA
              F8FFA262770E8093F76ABC496015CBF44FCD0170CA58C7C65965F07E572AD361
              FA804AF54212CFD0C801FC73D506DB981253362527C813B3D3795273CA5A0FDF
              19032058EC63D621806829C4FB9FD39AAC850AA1310680CF3FA4D5BFA5A40D6D
              96BE7CE716012074286300C87D9C368B78BF0BED7321BCEE18C075AAEB047092
              FCDB42012A12B739239C0763005EEA5CB2D78051863F3E3540D8AB8EF0C900BC
              579B5D3CC98A965BB35A8816C06ECFF0464E81A6B935E66D7F0BA3C6518DD107
              E6D2827339DA08E7D6D802DDCDC2252F5D8C769B37B95B7227E04B1E7D0B2A4C
              BD787CF2A24093C290034005EC63FD0B971B095DDB84D186FC71D669D652E700
              D8B3DB91A2002F25C0940C6A3EA76FA35927CA822500CCEBCACF67F44A54A721
              35FADEE20CA2D99B5929409F12160C8AF4BD5276D5E165C8BF993581A8012020
              2A081BEF9778C7CDA1E2D04AA39AF541FC3A0C510B6031911704646F58433C04
              4ED014026F9F661053012C18FF57080F41828F25B92FCF2125A200954E7A34BD
              09C42E01ECE44376DA3540186209002188A5004C865812C02488A50154432C11
              A00F62B07B5D2A8087A087A285F1B7F9C385B26400EB78ED7F10BD97E6D201B2
              37FD06903DA299276C0ACC7CC0D9E557AFC03D711588316245F5CB0000000049
              454E44AE426082}
          end>
      end>
    Left = 360
    Top = 312
  end
end
