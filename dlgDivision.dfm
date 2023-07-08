object Division: TDivision
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Divisions : Age bracket and gender.'
  ClientHeight = 711
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 21
  object Panel2: TPanel
    Left = 0
    Top = 670
    Width = 737
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 669
    ExplicitWidth = 690
    DesignSize = (
      737
      41)
    object Label5: TLabel
      Left = 7
      Top = 6
      Width = 412
      Height = 21
      Caption = 'A division is an age range (inclusive) with a specific gender. '
    end
    object btnClose: TButton
      Left = 627
      Top = 6
      Width = 88
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 737
    Height = 670
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 694
    object TabSheet3: TTabSheet
      Caption = 'Divisions'
      DesignSize = (
        729
        634)
      object DBGrid1: TDBGrid
        Left = 3
        Top = 16
        Width = 638
        Height = 620
        Anchors = [akLeft, akTop, akBottom]
        DataSource = dsDivision
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Caption'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AgeFrom'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AgeTo'
            Visible = True
          end
          item
            DropDownRows = 4
            Expanded = False
            FieldName = 'luGender'
            Visible = True
          end>
      end
      object DBNavigator1: TDBNavigator
        Left = 658
        Top = 16
        Width = 65
        Height = 600
        DataSource = dsDivision
        Kind = dbnVertical
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Reports'
      object Label10: TLabel
        Left = 179
        Top = 13
        Width = 452
        Height = 63
        Caption = 
          'List all the available members for each division.  Member'#39's age ' +
          'calculated on '#39'start of swimming season'#39'. Active members appear ' +
          'in this list. '
        WordWrap = True
      end
      object btnDivMembers: TButton
        Left = 15
        Top = 18
        Width = 158
        Height = 25
        Caption = 'Division Members'
        TabOrder = 0
        OnClick = btnDivMembersClick
      end
    end
  end
  object qryDivision: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'ScoreDivisionID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..ScoreDivision'
    UpdateOptions.KeyFields = 'ScoreDivisionID'
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ';'
      ''
      'DECLARE @SwimClubID AS int;'
      ''
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'SELECT [ScoreDivisionID]'
      '      ,[SwimClubID]'
      '      ,[Caption]'
      '      ,[AgeFrom]'
      '      ,[AgeTo]'
      '      ,[GenderID]'
      '  FROM [dbo].[ScoreDivision]'
      'WHERE SwimClubID = @SwimCLubID'
      ';')
    Left = 336
    Top = 528
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qryDivisionScoreDivisionID: TFDAutoIncField
      FieldName = 'ScoreDivisionID'
      Origin = 'ScoreDivisionID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object qryDivisionSwimClubID: TIntegerField
      FieldName = 'SwimClubID'
      Origin = 'SwimClubID'
      Visible = False
    end
    object qryDivisionCaption: TWideStringField
      DisplayLabel = 'Description of Division'
      DisplayWidth = 34
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 128
    end
    object qryDivisionAgeFrom: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Age From'
      DisplayWidth = 10
      FieldName = 'AgeFrom'
      Origin = 'AgeFrom'
      DisplayFormat = '##0'
    end
    object qryDivisionAgeTo: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Age To'
      DisplayWidth = 10
      FieldName = 'AgeTo'
      Origin = 'AgeTo'
      DisplayFormat = '##0'
    end
    object qryDivisionluGender: TStringField
      DisplayLabel = 'Gender'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'luGender'
      LookupDataSet = tblGender
      LookupKeyFields = 'GenderID'
      LookupResultField = 'Caption'
      KeyFields = 'GenderID'
      Lookup = True
    end
    object qryDivisionGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
      Visible = False
    end
  end
  object dsDivision: TDataSource
    DataSet = qryDivision
    Left = 408
    Top = 528
  end
  object tblGender: TFDTable
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'GenderID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'Gender'
    UpdateOptions.KeyFields = 'GenderID'
    TableName = 'Gender'
    Left = 338
    Top = 472
  end
  object luGender: TDataSource
    DataSet = tblGender
    Left = 410
    Top = 472
  end
  object frxDivMembers: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43429.469572048600000000
    ReportOptions.LastChange = 44894.496938391200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 464
    Top = 240
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = frxDSDivMembers
        DataSetName = 'frxDS'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 4
      ColumnWidth = 47.500000000000000000
      ColumnPositions.Strings = (
        '0'
        '47.5'
        '95'
        '142.5')
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 49.133890000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object frxDScSwimClub: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'ClubName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubName"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 1.779530000000000000
          Top = 43.590600000000000000
          Width = 714.331170000000000000
          StretchMode = smMaxHeight
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 4.000000000000000000
        end
        object frxDBDataset2NickName: TfrxMemoView
          AllowVectorExport = True
          Left = 4.705455930000000000
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
        end
        object dsHeaderStartOfSwimSeason: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 441.666666670000000000
          Top = 21.843090740000000000
          Width = 272.126160000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          DisplayFormat.FormatStr = 'mmmm dd, yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Start of Swimming Season : [dsHeader."StartOfSwimSeason"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 287.244280000000000000
        Width = 718.110700000000000000
        object Page: TfrxMemoView
          AllowVectorExport = True
          Left = 279.685220000000000000
          Top = 1.889765000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Page#] of [TotalPages#]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 0.779530000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed on [Date]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 19.790043330000000000
        Top = 128.504020000000000000
        Width = 179.527675000000000000
        Condition = 'frxDS."ScoreDivisionID"'
        KeepTogether = True
        object frxDSDivisionStr: TfrxMemoView
          AllowVectorExport = True
          Width = 175.722016670000000000
          Height = 17.343846670000000000
          AutoWidth = True
          DataSet = frxDSDivMembers
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxDS."Caption"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 170.078850000000000000
        Width = 179.527675000000000000
        DataSet = frxDSDivMembers
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object frxDSEventStr: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 169.847866670000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSet = frxDSDivMembers
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."ucFName"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118120000000000000
        Top = 211.653680000000000000
        Width = 179.527675000000000000
      end
    end
  end
  object frxDSDivMembers: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = True
    DataSet = qryDivMembers
    BCDToCurrency = False
    Left = 368
    Top = 240
  end
  object qryDivMembers: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexesActive = False
    IndexFieldNames = 'ScoreDivisionID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime]
    FormatOptions.FmtDisplayDateTime = 'dd mmm YYYY HH:MM'
    FormatOptions.FmtDisplayDate = 'dd mmm YYYYY'
    FormatOptions.FmtDisplayTime = 'nn:mm.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'ScoreDivisionID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @SeedDate AS DATETIME;'
      ''
      'SET @SeedDate = :SEEDDATE;'
      ''
      'IF (@SeedDate IS NULL)'
      #9'SET @SeedDate = GETDATE();'
      ''
      'SELECT ScoreDivision.ScoreDivisionID'
      #9',ScoreDivision.Caption'
      #9',Member.MemberID'
      #9',Member.DOB'
      #9',dbo.SwimmerAge(@SeedDate, Member.DOB) AS AGE'
      #9',Member.IsActive'
      #9',CONCAT ('
      #9#9'UPPER(Member.LastName)'
      #9#9','#39', '#39
      #9#9',Member.FirstName'
      #9#9') AS ucFName'
      #9',ScoreDivision.AgeFrom'
      #9',ScoreDivision.AgeTo'
      #9',ScoreDivision.GenderID'
      'FROM ScoreDivision'
      'INNER JOIN Member ON ScoreDivision.GenderID = Member.GenderID'
      'WHERE (Member.IsActive = 1)'
      
        #9'AND (dbo.SwimmerAge(@SeedDate, Member.DOB) >= ScoreDivision.Age' +
        'From)'
      
        #9'AND (dbo.SwimmerAge(@SeedDate, Member.DOB) <= ScoreDivision.Age' +
        'To)'
      'ORDER BY ScoreDivision.ScoreDivisionID, Member.LastName'
      '')
    Left = 264
    Top = 240
    ParamData = <
      item
        Name = 'SEEDDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryRptHeader: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = 1; -- :SWIMCLUBID'
      ''
      
        '-- Select rows from a Table or View '#39'[SwimClub]'#39' in schema '#39'[dbo' +
        ']'#39
      'SELECT SwimClubID,'
      '       StartOfSwimSeason, '
      '       SUBSTRING(Caption, 0, 50) AS ClubName,'
      '       SUBSTRING(NickName, 0, 50) AS ClubNickName,'
      
        '       FORMAT(StartOfSwimSeason, '#39'ddd dd MMM yyyy'#39') AS SeasonSta' +
        'rt'
      'FROM [dbo].[SwimClub]'
      'WHERE SwimClubID = @SwimClubID;')
    Left = 264
    Top = 184
  end
  object frxDBDSRptHeader: TfrxDBDataset
    UserName = 'dsHeader'
    CloseDataSource = False
    DataSet = qryRptHeader
    BCDToCurrency = False
    Left = 368
    Top = 184
  end
end
