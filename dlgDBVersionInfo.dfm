object DBVersionInfo: TDBVersionInfo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SwimClubMeet MS SQL Database Version Information.'
  ClientHeight = 421
  ClientWidth = 862
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
  object Label1: TLabel
    Left = 112
    Top = 112
    Width = 68
    Height = 59
    Caption = 'lbl1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -43
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 264
    Top = 112
    Width = 68
    Height = 59
    Caption = 'lbl2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -43
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 408
    Top = 112
    Width = 68
    Height = 59
    Caption = 'lbl3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -43
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 544
    Top = 112
    Width = 68
    Height = 59
    Caption = 'lbl4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -43
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object VirtualImage1: TVirtualImage
    Left = 64
    Top = 32
    Width = 700
    Height = 217
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = -1
  end
  object btnClose: TButton
    Left = 680
    Top = 344
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
    Left = 72
    Top = 344
  end
  object ImageCollection1: TImageCollection
    Images = <>
    Left = 72
    Top = 272
  end
  object dsSCMSystem: TDataSource
    DataSet = qrySCMSystem
    Left = 160
    Top = 344
  end
end
