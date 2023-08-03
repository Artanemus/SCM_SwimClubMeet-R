object EventIndvFrame: TEventIndvFrame
  Left = 0
  Top = 0
  Width = 1075
  Height = 582
  TabOrder = 0
  object Entrant_Grid: TDBGrid
    Left = 0
    Top = 0
    Width = 1075
    Height = 582
    Margins.Left = 60
    Align = alClient
    Anchors = []
    DataSource = SCM.dsEntrant
    DefaultDrawing = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = Entrant_GridCellClick
    OnColEnter = Entrant_GridColEnter
    OnColExit = Entrant_GridColExit
    OnDrawColumnCell = Entrant_GridDrawColumnCell
    OnEditButtonClick = Entrant_GridEditButtonClick
    OnEnter = Entrant_GridEnter
    OnKeyDown = Entrant_GridKeyDown
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
