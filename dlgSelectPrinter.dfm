object SelectPrinter: TSelectPrinter
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Batch Print'
  ClientHeight = 576
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  StyleElements = [seFont, seClient]
  PixelsPerInch = 96
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 519
    Width = 516
    Height = 57
    Align = alBottom
    TabOrder = 0
    object btnCancel: TButton
      Left = 163
      Top = 16
      Width = 81
      Height = 30
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOk: TButton
      Left = 253
      Top = 16
      Width = 81
      Height = 30
      Caption = 'Ok'
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 59
    Width = 496
    Height = 450
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    Caption = 'Select output ...'
    Padding.Left = 10
    TabOrder = 1
    object Label1: TLabel
      Left = 22
      Top = 382
      Width = 99
      Height = 21
      Caption = 'Select folder ...'
    end
    object rbtnSendToPrinter: TRadioButton
      AlignWithMargins = True
      Left = 15
      Top = 33
      Width = 476
      Height = 17
      Margins.Top = 10
      Align = alTop
      Caption = 'Send to printer.'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbtnSendToPDF: TRadioButton
      AlignWithMargins = True
      Left = 15
      Top = 214
      Width = 476
      Height = 17
      Margins.Top = 10
      Align = alTop
      Caption = 'Send to PDF'
      TabOrder = 2
    end
    object lboxPrinters: TListBox
      AlignWithMargins = True
      Left = 22
      Top = 63
      Width = 462
      Height = 131
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      ItemHeight = 21
      TabOrder = 1
    end
    object rgrpCollation: TRadioGroup
      Left = 49
      Top = 248
      Width = 248
      Height = 89
      Caption = 'Collation ...'
      Enabled = False
      ItemIndex = 0
      Items.Strings = (
        'PDF for each report'
        'Single PDF')
      TabOrder = 3
    end
    object edtFolder: TEdit
      Left = 22
      Top = 409
      Width = 462
      Height = 29
      TabOrder = 5
      Text = 'edtFolder'
    end
    object btnBrowseForFolder: TButton
      Left = 384
      Top = 378
      Width = 100
      Height = 25
      Caption = 'Browse'
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 516
    Height = 49
    Align = alTop
    Caption = 'BATCH PRINT REPORTS'
    TabOrder = 2
  end
end
