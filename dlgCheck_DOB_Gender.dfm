object Check_DOB_Gender: TCheck_DOB_Gender
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Check: DOB /Gender'
  ClientHeight = 486
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  TextHeight = 21
  object pnlFooter: TPanel
    Left = 0
    Top = 445
    Width = 624
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 232
    ExplicitTop = 224
    ExplicitWidth = 185
    object btnOK: TButton
      Left = 199
      Top = 5
      Width = 225
      Height = 32
      Caption = 'Close and abort AutoBuild'
      TabOrder = 0
      OnClick = btnOKClick
    end
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblHeader: TLabel
      Left = 3
      Top = 14
      Width = 354
      Height = 21
      Caption = 'Members with missing DOB or unspecified Gender.'
    end
    object lblHeader2: TLabel
      Left = 3
      Top = 41
      Width = 395
      Height = 21
      Caption = 'For AutoBuild to be successful these errors must be fixed.'
    end
  end
  object pnlBody: TPanel
    Left = 0
    Top = 73
    Width = 624
    Height = 372
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = 232
    ExplicitTop = 224
    ExplicitWidth = 185
    ExplicitHeight = 41
    object dbgDOBGender: TDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 618
      Height = 366
      Align = alClient
      DataSource = dsErronous_DOB_GENDER
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object qryErronous_DOB_GENDER: TFDQuery
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvStrsTrim2Len]
    FormatOptions.StrsTrim2Len = True
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      ''
      ''
      'DECLARE @EventID AS INT;'
      'SET @EventID = :EVENTID; -- 252;'
      ''
      'SELECT'
      #9'EventID,'
      #9'Nominee.MemberID, '
      
        #9'-- Starting with SQL Server 2022 (16.x), optionally removes the' +
        ' space character char(32) or other specified characters from the' +
        ' start, end, or both sides of a string.'
      #9'TRIM(Concat(FirstName, '#39' '#39', UPPER(LastName) )) AS FName,'
      #9'Member.GenderID,'
      #9'FORMAT(Member.DOB, '#39'yyyy-mm-dd'#39') AS '#39'Date'#39','
      #9'Gender.Caption,'
      #9'DOB'
      'FROM dbo.Nominee'
      'INNER JOIN Member ON Nominee.MemberID = Member.MemberID'
      'INNER JOIN Gender ON Member.GenderID = Gender.GenderID'
      'WHERE (Member.GenderID IS NULL OR DOB IS NULL) AND '
      #9'EventID = @EventID'
      'ORDER BY Firstname;'
      '')
    Left = 464
    Top = 24
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 252
      end>
    object qryErronous_DOB_GENDEREventID: TIntegerField
      FieldName = 'EventID'
      Origin = 'EventID'
      Visible = False
    end
    object qryErronous_DOB_GENDERMemberID: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Member ID'
      FieldName = 'MemberID'
      Origin = 'MemberID'
    end
    object qryErronous_DOB_GENDERFName: TWideStringField
      DisplayWidth = 24
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Size = 512
    end
    object qryErronous_DOB_GENDERGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
      Visible = False
    end
    object qryErronous_DOB_GENDERDate: TWideStringField
      DisplayWidth = 12
      FieldName = 'Date'
      Origin = 'Date'
      ReadOnly = True
      Size = 4000
    end
    object qryErronous_DOB_GENDERCaption: TWideStringField
      DisplayWidth = 10
      FieldName = 'Caption'
      Origin = 'Caption'
    end
    object qryErronous_DOB_GENDERDOB: TSQLTimeStampField
      DisplayWidth = 10
      FieldName = 'DOB'
      Origin = 'DOB'
      Visible = False
    end
  end
  object dsErronous_DOB_GENDER: TDataSource
    DataSet = qryErronous_DOB_GENDER
    Left = 464
    Top = 88
  end
end
