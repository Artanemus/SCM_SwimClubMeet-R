object AutoBuild_Finals: TAutoBuild_Finals
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Auto Build Finals.'
  ClientHeight = 351
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Panel2: TPanel
    Left = 0
    Top = 310
    Width = 300
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnCancel: TButton
      Left = 153
      Top = 6
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'No'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOk: TButton
      Left = 72
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Yes'
      Default = True
      ModalResult = 6
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 300
    Height = 310
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 254
      Height = 37
      AutoSize = False
      Caption = 'Perform a FINALS Auto-Build for the current selected event?'
      WordWrap = True
    end
    object lblSeedDepth2: TLabel
      Left = 157
      Top = 242
      Width = 60
      Height = 17
      Caption = '(Default 3)'
      Visible = False
    end
    object lblSeedDepth1: TLabel
      Left = 34
      Top = 242
      Width = 70
      Height = 17
      Caption = 'Seed depth:'
      Visible = False
    end
    object Label2: TLabel
      Left = 0
      Top = 287
      Width = 300
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = '(Values set here don'#39't effect global setings.)'
    end
    object prefSeperateGender: TCheckBox
      Left = 24
      Top = 51
      Width = 134
      Height = 17
      Caption = 'Seperate gender.'
      TabOrder = 0
    end
    object prefExcludeOutsideLanes: TCheckBox
      Left = 24
      Top = 113
      Width = 160
      Height = 17
      Caption = 'Exclude outside lanes.'
      TabOrder = 1
    end
    object CheckBox1: TCheckBox
      Left = 64
      Top = 74
      Width = 214
      Height = 17
      Caption = 'Create an event for each gender.'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 2
    end
    object rgpSeedMethod: TRadioGroup
      Left = 24
      Top = 153
      Width = 254
      Height = 73
      Hint = 'Decides what lane an entrant is given.'
      Caption = 'Seed Method.'
      Enabled = False
      ItemIndex = 0
      Items.Strings = (
        'FINALS seeding.'
        'Quarter, semi finals circle seeding.')
      TabOrder = 3
    end
    object spnSeedDepth: TSpinEdit
      Left = 110
      Top = 239
      Width = 41
      Height = 27
      MaxValue = 10
      MinValue = 0
      TabOrder = 4
      Value = 3
      Visible = False
    end
  end
end
