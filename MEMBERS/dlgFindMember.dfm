object FindMember: TFindMember
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Find Member'
  ClientHeight = 530
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 19
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 353
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 357
    object VirtualImage1: TVirtualImage
      Left = 8
      Top = 7
      Width = 34
      Height = 34
      ImageCollection = ImageCollection1
      ImageWidth = 0
      ImageHeight = 0
      ImageIndex = 0
      ImageName = 'Search_48x48'
    end
    object Edit1: TEdit
      Left = 48
      Top = 11
      Width = 284
      Height = 27
      TabOrder = 0
      Text = 'Edit1'
      OnChange = Edit1Change
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 479
    Width = 353
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 480
    ExplicitWidth = 357
    DesignSize = (
      353
      51)
    object lblFound: TLabel
      Left = 8
      Top = 16
      Width = 55
      Height = 19
      Caption = 'Found :'
    end
    object btnGotoMember: TButton
      Left = 193
      Top = 10
      Width = 131
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'Goto Member'
      TabOrder = 0
      OnClick = btnGotoMemberClick
      ExplicitLeft = 201
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 49
    Width = 353
    Height = 430
    Align = alClient
    DataSource = dsFindMember
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'MemberID'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'MembershipNum'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'FName'
        Width = 300
        Visible = True
      end>
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Search_48x48'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000002B7494441546843ED988D6D14311046
              BFAB8074005490A4024205400521150015905400540054105241A002920A0215
              042A003DC9969CC15E7B3D5EDD46DC48A75C4EFE993733FE3CBB1BDD73DBDC73
              FFB503D87606FFEB0CEC497A22E94012DFF9FB237C7E49BA08DF174D524F0670
              F4ADA4E70D9E01742AE973C3D8AE21730088F23B492F3B7602E485A4AB8EB993
              535A011E493A0F65E2F1E144D227CF02766E0B00CE7F0F756EE77F0B5125B244
              193B0AA094DAC38CB36F24BD1F055103A06C2E3391BF0EA5345512CCA5FE5F65
              9CA59CBE8C80A80190EE63B3D15970AC757F32C23A693650A9C3112A35054009
              503AA9CD753ECEA50CC9D683643194A94710EE383405408A9F25A3291BA07AED
              7550B174FE636F164A00D4EFADF194947B65F06BB8FCE2D2EE035D02E0924236
              A3A136D4B2D786AF5B02403DB86DA37D904409782D77AE6A4232B96769323A9D
              CADFC80BE88FF16811005BAB4F25F1DB08B36BBB0E7289DEEAFF4800C4019188
              B64806EC19E8D57F9BB19CBA2D0260359BDEBEA57DAE95184A466B12CD7BB714
              9F89B9396F928D68D4B80768013C66C5C1AD6E53E9C3E9B47FF16E969350F7D9
              9A02A04FF968C2EDD990BE2A6D45865C8EB50364B3C0FF40C4DEBFB59C08846D
              DC46B426D5F742B9B4730E50294AAA66CCC779DB047ACB719606E74A8905B890
              38943F4D938754EE07D52AB51F04814C7A9BC36A062269AE15B6D10708F5E2D3
              6243206A672075847B801B3A7D286971348EE1D0F21E293537C41C003626BAD4
              BF7DCC9C02A1C4C8200F48B9727441CC05888E024246F8D8A83206A729293266
              9BC0A110BD00B98803D52AAFC3204602CC390F8C2D41F0ECD1FCCA659B002508
              7E6F7E80DA36801B620D002E88B5007443AC09A00B626D00B321D6089083F81D
              5EACFDD3FCAD152085283ACFA035034408A25E6CBBD70E50BDDD7700D5102D3C
              60978185035C5DFE2F24F88F31DE923FDD0000000049454E44AE426082}
          end>
      end>
    Left = 232
    Top = 112
  end
  object qryFindMember: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    IndexFieldNames = 'MemberID'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'SELECT        '
      ' Member.MemberID'
      ', Member.MembershipNum'
      ', CONCAT(UPPER([LastName]), '#39', '#39', Member.FirstName ) AS FName'
      ', Member.SwimClubID'
      'FROM            Member WHERE [Member].[SwimClubID] = @SwimClubID'
      'ORDER BY Member.LastName;')
    Left = 97
    Top = 176
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qryFindMemberMemberID: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 5
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ReadOnly = True
      Visible = False
    end
    object qryFindMemberMembershipNum: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'Num'
      DisplayWidth = 5
      FieldName = 'MembershipNum'
      Origin = 'MembershipNum'
      Visible = False
    end
    object qryFindMemberFName: TWideStringField
      DisplayLabel = 'Member'#39's Name'
      DisplayWidth = 300
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Required = True
      Size = 258
    end
    object qryFindMemberSwimClubID: TIntegerField
      FieldName = 'SwimClubID'
      Origin = 'SwimClubID'
      Visible = False
    end
  end
  object dsFindMember: TDataSource
    DataSet = qryFindMember
    Left = 193
    Top = 176
  end
end
