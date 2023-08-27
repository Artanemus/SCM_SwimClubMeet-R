object SwapLanes: TSwapLanes
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Swap Lanes ...'
  ClientHeight = 156
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  TextHeight = 19
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 660
    Height = 109
    Align = alClient
    TabOrder = 0
    ExplicitTop = 8
    ExplicitWidth = 705
    ExplicitHeight = 110
    object Label1: TLabel
      Left = 19
      Top = 23
      Width = 43
      Height = 19
      Alignment = taRightJustify
      Caption = 'Heat :'
    end
    object Label2: TLabel
      Left = 19
      Top = 71
      Width = 43
      Height = 19
      Alignment = taRightJustify
      Caption = 'Heat :'
    end
    object Label3: TLabel
      Left = 202
      Top = 23
      Width = 44
      Height = 19
      Alignment = taRightJustify
      Caption = 'Lane :'
    end
    object Label4: TLabel
      Left = 202
      Top = 71
      Width = 44
      Height = 19
      Alignment = taRightJustify
      Caption = 'Lane :'
    end
    object Shape1: TShape
      Left = 32
      Top = 57
      Width = 600
      Height = 4
    end
    object DBText1: TDBText
      Left = 413
      Top = 23
      Width = 89
      Height = 17
      Alignment = taRightJustify
      DataField = 'FirstName'
      DataSource = dsFNameA
    end
    object DBText2: TDBText
      Left = 413
      Top = 71
      Width = 89
      Height = 17
      Alignment = taRightJustify
      DataField = 'FirstName'
      DataSource = dsFNameB
    end
    object DBText3: TDBText
      Left = 508
      Top = 23
      Width = 71
      Height = 19
      AutoSize = True
      DataField = 'LastName'
      DataSource = dsFNameA
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText4: TDBText
      Left = 508
      Top = 71
      Width = 71
      Height = 19
      AutoSize = True
      DataField = 'LastName'
      DataSource = dsFNameB
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText5: TDBText
      Left = 68
      Top = 23
      Width = 33
      Height = 21
      Alignment = taCenter
      Color = clBtnHighlight
      DataField = 'HeatNum'
      DataSource = dsHeatA
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object DBText6: TDBText
      Left = 68
      Top = 71
      Width = 33
      Height = 21
      Alignment = taCenter
      Color = clBtnHighlight
      DataField = 'HeatNum'
      DataSource = dsHeatB
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object DBText7: TDBText
      Left = 252
      Top = 23
      Width = 33
      Height = 21
      Alignment = taCenter
      Color = clBtnHighlight
      DataField = 'Lane'
      DataSource = dsEntrantA
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object DBText8: TDBText
      Left = 252
      Top = 71
      Width = 33
      Height = 21
      Alignment = taCenter
      Color = clBtnHighlight
      DataField = 'Lane'
      DataSource = dsEntrantB
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object DBNavigator1: TDBNavigator
      Left = 107
      Top = 19
      Width = 68
      Height = 32
      DataSource = dsHeatA
      VisibleButtons = [nbPrior, nbNext]
      TabOrder = 0
    end
    object DBNavigator2: TDBNavigator
      Left = 107
      Top = 67
      Width = 68
      Height = 32
      DataSource = dsHeatB
      VisibleButtons = [nbPrior, nbNext]
      TabOrder = 2
    end
    object DBNavigator3: TDBNavigator
      Left = 291
      Top = 67
      Width = 68
      Height = 32
      DataSource = dsEntrantB
      VisibleButtons = [nbPrior, nbNext]
      TabOrder = 3
    end
    object DBNavigator4: TDBNavigator
      Left = 291
      Top = 19
      Width = 68
      Height = 32
      DataSource = dsEntrantA
      VisibleButtons = [nbPrior, nbNext]
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 109
    Width = 660
    Height = 47
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 110
    ExplicitWidth = 705
    DesignSize = (
      660
      47)
    object btnCancel: TButton
      Left = 395
      Top = 6
      Width = 91
      Height = 35
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
      ExplicitLeft = 444
    end
    object btnSwapLanes: TButton
      Left = 492
      Top = 6
      Width = 108
      Height = 35
      Anchors = [akTop, akRight]
      Caption = 'Swap Lanes'
      Default = True
      ModalResult = 1
      TabOrder = 1
      OnClick = btnSwapLanesClick
      ExplicitLeft = 500
    end
  end
  object tblEntrantA: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HeatID;Lane:A'
    MasterSource = dsHeatA
    MasterFields = 'HeatID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Entrant'
    UpdateOptions.KeyFields = 'EntrantID'
    TableName = 'SwimClubMeet..Entrant'
    Left = 344
    Top = 16
  end
  object tblEntrantB: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HeatID;Lane:A'
    MasterSource = dsHeatB
    MasterFields = 'HeatID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Entrant'
    UpdateOptions.KeyFields = 'EntrantID'
    TableName = 'SwimClubMeet..Entrant'
    Left = 296
    Top = 56
  end
  object tblHeatA: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EventID;HeatNum:A'
    MasterSource = dsEvent
    MasterFields = 'EventID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..HeatIndividual'
    UpdateOptions.KeyFields = 'HeatID'
    TableName = 'SwimClubMeet..HeatIndividual'
    Left = 160
    Top = 8
  end
  object tblHeatB: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EventID;HeatNum:A'
    MasterSource = dsEvent
    MasterFields = 'EventID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..HeatIndividual'
    UpdateOptions.KeyFields = 'HeatID'
    TableName = 'SwimClubMeet..HeatIndividual'
    Left = 160
    Top = 56
  end
  object tblEvent: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EventID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Event'
    UpdateOptions.KeyFields = 'EventID'
    TableName = 'SwimClubMeet..Event'
    Left = 24
    Top = 8
  end
  object dsHeatA: TDataSource
    DataSet = tblHeatA
    Left = 200
    Top = 8
  end
  object dsEvent: TDataSource
    DataSet = tblEvent
    Left = 64
    Top = 8
  end
  object dsHeatB: TDataSource
    DataSet = tblHeatB
    Left = 200
    Top = 56
  end
  object dsEntrantB: TDataSource
    DataSet = tblEntrantB
    Left = 352
    Top = 56
  end
  object dsEntrantA: TDataSource
    DataSet = tblEntrantA
    Left = 400
    Top = 16
  end
  object tblFNameB: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    MasterSource = dsEntrantB
    MasterFields = 'MemberID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    TableName = 'SwimClubMeet..Member'
    Left = 448
    Top = 56
  end
  object tblFNameA: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    MasterSource = dsEntrantA
    MasterFields = 'MemberID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    TableName = 'SwimClubMeet..Member'
    Left = 496
    Top = 16
  end
  object dsFNameA: TDataSource
    DataSet = tblFNameA
    Left = 560
    Top = 16
  end
  object dsFNameB: TDataSource
    DataSet = tblFNameB
    Left = 512
    Top = 56
  end
end
