object ManageMember: TManageMember
  Left = 0
  Top = 0
  Caption = 'Manage SwimClubMeet Members'
  ClientHeight = 842
  ClientWidth = 1363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 19
  object Panel1: TPanel
    Left = 0
    Top = 31
    Width = 1363
    Height = 49
    Align = alTop
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 1359
    object lblMemberCount: TLabel
      Left = 669
      Top = 12
      Width = 155
      Height = 23
      Caption = 'Members Found : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCount: TLabel
      Left = 830
      Top = 12
      Width = 10
      Height = 23
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object chkbHideInActive: TCheckBox
      Left = 225
      Top = 12
      Width = 206
      Height = 28
      Caption = 'Hide In-Active Members'
      TabOrder = 1
      WordWrap = True
      OnClick = chkbHideInActiveClick
    end
    object chkbHideArchived: TCheckBox
      Left = 20
      Top = 12
      Width = 199
      Height = 28
      Caption = 'Hide Archived Members'
      TabOrder = 0
      WordWrap = True
      OnClick = chkbHideArchivedClick
    end
    object chkbHideNonSwimmers: TCheckBox
      Left = 442
      Top = 12
      Width = 175
      Height = 28
      Caption = 'Hide Non-Swimmers'
      TabOrder = 2
      WordWrap = True
      OnClick = chkbHideNonSwimmersClick
    end
    object btnFindMember: TButton
      Left = 890
      Top = 9
      Width = 123
      Height = 34
      Caption = 'Find...'
      TabOrder = 3
      OnClick = btnFindMemberClick
    end
    object btnGotoMemberID: TButton
      Left = 1027
      Top = 9
      Width = 133
      Height = 34
      Caption = 'Goto MemberID'
      TabOrder = 4
      OnClick = btnGotoMemberIDClick
    end
    object btnGotoMembership: TButton
      Left = 1172
      Top = 9
      Width = 157
      Height = 34
      Caption = 'Goto Membership#'
      TabOrder = 5
      OnClick = btnGotoMembershipClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 776
    Width = 1363
    Height = 66
    Align = alBottom
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 775
    ExplicitWidth = 1359
    object DBNavigator1: TDBNavigator
      Left = 347
      Top = 9
      Width = 648
      Height = 47
      DataSource = ManageMemberData.dsMember
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel, nbRefresh]
      ParentShowHint = False
      ConfirmDelete = False
      ShowHint = True
      TabOrder = 0
      BeforeAction = DBNavigator1BeforeAction
      OnClick = DBNavigator1Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 80
    Width = 1363
    Height = 696
    ActivePage = TabSheet1
    Align = alClient
    MultiLine = True
    TabHeight = 40
    TabOrder = 2
    TabWidth = 160
    ExplicitWidth = 1359
    ExplicitHeight = 695
    object TabSheet1: TTabSheet
      Caption = 'Member'#39's Details'
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 1355
        Height = 646
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitTop = -2
        object Label3: TLabel
          Left = 105
          Top = 139
          Width = 32
          Height = 19
          Alignment = taRightJustify
          Caption = 'DOB'
        end
        object Label4: TLabel
          Left = 87
          Top = 212
          Width = 51
          Height = 19
          Alignment = taRightJustify
          Caption = 'Gender'
        end
        object Label2: TLabel
          Left = 52
          Top = 95
          Width = 86
          Height = 19
          Alignment = taRightJustify
          Caption = 'Last Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 50
          Top = 59
          Width = 88
          Height = 19
          Alignment = taRightJustify
          Caption = 'First Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 100
          Top = 486
          Width = 39
          Height = 19
          Alignment = taRightJustify
          Caption = 'Email'
        end
        object DBSwimmerAge: TDBText
          Left = 313
          Top = 170
          Width = 65
          Height = 17
          DataField = 'SwimmerAge'
          DataSource = ManageMemberData.dsMember
        end
        object Label7: TLabel
          Left = 11
          Top = 418
          Width = 128
          Height = 38
          Alignment = taRightJustify
          Caption = 'Club Membership Number'
          WordWrap = True
        end
        object Label12: TLabel
          Left = 17
          Top = 27
          Width = 121
          Height = 23
          Alignment = taRightJustify
          Caption = 'Member'#39's ID'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dblblMemberID: TDBText
          Left = 144
          Top = 27
          Width = 108
          Height = 30
          DataField = 'MemberID'
          DataSource = ManageMemberData.dsMember
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label21: TLabel
          Left = 95
          Top = 525
          Width = 44
          Height = 19
          Alignment = taRightJustify
          Caption = 'House'
        end
        object Label22: TLabel
          Left = 116
          Top = 170
          Width = 191
          Height = 19
          Alignment = taRightJustify
          Caption = 'Member'#39's age as of today :'
        end
        object Label24: TLabel
          Left = 144
          Top = 246
          Width = 204
          Height = 19
          Caption = '(Checkboxes use Specificity.)'
        end
        object Label18: TLabel
          Left = 27
          Top = 371
          Width = 113
          Height = 38
          Alignment = taRightJustify
          Caption = 'Governing Body Registration'
          WordWrap = True
        end
        object Label8: TLabel
          Left = 221
          Top = 418
          Width = 277
          Height = 19
          Caption = '(Recommended - minimum of 4 digits)'
        end
        object Label23: TLabel
          Left = 997
          Top = 256
          Width = 21
          Height = 118
          Alignment = taCenter
          Caption = 'PERSONAL BEST'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Orientation = 900
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 557
          Top = 256
          Width = 21
          Height = 137
          Alignment = taRightJustify
          Caption = 'CONTACT DETAILS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Orientation = 900
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
        end
        object Label6: TLabel
          Left = 557
          Top = 8
          Width = 21
          Height = 47
          Alignment = taRightJustify
          Caption = 'ROLES'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Orientation = 900
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
        end
        object Label11: TLabel
          Left = 98
          Top = 557
          Width = 41
          Height = 19
          Alignment = taRightJustify
          Caption = 'TAGS'
        end
        object btnInfoRoles: TVirtualImage
          Left = 1265
          Top = 10
          Width = 25
          Height = 26
          ImageCollection = ImageCollectMember
          ImageWidth = 0
          ImageHeight = 0
          ImageIndex = 4
          ImageName = 'Info'
          OnClick = btnInfoRolesClick
          OnMouseLeave = btnInfoMouseLeave
        end
        object btnInfoContact: TVirtualImage
          Left = 911
          Top = 256
          Width = 25
          Height = 26
          ImageCollection = ImageCollectMember
          ImageWidth = 0
          ImageHeight = 0
          ImageIndex = 4
          ImageName = 'Info'
          OnClick = btnInfoContactClick
          OnMouseLeave = btnInfoMouseLeave
        end
        object DBlucboGender: TDBLookupComboBox
          Left = 145
          Top = 208
          Width = 148
          Height = 27
          DataField = 'GenderID'
          DataSource = ManageMemberData.dsMember
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          KeyField = 'GenderID'
          ListField = 'Caption'
          ListSource = ManageMemberData.dsGender
          NullValueKey = 32776
          ParentFont = False
          TabOrder = 3
        end
        object DBedtFirstName: TDBEdit
          Left = 144
          Top = 56
          Width = 292
          Height = 27
          DataField = 'FirstName'
          DataSource = ManageMemberData.dsMember
          TabOrder = 0
        end
        object DBedtLastName: TDBEdit
          Left = 144
          Top = 92
          Width = 292
          Height = 27
          DataField = 'LastName'
          DataSource = ManageMemberData.dsMember
          TabOrder = 1
        end
        object DBedtMembershipNum: TDBEdit
          Left = 145
          Top = 415
          Width = 70
          Height = 27
          DataField = 'MembershipNum'
          DataSource = ManageMemberData.dsMember
          TabOrder = 9
        end
        object DBchkIsActive: TDBCheckBox
          Left = 144
          Top = 300
          Width = 292
          Height = 17
          Caption = 'Is Active - Indicates full membership. '
          DataField = 'IsActive'
          DataSource = ManageMemberData.dsMember
          TabOrder = 6
        end
        object DBEdtEmail: TDBEdit
          Left = 145
          Top = 483
          Width = 407
          Height = 27
          DataField = 'Email'
          DataSource = ManageMemberData.dsMember
          TabOrder = 10
        end
        object DBlucboHouse: TDBLookupComboBox
          Left = 145
          Top = 521
          Width = 233
          Height = 27
          Hint = 'Assign house (Clear .. Ctrl-Del)'
          DataField = 'HouseID'
          DataSource = ManageMemberData.dsMember
          KeyField = 'HouseID'
          ListField = 'Caption'
          ListSource = ManageMemberData.dsHouse
          NullValueKey = 32776
          TabOrder = 11
        end
        object DBchkIsSwimmer: TDBCheckBox
          Left = 144
          Top = 327
          Width = 344
          Height = 17
          Caption = 'Is Swimmer - Participates in events.'
          DataField = 'IsSwimmer'
          DataSource = ManageMemberData.dsMember
          TabOrder = 7
        end
        object DBchkIsArchived: TDBCheckBox
          Left = 144
          Top = 273
          Width = 255
          Height = 17
          Caption = 'Is Archived - Retired from club.'
          DataField = 'IsArchived'
          DataSource = ManageMemberData.dsMember
          TabOrder = 5
        end
        object btnClearHouse: TButton
          Tag = 3
          Left = 384
          Top = 516
          Width = 75
          Height = 32
          Hint = 'Clear the house name.'
          Caption = 'Clear'
          ImageIndex = 0
          Images = ImageList1
          TabOrder = 12
          OnClick = btnClearClick
        end
        object btnClearGender: TButton
          Tag = 1
          Left = 299
          Top = 208
          Width = 75
          Height = 32
          Hint = 'Clear the house name.'
          Caption = 'Clear'
          ImageIndex = 0
          Images = ImageList1
          TabOrder = 4
          OnClick = btnClearClick
        end
        object RegistrationNum: TDBEdit
          Left = 146
          Top = 368
          Width = 184
          Height = 27
          DataField = 'MembershipStr'
          DataSource = ManageMemberData.dsMember
          TabOrder = 8
        end
        object dtpickDOB: TCalendarPicker
          Left = 143
          Top = 132
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
          Date = 38466.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          IsEmpty = False
          OnChange = dtpickDOBChange
          ParentFont = False
          TabOrder = 2
          TextHint = 'select a date'
        end
        object DBgridHistoryPB: TDBGrid
          Left = 1024
          Top = 256
          Width = 301
          Height = 381
          DataSource = ManageMemberData.dsMemberPB
          TabOrder = 13
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'EventStr'
              Title.Caption = 'Event'
              Width = 155
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PB'
              Width = 90
              Visible = True
            end>
        end
        object DBgridContactInfo: TDBGrid
          Left = 584
          Top = 256
          Width = 321
          Height = 210
          DataSource = ManageMemberData.dsContactNum
          Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 14
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'Number'
              Title.Caption = 'Contact Number'
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'luContactNumType'
              Title.Caption = 'Contact Type'
              Width = 120
              Visible = True
            end>
        end
        object DBContactNumNavigator: TDBNavigator
          Left = 911
          Top = 288
          Width = 60
          Height = 176
          DataSource = ManageMemberData.dsContactNum
          VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel]
          Hints.Strings = (
            'First record'
            'Prior record'
            'Next record'
            'Last record'
            'Insert contact record'
            'Delete contact record'
            'Edit record'
            'Post contact edit'
            'Cancel contact edit'
            'Refresh data'
            'Apply updates'
            'Cancel updates')
          Kind = dbnVertical
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
        end
        object DBGridRole: TDBGrid
          Left = 584
          Top = 8
          Width = 675
          Height = 210
          DataSource = ManageMemberData.dsMemberRoleLnk
          DefaultDrawing = False
          Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 16
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnCellClick = DBGridRoleCellClick
          OnColEnter = DBGridColEnter
          OnColExit = DBGridColExit
          OnDrawColumnCell = DBGridDrawColumnCell
          OnEditButtonClick = DBGridRoleEditButtonClick
          OnKeyDown = DBGridRoleKeyDown
          Columns = <
            item
              DropDownRows = 12
              Expanded = False
              FieldName = 'luMemberRoleStr'
              Title.Caption = 'Member'#39's Roles'
              Width = 250
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'IsActive'
              Title.Caption = 'Active'
              Width = 72
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'IsArchived'
              Title.Caption = 'Archived'
              Width = 72
              Visible = True
            end
            item
              ButtonStyle = cbsEllipsis
              Expanded = False
              FieldName = 'ElectedOn'
              ReadOnly = True
              Title.Caption = 'Elected On'
              Width = 110
              Visible = True
            end
            item
              ButtonStyle = cbsEllipsis
              Expanded = False
              FieldName = 'RetiredOn'
              ReadOnly = True
              Title.Caption = 'Retired On'
              Width = 110
              Visible = True
            end>
        end
        object DBNavigator2: TDBNavigator
          Left = 1265
          Top = 42
          Width = 60
          Height = 176
          DataSource = ManageMemberData.dsMemberRoleLnk
          VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel]
          Hints.Strings = (
            'First record'
            'Prior record'
            'Next record'
            'Last record'
            'Insert role record'
            'Delete role record'
            'Edit record'
            'Post role edit'
            'Cancel role edit'
            'Refresh data'
            'Apply updates'
            'Cancel updates')
          Kind = dbnVertical
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
        end
        object DBMemo1: TDBMemo
          Left = 145
          Top = 554
          Width = 407
          Height = 89
          DataField = 'TAGS'
          DataSource = ManageMemberData.dsMember
          TabOrder = 18
        end
        object btnClearDOB: TButton
          Tag = 1
          Left = 289
          Top = 132
          Width = 75
          Height = 32
          Hint = 'Clear the house name.'
          Caption = 'Clear'
          ImageIndex = 0
          Images = ImageList1
          TabOrder = 19
          OnClick = btnClearDOBClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Member'#39's List'
      ImageIndex = 1
      object DBGrid3: TDBGrid
        Left = 0
        Top = 0
        Width = 1355
        Height = 646
        Align = alClient
        BorderStyle = bsNone
        DataSource = ManageMemberData.dsMember
        DefaultDrawing = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnCellClick = DBGridCellClick
        OnColEnter = DBGridColEnter
        OnColExit = DBGridColExit
        OnDrawColumnCell = DBGridDrawColumnCell
        OnEditButtonClick = DBGridEditButtonClick
        OnKeyDown = DBGridKeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'MemberID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MembershipNum'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FirstName'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LastName'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'DOB'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'luGender'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IsArchived'
            Title.Caption = 'Archive'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IsActive'
            Width = 40
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IsSwimmer'
            Title.Caption = 'Swims'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'luHouse'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Email'
            Width = 250
            Visible = True
          end>
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'REPORTS'
      ImageIndex = 2
      object Label5: TLabel
        Left = 241
        Top = 51
        Width = 443
        Height = 19
        Caption = 'Produce a detailed report of the current selected club member.'
        WordWrap = True
      end
      object Label14: TLabel
        Left = 241
        Top = 97
        Width = 499
        Height = 19
        Caption = 
          'List the swimming events that the current selected member has sw' +
          'um.'
        WordWrap = True
      end
      object Label16: TLabel
        Left = 241
        Top = 236
        Width = 472
        Height = 19
        Caption = 'Prepare a summary of all the club members (3 columns per page).'
        WordWrap = True
      end
      object Label17: TLabel
        Left = 241
        Top = 282
        Width = 352
        Height = 19
        Caption = 'Prepare a detailed report of all the club members.'
        WordWrap = True
      end
      object Label9: TLabel
        Left = 242
        Top = 339
        Width = 290
        Height = 19
        Caption = 'Prepare a compact list of club members. '
        WordWrap = True
      end
      object Label19: TLabel
        Left = 242
        Top = 20
        Width = 248
        Height = 25
        Caption = 'Current Selected Member ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label20: TLabel
        Left = 241
        Top = 205
        Width = 131
        Height = 25
        Caption = 'All Members ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object btnMemberDetail: TButton
        Left = 3
        Top = 43
        Width = 218
        Height = 38
        Caption = 'Member Details'
        TabOrder = 0
        OnClick = btnMemberDetailClick
      end
      object btnClubMembersSummary: TButton
        Left = 3
        Top = 228
        Width = 218
        Height = 38
        Caption = 'Club Members Summary'
        TabOrder = 1
        OnClick = btnClubMembersSummaryClick
      end
      object btnMemberHistory: TButton
        Left = 3
        Top = 89
        Width = 218
        Height = 38
        Caption = 'Member History'
        TabOrder = 2
        OnClick = btnMemberHistoryClick
      end
      object btnClubMembersDetailed: TButton
        Left = 3
        Top = 274
        Width = 218
        Height = 38
        Caption = 'Club Members Detailed'
        TabOrder = 3
        OnClick = btnClubMembersDetailedClick
      end
      object btnClubMembersList: TButton
        Left = 3
        Top = 320
        Width = 218
        Height = 38
        Caption = 'Club Members List'
        TabOrder = 4
        OnClick = btnClubMembersListClick
      end
    end
  end
  object ActnMemberMenuBar: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 1363
    Height = 31
    UseSystemFont = False
    ActionManager = ActnManagerMember
    Caption = 'Member Menu Bar'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    HorzMargin = 10
    Spacing = 10
    ExplicitWidth = 1359
  end
  object ImageList1: TImageList
    Height = 24
    Width = 24
    Left = 504
    Top = 392
    Bitmap = {
      494C010101000800040018001800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000600000001800000001002000000000000024
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000040000001000000010000000100000
      0010000000100000001000000010000000100000001000000010000000100000
      0010000000100000001000000001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001000000C5000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000079000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000024000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000004000000E2000000FF000000FF000000FF000000FF000000FF0000
      0063000000FF000000FF000000FF000000FF0000008F000000FF000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000AA000000FF000000FF000000FF000000FF000000FF000000240000
      000000000024000000FF000000FF000000630000000000000024000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0040000000FF000000FF000000FF000000FF000000FF00000091000000000000
      0000000000000000002400000063000000000000000000000000000000640000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000100000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000640000
      0000000000000000000000000000000000000000000000000024000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000C50000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00640000000000000000000000000000000000000024000000FF000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000C30000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00630000000000000000000000000000000000000024000000FF000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000100000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000630000
      0000000000000000000000000000000000000000000000000024000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0040000000FF000000FF000000FF000000FF000000FF0000008F000000000000
      0000000000000000002400000064000000000000000000000000000000640000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000AA000000FF000000FF000000FF000000FF000000FF000000240000
      000000000024000000FF000000FF000000640000000000000024000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000004000000E0000000FF000000FF000000FF000000FF000000FF0000
      0064000000FF000000FF000000FF000000FF00000091000000FF000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000024000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000079000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001000000C3000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000040000001000000010000000100000
      0010000000100000001000000010000000100000001000000010000000100000
      0010000000100000001000000001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000180000000100010000000000200100000000000000000000
      000000000000000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00
      0000000000000000FFFFFF000000000000000000FE0001000000000000000000
      FC0001000000000000000000FC0001000000000000000000F800010000000000
      00000000F00001000000000000000000F01081000000000000000000E039C100
      0000000000000000C01F81000000000000000000800F01000000000000000000
      800F01000000000000000000C01F81000000000000000000E039C10000000000
      00000000F01081000000000000000000F00001000000000000000000F8000100
      0000000000000000FC0001000000000000000000FC0001000000000000000000
      FE0001000000000000000000FFFFFF000000000000000000FFFFFF0000000000
      00000000FFFFFF00000000000000000000000000000000000000000000000000
      000000000000}
  end
  object ActnManagerMember: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = MemFile_AutoEdit
                Caption = '&Auto Edit'
                ImageIndex = 1
                ImageName = 'Edit'
              end
              item
                Caption = '-'
              end
              item
                Action = MemFile_Exit
                Caption = '&Exit Member'
                ImageIndex = 0
                ImageName = 'Exit'
              end>
            Caption = '&File'
          end
          item
            Items = <
              item
                Action = MemSearch_FindMember
                Caption = '&Find Member...'
                ImageIndex = 2
                ImageName = 'Search'
                ShortCut = 16454
              end
              item
                Action = MemSearch_GotoMembershipNum
                Caption = '&Goto Membership Number...'
                ImageIndex = 3
                ImageName = 'Goto'
              end
              item
                Action = MemSearch_GotoMemberID
                Caption = 'G&oto Member ID...'
                ImageIndex = 3
                ImageName = 'Goto'
              end>
            Caption = '&Search'
          end>
        ActionBar = ActnMemberMenuBar
      end>
    Images = VirtlImageListMember
    Left = 504
    Top = 152
    StyleName = 'Platform Default'
    object MemFile_AutoEdit: TAction
      Category = 'File'
      AutoCheck = True
      Caption = 'Auto Edit'
      ImageIndex = 1
      ImageName = 'Edit'
    end
    object MemFile_Exit: TAction
      Category = 'File'
      Caption = 'Exit Member'
      ImageIndex = 0
      ImageName = 'Exit'
      OnExecute = MemFile_ExitExecute
    end
    object MemSearch_FindMember: TAction
      Category = 'Search'
      Caption = 'Find Member...'
      ImageIndex = 2
      ImageName = 'Search'
      ShortCut = 16454
      OnExecute = MemSearch_FindMemberExecute
    end
    object MemSearch_GotoMembershipNum: TAction
      Category = 'Search'
      Caption = 'Goto Membership Number...'
      ImageIndex = 3
      ImageName = 'Goto'
      OnExecute = btnGotoMembershipClick
    end
    object MemSearch_GotoMemberID: TAction
      Category = 'Search'
      Caption = 'Goto Member ID...'
      ImageIndex = 3
      ImageName = 'Goto'
      OnExecute = btnGotoMemberIDClick
    end
  end
  object ImageCollectMember: TImageCollection
    Images = <
      item
        Name = 'Exit'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001B3494441546843ED99BB2E05511486
              BF53E924121AA2D57A0209954E47A344212A89DEA5388D44251A0A858A17D0F1
              329E83ACE40CC7D897D997396BEF98A92699B5F6FCDFBAEC59E7EC11955FA3CA
              F533006867D09781256015984F10FA9EE0EB757501DC00A7DE15DC06227E2B71
              0DA7BB0DE00358CEF06215800BE03C8378594205E01E38AC19E00DD86C015C26
              0049467BBB4C3D6002F0ED56BD09F42D3C00F822D4F7F312323007EC002F31B0
              DA000BC0E304602F0642136005786AED78C1105A006BC033B06E289B20082D00
              D1EDFAE27786D004C802A10D900C51028040C8F0681B399CE59413A03D3F856E
              EBE26F9B82AD1039013E431507DA1B216A0210DE3F1003C05419545F42A94DBC
              015C59FA62264D1CD893BFCCCF80EB50F1629FB30762014E80DB18F125001C00
              0FB1E2B501F627E3B4497F15C39C8CD3BB358FD3A2BD0DD139F20D78094DDC40
              048BD7EE81E9EA9152AAF2477DECD6FBED5742092541FC1B00DF9FBBCD202701
              91FB263072EFF3CD9E813BE03869D51F6795F301D7E73D944B054044BE02DBA1
              6A0DF66A008BC018384A8450036874577DCC9A18FCD9B8177B74D4157F00E81A
              A9BEECBE007A7E5F31069917990000000049454E44AE426082}
          end>
      end
      item
        Name = 'Edit'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000033F494441546843ED9879C80D511887
              9F2F9148241259229125916489105992C8CE67DFF77DDF65DFF77DDF77591289
              1059924824125922914824129D7AA7DEE6BBF7CE9D7B67FBEACE7FBF3BB799E7
              79CF7B66CE992C72F99195CBF9C908843D829911F061049A00738079C035A7EB
              4769040A01BB818E0AFA38D02591445404CA024780FA3160134A444560AEB44D
              BC62C795888A8001779268079CB51B862960EEDD0930D5B58E44126642378D8A
              401EE979236026693212063EC753298C11C82BF01D54359D244ECA68E5982341
              0BE4038E02ED63CCD67812B78196C0F758333C4881FC52793319ADE30950CD61
              2476016FE23D9E82122820F06D158879DB9E008E3948247C1907215050DAA68D
              2299052C905C351D09BF05CCF2C0F47C6B053F0358A4F26C59F7583F995131F3
              E19FD33AC89CF753A0B0B44D2B05320D58A2F24C60BECAA704FE6F32F07E0A14
              91CAB750205381A52A4F0716AA7C5AE0FF240BEF974051816FAE402603CB6D32
              8B553E23F0BFDDC0FB21504CDAA699029908AC54798AAD8DCE09FC2FB7F05E0B
              1497CAEBF5CA7860B5029B042C53F9BCC0FF4C05DE4B811202DF58818C05D6AA
              3C0158A1F205A033F0235578AF044A0A7C2305321A58AFF2386095CA17A5F231
              97076E84D27D8C9612F886EAA623818D2A8F01D6A87C49E0BFB9018DF7DF7404
              4A0B7C0375F1E1C066954701EB54BE2C6DF3D50BF8745AA88CBCFEEB2990A1C0
              569547001B54BE2295FFE2157CAA02E5A4F27515C86060BBCAC3804D2A5F15F8
              CF5EC2A722505EE0EB289081C04E9587005B54BE2E6DF3C96B78B70215A46D6A
              2B90FEF22DC7FA6910B04D9DBF21F01FFD8077235051E06B29907EC01E950700
              3B54BE296DF3C12FF864052A49DBD454207D807D3619B373B28E5B52F9F77EC2
              272350592A5F4381F4020EA8DCD7D6467704FE9DDFF04E025504BEBA02C9060E
              A9DC1BD8ABF25D817F1B04BC93C063DB5EB5BBAC342DB69EC07E057A4FE05F07
              05EF24A0B7745D65342CB61EC041057A5FE05F0509EF46402F39BA018715E803
              F9E8F43268F85404CC66DB6CD2ADE3A154FE4518F06E0462F13D12F8E761C1A7
              236026B8F930FB2C4CF85405CCE740B3937A1A36BC934014F81C19D2D9D0385E
              3C883F640482A872A27B644620EC11F80FD4919C3180B038370000000049454E
              44AE426082}
          end>
      end
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
      end
      item
        Name = 'Goto'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001AE494441546843ED98AD4E04311080
              BFD36882426130BC030A05287E148FC003A0008344F1042802B984E0082F8043
              205038044F80C0409AEC26A5B96DA73B6DE68EB4C99ADDE9F4FB6636DBDE4D58
              F03159707E9A8075075B075A07941568AF90B280EAE9961DB8050EB40656020E
              7E1FB8D34A5808F4F07DF15512F320E044464B580838E0B00BA325AC048A4958
              0A1491B016504BCC83804A625E04464BE40A2C011BC1A5DD4CC3F99BC18DE827
              36476017B804D64A130BF20D4A48052E8013C1423543DCB9C989FC1912819F9A
              54C2DC33E1DDDC94C03570142CF205DC03AFC0B3104012B6DCEDD061EC207C4A
              600B780CB2BD74A7C8770951468C3B99BAE345167C4AE001D8F1327E00AB1950
              D2D0D1F029814F60A5A3F806B681272995304E051F135807DE3C8829B0278492
              86A9E1630287C08D4772051C4BC9047145E0630267C0A907720EB87B25463178
              0B81A2F016026ECD5022FA9D4FB57C6823ABF90AF9122A78AB0EF445EDFF5649
              1539FADCAA032A687F72132856CA9189FE7507C29A94DAC846D67AF6B4D4EF81
              A28BD548D6046A54352767EB404EB56AC4B60ED4A86A4ECED6819C6AD588FD05
              28D25331505BCA9D0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Info'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000042E494441546843ED9947A815491486
              3FB72E0C881B130AAE467414845117868563449C3163405147174E7010441046
              712328C6013161CE19CC2E745C184031A12B41316D440C0BD7F20F558FBA7DBB
              6F5755973E1E78A0B9977BEB9C3A7F8513FE6E450B97562DDC7FBE0368EE1D4C
              B9035D8021407FA0BBF308E373E7B903FC07BC4A01BE2A801F8079C020E0A740
              876E0337801DC09340DDA6E1B100DA007F038B017DAF229F80F5C03A40DF8324
              06C04C6029D02B33D353E000F0D21C0FFBA9613A5E5D9DCFE940CF8CFE63602D
              B03B044128800DC09F9909AE03FB8DF39F3D276F0D08C40C6070464700E678DA
              090AA3E781518EE177C002E084EF6405E326005B810ECEFFBAF43D7CECFAEEC0
              26E077C7E023606A95CB97714EC1E030D0DBF9FDAE89680D71F800F8CDAC9035
              740C98ECB33A11638E02931CBD65C0EA4676CA004C312B636DFC9BD989081F4B
              5536038B9C51BA2B078BB41A015078549CB6D1E60AF073E9F469065C06861B53
              8A4ECA33B921B6118015C03FC68842E240E0751AFF4AAD74066E9AD0ABC12B01
              F95327450074A964C026A95F8153A5D3D60E9806FC627E92EEA1407DE99E343A
              5A7D2D605DC62E02A0CCF89751569C578D132A0AAF022E91230A97A1A29AC9E6
              09E52065FE1A2902700FE86B462A0A6D0F9D19980DEC327A4A4C4119D6E8CD07
              B699EFF7817E3E0054493E3303551EFC08F866D8ACFD8EE687B7110B201565EC
              074ED9A1E4A624D724793BE0AE5CE1E589742846CD0D26753B9907C03DFF2A15
              EC16C64C9E42C74DA475F7200F8022C67833F358E05C0A2F2AD818039C35FAA7
              9DC8F6FF4F7900DC0BDC0750DD13234381AB46F11A302CC688A98F1E165DE43C
              00EF817646419F1F23274E05A02DF0C1F8A0CFF66597D80520E5E02EC94C900A
              8092A95D442F00EE11521D14DBAFA602A0AA40F590A42E17945DE291C0A5663E
              4223808B2197D80DA3621C76363380B986B9901B5E6154F5B77A5C49954496EA
              08B9894C3DB4888326C93B426210543E4BAA94122900644B09311B3584585131
              77CB21AA628BB91400DC624E44D880EC712E022092C996AEB1E5740A006E39AD
              BB2932AD467C1B9A8911F4495500EA1F8E1B6F831B1AE9B997471C901A8B909C
              50058062BF76DE7245C12DA500649B7AD544AA8DBE85A8F6B11C5174532F47C5
              83EE753CFE9A9C909D26CB0DCD02F615AD5A192F24BD35C012C7C0D7E486B29C
              D046A737CFC5E003408A6780718E057144EA8E52D12CA251D43F5B2E48535D00
              46979D575F00B2B307D0765A51B213531D4AB7647D127DA2955692B2A29DF8A3
              CC79FD1F0240E317025B328653D3EB416D6C2800F92E567A7983171C6FCCD17A
              01E89174338F8E4A27F36E20EF05C72AE088CFCADB313100A4DBA25F31B90BA4
              84A37A4549CB1261BE0BA8E644BDB248B3900459633F7607F29C1421262022C2
              1ABD66155125C76B082A5FD4D9712901C4FA5049EF3B804ACB9740B9C5EFC017
              4EABDD310AD690EA0000000049454E44AE426082}
          end>
      end>
    Left = 504
    Top = 224
  end
  object VirtlImageListMember: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Exit'
        Name = 'Exit'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Edit'
        Name = 'Edit'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Search'
        Name = 'Search'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Goto'
        Name = 'Goto'
      end>
    ImageCollection = ImageCollectMember
    Width = 32
    Height = 32
    Left = 504
    Top = 312
  end
  object BalloonHint1: TBalloonHint
    Delay = 100
    Left = 716
    Top = 630
  end
  object VirtualImageList1: TVirtualImageList
    Images = <
      item
        CollectionIndex = 4
        CollectionName = 'Info'
        Name = 'Info'
      end>
    ImageCollection = ImageCollectMember
    Width = 24
    Height = 24
    Left = 816
    Top = 632
  end
end
