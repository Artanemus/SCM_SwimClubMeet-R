object SplitTime: TSplitTime
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'RaceTime and SplitTimes'
  ClientHeight = 448
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 249
    Height = 49
    Align = alTop
    BevelEdges = [beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 416
    object Label1: TLabel
      Left = 11
      Top = 15
      Width = 67
      Height = 21
      Caption = 'RaceTime'
    end
    object DBEdit1: TDBEdit
      Left = 91
      Top = 12
      Width = 153
      Height = 29
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 249
    Height = 343
    Align = alClient
    BevelEdges = []
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 41
    ExplicitWidth = 567
    ExplicitHeight = 366
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 182
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
          FieldName = 'SplitTime'
          Title.Alignment = taCenter
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TeamName'
          Visible = False
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
      Left = 177
      Top = 0
      Width = 72
      Height = 343
      Align = alRight
      Kind = dbnVertical
      TabOrder = 1
      ExplicitLeft = 344
      ExplicitHeight = 358
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 392
    Width = 249
    Height = 56
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 322
    object Button1: TButton
      Left = 164
      Top = 12
      Width = 75
      Height = 34
      Caption = 'Close'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object qryTeamSplit: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'TeamSplitID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.TeamName'
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
      'SplitTime, '
      'TeamSplit.TeamID,'
      'TeamName.Caption AS TeamName'
      'FROM '
      'TeamSplit'
      'INNER JOIN Team ON TeamSplit.TeamID = Team.TeamID'
      'LEFT JOIN TeamName ON Team.TeamNameID = TeamName.TeamNameID'
      ''
      ';'
      '')
    Left = 144
    Top = 232
    ParamData = <
      item
        Name = 'TEAMID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qryTeamSplitSplitTime: TTimeField
      DisplayLabel = 'Split-Time'
      DisplayWidth = 10
      FieldName = 'SplitTime'
      Origin = 'SplitTime'
    end
    object qryTeamSplitTeamName: TWideStringField
      FieldName = 'TeamName'
      Origin = 'TeamName'
      Size = 64
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
    Left = 144
    Top = 161
  end
end
