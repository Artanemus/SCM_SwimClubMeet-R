object BatchProgress: TBatchProgress
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Batch Process Reports'
  ClientHeight = 196
  ClientWidth = 521
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 521
    Height = 57
    Align = alTop
    Caption = 'Batch Process Reports.'
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 139
    Width = 521
    Height = 57
    Align = alBottom
    TabOrder = 1
    object Label2: TLabel
      Left = 11
      Top = 18
      Width = 58
      Height = 21
      Caption = 'Errors: 0'
    end
    object btnCancel: TButton
      Left = 220
      Top = 14
      Width = 81
      Height = 30
      Caption = 'Cancel'
      Enabled = False
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 57
    Width = 521
    Height = 82
    Align = alClient
    TabOrder = 2
    object Label1: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 21
      Width = 499
      Height = 21
      Margins.Left = 10
      Margins.Top = 20
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Current Task.'
      ExplicitLeft = 32
      ExplicitTop = 23
      ExplicitWidth = 457
    end
    object ProgressBar1: TProgressBar
      AlignWithMargins = True
      Left = 11
      Top = 54
      Width = 499
      Height = 17
      Margins.Left = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      TabOrder = 0
    end
  end
end
