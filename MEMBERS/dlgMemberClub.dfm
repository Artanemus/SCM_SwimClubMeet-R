object MemberClub: TMemberClub
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Select Swimming Club ...'
  ClientHeight = 479
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 21
  object chklstSwimClub: TCheckListBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 347
    Height = 418
    Align = alClient
    CheckBoxPadding = 6
    ItemHeight = 27
    Items.Strings = (
      'ALL CLUBS (Displays all members)'
      'SwimClub1'
      'SwimClub2'
      'SwimClub3'
      'SwimClub4'
      'NONE (Members not assigned a club)')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 424
    Width = 353
    Height = 55
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object btnOk: TButton
      Left = 123
      Top = 11
      Width = 107
      Height = 34
      Caption = 'OK'
      TabOrder = 0
    end
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
    Left = 80
    Top = 272
  end
end
