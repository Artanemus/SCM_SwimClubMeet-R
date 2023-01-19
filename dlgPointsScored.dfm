object PointsScored: TPointsScored
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Score : Points and Divisions'
  ClientHeight = 711
  ClientWidth = 694
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Panel2: TPanel
    Left = 0
    Top = 670
    Width = 694
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      694
      41)
    object btnClose: TButton
      Left = 588
      Top = 6
      Width = 88
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 694
    Height = 670
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Points'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 686
        Height = 638
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lblPlace: TLabel
          Left = 67
          Top = 13
          Width = 30
          Height = 17
          Caption = 'Place'
        end
        object lblPoints: TLabel
          Left = 105
          Top = 13
          Width = 35
          Height = 17
          Caption = 'Points'
        end
        object lbl01: TLabel
          Left = 81
          Top = 39
          Width = 17
          Height = 17
          Caption = '1st'
        end
        object lbl02: TLabel
          Left = 76
          Top = 70
          Width = 22
          Height = 17
          Caption = '2nd'
        end
        object lbl03: TLabel
          Left = 78
          Top = 101
          Width = 20
          Height = 17
          Caption = '3rd'
        end
        object lbl04: TLabel
          Left = 80
          Top = 132
          Width = 18
          Height = 17
          Caption = '4th'
        end
        object lbl05: TLabel
          Left = 80
          Top = 163
          Width = 18
          Height = 17
          Caption = '5th'
        end
        object lbl06: TLabel
          Left = 80
          Top = 194
          Width = 18
          Height = 17
          Caption = '6th'
        end
        object lbl07: TLabel
          Left = 80
          Top = 225
          Width = 18
          Height = 17
          Caption = '7th'
        end
        object lbl08: TLabel
          Left = 80
          Top = 256
          Width = 18
          Height = 17
          Caption = '8th'
        end
        object lbl09: TLabel
          Left = 80
          Top = 287
          Width = 18
          Height = 17
          Caption = '9th'
        end
        object lbl10: TLabel
          Left = 73
          Top = 318
          Width = 25
          Height = 17
          Caption = '10th'
        end
        object lbl11: TLabel
          Left = 208
          Top = 39
          Width = 25
          Height = 17
          Caption = '11th'
        end
        object lbl12: TLabel
          Left = 208
          Top = 70
          Width = 25
          Height = 17
          Caption = '12th'
        end
        object Label6: TLabel
          Left = 138
          Top = 400
          Width = 95
          Height = 17
          Caption = 'Unplaced points'
          Enabled = False
        end
        object Label1: TLabel
          Left = 208
          Top = 101
          Width = 25
          Height = 17
          Caption = '13th'
        end
        object Label7: TLabel
          Left = 208
          Top = 132
          Width = 25
          Height = 17
          Caption = '14th'
        end
        object Label8: TLabel
          Left = 208
          Top = 163
          Width = 25
          Height = 17
          Caption = '15th'
        end
        object Label11: TLabel
          Left = 208
          Top = 194
          Width = 25
          Height = 17
          Caption = '16th'
        end
        object Label12: TLabel
          Left = 208
          Top = 225
          Width = 25
          Height = 17
          Caption = '17th'
        end
        object Label13: TLabel
          Left = 208
          Top = 256
          Width = 25
          Height = 17
          Caption = '18th'
        end
        object Label14: TLabel
          Left = 208
          Top = 284
          Width = 25
          Height = 17
          Caption = '19th'
        end
        object Label15: TLabel
          Left = 208
          Top = 318
          Width = 25
          Height = 17
          Caption = '20th'
        end
        object Label16: TLabel
          Left = 201
          Top = 13
          Width = 30
          Height = 17
          Caption = 'Place'
        end
        object Label17: TLabel
          Left = 239
          Top = 13
          Width = 35
          Height = 17
          Caption = 'Points'
        end
        object Label20: TLabel
          Left = 344
          Top = 39
          Width = 25
          Height = 17
          Caption = '21th'
        end
        object Label21: TLabel
          Left = 344
          Top = 70
          Width = 25
          Height = 17
          Caption = '22th'
        end
        object Label22: TLabel
          Left = 344
          Top = 101
          Width = 25
          Height = 17
          Caption = '23th'
        end
        object Label23: TLabel
          Left = 344
          Top = 132
          Width = 25
          Height = 17
          Caption = '24th'
        end
        object Label24: TLabel
          Left = 337
          Top = 13
          Width = 30
          Height = 17
          Caption = 'Place'
        end
        object Label25: TLabel
          Left = 375
          Top = 13
          Width = 35
          Height = 17
          Caption = 'Points'
        end
        object Label26: TLabel
          Left = 480
          Top = 39
          Width = 25
          Height = 17
          Caption = '31th'
        end
        object Label27: TLabel
          Left = 480
          Top = 70
          Width = 25
          Height = 17
          Caption = '32th'
        end
        object Label28: TLabel
          Left = 344
          Top = 163
          Width = 25
          Height = 17
          Caption = '25th'
        end
        object Label29: TLabel
          Left = 344
          Top = 194
          Width = 25
          Height = 17
          Caption = '26th'
        end
        object Label30: TLabel
          Left = 344
          Top = 225
          Width = 25
          Height = 17
          Caption = '27th'
        end
        object Label31: TLabel
          Left = 344
          Top = 256
          Width = 25
          Height = 17
          Caption = '28th'
        end
        object Label32: TLabel
          Left = 344
          Top = 284
          Width = 25
          Height = 17
          Caption = '29th'
        end
        object Label33: TLabel
          Left = 344
          Top = 318
          Width = 25
          Height = 17
          Caption = '30th'
        end
        object Label34: TLabel
          Left = 473
          Top = 13
          Width = 30
          Height = 17
          Caption = 'Place'
        end
        object Label35: TLabel
          Left = 511
          Top = 13
          Width = 35
          Height = 17
          Caption = 'Points'
        end
        object edtm01: TMaskEdit
          Tag = 1
          Left = 104
          Top = 36
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 0
          Text = ' 4.5'
          OnChange = edtmOnChange
        end
        object edtm02: TMaskEdit
          Tag = 2
          Left = 104
          Top = 67
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 1
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm03: TMaskEdit
          Tag = 3
          Left = 104
          Top = 98
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 2
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm04: TMaskEdit
          Tag = 4
          Left = 104
          Top = 129
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 3
          Text = ' 2.5'
          OnChange = edtmOnChange
        end
        object edtm05: TMaskEdit
          Tag = 5
          Left = 104
          Top = 160
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 4
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm06: TMaskEdit
          Tag = 6
          Left = 105
          Top = 191
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 5
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm07: TMaskEdit
          Tag = 7
          Left = 104
          Top = 222
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 6
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm08: TMaskEdit
          Tag = 8
          Left = 104
          Top = 253
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 7
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm09: TMaskEdit
          Tag = 9
          Left = 104
          Top = 284
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 8
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm10: TMaskEdit
          Tag = 10
          Left = 104
          Top = 315
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 9
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm11: TMaskEdit
          Tag = 11
          Left = 239
          Top = 36
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 10
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm12: TMaskEdit
          Tag = 12
          Left = 239
          Top = 67
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 11
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm00: TMaskEdit
          Left = 239
          Top = 397
          Width = 42
          Height = 25
          Enabled = False
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 32
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm13: TMaskEdit
          Tag = 13
          Left = 239
          Top = 98
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 12
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm14: TMaskEdit
          Tag = 14
          Left = 239
          Top = 129
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 13
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm15: TMaskEdit
          Tag = 15
          Left = 239
          Top = 160
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 14
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm16: TMaskEdit
          Tag = 16
          Left = 239
          Top = 191
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 15
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm17: TMaskEdit
          Tag = 17
          Left = 239
          Top = 222
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 16
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm18: TMaskEdit
          Tag = 18
          Left = 239
          Top = 253
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 17
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm19: TMaskEdit
          Tag = 19
          Left = 239
          Top = 284
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 18
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm20: TMaskEdit
          Tag = 20
          Left = 239
          Top = 315
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 19
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm21: TMaskEdit
          Tag = 21
          Left = 375
          Top = 36
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 20
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm22: TMaskEdit
          Tag = 22
          Left = 375
          Top = 67
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 21
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm23: TMaskEdit
          Tag = 23
          Left = 375
          Top = 98
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 22
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm24: TMaskEdit
          Tag = 24
          Left = 375
          Top = 129
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 23
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm31: TMaskEdit
          Tag = 31
          Left = 511
          Top = 36
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 30
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm32: TMaskEdit
          Tag = 32
          Left = 511
          Top = 67
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 31
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm25: TMaskEdit
          Tag = 25
          Left = 375
          Top = 160
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 24
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm26: TMaskEdit
          Tag = 26
          Left = 375
          Top = 191
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 25
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm27: TMaskEdit
          Tag = 27
          Left = 375
          Top = 222
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 26
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm28: TMaskEdit
          Tag = 28
          Left = 375
          Top = 253
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 27
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm29: TMaskEdit
          Tag = 29
          Left = 375
          Top = 284
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 28
          Text = '  . '
          OnChange = edtmOnChange
        end
        object edtm30: TMaskEdit
          Tag = 30
          Left = 375
          Top = 315
          Width = 42
          Height = 25
          EditMask = '99.9;1;0'
          MaxLength = 4
          TabOrder = 29
          Text = '  . '
          OnChange = edtmOnChange
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Reports'
      object Label10: TLabel
        Left = 167
        Top = 6
        Width = 335
        Height = 17
        Caption = 'Display a report with place and score,  ready for printing.'
      end
      object btnPointsScored: TButton
        Left = 3
        Top = 3
        Width = 158
        Height = 25
        Caption = 'Points Scored'
        TabOrder = 0
        OnClick = btnPointsScoredClick
      end
    end
  end
  object cmdInsertPlace: TFDCommand
    Connection = SCM.scmConnection
    CommandText.Strings = (
      'USE [SwimClubMeet]'
      ';'
      ''
      'DECLARE @SwimClubID AS int;'
      'DECLARE @Place AS int;'
      'DECLARE @Points AS decimal(18,0);'
      ''
      'SET @SwimClubID = :SWIMCLUBID;'
      'SET @Place = :PLACE;'
      
        'SET @Points = :POINTS; -- implicit float to decimal - doesn'#39't ne' +
        'ed CAST'
      ''
      'IF (@SwimClubID > 0)  '
      ''
      'INSERT INTO [dbo].[ScorePoints]'
      '           ([SwimClubID]'
      '           ,[Place]'
      '           ,[Points])'
      '     VALUES'
      '           (@SwimClubID'
      '           ,@Place'
      '           ,@Points)'
      ';')
    ActiveStoredUsage = [auDesignTime]
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'PLACE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'POINTS'
        DataType = ftFloat
        ParamType = ptInput
        Value = 0.000000000000000000
      end>
    Left = 552
    Top = 536
  end
  object cmdDeletePlace: TFDCommand
    Connection = SCM.scmConnection
    CommandText.Strings = (
      'USE [SwimClubMeet]'
      ';'
      ''
      'DECLARE @SwimClubID AS int;'
      'DECLARE @Place AS int;'
      ''
      'SET @SwimClubID = :SWIMCLUBID;'
      'SET @Place = :PLACE;'
      ''
      ''
      'IF (@SwimClubID > 0) '
      ' '
      'DELETE FROM [dbo].[ScorePoints]'
      '      WHERE Place > @Place OR Place IS NULL OR Place = 0'
      ';')
    ActiveStoredUsage = [auDesignTime]
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'PLACE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 552
    Top = 480
  end
  object dsScorePoints: TDataSource
    DataSet = tblScorePoints
    Left = 408
    Top = 584
  end
  object tblScorePoints: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'ScorePointsID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..ScorePoints'
    TableName = 'SwimClubMeet..ScorePoints'
    Left = 336
    Top = 584
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
    Top = 224
  end
  object frxDBDSRptHeader: TfrxDBDataset
    UserName = 'dsHeader'
    CloseDataSource = False
    DataSet = qryRptHeader
    BCDToCurrency = False
    Left = 368
    Top = 224
  end
  object qryPointsScored: TFDQuery
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
      'USE SwimClubMeet;'
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = :SWIMCLUBID; --1;'
      'SELECT [ScorePointsID]'
      '     , [SwimClubID]'
      '     , [Place]'
      '     , [Points]'
      'FROM [SwimClubMeet].[dbo].[ScorePoints]'
      'ORDER BY [Place] ASC')
    Left = 264
    Top = 280
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object frxDSPointsScored: TfrxDBDataset
    UserName = 'frxDS'
    CloseDataSource = True
    DataSet = qryPointsScored
    BCDToCurrency = False
    Left = 368
    Top = 280
  end
  object frxPointsScored: TfrxReport
    Version = '6.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43429.469572048600000000
    ReportOptions.LastChange = 44894.481699907410000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 464
    Top = 280
    Datasets = <
      item
        DataSet = frxDBDSRptHeader
        DataSetName = 'dsHeader'
      end
      item
        DataSet = frxDSPointsScored
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
          Width = 267.296846670000000000
          Height = 18.897650000000000000
          AutoWidth = True
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
          Width = 265.444994810000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataField = 'ClubNickName'
          DataSet = frxDBDSRptHeader
          DataSetName = 'dsHeader'
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsHeader."ClubNickName"]')
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 538.888888890000000000
          Top = 9.806053700000000000
          Width = 175.969731480000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI Semibold'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'PLACE & POINTS SCORED')
          ParentFont = False
          WordWrap = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 253.228510000000000000
        Width = 718.110700000000000000
        object Page: TfrxMemoView
          AllowVectorExport = True
          Left = 279.685220000000000000
          Top = 1.889765000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
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
          Left = 5.112863330000000000
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
          WordWrap = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = [ftBottom]
        Height = 20.039270000000000000
        Top = 173.858380000000000000
        Width = 179.527675000000000000
        DataSet = frxDSPointsScored
        DataSetName = 'frxDS'
        KeepTogether = True
        RowCount = 0
        object frxDSPoints: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 87.962962960000000000
          Top = 0.215694070000000000
          Width = 69.184944810000000000
          Height = 18.897650000000000000
          DataField = 'Points'
          DataSet = frxDSPointsScored
          DataSetName = 'frxDS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDS."Points"]')
          ParentFont = False
        end
        object frxDSPlace: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 20.407407410000000000
          Top = 0.215694070000000000
          Width = 64.518278140000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSet = frxDSPointsScored
          DataSetName = 'frxDS'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDS."Place"]')
          ParentFont = False
        end
      end
      object ColumnHeader1: TfrxColumnHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 90.708720000000000000
        Width = 179.527675000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 21.185185190000000000
          Top = 0.032020740000000000
          Width = 51.895657410000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'PLACE')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 87.962962960000000000
          Top = -0.930942220000000000
          Width = 65.784546300000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'POINTS')
          ParentFont = False
        end
      end
    end
  end
end
