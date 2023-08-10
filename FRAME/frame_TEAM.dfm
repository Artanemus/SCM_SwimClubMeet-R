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
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitHeight = 290
    object Grid: TDBGrid
      Left = 0
      Top = 0
      Width = 1033
      Height = 234
      Align = alClient
      DataSource = SCM.dsTeam
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
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
    Caption = 'Panel2'
    TabOrder = 1
    object GridEntrant: TDBGrid
      Left = 0
      Top = 0
      Width = 1033
      Height = 241
      Align = alClient
      DataSource = SCM.dsTeamEntrant
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
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
