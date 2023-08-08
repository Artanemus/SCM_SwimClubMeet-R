object frameTEAM: TframeTEAM
  Left = 0
  Top = 0
  Width = 1033
  Height = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 0
    Top = 290
    Width = 1033
    Height = 14
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 288
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1033
    Height = 290
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitHeight = 209
    object Grid: TDBGrid
      Left = 0
      Top = 0
      Width = 1033
      Height = 290
      Align = alClient
      DataSource = SCM.dsTeam
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 304
    Width = 1033
    Height = 296
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 1
    object GridEntrant: TDBGrid
      Left = 0
      Top = 0
      Width = 1033
      Height = 296
      Align = alClient
      DataSource = SCM.dsTeamEntrant
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
end
