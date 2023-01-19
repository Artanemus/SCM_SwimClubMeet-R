object House: THouse
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SwimClubMeet house pereferences and reports.'
  ClientHeight = 789
  ClientWidth = 875
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 875
    Height = 728
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 875
      Height = 728
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'House Details'
        object Label1: TLabel
          Left = 152
          Top = 351
          Width = 83
          Height = 21
          Caption = 'House Logo'
        end
        object Label2: TLabel
          Left = 384
          Top = 24
          Width = 90
          Height = 21
          Caption = 'House Name'
        end
        object Label3: TLabel
          Left = 384
          Top = 84
          Width = 90
          Height = 21
          Caption = 'House Motto'
        end
        object Label4: TLabel
          Left = 384
          Top = 152
          Width = 86
          Height = 21
          Caption = 'House Color'
        end
        object Label5: TLabel
          Left = 384
          Top = 224
          Width = 114
          Height = 21
          Caption = 'House Members'
        end
        object Label6: TLabel
          Left = 619
          Top = 219
          Width = 47
          Height = 21
          Alignment = taRightJustify
          Caption = 'Search'
        end
        object shapeHouseColor: TShape
          Left = 384
          Top = 175
          Width = 86
          Height = 34
          OnMouseUp = shapeHouseColorMouseUp
        end
        object LogoImage: TImage
          Left = 32
          Top = 24
          Width = 306
          Height = 306
          Center = True
          Proportional = True
          Stretch = True
        end
        object Label7: TLabel
          Left = 32
          Top = 424
          Width = 306
          Height = 21
          Alignment = taCenter
          AutoSize = False
          Caption = '(PNG, BMP, JPG - min 400x400 pixels,)'
        end
        object DBEdit1: TDBEdit
          Left = 384
          Top = 47
          Width = 457
          Height = 29
          DataField = 'Caption'
          DataSource = dsHouse
          TabOrder = 0
        end
        object DBGrid2: TDBGrid
          Left = 384
          Top = 251
          Width = 457
          Height = 350
          DataSource = dsHouseMember
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 3
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
        object edtSearchHouseMember: TEdit
          Left = 672
          Top = 216
          Width = 169
          Height = 29
          TabOrder = 2
          OnChange = edtSearchHouseMemberChange
        end
        object DBEdit2: TDBEdit
          Left = 384
          Top = 107
          Width = 457
          Height = 29
          DataField = 'Motto'
          DataSource = dsHouse
          TabOrder = 1
        end
        object btnLoadHouseLogo: TButton
          Left = 148
          Top = 374
          Width = 86
          Height = 33
          Caption = 'Load'
          TabOrder = 4
          OnClick = btnLoadHouseLogoClick
        end
        object DBNavigator1: TDBNavigator
          Left = 32
          Top = 630
          Width = 801
          Height = 51
          DataSource = dsHouse
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel, nbRefresh]
          TabOrder = 5
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Leader Board'
        ImageIndex = 3
        TabVisible = False
        object Label8: TLabel
          Left = 107
          Top = 58
          Width = 669
          Height = 21
          Caption = 
            'House leaderboard tallies shown here are the results of Points a' +
            'nd Divisions settings set in Score.'
        end
        object btnUpdate: TButton
          Left = 107
          Top = 27
          Width = 88
          Height = 25
          Caption = 'Update'
          TabOrder = 0
        end
        object Edit2: TEdit
          Left = 201
          Top = 26
          Width = 271
          Height = 29
          Alignment = taCenter
          DoubleBuffered = False
          ParentDoubleBuffered = False
          ReadOnly = True
          TabOrder = 1
          Text = 'Date of last update : never.'
        end
        object DBGrid3: TDBGrid
          Left = 201
          Top = 96
          Width = 271
          Height = 473
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Report'
        ImageIndex = 2
        object Label10: TLabel
          Left = 167
          Top = 11
          Width = 266
          Height = 21
          Caption = 'Print a list of members for each house.'
        end
        object btnHouseMemberRpt: TButton
          Left = 3
          Top = 3
          Width = 158
          Height = 39
          Caption = 'House Members'
          TabOrder = 0
          OnClick = btnHouseMemberRptClick
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 728
    Width = 875
    Height = 61
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnClose: TButton
      Left = 722
      Top = 6
      Width = 123
      Height = 51
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object qryHouse: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    AfterScroll = qryHouseAfterScroll
    IndexFieldNames = 'HouseID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..House'
    UpdateOptions.KeyFields = 'HouseID'
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ';'
      ''
      'SELECT [HouseID]'
      '      ,[Caption]'
      '      ,[Motto]'
      '      ,[Color]'
      '      ,[LogoDir]'
      ',[LogoImg]'
      '  FROM [dbo].[House]'
      ';')
    Left = 72
    Top = 168
    object qryHouseHouseID: TFDAutoIncField
      FieldName = 'HouseID'
      Origin = 'HouseID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryHouseCaption: TWideStringField
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 128
    end
    object qryHouseMotto: TWideStringField
      FieldName = 'Motto'
      Origin = 'Motto'
      Size = 128
    end
    object qryHouseColor: TIntegerField
      FieldName = 'Color'
      Origin = 'Color'
      OnGetText = qryHouseColorGetText
    end
    object qryHouseLogoDir: TMemoField
      FieldName = 'LogoDir'
      Origin = 'LogoDir'
      OnGetText = qryHouseLogoDirGetText
      BlobType = ftMemo
      Size = 2147483647
    end
    object qryHouseLogoImg: TBlobField
      FieldName = 'LogoImg'
      Origin = 'LogoImg'
    end
  end
  object dsHouse: TDataSource
    DataSet = qryHouse
    Left = 176
    Top = 168
  end
  object ColorDialog1: TColorDialog
    Left = 424
    Top = 120
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'All (*.gif;*.jpg;*.jpeg;*.png;*.bmp;*.ico;*.emf;*.wmf;*.tif;*.ti' +
      'ff)|*.gif;*.jpg;*.jpeg;*.png;*.bmp;*.ico;*.emf;*.wmf;*.tif;*.tif' +
      'f|GIF Image (*.gif)|*.gif|JPEG Image File (*.jpg)|*.jpg|JPEG Ima' +
      'ge File (*.jpeg)|*.jpeg|Portable Network Graphics (*.png)|*.png|' +
      'Bitmaps (*.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles (*.' +
      'emf)|*.emf|Metafiles (*.wmf)|*.wmf|TIFF Images (*.tif)|*.tif|TIF' +
      'F Images (*.tiff)|*.tiff'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Load SCM House Logo'
    Left = 317
    Top = 117
  end
  object qryHouseMember: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    FilterOptions = [foCaseInsensitive]
    IndexFieldNames = 'HouseID'
    MasterSource = dsHouse
    MasterFields = 'HouseID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ';'
      ''
      'SELECT [MemberID]'
      #9',[MembershipNum]'
      #9',SubString(CONCAT ('
      #9#9#9'Upper(Member.LastName)'
      #9#9#9','#39', '#39
      #9#9#9',Member.FirstName'
      #9#9#9'), 0, 60) AS FName'
      #9',[HouseID]'
      #9',dbo.SwimmerAge(GETDATE(), DOB) AS AGE'
      'FROM [dbo].[Member]'
      'WHERE Member.IsActive = 1'
      'ORDER BY Member.LastName'
      ';')
    Left = 72
    Top = 120
    object qryHouseMemberHouseID: TIntegerField
      FieldName = 'HouseID'
      Origin = 'HouseID'
      Visible = False
    end
    object qryHouseMemberMemberID: TFDAutoIncField
      Alignment = taCenter
      DisplayLabel = '  ID'
      DisplayWidth = 6
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      DisplayFormat = '0000'
    end
    object qryHouseMemberMembershipNum: TIntegerField
      DisplayLabel = 'Num#'
      DisplayWidth = 6
      FieldName = 'MembershipNum'
      Origin = 'MembershipNum'
      DisplayFormat = '0000'
    end
    object qryHouseMemberFName: TWideStringField
      DisplayLabel = 'Member'#39's Name'
      DisplayWidth = 34
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Size = 60
    end
    object qryHouseMemberAGE: TIntegerField
      Alignment = taCenter
      DisplayLabel = ' AGE'
      DisplayWidth = 5
      FieldName = 'AGE'
      Origin = 'AGE'
      ReadOnly = True
      DisplayFormat = '#0'
    end
  end
  object dsHouseMember: TDataSource
    DataSet = qryHouseMember
    Left = 176
    Top = 120
  end
  object frxHouseRpt: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43428.811813125000000000
    ReportOptions.LastChange = 43434.512179675900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 280
    Top = 232
    Datasets = <
      item
        DataSet = frxDSHouseRpt
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
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 64.252010000000000000
        ParentFont = False
        Top = 124.724490000000000000
        Width = 179.527675000000000000
        Condition = 'frxDS."HouseID"'
        KeepTogether = True
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 170.162956670000000000
          Height = 30.236240000000000000
          Frame.Typ = []
        end
        object frxDSHouseStr: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 161.270563330000000000
          Height = 18.897650000000000000
          DataField = 'HouseStr'
          DataSet = frxDSHouseRpt
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDS."HouseStr"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 33.349103330000000000
          Width = 27.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'ID')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 38.692950000000000000
          Top = 34.015770000000000000
          Width = 138.803340000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Member'#39's Name')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object FDQuery1NickName: TfrxMemoView
          AllowVectorExport = True
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'NickName'
          DataSet = frxDSHouseRpt
          DataSetName = 'frxDS'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."NickName"]')
        end
        object frxDSClubName: TfrxMemoView
          AllowVectorExport = True
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'ClubName'
          DataSet = frxDSHouseRpt
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."ClubName"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 211.653680000000000000
        Width = 179.527675000000000000
        DataSet = frxDSHouseRpt
        DataSetName = 'frxDS'
        RowCount = 0
        object frxDSMemberID: TfrxMemoView
          AllowVectorExport = True
          Left = 1.279530000000000000
          Width = 36.354360000000000000
          Height = 18.897650000000000000
          DataField = 'MemberID'
          DataSet = frxDSHouseRpt
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."MemberID"]')
          ParentFont = False
        end
        object frxDSFNAME: TfrxMemoView
          AllowVectorExport = True
          Left = 38.192950000000000000
          Width = 138.082870000000000000
          Height = 18.897650000000000000
          DataField = 'FNAME'
          DataSet = frxDSHouseRpt
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."FNAME"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 325.039580000000000000
        Width = 718.110700000000000000
        object TotalPages: TfrxMemoView
          AllowVectorExport = True
          Left = 266.456865000000000000
          Top = 1.889765000000010000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Page [Page#] of [TotalPages#]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Date: TfrxMemoView
          AllowVectorExport = True
          Top = 1.889765000000010000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Printed On: [Date]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 11.338590000000000000
        Top = 253.228510000000000000
        Width = 179.527675000000000000
      end
    end
  end
  object qryHouseRpt: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HouseID'
    Connection = SCM.scmConnection
    UpdateOptions.KeyFields = 'HouseID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'SELECT House.HouseID'
      #9',Member.MemberID'
      #9',House.Caption AS HouseStr'
      #9',CONCAT ('
      #9#9'Member.FirstName'
      #9#9','#39' '#39
      #9#9',UPPER(Member.LastName)'
      #9#9') AS FNAME'
      #9',SwimClub.Caption AS ClubName'
      #9',SwimClub.NickName'
      'FROM House'
      'INNER JOIN Member ON House.HouseID = Member.HouseID'
      'INNER JOIN SwimClub ON Member.SwimClubID = SwimClub.SwimClubID'
      'ORDER BY House.HouseID'
      #9',Member.LastName;'
      '')
    Left = 72
    Top = 232
  end
  object frxXLSExport1: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 72
    Top = 296
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 176
    Top = 296
  end
  object frxDSHouseRpt: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = False
    DataSet = qryHouseRpt
    BCDToCurrency = False
    Left = 176
    Top = 232
  end
end
