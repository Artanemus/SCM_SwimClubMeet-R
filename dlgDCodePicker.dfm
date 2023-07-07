object DCodePicker: TDCodePicker
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FINA'#39'S Disqualification Codes'
  ClientHeight = 783
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 715
    Width = 534
    Height = 68
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 714
    ExplicitWidth = 530
    object btnOk: TButton
      Left = 348
      Top = 18
      Width = 161
      Height = 33
      Caption = 'OK '
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 181
      Top = 18
      Width = 161
      Height = 33
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnClearCodeExit: TButton
      Left = 14
      Top = 18
      Width = 161
      Height = 33
      Caption = 'Clear Code and Exit'
      TabOrder = 2
      OnClick = btnClearCodeExitClick
    end
  end
  object lvCodes: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 521
    Height = 709
    Margins.Right = 10
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'DCode'
        MaxWidth = 80
      end
      item
        AutoSize = True
        Caption = 'Description'
        MaxWidth = 380
      end
      item
        Caption = 'DCodeID'
        Width = 0
      end
      item
        Caption = 'DCodeTypeID'
        Width = 0
      end>
    Groups = <
      item
        Header = 'GENERAL'
        GroupID = 0
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        Subtitle = 'Common disqualifications.'
        TitleImage = -1
      end
      item
        Header = 'SWIMMING STROKE'
        GroupID = 1
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        Subtitle = 'DCodes for the specific stroke.'
        TitleImage = -1
      end
      item
        Header = 'SCM CODES'
        GroupID = 2
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        Subtitle = 'Extended DCodes for simplified schema.'
        TitleImage = -1
      end>
    IconOptions.AutoArrange = True
    Items.ItemData = {
      05E50000000500000000000000FFFFFFFFFFFFFFFF0100000000000000000000
      000643004F004400450020004100104C006F006E006700200064006500730063
      00720069007000740069006F006E0010E7151500000000FFFFFFFFFFFFFFFF00
      00000000000000000000000643004F00440045002000420000000000FFFFFFFF
      FFFFFFFF0000000000000000000000000643004F004400450020004300000000
      00FFFFFFFFFFFFFFFF00000000010000000000000007530043004F0044004500
      2000410000000000FFFFFFFFFFFFFFFF00000000020000000000000005530043
      004D0020004100FFFF}
    GroupView = True
    RowSelect = True
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    ViewStyle = vsReport
    OnDblClick = lvCodesDblClick
    ExplicitLeft = 8
    ExplicitTop = 0
    ExplicitWidth = 517
    ExplicitHeight = 708
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
    Left = 376
    Top = 24
    ParamData = <
      item
        Name = 'DISQUALIFYTYPEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 3
      end>
  end
  object qryStroke: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE  SwimClubMeet ;'
      ''
      'DECLARE @EntrantID AS INTEGER;'
      'SET @EntrantID = :ENTRANTID;'
      ''
      'SELECT [Event].StrokeID, [Stroke].Caption FROM dbo.Entrant'
      
        'INNER JOIN HeatIndividual ON  Entrant.HeatID = HeatIndividual.He' +
        'atID'
      'INNER JOIN [Event] ON HeatIndividual.EventID = [Event].EventID'
      'INNER JOIN [Stroke] ON [Event].StrokeID = [Stroke].StrokeID'
      'WHERE Entrant.EntrantID = @EntrantID;')
    Left = 376
    Top = 104
    ParamData = <
      item
        Name = 'ENTRANTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
