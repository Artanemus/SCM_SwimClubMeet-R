object DOBPicker: TDOBPicker
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Date of Birth'
  ClientHeight = 385
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  TextHeight = 13
  object CalendarView1: TCalendarView
    Left = 0
    Top = 0
    Date = 44832.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    HeaderInfo.DaysOfWeekFont.Color = clWindowText
    HeaderInfo.DaysOfWeekFont.Height = -13
    HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    HeaderInfo.DaysOfWeekFont.Style = []
    HeaderInfo.Font.Charset = DEFAULT_CHARSET
    HeaderInfo.Font.Color = clWindowText
    HeaderInfo.Font.Height = -20
    HeaderInfo.Font.Name = 'Segoe UI'
    HeaderInfo.Font.Style = []
    OnDblClick = CalendarView1DblClick
    ParentFont = False
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 110
    Top = 352
    Width = 75
    Height = 25
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnOkClick
  end
end
