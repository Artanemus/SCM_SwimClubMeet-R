object QualifyTimes: TQualifyTimes
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Qualification Times...'
  ClientHeight = 680
  ClientWidth = 621
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 17
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 621
    Height = 639
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 617
    ExplicitHeight = 638
    object TabSheet1: TTabSheet
      Caption = 'Setup'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 132
        Width = 613
        Height = 475
        Align = alClient
        Options = [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
      object Panel1: TPanel
        Left = 0
        Top = 99
        Width = 613
        Height = 33
        Align = alTop
        TabOrder = 1
        ExplicitWidth = 609
        DesignSize = (
          613
          33)
        object Label3: TLabel
          Left = 4
          Top = 8
          Width = 602
          Height = 19
          Alignment = taCenter
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = 'Qualification Times for Short Course Events (SC)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 381
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 613
        Height = 99
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitWidth = 609
        object Label4: TLabel
          Left = 26
          Top = 25
          Width = 64
          Height = 51
          Alignment = taCenter
          Caption = 'The distance to QUALIFY.'
          WordWrap = True
        end
        object Label5: TLabel
          Left = 200
          Top = 25
          Width = 51
          Height = 51
          Alignment = taCenter
          Caption = 'The TRIAL distance.'
          WordWrap = True
        end
        object Label6: TLabel
          Left = 346
          Top = 25
          Width = 88
          Height = 68
          Alignment = taCenter
          Caption = 'The TIME the TRIAL distance must be completed in.'
          WordWrap = True
        end
        object Label7: TLabel
          Left = 112
          Top = 41
          Width = 59
          Height = 34
          Alignment = taCenter
          Caption = 'Swimming Stroke'
          WordWrap = True
        end
        object Label8: TLabel
          Left = 280
          Top = 45
          Width = 43
          Height = 17
          Alignment = taCenter
          Caption = 'Gender'
          WordWrap = True
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Reports'
      ImageIndex = 1
      object Label1: TLabel
        Left = 92
        Top = 90
        Width = 513
        Height = 39
        AutoSize = False
        Caption = 
          'Post-Session : Highlight qualified swimmers in the current sessi' +
          'on. Ordered by name.'
        WordWrap = True
      end
      object Label2: TLabel
        Left = 92
        Top = 187
        Width = 514
        Height = 39
        AutoSize = False
        Caption = 
          'Display a qualification report for each club member. Ordered by ' +
          #39'last name'#39'.'
        WordWrap = True
      end
      object Label10: TLabel
        Left = 92
        Top = 232
        Width = 514
        Height = 39
        AutoSize = False
        Caption = 
          'Display a summary of club members who have qualified. Ordered by' +
          ' distance and stroke.'
        WordWrap = True
      end
      object Label12: TLabel
        Left = 92
        Top = 285
        Width = 514
        Height = 26
        AutoSize = False
        Caption = 
          'Prepare a report of the qualification times table, ready for pri' +
          'nting.'
        WordWrap = True
      end
      object Label9: TLabel
        Left = 91
        Top = 43
        Width = 514
        Height = 36
        AutoSize = False
        Caption = 
          'Post-Nomination : List members who have nominated for events in ' +
          'the current session but are not qualified to swim those events.'
        WordWrap = True
      end
      object Label11: TLabel
        Left = 11
        Top = 20
        Width = 224
        Height = 17
        Caption = 'REPORTS FOR THE CURRENT SESSION'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 11
        Top = 164
        Width = 156
        Height = 17
        Caption = 'OTHER GENERAL REPORTS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object btnSessionReport: TButton
        Left = 11
        Top = 91
        Width = 75
        Height = 25
        Caption = 'Session'
        TabOrder = 1
        OnClick = btnSessionReportClick
      end
      object btnMemberReport: TButton
        Left = 11
        Top = 187
        Width = 75
        Height = 25
        Caption = 'Member'
        TabOrder = 2
        OnClick = btnMemberReportClick
      end
      object btnDistStrokeReport: TButton
        Left = 11
        Top = 232
        Width = 75
        Height = 25
        Caption = 'Dist:Stroke'
        TabOrder = 3
        OnClick = btnDistStrokeReportClick
      end
      object btnTableReport: TButton
        Left = 11
        Top = 285
        Width = 75
        Height = 25
        Caption = 'Table'
        TabOrder = 4
        OnClick = btnTableReportClick
      end
      object btnNotQualifyReport: TButton
        Left = 11
        Top = 43
        Width = 75
        Height = 41
        Caption = 'Not Qualified'
        TabOrder = 0
        WordWrap = True
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 639
    Width = 621
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 638
    ExplicitWidth = 617
    DesignSize = (
      621
      41)
    object BtnClose: TButton
      Left = 527
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = BtnCloseClick
      ExplicitLeft = 523
    end
  end
  object qryQualify: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'QualifyID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Qualify'
    UpdateOptions.KeyFields = 'QualifyID'
    SQL.Strings = (
      'SELECT'
      '  Qualify.TrialDistID,'
      '  Qualify.QualifyDistID,'
      '  Qualify.StrokeID,'
      '  Qualify.TrialTime,'
      '  Qualify.IsShortCourse,'
      '  Qualify.GenderID,'
      '  Qualify.QualifyID'
      'FROM'
      '  Qualify'
      'WHERE (Qualify.IsShortCourse = :ISSHORTCOURSE)')
    Left = 104
    Top = 496
    ParamData = <
      item
        Name = 'ISSHORTCOURSE'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end>
    object qryQualifyTrialDistID: TIntegerField
      FieldName = 'TrialDistID'
      Origin = 'TrialDistID'
      Visible = False
    end
    object qryQualifyQualifyDistID: TIntegerField
      FieldName = 'QualifyDistID'
      Origin = 'QualifyDistID'
      Visible = False
    end
    object qryQualifyStrokeID: TIntegerField
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
      Visible = False
    end
    object qryQualifyIsShortCourse: TBooleanField
      FieldName = 'IsShortCourse'
      Origin = 'IsShortCourse'
      Visible = False
    end
    object qryQualifyGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
      Visible = False
    end
    object qryQualifyQualifyID: TFDAutoIncField
      FieldName = 'QualifyID'
      Origin = 'QualifyID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object qryQualifyluQDistance: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'QDistance'
      DisplayWidth = 9
      FieldKind = fkLookup
      FieldName = 'luQDistance'
      LookupDataSet = tblQDistance
      LookupKeyFields = 'DistanceID'
      LookupResultField = 'Caption'
      KeyFields = 'QualifyDistID'
      Lookup = True
    end
    object qryQualifyluStroke: TStringField
      DisplayLabel = 'Stroke'
      DisplayWidth = 16
      FieldKind = fkLookup
      FieldName = 'luStroke'
      LookupDataSet = tblStroke
      LookupKeyFields = 'StrokeID'
      LookupResultField = 'Caption'
      KeyFields = 'StrokeID'
      Lookup = True
    end
    object qryQualifyluTDistance: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'TDistance'
      DisplayWidth = 9
      FieldKind = fkLookup
      FieldName = 'luTDistance'
      LookupDataSet = tblTDistance
      LookupKeyFields = 'DistanceID'
      LookupResultField = 'Caption'
      KeyFields = 'TrialDistID'
      Lookup = True
    end
    object qryQualifyluGender: TStringField
      Alignment = taCenter
      DisplayLabel = 'Gender'
      DisplayWidth = 12
      FieldKind = fkLookup
      FieldName = 'luGender'
      LookupDataSet = tblGender
      LookupKeyFields = 'GenderID'
      LookupResultField = 'Caption'
      KeyFields = 'GenderID'
      Lookup = True
    end
    object qryQualifyTrialTime: TTimeField
      Alignment = taRightJustify
      DisplayLabel = 'TIME'
      FieldName = 'TrialTime'
      Origin = 'TrialTime'
      OnGetText = qryQualifyTrialTimeGetText
      OnSetText = qryQualifyTrialTimeSetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
  end
  object DSQualify: TDataSource
    DataSet = qryQualify
    Left = 168
    Top = 496
  end
  object tblQDistance: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'DistanceID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Distance'
    TableName = 'SwimClubMeet..Distance'
    Left = 288
    Top = 504
  end
  object tblStroke: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'StrokeID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Stroke'
    TableName = 'SwimClubMeet..Stroke'
    Left = 360
    Top = 504
  end
  object tblGender: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'GenderID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Gender'
    TableName = 'SwimClubMeet..Gender'
    Left = 360
    Top = 560
  end
  object tblTDistance: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'DistanceID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Distance'
    TableName = 'SwimClubMeet..Distance'
    Left = 288
    Top = 560
  end
end
