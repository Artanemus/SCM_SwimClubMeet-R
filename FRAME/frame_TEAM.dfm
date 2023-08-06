object frameTEAM: TframeTEAM
  Left = 0
  Top = 0
  Width = 1033
  Height = 600
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 0
    Top = 209
    Width = 1033
    Height = 10
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 845
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1033
    Height = 209
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object Grid: TDBGrid
      Left = 0
      Top = 0
      Width = 1033
      Height = 209
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 219
    Width = 1033
    Height = 381
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 1
    object GridEntrant: TDBGrid
      Left = 0
      Top = 0
      Width = 1033
      Height = 381
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
end
