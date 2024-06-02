object MemberClub: TMemberClub
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Select Swimming Club ...'
  ClientHeight = 275
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  TextHeight = 21
  object chklstSwimClub: TCheckListBox
    AlignWithMargins = True
    Left = 3
    Top = 10
    Width = 335
    Height = 209
    Margins.Top = 10
    Margins.Bottom = 10
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
  end
  object Panel1: TPanel
    Left = 0
    Top = 229
    Width = 341
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object btnOk: TButton
      Left = 133
      Top = 7
      Width = 75
      Height = 32
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOkClick
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
    Left = 176
    Top = 40
  end
  object dsSwimClub: TDataSource
    DataSet = qrySwimClub
    Left = 248
    Top = 40
  end
end
