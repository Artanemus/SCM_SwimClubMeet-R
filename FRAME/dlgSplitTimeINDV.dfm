object SplitTimeINDV: TSplitTimeINDV
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'RaceTime and SplitTimes'
  ClientHeight = 419
  ClientWidth = 317
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 317
    Height = 65
    Align = alTop
    BevelEdges = [beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 3
      Top = 17
      Width = 81
      Height = 25
      Caption = 'RaceTime'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object DBGridRaceTime: TDBGrid
      Left = 90
      Top = 13
      Width = 154
      Height = 39
      DataSource = dsEntrant
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [dgEditing, dgAlwaysShowEditor, dgColumnResize, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnKeyDown = DBGridRaceTimeKeyDown
      Columns = <
        item
          Alignment = taLeftJustify
          Expanded = False
          FieldName = 'RaceTime'
          Width = 140
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 317
    Height = 298
    Align = alClient
    BevelEdges = []
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    object DBGridSplit: TDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 250
      Height = 293
      Align = alClient
      DataSource = dsSplit
      Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'LapNum'
          ReadOnly = True
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SplitTime'
          Title.Alignment = taCenter
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SplitID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'EntrantID'
          Visible = False
        end>
    end
    object RelativePanel1: TRelativePanel
      Left = 256
      Top = 0
      Width = 65
      Height = 299
      ControlCollection = <
        item
          Control = sbtnDelete
          AlignBottomWithPanel = False
          AlignHorizontalCenterWithPanel = True
          AlignLeftWithPanel = False
          AlignRightWithPanel = False
          AlignTopWithPanel = False
          AlignVerticalCenterWithPanel = False
          Below = sbtnNew
        end
        item
          Control = sbtnMoveDown
          AlignBottomWithPanel = False
          AlignHorizontalCenterWithPanel = True
          AlignLeftWithPanel = False
          AlignRightWithPanel = False
          AlignTopWithPanel = False
          AlignVerticalCenterWithPanel = False
          Below = spbtnMoveUp
        end
        item
          Control = sbtnNew
          AlignBottomWithPanel = False
          AlignHorizontalCenterWithPanel = True
          AlignLeftWithPanel = False
          AlignRightWithPanel = False
          AlignTopWithPanel = False
          AlignVerticalCenterWithPanel = False
          Below = sbtnMoveDown
        end
        item
          Control = spbtnMoveUp
          AlignBottomWithPanel = False
          AlignHorizontalCenterWithPanel = True
          AlignLeftWithPanel = False
          AlignRightWithPanel = False
          AlignTopWithPanel = True
          AlignVerticalCenterWithPanel = False
        end>
      Align = alRight
      BevelEdges = []
      BevelKind = bkFlat
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        65
        298)
      object sbtnDelete: TSpeedButton
        AlignWithMargins = True
        Left = 8
        Top = 172
        Width = 48
        Height = 48
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = []
        ImageIndex = 3
        ImageName = 'DeleteForever'
        Images = VirtualImageList1
        Flat = True
        Layout = blGlyphTop
        Margin = 0
        NumGlyphs = 2
        OnClick = sbtnDeleteClick
      end
      object sbtnMoveDown: TSpeedButton
        AlignWithMargins = True
        Left = 8
        Top = 60
        Width = 48
        Height = 48
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = []
        ImageIndex = 0
        ImageName = 'Down'
        Images = VirtualImageList1
        Flat = True
        Layout = blGlyphTop
        Margin = 0
        NumGlyphs = 2
        OnClick = sbtnMoveDownClick
      end
      object sbtnNew: TSpeedButton
        AlignWithMargins = True
        Left = 8
        Top = 116
        Width = 48
        Height = 48
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = []
        ImageIndex = 2
        ImageName = 'New'
        Images = VirtualImageList1
        Flat = True
        Layout = blGlyphTop
        Margin = 0
        NumGlyphs = 2
        OnClick = sbtnNewClick
      end
      object spbtnMoveUp: TSpeedButton
        AlignWithMargins = True
        Left = 8
        Top = 4
        Width = 48
        Height = 48
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = []
        ImageIndex = 1
        ImageName = 'Up'
        Images = VirtualImageList1
        Flat = True
        Layout = blGlyphTop
        Margin = 0
        NumGlyphs = 2
        OnClick = spbtnMoveUpClick
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 363
    Width = 317
    Height = 56
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
    object btnPost: TButton
      Left = 123
      Top = 10
      Width = 75
      Height = 34
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnPostClick
    end
  end
  object qrySplit: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    OnNewRecord = qrySplitNewRecord
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'indxOrderByLap'
        Fields = 'LapNum'
      end>
    IndexName = 'indxOrderByLap'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.Split'
    UpdateOptions.KeyFields = 'SplitID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ';'
      ''
      'DECLARE @EntrantID AS INTEGER;'
      'SET @EntrantID = :ENTRANTID'
      ''
      'SELECT  '
      'SplitID, '
      'LapNum,'
      'SplitTime, '
      'EntrantID'
      'FROM '
      'Split'
      'WHERE EntrantID = @EntrantID'
      'ORDER BY LapNum Desc'
      ';'
      '')
    Left = 32
    Top = 264
    ParamData = <
      item
        Name = 'ENTRANTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 612
      end>
    object qrySplitLapNum: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Lap'
      DisplayWidth = 6
      FieldName = 'LapNum'
      Origin = 'LapNum'
    end
    object qrySplitSplitTime: TTimeField
      Alignment = taRightJustify
      DisplayLabel = 'Split-Time'
      DisplayWidth = 10
      FieldName = 'SplitTime'
      Origin = 'SplitTime'
      OnGetText = TimeFieldGetText
      OnSetText = TimeFieldSetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
    object qrySplitSplitID: TFDAutoIncField
      FieldName = 'SplitID'
      Origin = 'SplitID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qrySplitEntrantID: TIntegerField
      FieldName = 'EntrantID'
      Origin = 'EntrantID'
    end
  end
  object dsSplit: TDataSource
    DataSet = qrySplit
    Left = 88
    Top = 265
  end
  object qryEntrant: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'EntrantID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.Entrant'
    UpdateOptions.KeyFields = 'EntrantID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ';'
      'DECLARE @EntrantID AS INTEGER;'
      'SET @EntrantID = :ENTRANTID;'
      ''
      'Select '
      'Entrant.EntrantID'
      ',RaceTime'
      ',CONCAT(FirstName, '#39' '#39', UPPER(LastName)) AS FullName'
      ' FROM Entrant'
      ' INNER JOIN Member ON Entrant.MemberID = Member.MemberID'
      ' WHERE EntrantID = @EntrantID'
      ' ;')
    Left = 32
    Top = 209
    ParamData = <
      item
        Name = 'ENTRANTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 612
      end>
    object qryEntrantEntrantID: TFDAutoIncField
      FieldName = 'EntrantID'
      Origin = 'EntrantID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryEntrantRaceTime: TTimeField
      Alignment = taRightJustify
      DisplayWidth = 10
      FieldName = 'RaceTime'
      Origin = 'RaceTime'
      OnGetText = TimeFieldGetText
      OnSetText = qryEntrantRaceTimeSetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
    object qryEntrantFullName: TWideStringField
      FieldName = 'FullName'
      Origin = 'FullName'
      ReadOnly = True
      Required = True
      Size = 257
    end
  end
  object dsEntrant: TDataSource
    DataSet = qryEntrant
    Left = 88
    Top = 208
  end
  object VirtualImageList1: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Down'
        Name = 'Down'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Up'
        Name = 'Up'
      end
      item
        CollectionIndex = 2
        CollectionName = 'New'
        Name = 'New'
      end
      item
        CollectionIndex = 3
        CollectionName = 'DeleteForever'
        Name = 'DeleteForever'
      end>
    ImageCollection = ImageCollection1
    Width = 48
    Height = 48
    Left = 184
    Top = 193
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Down'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000018E494441546843ED97AD4EC44010C7
              7FF73AF03A403008040681C020107C08040681C02010282C8237E0053078341E
              45C8243749D3DC76673B3B214DA6A6496FF6FFB9DDBB5BB1F06BB570FDA481FF
              6E301BC8069C09E4167206E85E9E0DB82374026403CE00DDCBB30177844E80B9
              0D6C013BC0B5935F97EF02AFC04F2BDE1C0322FE05D806CE819B56D2D1BC8817
              BC37E000F86EC16B353014AF3C67C06D0BE96056C5EBA377601FF8B2E2B518D8
              245E794E813B2BE97A6E2C5E977F007BC0A705AFC580E05D021705E013E0DE42
              0A94C42BC7951167D63FB22913C7C043857C4ABC08177CF3D5DA80024F993802
              1E0B0ABA8A178EB9066ADBE910782A9C369BBC3527AF201E03351372243E575E
              58F978B6786F0396ED2447E2EFFA9CEF9A7CAF062C264A2FA42BF9DE066ADB69
              6CA28BF85E5B68286EEA74D2B96EE2230CD49AE82A3ECA40C94477F19106C626
              42C4471B5013C3BBF9278275D0FB4566E5099B4B0361D11A81B30163506163D9
              4058B446E06CC01854D858361016AD11381B30061536960D84456B045E7C037F
              8C743731F58E463E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Up'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000159494441546843ED96A14EC4501045
              CFFE230B09981518040283C02C090281412030080C0234683C5FC127EC0F10D2
              A44DC866FB76A63337A4C954CFBB73CFBDAF4D17CCFC59CCDC3F05F0DF0D5603
              D5403081BA42C100C3C7AB81708441816A201860F87835108E3028A06E60D9FB
              7B0BFA1C3DAE04E8CCBFF69B0F0109840AE0AFF9213D09840260977919443640
              CBBC042213C0623E1D220BC0633E152203A065FE06F801D623DFC1F08B1D0568
              99BF05AE7AE3D72A880840CBFC1D70B995BA04622A40CBFC3D70317265D221A6
              00B4CC3F00E77B7E1B5221BC002DF38FC099F19F270DC203D032FF049C1ACD0F
              6329101E806EF12E886760E5343F06B1018E810FAB9E17601BE20538B12EDBF3
              627FF7417C7AF4A6000C1007C091675963B6BB4EEFC097576F2A80778F6CBE00
              64D11A85AB016350B2B16A4016AD51B81A3006251BAB0664D11A85AB016350B2
              B16A4016AD5178F60DFC02594B3631AFDA775A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'New'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001FC494441546843ED986151C4301085
              DF29001480034001380007E0001C000E90000A1814000E90C0290014C07C37C9
              CD12D2F47A6D4A7A2433FDD1C936D9F7DE66779B99263E6613F75F15C05F2B58
              15A80AF46460E342E84AD2A5A4ED9EC4E4FAFC43D2ADA41BBF8155E05A1200A6
              300080BF3FEAC07BC1CC87A4A2C44E08E0CB58957A367EF9681DAD0046383C55
              8111484E6EF1BF14D893B42BE953D26B8497D8FC51823FBB0E8572DFD9BE24BE
              3990B425692EE94D5227056C613B8C80F0F33870EC9CB01B847E593BEC9F9C41
              2A653F4B82145FB8D606800280B0635200707C59BE1D8A14807B49770160AAA7
              0FC59802B1F5065180D8250E193694520042B061388D0A80D885BD13C7A00FA5
              490138755900253CBB439F816C21E4B307201E4C28F14EFB3D5416CA0E00DF39
              98674E8D4749170D008A3AC496610A10998402C7B9E03DA6407187D8172A54B0
              1984F7BE00FCDAE792782088DF5A06BF8F54E35E85CC3AE8D3210B133E4D0062
              DD4153254E7412CBA9C101D8505AE710F33D45CAF7432910D4215442994EAD04
              CD1A8FADA076A3D8BC0DB5D0A9D83A8447DB0D0840FDE804601569C7B6A900C6
              663CDCAF2A5015E8C94032844873BEEFEFB94FF6CFA90D8BF4BB5197BB00A2A5
              A51FA1592B71C03C6DCCE2663A54A044875B7D2AF516BAD5F1AAC0CA146536AC
              219499E0D6E5AB02AD146536F806EE4BDA31C8F8688A0000000049454E44AE42
              6082}
          end>
      end
      item
        Name = 'DeleteForever'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001C6494441546843ED59D14DC4300C7D
              B7011B1C6C001B1C9300233001C7066C004C0223C004C0066C00B2544B5694C4
              76DAC677104BFDAADDBCE767C769BBC191DBE6C8F1631088567028F05714D803
              B87392B9074071B3CC524216603B007479EC15005D9A11D1A25908FC682BAC7C
              BF8AF15F10E03A95A55495758622B935AA7D625180F1C852F2C479F8B8D7F000
              713FDC837CF275AF31083464B916321468CDCEF514F86454A4E41FA20081799C
              80DF00D048D4FCBB133805F09164BD464282E7B033009F91BB500E548E84C5AF
              BB029C450D9C76BF79582E39074A20091CF708032D955998023525D28DA9D623
              E104086C4E092DF307514232D3B4955E25A97F9EC8B5CE9A6CDC923DC00B9C03
              7801709259519B13E12554036F29A3500239F054366469395D16DE87C30894C0
              CB338F24F10D8048BC256516424003CF18D3C6CE91E84E801A95CE42B2616BBB
              4D8EC4C5219D852C5BA52491FA7757404E60FAB0C535AFBD16F0913BF50F23A0
              01B6DE1F04161DF3D6B40BBFA1C050A0A16C64C8AA25442FDEDB9900ADE1EF00
              68C2ABE6394EB7FC855101141C6E013C58823D04E879448286CF5A4A7C4DDF95
              CCBF9EBC042C49E9EA3308744D7766B1A1C0506066067E01471680317CB5C33D
              0000000049454E44AE426082}
          end>
      end>
    Left = 184
    Top = 137
  end
end
