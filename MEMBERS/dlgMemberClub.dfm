object MemberClub: TMemberClub
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Select Swimming Club ...'
  ClientHeight = 221
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  TextHeight = 21
  object chklstSwimClub: TCheckListBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 307
    Height = 215
    Align = alClient
    BorderStyle = bsNone
    CheckBoxPadding = 8
    ItemHeight = 29
    Items.Strings = (
      'ALL CLUBS (Displays all members)'
      'SwimClub1'
      'SwimClub2'
      'SwimClub3'
      'SwimClub4'
      'NONE (Members not assigned a club)')
    TabOrder = 0
    OnClickCheck = chklstSwimClubClickCheck
    ExplicitLeft = -2
    ExplicitTop = -2
  end
  object qrySwimClub: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    ConnectionName = 'MSSQL_SwimClubMeet'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'Select SwimClubID, Caption FROM SwimClub ORDER BY SwimClubID ASC')
    Left = 232
    Top = 48
  end
end
