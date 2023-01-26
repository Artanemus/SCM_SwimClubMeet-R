object MembershipType: TMembershipType
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Membership Type ...'
  ClientHeight = 598
  ClientWidth = 853
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 853
    Height = 557
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Details'
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 839
        Height = 519
        Align = alClient
        BevelEdges = []
        BevelOuter = bvNone
        TabOrder = 0
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 839
          Height = 41
          Align = alTop
          BevelEdges = []
          BevelOuter = bvNone
          TabOrder = 0
          object Label4: TLabel
            Left = 17
            Top = 12
            Width = 91
            Height = 17
            Caption = 'Display Caption'
            WordWrap = True
          end
          object Label5: TLabel
            Left = 576
            Top = 0
            Width = 59
            Height = 34
            Alignment = taCenter
            Caption = 'Used for Swimmers'
            WordWrap = True
          end
          object Label6: TLabel
            Left = 720
            Top = 0
            Width = 56
            Height = 34
            Alignment = taCenter
            Caption = 'Age To (Inclusive)'
            WordWrap = True
          end
          object Label7: TLabel
            Left = 224
            Top = 12
            Width = 213
            Height = 17
            Caption = 'Full description of membership type.'
            WordWrap = True
          end
          object Label8: TLabel
            Left = 656
            Top = 0
            Width = 30
            Height = 34
            Alignment = taCenter
            Caption = 'Age From'
            WordWrap = True
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 41
          Width = 839
          Height = 478
          Align = alClient
          Caption = 'Panel4'
          TabOrder = 1
          object DBGrid1: TDBGrid
            Left = 1
            Top = 1
            Width = 837
            Height = 476
            Align = alClient
            DataSource = dsMembershipType
            DefaultDrawing = False
            Options = [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -13
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnCellClick = DBGrid1CellClick
            OnColEnter = DBGrid1ColEnter
            OnColExit = DBGrid1ColExit
            OnDrawColumnCell = DBGrid1DrawColumnCell
            Columns = <
              item
                Expanded = False
                FieldName = 'MembershipTypeID'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'Caption'
                Width = 207
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'LongCaption'
                Title.Caption = 'Notes'
                Width = 350
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'IsSwimmer'
                Width = 76
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Sort'
                Visible = False
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'AgeFrom'
                Width = 65
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'AgeTo'
                Width = 65
                Visible = True
              end>
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Report'
      ImageIndex = 2
      object Label2: TLabel
        Left = 116
        Top = 24
        Width = 315
        Height = 39
        AutoSize = False
        Caption = 
          'Display a detailed membership type report for each active club m' +
          'ember. Ordered by membership type.'
        WordWrap = True
      end
      object Label1: TLabel
        Left = 116
        Top = 72
        Width = 315
        Height = 39
        AutoSize = False
        Caption = 
          'Prepare a report of the membership type table, ready for printin' +
          'g.'
        WordWrap = True
      end
      object btnMemShipTypeMember: TButton
        Left = 24
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Member'
        TabOrder = 0
      end
      object btnMemShipTypeTable: TButton
        Left = 24
        Top = 72
        Width = 75
        Height = 25
        Caption = 'Table'
        TabOrder = 1
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 557
    Width = 853
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      853
      41)
    object btnClose: TButton
      Left = 771
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object qryMembershipType: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    UpdateOptions.UpdateTableName = 'SwimClubMeet..MembershipType'
    UpdateOptions.KeyFields = 'MembershipTypeID'
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ';'
      ''
      'DECLARE @StartOfSwimSeason AS DATETIME;'
      'DECLARE @SwimClubID AS INTEGER;'
      ''
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      
        'SELECT @StartOfSwimSeason =  [StartOfSwimSeason] FROM SwimClub W' +
        'HERE SwimClubID = @SwimClubID;'
      'IF (@StartOfSwimSeason IS NULL)'
      '   SET  @StartOfSwimSeason = GETDATE();'
      ''
      ''
      'SELECT [MembershipTypeID]'
      '      ,[Caption]'
      '      ,[LongCaption]'
      '      ,[IsSwimmer]'
      '      ,[Sort]'
      '      ,[AgeFrom]'
      '      ,[AgeTo]'
      ',@StartOfSwimSeason AS StartOfSwimSeason'
      '  FROM [dbo].[MembershipType]'
      'ORDER BY Sort;')
    Left = 128
    Top = 296
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qryMembershipTypeMembershipTypeID: TFDAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'MembershipTypeID'
      Origin = 'MembershipTypeID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryMembershipTypeCaption: TWideStringField
      DisplayLabel = 'Description'
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 64
    end
    object qryMembershipTypeIsSwimmer: TBooleanField
      FieldName = 'IsSwimmer'
      Origin = 'IsSwimmer'
    end
    object qryMembershipTypeSort: TIntegerField
      FieldName = 'Sort'
      Origin = 'Sort'
    end
    object qryMembershipTypeAgeFrom: TIntegerField
      DisplayLabel = 'Age.From'
      FieldName = 'AgeFrom'
      Origin = 'AgeFrom'
    end
    object qryMembershipTypeAgeTo: TIntegerField
      DisplayLabel = 'Age.To'
      FieldName = 'AgeTo'
      Origin = 'AgeTo'
    end
    object qryMembershipTypeLongCaption: TWideStringField
      FieldName = 'LongCaption'
      Origin = 'LongCaption'
      Size = 128
    end
    object qryMembershipTypeStartOfSwimSeason: TSQLTimeStampField
      FieldName = 'StartOfSwimSeason'
      Origin = 'StartOfSwimSeason'
      ReadOnly = True
    end
  end
  object dsMembershipType: TDataSource
    DataSet = qryMembershipType
    Left = 232
    Top = 296
  end
end
