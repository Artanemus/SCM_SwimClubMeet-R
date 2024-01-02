object frameTEAM: TframeTEAM
  Left = 0
  Top = 0
  Width = 1033
  Height = 489
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 0
    Top = 297
    Width = 1033
    Height = 14
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 288
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1033
    Height = 297
    Align = alTop
    BevelEdges = []
    BevelKind = bkFlat
    BevelOuter = bvNone
    BevelWidth = 2
    Caption = 'Panel1'
    ParentColor = True
    TabOrder = 0
    object Grid: TDBGrid
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 1029
      Height = 293
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      BorderStyle = bsNone
      DataSource = SCM.dsTeam
      DefaultDrawing = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = GridCellClick
      OnColEnter = GridColEnter
      OnColExit = GridColExit
      OnDrawColumnCell = GridDrawColumnCell
      OnEditButtonClick = GridEditButtonClick
      OnEnter = GridEnter
      Columns = <
        item
          Expanded = False
          FieldName = 'Lane'
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'TeamName'
          Width = 240
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RaceTime'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TimeToBeat'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IsScratched'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IsDisqualified'
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'DCode'
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 311
    Width = 1033
    Height = 178
    Align = alClient
    BevelEdges = []
    BevelKind = bkFlat
    BevelOuter = bvNone
    ParentColor = True
    ShowCaption = False
    TabOrder = 1
    object rpnlTeamEntrantTools: TRelativePanel
      Left = 653
      Top = 0
      Width = 88
      Height = 178
      ControlCollection = <
        item
          Control = spbtnMoveUpSlot
          AlignBottomWithPanel = False
          AlignHorizontalCenterWithPanel = True
          AlignLeftWithPanel = False
          AlignRightWithPanel = False
          AlignTopWithPanel = True
          AlignVerticalCenterWithPanel = False
        end
        item
          Control = spbtnMoveDownSlot
          AlignBottomWithPanel = False
          AlignHorizontalCenterWithPanel = True
          AlignLeftWithPanel = False
          AlignRightWithPanel = False
          AlignTopWithPanel = False
          AlignVerticalCenterWithPanel = False
          Below = spbtnMoveUpSlot
        end
        item
          Control = spbtnTeamEntrantClear
          AlignBottomWithPanel = False
          AlignHorizontalCenterWithPanel = True
          AlignLeftWithPanel = False
          AlignRightWithPanel = False
          AlignTopWithPanel = False
          AlignVerticalCenterWithPanel = False
          Below = spbtnMoveDownSlot
        end
        item
          Control = spbtnTeamEntrantStrike
          AlignBottomWithPanel = False
          AlignHorizontalCenterWithPanel = True
          AlignLeftWithPanel = False
          AlignRightWithPanel = False
          AlignTopWithPanel = False
          AlignVerticalCenterWithPanel = False
          Below = spbtnTeamEntrantClear
        end
        item
          Control = spbtnAddSlot
          AlignBottomWithPanel = False
          AlignHorizontalCenterWithPanel = True
          AlignLeftWithPanel = False
          AlignRightWithPanel = False
          AlignTopWithPanel = False
          AlignVerticalCenterWithPanel = False
          Below = spbtnTeamEntrantStrike
        end
        item
          Control = spbtnRemoveSlot
          AlignBottomWithPanel = False
          AlignHorizontalCenterWithPanel = True
          AlignLeftWithPanel = False
          AlignRightWithPanel = False
          AlignTopWithPanel = False
          AlignVerticalCenterWithPanel = False
          Below = spbtnAddSlot
        end>
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        88
        178)
      object spbtnMoveUpSlot: TSpeedButton
        Left = 20
        Top = 0
        Width = 48
        Height = 48
        Hint = 'Move the swimmer up the race order.'
        Anchors = []
        ImageIndex = 0
        ImageName = 'Up'
        Images = vimglistTEAM
        Layout = blGlyphTop
        Margin = 0
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
      end
      object spbtnMoveDownSlot: TSpeedButton
        Left = 20
        Top = 48
        Width = 48
        Height = 48
        Hint = 'Move the swimmer down the race order.'
        Anchors = []
        ImageIndex = 1
        ImageName = 'Down'
        Images = vimglistTEAM
        Layout = blGlyphTop
        Margin = 0
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
      end
      object spbtnTeamEntrantClear: TSpeedButton
        Left = 20
        Top = 96
        Width = 48
        Height = 48
        Hint = 'Clear the swimmer from the team. The member remains nominated.'
        Anchors = []
        ImageIndex = 2
        ImageName = 'Delete'
        Images = vimglistTEAM
        Layout = blGlyphTop
        Margin = 0
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = spbtnTeamEntrantClearClick
      end
      object spbtnTeamEntrantStrike: TSpeedButton
        Left = 20
        Top = 144
        Width = 48
        Height = 48
        Hint = 
          'Strike the swimmer from the team and remove nomination to the ev' +
          'ent.'
        Anchors = []
        ImageIndex = 3
        ImageName = 'DeleteForever'
        Images = vimglistTEAM
        Layout = blGlyphTop
        Margin = 0
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = spbtnTeamEntrantStrikeClick
      end
      object spbtnAddSlot: TSpeedButton
        Left = 20
        Top = 192
        Width = 48
        Height = 48
        Hint = 'Add a new swimmer slot for this team.'
        Anchors = []
        ImageIndex = 4
        ImageName = 'add'
        Images = vimglistTEAM
        Layout = blGlyphTop
        Margin = 0
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = spbtnAddSlotClick
      end
      object spbtnRemoveSlot: TSpeedButton
        Left = 20
        Top = 240
        Width = 48
        Height = 48
        Hint = 'Remove the slot (must be empty of swimmer).'
        Anchors = []
        ImageIndex = 5
        ImageName = 'remove'
        Images = vimglistTEAM
        Layout = blGlyphTop
        Margin = 0
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = spbtnRemoveSlotClick
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 653
      Height = 178
      Align = alLeft
      BevelEdges = []
      BevelKind = bkFlat
      BevelOuter = bvNone
      BevelWidth = 2
      TabOrder = 1
      object GridEntrant: TDBGrid
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 649
        Height = 174
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BorderStyle = bsNone
        DataSource = SCM.dsTeamEntrant
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnEditButtonClick = GridEntrantEditButtonClick
        OnEnter = GridEntrantEnter
        Columns = <
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'FullName'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RaceTime'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TimeToBeat'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PersonalBest'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'luStroke'
            Visible = False
          end>
      end
    end
  end
  object imgcollTEAM: TImageCollection
    Images = <
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
        Name = 'Delete'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000164494441546843ED99E14D03310C85
              BF4E40376004D8A06513468009A01B74846ED2B2016C001BB413802CE5A4A84D
              9338BD501D3C4BF7E32E4EECE7E738C965C6C4653671FF11806B332806FE0A03
              AFC08B13CC0AB07E17494D0AD538B604ECF1C80EB0A72406F4ACD400F82E59E8
              DC9EF5F15F0018F2344EA52CAD173092B2919D27350C0CFEC4A9E4E9E7C1E3B6
              E171C43DB8C7F3A0EBB621005194EF819BF0FE01EC8F18980377E1DB01784F30
              745506ACA62F82530F891A6FEBC436B4BF9D5937042037EF4AD1110340294827
              011EB30A8901315058394BF9A914520A2985B495D042969D052AA3DA4E271244
              9BB9282893DF4AAC013B179B3C25CEBCD6663A26761E369D6329158AAEE78186
              BF2802E0BA6272D3DB4089DBC69855A8C1DFDF4DA14FE0760C2F2BC6B01F6343
              41C8AA7B1868B985A9F035A9F21C55ACD100D84006E2B123135FC0C673F5E461
              A0359A5DFB0940D7F0560C2E062A82D45565F20CFC0062799D311B6C0DDD0000
              000049454E44AE426082}
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
      end
      item
        Name = 'add'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000000CA494441546843ED975D0E80200C83
              C7CDF4E47A34E38B31CACF281083F97CC415B7B6C3116CF2274C9EBF51C0D70A
              A2000A3432808512042E89F5BD91F0177C94026701DBE36BAB9951C0530214C8
              F40016F2343C16C2421E9F6462B01016C24265065283590919FB919530B1F7D9
              F9C9D3C4B1C14C4944C11407400A5068ADC0A0C049D6F44D5CA1F815CA8DCCCB
              9AE714F2EE758F43012F6B28C034EAF54A220E0B61212CD4C8C09F2D547DBB52
              B81C750A29B948180A9068EB0842818E644A5BA180445B47D0F40A1C54243E31
              177CF0BB0000000049454E44AE426082}
          end>
      end
      item
        Name = 'remove'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000000B6494441546843ED94510D80301403
              8B0DD4A000B3084014060806C8D2369025C77FBBBDBB37164DFE2D93DF5F0CF0
              B7410C602024C00A8500E3380662846101064280711C0331C2B0000321C0388E
              81186158808110601C1F31B0495AE393BC824BD2F1161D1DE0F4CE8F533B0348
              7A560803E632D55668EA476CC2FB2636F217FAE626E6290C6082ABC530504369
              1661C004578B61A086D22CC28009AE16C3400DA5598401135C2D86811A4AB308
              0326B85A6C7A0337F5550C31D26BC6F10000000049454E44AE426082}
          end>
      end>
    Left = 504
    Top = 232
  end
  object vimglistTEAM: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Up'
        Name = 'Up'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Down'
        Name = 'Down'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 3
        CollectionName = 'DeleteForever'
        Name = 'DeleteForever'
      end
      item
        CollectionIndex = 4
        CollectionName = 'add'
        Name = 'add'
      end
      item
        CollectionIndex = 5
        CollectionName = 'remove'
        Name = 'remove'
      end>
    ImageCollection = imgcollTEAM
    Width = 48
    Height = 48
    Left = 632
    Top = 232
  end
end
