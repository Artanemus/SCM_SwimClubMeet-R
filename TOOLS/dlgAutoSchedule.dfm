object AutoSchedule: TAutoSchedule
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Auto-Schedule'
  ClientHeight = 704
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    469
    704)
  TextHeight = 21
  object Label3: TLabel
    Left = 121
    Top = 251
    Width = 42
    Height = 21
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = '25M ..'
  end
  object Label4: TLabel
    Left = 256
    Top = 251
    Width = 49
    Height = 21
    Caption = '(MINS)'
  end
  object Label5: TLabel
    Left = 121
    Top = 289
    Width = 42
    Height = 21
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = '50M ..'
  end
  object Label6: TLabel
    Left = 256
    Top = 289
    Width = 49
    Height = 21
    Caption = '(MINS)'
  end
  object Label7: TLabel
    Left = 112
    Top = 327
    Width = 51
    Height = 21
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = '100M ..'
  end
  object Label8: TLabel
    Left = 256
    Top = 327
    Width = 49
    Height = 21
    Caption = '(MINS)'
  end
  object Label9: TLabel
    Left = 112
    Top = 365
    Width = 51
    Height = 21
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = '200M ..'
  end
  object Label10: TLabel
    Left = 256
    Top = 365
    Width = 49
    Height = 21
    Caption = '(MINS)'
  end
  object Label11: TLabel
    Left = 112
    Top = 403
    Width = 51
    Height = 21
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = '400M ..'
  end
  object Label12: TLabel
    Left = 256
    Top = 403
    Width = 49
    Height = 21
    Caption = '(MINS)'
  end
  object Label1: TLabel
    Left = 103
    Top = 441
    Width = 60
    Height = 21
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = '1000M ..'
  end
  object Label2: TLabel
    Left = 256
    Top = 441
    Width = 49
    Height = 21
    Caption = '(MINS)'
  end
  object Label13: TLabel
    Left = 90
    Top = 18
    Width = 289
    Height = 25
    Caption = 'Auto schedule swimming events.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 41
    Top = 218
    Width = 359
    Height = 21
    Caption = 'Turn-around time for each heat for a given distance.'
  end
  object Label15: TLabel
    Left = 41
    Top = 486
    Width = 263
    Height = 21
    Caption = 'The interval that seperates each event.'
  end
  object Label16: TLabel
    Left = 256
    Top = 519
    Width = 49
    Height = 21
    Caption = '(MINS)'
  end
  object Label17: TLabel
    Left = 40
    Top = 137
    Width = 177
    Height = 21
    Caption = 'Event 01 commences at ...'
  end
  object Label19: TLabel
    Left = 41
    Top = 568
    Width = 140
    Height = 21
    Caption = 'Session finishes at ...'
  end
  object Label20: TLabel
    Left = 335
    Top = 602
    Width = 82
    Height = 21
    Caption = '(Estimated) '
  end
  object Label18: TLabel
    Left = 40
    Top = 57
    Width = 170
    Height = 21
    Caption = 'Session commences at ...'
  end
  object Panel1: TPanel
    Left = 0
    Top = 658
    Width = 469
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 135
    ExplicitWidth = 415
    DesignSize = (
      469
      46)
    object btnCancel: TButton
      Left = 110
      Top = 8
      Width = 75
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOk: TButton
      Left = 191
      Top = 8
      Width = 169
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'AUTO Schedule'
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
  object TimePicker2: TTimePicker
    Left = 169
    Top = 245
    Width = 81
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 1
    Time = 0.001388888888888889
    TimeFormat = 'nn'
  end
  object TimePicker3: TTimePicker
    Left = 169
    Top = 283
    Width = 81
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 2
    Time = 0.002083333333333333
    TimeFormat = 'nn'
  end
  object TimePicker4: TTimePicker
    Left = 169
    Top = 321
    Width = 81
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 3
    Time = 0.002777777777777778
    TimeFormat = 'nn'
  end
  object TimePicker5: TTimePicker
    Left = 169
    Top = 359
    Width = 81
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 4
    Time = 0.004166666666666667
    TimeFormat = 'nn'
  end
  object TimePicker6: TTimePicker
    Left = 169
    Top = 397
    Width = 81
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 5
    Time = 0.006944444444444444
    TimeFormat = 'nn'
  end
  object TimePicker1: TTimePicker
    Left = 169
    Top = 435
    Width = 81
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 6
    Time = 0.013888888888888890
    TimeFormat = 'nn'
  end
  object TimePicker7: TTimePicker
    Left = 169
    Top = 513
    Width = 81
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 7
    Time = 0.003472222222222222
    TimeFormat = 'nn'
  end
  object tpEventStart: TTimePicker
    Left = 169
    Top = 164
    Width = 160
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 8
    Time = 0.770833333333333400
    TimeFormat = 'HH:nn ampm'
  end
  object TimePicker9: TTimePicker
    Left = 169
    Top = 595
    Width = 160
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 9
    Time = 0.770833333333333400
    TimeFormat = 'hh:nn ampm'
  end
  object tpSessionStart: TTimePicker
    Left = 169
    Top = 84
    Width = 160
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 10
    Time = 0.770833333333333400
    TimeFormat = 'HH:nn ampm'
  end
  object qrySession: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SessionID AS INTEGER;'
      'SET @SessionID = :SESSIONID;'
      ''
      'SELECT SessionStart FROM SESSION WHERE SessionID = @SessionID;')
    Left = 376
    Top = 280
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
end
