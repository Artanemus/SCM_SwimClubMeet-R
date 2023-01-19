object BasicLogin: TBasicLogin
  Left = 0
  Top = 0
  Caption = 'Login to the SwimClubMeet Server ...'
  ClientHeight = 285
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    527
    285)
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 48
    Top = 19
    Width = 45
    Height = 19
    Alignment = taRightJustify
    Caption = 'Server'
  end
  object Label2: TLabel
    Left = 15
    Top = 59
    Width = 78
    Height = 19
    Alignment = taRightJustify
    Caption = 'User Name'
  end
  object Label3: TLabel
    Left = 26
    Top = 99
    Width = 67
    Height = 19
    Alignment = taRightJustify
    Caption = 'Password'
  end
  object lblLoginErrMsg: TLabel
    Left = 23
    Top = 184
    Width = 453
    Height = 20
    Alignment = taCenter
    AutoSize = False
    Caption = 'The login failed - retry or abort.'
    Visible = False
  end
  object chkOsAuthent: TCheckBox
    Left = 99
    Top = 136
    Width = 206
    Height = 24
    Caption = 'Use OS Authentication'
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 99
    Top = 96
    Width = 295
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = 'edtPassword'
  end
  object edtServer: TEdit
    Left = 99
    Top = 16
    Width = 419
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Text = 'edtServer'
  end
  object edtUser: TEdit
    Left = 99
    Top = 56
    Width = 367
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Text = 'edtUser'
  end
  object Panel1: TPanel
    Left = 0
    Top = 215
    Width = 527
    Height = 70
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      527
      68)
    object lblMsg: TLabel
      Left = 23
      Top = 21
      Width = 306
      Height = 27
      AutoSize = False
      Caption = 'Attempting to connect ... please wait.'
      Visible = False
    end
    object btnAbort: TButton
      Left = 351
      Top = 19
      Width = 81
      Height = 32
      Anchors = [akTop, akRight]
      Caption = 'Abort'
      ModalResult = 3
      TabOrder = 1
      OnClick = btnAbortClick
    end
    object btnConnect: TButton
      Left = 438
      Top = 19
      Width = 81
      Height = 32
      Anchors = [akTop, akRight]
      Caption = 'Login'
      Default = True
      TabOrder = 0
      OnClick = btnConnectClick
    end
  end
end
