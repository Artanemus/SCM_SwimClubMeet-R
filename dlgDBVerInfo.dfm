object DBVerInfo: TDBVerInfo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SwimClubMeet MS SQL Database Version Information.'
  ClientHeight = 208
  ClientWidth = 557
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 21
  object Shape5: TShape
    Left = 57
    Top = 21
    Width = 60
    Height = 93
    Brush.Style = bsClear
    Pen.Width = 2
  end
  object Shape6: TShape
    Left = 186
    Top = 21
    Width = 60
    Height = 93
    Brush.Style = bsClear
    Pen.Width = 2
  end
  object Shape7: TShape
    Left = 312
    Top = 21
    Width = 60
    Height = 93
    Brush.Style = bsClear
    Pen.Width = 2
  end
  object Shape8: TShape
    Left = 437
    Top = 21
    Width = 60
    Height = 93
    Brush.Style = bsClear
    Pen.Width = 2
  end
  object Label1: TLabel
    Left = 59
    Top = 8
    Width = 56
    Height = 106
    Alignment = taCenter
    AutoSize = False
    Caption = '1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -80
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 188
    Top = 8
    Width = 56
    Height = 106
    Alignment = taCenter
    AutoSize = False
    Caption = '1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -80
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 314
    Top = 8
    Width = 56
    Height = 106
    Alignment = taCenter
    AutoSize = False
    Caption = '5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -80
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 439
    Top = 8
    Width = 56
    Height = 106
    Alignment = taCenter
    AutoSize = False
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -80
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 156
    Top = 28
    Width = 29
    Height = 86
    Caption = 'VERSION'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Orientation = 900
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 282
    Top = 43
    Width = 29
    Height = 71
    Caption = 'MAJOR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Orientation = 900
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 407
    Top = 43
    Width = 29
    Height = 70
    Caption = 'MINOR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Orientation = 900
    Font.Style = []
    ParentFont = False
  end
  object Shape1: TShape
    Left = 128
    Top = 77
    Width = 18
    Height = 18
    Brush.Color = clBlack
    Shape = stCircle
  end
  object Shape2: TShape
    Left = 256
    Top = 77
    Width = 18
    Height = 18
    Brush.Color = clBlack
    Shape = stCircle
  end
  object Shape3: TShape
    Left = 381
    Top = 77
    Width = 18
    Height = 18
    Brush.Color = clBlack
    Shape = stCircle
  end
  object Shape4: TShape
    Left = 506
    Top = 77
    Width = 18
    Height = 18
    Brush.Color = clBlack
    Shape = stCircle
  end
  object Label5: TLabel
    Left = 25
    Top = 43
    Width = 29
    Height = 71
    Caption = 'MODEL'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Orientation = 900
    Font.Style = []
    ParentFont = False
  end
  object btnClose: TButton
    Left = 422
    Top = 152
    Width = 84
    Height = 39
    Caption = 'Close'
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object qrySCMSystem: TFDQuery
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'SELECT * FROM SCMSystem WHERE SCMSystemID = 1;')
    Left = 256
    Top = 136
  end
  object dsSCMSystem: TDataSource
    DataSet = qrySCMSystem
    Left = 336
    Top = 136
  end
end
