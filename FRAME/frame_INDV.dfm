object frameINDV: TframeINDV
  Left = 0
  Top = 0
  Width = 1075
  Height = 324
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Grid: TDBGrid
    Left = 0
    Top = 0
    Width = 1075
    Height = 324
    Margins.Left = 60
    Align = alClient
    Anchors = []
    DataSource = SCM.dsEntrant
    DefaultDrawing = False
    GradientEndColor = 14079702
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
    OnKeyDown = GridKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'Lane'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FullName'
        Width = 340
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RaceTime'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TimeToBeat'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PersonalBest'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IsScratched'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IsDisqualified'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DCode'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'luCategory'
        Visible = True
      end>
  end
end
