object ManageMember: TManageMember
  Left = 0
  Top = 0
  Caption = 'Manage SwimClubMeet Members'
  ClientHeight = 824
  ClientWidth = 1350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 19
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1350
    Height = 49
    Align = alTop
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 0
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
    Top = 758
    Width = 1350
    Height = 66
    Align = alBottom
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 1
    object DBNavigator1: TDBNavigator
      Left = 385
      Top = 6
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
    Top = 49
    Width = 1350
    Height = 709
    ActivePage = TabSheet1
    Align = alClient
    MultiLine = True
    TabHeight = 40
    TabOrder = 2
    TabWidth = 160
    object TabSheet1: TTabSheet
      Caption = 'Member'#39's Details'
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 1342
        Height = 659
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
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
          Left = 99
          Top = 567
          Width = 39
          Height = 19
          Alignment = taRightJustify
          Caption = 'Email'
        end
        object DBText3: TDBText
          Left = 313
          Top = 170
          Width = 65
          Height = 17
          DataField = 'SwimmerAge'
        end
        object Label6: TLabel
          Left = 52
          Top = 500
          Width = 86
          Height = 38
          Alignment = taRightJustify
          Caption = 'Membership Type'
          WordWrap = True
        end
        object Label7: TLabel
          Left = 11
          Top = 444
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
          Left = 94
          Top = 606
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
          Top = 263
          Width = 204
          Height = 19
          Caption = '(Checkboxes use Specificity.)'
        end
        object Label18: TLabel
          Left = 27
          Top = 388
          Width = 113
          Height = 38
          Alignment = taRightJustify
          Caption = 'Governing Body Registration'
          WordWrap = True
        end
        object Label8: TLabel
          Left = 275
          Top = 444
          Width = 277
          Height = 19
          Caption = '(Recommended - minimum of 4 digits)'
        end
        object Label23: TLabel
          Left = 605
          Top = 251
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
          Left = 605
          Top = 27
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
        object DBlucboMembershipType: TDBLookupComboBox
          Left = 144
          Top = 500
          Width = 320
          Height = 27
          DataField = 'MembershipTypeID'
          DataSource = ManageMemberData.dsMember
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          KeyField = 'MembershipTypeID'
          ListField = 'Caption'
          ListSource = ManageMemberData.dsMembershipType
          NullValueKey = 32776
          ParentFont = False
          TabOrder = 10
        end
        object DBedtMembershipNum: TDBEdit
          Left = 145
          Top = 441
          Width = 124
          Height = 27
          DataField = 'MembershipNum'
          DataSource = ManageMemberData.dsMember
          TabOrder = 9
        end
        object DBchkIsActive: TDBCheckBox
          Left = 144
          Top = 317
          Width = 292
          Height = 17
          Caption = 'Is Active - Indicates full membership. '
          DataField = 'IsActive'
          DataSource = ManageMemberData.dsMember
          TabOrder = 6
        end
        object DBEdtEmail: TDBEdit
          Left = 144
          Top = 564
          Width = 320
          Height = 27
          DataField = 'Email'
          DataSource = ManageMemberData.dsMember
          TabOrder = 12
        end
        object DBlucboHouse: TDBLookupComboBox
          Left = 144
          Top = 602
          Width = 186
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
          Left = 144
          Top = 344
          Width = 344
          Height = 17
          Caption = 'Is Swimmer - Participates in events.'
          DataField = 'IsSwimmer'
          DataSource = ManageMemberData.dsMember
          TabOrder = 7
        end
        object DBchkIsArchived: TDBCheckBox
          Left = 144
          Top = 290
          Width = 255
          Height = 17
          Caption = 'Is Archived - Retired from club.'
          DataField = 'IsArchived'
          DataSource = ManageMemberData.dsMember
          TabOrder = 5
        end
        object btnClearHouse: TButton
          Tag = 3
          Left = 336
          Top = 601
          Width = 75
          Height = 32
          Hint = 'Clear the house name.'
          Caption = 'Clear'
          ImageIndex = 0
          Images = ImageList1
          TabOrder = 14
          OnClick = btnClearClick
        end
        object btnClearMembershipType: TButton
          Tag = 2
          Left = 470
          Top = 500
          Width = 75
          Height = 32
          Hint = 'Clear the house name.'
          Caption = 'Clear'
          ImageIndex = 0
          Images = ImageList1
          TabOrder = 11
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
          Left = 145
          Top = 388
          Width = 184
          Height = 27
          DataField = 'MembershipStr'
          DataSource = ManageMemberData.dsMember
          TabOrder = 8
        end
        object dtpickDOB: TCalendarPicker
          Left = 143
          Top = 128
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
          OnChange = dtpickDOBChange
          ParentFont = False
          TabOrder = 2
          TextHint = 'select a date'
        end
        object DBgridHistoryPB: TDBGrid
          Left = 632
          Top = 251
          Width = 321
          Height = 382
          DataSource = ManageMemberData.dsMemberPB
          TabOrder = 15
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
              Width = 140
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PB'
              Width = 80
              Visible = True
            end>
        end
        object DBgridContactInfo: TDBGrid
          Left = 632
          Top = 27
          Width = 321
          Height = 204
          DataSource = ManageMemberData.dsContactNum
          Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 16
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
          Left = 959
          Top = 27
          Width = 60
          Height = 204
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
          TabOrder = 17
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Member'#39's List'
      ImageIndex = 1
      object DBGrid3: TDBGrid
        Left = 0
        Top = 0
        Width = 1342
        Height = 659
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
        OnCellClick = DBGrid3CellClick
        OnColEnter = DBGrid3ColEnter
        OnColExit = DBGrid3ColExit
        OnDrawColumnCell = DBGrid3DrawColumnCell
        OnEditButtonClick = DBGrid3EditButtonClick
        OnKeyDown = DBGrid3KeyDown
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
            FieldName = 'luMembershipType'
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
        TabOrder = 1
      end
      object btnMemberHistory: TButton
        Left = 3
        Top = 89
        Width = 218
        Height = 38
        Caption = 'Member History'
        TabOrder = 2
      end
      object btnClubMembersDetailed: TButton
        Left = 3
        Top = 274
        Width = 218
        Height = 38
        Caption = 'Club Members Detailed'
        TabOrder = 3
      end
      object btnClubMembersList: TButton
        Left = 3
        Top = 320
        Width = 218
        Height = 38
        Caption = 'Club Members List'
        TabOrder = 4
      end
    end
  end
  object ImageList1: TImageList
    Height = 24
    Width = 24
    Left = 880
    Top = 136
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
  object MainMenu1: TMainMenu
    Left = 936
    Top = 136
    object File2: TMenuItem
      Caption = '&File'
      object AutoEdit1: TMenuItem
        Caption = 'Auto Edit...'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit2: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit2Click
      end
    end
    object Find1: TMenuItem
      Caption = 'Search'
      object GotoMembershipNumber1: TMenuItem
        Caption = 'Goto Membership Number...'
      end
      object GotoMemberID1: TMenuItem
        Caption = 'Goto Member ID...'
      end
      object Find2: TMenuItem
        Caption = 'Find... '
        ShortCut = 16454
        OnClick = Find2Click
      end
    end
    object Help2: TMenuItem
      Caption = '&Help'
      object About2: TMenuItem
        Caption = '&About...'
        OnClick = About2Click
      end
      object Onlinehelp1: TMenuItem
        Caption = 'Online help ...'
        OnClick = Onlinehelp1Click
      end
      object SCMwebsite1: TMenuItem
        Caption = 'SCM website ...'
        OnClick = SCMwebsite1Click
      end
    end
  end
end
