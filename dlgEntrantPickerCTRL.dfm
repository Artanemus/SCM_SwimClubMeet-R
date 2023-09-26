object EntrantPickerCTRL: TEntrantPickerCTRL
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Quick-Pick from Active Members ,,,'
  ClientHeight = 702
  ClientWidth = 822
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 19
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 822
    Height = 702
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = 3107439
    ParentBackground = False
    TabOrder = 0
    StyleElements = [seFont, seBorder]
    ExplicitLeft = 640
    ExplicitTop = 200
    ExplicitWidth = 185
    ExplicitHeight = 41
    DesignSize = (
      822
      702)
    object VirtualImage1: TVirtualImage
      Left = 8
      Top = 8
      Width = 34
      Height = 39
      ImageCollection = ImageCollection1
      ImageWidth = 0
      ImageHeight = 0
      ImageIndex = 0
      ImageName = 'Search'
    end
    object btnCancel: TButton
      Left = 711
      Top = 94
      Width = 106
      Height = 35
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnPost: TButton
      Left = 711
      Top = 53
      Width = 106
      Height = 35
      Caption = 'Post'
      ModalResult = 1
      TabOrder = 1
      OnClick = btnPostClick
    end
    object btnToggleName: TButton
      Left = 711
      Top = 135
      Width = 106
      Height = 35
      Caption = 'Toggle Name'
      TabOrder = 2
      OnClick = btnToggleNameClick
    end
    object DBGrid1: TDBGrid
      Left = 8
      Top = 53
      Width = 697
      Height = 641
      Anchors = [akLeft, akTop, akBottom]
      DataSource = dsQuickPickCtrl
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 3
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
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AGE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Gender'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MemberID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'GenderID'
          Visible = False
        end>
    end
    object Nominate_Edit: TEdit
      Left = 48
      Top = 15
      Width = 223
      Height = 27
      TabOrder = 4
      OnChange = Nominate_EditChange
    end
  end
  object dsQuickPickCtrl: TDataSource
    DataSet = qryQuickPickCtrl
    Left = 263
    Top = 280
  end
  object qryQuickPickCtrl: TFDQuery
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
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @EventID INT;'
      'DECLARE @Algorithm INT;'
      'DECLARE @DistanceID INT;'
      'DECLARE @StrokeID INT;'
      'DECLARE @SessionStart DATETIME;'
      'DECLARE @ToggleName BIT;'
      'DECLARE @Order INT;'
      'DECLARE @CalcDefault INT;'
      'DECLARE @BottomPercent FLOAT;'
      'DECLARE @EventType INT;'
      ''
      'SET @EventID = :EVENTID;'
      'SET @Algorithm = :ALGORITHM;'
      'SET @ToggleName = :TOGGLENAME;'
      'SET @CalcDefault = :CALCDEFAULT'
      'SET @BottomPercent = :BOTTOMPERCENT'
      'SET @EventType = :EVENTTYPE'
      ''
      'SET @DistanceID ='
      '('
      '    SELECT DistanceID FROM Event WHERE Event.EventID = @EventID'
      ');'
      'SET @StrokeID ='
      '('
      '    SELECT StrokeID FROM Event WHERE Event.EventID = @EventID'
      ');'
      'SET @SessionStart ='
      '('
      '    SELECT Session.SessionStart'
      '    FROM Event'
      '        INNER JOIN Session'
      '            ON Event.SessionID = Session.SessionID'
      '    WHERE Event.EventID = @EventID'
      ');'
      ''
      '-- Drop a temporary table called '#39'#tmpID'#39
      'IF OBJECT_ID('#39'tempDB..#tmpID'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #tmpID;'
      ''
      'CREATE TABLE #tmpID'
      '('
      '    MemberID INT'
      '  --,TeamEntrant.TeamEntrantID AS ID'
      '  , GenderID INT'
      ')'
      ''
      'IF @EventType = 1'
      'BEGIN'
      '    INSERT INTO #tmpID'
      '    SELECT Entrant.MemberID'
      '         , Member.GenderID'
      '    FROM Entrant'
      '        INNER JOIN HeatIndividual'
      '            ON Entrant.HeatID = HeatIndividual.HeatID'
      '        INNER JOIN Event'
      '            ON HeatIndividual.EventID = Event.EventID'
      '        INNER JOIN Session'
      '            ON Event.SessionID = Session.SessionID'
      '        INNER JOIN Member'
      '            ON Entrant.MemberID = Member.MemberID'
      '    WHERE (HeatIndividual.EventID = @EventID)'
      '          AND (Entrant.MemberID IS NOT NULL);'
      'END'
      'ELSE'
      'BEGIN'
      '    INSERT INTO #tmpID'
      '    SELECT TeamEntrant.MemberID'
      '         , Member.GenderID'
      '    FROM TeamEntrant'
      '        INNER JOIN TEAM'
      '            ON TeamEntrant.TeamID = Team.TeamID'
      '        INNER JOIN HeatIndividual'
      '            ON Team.HeatID = HeatIndividual.HeatID'
      '        INNER JOIN Event'
      '            ON HeatIndividual.EventID = Event.EventID'
      '        INNER JOIN Session'
      '            ON Event.SessionID = Session.SessionID'
      '        INNER JOIN Member'
      '            ON TeamEntrant.MemberID = Member.MemberID'
      '    WHERE (HeatIndividual.EventID = @EventID)'
      '          AND (TeamEntrant.MemberID IS NOT NULL);'
      'END'
      ''
      
        '-- ALL OTHER Members who have not been placed in the current sel' +
        'ected event'
      'SELECT Member.MemberID'
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
      'FROM Member'
      '    LEFT OUTER JOIN #tmpID'
      '        ON #tmpID.MemberID = Member.MemberID'
      'WHERE #tmpID.MemberID IS NULL'
      '      AND Member.IsActive = 1')
    Left = 136
    Top = 272
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 350
      end
      item
        Name = 'ALGORITHM'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
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
    object qryQuickPickCtrlFName: TWideStringField
      DisplayLabel = 'Member'#39's Name'
      DisplayWidth = 30
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Size = 48
    end
    object qryQuickPickCtrlTTB: TTimeField
      Alignment = taCenter
      DisplayLabel = 'TimeToBeat'
      DisplayWidth = 12
      FieldName = 'TTB'
      Origin = 'TTB'
      ReadOnly = True
      DisplayFormat = 'nn:ss.zzz'
    end
    object qryQuickPickCtrlPB: TTimeField
      Alignment = taCenter
      DisplayLabel = 'Personal Best'
      DisplayWidth = 12
      FieldName = 'PB'
      Origin = 'PB'
      ReadOnly = True
      DisplayFormat = 'nn:ss.zzz'
    end
    object qryQuickPickCtrlAGE: TIntegerField
      Alignment = taCenter
      DisplayLabel = '  AGE'
      DisplayWidth = 5
      FieldName = 'AGE'
      Origin = 'AGE'
      ReadOnly = True
      DisplayFormat = '##0'
    end
    object qryQuickPickCtrlGender: TWideStringField
      Alignment = taCenter
      DisplayWidth = 9
      FieldName = 'Gender'
      Origin = 'Gender'
      ReadOnly = True
      Size = 2
    end
    object qryQuickPickCtrlMemberID: TFDAutoIncField
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryQuickPickCtrlGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
    end
  end
  object FDCommandUpdateEntrant: TFDCommand
    CommandText.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @MemberID AS Integer;'
      'DECLARE @ID AS Integer;'
      'DECLARE @TTB AS DateTime;'
      'DECLARE @PB AS DateTime;'
      'DECLARE @EventType AS INT;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @ID = :ENTRANTID;'
      'SET @TTB = :TTB;'
      'SET @PB = :PB;'
      'SET @EventType = :EVENTYPE;'
      ''
      'IF @EventType = 1'
      'BEGIN'
      'UPDATE [SwimClubMeet].[dbo].[Entrant]'
      '   SET [MemberID] = @MemberID'
      '      ,[RaceTime] = NULL'
      '      ,[TimeToBeat] = @TTB'
      '      ,[PersonalBest] = @PB'
      '      ,[IsDisqualified] = 0'
      '      ,[IsScratched] = 0'
      '      ,[DisqualifyCodeID] = NULL'
      ' WHERE EntrantID = @ID;'
      ' END'
      ' ELSE'
      ' BEGIN'
      ' UPDATE [SwimClubMeet].[dbo].[TeamEntrant]'
      '   SET [MemberID] = @MemberID'
      '      ,[RaceTime] = NULL'
      '      ,[TimeToBeat] = @TTB'
      '      ,[PersonalBest] = @PB'
      '      --,[DisqualifyCodeID] = NULL'
      '      --,[IsDisqualified] = 0'
      '      --,[IsScratched] = 0'
      ' WHERE TeamEntrantID = @ID;'
      ' END')
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ENTRANTID'
        DataType = ftInteger
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
        Name = 'EVENTYPE'
        ParamType = ptInput
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
    Left = 464
    Top = 216
  end
end
