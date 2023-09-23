object TeamNamePicker: TTeamNamePicker
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Relay Team Picker'
  ClientHeight = 292
  ClientWidth = 222
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 21
  object Grid: TDBGrid
    Left = 0
    Top = 0
    Width = 222
    Height = 255
    Align = alClient
    DataSource = dsTeamNames
    Options = [dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = GridDblClick
  end
  object RelativePanel1: TRelativePanel
    Left = 0
    Top = 255
    Width = 222
    Height = 37
    ControlCollection = <
      item
        Control = btnOk
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = True
        AlignRightWithPanel = True
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = True
      end>
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 301
    DesignSize = (
      222
      37)
    object btnOk: TButton
      AlignWithMargins = True
      Left = 4
      Top = 3
      Width = 214
      Height = 30
      Margins.Left = 4
      Margins.Top = 0
      Margins.Right = 4
      Anchors = []
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
  object qryTeamNames: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'TeamNameID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @EventID AS INTEGER;'
      'SET @EventID = :EVENTID;'
      ''
      'SELECT '
      'TeamName.TeamNameID,'
      'TeamName.Caption AS strTeamName'
      'FROM TeamName'
      'WHERE NOT EXISTS ('
      '    SELECT '
      '          TeamName.TeamNameID'
      ' '
      '    FROM TeamName AS tbl2'
      '    INNER JOIN Team ON TeamName.TeamNameID = Team.TeamNameID'
      
        '    INNER JOIN HeatIndividual ON Team.HeatID = HeatIndividual.He' +
        'atID'
      
        '    INNER JOIN [Event] ON HeatIndividual.EventID = [Event].Event' +
        'ID'
      
        '    WHERE [Event].EventID = @EventID AND TeamName.TeamNameID = t' +
        'bl2.TeamNameID'
      ');'
      ''
      ''
      '/*'
      'SELECT *'
      'FROM table1'
      'WHERE NOT EXISTS ('
      '    SELECT *'
      '    FROM table2'
      '    WHERE table1.id = table2.id'
      ');'
      '*/'
      '')
    Left = 120
    Top = 32
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryTeamNamesTeamNameID: TFDAutoIncField
      FieldName = 'TeamNameID'
      Origin = 'TeamNameID'
      ReadOnly = True
      Visible = False
    end
    object qryTeamNamesstrTeamName: TWideStringField
      DisplayLabel = 'Relay Team Name'
      DisplayWidth = 20
      FieldName = 'strTeamName'
      Origin = 'strTeamName'
      Size = 64
    end
  end
  object dsTeamNames: TDataSource
    DataSet = qryTeamNames
    Left = 120
    Top = 88
  end
end
