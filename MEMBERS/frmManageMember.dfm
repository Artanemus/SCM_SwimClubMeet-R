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
    Top = 25
    Width = 1363
    Height = 49
    Align = alTop
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 1359
    object btnInfoFilter: TVirtualImage
      Left = 869
      Top = 6
      Width = 25
      Height = 26
      ImageCollection = ImageCollectMember
      ImageWidth = 0
      ImageHeight = 0
      ImageIndex = 4
      ImageName = 'Info'
      OnClick = btnInfoFilterClick
      OnMouseLeave = btnInfoMouseLeave
    end
    object DBTextFullName: TDBText
      Left = 21
      Top = 6
      Width = 154
      Height = 25
      AutoSize = True
      DataField = 'FName'
      DataSource = ManageMemberData.dsMember
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnFindMember: TButton
      Left = 906
      Top = 9
      Width = 142
      Height = 34
      Caption = 'Find...'
      ImageIndex = 4
      ImageName = 'Search'
      ImageMargins.Left = 4
      ImageMargins.Right = -20
      Images = BTNImageList32x32
      TabOrder = 0
      OnClick = btnFindMemberClick
    end
    object btnGotoMemberID: TButton
      Left = 1054
      Top = 9
      Width = 142
      Height = 34
      Caption = 'Goto MemberID'
      TabOrder = 1
      OnClick = btnGotoMemberIDClick
    end
    object btnGotoMembership: TButton
      Left = 1202
      Top = 9
      Width = 157
      Height = 34
      Caption = 'Goto Membership#'
      TabOrder = 2
      OnClick = btnGotoMembershipClick
    end
    object btnFilter: TButton
      Left = 727
      Top = 9
      Width = 142
      Height = 34
      Action = actnFilter
      ImageIndex = 8
      ImageMargins.Left = 4
      ImageMargins.Right = -16
      Images = BTNImageList32x32
      TabOrder = 3
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
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 74
    Width = 1363
    Height = 702
    ActivePage = TabSheet5
    Align = alClient
    MultiLine = True
    TabHeight = 40
    TabOrder = 2
    TabWidth = 180
    ExplicitWidth = 1359
    ExplicitHeight = 701
    object TabSheet1: TTabSheet
      Caption = 'Member'#39's Details 1'
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 1355
        Height = 652
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Label3: TLabel
          Left = 23
          Top = 227
          Width = 115
          Height = 19
          Alignment = taRightJustify
          Caption = '*Date of Birth'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 68
          Top = 348
          Width = 69
          Height = 19
          Alignment = taRightJustify
          Caption = '*Gender'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 42
          Top = 143
          Width = 96
          Height = 19
          Alignment = taRightJustify
          Caption = '*Last Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 40
          Top = 107
          Width = 98
          Height = 19
          Alignment = taRightJustify
          Caption = '*First Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 732
          Top = 222
          Width = 39
          Height = 19
          Alignment = taRightJustify
          Caption = 'Email'
        end
        object Label7: TLabel
          Left = 586
          Top = 143
          Width = 185
          Height = 19
          Alignment = taRightJustify
          Caption = 'Club Membership Number'
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
          Width = 177
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
          Left = 727
          Top = 261
          Width = 44
          Height = 19
          Alignment = taRightJustify
          Caption = 'House'
        end
        object Label22: TLabel
          Left = 144
          Top = 296
          Width = 191
          Height = 19
          Alignment = taRightJustify
          Caption = 'Member'#39's age as of today :'
        end
        object Label24: TLabel
          Left = 143
          Top = 382
          Width = 204
          Height = 19
          Caption = '(Checkboxes use Specificity.)'
        end
        object Label18: TLabel
          Left = 508
          Top = 107
          Width = 264
          Height = 19
          Alignment = taRightJustify
          Caption = 'Governing Body Registration Number'
        end
        object Label8: TLabel
          Left = 853
          Top = 143
          Width = 277
          Height = 19
          Caption = '(Recommended - minimum of 4 digits)'
        end
        object lblMembersAge: TLabel
          Left = 341
          Top = 294
          Width = 128
          Height = 23
          Caption = 'lblMembersAge'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 144
          Top = 265
          Width = 193
          Height = 19
          Caption = 'Locale Date Format Syntax '
        end
        object btnInfoDateTime: TVirtualImage
          Left = 343
          Top = 258
          Width = 25
          Height = 26
          ImageCollection = ImageCollectMember
          ImageWidth = 0
          ImageHeight = 0
          ImageIndex = 4
          ImageName = 'Info'
          OnClick = btnInfoDateTimeClick
          OnMouseLeave = btnInfoMouseLeave
        end
        object Label15: TLabel
          Left = 670
          Top = 314
          Width = 102
          Height = 19
          Alignment = taRightJustify
          Caption = 'Metadata Tags'
        end
        object Label25: TLabel
          Left = 146
          Top = 63
          Width = 323
          Height = 19
          Caption = 'Fields marked with an asterisk * are required.'
        end
        object DBlucboGender: TDBLookupComboBox
          Left = 144
          Top = 344
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
          TabOrder = 5
        end
        object DBedtFirstName: TDBEdit
          Left = 144
          Top = 104
          Width = 292
          Height = 27
          DataField = 'FirstName'
          DataSource = ManageMemberData.dsMember
          TabOrder = 0
        end
        object DBedtLastName: TDBEdit
          Left = 144
          Top = 140
          Width = 292
          Height = 27
          DataField = 'LastName'
          DataSource = ManageMemberData.dsMember
          TabOrder = 1
        end
        object DBedtMembershipNum: TDBEdit
          Left = 777
          Top = 140
          Width = 70
          Height = 27
          DataField = 'MembershipNum'
          DataSource = ManageMemberData.dsMember
          TabOrder = 11
        end
        object DBchkIsActive: TDBCheckBox
          Left = 143
          Top = 436
          Width = 292
          Height = 17
          Caption = 'Is Active - Indicates full membership. '
          DataField = 'IsActive'
          DataSource = ManageMemberData.dsMember
          TabOrder = 8
        end
        object DBEdtEmail: TDBEdit
          Left = 777
          Top = 219
          Width = 407
          Height = 27
          DataField = 'Email'
          DataSource = ManageMemberData.dsMember
          TabOrder = 12
        end
        object DBlucboHouse: TDBLookupComboBox
          Left = 777
          Top = 257
          Width = 233
          Height = 27
          Hint = 'Assign house (Clear .. Ctrl-Del)'
          DataField = 'HouseID'
          DataSource = ManageMemberData.dsMember
          KeyField = 'HouseID'
          ListField = 'Caption'
          ListSource = ManageMemberData.dsHouse
          NullValueKey = 32776
          TabOrder = 13
        end
        object DBchkIsSwimmer: TDBCheckBox
          Left = 143
          Top = 463
          Width = 344
          Height = 17
          Caption = 'Is Swimmer - Participates in events.'
          DataField = 'IsSwimmer'
          DataSource = ManageMemberData.dsMember
          TabOrder = 9
        end
        object DBchkIsArchived: TDBCheckBox
          Left = 143
          Top = 409
          Width = 255
          Height = 17
          Caption = 'Is Archived - Retired from club.'
          DataField = 'IsArchived'
          DataSource = ManageMemberData.dsMember
          TabOrder = 7
        end
        object btnClearHouse: TButton
          Tag = 3
          Left = 1016
          Top = 252
          Width = 75
          Height = 32
          Hint = 'Clear the house name.'
          Caption = 'Clear'
          ImageIndex = 3
          ImageName = 'BackSpace_FILL'
          Images = BTNImageList32x32
          TabOrder = 14
          OnClick = btnClearClick
        end
        object btnClearGender: TButton
          Tag = 1
          Left = 298
          Top = 344
          Width = 75
          Height = 32
          Hint = 'Clear the house name.'
          Caption = 'Clear'
          ImageIndex = 3
          ImageName = 'BackSpace_FILL'
          Images = BTNImageList32x32
          TabOrder = 6
          OnClick = btnClearClick
        end
        object RegistrationNum: TDBEdit
          Left = 778
          Top = 104
          Width = 184
          Height = 27
          DataField = 'MembershipStr'
          DataSource = ManageMemberData.dsMember
          TabOrder = 10
        end
        object btnClearDOB: TButton
          Tag = 1
          Left = 290
          Top = 220
          Width = 75
          Height = 32
          Hint = 'Clear the house name.'
          Caption = 'Clear'
          ImageIndex = 3
          ImageName = 'BackSpace_FILL'
          Images = BTNImageList32x32
          TabOrder = 3
          OnClick = btnClearDOBClick
        end
        object btnDOBPicker: TButton
          Tag = 1
          Left = 371
          Top = 220
          Width = 127
          Height = 32
          Hint = 'Clear the house name.'
          Caption = 'DOB Picker'
          ImageIndex = 1
          ImageName = 'dialogs'
          Images = BTNImageList32x32
          TabOrder = 4
          OnClick = btnDOBPickerClick
        end
        object DBedtDOB: TDBEdit
          Left = 144
          Top = 222
          Width = 140
          Height = 27
          DataField = 'DOB'
          DataSource = ManageMemberData.dsMember
          TabOrder = 2
        end
        object DBMemo1: TDBMemo
          Left = 778
          Top = 311
          Width = 407
          Height = 124
          DataField = 'TAGS'
          DataSource = ManageMemberData.dsMember
          TabOrder = 15
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Member'#39's Details 2'
      ImageIndex = 3
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
        Left = 408
        Top = 10
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
      object Label13: TLabel
        Left = 54
        Top = 10
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
      object Label23: TLabel
        Left = 54
        Top = 245
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
      object Label26: TLabel
        Left = 557
        Top = 248
        Width = 21
        Height = 108
        Alignment = taRightJustify
        Caption = 'EVENTS SWUM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Orientation = 900
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object DBGridRole: TDBGrid
        Left = 584
        Top = 8
        Width = 675
        Height = 210
        DataSource = ManageMemberData.dsMemberRoleLnk
        DefaultDrawing = False
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 2
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
        OnKeyDown = DBGridGenericKeyDown
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
            FieldName = 'StartOn'
            ReadOnly = True
            Title.Caption = 'Start On'
            Width = 110
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'EndOn'
            ReadOnly = True
            Title.Caption = 'End On'
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
        TabOrder = 3
      end
      object DBContactNumNavigator: TDBNavigator
        Left = 408
        Top = 42
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
        TabOrder = 1
      end
      object DBgridContactInfo: TDBGrid
        Left = 81
        Top = 10
        Width = 321
        Height = 210
        DataSource = ManageMemberData.dsContactNum
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyDown = DBGridGenericKeyDown
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
      object DBgridHistoryPB: TDBGrid
        Left = 81
        Top = 248
        Width = 301
        Height = 381
        DataSource = ManageMemberData.dsMemberPB
        TabOrder = 4
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
      object DBGrid1: TDBGrid
        Left = 584
        Top = 248
        Width = 417
        Height = 385
        DataSource = ManageMemberData.dsMemberEvents
        TabOrder = 5
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'EventStr'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RaceTime'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EventDate'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EventID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'MemberID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'FName'
            Visible = False
          end>
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'LIST'
      ImageIndex = 1
      object DBGrid3: TDBGrid
        Left = 0
        Top = 0
        Width = 1355
        Height = 652
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
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FirstName'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LastName'
            Width = 64
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'DOB'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'luGender'
            Width = 64
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IsArchived'
            Title.Caption = 'Archive'
            Width = 64
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
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'luHouse'
            Width = 64
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
        TabOrder = 2
        OnClick = btnClubMembersSummaryClick
      end
      object btnMemberHistory: TButton
        Left = 3
        Top = 89
        Width = 218
        Height = 38
        Caption = 'Member History'
        TabOrder = 1
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
    object TabSheet5: TTabSheet
      Caption = 'CHART'
      ImageIndex = 4
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1355
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 1351
        DesignSize = (
          1355
          41)
        object Label27: TLabel
          Left = 24
          Top = 11
          Width = 59
          Height = 19
          Alignment = taRightJustify
          Caption = 'Distance'
        end
        object Label28: TLabel
          Left = 334
          Top = 11
          Width = 45
          Height = 19
          Alignment = taRightJustify
          Caption = 'Stroke'
        end
        object cmboDistance: TComboBox
          Left = 89
          Top = 8
          Width = 183
          Height = 27
          TabOrder = 0
          Text = 'cmboDistance'
          OnChange = cmboDistanceChange
        end
        object cmboStroke: TComboBox
          Left = 385
          Top = 8
          Width = 184
          Height = 27
          TabOrder = 1
          Text = 'cmboStroke'
          OnChange = cmboStrokeChange
        end
        object chkbDoCurrSeason: TCheckBox
          Left = 616
          Top = 11
          Width = 225
          Height = 17
          Caption = 'Current swimming season.'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = chkbDoCurrSeasonClick
        end
        object btmPrintChart: TButton
          Left = 1223
          Top = 8
          Width = 129
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Print Chart'
          TabOrder = 3
          OnClick = btmPrintChartClick
        end
      end
      object DBChart1: TDBChart
        Left = 0
        Top = 41
        Width = 1355
        Height = 611
        Title.Text.Strings = (
          'TDBChart')
        BottomAxis.ExactDateTime = False
        BottomAxis.Increment = 1.000000000000000000
        Legend.Title.Alignment = taCenter
        Legend.Title.Text.Strings = (
          'Race Time & Date')
        View3D = False
        OnGetLegendText = DBChart1GetLegendText
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 1351
        ExplicitHeight = 610
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series2: TLineSeries
          HoverElement = [heCurrent]
          DataSource = ManageMemberData.qryChart
          XLabelsSource = 'ChartX'
          Brush.BackColor = clDefault
          Pointer.Brush.Gradient.EndColor = 10708548
          Pointer.Gradient.EndColor = 10708548
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'ChartX'
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'Seconds'
        end
      end
    end
  end
  object ActnMemberMenuBar: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 1363
    Height = 25
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
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    HorzMargin = 10
    Spacing = 10
    ExplicitWidth = 1359
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
    Left = 1120
    Top = 536
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
    object actnFilter: TAction
      Caption = 'Filter'
      ImageIndex = 4
      ImageName = 'filter_alt'
      OnExecute = actnFilterExecute
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
      end
      item
        Name = 'dialogs'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000128494441546843ED993D0EC2300C85
              BF5E8701265881998320C121804380C4419881152618B80EA848954A9AD0A0FE
              A42D2FB39BF8D9CF2F8D1DD1F215B5DC7F042074063B9F81213003C681227D06
              0EC0D575FEB70CAC815520C7CD633740EC4F66B900F4815B439C4FDC180077D3
              2717802DB06818801DB0F40570042629E350C5FE4CF97002A6025033AD948124
              E09DAC81B8D0CB5C9902052AA590A95445C05815460072EE016520EF92128544
              217F5D920A99B1F2F91B950A4985C0D9171285FC05E86D2915920AFD4819D35C
              14FA5B0A1564CEC7E7B53F29CB74DEB557A56F6201F0888032D0DAC65693861B
              4910AD430E57CB301E2D5D3C385AA7C9C8366AEAEC8829896C3C6A9A03BD3A43
              9D3AEB01EC6DA3A5D0C5595A3C42B5CD0540142A8D0305377A01937C92313C82
              72590000000049454E44AE426082}
          end>
      end
      item
        Name = 'ClearBackSpace'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000252494441546843ED98E13105311485
              CFAB0015A00274A00354800A50012A4005A80015D0012A400754C07C33C94C26
              93CDCB4B6E981D9B5F8FD9BD7BBF7BCF3DC9EE4C235FB391E7AF09E0AF3B3875
              60EA40630526093516B0F9F67FDF813549A7920E9A4B990EF029E946D2C950FC
              960E6C4A7A94B4DC29F930EC95A4E3D4736A01489AE481F88D4527562C012E25
              1DB9805F0EE4BD03C977103359EC9A0EEC4ABA0B02A34F807A2C7300A4F316E8
              FE411240BD96390095F709231D5C087DC60B5024765E48B62FE93671AD29002E
              70113C644FD2FD40F27EC0B1C0C33910D7CE8653D79A01C49639686B92CEDCDE
              E0F3CE41F8E4FDB5C072BD5F6600CF81657EB8DF29E98449238B1C449C3C128A
              37441380B8A25B925E0AB44D2587204A92E711CD00DB6EC3F2F932940095AE14
              04F786954E55DE44423809D2C16958AF953B6F0C11C2E7926FEE406C990C72ED
              6E9B8298977C330016B9E3CAC5C0A2FD5A8058F3842DB1D8A61940420CEBAA83
              E037108BAE54F239770AE3370110A87588536E43DC79166B32C43E48AD8DE6AC
              3267B1A61DF0C190CF86FB8339404AB98DACC4E74B209A25E40170A027494BEE
              1F8B1C25726E1343C4FB8C1900792F729803968E9558A587609F61E6C2CE9A02
              00115BEB7AE6380D70E9AECD75BC14C5B23407C05A99012F25803856F75AE600
              296B1DD52BA5AF74F852DFBA4BE7BAD7A5033C1029F941ED259F302EAFAFC9EF
              4F355F2586ACB52788F9872D9F2C476D1C243C1A588250796C36F9558E07B574
              C032D1EA58134075E98C6E9C3A6054C8EA305307AA4B6774E3D401A342568719
              7D077E00C2448C31F447C64B0000000049454E44AE426082}
          end>
      end
      item
        Name = 'BackSpace_FILL'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000243494441546843ED98316815411086
              BF07564A8440D0225D8890D24282B6826D8A80415014EC6C044108046C848020
              083676560A924820695404D14A0D16621510D2246942C446EC42083FDCC1E3E5
              DCDBD9D9DCF1F0B6BC9BF9E7FF766EEF76AFC7908FDE90FBA70368BB835D07BA
              0E3867E0BF7F84CE01E3CE49B4A47F1A0CF676E03D70C5E2C0197BC4AF076001
              58741AB2A66703B8047CB656CF109F0DE03B703E8321AB44168027C03D6BE54C
              F16E8019602D9399141917C06960071849A99C29C705B004CC198DBC06AED6E4
              C4C49412C900B781E746F38295B9E50084EE2B4E908AAB1B490013C0669DF2C0
              FDD27C79B90AA2345FC6C44024017C032E1800568A593D18C8E98718341F02ED
              9731033C041E18CC97A16F0A88BF1510BA54B596428F5AD21AB8087C49305FA6
              7C2C8CFE8AD088312F1953077E03A311C543215F0B88ED4050AC7913C04BE0BA
              D37C99FEA380F859A167316F027801DC18660079DF05CE38215A7B84E45BBB4D
              ED3A53C7BF16F109603FF08A0DD5332D6209CD038F120842AF5101DC02FE2440
              980154E30370D90011F3217B07DC04F68C104900631585EA7862B6123AA0AB13
              5B8598CED6ABC0C980781280F46601CDAC65C46CE6D68B4E9C02DE02676B0A24
              0348F72970D74250EC46EBB6D3FA4E08603242DB0520FD0D602AA2D07185B801
              A601B5BDADE10690F1FBC0E39608B200C8BB0EF63AE0373DB201E87FA8D643D3
              07FC6C009AF96BC0AB865B901540DE9F01771A84C80ED0A0F7EA529EBFD3AD9B
              97810EA0ED36741DE83AE09C81EE11724EA03BFD10E1B95B31ED1AD310000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Checked'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000188494441546843ED995D51C6301045
              CFA7001C000E90004EC0010E0007380009384002480005E000E6CE90994E4993
              E6AF4999CD4B1F9AA4F7ECDD24DBC9819DB7C3CEF56300BD1D34074677E016B8
              018E3B09FD021E80FBA5EF8752E80E10C0084D00D2F3A785003E3B467E2EF41D
              384B05F89E0CE8B5D8A31A42C2A28337C8ADA8060368EC8239E0026C8B38906A
              3A242F80674F9FE15348E25F8073E01A789A410C0D3015EF74EBB0D2A1E5DAB0
              003EF1BB7160AD78B9309C0329E29B03B8125B25EF9A962ABE298013A38F5C02
              31881CF14D015E7FB73E7DE42D02912BBE29C015F038C99B258812F14D013479
              0CA2547C73801084DEB913D619E5DBE7638B7F936DD4E78484A93C2811BF8903
              4EE01C621AD99CC87729257C1025E23775C0E744A9F82E006E61EB392F8D630B
              D6F77E93459C236CED18037091B27FE2B53933EB6729642994993A554E62FDA4
              1C150AA835FC0338F54DF6AF2F3804AC5B11D53827B54299388F22AF13DD7B3B
              A3B97AEDEF891CCBDD0DA05A28332732073203576DD8EE1DF80140A979314B2A
              62800000000049454E44AE426082}
          end>
      end
      item
        Name = 'UnChecked'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000000EF494441546843ED99D10DC2300C44
              5F27800D80CD18810D800D1881D1E804B001C842150848ADA40537E8F2DBBAF5
              9D5FE2A669A87C3495E78F0444575015987A05B6C0069807257A010EC03EF5FE
              3E8476800998C2300196CFDBE813700E74FE35D113B0CA15707D0A889AEC6E0E
              7D89B9C13F60CBCD4102BE5C0555A0335893B810352124840AD1E9C284901012
              420F073EF6227D0B0D44C40BD72AA455C863C4B92E848490105223BB3BA02D65
              E15CD032AA65B4101D6D29CD013B5C980D7470ACF01658E6FE5EAFFE80C3049B
              8835B018CBCACCE798F3C7D4E94C6483CAD491BE3DAAC34A4074835205FEA602
              37C5724A31DEC9C9540000000049454E44AE426082}
          end>
      end
      item
        Name = 'filter_alt'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000239494441546843ED983F481D411087
              BF578A6D0282A68A45545452C62A8A2420A4312816166A22A40BE23F2CEC4430
              10B10C444D2085A068A522886823A40C51214D1AC542B48E65C2C03D598EBDB7
              777B73C407BBE5DDCE6FE6DBD9DFDEBE57A2CA47A9CAEB2700FCEF0E860E840E
              E45C81345BE821D092338F6FF829705329D805D007ACFB66578AEB073692B45C
              005F8021A5427C65A47881B00E17C024F0C137B352DC4760C217A006D8059E1B
              02ABC01BA5E2E2322BC088F1F008E8016E7D0124AE2D82A83744C680256588F7
              31CDCBA8F89F794C5C8EED05366342DDC08112449745EB35B0E5D27779C08C9F
              02168C0757402B70ED4AE278FF003801EA8C79D369BD970540F43F036F8D44FB
              C08B9C007BC04B436319184DAB9915C066EA45603C6DC2D83C39E1E4A42B0FA7
              69E379B20224997A18F89A116210F866C4A432AD068068D84CFD14F89112A2DD
              32379569B50044276EEA5F4033F0D701215D3F039A7C4CAB09603375C5CF7E94
              7C0D18F035AD3680CDD4B3C05C42176680F93CA6D5064832F52B603B964CAE04
              3B794D5B0480CDD47F8027C04594B001108FD41A057899B628009BA9BF03CFA2
              84C7408786698B04B099FA5394F09D96698B06906BF7A1E318ED04E48BAB327C
              BEC495120780AC6D091D88AD58D842610B655D81B08572AE583885C216BA675B
              E81170EEA8A911F89DB3EEBB706D0F88B05CE6CCFF52CD5AE512279739B55104
              8014F718906E984356BDFC03E7DE03A815E8122AAA03AEBC6AEF0380DA527A0A
              850E782E9C5A58D577E01F4B096A31D3531B890000000049454E44AE426082}
          end>
      end
      item
        Name = 'filter_alt_off'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000288494441546843ED993D68163118C7
              7FAFE05070501C844205D14510140441B05A11FCC24114050707D1C1A1A38820
              2E0E3A48711007B15BFD40452787D2C52F1CDD04279716C4411C3B96F287BC10
              C2BD974B2EB9DC2BDE7AB9CBFF977F9E2779920163FE0CC65C3FFF014A3BF84F
              3AF0DA8CEAC5D2A3DBA47FD70189BF603E7C03F41EA20E401C2EC44C935149D8
              E63BF0A7EE7F553160BB5005711C780F6C4C28B4EE579A051AC8CA675410FB20
              0E01AF80C90E206AA7725D16F241EC071680DD99216E020F421D18B6F741A4D6
              3E0F5CB57EFA053809ACC602E8BBAE20668147965005AFC47F0B0DE2AAF6B921
              A681CF4EC79781673E8B4356E25C10DB80AFC04E4BEC3DE0B64FBCDE8700E49A
              4E6F817396D877C0F926E263005243DC01EE5A627F004AD17F7302A482B804BC
              70846AA5FFD4547CAC032952EC016011D8628955167A1C22BE2D40AC135BCDD6
              E0A825F609703D547C0A801888A7C03567B13A1C233E154008C42DE0BEB358ED
              057E95066802A13A63582C0DF59E009662C5A774A06960DB103780B936E27300
              280D7E7044B9DB61419C06AEB415DF1580FAC9569E866E257C8356E5C0F09B2C
              105D026471A26B80E4102500924294024806511220094409001D56EDB1D259AB
              EC540240BBD087C0BE1410A5007E9B825D674BADD68952001F815DC07340C54D
              3444490089DE61200EC642940690EE29531BAB980F76223580C42C7B364CDB81
              15A78D0E8955E01F0985480DA0FEB59D1E758FA0B96FD7C236870EB81413C742
              207200A87F9DB2C90DFBD1A8FFF4B8A3825F4EE80EA2D174CA05E0D159FB7AB3
              8138D504A28F00D2BD0978099CF141F41540BA278C13670D44E596A3CF00D2AD
              7B3839B136EAC6B4EF0082D860002A03671C006A237EEC01D601D3CB87317D5F
              A3B20000000049454E44AE426082}
          end>
      end
      item
        Name = 'asterisk'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000002B3494441546843ED983BAF8D411486
              9FD3F157F813FC08B72808E27E4D284828244810B720C43D41E2D2684814C869
              4EA150088946A191884621110D7BC94CF265CEAC6FD69A3D67B3E39B6437FB9B
              59EB7DE69DFB0C535E66A65C3F03C0DF76707040716019F032F9B61C78D5DAB1
              85726000B03AF5AF39B004786F152FF5BC007780C5A3242B0B496A8690887F08
              3C030E58213C006781BD21F0A3028417208A5F1AE25F03365B20AC00C7804349
              C03E080F402A3EA6B90FAC2D4158018E028733C134082B80265E52955CFE23C7
              0A20758F03078D101680B1C57B01A4FE496582A5BD55026822BE0640DA9C01F6
              159CE8036826BE1640DA5D0076F54068005FC25219579B6E08D3984F737AE640
              DAF632B04D81906FB9B3D0C5D1E46C267E1C07A26E59AF3729102B92FFDFB516
              DF024062DC02D697D66BE57BD5B0E9C61A670875E3DCB56C3A8E8DD0DC1F1A80
              4C426FD90AAC3236929E9779E22DF3EE131AC02F6FE409D59FA777009850CFC7
              34FF8F033593783B90AEFD9A416F81DD15EE9927B137B6DCA4ACE263EC37C09A
              D1EF833759EB7DA0467CD4F01A580D7CAC85187723D3C43FC8EC09B9FF44F75C
              80F85403310E8026FE1E705D39CCC9B929774D9C0D109FBD10B5009A7879B590
              7351DF7DE036B02E23F44570EDAB07A20640137FA373322DDDC8C4A18D19A1CF
              C36BC7372B841740137F1590B3502C2500A97705D89211FA34407CB740780034
              F197809D49320B8034910BCE8E8CD02701E26709C20AA0893FDF79ECEAE6B202
              489B73C09E8CD0C701A2F7606905D800C818EF96D33D4F801E0089790AD89FC4
              973972B395031247B67EE9712927322F75B50EC476DD772771441E0E8AC5EA40
              0C24CF8B8B802385C85E0762387901FC111ED18AE2A58217C014B4B00F586398
              EA0D004A37D50E2153AF772B0D0EB8BBAC71838572A0B14C3DDC0030B1AE5612
              4DBD03BF012DBC9C31D9C92A1A0000000049454E44AE426082}
          end>
      end>
    Left = 1112
    Top = 624
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
      end
      item
        CollectionIndex = 10
        CollectionName = 'filter_alt'
        Name = 'filter_alt'
      end
      item
        CollectionIndex = 11
        CollectionName = 'filter_alt_off'
        Name = 'filter_alt_off'
      end>
    ImageCollection = ImageCollectMember
    Width = 32
    Height = 32
    Left = 1192
    Top = 648
  end
  object BalloonHint1: TBalloonHint
    Delay = 100
    Left = 1116
    Top = 686
  end
  object BTNImageList32x32: TVirtualImageList
    Images = <
      item
        CollectionIndex = 4
        CollectionName = 'Info'
        Name = 'Info'
      end
      item
        CollectionIndex = 5
        CollectionName = 'dialogs'
        Name = 'dialogs'
      end
      item
        CollectionIndex = 6
        CollectionName = 'ClearBackSpace'
        Name = 'ClearBackSpace'
      end
      item
        CollectionIndex = 7
        CollectionName = 'BackSpace_FILL'
        Name = 'BackSpace_FILL'
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
      end
      item
        CollectionIndex = 8
        CollectionName = 'Checked'
        Name = 'Checked'
      end
      item
        CollectionIndex = 9
        CollectionName = 'UnChecked'
        Name = 'UnChecked'
      end
      item
        CollectionIndex = 10
        CollectionName = 'filter_alt'
        Name = 'filter_alt'
      end
      item
        CollectionIndex = 11
        CollectionName = 'filter_alt_off'
        Name = 'filter_alt_off'
      end>
    ImageCollection = ImageCollectMember
    Width = 32
    Height = 32
    Left = 1048
    Top = 656
  end
end
