object frameTEAM: TframeTEAM
  Left = 0
  Top = 0
  Width = 1033
  Height = 489
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 0
    Top = 234
    Width = 1033
    Height = 14
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 288
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1033
    Height = 234
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 2
    Caption = 'Panel1'
    Color = clMaroon
    ParentBackground = False
    TabOrder = 0
    StyleElements = [seFont]
    object Grid: TDBGrid
      Left = 2
      Top = 2
      Width = 1029
      Height = 230
      Align = alClient
      DataSource = SCM.dsTeam
      DefaultDrawing = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = GridCellClick
      OnColEnter = GridColEnter
      OnColExit = GridColExit
      OnDrawColumnCell = GridDrawColumnCell
      OnEditButtonClick = GridEditButtonClick
      OnEnter = GridEnter
      Columns = <
        item
          Expanded = False
          FieldName = 'Lane'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TeamName'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RaceTime'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TimeToBeat'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IsScratched'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IsDisqualified'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DCode'
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 248
    Width = 1033
    Height = 241
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 2
    Caption = 'Panel2'
    Color = clMaroon
    ParentBackground = False
    TabOrder = 1
    StyleElements = [seFont]
    object GridEntrant: TDBGrid
      Left = 2
      Top = 2
      Width = 1029
      Height = 237
      Align = alClient
      DataSource = SCM.dsTeamEntrant
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnEditButtonClick = GridEntrantEditButtonClick
      OnEnter = GridEntrantEnter
      Columns = <
        item
          Expanded = False
          FieldName = 'SwimOrder'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FullName'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RaceTime'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TimeToBeat'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PersonalBest'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'luStroke'
          Visible = True
        end>
    end
  end
end
