object SplitTime: TSplitTime
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'RaceTime and SplitTimes'
  ClientHeight = 448
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 49
    Align = alTop
    BevelEdges = [beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 245
    object Label1: TLabel
      Left = 44
      Top = 15
      Width = 67
      Height = 21
      Caption = 'RaceTime'
    end
    object DBEdit1: TDBEdit
      Left = 117
      Top = 14
      Width = 153
      Height = 29
      DataField = 'RaceTime'
      DataSource = dsTeam
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 321
    Height = 343
    Align = alClient
    BevelEdges = []
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 245
    ExplicitHeight = 342
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 241
      Height = 337
      Align = alLeft
      DataSource = dsTeamSplit
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
          FieldName = 'TeamSplitID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TeamID'
          Visible = False
        end>
    end
    object DBNavigator1: TDBNavigator
      Left = 249
      Top = 0
      Width = 72
      Height = 343
      DataSource = dsTeamSplit
      Align = alRight
      Kind = dbnVertical
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      ExplicitLeft = 173
      ExplicitHeight = 342
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 392
    Width = 321
    Height = 56
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 391
    ExplicitWidth = 245
    object btnPost: TButton
      Left = 163
      Top = 10
      Width = 75
      Height = 34
      Caption = 'Post'
      TabOrder = 0
      OnClick = btnPostClick
    end
    object btnCancel: TButton
      Left = 82
      Top = 10
      Width = 75
      Height = 34
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object qryTeamSplit: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    OnNewRecord = qryTeamSplitNewRecord
    IndexFieldNames = 'TeamSplitID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.TeamSplit'
    UpdateOptions.KeyFields = 'TeamSplitID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ';'
      ''
      'DECLARE @TeamID AS INTEGER;'
      'SET @TeamID = :TEAMID'
      ''
      'SELECT  '
      'TeamSplitID, '
      'LapNum,'
      'SplitTime, '
      'TeamSplit.TeamID'
      'FROM '
      'TeamSplit'
      'WHERE TeamID = @TeamID'
      ''
      ';'
      '')
    Left = 32
    Top = 264
    ParamData = <
      item
        Name = 'TEAMID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qryTeamSplitLapNum: TIntegerField
      DisplayLabel = 'Lap'
      DisplayWidth = 6
      FieldName = 'LapNum'
      Origin = 'LapNum'
    end
    object qryTeamSplitSplitTime: TTimeField
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
    object qryTeamSplitTeamSplitID: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 4
      FieldName = 'TeamSplitID'
      Origin = 'TeamSplitID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryTeamSplitTeamID: TIntegerField
      DisplayWidth = 12
      FieldName = 'TeamID'
      Origin = 'TeamID'
    end
  end
  object dsTeamSplit: TDataSource
    DataSet = qryTeamSplit
    Left = 88
    Top = 265
  end
  object qryTeam: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'TeamID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.Team'
    UpdateOptions.KeyFields = 'TeamID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ';'
      'DECLARE @TeamID AS INTEGER;'
      'SET @TeamID = :TEAMID;'
      ''
      'Select '
      'Team.TeamID'
      ',RaceTime'
      ',TeamName.Caption AS TeamNameStr'
      ' FROM Team'
      ' LEFT JOIN TeamName ON Team.TeamNameID = TeamName.TeamNameID'
      ' WHERE TeamID = @TeamID'
      ' ;')
    Left = 32
    Top = 209
    ParamData = <
      item
        Name = 'TEAMID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 11
      end>
    object qryTeamTeamID: TFDAutoIncField
      FieldName = 'TeamID'
      Origin = 'TeamID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryTeamRaceTime: TTimeField
      Alignment = taRightJustify
      FieldName = 'RaceTime'
      Origin = 'RaceTime'
      OnGetText = TimeFieldGetText
      OnSetText = TimeFieldSetText
      DisplayFormat = 'nn:ss.zzz'
      EditMask = '!00:00.000;1;0'
    end
    object qryTeamTeamNameStr: TWideStringField
      FieldName = 'TeamNameStr'
      Origin = 'TeamNameStr'
      Size = 64
    end
  end
  object dsTeam: TDataSource
    DataSet = qryTeam
    Left = 88
    Top = 208
  end
end
