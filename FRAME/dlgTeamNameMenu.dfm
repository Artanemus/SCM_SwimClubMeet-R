object TeamNameMenu: TTeamNameMenu
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Team Name '
  ClientHeight = 251
  ClientWidth = 210
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 21
  object btnCreateNewTeam: TButton
    Left = 8
    Top = 16
    Width = 193
    Height = 41
    Caption = 'Create Relay Team'
    TabOrder = 0
    OnClick = btnCreateNewTeamClick
  end
  object btnRenameTeam: TButton
    Left = 8
    Top = 63
    Width = 193
    Height = 41
    Caption = 'Rename Team'
    TabOrder = 1
  end
  object btnClearTeam: TButton
    Left = 8
    Top = 110
    Width = 193
    Height = 41
    Caption = 'Clear Team from Lane'
    TabOrder = 2
  end
  object btnStrikeTeam: TButton
    Left = 8
    Top = 157
    Width = 193
    Height = 41
    Caption = 'Strike Team from Lane'
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 8
    Top = 204
    Width = 193
    Height = 41
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = btnCancelClick
  end
end
