object SchedulePicker: TSchedulePicker
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Schedule Event...'
  ClientHeight = 182
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  TextHeight = 21
  object Label1: TLabel
    Left = 23
    Top = 55
    Width = 139
    Height = 21
    Caption = 'Schedule Event for ..'
  end
  object Label2: TLabel
    Left = 308
    Top = 55
    Width = 87
    Height = 21
    Caption = '(HOUR:MIN)'
  end
  object Panel1: TPanel
    Left = 0
    Top = 136
    Width = 419
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      419
      46)
    object btnCancel: TButton
      Left = 255
      Top = 9
      Width = 75
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOk: TButton
      Left = 336
      Top = 9
      Width = 75
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'OK'
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
  object TimePicker1: TTimePicker
    Left = 168
    Top = 48
    Width = 134
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 1
    Time = 45081.596733321760000000
    TimeFormat = 'hh:nn'
  end
end
