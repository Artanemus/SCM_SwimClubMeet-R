object LeaderBoard: TLeaderBoard
  Left = 0
  Top = 0
  Caption = 'LeaderBoard'
  ClientHeight = 970
  ClientWidth = 1468
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 17
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1468
    Height = 936
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1464
    ExplicitHeight = 935
    object TabSheet5: TTabSheet
      Caption = 'Setup'
      ImageIndex = 4
      object lblSessionCaption: TLabel
        Left = 180
        Top = 62
        Width = 114
        Height = 17
        Alignment = taCenter
        Caption = 'Session Description'
      end
      object Label2: TLabel
        Left = 52
        Top = 19
        Width = 119
        Height = 17
        Alignment = taRightJustify
        Caption = 'Swimming session ...'
      end
      object Label1: TLabel
        Left = 51
        Top = 308
        Width = 122
        Height = 17
        Alignment = taRightJustify
        Caption = 'Entrant'#39's age as of ...'
      end
      object Label5: TLabel
        Left = 48
        Top = 454
        Width = 126
        Height = 17
        Alignment = taRightJustify
        Caption = 'Placement given on ...'
      end
      object Label6: TLabel
        Left = 47
        Top = 421
        Width = 127
        Height = 17
        Alignment = taRightJustify
        Caption = 'Score calculated on ...'
      end
      object Label7: TLabel
        Left = 71
        Top = 132
        Width = 102
        Height = 17
        Alignment = taRightJustify
        Caption = 'Range to score ...'
      end
      object Label8: TLabel
        Left = 274
        Top = 162
        Width = 115
        Height = 17
        Alignment = taRightJustify
        Caption = 'Custom date from...'
      end
      object Label10: TLabel
        Left = 270
        Top = 225
        Width = 99
        Height = 17
        Alignment = taRightJustify
        Caption = 'Custom date to...'
      end
      object Label11: TLabel
        Left = 227
        Top = 338
        Width = 166
        Height = 17
        Alignment = taRightJustify
        Caption = 'Custom seed date for age ...'
      end
      object Label12: TLabel
        Left = 53
        Top = 62
        Width = 121
        Height = 17
        Alignment = taRightJustify
        Caption = 'Session Description :'
      end
      object Label13: TLabel
        Left = 15
        Top = 87
        Width = 159
        Height = 17
        Alignment = taRightJustify
        Caption = 'Start of Swimming Season :'
      end
      object DBtxtStartOfSwimmingSeason: TDBText
        Left = 180
        Top = 87
        Width = 172
        Height = 17
        AutoSize = True
        DataField = 'StartOfSwimSeasonStr'
        DataSource = dsLBHeader
      end
      object cbxSession: TComboBox
        Left = 180
        Top = 19
        Width = 255
        Height = 25
        Style = csDropDownList
        DropDownCount = 12
        TabOrder = 0
        OnChange = cbxSessionChange
      end
      object cbxCalcEntrantAge: TComboBox
        Left = 179
        Top = 305
        Width = 254
        Height = 25
        Style = csDropDownList
        TabOrder = 1
        Items.Strings = (
          'Start of swimming season'
          'Current session'
          'Custom seed date')
      end
      object cbxCalcByEvent: TComboBox
        Left = 180
        Top = 451
        Width = 255
        Height = 25
        Style = csDropDownList
        TabOrder = 2
        Items.Strings = (
          'HEAT'
          'EVENT')
      end
      object cbxCalcRange: TComboBox
        Left = 179
        Top = 129
        Width = 255
        Height = 25
        Style = csDropDownList
        TabOrder = 3
        Items.Strings = (
          'Start of season to selected'
          'Selected session only'
          'Custom date range')
      end
      object cbxCalcRelative: TComboBox
        Left = 180
        Top = 418
        Width = 253
        Height = 25
        Style = csDropDownList
        TabOrder = 4
        Items.Strings = (
          'ABSOLUTE'
          'RELATIVE TO DIVISION')
      end
      object calDateFrom: TCalendarPicker
        Left = 256
        Top = 187
        Height = 32
        CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
        CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
        CalendarHeaderInfo.DaysOfWeekFont.Height = -13
        CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
        CalendarHeaderInfo.DaysOfWeekFont.Style = []
        CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
        CalendarHeaderInfo.Font.Color = clWindowText
        CalendarHeaderInfo.Font.Height = -20
        CalendarHeaderInfo.Font.Name = 'Segoe UI'
        CalendarHeaderInfo.Font.Style = []
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        TextHint = 'select a date'
      end
      object calDateTo: TCalendarPicker
        Left = 256
        Top = 250
        Height = 32
        CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
        CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
        CalendarHeaderInfo.DaysOfWeekFont.Height = -13
        CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
        CalendarHeaderInfo.DaysOfWeekFont.Style = []
        CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
        CalendarHeaderInfo.Font.Color = clWindowText
        CalendarHeaderInfo.Font.Height = -20
        CalendarHeaderInfo.Font.Name = 'Segoe UI'
        CalendarHeaderInfo.Font.Style = []
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        TextHint = 'select a date'
      end
      object calAgeSeedDate: TCalendarPicker
        Left = 257
        Top = 363
        Height = 32
        CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
        CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
        CalendarHeaderInfo.DaysOfWeekFont.Height = -13
        CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
        CalendarHeaderInfo.DaysOfWeekFont.Style = []
        CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
        CalendarHeaderInfo.Font.Color = clWindowText
        CalendarHeaderInfo.Font.Height = -20
        CalendarHeaderInfo.Font.Name = 'Segoe UI'
        CalendarHeaderInfo.Font.Style = []
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        TextHint = 'select a date'
      end
      object btnPrintSetup: TButton
        Left = 179
        Top = 544
        Width = 255
        Height = 25
        Caption = 'Printer Setup'
        TabOrder = 8
        OnClick = btnPrintSetupClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Leader Board'
      object RelativePanel1: TRelativePanel
        Left = 0
        Top = 0
        Width = 1460
        Height = 57
        ControlCollection = <
          item
            Control = DBtxtSwimClubCaption
            AlignBottomWithPanel = False
            AlignHorizontalCenterWithPanel = True
            AlignLeftWithPanel = False
            AlignRightWithPanel = False
            AlignTopWithPanel = False
            AlignVerticalCenterWithPanel = False
          end
          item
            Control = DBtxtSwimClubNickName
            AlignBottomWithPanel = False
            AlignHorizontalCenterWithPanel = True
            AlignLeftWithPanel = False
            AlignRightWithPanel = False
            AlignTopWithPanel = False
            AlignVerticalCenterWithPanel = False
          end
          item
            Control = spbEventScores
            AlignBottomWithPanel = False
            AlignHorizontalCenterWithPanel = False
            AlignLeftWithPanel = False
            AlignRightWithPanel = False
            AlignTopWithPanel = False
            AlignVerticalCenterWithPanel = True
            RightOf = spbMemberScores
          end
          item
            Control = spbExportPDF
            AlignBottomWithPanel = False
            AlignHorizontalCenterWithPanel = False
            AlignLeftWithPanel = False
            AlignRightWithPanel = False
            AlignTopWithPanel = False
            AlignVerticalCenterWithPanel = True
            LeftOf = spbPrintReport
          end
          item
            Control = spbHouseScores
            AlignBottomWithPanel = False
            AlignHorizontalCenterWithPanel = False
            AlignLeftWithPanel = False
            AlignRightWithPanel = False
            AlignTopWithPanel = False
            AlignVerticalCenterWithPanel = True
            RightOf = spbEventScores
          end
          item
            Control = spbMemberScores
            AlignBottomWithPanel = False
            AlignHorizontalCenterWithPanel = False
            AlignLeftWithPanel = True
            AlignRightWithPanel = False
            AlignTopWithPanel = False
            AlignVerticalCenterWithPanel = True
          end
          item
            Control = spbPrintReport
            AlignBottomWithPanel = False
            AlignHorizontalCenterWithPanel = False
            AlignLeftWithPanel = False
            AlignRightWithPanel = False
            AlignTopWithPanel = False
            AlignVerticalCenterWithPanel = True
            LeftOf = sbtnRefresh
          end
          item
            Control = sbtnRefresh
            AlignBottomWithPanel = False
            AlignHorizontalCenterWithPanel = False
            AlignLeftWithPanel = False
            AlignRightWithPanel = True
            AlignTopWithPanel = False
            AlignVerticalCenterWithPanel = True
          end>
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          1460
          57)
        object DBtxtSwimClubCaption: TDBText
          Left = 640
          Top = 5
          Width = 180
          Height = 21
          Alignment = taCenter
          Anchors = []
          AutoSize = True
          DataField = 'Caption'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DBtxtSwimClubNickName: TDBText
          Left = 657
          Top = 28
          Width = 146
          Height = 17
          Alignment = taCenter
          Anchors = []
          AutoSize = True
          DataField = 'NickName'
        end
        object spbEventScores: TSpeedButton
          Tag = 2
          Left = 48
          Top = 4
          Width = 48
          Height = 48
          AllowAllUp = True
          Anchors = []
          GroupIndex = 2
          ImageIndex = 3
          ImageName = 'outline_pool_black_48dp'
          Images = VirtualImageList2
          Flat = True
          OnClick = spbGenericSPBtnClick
        end
        object spbExportPDF: TSpeedButton
          Left = 1316
          Top = 4
          Width = 48
          Height = 48
          Action = actnExportPDF
          Anchors = []
          ImageIndex = 2
          ImageName = 'outline_picture_as_pdf_black_48dp'
          Images = VirtualImageList1
          Flat = True
        end
        object spbHouseScores: TSpeedButton
          Tag = 3
          Left = 96
          Top = 4
          Width = 48
          Height = 48
          AllowAllUp = True
          Anchors = []
          GroupIndex = 2
          ImageIndex = 2
          ImageName = 'outline_home_black_48dp'
          Images = VirtualImageList2
          Flat = True
          OnClick = spbGenericSPBtnClick
        end
        object spbMemberScores: TSpeedButton
          Tag = 1
          Left = 0
          Top = 4
          Width = 48
          Height = 48
          AllowAllUp = True
          Anchors = []
          GroupIndex = 2
          ImageIndex = 1
          ImageName = 'outline_people_alt_black_48dp'
          Images = VirtualImageList2
          Flat = True
          OnClick = spbGenericSPBtnClick
        end
        object spbPrintReport: TSpeedButton
          Left = 1364
          Top = 4
          Width = 48
          Height = 48
          Action = actnPrint
          Anchors = []
          ImageIndex = 1
          ImageName = 'outline_print_black_48dp'
          Images = VirtualImageList1
          Flat = True
        end
        object sbtnRefresh: TSpeedButton
          Left = 1412
          Top = 4
          Width = 48
          Height = 48
          AllowAllUp = True
          Anchors = []
          ImageIndex = 3
          ImageName = 'outline_refresh_black_48dp'
          Images = VirtualImageList1
          Flat = True
        end
      end
      object frxPreview1: TfrxPreview
        Left = 0
        Top = 57
        Width = 1460
        Height = 847
        Align = alClient
        BevelEdges = []
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        OutlineVisible = False
        OutlineWidth = 120
        ThumbnailVisible = False
        FindFmVisible = False
        UseReportHints = True
        HideScrolls = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Reports'
      object Label4: TLabel
        Left = 183
        Top = 12
        Width = 692
        Height = 34
        Caption = 
          'Displays place and points for both ABSOLUTE position and RELATIV' +
          'E to division - grouped by division, then by entrant.'#13#10'A detaile' +
          'd report, including aggregates. Only available for the current s' +
          'ession.'
      end
      object Label9: TLabel
        Left = 183
        Top = 68
        Width = 507
        Height = 34
        Caption = 
          'Displays the details of each event. The divisions held within th' +
          'at event and it'#39's entrants. '#13#10'Only available for the current ses' +
          'sion.'
      end
      object btnABSREL_A: TButton
        Left = 19
        Top = 18
        Width = 158
        Height = 25
        Caption = 'ABS+REL by division'
        TabOrder = 0
        OnClick = btnABSREL_AClick
      end
      object btnABSREL_B: TButton
        Left = 19
        Top = 74
        Width = 158
        Height = 25
        Caption = 'ABS + REL by event'
        TabOrder = 1
        OnClick = btnABSREL_BClick
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 936
    Width = 1468
    Height = 34
    Panels = <
      item
        Bevel = pbNone
        Text = 'Status and error messages are displayed here.'
        Width = 400
      end>
    ExplicitTop = 935
    ExplicitWidth = 1464
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'outline_watch_later_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600806000000E29877
              38000003F4494441547801ECDB01445D5118C0F14D6F3516DEF6562F900CC013
              1216235129660124780C44C1A809987A60220A6518A4064A33480006A4B24C25
              AC3B90D4221ACBF2DEB73F3660EE776FF79DDEB9EFDC3F3F00D2C7B99D734E77
              2C2B2929292929292929292929298D5E8C6216EBD8838763C85FC7F0B08775CC
              6214BD4823604975E8C334B650824454C216A6D1873AE839560716700E31EC1C
              0BE880D3A590C73EA442F691470ACE740FC3F02096F0308C7BA8EABA7000B1D4
              01BA507565B104898925645115F5E004123327E8416CAB41014548046758C514
              06D1861634E15F4D68411B063185559C412228A2801AC4AA7A6C406E681BE368
              45D45A318E6DC80D6DA01EB1A8019B90902E31831C4C95C30C2E21216DA20156
              D78C43480817282083DB2A83022E20211CA21956F6F806BFFC4534A2523562F1
              0643780CABAA0FB9EC78E8842D75C20BB91CD5C38A6A427E70D790866DA5B116
              F2C35C838A5708712A3901DB9B08710A5BB06193558428AE91475CCAE31AA228
              5672B396C549C05FFE00E2D640C0219C54EAD86239E0B293475CCB075C8E962B
              71AA5982282610F726208AD26D9EA2D606BC44598389E4BFCCB616F072A716C6
              1B86283CA4AB6800697810C5308C960AF08394D0098AD700943A032CBB1E5230
              561EA25804C573004A8B10451E86D2D7FE0B64AB7800595CA8DF024375401453
              A0780F40690AA2E840D99B0F709E9F7160009900F709F3065EACA98FA66640D5
              3100A599008FBFEA50B6FA218A9C4303C84114FD285BD3101F3B20470640B403
              F1318D32A55F688F39388031FD6141797A14E0C8B9D5C101B40638AA7E84C875
              437C9CE2AE8303B88B53888F6E446E04E26305E4D8008856203E4610B939888F
              4987073009F1318788E917EE430E0F6048BFB88FDE2EC447BBC3036887F8D845
              E48E203E5A1C1E400BC4C71122A7BD30CE383C808CFEB23B7A57101FB50E0FA0
              16E2E3CAA501DCB771002E2D41DFF0DCB625A82A3FC28A4F7812FF8FB0CD7F86
              EA7EE10DEEDBF76768FC37622FF01DA25096256B3762161C45E83DC05BFC8654
              6E59D28F22E27D18A797C367F3CB92F9C338BB8FA3F55EE287F965C9FC71B4BD
              17327A19BC47C9FCB264FE42C6DE2B49BD67F86A7E59D2AF24EDBF9437570AAF
              F1D3E0B2A45FCADBFF2CC578CDF80809E883816729763ECCB274EFF0CAC0C32C
              3B9F265AB877F8829481A789763ECEB56CEF50C453038F73ED7E9E6ED1DEE19D
              FDCFD32DF8070D0365308B8771F9078D3FEDDD310100000CC230FFAEE7623D48
              7C50FA8952A79F286523BD4030D20B66AA817EA6DA0FB50DB5A50A8254815847
              10EB90AB09723501C1A69864594FB4AF275BD9136EED491787C4BB03F2F50107
              0E01172601273E0137563B1CB9B932C499E73377B6000000079195108DDCF254
              E20000000049454E44AE426082}
          end>
      end
      item
        Name = 'outline_print_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000600000006008040000004891BF
              B3000001424944415478DAEDDA3D0E823000C5F1770717E3C79D583903265E88
              991318CF62E2686473D11553070D09AD864AA014FD3F3693D2F7436808201142
              08218410FF9881370000000000302D406CFB030000000000000000E82F6B65DA
              E9A8DBE03771F676D3513B655A772FBF54AE2A78717BAB946BD9A57E32C251FF
              FC6F24DFD6DFEA1E4D7D23A3BBB6DF1DFDB8EA3F0989FFB97F8DAEBE91D1D5F7
              5AC8A3AC6F6494FB2D9C55B480CA6751DD38C34E4A350FFE0C76AE5427A7CBA6
              7DE0DEA93F1BED41F2CC21ECDB071DAC2169B0BA2B152A55AAD0AAFE2DB5DA1C
              DA7763AF408B60F52FF59C979AB07056A2F8EE0E5F291AB316DDFB8C05383766
              3D03E014EAE7229E10E0FD323A29404F7D7E1E10FA05070000000000181730F4
              8BE9DEE7030000000000837E4FC45B4A0000000000C097BB00000000F0BF0042
              08218490DFC9035B33EF09195405090000000049454E44AE426082}
          end>
      end
      item
        Name = 'outline_picture_as_pdf_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600803000000D54687
              0A00000033504C54450000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000000000000000A30546C9
              0000001174524E53002A8ED5F2FF0592FCBA91D4E6A51BECE5437123D6000000
              EA494441547801EDD90592C3401043D136C84CF7BFECA20A03862E2DEA05A7E8
              87A127CCECB9A2AC6A9C54576511C7346D874BBAB689039A1E97F5470A031286
              D8557448E88AD85322A58C3D2352C6D85323A58E3DA03809F41B030E380072C0
              81FB1C004DF312CFD69900ADCBB3752A40F3B3752A40DBB3752A70E4D2016D80
              B6FB01C1CB5414581769801F0D9A40D0F127D90175803675601607D64510B8FF
              BEF0CF16077E55C00107640329906CA406920D0541B2B12648369805C946CB20
              D9701C241BEF8342E0B7041C70A0464EEC19D581521D283A598006A4E8B61649
              B7394A89EDDD6CC0CC5E01DC3E3F10D258D0C40000000049454E44AE426082}
          end>
      end
      item
        Name = 'outline_home_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000600000006008040000004891BF
              B3000001CD4944415478DAED98AD6E024114852F21152455884A4C2DAEBAB22F
              B0B26F80ED23A0FB06B5BC402DBE0E5D83ADC091601A9292ED1D12C8027377EF
              ECCFCCDDE47CC7B033B3EC3D982F2C110000000000E88601BD73067D1DFF8E16
              947316FCA987DCD3F238BECB92AF7AC603ADCEE3BBAC78A5473CD2FA627C9735
              AFF68427DADC8CEFB2E19D1EF0423BEFF82E3BDE35CE2BEDC5F15DF67CC2306F
              74281DDFE5C0A7CC4A2B57C6A0DC4ED2BACE2FC7B76E4C6E456915B3A567CED6
              BB67486ED7D23AE587A6C7FD297FF2ED1B919B4F5A2EDF34399F99F095EF8C01
              B949D2FAA2F1C5B931AF18949B24AD4F1ADD9C1DF1AA31B949D2FAA0A1F7FC90
              770CC94D92D6BCF4AEB90DB949D2FAA359E5BD333E95586EB2B432D5FD595AB9
              95494B4B42B955494B4B22B969A4A52581DCB4D2D212596E21D2D212516EA1D2
              D212496EF5A4A5A563B9359196960EE526492B574A4B4B263CA5A1DC2469B9B4
              8DF49C067293A415B7406DB949D28A5FA096DC2469A529102CB7B2D783690A04
              C9ADEAF5609A026AB9695E0FA629D0506E5505F2C0847E7FEBBF100AA0000AA0
              000A745AA0ED7D14400114400114400114400114400114B053A0E91F96D82FCE
              5000055000055000000000000000008AFC031C87CEBAB696E6E6000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'outline_leaderboard_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600103000000D856E5
              7B00000006504C5445000000000000A567B9CF0000000174524E530040E6D866
              000000294944415478016318ECE03F10D0850344C38003F7197D3810040434E6
              C010699C510E0CD09433980100DCDB46C8E41F69D30000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'outline_menu_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600103000000D856E5
              7B00000006504C5445000000000000A567B9CF0000000174524E530040E6D866
              0000001C4944415478016320138C02FEFF50F081961CF2C168188C86C1280000
              3628D729A23945180000000049454E44AE426082}
          end>
      end
      item
        Name = 'outline_people_alt_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000600000006008040000004891BF
              B3000003804944415478DAED994D48545114C77F35918649B548B45CD4AAFCC8
              8D0519F441A043137D815B3741458B42A1A5104C34A9D042618602177D40B468
              1B6D1A06029568619895A0B6505B8AA69529E9B49846F4DEFBDE9BA7EF19F33A
              FFB39CFFBDE7FC9FE7DC7BEE1104028140201008040281602DD84A0371520C33
              CB2CC3A488D3C0564B7E01A7B9CB6B4672E4FB8A52E2CC9036D80C714A8D6B76
              32EE8AEF1B0A88F2DD187CD6BE13A5C0B032CC922BBE4FDFBECF36F8ACF519BF
              EB03977CCF51634C03B38D53A3AD2F66D215DFF3AF9F7BF89990F4AF7AC725DF
              D3DCEF73157E2631D4DC2EE1A72BBE8788BA0E3F4D9AA88B3A30F33D4299F1E4
              F9480B956C673B95B4F0D178C294293B9D7238C1CAFC1190D05C2D7083D02A4E
              881B2C68BC84968A3F6C2524FCB975A71537F3D41B99F5CC2BCC69EDB67D652B
              60DA8FDB39ACB9B969C9BDA971C30AE39643DD84BD1710D7723F64C90D69B510
              5718E71D04C4BD1790525C34DBB29B15764AF9FDA8838094F70286141755B6EC
              2A853DA4FCBEDF41C090F702D4CEB3D8965DAC759CAB51E420604604042F85F2
              BE88F3FE18CDFB8B2CEF5B89BC6FE602D04EE7FD8326004FCABC7FD40760AC12
              80C15600468B0118EE0662BC2E10FCCF08514D23AD74936490B1E5F3648C4192
              74D34A23D5360F1E15859CA1622302DF4184186F98CBE9229BE30D3122ECC861
              E74A3EF083777471895D7E845E4D94FE35F5A269D2BC27C631070F45BC5CE6F7
              738F235E857E90DB7C5A73E82BED2B1D1CB24DCC47ABF85F88ADAF37DA4223BD
              9E84BED27A69648BA5841786F9C43936B90F7E334D8C7A1E7CD6466962B38B17
              C7672EBB3812803A067C0B3E6B03D4197DEFD7860759FE895CFB9B4E167D0F3F
              4D9A453A8D7DD0350BFE125D143AF7983D39399F2449826622D4B28F7200CAD9
              472D119A4990B479B6ACB41E431F1A328E0632F6963DF6E18F38389CE0095773
              BC742AB8C263261C761C314868B2E5975B9FC403B60BDB1DCF72AB8A6A63D8B6
              1A8A9415DB2CEA2063831AFF2F3A2D16CCF39C93EBBE4F8EF38C5F161E3A35F6
              53DBBFDA43938303C6D29DA38312CFEEF3DDB41967728B1C5098D76D05FCA652
              DFBCDD407C649D6FEB98EF751B3CB52BACC30E95735FDF58ED7466B9E85B5378
              966F8AB77E85B1D741C0077DD3298572C1D7BE36A2789BD2CAD8F5BFA0548ADF
              70F2E77483880011E0B7808D361120024480081001FF56804020100804028140
              20F8DFF0073E8ED3890E222A580000000049454E44AE426082}
          end>
      end
      item
        Name = 'outline_pool_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000600000006008040000004891BF
              B30000042C4944415478DAED9B5D6C544514C77F6D691128FDD4826F46591B21
              114CA351420C044313C383550B62CA47FC201AB12D20494302554BD2B02FF054
              02824D21C5071313CA935852518210055225B1AE0B1B2AB5B6B594D0A4DDB684
              E1A125C0EEDE3B337769E7AECE7F5EF79C39BFDD9DF3716717ACACACACACACAC
              ACACE412084689F0076D1CA58E37284ED26326E51C21C420838438423999930D
              10BB3AD94F29699EFC95118EF317A66C6A01C657882A6668F94A27E8E82D48FA
              5403080411DED4F01574F515340120101CA740F1CB23F354660640709597148E
              6E58EA273C19C75928AD61E9BB57AEE4A7DC1480E016EFBAFA6956F2D26C0E40
              709B4D2E7E3A947C7498047047B8A9E4E1E6E464A25C022CE5431AF8DD338251
              80FB358F3AFA5C113EF6D757289166B093214D046387D8494FF28B4B2095FE49
              A3CE9A4EA30682B142E6AEDD1A08865A09996A35108C34730F13C1483B9D2C42
              95E981E6E1234CF148993C80A0DAEF837FAD34BF54A776F8BE46A855EE5537A7
              76F8BE44D00B5F20D892DAE1FB0AC15BF8BE41F01EBE40B035B5C3378E907CF8
              02C127A91DBE3104F7F0AFF315EFB1887C208B277881F51CA6C74F088B69717C
              D8BE914712DA64B1964B0E56A5263E852571E3FC0055929638830FE21EC6B4B3
              CCD43948670DDFD28D60908B7CCA634A5679D4708E1B08FEE1046BC9C0CACACA
              EA3FAB4C96534F2B97E94730428863544AEFE88BA8A091B3448822E8E7020758
              4D9EC4EA59B6719C4B5C9BB8443FC967BC9C4C92CDA6862E87CA798A950E560B
              686224A1CD10FB782AA14D1AABF8D961A72B54335D3FF83436D02D69C2DA5818
              6355400363AE362304C989B17A9173D26BF4553AA10758C779C51BC9A3943217
              98CD737CCEBF4A563DD4B2886CE0715EE56B6E2B599DA582792ABFCB10BE5E7D
              16C002180018A09EE7C9018A788526499EB9D7E5BFC3D364904E80F5CA49A199
              15CC017228A12E4152D006B8C517715DFE7C4E4802E96563DC3D4B057F49AC4E
              53126393CF5E46BD0344696481C3AB4A697508A39B1DE426B499C9563A1DACCE
              F0BAC34EC51C6458076098083F7188B77954F2CA001FF10D1D44115CE70A27D9
              CD0AB25C6DA6B18C5D7C3FF16974F21B2D6C61BE64A702DEE22017E85501B0B2
              B2B2F293C6D3DE7784E94330CA9F4A692F9FD51CE00C118610DCA09D462A2892
              581553C931DAB98A40D0C50FD4B33C99CBEF596CF3507802ECBFAFF03C38CC34
              3916C6959C72D8A98B1AB2BD4D647F6B97FE3CF6C494FED835C63E0AE366E136
              C94EDD6C50FF89B9DE4476B7F99AC54276D2AB6435DE1CE64E348787159BC3F3
              AC2390FA1399B00016C000403F7594305BF3D04DCE44A60D304643DCDF1AE469
              AF87F73D4C643F2A4C645A0051BEE4190F85677BDCB337F944769AD75C26B2A8
              0EC0BD89AC50A9F4871841D0CF655A154A7FEC44F62B2D6C767C9BEEAA90351C
              E222032A005656565656565656FF1FDD01574E4866331FE1590000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'outline_refresh_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600806000000E29877
              3800000316494441547801EDDC03AC644B1446E167DBB6836705CFB615DD3879
              D6D86638B61D8C6DDBB66D7BCF1AC5395D7DEF4175CDBF922FE6AE7657D5454A
              29A594524A29A594524A29A594521E741BBE452574C374ACC246180C1BB10AD3
              D11515F10D6E4592554190BD8886980B2BA1D9A887E71218BE2198AEC77F5800
              4BC81CFC856BE2193E02E82654C10E584AB6A21CAE2FE1F051D815612B2C231B
              F17309868FC2EC618C83796238EECF7FF828C0BEC56E9867B6E3933C878FC2E9
              62D48779EC24AABA0F1F05D265E8082BA62DE88EBFF0091EC35D38DFDD781C9F
              E21FF4C24E5831B5C0A50EC347610CBF2F2C4F3BD018AFA2385D8C37D116FB61
              799A0F73E07517A3032C0F9BF02FAE455CDD82EA89BCF7785E1D98A3A36880EB
              905477A0E385B2005FE124CCC132BC80B4FA04DB435E8007B113E6A00F6E40DA
              DD8FE9A12EC048988356B81459753D4684B600BF380FDF8F6A84B400D763A3E3
              CBCEA5C8BA2AA1BD0495757CC3BD2190E1C39FAEC116878F9A2F04347CF8D36F
              B01C1A06367CF8D37487DFDEAF0B6CF8F0A3676039FC1BE0F0E147351D7E58BB
              36C0E1C38F26C322340E73F8F0A01B700C16E1D530870F0FFAD8E1CF948BC31C
              3E3CE87F5884EEE10E1F1ED40A16E1EF70870F0F1A038BF0115452396C257C0C
              2AC1D6C022DC0A95603B6111AE40706901945E82F426ACF431545FC494C34F11
              21A71FE394FBCFD1CAFF3F643CAA2D2CC27890FE924CA23B711816A134487FCA
              275155580E4F82B42D25EE6EC65658840920D2C6ACD86B0DCBA108CE696BA27B
              6F3B1C2AD980ABE09436E7BA773396C172F80B4E697BBA7B57620C2C8735B81A
              31A6031A17A31BCCC1B788311D51BA1CED600E0621C67448EF568C8639D886BB
              11533AA6FA2A96C11C9CC41788211DD4BE192D7002E6A82262485715FC8BADB0
              3CB44709D2651DAFA10D0EC2F2D40D972247BAAEE64A3C8497F01ECA6000F6C0
              8AA95316C3D7854D40356490AE2CDB85EF9041BAB46F0C1E44CAE9DACAAD2842
              CAE9E2D69DA88C1B9162BABA7821FE4E77F0BABC7B31EAE0758D35B9EBEB7762
              15A6A03B6AE14BDC09A594524A29A594524A29A594524AA94C3B05156E0E9530
              9D467A0000000049454E44AE426082}
          end>
      end>
    Left = 736
    Top = 192
  end
  object VirtualImageList1: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'outline_watch_later_black_48dp'
        Name = 'outline_watch_later_black_48dp'
      end
      item
        CollectionIndex = 1
        CollectionName = 'outline_print_black_48dp'
        Name = 'outline_print_black_48dp'
      end
      item
        CollectionIndex = 2
        CollectionName = 'outline_picture_as_pdf_black_48dp'
        Name = 'outline_picture_as_pdf_black_48dp'
      end
      item
        CollectionIndex = 8
        CollectionName = 'outline_refresh_black_48dp'
        Name = 'outline_refresh_black_48dp'
      end>
    ImageCollection = ImageCollection1
    Width = 48
    Height = 48
    Left = 824
    Top = 192
  end
  object VirtualImageList2: TVirtualImageList
    Images = <
      item
        CollectionIndex = 5
        CollectionName = 'outline_menu_black_48dp'
        Name = 'outline_menu_black_48dp'
      end
      item
        CollectionIndex = 6
        CollectionName = 'outline_people_alt_black_48dp'
        Name = 'outline_people_alt_black_48dp'
      end
      item
        CollectionIndex = 3
        CollectionName = 'outline_home_black_48dp'
        Name = 'outline_home_black_48dp'
      end
      item
        CollectionIndex = 7
        CollectionName = 'outline_pool_black_48dp'
        Name = 'outline_pool_black_48dp'
      end
      item
        CollectionIndex = 4
        CollectionName = 'outline_leaderboard_black_48dp'
        Name = 'outline_leaderboard_black_48dp'
      end>
    ImageCollection = ImageCollection1
    Width = 48
    Height = 48
    Left = 824
    Top = 256
  end
  object ActionManager1: TActionManager
    Left = 928
    Top = 192
    StyleName = 'Platform Default'
    object actnRefresh: TAction
      Hint = 'Refresh the leaderboard.'
      OnExecute = actnRefreshExecute
      OnUpdate = actnRefreshUpdate
    end
    object actnPrint: TAction
      Hint = 'Print the currently viewed report.'
      OnExecute = actnPrintExecute
      OnUpdate = actnPrintUpdate
    end
    object actnExportPDF: TAction
      Hint = 'Export the current viewed report to a PDF to file.'
      OnExecute = actnExportPDFExecute
      OnUpdate = actnExportPDFUpdate
    end
  end
  object qryLBHeader: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SwimClubID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'SwimClubID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      ''
      'SELECT '
      #9#9' [SwimClubID]'
      #9#9',[NickName]'
      #9#9',[Caption]'
      #9#9',[StartOfSwimSeason]'
      
        '                ,Format(StartOfSwimSeason, '#39'MMMM dd, yyyy'#39', '#39'en-' +
        'AU'#39') AS StartOfSwimSeasonStr'
      ''
      'FROM [SwimClubMeet].[dbo].[SwimClub]'
      'WHERE SwimClubID = @SwimClubID; ')
    Left = 824
    Top = 320
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsLBHeader: TDataSource
    AutoEdit = False
    DataSet = qryLBHeader
    Left = 927
    Top = 320
  end
  object qrySession: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @swimclubid AS INTEGER;'
      'SET @swimclubid = :SWIMCLUBID; -- 1;'
      ''
      'SELECT [SessionID]'
      '     , [Caption]'
      '     , [SessionStart]'
      '     , [ClosedDT]'
      '     , [SwimClubID]'
      '     , [SessionStatusID]'
      'FROM [SwimClubMeet].[dbo].[Session]'
      'WHERE [Session].[SwimClubID] = @swimclubid;')
    Left = 824
    Top = 384
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsSession: TDataSource
    DataSet = qrySession
    Left = 928
    Top = 384
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 928
    Top = 256
  end
end
