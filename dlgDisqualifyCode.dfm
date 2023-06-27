object DisqualifyCode: TDisqualifyCode
  Left = 0
  Top = 0
  Caption = 'Disqualification Codes'
  ClientHeight = 509
  ClientWidth = 917
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 21
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 24
    Width = 433
    Height = 313
    Caption = 'GENERAL'
    TabOrder = 0
  end
  object RadioGroup2: TRadioGroup
    Left = 464
    Top = 24
    Width = 433
    Height = 388
    Caption = 'Specific to Stroke'
    TabOrder = 1
  end
  object RadioGroup3: TRadioGroup
    Left = 8
    Top = 355
    Width = 433
    Height = 57
    Caption = 'SwimClubMeet special codes'
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 441
    Width = 917
    Height = 68
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 560
    ExplicitWidth = 1109
    object Button1: TButton
      Left = 710
      Top = 18
      Width = 161
      Height = 33
      Caption = 'OK '
      TabOrder = 0
    end
    object Button2: TButton
      Left = 543
      Top = 18
      Width = 161
      Height = 33
      Caption = 'Cancel'
      TabOrder = 1
    end
    object Button3: TButton
      Left = 14
      Top = 18
      Width = 161
      Height = 33
      Caption = 'Clear Selected'
      TabOrder = 2
    end
  end
  object qryDisqualifyCode: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    DetailFields = 'DisqualifyCodeID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'DisqualifyCodeID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @DisqualifyTypeID AS INTEGER;'
      ''
      'SET @DisqualifyTypeID = :DISQUALIFYTYPEID'
      ''
      'SELECT [DisqualifyCodeID]'
      '     , [DisqualifyCode].[Caption] AS DCodeStr'
      '     , ABREV'
      '     , [DisqualifyType].[DisqualifyTypeID]'
      '     , [DisqualifyType].[Caption] AS TypeStr'
      'FROM DisqualifyCode'
      '    LEFT JOIN DisqualifyType'
      
        '        ON [DisqualifyCode].[DisqualifyTypeID] = [DisqualifyType' +
        '].[DisqualifyTypeID]'
      'WHERE [DisqualifyCode].[DisqualifyTypeID] = @DisqualifyTypeID'
      '      OR [DisqualifyCode].[DisqualifyTypeID] = 1'
      '      OR [DisqualifyCode].[DisqualifyTypeID] = 8'
      'ORDER BY [DisqualifyCode].[DisqualifyTypeID];')
    Left = 440
    Top = 232
    ParamData = <
      item
        Name = 'DISQUALIFYTYPEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 3
      end>
  end
end
