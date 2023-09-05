object AutoBuild_Relay: TAutoBuild_Relay
  Left = 0
  Top = 0
  Caption = 'AutoBuild Selected Relay ...'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel2: TPanel
    Left = 0
    Top = 395
    Width = 624
    Height = 46
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 508
    object btnCancel: TButton
      Left = 257
      Top = 6
      Width = 75
      Height = 27
      Cancel = True
      Caption = 'No'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOk: TButton
      Left = 176
      Top = 6
      Width = 75
      Height = 27
      Caption = 'Yes'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
  end
end
