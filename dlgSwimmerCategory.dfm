object SwimmerCategory: TSwimmerCategory
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Swimmer Categories ...'
  ClientHeight = 598
  ClientWidth = 1012
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 21
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1012
    Height = 557
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1008
    ExplicitHeight = 556
    object TabSheet1: TTabSheet
      Caption = 'Details'
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 998
        Height = 515
        Align = alClient
        BevelEdges = []
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 994
        ExplicitHeight = 514
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 998
          Height = 57
          Align = alTop
          BevelEdges = []
          BevelOuter = bvNone
          TabOrder = 0
          ExplicitWidth = 994
          object Label4: TLabel
            Left = 57
            Top = 30
            Width = 109
            Height = 21
            Caption = 'Display Caption'
            WordWrap = True
          end
          object Label5: TLabel
            Left = 273
            Top = 30
            Width = 47
            Height = 21
            Alignment = taCenter
            Caption = 'ABREV'
            WordWrap = True
          end
          object Label6: TLabel
            Left = 733
            Top = 9
            Width = 70
            Height = 42
            Alignment = taCenter
            Caption = 'Age To (Inclusive)'
            WordWrap = True
          end
          object Label7: TLabel
            Left = 339
            Top = 31
            Width = 253
            Height = 21
            Caption = 'Full description of membership type.'
            WordWrap = True
          end
          object Label8: TLabel
            Left = 682
            Top = 9
            Width = 37
            Height = 42
            Alignment = taCenter
            Caption = 'Age From'
            WordWrap = True
          end
          object Label3: TLabel
            Left = 873
            Top = 30
            Width = 61
            Height = 21
            Alignment = taCenter
            Caption = 'Archived'
            WordWrap = True
          end
          object Label9: TLabel
            Left = 817
            Top = 30
            Width = 42
            Height = 21
            Alignment = taCenter
            Caption = 'Active'
            WordWrap = True
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 57
          Width = 998
          Height = 458
          Align = alClient
          Caption = 'Panel4'
          TabOrder = 1
          ExplicitWidth = 994
          ExplicitHeight = 457
          object DBGrid1: TDBGrid
            Left = 1
            Top = 1
            Width = 996
            Height = 456
            Align = alClient
            BorderStyle = bsNone
            DataSource = dsSwimmerCategory
            DefaultDrawing = False
            Options = [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnCellClick = DBGrid1CellClick
            OnColEnter = DBGrid1ColEnter
            OnColExit = DBGrid1ColExit
            OnDrawColumnCell = DBGrid1DrawColumnCell
            Columns = <
              item
                Expanded = False
                FieldName = 'SwimmerCategoryID'
                Width = 30
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Caption'
                Width = 230
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ABREV'
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
              end
              item
                Expanded = False
                FieldName = 'IsActive'
                Width = 65
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'IsArchived'
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
        Left = 167
        Top = 27
        Width = 418
        Height = 46
        AutoSize = False
        Caption = 'Display a detailed  report of "Swimmer Categories".'
        WordWrap = True
      end
      object Label1: TLabel
        Left = 167
        Top = 115
        Width = 394
        Height = 54
        AutoSize = False
        Caption = 
          'Prepare a table report of the "Swimmer Categories", ready for pr' +
          'inting or export to XLS.'
        WordWrap = True
      end
      object btnSwimCategoryDetailed: TButton
        Left = 24
        Top = 24
        Width = 113
        Height = 29
        Caption = 'Detailed'
        TabOrder = 0
      end
      object btnSwimCategoryTable: TButton
        Left = 24
        Top = 112
        Width = 113
        Height = 29
        Caption = 'Table'
        TabOrder = 1
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 557
    Width = 1012
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 556
    ExplicitWidth = 1008
    DesignSize = (
      1012
      41)
    object btnClose: TButton
      Left = 914
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
      ExplicitLeft = 910
    end
  end
  object qrySwimmerCategory: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SwimmerCategoryID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.SwimmerCategory'
    UpdateOptions.KeyFields = 'SwimmerCategoryID'
    SQL.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @SwimClubID AS INTEGER;'
      ''
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'SELECT [SwimmerCategoryID]'
      '     , [Caption]'
      '     , [LongCaption]'
      '     , [ABREV]'
      '     , [AgeFrom]'
      '     , [AgeTo]'
      '     , [IsActive]'
      '     , [IsArchived]'
      'FROM [dbo].[SwimmerCategory]'
      'WHERE SwimClubID = @SwimClubID'
      'ORDER BY AgeFrom;')
    Left = 128
    Top = 296
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qrySwimmerCategorySwimmerCategoryID: TFDAutoIncField
      FieldName = 'SwimmerCategoryID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qrySwimmerCategoryCaption: TWideStringField
      DisplayLabel = 'Description'
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 64
    end
    object qrySwimmerCategoryLongCaption: TWideStringField
      FieldName = 'LongCaption'
      Origin = 'LongCaption'
      Size = 128
    end
    object qrySwimmerCategoryABREV: TWideStringField
      FieldName = 'ABREV'
      Size = 5
    end
    object qrySwimmerCategoryAgeFrom: TIntegerField
      DisplayLabel = 'Age.From'
      FieldName = 'AgeFrom'
      Origin = 'AgeFrom'
    end
    object qrySwimmerCategoryAgeTo: TIntegerField
      DisplayLabel = 'Age.To'
      FieldName = 'AgeTo'
      Origin = 'AgeTo'
    end
    object qrySwimmerCategoryIsActive: TBooleanField
      FieldName = 'IsActive'
    end
    object qrySwimmerCategoryIsArchived: TBooleanField
      FieldName = 'IsArchived'
    end
  end
  object dsSwimmerCategory: TDataSource
    DataSet = qrySwimmerCategory
    Left = 280
    Top = 296
  end
end
