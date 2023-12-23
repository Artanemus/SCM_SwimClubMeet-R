object Preferences: TPreferences
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SwimClubMeet Preferences...'
  ClientHeight = 590
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 646
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 642
    object DBText1: TDBText
      Left = 13
      Top = 9
      Width = 60
      Height = 19
      AutoSize = True
      DataField = 'Caption'
      DataSource = dsSwimClub
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 542
    Width = 646
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 541
    ExplicitWidth = 642
    DesignSize = (
      646
      48)
    object btnClose: TButton
      Left = 476
      Top = 6
      Width = 101
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
      ExplicitLeft = 472
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 646
    Height = 501
    ActivePage = TabSheet6
    Align = alClient
    TabOrder = 2
    OnChanging = PageControl1Changing
    ExplicitWidth = 642
    ExplicitHeight = 500
    object TabSheet1: TTabSheet
      Caption = 'Club'
      object Label2: TLabel
        Left = 50
        Top = 14
        Width = 78
        Height = 21
        Alignment = taRightJustify
        Caption = 'Club Name'
      end
      object Label3: TLabel
        Left = 22
        Top = 49
        Width = 106
        Height = 21
        Alignment = taRightJustify
        Caption = 'Club Nickname'
      end
      object Label4: TLabel
        Left = 87
        Top = 89
        Width = 38
        Height = 21
        Alignment = taRightJustify
        Caption = 'Email'
      end
      object Label5: TLabel
        Left = 13
        Top = 121
        Width = 115
        Height = 21
        Alignment = taRightJustify
        Caption = 'Contact Number'
      end
      object Label6: TLabel
        Left = 71
        Top = 157
        Width = 57
        Height = 21
        Alignment = taRightJustify
        Caption = 'WebSite'
      end
      object Label11: TLabel
        Left = 12
        Top = 211
        Width = 116
        Height = 21
        Alignment = taRightJustify
        Caption = 'Number of lanes'
      end
      object Label12: TLabel
        Left = 50
        Top = 247
        Width = 78
        Height = 21
        Alignment = taRightJustify
        Caption = 'Pool length'
      end
      object Label16: TLabel
        Left = 192
        Top = 248
        Width = 51
        Height = 21
        Alignment = taRightJustify
        Caption = 'Meters.'
      end
      object Label14: TLabel
        Left = 35
        Top = 283
        Width = 93
        Height = 21
        Alignment = taRightJustify
        Caption = 'Season Starts'
      end
      object DBEdit1: TDBEdit
        Left = 134
        Top = 11
        Width = 387
        Height = 29
        DataField = 'Caption'
        DataSource = dsSwimClub
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 134
        Top = 46
        Width = 387
        Height = 29
        DataField = 'NickName'
        DataSource = dsSwimClub
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 134
        Top = 82
        Width = 483
        Height = 29
        DataField = 'Email'
        DataSource = dsSwimClub
        TabOrder = 2
      end
      object DBEdit4: TDBEdit
        Left = 134
        Top = 118
        Width = 203
        Height = 29
        DataField = 'ContactNum'
        DataSource = dsSwimClub
        TabOrder = 3
      end
      object DBEdit5: TDBEdit
        Left = 134
        Top = 153
        Width = 483
        Height = 29
        DataField = 'WebSite'
        DataSource = dsSwimClub
        TabOrder = 4
      end
      object DBEdit9: TDBEdit
        Left = 134
        Top = 208
        Width = 56
        Height = 29
        DataField = 'NumOfLanes'
        DataSource = dsSwimClub
        TabOrder = 5
      end
      object DBEdit10: TDBEdit
        Left = 134
        Top = 244
        Width = 56
        Height = 29
        DataField = 'LenOfPool'
        DataSource = dsSwimClub
        TabOrder = 6
      end
      object dtpStartOfSwimSeason: TDateTimePicker
        Left = 134
        Top = 280
        Width = 186
        Height = 29
        Date = 43786.000000000000000000
        Time = 0.420016226853476800
        TabOrder = 7
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Club Logo'
      ImageIndex = 5
      object Bevel1: TBevel
        Left = 26
        Top = 18
        Width = 318
        Height = 319
        Shape = bsFrame
        Style = bsRaised
      end
      object Label15: TLabel
        Left = 32
        Top = 424
        Width = 306
        Height = 21
        Alignment = taCenter
        AutoSize = False
        Caption = '(PNG, BMP, JPG - min 400x400 pixels,)'
      end
      object btnLoadClubLogo: TButton
        Left = 396
        Top = 18
        Width = 101
        Height = 33
        Caption = 'Load'
        TabOrder = 0
        OnClick = btnLoadClubLogoClick
      end
      object btnClearClubLogo: TButton
        Left = 396
        Top = 96
        Width = 101
        Height = 33
        Caption = 'Clear'
        TabOrder = 1
        OnClick = btnClearClubLogoClick
      end
      object btnSaveClubLogo: TButton
        Left = 396
        Top = 57
        Width = 101
        Height = 33
        Caption = 'Save'
        TabOrder = 2
        OnClick = btnSaveClubLogoClick
      end
      object DBImage1: TDBImage
        Left = 32
        Top = 24
        Width = 306
        Height = 306
        DataSource = dsSwimClub
        Proportional = True
        Stretch = True
        TabOrder = 3
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TTB'
      object Label7: TLabel
        Left = 9
        Top = 201
        Width = 229
        Height = 21
        Caption = 'For entrants without race times ...'
      end
      object Label8: TLabel
        Left = 93
        Top = 285
        Width = 333
        Height = 21
        Caption = 'percent. (With consideration to age and gender.)'
      end
      object lbl2: TLabel
        Left = 9
        Top = 19
        Width = 143
        Height = 17
        Caption = 'Entrant'#39's Time To Beat.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object prefHeatAlgorithm: TRadioGroup
        Left = 9
        Top = 66
        Width = 360
        Height = 111
        Caption = 'Algorithm ... '
        ItemIndex = 1
        Items.Strings = (
          'Use the last known race time.'
          'Use the average of the 3 fastest race times.'
          'Use particpants personal best.')
        TabOrder = 0
      end
      object prefUseDefRaceTime: TCheckBox
        Left = 9
        Top = 232
        Width = 488
        Height = 44
        Caption = 'Calculate a race time based on the mean average of the bottom '
        Checked = True
        State = cbChecked
        TabOrder = 1
        WordWrap = True
      end
      object prefRaceTimeTopPercent: TSpinEdit
        Left = 38
        Top = 282
        Width = 45
        Height = 31
        MaxValue = 100
        MinValue = 0
        TabOrder = 2
        Value = 50
      end
    end
    object tab1: TTabSheet
      Caption = 'AutoBuild'
      ImageIndex = 2
      DesignSize = (
        638
        465)
      object lbl3: TLabel
        Left = 9
        Top = 19
        Width = 110
        Height = 17
        Caption = 'Auto-Build Heats.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object btn1: TSpeedButton
        Left = 145
        Top = 15
        Width = 33
        Height = 33
        Hint = 'Club Members'
        Anchors = [akTop, akRight]
        Flat = True
        Glyph.Data = {
          36090000424D3609000000000000360000002800000018000000180000000100
          2000000000000009000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000004000000330000
          005E000000790000008600000086000000790000005E00000033000000040000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000002F0000007C0000008A0000
          008A0000008A00000089000000890000008A0000008A0000008A0000007C0000
          002F000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000010000004D0000008A0000008A0000006D0000
          003400000011000000010000000100000011000000340000006D0000008A0000
          008A0000004D0000000100000000000000000000000000000000000000000000
          000000000000000000000000004D0000008A0000008500000036000000010000
          0000000000000000000000000000000000000000000000000001000000360000
          00850000008A0000004D00000000000000000000000000000000000000000000
          0000000000000000002F0000008A000000860000002300000000000000000000
          0000000000000000000200000002000000000000000000000000000000000000
          0023000000860000008A0000002F000000000000000000000000000000000000
          0000000000040000007C0000008A000000360000000000000000000000000000
          0000000000000000008800000088000000000000000000000000000000000000
          0000000000360000008A0000007C000000040000000000000000000000000000
          0000000000330000008A0000006D000000010000000000000000000000000000
          0000000000000000008800000088000000000000000000000000000000000000
          0000000000010000006D0000008A000000330000000000000000000000000000
          00000000005E0000008A00000034000000000000000000000000000000000000
          0000000000000000008800000088000000000000000000000000000000000000
          000000000000000000340000008A0000005E0000000000000000000000000000
          0000000000790000008A00000011000000000000000000000000000000000000
          0000000000000000008800000088000000000000000000000000000000000000
          000000000000000000110000008A000000790000000000000000000000000000
          0000000000860000008900000001000000000000000000000000000000000000
          0000000000000000008800000088000000000000000000000000000000000000
          0000000000000000000100000089000000860000000000000000000000000000
          0000000000860000008900000001000000000000000000000000000000000000
          0000000000000000008600000086000000000000000000000000000000000000
          0000000000000000000100000089000000860000000000000000000000000000
          0000000000790000008A00000011000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000110000008A000000790000000000000000000000000000
          00000000005E0000008A00000034000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000340000008A0000005E0000000000000000000000000000
          0000000000330000008A0000006D000000010000000000000000000000000000
          0000000000000000008800000088000000000000000000000000000000000000
          0000000000010000006D0000008A000000330000000000000000000000000000
          0000000000040000007C0000008A000000360000000000000000000000000000
          0000000000000000008800000088000000000000000000000000000000000000
          0000000000360000008A0000007C000000040000000000000000000000000000
          0000000000000000002F0000008A000000850000002300000000000000000000
          0000000000000000000200000002000000000000000000000000000000000000
          0023000000850000008A0000002F000000000000000000000000000000000000
          000000000000000000000000004D0000008A0000008600000036000000010000
          0000000000000000000000000000000000000000000000000001000000360000
          00860000008A0000004D00000000000000000000000000000000000000000000
          00000000000000000000000000010000004D0000008A0000008A0000006D0000
          003400000011000000010000000100000011000000340000006D0000008A0000
          008A0000004D0000000100000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000002F0000007C0000008A0000
          008A0000008A00000089000000890000008A0000008A0000008A0000007C0000
          002F000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000004000000330000
          005E000000790000008600000086000000790000005E00000033000000040000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Layout = blGlyphTop
        Margin = 0
        Visible = False
        ExplicitLeft = 139
      end
      object lblSeedDepth2: TLabel
        Left = 435
        Top = 226
        Width = 73
        Height = 21
        Caption = '(Default 3)'
      end
      object lblSeedDepth1: TLabel
        Left = 298
        Top = 226
        Width = 81
        Height = 21
        Caption = 'Seed depth:'
      end
      object prefSeperateGender: TCheckBox
        Left = 9
        Top = 60
        Width = 163
        Height = 26
        Hint = 'Seperate male and female entrants.'
        Caption = 'Seperate gender.'
        TabOrder = 0
      end
      object prefExcludeOutsideLanes: TCheckBox
        Left = 9
        Top = 92
        Width = 184
        Height = 25
        Hint = 'No swimming in the gutter lanes.'
        Caption = 'Exclude outside lanes.'
        TabOrder = 1
      end
      object prefGroupBy: TRadioGroup
        Left = 9
        Top = 130
        Width = 254
        Height = 175
        Hint = 'Broad categories that gather together entants.'
        Caption = 'Group entrants by ...'
        Items.Strings = (
          'Don'#39't group.'
          'Entrant'#39's age.'
          'Swimming Category.'
          'Divisions.')
        TabOrder = 2
      end
      object rgpSeedMethod: TRadioGroup
        Left = 297
        Top = 130
        Width = 264
        Height = 87
        Hint = 'Decides what lane an entrant is given.'
        Caption = 'Seed Method (scattered using TTB).'
        ItemIndex = 0
        Items.Strings = (
          'SwimClubMeet (default)'
          'Circle Seeding')
        TabOrder = 3
      end
      object spnSeedDepth: TSpinEdit
        Left = 388
        Top = 223
        Width = 41
        Height = 31
        MaxValue = 10
        MinValue = 0
        TabOrder = 4
        Value = 3
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Nominate'
      ImageIndex = 5
      object prefCheckUnNomination: TCheckBox
        Left = 9
        Top = 11
        Width = 584
        Height = 78
        Caption = 
          'If a member has been assigned a lane and then un-nominated, they' +
          ' will be removed from the heat.  When this option is enabled, a ' +
          'warning message will be displayed.'
        TabOrder = 0
        WordWrap = True
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Switches'
      ImageIndex = 6
      object prefEnableTeamEvents: TCheckBox
        Left = 32
        Top = 30
        Width = 241
        Height = 19
        Caption = 'Enable Team Events.'
        Checked = True
        State = cbChecked
        TabOrder = 0
        Visible = False
      end
      object prefEnableDCodes: TCheckBox
        Left = 32
        Top = 64
        Width = 313
        Height = 20
        Caption = 'Enable FINA disqualification codes.'
        TabOrder = 1
      end
      object prefDisplaySwimmerCAT: TCheckBox
        Left = 32
        Top = 98
        Width = 369
        Height = 22
        Caption = 'Display Swimmer Category in the entrant'#39's grid.'
        TabOrder = 2
      end
      object prefDisplayDivisions: TCheckBox
        Left = 32
        Top = 136
        Width = 313
        Height = 22
        Caption = 'Display Divisions in the entrant'#39's grid.'
        TabOrder = 3
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'System'
      ImageIndex = 4
      object Label10: TLabel
        Left = 27
        Top = 13
        Width = 41
        Height = 17
        Caption = 'System'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 27
        Top = 200
        Width = 162
        Height = 17
        Caption = 'On Auto-Build, Inject Data ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 27
        Top = 100
        Width = 60
        Height = 17
        Caption = 'Event Grid'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 27
        Top = 359
        Width = 358
        Height = 34
        AutoSize = False
        Caption = 
          'WARNING : When this option is enabled and an auto-build is perfo' +
          'rmed - param SessionStart TDateTime is set to today'#39's date.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label17: TLabel
        Left = 27
        Top = 311
        Width = 358
        Height = 50
        AutoSize = False
        Caption = 
          'Typically this feature is used to automatically seed member'#39's pe' +
          'rsonal bests into a session. A method to kick-start a newly buil' +
          't SwimClubMeet database. '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object prefImportSeedTime: TRadioGroup
        Left = 27
        Top = 223
        Width = 358
        Height = 82
        Caption = 'Send dbo.Nominee.SeedTime too  ...'
        ItemIndex = 0
        Items.Strings = (
          'DISABLED (Default)'
          'dbo.Entrant.RaceTime')
        TabOrder = 4
      end
      object prefUseWindowsDefTheme: TCheckBox
        Left = 27
        Top = 60
        Width = 238
        Height = 26
        Caption = 'Use Window'#39's default theme.'
        TabOrder = 1
      end
      object prefShowDebugInfo: TCheckBox
        Left = 27
        Top = 32
        Width = 211
        Height = 26
        Caption = 'Show Debug Information.'
        TabOrder = 0
      end
      object prefGenerateEventDescription: TCheckBox
        Left = 27
        Top = 123
        Width = 366
        Height = 17
        Caption = 'Generate an event description for new events.'
        TabOrder = 2
      end
      object prefGenerateEventDescStr: TEdit
        Left = 48
        Top = 146
        Width = 488
        Height = 29
        TabOrder = 3
        Text = ' - Individual, all genders, all ages.'
      end
    end
  end
  object dsSwimClub: TDataSource
    DataSet = qrySwimClub
    Left = 488
    Top = 448
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Load SCM Club Logo'
    Left = 573
    Top = 453
  end
  object tblSystem: TFDTable
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    TableName = 'SwimClubMeet..SCMSystem'
    Left = 488
    Top = 384
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 572
    Top = 385
  end
  object qrySwimClub: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SwimClubID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..SwimClub'
    UpdateOptions.KeyFields = 'SwimClubID'
    SQL.Strings = (
      'Use SwimClubMeet;'
      ''
      'DECLARE @SwimClubID AS INT;'
      'SET @SwimClubID = 1; --:SWIMCLUBID'
      ''
      'DECLARE @Major AS INT;'
      
        'SET @Major = (SELECT Major FROM SwimClubMeet.dbo.SCMSystem WHERE' +
        ' SCMSystemID = 1);'
      'DECLARE @Minor AS INT;'
      
        'SET @Minor = (SELECT Major FROM SwimClubMeet.dbo.SCMSystem WHERE' +
        ' SCMSystemID = 1);'
      ''
      '-- Drop a temporary table called '#39'#TableName'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#TempSCMSwimClub'#39', '#39'U'#39') IS NOT NULL'
      'DROP TABLE #TempSCMSwimClub'
      ';'
      ''
      '/* Get the data into a temp table */'
      '    SELECT * INTO #TempSCMSwimClub'
      '    FROM '
      '    SwimClub WHERE @SwimClubID = @SwimClubID;'
      ''
      '/*'
      'VERSION 1,1,5,0 AND 1,1,5,1 COMPATABILITY'
      '*/'
      ''
      'IF (@Major = 5) AND ((@Minor = 0) OR (@Minor = 1))'
      'BEGIN'
      #9'/* Drop the columns that are not needed */'
      #9'IF COL_LENGTH('#39'SwimClub'#39','#39'LogoDir'#39') IS NOT NULL'
      #9'BEGIN'
      #9'/* Column does exist */'
      #9#9'ALTER TABLE #TempSCMSwimClub'
      #9#9'DROP COLUMN LogoDir'
      #9'END'
      #9'IF COL_LENGTH('#39'SwimClub'#39','#39'LogoImg'#39') IS NOT NULL'
      #9'BEGIN'
      #9'/* Column does exist */'
      #9#9'ALTER TABLE #TempSCMSwimClub'
      #9#9'DROP COLUMN LogoImg'
      #9'END'
      #9'IF COL_LENGTH('#39'SwimClub'#39','#39'LogoType'#39') IS NOT NULL'
      #9'BEGIN'
      #9'/* Column does exist */'
      #9#9'ALTER TABLE #TempSCMSwimClub'
      #9#9'DROP COLUMN LogoType'
      #9'END'
      'END'
      ''
      'SELECT * from #TempSCMSwimClub;')
    Left = 408
    Top = 448
  end
end
