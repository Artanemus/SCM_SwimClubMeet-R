object NewSession: TNewSession
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'New Session ...'
  ClientHeight = 315
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 249
    Height = 274
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 245
    ExplicitHeight = 273
    object Label1: TLabel
      Left = 15
      Top = 189
      Width = 149
      Height = 21
      Caption = 'Session Description ...'
    end
    object Label2: TLabel
      Left = 47
      Top = 14
      Width = 89
      Height = 21
      Caption = 'Session Date'
    end
    object Label3: TLabel
      Left = 47
      Top = 79
      Width = 91
      Height = 21
      Caption = 'Session Time'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 274
    Width = 249
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 273
    ExplicitWidth = 245
    object btnCancel: TButton
      Left = 47
      Top = 6
      Width = 75
      Height = 28
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnPost: TButton
      Left = 128
      Top = 6
      Width = 75
      Height = 28
      Caption = 'Post'
      Default = True
      ModalResult = 1
      TabOrder = 1
      OnClick = btnPostClick
    end
  end
  object DatePicker1: TDatePicker
    Left = 47
    Top = 41
    Date = 44163.000000000000000000
    DateFormat = 'd/MM/yyyy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 2
  end
  object TimePicker1: TTimePicker
    Left = 47
    Top = 106
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 3
    Time = 44163.440787812500000000
    TimeFormat = 'h:mm AMPM'
  end
  object DBEdit1: TDBEdit
    Left = 15
    Top = 216
    Width = 225
    Height = 29
    DataField = 'Caption'
    TabOrder = 4
  end
  object qrySessionDlg: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SessionID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Session'
    UpdateOptions.KeyFields = 'SessionID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'SELECT [SessionID]'
      '     , [Caption]'
      '     , [SessionStart]'
      '     , [ClosedDT]'
      '     , [SwimClubID]'
      '     , [SessionStatusID]'
      'FROM [SwimClubMeet].[dbo].[Session];')
    Left = 48
    Top = 152
  end
  object dsSessionDlg: TDataSource
    DataSet = qrySessionDlg
    Left = 144
    Top = 152
  end
end
