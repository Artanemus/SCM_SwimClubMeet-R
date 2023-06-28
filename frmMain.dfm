object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 939
  ClientWidth = 1414
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  TextHeight = 21
  object pnlPageControl: TPanel
    Left = 0
    Top = 112
    Width = 1414
    Height = 798
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 1410
    ExplicitHeight = 797
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 1414
      Height = 798
      ActivePage = TabSheet1
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      OnChange = PageControl1Change
      OnChanging = PageControl1Changing
      ExplicitWidth = 1410
      ExplicitHeight = 797
      object TabSheet1: TTabSheet
        Caption = 'Session'
        object pnlSessionLeft: TPanel
          Left = 0
          Top = 0
          Width = 729
          Height = 759
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object pnlSessLeftTop: TPanel
            Left = 0
            Top = 0
            Width = 729
            Height = 20
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object lblSessionCaption: TLabel
              Left = 8
              Top = -3
              Width = 72
              Height = 21
              Caption = 'SESSIONS'
            end
          end
          object Session_Grid: TDBGrid
            AlignWithMargins = True
            Left = 10
            Top = 20
            Width = 649
            Height = 739
            Margins.Left = 10
            Margins.Top = 0
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alClient
            DataSource = SCM.dsSession
            DefaultDrawing = False
            PopupMenu = pumSession
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnDrawColumnCell = Session_GridDrawColumnCell
          end
          object SessionWidgets: TRelativePanel
            Left = 669
            Top = 20
            Width = 60
            Height = 739
            ControlCollection = <
              item
                Control = spbtnSessionToggleVisible
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = True
                AlignVerticalCenterWithPanel = False
              end
              item
                Control = ShapeSessBar1
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnSessionToggleVisible
              end
              item
                Control = spbtnSessionToggleLock
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = ShapeSessBar1
              end
              item
                Control = spbtnSessionNew
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnSessionToggleLock
              end
              item
                Control = spbtnSessionDelete
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnSessionNew
              end
              item
                Control = ShapeSessBar2
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnSessionDelete
              end
              item
                Control = spbtnSessionReport
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = ShapeSessBar2
              end
              item
                Control = ShapeSessDot1
                AlignBottomWith = spbtnSessionReport
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = False
                AlignLeftWithPanel = True
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
              end>
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 2
            DesignSize = (
              60
              739)
            object spbtnSessionToggleVisible: TSpeedButton
              Left = 6
              Top = 0
              Width = 48
              Height = 48
              Action = Session_ToggleVisible
              AllowAllUp = True
              Anchors = []
              GroupIndex = 1
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
            end
            object ShapeSessBar1: TShape
              AlignWithMargins = True
              Left = 6
              Top = 58
              Width = 48
              Height = 4
              Margins.Left = 0
              Margins.Top = 10
              Margins.Right = 0
              Margins.Bottom = 10
              Anchors = []
              Brush.Color = 8421631
            end
            object spbtnSessionToggleLock: TSpeedButton
              Left = 6
              Top = 72
              Width = 48
              Height = 48
              Hint = 'Lock-Unlock the session.'
              Action = Session_ToggleLock
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
            end
            object spbtnSessionNew: TSpeedButton
              Left = 6
              Top = 120
              Width = 48
              Height = 48
              Action = Session_New
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnSessionDelete: TSpeedButton
              Left = 6
              Top = 168
              Width = 48
              Height = 48
              Action = Session_Delete
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object ShapeSessBar2: TShape
              AlignWithMargins = True
              Left = 6
              Top = 226
              Width = 48
              Height = 4
              Margins.Left = 0
              Margins.Top = 10
              Margins.Right = 0
              Margins.Bottom = 10
              Anchors = []
              Brush.Color = 8421631
            end
            object spbtnSessionReport: TSpeedButton
              Left = 6
              Top = 240
              Width = 48
              Height = 48
              Action = Session_Report
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object ShapeSessDot1: TShape
              Left = 0
              Top = 278
              Width = 20
              Height = 10
              Anchors = []
              Brush.Color = 8421631
              Shape = stCircle
            end
          end
        end
        object pnlSessionClient: TPanel
          Left = 729
          Top = 0
          Width = 677
          Height = 759
          Align = alClient
          BevelOuter = bvNone
          Caption = 'pnlSessionClient'
          TabOrder = 1
          object pnlSessClientTop: TPanel
            Left = 0
            Top = 0
            Width = 677
            Height = 20
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lblSessionEventCaption: TLabel
              Left = 6
              Top = -3
              Width = 55
              Height = 21
              Caption = 'EVENTS'
            end
          end
          object Panel7: TPanel
            Left = 0
            Top = 20
            Width = 677
            Height = 739
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel7'
            TabOrder = 1
            object Event_Grid: TDBGrid
              AlignWithMargins = True
              Left = 10
              Top = 0
              Width = 597
              Height = 739
              Margins.Left = 10
              Margins.Top = 0
              Margins.Right = 10
              Margins.Bottom = 0
              Align = alClient
              DataSource = SCM.dsEvent
              Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgTitleClick, dgTitleHotTrack]
              PopupMenu = pumEvent
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -16
              TitleFont.Name = 'Segoe UI'
              TitleFont.Style = []
              OnDrawColumnCell = Event_GridDrawColumnCell
              OnKeyDown = Event_GridKeyDown
            end
            object EventWidgets: TRelativePanel
              Left = 617
              Top = 0
              Width = 60
              Height = 739
              ControlCollection = <
                item
                  Control = ShapeBarEv1
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = True
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = False
                  AlignVerticalCenterWithPanel = False
                  Below = spbtnEventToggleGridView
                end
                item
                  Control = ShapeBarEv2
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = True
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = False
                  AlignVerticalCenterWithPanel = False
                  Below = spbtnEventDelete
                end
                item
                  Control = ShapeDotEv1
                  AlignBottomWith = spbtnEventReport
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = False
                  AlignLeftWithPanel = True
                  AlignRightWithPanel = False
                  AlignTopWithPanel = False
                  AlignVerticalCenterWithPanel = False
                end
                item
                  Control = spbtnEventDelete
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = True
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = False
                  AlignVerticalCenterWithPanel = False
                  Below = spbtnEventNew
                end
                item
                  Control = spbtnEventMoveDown
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = True
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = False
                  AlignVerticalCenterWithPanel = False
                  Below = spbtnEventMoveUp
                end
                item
                  Control = spbtnEventMoveUp
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = True
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = False
                  AlignVerticalCenterWithPanel = False
                  Below = ShapeBarEv1
                end
                item
                  Control = spbtnEventNew
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = True
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = False
                  AlignVerticalCenterWithPanel = False
                  Below = spbtnEventMoveDown
                end
                item
                  Control = spbtnEventReport
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = True
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = False
                  AlignVerticalCenterWithPanel = False
                  Below = ShapeBarEv2
                end
                item
                  Control = spbtnEventToggleGridView
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = True
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = True
                  AlignVerticalCenterWithPanel = False
                end>
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 1
              DesignSize = (
                60
                739)
              object ShapeBarEv1: TShape
                AlignWithMargins = True
                Left = 6
                Top = 58
                Width = 48
                Height = 4
                Margins.Left = 0
                Margins.Top = 10
                Margins.Right = 0
                Margins.Bottom = 10
                Anchors = []
                Brush.Color = 8421631
              end
              object ShapeBarEv2: TShape
                AlignWithMargins = True
                Left = 6
                Top = 274
                Width = 48
                Height = 4
                Margins.Left = 0
                Margins.Top = 10
                Margins.Right = 0
                Margins.Bottom = 10
                Anchors = []
                Brush.Color = 8421631
              end
              object ShapeDotEv1: TShape
                AlignWithMargins = True
                Left = 0
                Top = 326
                Width = 20
                Height = 10
                Margins.Left = 0
                Margins.Top = 10
                Margins.Right = 0
                Margins.Bottom = 10
                Anchors = []
                Brush.Color = 8421631
                Shape = stCircle
              end
              object spbtnEventDelete: TSpeedButton
                Left = 6
                Top = 216
                Width = 48
                Height = 48
                Action = Event_Delete
                Anchors = []
                Images = VirtualImageList1
                Flat = True
                Layout = blGlyphTop
                Margin = 0
                NumGlyphs = 2
              end
              object spbtnEventMoveDown: TSpeedButton
                Left = 6
                Top = 120
                Width = 48
                Height = 48
                Action = Event_MoveDown
                Anchors = []
                Images = VirtualImageList1
                Flat = True
                Layout = blGlyphTop
                Margin = 0
                NumGlyphs = 2
              end
              object spbtnEventMoveUp: TSpeedButton
                Left = 6
                Top = 72
                Width = 48
                Height = 48
                Action = Event_MoveUp
                Anchors = []
                Images = VirtualImageList1
                Flat = True
                Layout = blGlyphTop
                Margin = 0
                NumGlyphs = 2
              end
              object spbtnEventNew: TSpeedButton
                Left = 6
                Top = 168
                Width = 48
                Height = 48
                Action = Event_NewRecord
                Anchors = []
                Images = VirtualImageList1
                Flat = True
                Layout = blGlyphTop
                Margin = 0
                NumGlyphs = 2
              end
              object spbtnEventReport: TSpeedButton
                Left = 6
                Top = 288
                Width = 48
                Height = 48
                Action = Event_Report
                Anchors = []
                Images = VirtualImageList1
                Flat = True
                Layout = blGlyphTop
                Margin = 0
                NumGlyphs = 2
              end
              object spbtnEventToggleGridView: TSpeedButton
                Left = 6
                Top = 0
                Width = 48
                Height = 48
                Action = Event_ToggleGridView
                AllowAllUp = True
                Anchors = []
                Images = VirtualImageList1
                Flat = True
                Layout = blGlyphTop
                Margin = 0
              end
            end
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Nominate'
        ImageIndex = 1
        object NominateBackPanel: TRelativePanel
          Left = 0
          Top = 0
          Width = 1406
          Height = 759
          ControlCollection = <
            item
              Control = NominateCenteredPanel
              AlignBottomWithPanel = True
              AlignHorizontalCenterWithPanel = True
              AlignLeftWithPanel = False
              AlignRightWithPanel = False
              AlignTopWithPanel = True
              AlignVerticalCenterWithPanel = False
            end
            item
              Control = lblNomWarning
              AlignBottomWithPanel = False
              AlignHorizontalCenterWithPanel = False
              AlignLeftWithPanel = False
              AlignRightWithPanel = False
              AlignTopWithPanel = False
              AlignVerticalCenterWithPanel = False
            end>
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            1406
            759)
          object NominateCenteredPanel: TPanel
            Left = 181
            Top = 0
            Width = 1044
            Height = 759
            Anchors = []
            BevelOuter = bvNone
            TabOrder = 0
            object NominateQuickPick: TRelativePanel
              AlignWithMargins = True
              Left = 0
              Top = 10
              Width = 352
              Height = 739
              Margins.Left = 0
              Margins.Top = 10
              Margins.Right = 0
              Margins.Bottom = 10
              ControlCollection = <
                item
                  Control = Nominate_Edit
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = False
                  AlignLeftWithPanel = True
                  AlignRightWithPanel = True
                  AlignTopWithPanel = True
                  AlignVerticalCenterWithPanel = False
                end
                item
                  Control = VirtualImage1
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = False
                  AlignLeftWithPanel = True
                  AlignRightWithPanel = False
                  AlignTopWithPanel = True
                  AlignVerticalCenterWithPanel = False
                end
                item
                  Control = Nominate_Grid
                  AlignBottomWithPanel = True
                  AlignHorizontalCenterWithPanel = False
                  AlignLeftWithPanel = True
                  AlignRightWithPanel = True
                  AlignTopWithPanel = True
                  AlignVerticalCenterWithPanel = False
                end
                item
                  Control = btnClearSearch
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = False
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = True
                  AlignTopWithPanel = True
                  AlignVerticalCenterWithPanel = False
                end>
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              DesignSize = (
                352
                739)
              object Nominate_Edit: TEdit
                AlignWithMargins = True
                Left = 40
                Top = 0
                Width = 232
                Height = 29
                Margins.Left = 40
                Margins.Top = 0
                Margins.Right = 80
                Margins.Bottom = 0
                Align = alTop
                TabOrder = 0
                OnChange = Nominate_EditChange
              end
              object VirtualImage1: TVirtualImage
                Left = 0
                Top = 0
                Width = 33
                Height = 32
                Anchors = []
                ImageCollection = ImageCollection1
                ImageWidth = 0
                ImageHeight = 0
                ImageIndex = 0
                ImageName = 'Search'
              end
              object Nominate_Grid: TDBGrid
                AlignWithMargins = True
                Left = 0
                Top = 40
                Width = 352
                Height = 699
                Margins.Left = 0
                Margins.Top = 40
                Margins.Right = 0
                Margins.Bottom = 0
                DataSource = SCM.dsNominateMembers
                DefaultDrawing = False
                Options = [dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
                PopupMenu = pumNominate
                TabOrder = 1
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -16
                TitleFont.Name = 'Segoe UI'
                TitleFont.Style = []
                OnDrawColumnCell = Nominate_GridDrawColumnCell
                OnDblClick = Nominate_GridDblClick
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'FName'
                    Width = 310
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'MemberID'
                    Title.Caption = 'ID'
                    Visible = False
                  end
                  item
                    Expanded = False
                    FieldName = 'GenderID'
                    Visible = False
                  end
                  item
                    Expanded = False
                    FieldName = 'FullName'
                    Visible = False
                  end>
              end
              object btnClearSearch: TButton
                Tag = 1
                Left = 277
                Top = 0
                Width = 75
                Height = 32
                Hint = 'Clear the house name.'
                Anchors = []
                Caption = 'Clear'
                ImageIndex = 0
                ImageName = 'ClearBackSpace'
                Images = VirtualImageList3
                TabOrder = 2
                OnClick = btnClearSearchClick
              end
            end
            object NominateWidgets: TRelativePanel
              AlignWithMargins = True
              Left = 352
              Top = 48
              Width = 60
              Height = 711
              Margins.Left = 0
              Margins.Top = 48
              Margins.Right = 0
              Margins.Bottom = 0
              ControlCollection = <
                item
                  Control = spbtnNominateSortMember
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = True
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = True
                  AlignVerticalCenterWithPanel = False
                end
                item
                  Control = ShapeNomBar1
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = True
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = False
                  AlignVerticalCenterWithPanel = False
                  Below = spbtnNominateSortMember
                end
                item
                  Control = spbtnNominateReport
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = True
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = False
                  AlignVerticalCenterWithPanel = False
                  Below = ShapeNomBar1
                end
                item
                  Control = ShapeNomDot1
                  AlignBottomWith = spbtnNominateReport
                  AlignBottomWithPanel = False
                  AlignHorizontalCenterWithPanel = False
                  AlignLeftWithPanel = True
                  AlignRightWithPanel = False
                  AlignTopWithPanel = False
                  AlignVerticalCenterWithPanel = False
                end>
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 1
              DesignSize = (
                60
                711)
              object spbtnNominateSortMember: TSpeedButton
                Left = 6
                Top = 0
                Width = 48
                Height = 48
                Action = Nominate_SortMembers
                AllowAllUp = True
                Anchors = []
                Images = VirtualImageList1
                Flat = True
                Layout = blGlyphTop
                Margin = 0
              end
              object ShapeNomBar1: TShape
                AlignWithMargins = True
                Left = 6
                Top = 58
                Width = 48
                Height = 4
                Margins.Left = 0
                Margins.Top = 10
                Margins.Right = 0
                Margins.Bottom = 10
                Anchors = []
                Brush.Color = 8421631
              end
              object spbtnNominateReport: TSpeedButton
                Left = 6
                Top = 72
                Width = 48
                Height = 48
                Hint = 'Create and display a nominee'#39's report.'
                Action = Nominate_Report
                Anchors = []
                Images = VirtualImageList1
                Flat = True
                Layout = blGlyphTop
                Margin = 0
                NumGlyphs = 2
              end
              object ShapeNomDot1: TShape
                Left = 0
                Top = 110
                Width = 20
                Height = 10
                Anchors = []
                Brush.Color = 8421631
                Shape = stCircle
              end
            end
            object NominateRightPanel: TRelativePanel
              AlignWithMargins = True
              Left = 514
              Top = 10
              Width = 530
              Height = 739
              Margins.Left = 0
              Margins.Top = 10
              Margins.Right = 0
              Margins.Bottom = 10
              ControlCollection = <
                item
                  Control = Nominate_ControlList
                  AlignBottomWithPanel = True
                  AlignHorizontalCenterWithPanel = False
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = True
                  AlignTopWithPanel = True
                  AlignVerticalCenterWithPanel = False
                end
                item
                  Control = dbtxtNominateFullName
                  AlignBottomWithPanel = True
                  AlignHorizontalCenterWithPanel = False
                  AlignLeftWithPanel = False
                  AlignRightWithPanel = False
                  AlignTopWithPanel = True
                  AlignVerticalCenterWithPanel = False
                  LeftOf = Nominate_ControlList
                end>
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 2
              object Nominate_ControlList: TControlList
                Left = 57
                Top = 0
                Width = 473
                Height = 739
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                Align = alRight
                Anchors = []
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Segoe UI'
                Font.Style = []
                ItemHeight = 48
                ItemMargins.Left = 0
                ItemMargins.Top = 0
                ItemMargins.Right = 0
                ItemMargins.Bottom = 0
                ParentColor = False
                ParentFont = False
                PopupMenu = pumHeat
                TabOrder = 0
                OnBeforeDrawItem = Nominate_ControlListBeforeDrawItem
                object clistEventDistStrokeStr: TLabel
                  Left = 91
                  Top = 5
                  Width = 210
                  Height = 21
                  Caption = 'Control List Distance Stroke'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object clistEventCaption: TLabel
                  Left = 91
                  Top = 24
                  Width = 4
                  Height = 17
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object clistCheckBox: TControlListButton
                  AlignWithMargins = True
                  Left = 5
                  Top = 1
                  Width = 40
                  Height = 40
                  Margins.Left = 0
                  Margins.Top = 0
                  Margins.Right = 0
                  Margins.Bottom = 0
                  Images = VirtualImageList2
                  ImageIndex = 0
                  ImageName = 'UnChecked'
                  Layout = blGlyphTop
                  LinkHotColor = clHighlight
                  Style = clbkToolButton
                  OnClick = clistCheckBoxClick
                end
                object vimage: TVirtualImage
                  Left = 45
                  Top = 1
                  Width = 40
                  Height = 40
                  ImageCollection = ImageCollection1
                  ImageWidth = 0
                  ImageHeight = 0
                  ImageIndex = 24
                  ImageName = 'Qualify'
                end
              end
              object dbtxtNominateFullName: TDBText
                AlignWithMargins = True
                Left = 12
                Top = 40
                Width = 45
                Height = 696
                Margins.Top = 40
                Margins.Right = 0
                Align = alRight
                Anchors = []
                AutoSize = True
                DataField = 'FullName'
                DataSource = SCM.dsNominateMembers
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -32
                Font.Name = 'Segoe UI'
                Font.Orientation = 900
                Font.Style = []
                ParentFont = False
              end
            end
          end
          object lblNomWarning: TLabel
            Left = 134
            Top = 53
            Width = 45
            Height = 187
            Alignment = taCenter
            Anchors = []
            Caption = 'No Members'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Orientation = 900
            Font.Style = []
            ParentFont = False
            Visible = False
            WordWrap = True
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Heats'
        ImageIndex = 2
        object HeatRightPanel: TPanel
          AlignWithMargins = True
          Left = 282
          Top = 147
          Width = 1104
          Height = 602
          Margins.Left = 0
          Margins.Top = 10
          Margins.Right = 20
          Margins.Bottom = 10
          Align = alClient
          BevelOuter = bvNone
          Caption = 'HeatRightPanel'
          TabOrder = 0
          ExplicitWidth = 1100
          ExplicitHeight = 601
          object Entrant_Grid: TDBGrid
            Left = 0
            Top = 0
            Width = 1044
            Height = 602
            Margins.Left = 60
            Align = alClient
            Anchors = []
            DataSource = SCM.dsEntrant
            DefaultDrawing = False
            Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgTitleClick, dgTitleHotTrack]
            PopupMenu = pumEntrant
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnCellClick = Entrant_GridCellClick
            OnColEnter = Entrant_GridColEnter
            OnColExit = Entrant_GridColExit
            OnDrawColumnCell = Entrant_GridDrawColumnCell
            OnEditButtonClick = Entrant_GridEditButtonClick
            OnEnter = Entrant_GridEnter
            OnKeyDown = Entrant_GridKeyDown
          end
          object EntrantWidgets: TRelativePanel
            Left = 1044
            Top = 0
            Width = 60
            Height = 602
            ControlCollection = <
              item
                Control = spbtnEntrantDown
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnEntrantUp
              end
              item
                Control = spbtnEntrantEmptyLane
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnEntrantSwapLanes
              end
              item
                Control = spbtnEntrantScratchLane
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnEntrantEmptyLane
              end
              item
                Control = spbtnEntrantSwapLanes
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnEntrantDown
              end
              item
                Control = spbtnEntrantUp
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = True
                AlignVerticalCenterWithPanel = False
              end
              item
                Control = spbtnEntrantSort
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnEntrantScratchLane
              end>
            Align = alRight
            Anchors = []
            BevelOuter = bvNone
            TabOrder = 1
            ExplicitLeft = 1040
            ExplicitHeight = 601
            DesignSize = (
              60
              602)
            object spbtnEntrantDown: TSpeedButton
              Left = 6
              Top = 48
              Width = 48
              Height = 48
              Action = Entrant_MoveDown
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnEntrantEmptyLane: TSpeedButton
              Left = 6
              Top = 144
              Width = 48
              Height = 48
              Action = Entrant_EmptyLane
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnEntrantScratchLane: TSpeedButton
              Left = 6
              Top = 192
              Width = 48
              Height = 48
              Action = Entrant_Strike
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnEntrantSwapLanes: TSpeedButton
              Left = 6
              Top = 96
              Width = 48
              Height = 48
              Action = Entrant_SwapLanes
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnEntrantUp: TSpeedButton
              Left = 6
              Top = 0
              Width = 48
              Height = 48
              Action = Entrant_MoveUp
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnEntrantSort: TSpeedButton
              Left = 6
              Top = 240
              Width = 48
              Height = 48
              Action = Entrant_Sort
              Anchors = []
              ImageIndex = 37
              ImageName = 'Sort'
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
          end
        end
        object HeatNavigationPanel: TRelativePanel
          AlignWithMargins = True
          Left = 0
          Top = 10
          Width = 1406
          Height = 117
          Margins.Left = 0
          Margins.Top = 10
          Margins.Right = 0
          Margins.Bottom = 10
          ControlCollection = <
            item
              Control = dbnavEventNavigatePrior
              AlignBottomWithPanel = False
              AlignHorizontalCenterWithPanel = False
              AlignLeftWithPanel = True
              AlignRightWithPanel = False
              AlignTopWithPanel = False
              AlignVerticalCenterWithPanel = True
            end
            item
              Control = dbnavEventNavigateNext
              AlignBottomWithPanel = False
              AlignHorizontalCenterWithPanel = False
              AlignLeftWithPanel = False
              AlignRightWithPanel = True
              AlignTopWithPanel = False
              AlignVerticalCenterWithPanel = True
            end
            item
              Control = HeatNavigateControlList
              AlignBottomWithPanel = False
              AlignHorizontalCenterWithPanel = False
              AlignLeftWithPanel = True
              AlignRightWithPanel = True
              AlignTopWithPanel = False
              AlignVerticalCenterWithPanel = True
            end>
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          ExplicitWidth = 1402
          DesignSize = (
            1406
            117)
          object dbnavEventNavigatePrior: TDBNavigator
            AlignWithMargins = True
            Left = 10
            Top = 19
            Width = 58
            Height = 78
            Margins.Left = 10
            Margins.Top = 0
            Margins.Bottom = 0
            VisibleButtons = [nbPrior]
            Anchors = []
            TabOrder = 0
          end
          object dbnavEventNavigateNext: TDBNavigator
            AlignWithMargins = True
            Left = 1338
            Top = 19
            Width = 58
            Height = 78
            Margins.Top = 0
            Margins.Right = 10
            Margins.Bottom = 0
            VisibleButtons = [nbNext]
            Anchors = []
            TabOrder = 1
          end
          object HeatNavigateControlList: TControlList
            AlignWithMargins = True
            Left = 66
            Top = 14
            Width = 1274
            Height = 89
            Margins.Left = 66
            Margins.Top = 0
            Margins.Right = 66
            Margins.Bottom = 0
            Anchors = []
            ItemCount = 34
            ItemWidth = 200
            ItemHeight = 68
            ItemIndex = 0
            ItemMargins.Left = 10
            ItemMargins.Top = 0
            ItemMargins.Right = 10
            ItemMargins.Bottom = 0
            ColumnLayout = cltMultiLeftToRight
            ParentColor = False
            TabOrder = 2
            OnBeforeDrawItem = HeatNavigateControlListBeforeDrawItem
            object ShapeHeatNavBlackLine: TShape
              Left = 67
              Top = 29
              Width = 65
              Height = 2
              Brush.Style = bsClear
              Pen.Color = clDefault
              Pen.Width = 2
            end
            object vimgHeatCircle: TVirtualImage
              Left = 19
              Top = 3
              Width = 52
              Height = 52
              Anchors = []
              Center = True
              ImageCollection = ImageCollection1
              ImageWidth = 0
              ImageHeight = 0
              ImageIndex = 35
              ImageName = 'EvMulti'
            end
            object vimgHeatStroke: TVirtualImage
              Left = 129
              Top = 3
              Width = 52
              Height = 52
              Anchors = []
              Center = True
              ImageCollection = ImageCollection1
              ImageWidth = 0
              ImageHeight = 0
              ImageIndex = 47
              ImageName = 'EmptyFrame'
            end
            object dbtxtEventCaption: TDBText
              Left = 4
              Top = 48
              Width = 190
              Height = 21
              Alignment = taCenter
              Anchors = []
              Color = clWindowText
              DataField = 'Caption'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              StyleElements = [seClient, seBorder]
              WordWrap = True
              ExplicitTop = 46
            end
            object lblHeatNavigatorEventNum: TLabel
              Left = 15
              Top = 3
              Width = 60
              Height = 47
              Alignment = taCenter
              Anchors = []
              AutoSize = False
              Caption = '1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -32
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlCenter
            end
            object lblHeatStrokeStr: TLabel
              Left = 127
              Top = 18
              Width = 57
              Height = 21
              Alignment = taCenter
              AutoSize = False
              Caption = 'User'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblHeatNavigatorDistance: TLabel
              Left = 67
              Top = 8
              Width = 65
              Height = 39
              Alignment = taCenter
              Anchors = []
              AutoSize = False
              Caption = '100'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -27
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlCenter
            end
          end
        end
        object HeatLeftPanel: TPanel
          AlignWithMargins = True
          Left = 20
          Top = 137
          Width = 252
          Height = 622
          Margins.Left = 20
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 2
          ExplicitHeight = 621
          object HeatWidgets: TRelativePanel
            AlignWithMargins = True
            Left = 192
            Top = 10
            Width = 60
            Height = 602
            Margins.Left = 0
            Margins.Top = 10
            Margins.Right = 0
            Margins.Bottom = 10
            ControlCollection = <
              item
                Control = spbtnHeatUp
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = True
                AlignVerticalCenterWithPanel = False
              end
              item
                Control = spbtnHeatDown
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnHeatUp
              end
              item
                Control = spbtnHeatToggleStatus
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnHeatDown
              end
              item
                Control = spbtnHeatNew
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = False
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnHeatToggleStatus
              end
              item
                Control = spbtnHeatDelete
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnHeatNew
              end
              item
                Control = ShapeHeatBar1
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnHeatDelete
              end
              item
                Control = spbtnHeatAutoBuild
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = ShapeHeatBar1
              end
              item
                Control = ShapeHeatBar2
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnHeatAutoBuild
              end
              item
                Control = spbtnHeatMarshall
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = ShapeHeatBar2
              end
              item
                Control = spbtnHeatTimeKeeper
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnHeatMarshall
              end
              item
                Control = ShapeHeatBar3
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnHeatBatchPrintSet
              end
              item
                Control = spbtnHeatBatchPrintSet
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = spbtnHeatTimeKeeper
              end
              item
                Control = spbtnHeatReport
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = True
                AlignLeftWithPanel = False
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
                Below = ShapeHeatBar3
              end
              item
                Control = ShapeHeatDot1
                AlignBottomWith = spbtnHeatMarshall
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = False
                AlignLeftWithPanel = True
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
              end
              item
                Control = ShapeHeatDot2
                AlignBottomWith = spbtnHeatTimeKeeper
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = False
                AlignLeftWithPanel = True
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
              end
              item
                Control = ShapeHeatDot3
                AlignBottomWith = spbtnHeatReport
                AlignBottomWithPanel = False
                AlignHorizontalCenterWithPanel = False
                AlignLeftWithPanel = True
                AlignRightWithPanel = False
                AlignTopWithPanel = False
                AlignVerticalCenterWithPanel = False
              end>
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
            ExplicitHeight = 601
            DesignSize = (
              60
              602)
            object spbtnHeatUp: TSpeedButton
              Left = 6
              Top = 0
              Width = 48
              Height = 48
              Action = Heat_MoveUp
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnHeatDown: TSpeedButton
              Left = 6
              Top = 48
              Width = 48
              Height = 48
              Action = Heat_MoveDown
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnHeatToggleStatus: TSpeedButton
              Left = 6
              Top = 96
              Width = 48
              Height = 48
              Action = Heat_ToggleStatus
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnHeatNew: TSpeedButton
              Left = 6
              Top = 144
              Width = 48
              Height = 48
              Action = Heat_NewRecord
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnHeatDelete: TSpeedButton
              Left = 6
              Top = 192
              Width = 48
              Height = 48
              Action = Heat_Delete
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object ShapeHeatBar1: TShape
              AlignWithMargins = True
              Left = 6
              Top = 250
              Width = 48
              Height = 4
              Margins.Left = 0
              Margins.Top = 10
              Margins.Right = 0
              Margins.Bottom = 10
              Anchors = []
              Brush.Color = 8421631
            end
            object spbtnHeatAutoBuild: TSpeedButton
              Left = 6
              Top = 264
              Width = 48
              Height = 48
              Action = Heat_AutoBuild
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object ShapeHeatBar2: TShape
              AlignWithMargins = True
              Left = 6
              Top = 322
              Width = 48
              Height = 4
              Margins.Left = 0
              Margins.Top = 10
              Margins.Right = 0
              Margins.Bottom = 10
              Anchors = []
              Brush.Color = 8421631
            end
            object spbtnHeatMarshall: TSpeedButton
              Left = 6
              Top = 336
              Width = 48
              Height = 48
              Hint = 'Create a marshall'#39's sheet for the heats in this event.'
              Action = Heat_MarshallReport
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnHeatTimeKeeper: TSpeedButton
              Left = 6
              Top = 384
              Width = 48
              Height = 48
              Hint = 'Create a timekeeper'#39's sheet for the selected heat.'
              Action = Heat_TimeKeeperReport
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object ShapeHeatBar3: TShape
              AlignWithMargins = True
              Left = 6
              Top = 490
              Width = 48
              Height = 4
              Margins.Left = 0
              Margins.Top = 10
              Margins.Right = 0
              Margins.Bottom = 10
              Anchors = []
              Brush.Color = 8421631
            end
            object spbtnHeatBatchPrintSet: TSpeedButton
              Left = 6
              Top = 432
              Width = 48
              Height = 48
              Hint = 'Create and print all sheets, both marshall and timekeepers.'
              Action = Heat_PrintSet
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object spbtnHeatReport: TSpeedButton
              Left = 6
              Top = 504
              Width = 48
              Height = 48
              Action = Heat_Report
              Anchors = []
              Images = VirtualImageList1
              Flat = True
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
            end
            object ShapeHeatDot1: TShape
              AlignWithMargins = True
              Left = 5
              Top = 374
              Width = 20
              Height = 10
              Margins.Left = 5
              Anchors = []
              Brush.Color = 8421631
              Shape = stCircle
            end
            object ShapeHeatDot2: TShape
              AlignWithMargins = True
              Left = 5
              Top = 422
              Width = 20
              Height = 10
              Margins.Left = 5
              Anchors = []
              Brush.Color = 8421631
              Shape = stCircle
            end
            object ShapeHeatDot3: TShape
              AlignWithMargins = True
              Left = 5
              Top = 542
              Width = 20
              Height = 10
              Margins.Left = 5
              Anchors = []
              Brush.Color = 8421631
              Shape = stCircle
            end
          end
          object HeatControlList: TControlList
            Left = 0
            Top = 0
            Width = 176
            Height = 622
            Align = alLeft
            BorderStyle = bsNone
            ItemMargins.Left = 0
            ItemMargins.Top = 0
            ItemMargins.Right = 0
            ItemMargins.Bottom = 0
            ParentColor = False
            PopupMenu = pumHeat
            TabOrder = 1
            OnBeforeDrawItem = HeatControlListBeforeDrawItem
            ExplicitHeight = 621
            object vimgHeatNum: TVirtualImage
              Left = 16
              Top = 11
              Width = 48
              Height = 48
              ImageCollection = ImageCollection1
              ImageWidth = 0
              ImageHeight = 0
              ImageIndex = 28
              ImageName = 'EvBlue'
            end
            object clbtnHeatStatus: TControlListButton
              Left = 70
              Top = 11
              Width = 48
              Height = 48
              Images = VirtualImageList1
              ImageIndex = 33
              ImageName = 'HeatOpen'
              Spacing = 0
              Layout = blGlyphTop
              LinkHotColor = clHighlight
              Style = clbkToolButton
              OnClick = Heat_ToggleStatusExecute
            end
            object Label1: TLabel
              Left = 12
              Top = 17
              Width = 54
              Height = 32
              Alignment = taCenter
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -24
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 910
    Width = 1414
    Height = 29
    Panels = <
      item
        Text = 'Session: '
        Width = 300
      end
      item
        Text = 'Nominees:'
        Width = 160
      end
      item
        Text = 'Entrants:'
        Width = 160
      end>
    ParentFont = True
    UseSystemFont = False
    ExplicitTop = 909
    ExplicitWidth = 1410
  end
  object pnlTitleBar: TRelativePanel
    Left = 0
    Top = 31
    Width = 1414
    Height = 81
    ControlCollection = <
      item
        Control = dbimgSwimClubLogo
        AlignBottomWithPanel = True
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = True
        AlignRightWithPanel = False
        AlignTopWithPanel = True
        AlignVerticalCenterWithPanel = False
      end
      item
        Control = pnlClubData
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = True
        RightOf = dbimgSwimClubLogo
      end
      item
        Control = pnlDebugInfo
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = True
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = True
      end
      item
        Control = sbtnRefresh
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = True
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = True
      end
      item
        Control = sbtnMembers
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = True
        LeftOf = sbtnRefresh
      end>
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 1410
    DesignSize = (
      1414
      81)
    object dbimgSwimClubLogo: TDBImage
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 59
      Height = 61
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Anchors = []
      DataField = 'LogoImg'
      DataSource = SCM.dsSwimClub
      Proportional = True
      Stretch = True
      TabOrder = 0
    end
    object pnlClubData: TRelativePanel
      Left = 79
      Top = 15
      Width = 317
      Height = 51
      ControlCollection = <
        item
          Control = dbtxtSwimClubCaption
          AlignBottomWithPanel = False
          AlignHorizontalCenterWithPanel = False
          AlignLeftWithPanel = True
          AlignRightWithPanel = False
          AlignTopWithPanel = True
          AlignVerticalCenterWithPanel = False
        end
        item
          Control = dbtxtSwimClubNickName
          AlignBottomWithPanel = True
          AlignHorizontalCenterWithPanel = False
          AlignLeftWithPanel = True
          AlignRightWithPanel = False
          AlignTopWithPanel = False
          AlignVerticalCenterWithPanel = False
        end>
      Anchors = []
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        317
        51)
      object dbtxtSwimClubCaption: TDBText
        Left = 0
        Top = 0
        Width = 161
        Height = 19
        Anchors = []
        AutoSize = True
        DataField = 'Caption'
        DataSource = SCM.dsSwimClub
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object dbtxtSwimClubNickName: TDBText
        Left = 0
        Top = 30
        Width = 179
        Height = 21
        Anchors = []
        AutoSize = True
        DataField = 'NickName'
        DataSource = SCM.dsSwimClub
      end
    end
    object pnlDebugInfo: TPanel
      Left = 450
      Top = 20
      Width = 513
      Height = 41
      Anchors = []
      BevelOuter = bvNone
      TabOrder = 2
      object dbtxtDebugEntrant: TDBText
        Left = 355
        Top = 21
        Width = 50
        Height = 17
        Alignment = taCenter
        DataField = 'EntrantID'
      end
      object dbtxtDebugSwimClub: TDBText
        Left = 16
        Top = 21
        Width = 50
        Height = 17
        Alignment = taCenter
        DataField = 'SwimClubID'
        DataSource = SCM.dsSwimClub
      end
      object dbtxtDebugSession: TDBText
        Left = 83
        Top = 21
        Width = 50
        Height = 17
        Alignment = taCenter
        DataField = 'SessionID'
        DataSource = SCM.dsSession
      end
      object dbtxtDebugEvent: TDBText
        Left = 150
        Top = 21
        Width = 50
        Height = 17
        Alignment = taCenter
        DataField = 'EventID'
      end
      object dbtxtDebugHeat: TDBText
        Left = 288
        Top = 21
        Width = 50
        Height = 17
        Alignment = taCenter
        DataField = 'HeatID'
      end
      object Label11: TLabel
        Left = 16
        Top = 2
        Width = 32
        Height = 21
        Caption = 'Club'
      end
      object Label12: TLabel
        Left = 82
        Top = 2
        Width = 53
        Height = 21
        Caption = 'Session'
      end
      object Label13: TLabel
        Left = 147
        Top = 2
        Width = 38
        Height = 21
        Caption = 'Event'
      end
      object Label14: TLabel
        Left = 285
        Top = 2
        Width = 32
        Height = 21
        Caption = 'Heat'
      end
      object Label24: TLabel
        Left = 353
        Top = 2
        Width = 50
        Height = 21
        Caption = 'Entrant'
      end
      object Label25: TLabel
        Left = 422
        Top = 2
        Width = 59
        Height = 21
        Caption = 'Member'
      end
      object dbtxtDebugMember: TDBText
        Left = 423
        Top = 21
        Width = 50
        Height = 17
        Alignment = taCenter
        DataField = 'MemberID'
      end
      object Label2: TLabel
        Left = 214
        Top = 2
        Width = 64
        Height = 21
        Caption = 'Nominee'
      end
      object dbtxtDebugNominee: TDBText
        Left = 217
        Top = 21
        Width = 50
        Height = 17
        Alignment = taCenter
        DataField = 'NomineeID'
      end
    end
    object sbtnRefresh: TSpeedButton
      Left = 1366
      Top = 16
      Width = 48
      Height = 48
      Action = SCM_Refresh
      Anchors = []
      Images = VirtualImageList1
      Flat = True
      Layout = blGlyphTop
      Margin = 0
    end
    object sbtnMembers: TSpeedButton
      Left = 1318
      Top = 16
      Width = 48
      Height = 48
      Action = SCM_ManageMembers
      Anchors = []
      Images = VirtualImageList1
      Flat = True
      Layout = blGlyphTop
      Margin = 0
    end
  end
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 1414
    Height = 31
    UseSystemFont = False
    ActionManager = ActionManager1
    Caption = 'ActionMainMenuBar1'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    Spacing = 6
    ExplicitWidth = 1410
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = File_ExportCarnival
                Caption = 'E&xport CarnivalMeet...'
                ImageIndex = 46
                ImageName = 'Export'
              end
              item
                Action = File_ImportCarnival
                Caption = '&Import CarnivalMeet...'
                ImageIndex = 39
                ImageName = 'import'
              end
              item
                Caption = '-'
              end
              item
                Action = File_Exit
                Caption = '&Exit'
                ImageIndex = 38
                ImageName = 'Exit'
              end>
            Caption = '&File'
          end
          item
            Items = <
              item
                Action = Session_ToggleVisible
                Caption = '&Toggle visibility.'
                ImageIndex = 23
                ImageName = 'VisibilityOn'
              end
              item
                Action = Session_ToggleLock
                Caption = '&Lock/Unlock'
                ImageIndex = 21
                ImageName = 'Lock'
                ShortCut = 16460
              end
              item
                Action = Session_New
                Caption = '&New Session...'
                ImageIndex = 20
                ImageName = 'New'
                ShortCut = 16429
              end
              item
                Action = Session_Edit
                Caption = '&Edit Session ...'
                ImageIndex = 45
                ImageName = 'Edit'
              end
              item
                Action = Session_Delete
                Caption = '&Delete Session...'
                ImageIndex = 19
                ImageName = 'Delete'
                ShortCut = 16430
              end
              item
                Action = Session_Report
                Caption = '&Session Report*'
                ImageIndex = 17
                ImageName = 'Report'
              end
              item
                Caption = '-'
              end
              item
                Action = Session_Export
                Caption = 'E&xport Session...'
                ImageIndex = 46
                ImageName = 'Export'
              end
              item
                Action = Session_Import
                Caption = '&Import Session...'
                ImageIndex = 39
                ImageName = 'import'
              end
              item
                Action = Session_Clone
                Caption = '&Clone Session...'
                ImageIndex = 44
                ImageName = 'clone'
              end
              item
                Action = Session_Sort
                Caption = 'S&ort'
                ImageIndex = 8
                ImageName = 'Sync'
              end>
            Caption = '&Session'
          end
          item
            Items = <
              item
                Action = Event_ToggleGridView
                Caption = '&Toggle grid view.'
                ImageIndex = 16
                ImageName = 'GridOn'
              end
              item
                Action = Event_MoveUp
                Caption = '&Move Up'
                ImageIndex = 12
                ImageName = 'Up'
                ShortCut = 16422
              end
              item
                Action = Event_MoveDown
                Caption = 'M&ove Down'
                ImageIndex = 13
                ImageName = 'Down'
                ShortCut = 16424
              end
              item
                Action = Event_NewRecord
                Caption = '&New Event'
                ImageIndex = 20
                ImageName = 'New'
                ShortCut = 16429
              end
              item
                Action = Event_Delete
                Caption = '&Delete Event'
                ImageIndex = 19
                ImageName = 'Delete'
                ShortCut = 16430
              end
              item
                Action = Event_Report
                Caption = '&Event Report*'
                ImageIndex = 17
                ImageName = 'Report'
              end
              item
                Caption = '-'
              end
              item
                Action = Event_BuildFinals
                Caption = '&Build event finals ...'
                ImageIndex = 6
                ImageName = 'AutoBuild'
              end
              item
                Action = Event_BuildSemiFinals
                Caption = 'B&uild event semi-finals ...'
                ImageIndex = 6
                ImageName = 'AutoBuild'
              end
              item
                Action = Event_BuildQuarterFinals
                Caption = 'Bu&ild event quarter-finals ...'
                ImageIndex = 6
                ImageName = 'AutoBuild'
              end
              item
                Caption = '-'
              end
              item
                Action = Event_AutoSchedule
                Caption = '&Auto Schedule...'
                ImageIndex = 47
                ImageName = 'TimeAuto'
              end
              item
                Visible = False
                Action = Event_Renumber
                Caption = '&Renumber Lanes...'
                ImageIndex = 7
                ImageName = 'Cycle'
              end>
            Caption = '&Events'
          end
          item
            Items = <
              item
                Action = Nominate_SortMembers
                Caption = '&Sort on Name'
                ImageIndex = 11
                ImageName = 'Switch'
              end
              item
                Action = Nominate_Report
                Caption = '&Nominate Report*'
                ImageIndex = 17
                ImageName = 'Report'
              end
              item
                Caption = '-'
              end
              item
                Action = Nominate_MemeberDetails
                Caption = '&Member'#39's Details...'
                ImageIndex = 1
                ImageName = 'Members'
              end
              item
                Visible = False
                Action = Nominate_ClearEventNominations
                Caption = '&Clear event nominations... '
              end
              item
                Visible = False
                Action = Nominate_ClearSessionNominations
                Caption = 'C&lear session nominations...'
              end>
            Caption = '&Nominate'
          end
          item
            Items = <
              item
                Action = Heat_MoveUp
                Caption = '&Move Up'
                ImageIndex = 12
                ImageName = 'Up'
                ShortCut = 16422
              end
              item
                Action = Heat_MoveDown
                Caption = 'M&ove Down'
                ImageIndex = 13
                ImageName = 'Down'
                ShortCut = 16424
              end
              item
                Action = Heat_ToggleStatus
                Caption = '&Toggle Heat Status'
                ImageIndex = 36
                ImageName = 'HeatStatusToggle'
                ShortCut = 16468
              end
              item
                Action = Heat_NewRecord
                Caption = '&New Heat...'
                ImageIndex = 20
                ImageName = 'New'
                ShortCut = 16429
              end
              item
                Action = Heat_Delete
                Caption = '&Delete Heat...'
                ImageIndex = 19
                ImageName = 'Delete'
                ShortCut = 16430
              end
              item
                Action = Heat_AutoBuild
                Caption = '&AutoBuild Heats...'
                ImageIndex = 6
                ImageName = 'AutoBuild'
              end
              item
                Action = Heat_MarshallReport
                Caption = 'Ma&rshall sheet*'
                ImageIndex = 4
                ImageName = 'Marshall'
              end
              item
                Action = Heat_TimeKeeperReport
                Caption = 'T&ime Keeper sheet*'
                ImageIndex = 5
                ImageName = 'TimeKeeper'
              end
              item
                Action = Heat_PrintSet
                Caption = '&Print Set'
                ImageIndex = 3
                ImageName = 'BatchPrint'
              end
              item
                Action = Heat_Report
                Caption = '&Heat Report*'
                ImageIndex = 17
                ImageName = 'Report'
              end
              item
                Caption = '-'
              end
              item
                Action = Heat_BatchBuildHeats
                Caption = '&Build ALL Heats...'
                ImageIndex = 6
                ImageName = 'AutoBuild'
              end
              item
                Action = Heat_BatchMarshallReport
                Caption = 'Print A&LL Marshall Reports...'
                ImageIndex = 6
                ImageName = 'AutoBuild'
              end
              item
                Action = Heat_BatchTimeKeeperReport
                Caption = 'Print ALL Tim&ekeeper Reports...'
                ImageIndex = 6
                ImageName = 'AutoBuild'
              end
              item
                Visible = False
                Action = Heat_Renumber
                ImageIndex = 7
                ImageName = 'Cycle'
              end>
            Caption = '&Heats'
          end
          item
            Items = <
              item
                Action = Entrant_MoveUp
                Caption = '&Move Up'
                ImageIndex = 12
                ImageName = 'Up'
                ShortCut = 16422
              end
              item
                Action = Entrant_MoveDown
                Caption = 'M&ove Down'
                ImageIndex = 13
                ImageName = 'Down'
                ShortCut = 16424
              end
              item
                Action = Entrant_SwapLanes
                Caption = '&Swap Lanes...'
                ImageIndex = 10
                ImageName = 'Shuffle'
              end
              item
                Action = Entrant_EmptyLane
                Caption = '&Empty Lane'
                ImageIndex = 19
                ImageName = 'Delete'
                ShortCut = 16472
              end
              item
                Action = Entrant_Strike
                Caption = 'S&trike Entrant'
                ImageIndex = 18
                ImageName = 'DeleteForever'
                ShortCut = 16430
              end
              item
                Action = Entrant_Renumber
                Caption = '&Renumber Lanes'
                ImageIndex = 37
                ImageName = 'Sort'
              end
              item
                Action = Entrant_GotoMemberDetails
                Caption = 'Mem&ber'#39's Details...'
                ImageIndex = 1
                ImageName = 'Members'
              end
              item
                Visible = False
                Action = Entrant_Sort
              end>
            Caption = 'En&trants'
          end
          item
            Items = <
              item
                Action = Tools_QualifyTimes
                Caption = '&Qualify Times...'
              end
              item
                Action = Tools_Swimmercategory
              end
              item
                Visible = False
                Action = Tools_ConnectionManager
                Caption = '&Connection...'
              end
              item
                Action = Tools_House
                Caption = '&House...'
              end
              item
                Action = Tools_Score
                Caption = '&Score, Place, Points...'
              end
              item
                Action = Tools_Divisions
                Caption = '&Divisions...'
              end
              item
                Action = Tools_LeaderBoard
                Caption = '&LeaderBoard...'
              end
              item
                Action = Tools_DisqualifyCodes
                Caption = 'D&isqualification Codes...'
              end
              item
                Caption = '-'
              end
              item
                Action = Tools_Preferences
                Caption = '&Preferences...'
              end>
            Caption = 'T&ools'
          end
          item
            Items = <
              item
                Action = Help_About
                Caption = '&About...'
                ImageIndex = 43
                ImageName = 'info'
              end
              item
                Action = Help_LocalHelp
                Caption = '&Help...'
                ImageIndex = 42
                ImageName = 'Help'
              end
              item
                Action = Help_OnlineHelp
                Caption = '&Online Help...'
                ImageIndex = 42
                ImageName = 'Help'
              end
              item
                Caption = '-'
              end
              item
                Action = Help_Website
                Caption = '&SCM Homepage...'
                ImageIndex = 41
                ImageName = 'home'
              end>
            Caption = 'He&lp'
          end>
        ActionBar = ActionMainMenuBar1
      end>
    Images = VirtualImageListMenu
    OnUpdate = ActionManager1Update
    Left = 424
    Top = 240
    StyleName = 'Platform Default'
    object Help_About: TAction
      Category = 'Help'
      Caption = 'About...'
      ImageIndex = 43
      ImageName = 'info'
      OnExecute = Help_AboutExecute
    end
    object File_ExportCarnival: TAction
      Category = 'File'
      Caption = 'Export CarnivalMeet...'
      Enabled = False
      ImageIndex = 46
      ImageName = 'Export'
    end
    object File_ImportCarnival: TAction
      Category = 'File'
      Caption = 'Import CarnivalMeet...'
      Enabled = False
      ImageIndex = 39
      ImageName = 'import'
    end
    object File_Exit: TAction
      Category = 'File'
      Caption = 'Exit'
      ImageIndex = 38
      ImageName = 'Exit'
      OnExecute = File_ExitExecute
    end
    object Session_ToggleVisible: TAction
      Category = 'Session'
      Caption = 'Toggle visibility.'
      GroupIndex = 1
      Hint = 'Show, hide the visibility of locked sessions.'
      ImageIndex = 23
      ImageName = 'VisibilityOn'
      OnExecute = Session_ToggleVisibleExecute
      OnUpdate = Session_ToggleVisibleUpdate
    end
    object Session_ToggleLock: TAction
      Category = 'Session'
      Caption = 'Lock/Unlock'
      Hint = 'Toggle the session status.'
      ImageIndex = 21
      ImageName = 'Lock'
      ShortCut = 16460
      OnExecute = Session_ToggleLockExecute
      OnUpdate = Session_ToggleLockUpdate
    end
    object Session_New: TAction
      Category = 'Session'
      Caption = 'New Session...'
      Hint = 'Create a new session.'
      ImageIndex = 20
      ImageName = 'New'
      ShortCut = 16429
      OnExecute = Session_NewExecute
      OnUpdate = Session_NewUpdate
    end
    object Session_Edit: TAction
      Category = 'Session'
      Caption = 'Edit Session ...'
      ImageIndex = 45
      ImageName = 'Edit'
      OnExecute = Session_EditExecute
      OnUpdate = Session_EditUpdate
    end
    object Session_Delete: TAction
      Category = 'Session'
      Caption = 'Delete Session...'
      Hint = 'Delete the current selected session.'
      ImageIndex = 19
      ImageName = 'Delete'
      ShortCut = 16430
      OnExecute = Session_DeleteExecute
      OnUpdate = Session_DeleteUpdate
    end
    object Session_Report: TAction
      Category = 'Session'
      Caption = 'Session Report*'
      Hint = 'Display the session report.'
      ImageIndex = 17
      ImageName = 'Report'
      OnExecute = Session_ReportExecute
      OnUpdate = Session_ReportUpdate
    end
    object Session_Export: TAction
      Category = 'Session'
      Caption = 'Export Session...'
      Enabled = False
      ImageIndex = 46
      ImageName = 'Export'
    end
    object Nominate_SortMembers: TAction
      Category = 'Nominate'
      Caption = 'Sort on Name'
      Hint = 'Sort on member'#39's name.'
      ImageIndex = 11
      ImageName = 'Switch'
      OnExecute = Nominate_SortMembersExecute
      OnUpdate = Nominate_SortMembersUpdate
    end
    object Nominate_Report: TAction
      Category = 'Nominate'
      Caption = 'Nominate Report*'
      Hint = 'Display a nominee'#39's report.'
      ImageIndex = 17
      ImageName = 'Report'
      OnExecute = Nominate_ReportExecute
      OnUpdate = Nominate_ReportUpdate
    end
    object Event_ToggleGridView: TAction
      Category = 'Events'
      Caption = 'Toggle grid view.'
      Hint = 'Toggle grid. Expand or collapse it'#39's view.'
      ImageIndex = 16
      ImageName = 'GridOn'
      OnExecute = Event_ToggleGridViewExecute
      OnUpdate = Event_ToggleGridViewUpdate
    end
    object Event_MoveUp: TAction
      Category = 'Events'
      Caption = 'Move Up'
      Hint = 'Move the event up.'
      ImageIndex = 12
      ImageName = 'Up'
      ShortCut = 16422
      OnExecute = Event_MoveUpExecute
      OnUpdate = Event_MoveUpOrDownUpdate
    end
    object Event_MoveDown: TAction
      Category = 'Events'
      Caption = 'Move Down'
      Hint = 'Move the event down.'
      ImageIndex = 13
      ImageName = 'Down'
      ShortCut = 16424
      OnExecute = Event_MoveDownExecute
      OnUpdate = Event_MoveUpOrDownUpdate
    end
    object Tools_QualifyTimes: TAction
      Category = 'Tools'
      Caption = 'Qualify Times...'
      OnExecute = Tools_QualifyTimesExecute
    end
    object Event_NewRecord: TAction
      Category = 'Events'
      Caption = 'New Event'
      Hint = 'Create a new event.'
      ImageIndex = 20
      ImageName = 'New'
      ShortCut = 16429
      OnExecute = Event_NewRecordExecute
      OnUpdate = Event_NewRecordUpdate
    end
    object Event_Delete: TAction
      Category = 'Events'
      Caption = 'Delete Event'
      Hint = 'Delete the selected event.'
      ImageIndex = 19
      ImageName = 'Delete'
      ShortCut = 16430
      OnExecute = Event_DeleteExecute
      OnUpdate = Event_DeleteUpdate
    end
    object Event_Report: TAction
      Category = 'Events'
      Caption = 'Event Report*'
      Hint = 'Display the event report.'
      ImageIndex = 17
      ImageName = 'Report'
      OnExecute = Event_ReportExecute
      OnUpdate = Event_ReportUpdate
    end
    object Entrant_MoveUp: TAction
      Category = 'Entrants'
      Caption = 'Move Up'
      Hint = 'Move the entrant up a lane.'
      ImageIndex = 12
      ImageName = 'Up'
      ShortCut = 16422
      OnExecute = Entrant_MoveUpExecute
      OnUpdate = Entrant_MoveUpUpdate
    end
    object Entrant_MoveDown: TAction
      Category = 'Entrants'
      Caption = 'Move Down'
      Hint = 'Move the entrant down a lane.'
      ImageIndex = 13
      ImageName = 'Down'
      ShortCut = 16424
      OnExecute = Entrant_MoveDownExecute
      OnUpdate = Entrant_MoveDownUpdate
    end
    object Entrant_SwapLanes: TAction
      Category = 'Entrants'
      Caption = 'Swap Lanes...'
      Hint = 'Opens the swap lanes dialogue.'
      ImageIndex = 10
      ImageName = 'Shuffle'
      OnExecute = Entrant_SwapLanesExecute
      OnUpdate = Entrant_SwapLanesUpdate
    end
    object Entrant_EmptyLane: TAction
      Category = 'Entrants'
      Caption = 'Empty Lane'
      Hint = 'Empty the lane. The member remains nominated.'
      ImageIndex = 19
      ImageName = 'Delete'
      ShortCut = 16472
      OnExecute = Entrant_EmptyLaneExecute
      OnUpdate = Entrant_EmptyLaneUpdate
    end
    object Entrant_Strike: TAction
      Category = 'Entrants'
      Caption = 'Strike Entrant'
      Hint = 'Remove nomination and empty the lane.'
      ImageIndex = 18
      ImageName = 'DeleteForever'
      ShortCut = 16430
      OnExecute = Entrant_StrikeExecute
      OnUpdate = Entrant_StrikeUpdate
    end
    object Entrant_GotoMemberDetails: TAction
      Category = 'Entrants'
      Caption = 'Member'#39's Details...'
      Hint = 'Show the selected member'#39's details.'
      ImageIndex = 1
      ImageName = 'Members'
      OnExecute = Entrant_GotoMemberDetailsExecute
      OnUpdate = Entrant_GotoMemberDetailsUpdate
    end
    object Entrant_Renumber: TAction
      Category = 'Entrants'
      Caption = 'Renumber Lanes'
      ImageIndex = 37
      ImageName = 'Sort'
    end
    object Heat_MoveUp: TAction
      Category = 'Heats'
      Caption = 'Move Up'
      Hint = 'Move the heat up the stack.'
      ImageIndex = 12
      ImageName = 'Up'
      ShortCut = 16422
      OnExecute = Heat_MoveUpExecute
      OnUpdate = Heat_MoveUpUpdate
    end
    object Heat_MoveDown: TAction
      Category = 'Heats'
      Caption = 'Move Down'
      Hint = 'Move the heat down the stack.'
      ImageIndex = 13
      ImageName = 'Down'
      ShortCut = 16424
      OnExecute = Heat_MoveDownExecute
      OnUpdate = Heat_MoveDownUpdate
    end
    object Heat_ToggleStatus: TAction
      Category = 'Heats'
      Caption = 'Toggle Heat Status'
      Hint = 'Toggle the heat status'
      ImageIndex = 36
      ImageName = 'HeatStatusToggle'
      ShortCut = 16468
      OnExecute = Heat_ToggleStatusExecute
      OnUpdate = Heat_ToggleStatusUpdate
    end
    object Heat_NewRecord: TAction
      Category = 'Heats'
      Caption = 'New Heat...'
      Hint = 'Create a new heat'
      ImageIndex = 20
      ImageName = 'New'
      ShortCut = 16429
      OnExecute = Heat_NewRecordExecute
      OnUpdate = Heat_NewRecordUpdate
    end
    object SCM_Refresh: TAction
      Category = 'SCM'
      Caption = 'Refresh'
      Hint = 'Refresh'
      ImageIndex = 2
      ImageName = 'Refresh'
      OnExecute = SCM_RefreshExecute
      OnUpdate = SCM_RefreshUpdate
    end
    object Heat_Delete: TAction
      Category = 'Heats'
      Caption = 'Delete Heat...'
      Hint = 'Delete the selected heat.'
      ImageIndex = 19
      ImageName = 'Delete'
      ShortCut = 16430
      OnExecute = Heat_DeleteExecute
      OnUpdate = Heat_DeleteUpdate
    end
    object Heat_AutoBuild: TAction
      Category = 'Heats'
      Caption = 'AutoBuild Heats...'
      Hint = 'Auto-build heats.'
      ImageIndex = 6
      ImageName = 'AutoBuild'
      OnExecute = Heat_AutoBuildExecute
      OnUpdate = Heat_AutoBuildUpdate
    end
    object Heat_MarshallReport: TAction
      Category = 'Heats'
      Caption = 'Marshall sheet*'
      Hint = 'Display a marshall'#39's sheet for all heats.'
      ImageIndex = 4
      ImageName = 'Marshall'
      OnExecute = Heat_MarshallReportExecute
      OnUpdate = Heat_MarshallReportUpdate
    end
    object Heat_TimeKeeperReport: TAction
      Category = 'Heats'
      Caption = 'Time Keeper sheet*'
      Hint = 'Display a timekeeper'#39's sheet for the selected heat.'
      ImageIndex = 5
      ImageName = 'TimeKeeper'
      OnExecute = Heat_TimeKeeperReportExecute
      OnUpdate = Heat_TimeKeeperReportUpdate
    end
    object Tools_Swimmercategory: TAction
      Category = 'Tools'
      Caption = 'Swimmer Categories...'
      OnExecute = Tools_SwimmercategoryExecute
      OnUpdate = Tools_SwimmercategoryUpdate
    end
    object Entrant_Sort: TAction
      Category = 'Entrants'
      Caption = 'Sort on TTB'
      Hint = 'Sort entrants and repair lanes.'
      Visible = False
      OnExecute = Entrant_SortExecute
      OnUpdate = Entrant_SortUpdate
    end
    object Heat_PrintSet: TAction
      Category = 'Heats'
      Caption = 'Print Set'
      Hint = 'Print all sheets (marshall and timekeepers).'
      ImageIndex = 3
      ImageName = 'BatchPrint'
      OnExecute = Heat_PrintSetExecute
      OnUpdate = Heat_PrintSetUpdate
    end
    object Heat_Report: TAction
      Category = 'Heats'
      Caption = 'Heat Report*'
      Hint = 'Display a heat report.'
      ImageIndex = 17
      ImageName = 'Report'
      OnExecute = Heat_ReportExecute
      OnUpdate = Heat_ReportUpdate
    end
    object Tools_House: TAction
      Category = 'Tools'
      Caption = 'House...'
      OnExecute = Tools_HouseExecute
      OnUpdate = Tools_HouseUpdate
    end
    object Nominate_MemeberDetails: TAction
      Category = 'Nominate'
      Caption = 'Member'#39's Details...'
      Hint = 'Show the selected member'#39's details.'
      ImageIndex = 1
      ImageName = 'Members'
      OnExecute = Nominate_MemeberDetailsExecute
      OnUpdate = Nominate_MemeberDetailsUpdate
    end
    object Nominate_ClearEventNominations: TAction
      Category = 'Nominate'
      Caption = 'Clear event nominations... '
      Enabled = False
      Visible = False
    end
    object Nominate_ClearSessionNominations: TAction
      Category = 'Nominate'
      Caption = 'Clear session nominations...'
      Enabled = False
      Visible = False
    end
    object Event_BuildFinals: TAction
      Category = 'Events'
      Caption = 'Build event finals ...'
      ImageIndex = 6
      ImageName = 'AutoBuild'
      OnExecute = Event_BuildFinalsExecute
      OnUpdate = Event_BuildSCMEventTypeUpdate
    end
    object Event_BuildSemiFinals: TAction
      Category = 'Events'
      Caption = 'Build event semi-finals ...'
      ImageIndex = 6
      ImageName = 'AutoBuild'
      OnExecute = Event_BuildSemiFinalsExecute
      OnUpdate = Event_BuildSCMEventTypeUpdate
    end
    object Event_BuildQuarterFinals: TAction
      Category = 'Events'
      Caption = 'Build event quarter-finals ...'
      ImageIndex = 6
      ImageName = 'AutoBuild'
      OnExecute = Event_BuildQuarterFinalsExecute
      OnUpdate = Event_BuildSCMEventTypeUpdate
    end
    object Event_Renumber: TAction
      Category = 'Events'
      Caption = 'Renumber Lanes...'
      Enabled = False
      ImageIndex = 7
      ImageName = 'Cycle'
      Visible = False
      OnExecute = Event_RenumberExecute
      OnUpdate = Event_RenumberUpdate
    end
    object Heat_BatchBuildHeats: TAction
      Category = 'Heats'
      Caption = 'Build ALL Heats...'
      ImageIndex = 6
      ImageName = 'AutoBuild'
      OnExecute = Heat_BatchBuildHeatsExecute
      OnUpdate = Heat_BatchBuildHeatsUpdate
    end
    object Heat_BatchMarshallReport: TAction
      Category = 'Heats'
      Caption = 'Print ALL Marshall Reports...'
      ImageIndex = 6
      ImageName = 'AutoBuild'
      OnExecute = Heat_BatchMarshallReportExecute
      OnUpdate = Heat_BatchMarshallReportUpdate
    end
    object Heat_BatchTimeKeeperReport: TAction
      Category = 'Heats'
      Caption = 'Print ALL Timekeeper Reports...'
      ImageIndex = 6
      ImageName = 'AutoBuild'
      OnExecute = Heat_BatchTimeKeeperReportExecute
      OnUpdate = Heat_BatchTimeKeeperReportUpdate
    end
    object Heat_Renumber: TAction
      Category = 'Heats'
      Caption = 'Renumber'
      ImageIndex = 7
      ImageName = 'Cycle'
      Visible = False
    end
    object Session_Import: TAction
      Category = 'Session'
      Caption = 'Import Session...'
      Enabled = False
      ImageIndex = 39
      ImageName = 'import'
    end
    object Session_Clone: TAction
      Category = 'Session'
      Caption = 'Clone Session...'
      ImageIndex = 44
      ImageName = 'clone'
      OnExecute = Session_CloneExecute
      OnUpdate = Session_CloneUpdate
    end
    object Session_Sort: TAction
      Category = 'Session'
      Caption = 'Sort'
      ImageIndex = 8
      ImageName = 'Sync'
      OnExecute = Session_SortExecute
      OnUpdate = Session_SortUpdate
    end
    object Tools_Score: TAction
      Category = 'Tools'
      Caption = 'Score, Place, Points...'
      OnExecute = Tools_ScoreExecute
      OnUpdate = Tools_ScoreUpdate
    end
    object Tools_Divisions: TAction
      Category = 'Tools'
      Caption = 'Divisions...'
      OnExecute = Tools_DivisionsExecute
      OnUpdate = Tools_DivisionsUpdate
    end
    object Tools_LeaderBoard: TAction
      Category = 'Tools'
      Caption = 'LeaderBoard...'
      OnExecute = Tools_LeaderBoardExecute
      OnUpdate = Tools_LeaderBoardUpdate
    end
    object Tools_Preferences: TAction
      Category = 'Tools'
      Caption = 'Preferences...'
      OnExecute = Tools_PreferencesExecute
    end
    object Tools_ConnectionManager: TAction
      Category = 'Tools'
      Caption = 'Connection...'
      Visible = False
      OnExecute = Tools_ConnectionManagerExecute
    end
    object SCM_ManageMembers: TAction
      Category = 'SCM'
      Caption = 'Manage Members...'
      Hint = 'Create, edit, delete, stats, reports for your club members.'
      ImageIndex = 1
      ImageName = 'Members'
      OnExecute = SCM_ManageMembersExecute
      OnUpdate = SCM_ManageMembersUpdate
    end
    object Help_LocalHelp: TAction
      Category = 'Help'
      Caption = 'Help...'
      ImageIndex = 42
      ImageName = 'Help'
      OnExecute = Help_LocalHelpExecute
    end
    object Help_OnlineHelp: TAction
      Category = 'Help'
      Caption = 'Online Help...'
      ImageIndex = 42
      ImageName = 'Help'
      OnExecute = Help_OnlineHelpExecute
      OnUpdate = Help_OnlineHelpUpdate
    end
    object Help_Website: TAction
      Category = 'Help'
      Caption = 'SCM Homepage...'
      ImageIndex = 41
      ImageName = 'home'
      OnExecute = Help_WebsiteExecute
      OnUpdate = Help_WebsiteUpdate
    end
    object Tools_DisqualifyCodes: TAction
      Category = 'Tools'
      Caption = 'Disqualification Codes...'
      OnExecute = Tools_DisqualifyCodesExecute
    end
    object Event_AutoSchedule: TAction
      Category = 'Events'
      Caption = 'Auto Schedule...'
      Hint = 'Auto schedule events. '
      ImageIndex = 47
      ImageName = 'TimeAuto'
      OnExecute = Event_AutoScheduleExecute
      OnUpdate = Event_AutoScheduleUpdate
    end
  end
  object pumHeat: TPopupMenu
    Left = 888
    Top = 208
    object MoveUp2: TMenuItem
      Action = Heat_MoveUp
    end
    object MoveDown2: TMenuItem
      Action = Heat_MoveDown
    end
    object oggleStatus1: TMenuItem
      Action = Heat_ToggleStatus
    end
    object NewRecord1: TMenuItem
      Action = Heat_NewRecord
    end
    object DeleteHeat1: TMenuItem
      Action = Heat_Delete
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Marshall1: TMenuItem
      Action = Heat_MarshallReport
    end
    object imeKeeper1: TMenuItem
      Action = Heat_TimeKeeperReport
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object HeatRpt1: TMenuItem
      Action = Heat_Report
    end
  end
  object pumSession: TPopupMenu
    Left = 792
    Top = 280
    object DeleteSession1: TMenuItem
      Action = Session_New
    end
    object EditSession1: TMenuItem
      Action = Session_Edit
    end
    object CloneSession2: TMenuItem
      Action = Session_Clone
    end
    object NewSession1: TMenuItem
      Action = Session_Delete
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Sort1: TMenuItem
      Action = SCM_Refresh
    end
    object oggleSessionStatus1: TMenuItem
      Action = Session_ToggleLock
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object SessionRpt1: TMenuItem
      Action = Session_Report
    end
  end
  object pumEntrant: TPopupMenu
    Left = 864
    Top = 280
    object MoveUp3: TMenuItem
      Action = Entrant_MoveUp
    end
    object MoveDown3: TMenuItem
      Action = Entrant_MoveDown
    end
    object SwapLanes1: TMenuItem
      Action = Entrant_SwapLanes
    end
    object EmptyLane1: TMenuItem
      Action = Entrant_EmptyLane
    end
    object StrikeEntrant1: TMenuItem
      Action = Entrant_Strike
    end
    object Renumber2: TMenuItem
      Action = Entrant_Sort
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object GotoMember: TMenuItem
      Action = Entrant_GotoMemberDetails
    end
  end
  object pumEvent: TPopupMenu
    Left = 936
    Top = 280
    object MoveUp1: TMenuItem
      Action = Event_MoveUp
    end
    object MoveDown1: TMenuItem
      Action = Event_MoveDown
    end
    object NewEvent1: TMenuItem
      Action = Event_NewRecord
    end
    object DeleteEvent1: TMenuItem
      Action = Event_Delete
    end
    object Renumber1: TMenuItem
      Action = Event_Renumber
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object EventRpt1: TMenuItem
      Action = Event_Report
    end
    object N11: TMenuItem
      Caption = '-'
    end
  end
  object pumNominate: TPopupMenu
    Left = 816
    Top = 200
    object Sort2: TMenuItem
      Action = Nominate_SortMembers
    end
    object Filter1: TMenuItem
      Caption = 'IsQualified'
      Hint = 'Tag events qualified by the nominee.'
      Visible = False
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object NominateRpt1: TMenuItem
      Action = Nominate_Report
    end
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Search'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000002A1494441546843ED99E151D6401086
              5F2AD00EC00A900A900A1C2B502B102A502A102A502B502B502AD00EB403A002
              9867E696593249EE2E7BE14B66727FC27CDC77B7CFBDEFEE6D604F2B1F7B2B8F
              5F1BC0AE15DC1458B302AF25BD92F4323D8DE546D25F49BF25FD4C3FCFC639C5
              426F257D927450181520EF25FD2F9C5F35AD06E0B9A4EF9DD3AED9EC54D265CD
              174AE6960260932FC92EB6EEADA4AFC9229C2E270DA4598A2736F383F9A8D16C
              940010D4AF4EF05792DE15D8821CF921E9998B181550A3C928012078026170EA
              F8FFA262770E8093F76ABC496015CBF44FCD0170CA58C7C65965F07E572AD361
              FA804AF54212CFD0C801FC73D506DB981253362527C813B3D3795273CA5A0FDF
              19032058EC63D621806829C4FB9FD39AAC850AA1310680CF3FA4D5BFA5A40D6D
              96BE7CE716012074286300C87D9C368B78BF0BED7321BCEE18C075AAEB047092
              FCDB42012A12B739239C0763005EEA5CB2D78051863F3E3540D8AB8EF0C900BC
              579B5D3CC98A965BB35A8816C06ECFF0464E81A6B935E66D7F0BA3C6518DD107
              E6D2827339DA08E7D6D802DDCDC2252F5D8C769B37B95B7227E04B1E7D0B2A4C
              BD787CF2A24093C290034005EC63FD0B971B095DDB84D186FC71D669D652E700
              D8B3DB91A2002F25C0940C6A3EA76FA35927CA822500CCEBCACF67F44A54A721
              35FADEE20CA2D99B5929409F12160C8AF4BD5276D5E165C8BF993581A8012020
              2A081BEF9778C7CDA1E2D04AA39AF541FC3A0C510B6031911704646F58433C04
              4ED014026F9F661053012C18FF57080F41828F25B92FCF2125A200954E7A34BD
              09C42E01ECE44376DA3540186209002188A5004C865812C02488A50154432C11
              A00F62B07B5D2A8087A087A285F1B7F9C385B26400EB78ED7F10BD97E6D201B2
              37FD06903DA299276C0ACC7CC0D9E557AFC03D711588316245F5CB0000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'Members'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000314494441546843ED988FD18C410CC6
              9FAF0254800A50012A4005A8800E50012A40051F15A00254800A5001F33B9B9B
              4CECBEB7D975EEBBF166E6E6FEBCBBD93CC9936C72273A72393972FBB5023874
              04D708AC1198F4C04AA149074E6F9F89C00D4977255D92C467E49DA48F925E95
              776FE06B49B7CA0F5FCA73D63F9F413102E0BCA447921EEE38F8B1A4276E0D20
              DF56F600F87E057017AE11001F245DEDD2FEDBBB1EE8CB12B5B8FDBBA46B9288
              4C4AB200F02ADE377923E959A10EBFDD96C49A2B6ECDCDF0FCB4612174626D4A
              3200A0CE6749BC23D003636B12F97ED92DFAB9602154224ADD9201E039FCB524
              6FEB20407E730FFD3978FA7A63E39253AA5B3200E0F2D3A22572BBA6DC1BEA69
              B404E0BDAB685D51C800F0FCEFF194A7D11D497C475A89CCB34F8902B1519601
              70F411F03940B9A3EC51FE6AC2E546C29B9C891C203131FC9CA30255230AEB28
              95763B475A2C55214FB5BF9E0328F434E23B09496E509530FC62B91788800991
              E2B645B8275AF700770ACF5392C90153BC5445E2E131D95B09FCA394E516259B
              A04600A02CDEC8F1000CBAE72A0FCF5BBD109E676DDA78948E02602FFD1021C7
              30288301D665D25E448328A39617508A17D1B4F29AA24EAD3A0C2938F4A69908
              1CDAF6CDF9FF1D00784F2306E7F94CE98CB301BCB6124B4ED0DFB4FA7CF45099
              B81B2C7FC80DF674494F046C74B464ED521C1659C2D204D6C050855E843D2437
              AF250734298467987751EC2FA511E3E31EC050A5289FBE52D540D85EA2C49C6D
              D1DDEAAC458089AB35A870E3E2150B37EFD1A300368A59A9B5F6C383C1785A11
              5F4677DD2F71CEFE230284114F78C1683CC02B3DB3164500A10DE1DE8860FC14
              16FBAD5AC4B163DB83F908C410C23D423D75D1040B30D0E666FA2613464E730E
              673ED8C1D56DD3E701D0FE1ADF7B26AED97C20176CF887DF16F9A586CFCEDCFE
              01E001F836F7C2686F9240E50DF5A364AB678AAA37B6B700F494D784ADD5A57E
              F027A1711A12FF10689D73700018E6A3DE72E6108059EF8EEC5F012CCDAA231E
              CDEE998E40F6C033B1FE5F549BBD025D01ECD5BD1DCAD708743869AF4BD608EC
              D5BD1DCA7F01FCEEA831B2921B460000000049454E44AE426082}
          end>
      end
      item
        Name = 'Refresh'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000002A6494441546843ED98814D1C311045
              3F1540074005810A800A48072415845400A900E8002A002A002A805490A40242
              05A01779A491757B3BBEB55956594BA7D3CA5EEFFFF3FF786CAF69E26D6DE2F8
              3513185BC1598159818111982DE402B821694FD267495BEEC79027497F25FD96
              742FE9363D77C5FFD5752C0D720D05007B22E94B811B207323E92A11CA5F7D17
              02441CE0C705C0170D3D97F42353A43901C0DF49DAC910FD4C91C526D8851F6D
              DFFDA3D466F61E16FB9AAC4657530280063C24AC3D24250012691042B9433718
              5B1D2412CD0800FA9703FF92805C46502F18831A58683DF51989C716499CDB06
              F044321AF52E8E284A429BAD20E1D5ADB60A11A96F09452DF0468A958C409812
              9E6C15027C00EB5823E156B54D9712A8496EE5AD0A01C01EA59949585B554AAD
              8F5D1645D9E62127F27A3298007E7C76487707F89EE5956A5DD20613606B709D
              BEC83A9FAFFD25604621E0ED43C53C2D419C8D6521280DC052BB46F6423E6A14
              1A9E3F4C8B10603B606BF4B6DB1E7C08121102E1B23E06A3FF82C0E42D34F924
              AEB98C564F93480EF842C6868B4ADCB2512B3EA50F5CA49D6AE7F72204F2AD44
              CB5A906FE87A97ED0801D87B1B91139068D17CBE717381FA4B5B94C018DBE990
              D2510244C11F68FCF9B52F4891FEFC9CCD754BE89AA68400B980C49660B548E4
              E039EDA138F3F7B612024C06090A9B3F847F1F703AE366E2CCA12C3EAA9612E0
              5B440C25FCC98A67B6DAD19D2AF6E0528C485B033C491B9DE3DF7BAB103025BC
              9D0C0475821B06FAFE24B5500DDBD97D29E03D70DE2D8EBC7D7055024682C38D
              DD54F4FAB56300C58A79429ECFE71842C0E6229A00B0437F94082B0D2BDBA07B
              A51A040C3056A192DAF5BA59C72C0250FB61B39522DE428168C49B8CABA94013
              807D93CE04FA22D4BA7F56A07584FBE69F15E88B50EBFE37192485314CB78CD4
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'BatchPrint'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001BA494441546843ED57C151C4300CDC
              EB002A810E800E68810A800A800A0E3AA0034A003A804AA003989DB1199D51E2
              93621392915E993B59DAD5AE1D678385C766E1F81104E656301458A2025F9D41
              9B5C614A4EC083404541D3504DC98A029EF51A7EA9AAA9A62939080C7B2714B0
              9C8CEE698D3471D75CFD1E38007004E018009F19B76292F2D9A26299ABD5FC04
              F006E01D009FD51853E0A6003B05E0D4B52478A7151922F00CE0746AD7C6EB5F
              009C953535025700B622911272F1A08C8D81E672B42C87480BE7B806702FFB69
              0408F6242551B6563EF7F2647FDA99F15A3A4323F02136ECE11F4F9E53BF4C3D
              1F1268FE464C0CBA80987E4223E03E93BD2316EBA47D2F003CA6FF0631FD3702
              E7009E12686E58DA99B1180204CB770E83EF801C8B22A0393108C8A9E423ADC1
              9E554B686FDCA60ACCF14D1C04A4D6721AEA05CBE12D694BD3D15E4BCEE7B0C4
              242F799EEF89DA2963EA5923501B660F02A69EAB2450FB0EE0B7428E1E0AFCBA
              F31792EC58CC03A0C765CF5D3308D476DC9EFF87027B0E6AFC6E6E2952E4CEA6
              C004CC834B4DFBD2949C5ACE71996BC3762D047AD8C65DD3632177B31E0B8340
              8FA95A6A86029669F5C8FD06433F5C313B573EE40000000049454E44AE426082}
          end>
      end
      item
        Name = 'Marshall'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000351494441546843ED99FDB14C4110C5
              CF8B00112002448008100122400488001120024480081001224004D4EFD5B4EA
              9A9A8F9EB9B3EFED56EDFCB5B53B77A64FF7E9D3DD774F74E0EBE4C0EDD711C0
              7947705711B822E9BEA40709E01B496F25FD580D7825808B92EE24A36F550CFD
              2409301F24FD5E016605008CC5DB77250122B230FE7D8A0AA0A6D72C004F113E
              97165EC64816E0884E6941AB698A8D008850E4A7A497C9F09CEF0005C8634997
              57512C02A047913FC9600CFF1AE4C2F5040440170ACF84291601F0B74311C2BF
              65A1542D8A356D1C05D0A2C816103C5BA3D8520011C05B81F0BC8FFA1140D81B
              05D79BC48E56E0F09D114A840F2B0040325928D4C80ADFB96B005F2421B3B5D6
              A2066A2F0050F87E250B2F0DF63E7B01007D7F9D003C4CED4294467B01803EC8
              FA1FFA228A55749D190068F24CD2B58265B40BD69DD21A94DA8C6FA9A5C81F3F
              330076312AF328EADEB4EF55C5F8732B645084BEA8D49C796CA8127B5B73C0D2
              085084ACFDEDA9099481FB372BD1201748EED63446F1FB9E9EA7F7AACD1BA75B
              2275004F9941B73B9EE34CBCFBAE02E06A602EA6667C4CCF7FEED5905100F7DC
              9455A33C3462C42CAD2781AAEC1DB004002AF33490786630C5CBD4079561994A
              4147A2D05A5E109E2795ABEE8F446024A4DE7B5E65BC51373A93DB1065230072
              596B2532F40104896A03BD798FEF00C21E6BF272CFFAF62394A35100DE2B351E
              7339C6B55486E206256B5519602FA2091C42980EF3D4A8F11800919755AD7DC8
              A7C966443042326A61F6F560B439EBE4EDE9CFBEF9EBEABF1D18A510FBBD1A01
              86648C783C623C51617630EF77D567060097D09059550E5F1240E09D13F6FE48
              0E980D5E52F92EC4D30E80BC7247AAFDFF234728640FF93E1F0A7161F48D5C8E
              0555A26DB0C2373A370C25B15D9E5309E349EA5110184FCF64BC873A7C379457
              3311000817511BAC751E8D44EE791BFC479D3015018B44CE5D40908CB410ADC5
              E0C33EFF5FC2742ECD46C0273539E18718BC48B5CE071604802A8BF76D4D7B7E
              46466B5EC5205A887C2E0688BDD0A245F08673169D2AC56B9836DE90AD11F089
              8D91D676F7A49F1A02B8A1842D1DBA0A809D8DA2C0EFDA40C33F95FC3EFAAEB4
              EA90D5007C44A087FF9B159A6DF6788E6457007A145AF6FB11C032574E1E74F0
              11F8076068C4318E89B5CC0000000049454E44AE426082}
          end>
      end
      item
        Name = 'TimeKeeper'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000355494441546843ED98FD914D4110C5
              CF466045C046B0448008D808AC0810012240046C048800112C1120024440FDB6
              A6ABDAD49D999E8FF7C753AFABB6DEBE77EFF4F4E93EFD3173A43D97A33DB75F
              2B01FCE974C692BD972849861F007446F0EAF5951118D97F7ACD01C0B40B2715
              AC8CC04D4977243D90742CE956FA34133F49FA2589CF0F92BE4FDABE2C071E4A
              7A920CEEB10900CF255D6C2CC2010880AB321381BB929E49E2734600F2284506
              3D18FF3129BCD702310AE08DA4F3CCEADFC988F7891E50C50B40A11914E3FF6B
              D9F357925E24E3A11FF245D2ED9A777A01E09D7799D7311C2A60408F403BD6E5
              40BC0E22F37615000BAD7907BDAF93114DAE168C4027201E6F3C6F1ACF9A9E08
              C04BCFF7D006C19040476869425E9C44D64601E49C8797F0B326F0FD467AE147
              A06CE21C4B5E8B2E34AB4A0440AE38EA79A8419542484EBEB7248FC499248A42
              5122003C75A8D979F529291F01802E9296DE8234A9D40240C9A3EA20541B6811
              4DD851002436865B75AA46BC05805ACE78D043038BC82800D6FBB5D55E500380
              277E3A7EB4C0E6549A01802E7F40A2226DCE4E35A37C42317C41A71E990540F2
              DE4F1B3E2D35CA1A00AF205A793CC05900DE819F4B33570D80E73F43553EDBB4
              A2310BC097EF2100976E442E72B08262160015EF5BAB9CD622E093A83781F34A
              126D64B93F9A36FCD700A8BFA7C92591D927F71E14E0CF3A6AEF1192A9171A23
              5F4B27BE5D26712BC95BCFA793D8CF24C53ADCB262E23993E8CBB4BE3883EDB2
              914DD87EB534D4877A4689EB1D83DCACF1F91853DCBB551EBD17464BE10818DF
              43AA634C0B804F24C6681A5A749C1E319C35789F06667743D529A00500857EA4
              20229C9276299C3F6C702C8E10664004806FE9ACDB25953C75D8AB39C24400E4
              6301DF47A6D356D4F2F370A8744701B0B9EF0B068A68AC100EFFFED01F3E7BF7
              0020A9C8071B2FAC56E3A9DE31C140434F9A953F2C3136503C42C5A207805508
              AE10EDD680DFD888DFB8A50B6D9A2A0CB771745BAB36E80A7BBE2789B728E2DB
              BC7FCE0008D5ECD20B6F2216350634B8EEAF276D7D88F3B931BD11F0EB093F9E
              B773EB682ED0A870C8100D670098C1F01503B6AECC4BA0EC2A1E07F41E55FFD1
              B90280576877FF46117FCFCF7B500B83ABD7853DA15C0DA067EF25EF1E002C71
              E38492BD8FC05F6103B831B5CDAA2A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'AutoBuild'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000002ED494441546843ED998F910C411487
              7F1701224004880019100122400488001120822302448008C80011505F553FF5
              F4BEDEE9DEEE9E9D2D5ED5D6DDDECCF4FCBE7E7FFA75DF994EDCCE4E5CBFFE69
              802B922E4BBA98BCF843D24F499FD7F46AAB0710FD50D21D49FC1ED937491F24
              BD493FA7F2D40230CBCF25DD6F54F35AD23349404DB15A0084BFCA1458B81032
              78E37A0AA95C28A1757B5668D502202A874038C2106886A700792AE96646F240
              121E196A2D00B51026F0510A3BFB3EC513FB00DE4B7A1CB8BEC613261A6FBC75
              A105C4D5CC6B5D1E290110024FD28BA2F86D81B82589C93023A9197F889500BE
              BA3259727D0BC48B547E113DD40B110035FE3C9B9E5E08929BA467E1C3EEA6D0
              EAF64204E067CBBFA017C28FCB22D7BAA684B01100ABA89540929878BD909E8E
              20581FBC9892385F953E4A2237BA2D02F0F1CF752A09501144AD7884FA646622
              2E75AB97C26EF4971BD800230862DACF624D5844637771441EA06FB164A38432
              FB580EE15F5C239EFB5701F039902FFF1144AD789EFD94A8BFA409E99A7D1E8E
              3C40BF722F8DFC5212C9E7CD4344D74BA27C12BF4B2DF91400BF4011E73782B7
              00C1A7A53963F679061BD6D8451E60D1F9EE44534AA9E13D96B7135420DFC51E
              3CF6522F6403E3859EAD22CF5E4B830DED4A4B0078816A64B53FEAFD5B666DDF
              5AD232CECEBDFBDAE9BC270288D8B5B2BAF4627669CCB685CA1488A50D4DB495
              241F68894B318CF7D8F8537580F6BBB6E1104B00CC7204C1DF114768F9DC2059
              F31E270FBFA1103500B60AFB9DD552F8E4D7A741D4029820BC416858452981D0
              6D229A50329B02D10A606288F3E8700B9124B9E5C7D2AEAD3B9C0E056809A1A9
              106B004485605838AD05300D624D8029106B030C873806C0508863010C833826
              C02110B42F9CADFEB16303D442D85E9AFBFFD2BC058012846D65F3B3A74D0244
              10B6DFF6A77E3B27DB5BF1806F16F37F65D9B5F0F8666B0088F5C73A7BC5EF24
              444B8736F95E3A5D3B8F02A8787CB3450F34CDCD7F80A6E99A70F3C97BE037D7
              85EF31720B02260000000049454E44AE426082}
          end>
      end
      item
        Name = 'Cycle'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000003C8494441546843ED99FD910D5110C5
              CF468008D808100122602340048800112002360322400644800C8880FA55DD56
              FDEEEB99FB39F3FED9AE7AB5F37666FAF6E98F73FBF63BD33CB923E99EA44749
              E52D497C906F927E4BFA99AE3FA5EBE1D5CF06355C97F44CD213676CAD4A407D
              903404A6178019FE5C12D7234264DE4A7ADDA3A4070029F23E30FC8FA42F923E
              A6F4C030BC8CDC4F7F49333E8F036349AF17E97DBBFDD73D17DADA0AE08D24BC
              EEE5BBA457D9C2256712351C81AEDBD9C3440320C854002C8A97AE25E5BF92E1
              E4F18800041DA6175D7C7F3A1B008A2956D2E76BF220693243700E463F74CAF8
              CE7A2653520865A40B9F2D04A3A3FA60AD2E0014DFCBC41014E81EB204A20900
              1B10865B08C9FDF33DAC4F6B4420AA016078C4EF30030C315B3CD3ACE92E0280
              0DA049DBFE7365142C519855B8A67F18001B0B86DB66B3E685CB8C1966446318
              8051A31903BFDF749661B46786BB6E879D01604887E5150C4327493F42C1C2F5
              08ED011C6DF7F91FD70F86569DF8B201208DACDD85E32964C45286BAF8E1D6BD
              686C1D269A7CA82AAA6CEF6DB6736B1560205A678416D8FAFECD8C4B8A7D8A1F
              AD1B01C0D3C644A48A6D60A412DD25111AED7F5A40432E9FD30BAC4F0DFE9708
              40B1036C597DD2B38B365D0198E4E1929AEE08DCD860E72D199BDFF70CC81E75
              D0294429C43E601B992FE2D685673DEF8B9873C841C7D042A3B30C6AD5D34CA3
              D146D6BAE8CCE77D6B7DD4114711F021DBFB1C1001F7FBD2511F1601C80FEFA7
              AC03EF4CEBCB0E402E8D557CD8F66C1BF208B0035BD1D2681E9DC59700E4CDDB
              29A2E0BD0FB090D2D7065B4CD86CCC412D907FB34F634BC54E1AE37DBA6464F1
              20B5068028D03CD9C0C9864D3D0C83413803436A84F3880D14C87D6C099D571A
              2D72B8E7B86912E661854546CD74B650A1CD4CA357F313E2EAD9A3048005F211
              07A0DE55186D8FB4D413E70D3FF9289EC16B0060081EF343D89674F24C72D40A
              3847F8B459CD7BEFBC5A00762EF620286C4E6C6B13BB9C4918CBF09E179EC178
              DFA4AD01ADDA079632249A980180B0B35FE4E27751D2CE8FE6296A8EA57E806B
              9EE7B92AC6AB8D80370CE514A51F87739FDF09F0A62DEC7B2A980463E972A146
              AEF3011ACF0006FAAE961E002827A5F0BA9F177986E23EDEAFFDF9896205709E
              5E4520BD003CC310113C6F9B4EC45C91211C4E48BF2EC34DE12880250F018808
              E53F1F598E736F6D2F287A7E6B00A69F9CC6D8BC5EEC57C9AA425D43B35504FC
              9AD4016966D33EBB3765DABD07005F2FD03033584BA59C42AB5367AF148A0CB2
              FAF094DB6CF82901741B1BBDB8670A4D35FC2A029BB8B343E93F1362C8312737
              80DB0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Sync'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000002A8494441546843ED98EB71D5400C46
              BF54405201A48240054005241524540054005410A8005241E800A820A102A002
              A00232676637A3ECD896B43663EE8CF5EF5EEF6A75F45AD97BDA71D9DB71FBB5
              01AC1DC12D025B04667A604BA10E077E91F438B8EFABA427536B978A0087BC96
              F45612064EC97F057026E9D478E9E92E017C2CC65B6FF7025C4B62EFEF606ADD
              2EEB4DA1D6F83F925E4AE27F4FC652E893A4136F73FBBC07A0359EBC7F97F09E
              05B868A288EEE719882C005E7A660EE0B088D7AD4D1680B47920E98359F0BE44
              33C49101A060ED413DC663540BC0EF37A58B55A31F49A22E5CC900FC9074BF68
              246D38B4478600D063A3CB1AA2E34A14C07AFF6709BBAB7C64C118C0BE249C74
              AFEC0B45380A60BD1F523C413706C0169B4AA410A9342911006ED9CF450BED92
              A24BF76B6305D144074203C03956D05DA37038F0FCCEE20880F54AAA4378DE1B
              796EDBB45B6B11007AFC8B4C5E761A5EB71D4BBA2C3F1619E6A67276A6AD83DB
              1F4ABA2A4FDC3A8844C0E6E4C1CCFC8F02FF350B276D8C00849545AD73D6D14E
              7F99A6C1EF518900D816EA768505206CD7DBC91AB097A6DBF52211B057FCAB32
              792EE0E85115B6EBB9E74500AC4786BA0297126F65086346763A6D496CCABA2F
              4811005B541CD6D6412A679DD0A567AE0800674E4D8A4B02A467AE280069F2DD
              78CF0E744B01F04A7A6E52B1CE4B93418B02A0C4CE445C6EE42735B10440F7CB
              520600080C3E2A2E01A2BE84D769D5EDDB03EE6C8DFF268971222459000A9AD9
              A8427008BFEBD7B30C00BA1812499D7ADB623CBAC2E37A1600838720AAB7A200
              789D2F7936CFD3C673680F4085A0DFDB2F14FC1F01B03553C1BB8C8F022CFA2D
              B3297A2E3E9A43F7E51789C0BF00C0E05986D7D0AD01400D858BD46B4511004F
              C7AACF378055DD3FA38DAE6DF7EDF95B0AAD1D8A2D026B47E006AE729D31BCFD
              6DDE0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Swap'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000002C1494441546843ED99FF910E411086
              DFCBC065200344800810012240048800112002448008B808EE448008A847CD9C
              3635DF4ECF6EF7567D55BACA3FBEDDD9F7E9E95F3377A223B79323D7AF6C8007
              C5416FB21C950980F8D745F8434929107B01C0910291098068BB0B2910D900E9
              107B00A44244035C977447D2AD92BC5724F17F3D0BC9890800443E2AF17E75B2
              5CDE96F469F29D7F1EDF0A705FD24B4940CCDADB023DFB5E0800825F74047C2B
              1E7D2FE947F9F7B5538D42C443B2660710FFB1896D843F3BD0ACDA521A267E0D
              404FFCF322BE170AA9E2D700301AD4F966D498D2C5CF0210224F8D9B4765D002
              84868DDD6A6F0E103AE7A6DA2C858D5D1F087A82DD356FD5E19B148245F30258
              EF93B0B3F57EA4A3FD9D50AD852104E0BBF1FEE6E633A0A97986F74F47E49E1D
              B82BE95D59680FEFD3996F96EFDD93444F39681E003A2DA302F64AD2E3915736
              FECEFA34496C98FC1E00EB91ECF04134494FA3C43E9BC1B0EB170FC017D3756F
              486234C834AA0F39576D51A307E09777B1402AF737FF03047ABD2EC50188B0C5
              CE160E447F1EF0EC00317FAD2C7894494C1DE698883D29079804C75F2E69BB7E
              4819B543D9074934B64CB3552FA49131F730C861438F6C24B33DC015E29E1C60
              A17A2DB866AA9C61A281D51B0D97B3BC00AED1B6A3949100219EE66743F567A9
              3E17237A2FC0689DDEEF76AAA47A2D41B4A1E33D6FB8CAE816F1F5DDA5D31B75
              9FD0A95733C3DA6F0565ECC0967333E33A40C39358858806F08A2764385FD784
              450FE229D19E7CB9DC84488025F18407DD1CEF92ACED7D2961038CDBF3D13BD0
              8A9FC91B77C2F6168DD881F6FEC72B9EF2CAD8302C954B0B4600D446C745EF21
              A3AE13DB88E58457EF4EBDB0079F8B02682188E551EDDF2CDE356B4C7E8591A3
              EEC42E10913B50597785C800D8359CB2005A88D145F064A4FE7D3C13A0425075
              52FE4A9F91C4AB3DB9F6C5EC1D58ABCBFDDE6F2AC79731C532EAFB0000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'Shuffle'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001CB494441546843ED99ED4D03311044
              2715402994402740054005400750414225400794001D4005A091CEC8B2CEE7AF
              D945917C3F93B3EFBDF5C6D9F5ED70E4D7EEC8F93105FE7B05E70ACC15188C40
              6D0A9D03781D7C563CFCAE61AEB7AD67D7085C02D8033800B86A78F0D6AD3F0D
              F33C00B8CFDD5F1260E45FA2C12A093701B213FA422C918BE83580D324DA432B
              10E6B29048B38269CA744D2F8980D54A04D814FE1BC0C9F2A54CC04A22857F06
              F00120EC545201B5C41A3CD388BF11330195440E9EF39B0B8C4A6CC1BB09F44A
              94E05D055A256AE0DD05D6249E00DC241B7A2D7C439501694716FEECB887B304
              798F484CE0397FA9166A8A0680C7A5F47081B710289507FC935A2B175A03F577
              BF7A056210B3B4891F6225E0026F95426EF0160225F8B3A5B7B8ED4EFA64A032
              856AE0D9DDB161517576B26DB404CFB8718B65C7152E898462056AE063E89AF6
              D4A51A25540B7C8B848B400F7CAD84B9C0087C8D84A98002BE246126A084DF92
              F8B4E8892DE073125FD10197E454C2123E27113E1F16B080CF9D4EB38B931E2D
              A687BBAA7ADEF570371CAFABE0991AAE027CA0FA0547F6BC7FA54AE58B95ECCB
              15452DA4AA8CBBE699025D61130E9A2B200C66D7547305BAC2261CF40B22C998
              31A104EFA30000000049454E44AE426082}
          end>
      end
      item
        Name = 'Switch'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000017B494441546843ED97EB0DC2300C84
              DD0DD8043600260146601336804D6004D8840D4027B5521B1935F1232E52FA13
              F2B8CF762E4E477FFE757FAE9F1A4074065B065A0694116825A40CE09188B644
              7492AE13990188BFF6C26F52882880B17830BC88684744EFD24C44009889076C
              6D0053F1B501CCC5D70470115F0BC04D7C0D80543CF67C4ADC66E44EFBB15379
              1E62D8E2BDD41633C64F347B02400B2EA84386A892215501380894D0B9447132
              F6615942ABCC7A4E33216E1D52704D09413C6A1C11CD69C65C20A40083F84D61
              33660E2105E06A3BB72C4C2134008B80D002584184B7D3D2B2C03C9C23D15BC0
              BA959042E45A317B7570258437AAF4BBF4111DE6E71E6CE97EEC83E6235E8D9F
              E80AC165C01A0058E820272D8055903800CD46A8E775220EB734B2E0F259D8E8
              202CBD9DF1BBAB784B170A116F051026DE022054BC16205CBC066011E2350069
              13E7EE36BF3C586BA3F077DC1B6E3E3F77796801E6D677FFBF01B88778668396
              81960165045A092903A89EFE0554155431E4B725E90000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Up'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000012A494441546843ED96D10902311044
              E72AD052EC40ED442BD34ED40E2C453B9085048EE0B197DD0C22CC815FB9ACF3
              E679F126FCF935FD797E08E0D706654006920DE827942C30BD5D06D2152607C8
              40B2C0F476194857981C20034E81DBB2FE4A16BDB89D69C0C2DFCA371F015020
              580035FCAE003C01502018006DF8AA9F02311A60293C0D6224C0B7F0E792FC32
              7B0A879A1805B014FE5A829F005020460078E16BF914882CC0DAF034880C406F
              780A4414201A7E384404201B7E284404E00E603F3B16EDA8ACA74DEF2B4FFB60
              3F001C7A864400ECF5C020360032E15B13EF12DEFE27565F11001B6E10F68936
              DF06341316BC2BBC0D8902AC6E887DA300D80D7BF365C06B88BD2E03EC86BDF9
              32E035C45E970176C3DE7C19F01A62AFCB00BB616FBE0C780DB1D73FEEF03A31
              C9C0DEC00000000049454E44AE426082}
          end>
      end
      item
        Name = 'Down'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000013D494441546843ED967D0DC24014C3
              3B05200109A0802005074842020E400212908004F2925DB28CAF5DDB0B5978F7
              D708BCAEBF76DCADC3CC573773FF48805F37980D64036202F9088901CAE3D980
              1CA128900D8801CAE3D9801CA128F0B70D2C01AC005CC500CB7868DD182DA681
              307FEE0176068875AF7702B0AF8560002E00B6FD8DEE001488623E428975AC85
              6000E2A601B11021C6E6432E1A0888C98B01087115C2623E8CB0000A84CDBC0A
              C04058CD3B006A20ECE65D0053209A987702BC83D80028E746D92AA9DDE6DDB6
              A4FC895F698E77A738A9E3946D62DEDD40011A430C41ABF7F96F0782BB814F10
              76F3AD1A1843C4E743ED09FB2DF9F27DAB06861071ED7A6B7DE26A0D303548FA
              77094047671ACC064C41D232D9001D9D69301B300549CB64037474A6C16CC014
              242D930DD0D19906B3015390B4CC0330B83731714756500000000049454E44AE
              426082}
          end>
      end
      item
        Name = 'ExpandContent'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000000C0494441546843ED95390E80300C04
              93FF3F1A444701687DE51043BD76EC9988F4B6F9D7379FBFB1C06C8318C04090
              00572808305C8E0103C2C390BDA2125C29643CF82DCE024F64461A5044DE2D49
              B34921E5E4A40C0B248174B7C1801B5D5221069240BADB60C08D6E56E16A0F99
              99030B98912517580C98FF10C9B33EB663811194BFCEC000068204B8424180E1
              F2DF1A50C859E028FD521F32E540165886923288373344B37738A58E05144A95
              190C54D2557A6340A15499C140255DA5F7099A7A18314FBADE4E000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'GridOff'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000237494441546843D599814D03310C45
              7F27800D101340270026800D800960036002D8806E026C001B74049800F4C545
              CAA549ECE494D48954B5EAE5AE7E8EFD63A72BFC8F4300DFD3E7A1DE56005E01
              9C02B818118200BF93CB3F4784F001C8311C04016EA63072B11F42303FDE019C
              EC3139B60036009E421B08C0310204ED24C0A30FE1004681E04A1CA7003410B1
              28A2471EA60B3B1E4A849D130E5EF69D988AD2E4FCD8CDFE644D629B0790204C
              03FC003810F609D300EB49427310F7009EADE60073846506F7811C0435FA3A26
              73FB4E6297E4E700DE3C63623B36212873339DB602A09558AE16E1A4D14D4643
              9995766CC97077BD1B80C6A0543831275A8C9953351B99C6889E104D00529B9D
              53278D13B4738A00A43AA53627BAE5800440AFBD00B8132436F4AE2900BF9470
              864A9D9D7900A900340BF015B49EA995300BC08686E5048F6A72E1E4AB9326CF
              AA1B1ACDC363E5B4469D1C84E637BA03D0FBDA2A96B0D2D80B801642329ED7AB
              0134A5314B6DBE38D837F0E50FAEC49590139C739921F1ED28DA8935DEA999B3
              A4763201B0A4762A02D839CA8BB89BE173367DFF110921FF161E534A65077B6C
              CEF3873B77E27745001A892B3D95D0486CE8A7EA246E0110AA4A2A9C7C08F300
              12C410003908D300B74B6A27A927EE91039A3F59B83AD1DAC90A000DD4A81321
              66B59325002DC44C62AD011443C400D8901CD514380DEF49F6D831805893DED0
              36F5A3A3102995210493C5FC4A686452EDA24613B3EA34024036B147014841AC
              4702082158826CFE0069801040A2F167AE0000000049454E44AE426082}
          end>
      end
      item
        Name = 'GridOn'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000183494441546843ED99DD51C4300C84
              BFAB003A002A800E804E28012A80AB004AA013A003E8002A002A3866679C1B9F
              2FC93A0FE4674E7A4B22DB5A6913AD9D150BB7D5C2E327004C5DC1AE0ADC03B7
              C0F1D401A6F57F8027605DC6D306E0011080399A0028BEADB501F89E51E6CB24
              7E02670EC0C6002C277D052ED3CD6B40D77D7605BC24873740D7CE3A636AAB40
              00880AEC672028D4C78A7889DD2708080A2D9642AE2909D845D6B9DF01E9963E
              93BED218997C35C659DEEC767A976B646EE2299E1F1600691B6792B9E7C9E9AE
              8212A2CF63F2FF48B2DDADD16827F90DAA40CD8E2DFA804B7FF40193A1A05050
              A8C840ECC8E6B423ABD970AB9135DA4667494EDBC8576364F2D51867B9261BD4
              C8DCC4533C3F2C003AB771264A1C65DAA6464E37DAE9B782729ABA39770A2DD4
              568DE8C48EA321E642CCED66204EA7F37CB85389D852B6BC3FFF4E2175D2A6B3
              567CE14675F9024E1D8516FF934F0005E206381935BFDD8B29F3CFE51FCA3D61
              349360078551F3951934E1D8CE0160EC8C97EBFD01414DC6316DFCA666000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Report'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001C3494441546843ED59DB4D0331109C
              54001D0015043A800A1015403AA003A002A00228012A800E4809500174001AC9
              46D6C9771EDFC38EA5F54F92D3DA9ED9D9C769B342E36BD5387E1881DA0AAA0A
              DC00B806B05F08F00F80070077A9FB1402B70048A0C62201DEDFBB1402DF053D
              DF05FA09E0682A81DFE00085F01C4AC9772A80E4C3E640EECE90EF3402337A3D
              3CCA14C8F1C6D4121BABF54515082F1B1351B13C3402392134D829054962FB8B
              2A2060CC363102392194ED5E61832990A380F5814848150DA1E61B99F581DA21
              2454C56C93A239908D4ED86004FAFAC0D484E5B9AF00B60915165340505F3221
              81CD00919D2740969CBE9DF590588C4072D497F03F47935700F69C1D497070C5
              CF9CD7977FDB1A631592E0C4CD9378774A344380404F01BC05881FDDF0D83F5A
              2C8414C5A42C7680EF03E30B002FEE771304889580CF837C3871E1D50C01E603
              4BEA8123C1EFAC4C9C88FB35A8BA1212B237D4D8E9D81D03F8089E3DBB4AD50C
              010265697DEA71C0CE2BE071D3F3971112CD10603EB027AC3B2426136097F44D
              6764988FDEF605E07068B792C4CDFFC94707900413CD97BBD12E1537D2F3CC89
              E4EBBBA28078671D332350C7EF629BAE0D4EB9FF0FE02E6F31FE03BFB8000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'DeleteForever'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001C6494441546843ED59D14DC4300C7D
              B7011B1C6C001B1C9300233001C7066C004C0223C004C0066C00B2544B5694C4
              76DAC677104BFDAADDBCE767C769BBC191DBE6C8F1631088567028F05714D803
              B87392B9074071B3CC524216603B007479EC15005D9A11D1A25908FC682BAC7C
              BF8AF15F10E03A95A55495758622B935AA7D625180F1C852F2C479F8B8D7F000
              713FDC837CF275AF31083464B916321468CDCEF514F86454A4E41FA20081799C
              80DF00D048D4FCBB133805F09164BD464282E7B033009F91BB500E548E84C5AF
              BB029C450D9C76BF79582E39074A20091CF708032D955998023525D28DA9D623
              E104086C4E092DF307514232D3B4955E25A97F9EC8B5CE9A6CDC923DC00B9C03
              7801709259519B13E12554036F29A3500239F054366469395D16DE87C30894C0
              CB338F24F10D8048BC256516424003CF18D3C6CE91E84E801A95CE42B2616BBB
              4D8EC4C5219D852C5BA52491FA7757404E60FAB0C535AFBD16F0913BF50F23A0
              01B6DE1F04161DF3D6B40BBFA1C050A0A16C64C8AA25442FDEDB9900ADE1EF00
              68C2ABE6394EB7FC855101141C6E013C58823D04E879448286CF5A4A7C4DDF95
              CCBF9EBC042C49E9EA3308744D7766B1A1C0506066067E01471680317CB5C33D
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Delete'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000164494441546843ED99E14D03310C85
              BF4E40376004D8A06513468009A01B74846ED2B2016C001BB413802CE5A4A84D
              9338BD501D3C4BF7E32E4EECE7E738C965C6C4653671FF11806B332806FE0A03
              AFC08B13CC0AB07E17494D0AD538B604ECF1C80EB0A72406F4ACD400F82E59E8
              DC9EF5F15F0018F2344EA52CAD173092B2919D27350C0CFEC4A9E4E9E7C1E3B6
              E171C43DB8C7F3A0EBB621005194EF819BF0FE01EC8F18980377E1DB01784F30
              745506ACA62F82530F891A6FEBC436B4BF9D5937042037EF4AD1110340294827
              011EB30A8901315058394BF9A914520A2985B495D042969D052AA3DA4E271244
              9BB9282893DF4AAC013B179B3C25CEBCD6663A26761E369D6329158AAEE78186
              BF2802E0BA6272D3DB4089DBC69855A8C1DFDF4DA14FE0760C2F2BC6B01F6343
              41C8AA7B1868B985A9F035A9F21C55ACD100D84006E2B123135FC0C673F5E461
              A0359A5DFB0940D7F0560C2E062A82D45565F20CFC0062799D311B6C0DDD0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'New'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001FC494441546843ED986151C4301085
              DF29001480034001380007E0001C000E90000A1814000E90C0290014C07C37C9
              CD12D2F47A6D4A7A2433FDD1C936D9F7DE66779B99263E6613F75F15C05F2B58
              15A80AF46460E342E84AD2A5A4ED9EC4E4FAFC43D2ADA41BBF8155E05A1200A6
              300080BF3FEAC07BC1CC87A4A2C44E08E0CB58957A367EF9681DAD0046383C55
              8111484E6EF1BF14D893B42BE953D26B8497D8FC51823FBB0E8572DFD9BE24BE
              3990B425692EE94D5227056C613B8C80F0F33870EC9CB01B847E593BEC9F9C41
              2A653F4B82145FB8D606800280B0635200707C59BE1D8A14807B49770160AAA7
              0FC59802B1F5065180D8250E193694520042B061388D0A80D885BD13C7A00FA5
              490138755900253CBB439F816C21E4B307201E4C28F14EFB3D5416CA0E00DF39
              98674E8D4749170D008A3AC496610A10998402C7B9E03DA6407187D8172A54B0
              1984F7BE00FCDAE792782088DF5A06BF8F54E35E85CC3AE8D3210B133E4D0062
              DD4153254E7412CBA9C101D8505AE710F33D45CAF7432910D4215442994EAD04
              CD1A8FADA076A3D8BC0DB5D0A9D83A8447DB0D0840FDE804601569C7B6A900C6
              663CDCAF2A5015E8C94032844873BEEFEFB94FF6CFA90D8BF4BB5197BB00A2A5
              A51FA1592B71C03C6DCCE2663A54A044875B7D2AF516BAD5F1AAC0CA146536AC
              219499E0D6E5AB02AD146536F806EE4BDA31C8F8688A0000000049454E44AE42
              6082}
          end>
      end
      item
        Name = 'Lock'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000023B494441546843ED99F135043110C6
              BFAB0015A00254800A50012A4005A800157015A00254800A50012AE0FDC83EB1
              EF6E77B2898D23F3CFBD7B3B9BCCF7CDB7934932D084DB60C2E3D74F005893B4
              2869C5FDC2D19DA46BF77B9992B49400E6249DBAC09B6204C8B6A4C714405201
              D892742469DA18D48BA43D496746FFB16E29002095ABDA0C27922E9C647884A4
              D625EDD4FC569DB43AE3880500E3B792900F762F896CA0F9510610585F700F91
              D1922432D2C962011C7BACBE3A206DC1009AC0A75CC4646BB753F45274157AF6
              74BFE164638905399D3B4700CF585E1AE513930164F3E0067DF264648D852CCC
              3AE7F9AE55290680CF22B59DFF21C647CE9A818564EFDB1C31000E24EDBBD10E
              25F13FC462DFFF98AB002819F864A08B04FF97846817366BA592325AADC094C4
              D0E6ACE97DC61A5ADA0CCB47EC97CB902A93C2B7B5BC5A00B058554CA7082A64
              0C7A2A7AA5B16601F0E6BD4DF7D887F9DD6D638CA1002CFE2900FAA415006636
              5250EFC630CF69918479B002E08B01336925030DB26101ACFA7DF60BF4FF56CB
              9E01CE87D8DCFBC6669EF3208B6505D0D47AB4B606BFA10A71F2B63C8666EBD6
              336B069A00DC188E1EC19E15005AA7F51E65D633A0AC00EA07571510EBC157F6
              0C1000ED37A7766C84304A28A710D64D4FD60C58CA649B4F01E0336466A38DD6
              80E7E6394B2F14C06A886BC9C09FFA06B880A86E53426490C297C5AFF1E2D0F2
              11FBD74829820A19A3B5F5B00080015651FAFBBE3201F3F454AD77671600218C
              F5EE5B00F44E796DC289CFC03BC1238A31E3477E040000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'VisibilityOff'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000003BC494441546843ED9881B14D410C86
              F32AA00354800A50012A4005A80015A00254800A50012A400754C07C6673262F
              7693ECB967E69E3B6367EEBC7BDFDD93CD9FFCF993BD6772E2EBECC4FD97FF00
              8E9DC15E062E8AC8CF633B563DDF03C0F90F22F245441E548D1C739F05A0CE5F
              6B0EBD3E05103E03387DCF4474F7207A35B00604D9BB2122648F179F6F3A6A7D
              6C9FA127EFBF8AC8F743E93792D10A089CBC2D22F73BCE56FD02CC0B1179BF56
              38A23E908120D244F242D5DB601FAAC779CF6681648D6C06C4A7A65E80C221A2
              AB727C594478597AF1DE8367FF531179590D4A06003B19081C63CDF2190A42BF
              472272C9390CF85B956C540010A9CFEE80ADD5092044DE02211B8000CC706500
              709EC646B4FC8A4090155489BF4A2728962D80BC729B68A89CD55D11006410E7
              75217B4423EB13EF9A3AF50EA43E7028A29B1787301323003EF2C81CD151B588
              4064EA5429546C1008A5D410C4689823F23A52907ADF94B2C2E6598A93487338
              9FEF38D579DC7AC0881DD0968C5D352271DD17760F008DE5617B08DAE07C6F3A
              CD4078C7A8076CD3FC58D8C4A1884E80E07B955BE495C02CCB03B0BCFFD59C8F
              5460160407DB6788304A132D32F7D66C60BF8E25FFDCC8904BA54E96626C12D5
              6FEEF48AC41255E577A68498C761544DDF2FA0EDC316E98FE65C129CBF85ED65
              4FA31CDD272C4DCF457470208182094AA5E5190B80C2D5620DB5D71C42F37932
              3834CA043C7EDE9EAB649AADF6AC857A16804D53D5A875A4876304C23EC70087
              73D9B2D95E94D102B0055C51080EF4CDAE0AC236BBBB4DF33300D49ACE5D5D0A
              F962E1108C67EB77B6A1298FAD09DBECAE1406419BB1737D299251FCAA44C752
              2FC2E2E90408A8837844CB0F93A18C62C82A04542242D1CF2C5E21664064C9F3
              3F34A48D4C0D2259DAC22BB3F9484EAB35D1DBE79DEF4E05D13067AF8B95D91C
              9E4289CA15336B76384F7F517A0DA782A80BF6C65AE475389B3795E07BED9A6B
              E8E4231F8E34591BEF8DC644BA72674562F50ECCE84046C950769FB06306CE93
              8565F6F111C900B0DFCFE6FC8F4390C5A1E120F4D900A841D33E73D09552FD20
              ADF4054F0D8CE3D09BCA05DC80AA80D0BB44A854950C5803BDCBB77E4F3600C4
              8BC31908EDAC4F10503664177A61CBAEACB0BB406601600447A8035E15C5C9B4
              FE20106B00585A516044B2A23A3D209A25FBFC54260E01601DD21F7329401DC9
              FD2F6FEAAC2A92D20D3B594D0CB3B81580199A8CF6AE02B12700AB32B13700D3
              20F608600AC45E01F44074AF9E7B0660410C7F60DB3B004070C142A1BA33D129
              00D87416DA42EF37B571F219F8031D3DFD310C1B9D900000000049454E44AE42
              6082}
          end>
      end
      item
        Name = 'VisibilityOn'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000039B494441546843ED9981910D411086
              FB2220034480081001224004880011200264702240048800191001F555F5FFAA
              5FBF99E9D9B77775AE6AA74ADDDA9BEEE9BFFF7F7A7AE74EEC928F934B1EBF6D
              002E9AC18D818D819519D824E409BC6A6677CCEC9699DDF5773CF39EF1DBCCBE
              F9F3677FFEE2EF5771B096814766F63804BD3418C0BC37B30F4B0D35FF58002F
              CCEC59C8F0B1EBCB0E86DE98D9ABA58E9602401EEFCCEC7A63212421794832FC
              642025494A32437279FC34B327EE670ACB1200048E5CE2F8E59943060A766A61
              4FC20367F25A32C21F40CA310380EC7DF20CCA2181BF74FD968B4C4C2031F88B
              40D8F4F7AAC45400A09BE0554D88850D87FEAB8CAB2A614330486C3458837D40
              61D0600D40A8821DD88F00A0F3AF29786885DEDEC006A9A994E679EC117CA0F5
              DE2039AF13881BBD84F50064D9FC71FD9F0E167EEA32886CB5A69355E4F276E0
              0B49C1C6159FD395530F00B25116099EE72E8D2EA998356C54918841954701F1
              EEB907D9C3810D3E64C33372DA1B2D00914202C1D188F22CB58FCE56DE233083
              FCEE7B04FCFE76E19BB591B1C601E80CA03468A42BB245F094C6D1408602D1CC
              6A32466E1C9C1A80DEA9210388C150357A9B31AEF1D7FF035BB0515527988051
              49A3AA84B827E09BBECE1EE8684CB00060CC488779D16626FB021E5940D70435
              1A59193B9B082066BFDA605A2CEE17FA18E89E195116B36B459B1D0B11002FD5
              9FCC3ABD28003B79F724345321FE3B0911506461A64260A34D0CE8EE891974C5
              26FE114EF8994D4C29651F30F68ACB5994D1089ACDF9B0D8044B2BDDA232CADA
              51D73352A27452E654160141BFD33AC8E893744ECC54BAF25CEAD117B35A7684
              8D56029B562B11FBA4AA31CC9D70F35C1A357304A0C383805870D4CCC11C74C7
              7EA7A52632CFDC51574B33476F25C0DFFDCC393824AB763A4A43F21A7591C889
              C05A9F8BDA800437EAADE86AE9443586277C55017247885302E49CA85A064E69
              550E12519DB6649BACC7CFD6B213AE0010308EA39C78470691CBD1D721495B7C
              85E12F5E167465136D6700683E998F9F7B0202DDF4412359B4F602C1D295B21F
              F22D0789C91708CDEABC04804E5E80E45B041D82F15A850CC66B150A82AE5790
              57ABD3E5B280C02BB9EDC02C052043E8267355C59969EC9883D66172B6195C0D
              400EC816FF7A55A702406D87D151491DFA389681EC1469A8EAC4CB5D314486F3
              E52E32A92A599580ED6F646586CE7BC25949E8BCE3ECFADF005C58EA7DE18D81
              8D819519D824B43281ABCDFF018921E03192487AFD0000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Qualify'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000034C494441546843ED9881B10D411045
              EF8F0011F023400488801F01224004880011F0234004880011200244401D355D
              D5BA6677677A674A3DF5A6EAD7DFB7EFEDEEBDDDB76FF7EC890E7C9D1C387E1D
              09FCEB0C1E33F0BF67E05A21F86916D1D9127A5580DF3B440217257D2FC02F49
              FA3183C4CC0C3C91F4B8807E2A89CFC3D74C025F245D2988BF4A3A1D8E5E9AD6
              C8D0FCCB00F84CD29BD1246665E09DA49B01EC7B49B70E8100B2413EB5858C90
              D3B035230358E7DD82F0BCFCF79F875AEA68025827D1E73FCB2483A458582959
              1866A9A3093C94F4AC80FD2CC977E2ABE5FC2349CF47696834016F9DF725F94E
              6CAE34D4524712B823E97589EC4F27234E2129805F70D2C29576AF5E0248C240
              789BE418F7B1C655EBBCC8E641410C19FE3C093B867CF3F0572340246F3B3080
              B6A26C8D58CD2ED7EC75E9BE14BB9181F0DBD80C6B04004B34ACE85A41DBEF78
              0841A82D3A31C1C92C4C814CFFE5604B1282042937FFB6077E738DC8521EA3B4
              D6A8B8AF39933FF6F2E3F87260483FA9F68FAD1AF0BA351FC7DB9B35DA196AC8
              6104564B5CFE4212F65C5D5B04B8280E66441C8B1C3D98210FC0FB7AF3569C26
              C085681A4F3707E2DCE6CD3BA21F838413716E33482D19301CA417DD7B12488C
              CEBA67B1E9F19B1DC0938D2699F6100064CDA1C80C2432F30DDDD91767D569D6
              A2D34BC04890DA1BEEC6448BE26E254120D0BB6F861F8A545BEFF1E7F1190286
              DB8FCD9CEBD9B8C7A6B668935BDADC4380E8D9984C7FF0D6B7F55CBEA75F98DF
              93BDD46CB487807FEB9089A0CF607AC4DE43C08F05194BF5D6B9367EAC66730F
              015E5A59D3591ADE6C7303C1589CD8F2C7828EEFA8A1EE9525E01F1E677F40E0
              EDB47F23084024C758E017E7ADAFA436FC59024BE9A7B0F1F6A582C66ED1BB15
              EC5E19A66D34162040904B1CA3694CAC389A5BF3231026B38C11A409F8BD2FE0
              89BC1FC2901592B1CD3BC748CA8F21C8876BAD13939DEBBD459091907FEB5C7B
              1E8E02D8B82F4056105ADBD0F434C37427F69B774F80664634B71A12D9424271
              D3C2BDBADF9F6632103739C88573BDAFCF6BB2EA7E0D9F2140846D905B924BAB
              94A3AC18E8E24BE1E18DEC97A456B9B412F1B2EA0A6AD78FCB869C1AE8954B2B
              11EE8B33356D66F68ED3ADA0A6FEAE370353C1646E7E249089DAC86B7E03279C
              AC317B9277B30000000049454E44AE426082}
          end>
      end
      item
        Name = 'UnChecked'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000000EF494441546843ED99D10DC2300C44
              5F27800D80CD18810D800D1881D1E804B001C842150848ADA40537E8F2DBBAF5
              9D5FE2A669A87C3495E78F0444575015987A05B6C0069807257A010EC03EF5FE
              3E8476800998C2300196CFDBE813700E74FE35D113B0CA15707D0A889AEC6E0E
              7D89B9C13F60CBCD4102BE5C0555A0335893B810352124840AD1E9C284901012
              420F073EF6227D0B0D44C40BD72AA455C863C4B92E848490105223BB3BA02D65
              E15CD032AA65B4101D6D29CD013B5C980D7470ACF01658E6FE5EAFFE80C3049B
              8835B018CBCACCE798F3C7D4E94C6483CAD491BE3DAAC34A4074835205FEA602
              37C5724A31DEC9C9540000000049454E44AE426082}
          end>
      end
      item
        Name = 'Checked'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000188494441546843ED995D51C6301045
              CFA7001C000E90004EC0010E0007380009384002480005E000E6CE90994E4993
              E6AF4999CD4B1F9AA4F7ECDD24DBC9819DB7C3CEF56300BD1D34074677E016B8
              018E3B09FD021E80FBA5EF8752E80E10C0084D00D2F3A785003E3B467E2EF41D
              384B05F89E0CE8B5D8A31A42C2A28337C8ADA8060368EC8239E0026C8B38906A
              3A242F80674F9FE15348E25F8073E01A789A410C0D3015EF74EBB0D2A1E5DAB0
              003EF1BB7160AD78B9309C0329E29B03B8125B25EF9A962ABE298013A38F5C02
              31881CF14D015E7FB73E7DE42D02912BBE29C015F038C99B258812F14D013479
              0CA2547C73801084DEB913D619E5DBE7638B7F936DD4E78484A93C2811BF8903
              4EE01C621AD99CC87729257C1025E23775C0E744A9F82E006E61EB392F8D630B
              D6F77E93459C236CED18037091B27FE2B53933EB6729642994993A554E62FDA4
              1C150AA835FC0338F54DF6AF2F3804AC5B11D53827B54299388F22AF13DD7B3B
              A3B97AEDEF891CCBDD0DA05A28332732073203576DD8EE1DF80140A979314B2A
              62800000000049454E44AE426082}
          end>
      end
      item
        Name = 'EvBa'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000081549
              4441546881DD9A7B7054F515C73FE7DEBB8FC42486C702311924480843491C03
              52AA081251A6836307C1016AC10E5247A536D32920B153472D22740AC33882F8
              4230052A60C5628B52D058C1880F5009E51530680286E591844736FBB8A77F24
              84DD6493259BA0B4DF99DFCCEEEF7C7FE79CEFDEDFEF77CFDEDF1555A5394424
              05305B187E580455F54C8B5E55A5518403781AA801F40A6D278142C06CCA3B4C
              C0EA2B20C14B6D4B220400C3AF80A4DAD36C6090AA62D1809F1089FDC059AE2C
              5C0DF46BFC2CC030A0D40A3386639AAA7EF47D6576291091B1C0DB615DA940D3
              15686DD0278011C3B70F380D1C02B6011B55B53EFE54DB87580206AB6A2C01E1
              281091E3223247555FED606E97843605006C5DB4880C8FA74D4ECDB973945556
              B27DF76E566FDDEA397DE6CC7211C952D5C73A2DD3561053404A6222A949496D
              72529392B8B6674F6ECBCB63E6C489326BD932D67FF0C11C11D9A1AA6F755AB6
              51D09EE971494874BB79AEA0809F0E1DAA2EA773BE884867C70847A70B001011
              9E9E3EDD080683FD81219723C605C425A0C2EBA5C2EB25100AB5CA49F778C8CB
              CEF6D17093BC6C88B906A2E18E9933ED93B5B586659ADC3E64087F7EE821BA5F
              DDFC56023F1E3020F1CBB2B2411DCEB20DC47505FCC1A01FF824180AEDD9B463
              873EFAC20B512F852735159765F5EC508631D091353043550701E3FE51526256
              9F6D597998A6898A389AF78B485711B95F448A4464A7889489488988BC2422F9
              ED49A2C38B5855DF723A9D35E5DF7DD7C2E6ADAE26180C1E0B4B3C4D445688C8
              31E065E017C00D0ECBBA8E86DA663AB05544D68948F2A5C48F6B0D844344C469
              590E87D5D2554969699DCFEF2F6DE47535440ED8AA495919194C1839925B7272
              18D8A70F6EA793733E1FBB0E1EA468F366366CDB36C114491091BB54D5BEAC02
              8069B6AAAB4FAF5E119D5F1F3BC667FBF7BB81E2C62E97AD9AF45A612163860E
              6DE1E42AB79BE139390CCFC9213F2F8F82679F1D0B4C04D6B415BC2353688388
              54002F4FCCCF97ABDCEE2643C8B699F9FCF3B66559A5AAFA59F8A0FCC183633A
              9E386A1453C68C5197D3F9782C6E5C025C0E870B48BFCAED4E1F3F620473A74D
              6BF2E3F3FB99B17831DB4B4BC51F08FC2E1EFF0005E3C78B3F10C81691BE6DF1
              E29A427B56AC885A1EAC7CF75DFEB4668D9EA8A911E07155FD5734DEA9DA5AD6
              1617F3FEAE5D78ABAB19D8A70F7F983A959E5DBA3471323C1EFAA5A7D71DACA8
              180DBCD8A9025AC3A68F3FB64FD4D4184015F07A34CE4B1B37B270ED5A3D5B57
              D7F423EC292FE7AB438782EF2F5E6C99C6C54931E2FAEBDD878F1ECD6D2B66A7
              D64233C68D33EEB9F5569C96E5310D6387886436E73CB97225E77CBE0AE03740
              26E004EE385859C9277BF74670337BF532125CAE816DC5EC5401B7E4E6F25C41
              01FF5CB0C0E89A92926C19C60611691EE339551D007C0A4C05DE0456D9B66D1D
              3B79328298E1F120D0BBAD98714DA10AAF9790DDB03DF7484D25C1E58AB0E7F4
              ED4BD1638F59630B0B0701E380378000701FB05FE02385EB2FF0BB24276B5E56
              1669DDBA45F8494E4CC4564DEC7401178A39008765E92377DF2D8F4E9E1CC1B9
              212B8B89A346F1E6871F16006FA8EA0911F18AC8BF2DC370DC79D34D8C1E3C98
              BCFEFDE99B96167553703B9DD8B6ED8A66EB9080C662EE2BA036100CA62D5ABB
              F64743B2B3B92D2F2F8277DF9831C6EBEFBD374C44128064D330FE3AA0776FEB
              95D9B325332D2D661CA7C381ADDAA2960A47478BB9DB811CD334FFF6DA3BEFB4
              7812917BDD75382D4B818106CCEA929C9CB0FEC9278DF0E45595831515ACDEB2
              85EDBB77B73B89CE28E634140A2DDFFBEDB78116CE45E8D1A58B1F48733A1CBF
              2CBCF75E47D7949426FB1765650C7BF8611DFEC823FC76C912BE3C74A8DDF13B
              6B170A845AF977E6763A017203A150D7BB6EBEB9A95F557970E1C2C091AAAAF3
              C0DF1DA679245A41180B9D25203FF39A6BA23E8EAF3D7F5E808C8C1E3DEA5212
              2F6E28155E2F47AAAA4C551DA4AA3F73BB5CB5D1FED5C54247EEC4A345240B18
              2622BF9E3062448B1F4355397DE68C133032BA778FB09DADABC334CDFA502050
              2E223D0C9181FDD2D3DB9D445C024CC3B080672E7CBF253757C78F1CD982F7CD
              F1E3D40702267024D1ED8ED82AD33D1E6CDB7689C8525324AF57B76EA19CBE7D
              DB7DA81297805993265975F5F5188641567A3AF9797962992D63177FF105092E
              D791F33EDFE9BAFA7A0DB7A524263279F468F9CBE6CD0FA9882E9A3123AEE747
              7109983E766C4C8EAAF2EAA64DF5E77DBED5C0C9AA53A7B43967C1030FC89821
              43B8A67B77E99A9282B7BA1A4F6A6ABB72B92C0FB600D61617B3EF9B6F9CC04A
              E040795595BB3E10B9D35AA6C91D37DEC8A0CC4CA6CE9B67AF2B2E6E779CCB22
              E0A3D252662F5B1612911755F520B007A8DFF2F9E751F99FEEDBC7EEC387E3CA
              A553051CAFAE666E5111F73CF1840683C143B66D1702A86AD0565D3F7FF5EA80
              BFD955F0F9FDCC5CBA34186FCC986B60DEAA55242524B46AB755395153C3D113
              27D8F3F5D7D8AA88C84E55BD53554F5FE08542A167CA2A2A7E3EE9A9A7F4F753
              A6C8B53D7BF29FF272FE5854A4072A2B6D8765ED7FBBA424FBF0B1A6A7309CAA
              AD8DADA0F1906F2E9187683735F607B9F483B710B01DF81561C7A0E10DB85F44
              42E1E344C40F4C314D735D34BF86C8C9C6B1639BD966861FF2B586A1341CA8C5
              C219A05255CFB54552D55744643FF0209001EC55D525AA5A2A22DB81F9CDC7D8
              AA6D4EAF3605A8EACE98A9B713AABA8D86B3B4E6FD87E3F17741404DB3FEE522
              72251EB386A31A2E0A286966CCBEECE9740C0A7CDCF0E9FFE15583B0973DE6D2
              70E6FB4327D85AF3027308DBE5E47FFD759BFF021E7D0D7EABECBAC400000000
              49454E44AE426082}
          end>
      end
      item
        Name = 'EvBlue'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000081D49
              4441546881BD9A7B7054571DC73FE7B2D9249B2C642101ACA38096144B212830
              963454405AABC5B1652C8823450BA5566474C4169171A6B67F543A02D5BEDB69
              075F506146868A580A049047CAAB108A2D10453B7524C94213C886A4BBC93DFE
              B17B2FE79E3D67370FEA99D9993DBFE7F777CEEF771EF75E21A5E4A36A420807
              404AE97E643EAE45004288EB8019400D3006A80462405146A41368011A8033C0
              7E60B794F2FD7E3B9752F6E9079400F767C0B880ECC3EF4DE07BC0C03EE3E803
              F052602510EF2368D3AF05F83950D65B3CBD4A2121C43DC05AE0E366BED35412
              1D78B6ACBCA239366C68A2B0A8B81B21C4871D579C96A6E6D2D68BF18AF6CB97
              2BA574875B5C34010F49297FD7634C3D0940083110781E98A7F342A182D3959F
              9B74F09E077FD838E1D66929177014BEDE073859B72FB4E9D76B869D3E7E644A
              572A35D6E07233B0504AD9D2EF0084109F02FE4ABA30FD56505878FCEE854B76
              CD5BB6BCDDA4E7BA2E8EE3287DF0BAEAFF0D4FAE2ADAFCC2B33353C9CE899A89
              73C097A59467FB1C8010A20A781D50A7FCF2CD5FB9F3F7CBD6BE180F85420130
              C640C89E01535BFD83C5B1FD5BB7DC0B9429E438E9208EF53A0021C468D22BCC
              508F56100E9F5AF9D21F5E1B575D937234D41ED07C804D7C8F76EAF041E7D105
              73BF964A26C72BEC0BC05429E5E91E072084180C1C054679B4E2D2D283CFD51E
              DA39684879AF370E3D9D6C34804BF1F88025B7557FA1BDEDF25485FC1E30514A
              795197CFB2208410C03A157C241A3DF0CAC113BB74F0EAF6EABAC1CD56ED056A
              21070D60504545F7CB6FD6EF2E8946F72AE411C0BA0CB6DC01000B81AF7A9D82
              7061FD333BEA6A8B4AA23E441F8405A4CAD3CF1026878155CB75292C8AC8E7F7
              1CDD53100E9F5058B332D8ECF684104380C7154AEBCF5E79F5CF651515AE2A9C
              AF28D5C9B00562EB7B03515A56C663EBFFF49A10424D9B554288726B00C00AC0
              1798367BCEBA7153AABBBDF430A58C3F2B2A6843843AC90F2CA3681A94D15513
              E5B4D9737EA3900603CB5519BF883391FD9BF41987A2E2C8C10DA7FEF5069095
              77B95AD64696633FC8A7EBB5B96347DE96ECECA8CE7413C02829E50534F9451E
              78806FFEE8277B5C0D7C4FCEC459239D417B3545ECB6F41DDC6BF31F5AB953E9
              9602F7791D7506DE257D14A6201C3EB6F1DDF7B7E602EAAFFB59239CEEABA399
              6B6FD067C4B6BCCEF9CC2766A592496FB77E474A3916CFAE1062BC071E60FC2D
              B71EF28CA9803D87BE22A61176027CFDBFBEDCEA33A2A79BD7C6DD5C53A7A8DD
              2884B81A00305D61CA6FFD78455C37761530C6D693E34216C03CFA6A70F3962D
              D737B119AA5E8DAF3460C0B991636E0A48BA868435AD3ED9BCEC190C0034F8B0
              C95D7FD3041CC739A7906B541B7EFA4463831B74A7FAA8BBAE6B9C117D8333CD
              A015A41394CBDAD95D97682CD6A090C6A8F29FF6A843865FE74F952D2D4C4596
              4BDEB61B9BF6179B0FC77102D880EB011C21440428F6A843860FF3CFF7C622B6
              00CB7916F265CC206DA3AEDB89550CBDA274234288420765ED0788444ABB7507
              AA13DBEA92B51A19409926CE74E8B31577241A4D69EA518349612CCC2CC71621
              DB46A6020B04D5031BBEBCE5349A500989445BC85498B6E9CF054EE7998A5BE5
              074167FB4AB4B61668626D8E94B203E8F0282DCDE72301A0BE11B3B37C1B9BCA
              B38135D588C95FCB85E662A5DB2EA5FCD0D3F597A78BE71BCB756346679AA39E
              8032E9E7AB1195D4D2D8A81EA51B54BE7FDF6C6BFDA05237664A8B5C679B809C
              C58E2D9D7C594DC705DA5A5BD42723A7553BFB7CC5EEEE51FF38793C60355F21
              065792FC97151B58D5AE1EE03FEB8F0BD775472AA27F53E56A5583EBD73E5161
              346E30AC1AB12DA126D8A65B9B6E378069CDE3151AA9D6D79552BE03BCED714E
              D5ED9FA203B602C9C137CE9CCFD3EC28864C9BE6A94375D54AB75E4A7946F7B9
              CEFB934A25AB363DF7AB22DB3138902286338B492EDF7D5A0D4897DDF8F49AC2
              AE54B24A11F7AF99EA85A68CF495721040B8A8E8E81FFFFEDE5FF23DA8EA4FF3
              2F4504D350F327E78E1D312BD9D93929D3BF048C9452B6A2CA6608CF78FD6467
              E7A45F2E5D5C6E5BC3F33D65C802ABA6885EA88A9C5E4FAB972E1EAC800778CA
              03AFEB02AC02FEEB750E6CDBB2E0D8EE1D610F40AE7A30ADFBB635DE56A8AA8E
              039CAC3B10DABF6DCBB7157613B0DAE4170029E565E0618554FA8B07EFBBEB62
              E3F901A6E3850ED204D47A7AD5F4F5A5B635DEE43CF69D6FDC050C54D496A9A3
              0FF667A3AF0273BD7E7149C9E117F61E7B231A8B7567096BA0AE45BD5C696B73
              16D54C98D991484C51C89BA49473B2B05A0218081C066EF068C59192234F6DDF
              B73D36FC63DDEA7927D78EAC9E67F422353D1F72498FFCF76756EBE01B80C952
              CA4BBA1FA3FF4C2ADD81520F1D57DA277F77C6E7E7BC55BBA35055B6A5936959
              54FF9B0E6BF57B77851E983AF1EB1AF826D2EF08B2C043FE171C6381ED04DF89
              25264DBF7DFDC3CFBEDC58100EF7EA51BBED998FDBD5C5134B16561CDAF9FA7C
              20AAB01A813BA494F5568C3D78C53402D806DCA8D20BC2E1B7EF9CBF70C7829F
              3ED206F6B5DC962A1EE9B7AB1E8D6C5DF7D2EDA96460A302384B7AE4CF91A3F5
              F4255F29E93DE25E9DE784420D95559F3D30FB81A5E7277FF14B491348BD7F64
              D7F6F0E6179F1ED670E2AD5BBABABA6E20BB6D04EECFA4726E6CBD7CCD7A37F0
              24F0490B3F5E1C8D9E292B2F8FC7CA87250A4B4ABA1CA0A3BD3DD47AA1B9A425
              1E1FDA9168AB94520E35E903E7492F951B7A0CAA8F6FE85700CD5CBB17DD1F00
              8FD08737F6FDFDD46011E9BB84DB47E075F4F353836BF9B1C774AE7EEC319AF4
              CB08EF0EDB41F0638F0340AD94F23FFDF67D2D02B01AFF3F7C6EF33F5E6AEFEA
              CCD281EA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'EvBr'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000065D49
              4441546881DD9A7D7054D519C67FEFBD9B4DD20009410C84A906DB3A051407A3
              0ED59A06708A83E347A1A8D4C2F46B00AD1A66D4CAD496C1C274C81FA5EAB4D3
              DAAFD1301DC70A85B69430626D332E109AA631248D404AE463302524D9244B3E
              36BBF7BEFD63B34CB2BBB9BBB9ECB6699F993373F7DCF7BCEFF3DCB3E7FB88AA
              321A22224001930F41551D88CB555546444C077601414027693A03AC8E725655
              A2E4B381E3938060AAE96BB1022A2601A989A45EC0ABAA7888603163F1F711C3
              C984D940F1C8F3346001D0101510DB68EF54D5E07F8A592A10912DC08BA3B20A
              802B35305EA1A781DC14FC0F13A9D656A03E616F9121380A304C73AB6D59D327
              E8332422BF052A55B5C13DB5D4904C80B972C393CC9D7793A393FEBE3EFA037D
              5C686BE583BA6359173E3CFD8888AC12916755F5E5B4328E81A30080F9B72F66
              51D9D209396DA9ABE517DF7BC1FCB0A5F92511F1AB6A956B86496064C2E9FCDB
              1753B9A75A16952D51C3347F2C22191BD933220020CBEBE599975F95EC9CDC1C
              6043A6E2644C0040DEB47C967F699DC79B93F340A662B81270EC5035CF3EF879
              9EFFE20A7E50B181A6DAC3E3DA2EBCF36EAC50A8D435C3247025A0AFAB8BD3CD
              8D9C6AA8C7B77F1F5B1E5B896FFFBE84B6D7CEF9389665658B48DE55311D07AE
              FF42397979278129C06D22F2EE2FB77F3794D06ECA94E8E3B4547D8B48BE883C
              2C226B9309BFAA36A0AAFDAA5AAFAAEB7B2E7564057AFC7136977B7AA28F7E11
              2911117548DB44E46E318C0F8037812AD334DF70E290741C48117E80814080A9
              056307EEB696263C5E6F7728181C8AAC95A064DE024C736CE8F6B36D3A1008DC
              6018C6C18F4D9D9A73EF635FE1CC89169A8FFAA6E0807409B8DF343DF635C5C5
              71355AB36FB7A5AA8746E7BDB86B37D3A6178EB1DBFE8D2F0FD7FFF9D09AFC6B
              665A957BAA8D99C573F8CD8F76D27CD4E718D8B58050303853447600C522F2E8
              E71E5A15F755EBFEF4368DBE1A13782D45B7F2E48E1F7A6616CF4999876B0156
              385C083C0F3077FE4DBAF6B9EFC8E8F7CDC78EB073D306CBF4780E8743A183A9
              F82C9C357B7851D952EF4478B81270EB92656CAD7A0B80A905055CFFE9F912FD
              FA6D2D4D54EFFA15EFEE7953513A6CDB7A3425221E4F76D9FD5F20DA4E52852B
              01338A6633A36876C2775595DBB4D15723400858A1AAEDA9F8DCFCD3D7DC5049
              FF54E2E6C57749E1B545005E318C032272E344CAAB2AE75A4F72AEF524B66525
              B54F572F7405AB1EAF60E5C6A7397CE0F7FCE485678A8606060E8A48A9AAC60F
              1231F0775CE4FBEBD7E93F9BDE1700C334F17A9D9B4446267322C267EF7B90AD
              AFBF65981ECF75C0E654CABDF2DC53D6E9E6460BD80BEC56DB1E080D0F271CE1
              A37025C0F7C7DFB1B1FC0E3696DFC113CB3E43E5E35FE5DCA91371769FBA6511
              6B367DCB344CB342441C97A6E74E9DE07D5F8DA9AA0FABEA4A555DADAA375A96
              B527ED020603012E9E3FCBC5F367693FD346EDDB07D8BCFA3EDBDF7131CE76C5
              DAAF93E5F51AC072279F4D47DFC39B93735655F746F354F582AAFE2CED022032
              9953555155016E1B1E1AEADEFFFACFE3ECB27373B9B56CA91886E9B82EED6C6F
              C7B6B57EA23CD2D20654B5DE0A875FFAC75F6B0713BD2F99B7C0E3CDCEF98493
              8FDEAE4E3B3C1C4CA9CB1D8D7436E28FFABA3A13EEE6E5E5E72306339C0A077A
              FC21A0C7C92611D2296061D1752566A21743FDFDA86AC0A9F0C81EED84B7335D
              8F036AAB39D2B3E401F71A86F14469F9B2849D769FBF9B70D8EA741BCB09AE05
              0407073E0974477FCFBA7EAEBD7CCDBA84B6ADC71B86C2C3C166B7B19CE04A40
              E1AC59DC725759C44196971B16DCCC43EBBF69646567C7D906070739DDD4E801
              EAAE8AE9387025A0B4FC1E4ACBEF49C9D6B77F2FE150280CD41039054A2B32BA
              2F347039C0AF77EE08A3BCA1AABD998891F6C95C14C34343ECACD8A8BD9D97C2
              B66D6FCF549C8CD4C0C986BFF1ED471ED0FABFBC23B66D6F52D5B64CC481146A
              A0A5AE96C1CB971D6DC2E1307DDD5D5CBA709EE347DEE3CC89161051E029557D
              35D6BEEE9D83E4E68DDD6CF077FCCBDDC71C1940AA197B8896ADAA18A6D9CDC4
              0FE042C01F8085A38F4347E2942429BB2DB6CCA8B25B626C978C3EE44B08DBB2
              B692DA111344C6848F009F4383F5E3BC36389262AC2B7014A0AAAF4CD461127F
              BD40653A7D4605C44EA28E48E43F3C9910BB8B10E1FCBF7ED0FDFF71D560D465
              8F2A607012101C2FB51173D94362AFDB00245B80FF9790F0BACDBF0125BFB982
              097B13CC0000000049454E44AE426082}
          end>
      end
      item
        Name = 'EvBrown'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000009CF49
              4441546881BD9A7B8C55C51DC73F337BEFB24F965DDCF232162A2A6A6A110905
              5DAD08B6F5916A355A6B05D4B41AABD8A7D64463D26AD5D8D45AD1D6A4362095
              9A6AB5986A7DA0D20A5411545244405A81368A0BCB3EE02EFB9EE91FE7CCCC6F
              CEBDABB0A027B9BBE7FCCECC99EFEFF5FDCDCC39CA5ACB277528A514A0ADB503
              9FD818874201A5D4186026702A3009381A68002AD2263D401BF06F6033B00A58
              6EADDD76D0835B6B87F4032A812B807F0006B043F8AD05AE07460C19C7108057
              013F013E1C22E852BF0EE00EA0E140F11C500829A5CE07EE053E3BC8FD9DB535
              D5EF7EA6A1AE79F461F59D15C3CA07149AEE9E1EBDB3B5ADBAB9A5BD714F67E7
              51C6D8B1830CD1921A67A1DD4F60FBA58052AA1A78009897BD97CBE92D271D3F
              69D5FCB9E7EF3873C6D43E03683460406B3089C489C0B0EACD7772BF7AF8B1C6
              D5EBDE99DEDBD7FFF912433E035C6EAD6D396805945247007F038E97F2F27C7E
              FD772E3A77D92DD7CD296888416A30C6248A68C01827063406E3CFEF5BFC44F9
              3D8BFE34B3ABBBF78B99A1FF079C65ADDD3064059452C7012F00E384B8F0E5A6
              694B16DE716373AE3C970095964ECCECCF8B3D427C9E2A78FD6DF7D73DF6DCF2
              39D6DA0631561B708EB5F6D50356402935015809F878CDE7729B1EBEF3A6BFCC
              3C654A9F96E616A013EBCA7B012425FB04C9DAB7DFD5175E77EB59DDBDBD2709
              28EDC069D6DAF5FBAD80526A38B08684CF01A8AAA8787DE5A30B9E1F376AA42D
              B6A48CF3E2731F32AEADD621C4DC91B6DF5BE852D32EBAFA94D68EC21902D207
              C0146B6D7316ABCE0AD2E37711F8CA8A356F3EF5D0B271A31A6D1AE0DE72C99F
              04A4B4B211E75AEBE4DC08BDFD5046F485DA9A6ABBFE99452B1BEA6A5E1278C6
              028F28A58AF016099452DF022E76D7F97C6EE38A250B5EA8AFAD1A30C2EDCEC8
              092407D23D51FB040E4AA6ED7C5885BC48DA6A6F889CD6AC7EE2C1559515E56B
              04B4D9C0751FA9401A3A770B5161E11D372D3D7C74E38083256826D542C7D726
              B5686A6E378091A0BD878472E9B5F3D6F09A1A9E7DE8EE6795521F0A3CB729A5
              A21A92F5C00D88A43DF7B4E98BCE3C656A5F20C134E6DDB8E08178DF44160D1E
              D3AE9176041A2CEE64E903BDF2C77CEE08AEBCE0AB8F087CC3819B25609FC44A
              A93A603B500750519E7F63FBF2C79EA64C299778835165B8973DD204167D3D4B
              F9240F762C66B0E4D947CEFAE66985CEAED3D3C6DDC091D6DA0F42CFE4B8DC81
              07987FD905CB8CB2CA25A92B462EC683854B8493FBE9D4D202A70368A23E223F
              7450DCB1DD5D3FBCEA159239132433DCAB4A79E02D6032402E97DBF0FE8AC7FF
              8C522A246014CDBE40C5167651E26812B2BDC948B31E91155B6A3EFE8C8B6777
              75F79E9C0AB6A65EB03A057F94030F30FD846357A194322E1E3D63B847EA34D9
              8CB7B097A71E09208A59C67B51868C31A1AD64B0F4FEAC1953D6128E09C05469
              8E99E2263FB8F2A29DC84223C2C85B320A5FE315F2422D2C2DE23D699E329144
              E0C3C72571F08C016EB9666EBB18C06376DD9BFC63947ABF69CA09823E342646
              2B2925C4B2A8C0AE30F97E4654109127D9E4969EF463A573AD09878F259FCB6D
              120A3449052639E9F09AEACD5122792E3719D0C268C8F6C1733E1C44C8C58A65
              8C2FFEFB5A92B633181AEBEBFE231498241598E8A4A30E6BD815B95B5A4EC67D
              865D028B08768A42223CD129E353D67B9160F588D592D01D37A6B155201AAF94
              2AD3E9FC62845760645DA70325CB9031D2C52E86C3C05E6E626FC82225DB0745
              9C62461435ED9F157849337AE4C86EA1401EA8CD91AC7195935657560DB84124
              3D86A142DC684FB1AEADB87681178554C0266B4B22D76813403B769218460CAF
              EA273E6A35258E309709DACB8293DC1284202B71867DC262C689C55CC929EEBD
              224067BDAB4B4225077486D6B0B7735F4ECED3DD5CDE18617D9329F946942513
              AC1F15B740431173068B0BA111807CAD31B4EF29E432F8F7EA74F5DFEE24BBDA
              3AAABDA59D05B51606748F3682624DDCCEB348DC57B60FA60D7D83BA22DC44DF
              1DBB76570A491FB0D735D9E2A4CD2DAD8DFE61460E4444736EAC4095A25D1431
              426193052B88C2ADAD256A59B68CE183E6DD72BDFC9EB576C0B5F605A2A3D039
              2906A61994EE1C4D961A33A25C22D03204B5CE763631A30A83ED6AEB98181A27
              985DEF154E6AAD1DF3CADA753A0033C2EAA12A070F896AEC09CA142B29B759E4
              E1A932B9103A44DDB76CDFA1FAFAFB8F113D5748055E96CFFCE5C2C7C744383C
              CB048690EE76A04D11EF236A4108A3900BC24BDAE54BC82FF9FFE7BFFD433D82
              EE1D669D5A7D2BF0BABBB376FDE6266767C7009E4EA3B98F335772AFF4DC5F0B
              2B87DC8A81A6B922A939E43800CB5F7B739A00FF2EB04E7A0060913BE9EFEF3F
              E6F607165707F34AF690CB40230631E9B5A456C1F759A56237095F8667BB56BF
              7FE2B9F2EEDE5EA9C062B7772A173435C036602440793EFFAFADCB1F5DAA3D35
              EA40CEDE231245A81145CBCF52CB51B137241735D17E517A7DE4AC4B67EFEBEA
              768B997DC0046BEDCEC803D6DA02C9CE3300BD7D7D27CCBBF1AED1DE32CECA72
              FAEB5928CC5CA3F012741B31A2EB1679C564082DB9BEE1CEDFD40AF0000F3AF0
              9102E9714FEA05005EFCE7DA394F2D5B392C84063E6613EC211FFC5AD7BBA904
              3BA57FE2A942091A4EAFDFD8B0B16CC9D32FCD15F85A813B25E048016BED3EE0
              47425479CDCF7E7DE1B6F79B7361CE12CF1AB35B2E72EE935D2EFA256A9CAB48
              E739A7EEEE28E8AF5F7BEB39D6DA9102CF4DD92DF7AC07B0D63E8948E8818181
              89A75FF6BDB377B6B4E59CD5B4B09CACCC1EA00FA398424BAD17B27C0F9AAEEE
              2E35E3E2EF9EDAD3DBE7D7E9C05F8187B27807DBDCAD065E05FCCB87CA61E56F
              BDFCC8BDCF8E1F37BA3F4CE44ADA20514654E1E2BDA0F81D814CF496F6F6B219
              DFB8FE4B7BF6169AC4E3B60153ADB5BBB3E3941CDD5ADB099C0DFCD7C9BA7A7A
              4F6CBA64FE25CF2C7F6D58307B3C3993891DE25CEE3CC881755CD00CBCB6EE6D
              7DE279577F2D03BE85E445471178F8F8171C4793BCE090EFC4BA4E9F3679C9E2
              BB6EDE31AC2A6F650A040B4BDB04EB7AF22DDAC9D35C7DEB2F1A9E7A71D51C2B
              36D70478B9A5B2FF0AA44A8C2579C5F40529CFE7731BE79DF795E77FFAFD2BF6
              E4A2A5611A323A14339D71B40CA9BB1F5C5279FF1F97CEEAE9ED9B92197A6B0A
              7EF347E2DBCF977C95C07DC0B7B3F7CAB47E6FF2B113575E7BE9F93BCE9939BD
              2728223D915A3FB5FCCBABD7E5172C7EB271CDFA4D27F7F5F71F5762C8A5C095
              D6DAB68FC57680AF59CF4D159930C8FDDDB5D5959B0EAB1FB16B5443FDDEAAEA
              61035A97D97D9DFBCA3E6C6DAFD9D5DAD15828741E6DAC1D35C8103B811B1153
              858F3D86F886FEC71CDA17DDEDC0ED40FD27FEA6BEC4A7067F278997A1005F03
              CCE7203E3538541F7B8C26FED8E328928F3DAAD2265DA995B7904C85DDC71EDB
              0F7AEC43A1C0A00FFF143EB7F93F5C67794BF543A3F00000000049454E44AE42
              6082}
          end>
      end
      item
        Name = 'EvBu'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000068749
              4441546881DD9A6B7054E519C77FCF397B76379BC4A64C41AA78AB2015A3D6CA
              8843A3625BAA42CB45858ED88023066229D3A9B4181518DB694B6718EC74601C
              AB850F96CA4CEAD45151DB0CA455A403141A1344AEDA2C0824213490CB6EF676
              9E7E20097BC95EB27B68637F33E7C3BECFF33EE7FFDF77DF73DE3DEF11552519
              112906DC2981FF2DAAAA67076B1D3880C5400BA0C3F4E801D603BE01CD71E257
              0C0381B91EF580316000B814080F03614339E6A82A2ECE3311B0B8801F686778
              E101CAE33EDF0EFCB1DF405952F22F54F5A5FF8AAC1C11916B804FE29ACA8081
              1148D76911B0284BED28D001EC01B6A8EAAE02740E998C0680CB805B73AC752F
              B04244FE0C2C50D5B68294E54836032CA99A6DAFAA996FA48B77F704693F738E
              C67D4779FDAD1DBC5DB7EB1E11D92D22B7AAEA1967E5A692D540364A8A8B2829
              2EE2EA2B4733737A057FDFF5A1CC5FBC7A4C20107A0198E380C68CA4FD66F365
              F2A47236AC5F6EDAB67DBF888C75BA7E328E1B00B8ABE266264FBA216218C643
              17A37E3C79193871AA9DE39FB61189C6D2E63C30E34E4F6971D1D7F356962379
              CD81D9F356DAFE632D86CB6532FFA16FF1B3150BB15C66424EF90D5F22A6F675
              8EA8CC405E23D0DB1B0E003BA3D1D8A18DBF7F87576AB7A6E48C282B251A8D95
              162A301B855C85AA55B5514456BDBCB9EE270BE6DD53121F344C035535004464
              3270F9203542AAFA868808F0609AF37CACAAFF4C27A2E0CB28B0C97FBCA526B9
              B1FDCC392CCBD509E0F1B89F0A85C2DF4ECE314DA303180108503B5871CB325F
              22C36AC009031EB7E5B2931B1BF71D45C4380C50E4757BEFAAB899F163AF1888
              777507D8FC6A7DFC0292C71F9B89CBBC30971A9A8ED0D07424212799820D1806
              4BC75D7B8524B76FAEDDD6DBD313ACEBFF3C6B7A050FCCBC73207EE2E46936BF
              5A9FD0E7A9271EC6E3B9A0F7850D6FD0D07424E3F90B31B045443CC0C8472BEF
              4D08BCFED60E3ED877D46DAB6E2AA07E4EE465C057E429064ACA3E57A28F564E
              63E6F48A81D87B3B1AF9E193EB62886C54DB3EE694D074E4656067FDF3FD3F99
              819F4E20D04BF58F7E4DDDB67F608A1CB16DFB09471466C189490C40577790BF
              6CDD0D40547593AA763B553B138EAD853E5F56C2AA9A058C1F77A5023F17916A
              A76A67C231036EB7C592AA596C7B73ADCC9D3D05C3307E2322D73A553F1D792F
              E6FCC75BF11F6F251A4B5CD059968BE7562F61C2F8ABC434CD1F3BA232037919
              983D6FA57DDB946A6E9B52CD97BF3A5FB7BD9B78A7B72C17CF2CAFB444784444
              32DE880AA5A0C51CB0B5BB2778A26AE99A6830184AC8B9FB8EAF5052EC5572FF
              4F9D1785CC816A559DAAAAD7DB316DABABDF93101411264D9C60033715A4300B
              054F6255EDB6D5FE53B3FF544AECEAAB467B8051859E23138E5C856C5BC3D198
              ADC9ED5E8FDB04BC83F571B95CA8DAFD2B37AF88A8650DFDB6E48801B7DBFAC6
              98CB47A62CE8CE75062240A7A291E4ABD525A53E2291985744BCC0185F91276C
              182925B252C89D78AA889403335C2EB3FCEE3B6E494938D5DA1E01CE624B3014
              0A27C48A8A3C8C1A59166C6DEB586E188CBBE9C6B1E9FF606720AF11B02CD302
              D6009B80B9CB96CE35478D4C7EBC0A1F7ED4ACC0C1482C7AB6B32B90129F37E7
              9B3EE0A7B6CDF71656DEE7CB474B5E23B0B0729AE7DF1D5DF87C1E264DBC9EAF
              DD7E634A4E6B5B07A75ADA7DC0BE40A0F75F274E9E8E90F8049C654BE77249A9
              8FD1978EE03BF74DCE474A7E06BE5F352B6BCE6B6F6EA7C8EB6DEAEE09748888
              FFA303FE1049062CCB35506BF7DE834CBC653C439D0717E5C156675780E7D6D7
              467A02C1DFF535ED6DDAFFB1953C91FBD97FA09919DF7D9A48243AE473396E20
              1289F2D80FD6D8C1DED01960635FF3C168CC0EBDFB7EE3A07DD6AEAB8D0EB6D9
              980B8E1AD8DB7098690FD6E87B3B1A0987A355AA1A0450555BD57E65F5DA3F84
              9347614FC321DEAEDB690E5A3007B2CE81BF6E6F90CEAE9EB4714539DD7E8E43
              878FD17CAC051189A8EA2255DD129F1789C4D6EC3FD0BCF091C5BFD2954F56CA
              655FFC027FDBFE01CB9E7E3EE67299F59148746ACDB32F621A17BED30387FCD9
              1DF40DDDC3246EA055F5B53F4B8E9B6E2212E0FCB39D09F15BB749DBB88B003B
              BE9F61187E604CBABAA669FEB6AFEF3549B10DF19B7CE97819783F4B4E186855
              D566550D654A54D51745A419781C180DECB26DFB97C06960EA607D62B1D8A799
              6A6634A0AA9F90B8B15630AA5A07D40D124A7DC09A03FD0692B7F09F1191C5F9
              14BC8878923E9FD7FC59DFE8FEFF78D520E9658F93C34060BAA31B5847DCCB1E
              F2597FDDE63F5D99B4F48952795A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'EvFr'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000038049
              4441546881ED9A4D68545714C77FE7E91BA9A6B5AE844A2B54215202A5350B15
              0B0DD8E2C66E4A57D9B952E826A0C54A1B028DA555216661152C963650452D62
              898B884644AA22946C6C29564CF1339A8E4EBE3A3326738F8BCCE824F3E6BD3B
              EF4DF2C6923FDCC59CF3CEC7FFDD77EF3DF7CE1555653A44E465607E89225EE4
              5475B844AAAAE449CC033E079280D6681B027601EEB3BC8B08ECAF81046DDB91
              29048006C0D4406295B4F754F5D977BE06109EE346BEBB6A0975407DD1EFB5C0
              C5028157A73DDCA2AADDB392962544641DF05B91683158CE3422D2022442C63E
              A5AA7F85B40D841D01C769576316868CD10FC44BC071C4D9B8F913DE58F56645
              CE0F7FD939914D674225660BEBC5EA9DA635ACDEB0B622E75DEDDFE5669A8033
              A3DE67017304E2C60B4F2052C539F0CF5DBA761D28ABCF8CA5DD28FE6D1089C0
              686A844BBFF6FA3D52510F8B880B3401AF03BDAADA1F6453AD9A7F3D506EBEBC
              2922EF03E77DEC7F06DA44E4A8AABE0B20224F44A44E55C7FD02578B409FAAFE
              574E29325927AE787B55896EF0CE0023A9A12582D32BC2B20DCD1FE1265CBA0F
              1D4B30B5C0F4C4ACEDBA4444F79E395C92D0C1CFF6D0F3E3C98DF3138E7E7572
              BFD4373670FDF73FE83E74CCCA6FAD6C1BA579E716A96F6CA8D8B05A04BA4524
              E721BFACAAAD8149B8AEF9A07953A829BD5A049A3C9D2712BE03B080C60FD739
              0B5FA90B15381281E56FADE0E0D5139EBA5F3A7FE2C2899EC041B865F7F62829
              4423E0265C962E7FCD53B76871E56FF4C1AD7B8C3E1E269BC95ADBD4C420CE8C
              A5E9D8DAC6D59E8B0038F3EC87434DD4423FB4766A3EF97340971ABD6B6B1B7B
              0F0C27539C3D725A819DAAFA0D8088BC04B430797CE28BD8095CBBD407300EEC
              2BC854350D7C6D631F8940FFB5BF69FDF8534F5D369D45822B01FEBDF7007781
              7B233336116AEF1989406E22C7686A04208577773F0AF2319C4C618C0E84CDA1
              5A9FD032BF62CE0F6343A398F18964D8C0B1CF42F9B35913D63E760251314720
              6ECC11881B7304E286F542D677FE0AC9FB0FA7C8066FDB2FA08ACA99AE5325F2
              3BD7038F7E7C6145C01835A7BF3F1E29100A07B67DEBA9721C27B0EA2C072B02
              6ACC17F8FFC514B4F7BD09EC28A734C6FC69938717EC08A876840D90B7BF0578
              BFFE882810484D93778848DB4C048C80E99BEC21784EE00A93E570A1805F394B
              4945C165E07F72D5A0E8B2C70E60B006122CD71E03ED145DF69017FDBACD5322
              B413DAA316A7CA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'EvGreen'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000094D49
              4441546881BD9A798C55D51DC73FE7CE7BB3BC19989DA5894B212C75AA6C2A34
              2CA62809906A0562275DD08204A9D1D4C4566DB1ADD5A6565A975897B6A118AD
              4AB50631B575232C22A58C08056471A4AD560DF2066606E6CDC2CC704EFFB8EF
              DEF33BE7BDA1C3803DC95BCEFEFD2DE77B7EE79EAB8C317C56492915001863F4
              6736C7D9104029F539E0CBC074602C300AA8028AB34D4E002DC0FBC07BC05BC0
              0663CC7FCE787263CC803E400A58026C06346006F069006E02CA078C6300C04B
              811F02E90182CEF76901EE012A4E17CF69B990526A01F020704EDEFA40A54B07
              971D28AFA96AAA1A5A93292A29D22838D1D119B4A49B4B5B9B9A6BDB8F67461B
              6D86F731451AB80D78CAF41358BF04504A0D021E07BEE9D7058944E3D849755B
              AEB9E5BA43E3674EEED1404040E855011A4D10B6CCF6D0BCBB6547E2F9079EA8
              DDBF6DF7D4DE9EDEBA3C53BE042C36C6349FB1004AA9CF037F255C9C714A1616
              EEBAF286FA750BEF5C9611E258E05A1304B64CC722B8423D77FFCAE2350FFF61
              667757F725DED41F00738C3107062C8052EA42E035409ABCEDD239973DFDFD95
              3F4B2712892C180B3CFCF581F75D1FFD3EB8ECAE8A37D7BE712D864A31D75160
              AE31A6E1B405504A8D24A4BB6151592299DCBFFCE9FB5EBC68C6E49E20700144
              40F30BE4BB9414C4B6D8D7B03BB86BC177BFD2D3DD3D41406906A61B63F6F55B
              00A55405B01D1819959594A6B63DBC65F5EB35C36B74DF9A244F39688DE34ED6
              C572FB665A8E05DF99523F23D3DA769980F41130C918D3E4630DFC02A5940256
              39E0CB525B57EE5CFB7ACDF021DAD5A64D5A6B078CE3F5819D262B12A228DB36
              AC29AB2CD7AB76FD79536979D90631FC39C053D1CE7E4A0180EB807951265998
              DCF3D8DF9E5B972A2FD5D144DAE9AC73408675B2D6420DE229AD22C2B2F0A335
              248B93E6F1BFBFB039595CF88EE83C1B587A4A01945255C07DA2A8F5CED50FAC
              AD185AA325A820C785645EC75A26669B584CAC0DB4A8D1B11522450CAA2A37F7
              AC7DE42F4AA92302CFCF955243FA1400B81D881BCC9837EBA98BA65DAC43F708
              845B68745624D72A01AE46FD8924995A8D4BD5489B8D1A5767AEF8C6954F8A61
              2A811FC871E345AC94AA06FE0D0C02282C29DEF6DC071B5E01542E054A586E9D
              5C92F916AB652170C7CBCF50005F1F71F9CCAEF6AEE9D96C0730C21873D82A26
              4C8B23F000D7DCBA68BD463BE0A596F351A4ABC92CACC0856A97B85B22DDCD12
              445872ED9D376E143853C0F551465AE05DA00E20914CEEFAD3C71BD7E6A74B0B
              2820A2489F32E56EEB5B458E956B114BB96EFBAF9D77D9EC9EAEEEC9D9824663
              CC985844A5D4051178800BA74ED81A99DF6A44526760751DB8D689F2D2123ECB
              48212297894708445BD16EDC8C4BE46E3C5A2935CECE101E46E2547FC792B464
              043991CFE8164EA455DF3564FB88FF5D3A96A2DA315C0B2E5CBEAC9930F48ED2
              4C39CBB478A020F870CC843A63BB061E5409DF6526E2B2B085B560BEF5E347AD
              725CD93654DEB96347102412EF0B08D3A40071A4595639B8D135A1BB61C5CC92
              5367815BF7B240A4857285C61B2F103B7B56300DE5D5150785006365BF515169
              D5B0DA23AE0973372CEBA7EE020F90E5F6BF0D155CCDBB7B894C728E280FD5C3
              6BE5F960A4524A054AA922C263220095C3AADB2350D104B91B96BF79916D6B81
              4AD082631CC1A33516D76B5770DFF52A87D57608018A805420C103A4522527A3
              FF961EB5D09DF5636B21BBE07D3792A0F251A9DC0FA205EE1E7F2C86D4E0542F
              6E1A94C3B8D2975D067719C202937501EE2E1BB87B44F6DB5A4B526C3ED0D991
              A270238C9473D49091051D99F6848C65ACD348F342BE034DAE60AEDBC5F00257
              7037B09396946B4E9369694B78F8DB02634CB714A225DD9492DA8F8471430077
              27959A744307D9D75D4BBE167DCB4B154473B51C6E2A11DDBA808EA85DCCAFCD
              878ED4E6BA919DCA1F38770392E5BEC096A9E296DAF677CF0AAE70A0397AA8A9
              5A8039688C3151CBFD5169A6B56DB41F0A58B7F079DB5F4281A3792B72D65A82
              A92201FD8350945C01C3FCB1A3ADA344930312C1E6B8A3D6E7EE6BD8ED8CEA1E
              FFE4C0AE1B4503FABC1E5BCBE17649AE62C7D6B2D6861E1FEC690CF4491D1F73
              8137E528EBE584CFFFF2F743DDC92DAC38260A7C33BB2D24DBB88E278596568A
              D690CB48D1EF33F7FEB61A902CB43EAE35C634023BA39ABD5BFF3135022429CD
              A5B7BE8058B1720FF332DCB063B8BBB5CB4951DAB379C71491DD6B8CD92B9507
              101FDD7A7B7AEBFEB8625589D4B1EB325157ED118A0CE05C57B2FA946E8457EF
              AE9B48C8358F3E5BD8D3DD3D311F5679A029277C9C5701902C2ADCB1FA5FEB5E
              568902E3324D5FBFFD6D239492B5B03CD4E4793066EACFBF7C6E7767D7A5D98E
              6DC0F9D173D35815C69863C0C351BEE744F7C4154B7E54EBB091F3EDEF075297
              3ED87C7193EFE52E3B45233C78E3DD95023CC0A3F2A1AF6FCB5F019F44998657
              362D7CFB8DB70A231F951B92EFC32EEF87EDFA8A836478E12F58F994627FC3AE
              82CD6B5E5F28BAA6811512B0238031A60DB8551495AD58B47CFED14FD2053266
              910BD78F8924D4208874994BB7F1A2D6324F4C9BAD4DCDC14F16DCFC55634C95
              C0739B31A64562EEEBD9E8D388BB80E254C9F6DF6D5FF3EAA0EAC127ADDCB93E
              2EF9C85D1778F97CFF63B13991E9548BC75F35B3A32D334D54BC082CF02F3EF2
              6F83B00C889F067775745EBC74D2BC39873FFCB440904CCE8625B5EFEE1FC2AD
              9C35E3B90FD0D274A460F184AB6679E0FF4978E191A3EDBC02186332C01CE0E3
              5888CEAE49374DADAF6F7875539104EC2C6C2DD784BF7FC809654C6495B0FBCD
              B70B964E9C7F75C7F1CC97049C34E145476B3EACFFEB82E30B84171CF24EAC7D
              E215539EBDE3895F1C4A161689CEF9E8D273318D3827DB76277B4FAAFB6FF871
              F5D697372E04067BE0671B6376D247EACF15D33984574C5F94E589C2E4DEB98B
              E6BFB6E8EE5B8E83565E10115B20775DB8574CCFDCFB9B92971E5B3DCBBBD400
              3848A8F9839C22F5F792AF147804F8B65F1714141C1C3DFE82B7AEBEF95B8726
              CF99D69D2DF568D78DA376ACDB965CF3EB2787BEF7CEDEA9BD3DBD63FD318117
              8025D9BDE9D4D84EF39AF56AE021E0BC3EEA8F940C2A7DAFA2A6325D39B4BAAD
              A8347532003ADB3B0A5AD347CB5A9B5A6A3BDADAC7186386E4EB0F7C0A7CCF18
              F34CBF410DF086FE76E03067F7A2FBA70CE0C6FE4C5F35B89E302ED70304BE8D
              337CD5E06CBDEC311CFBB2C7186034E165442ADBA413FBB24723F6658F8FCE78
              EEB321409F83FF1F5EB7F92F1326F687B941CB6B0000000049454E44AE426082}
          end>
      end
      item
        Name = 'EvMe'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000087449
              4441546881DD9A7B8C5C7515C73FE777EF9D9D9D999D7DBF9F2D2DD89647D3D6
              28A53C6A42D3A4148922C4041388A62151D2A8843F0C7FA04202C61809148D84
              04824044838088103451D4168B221428B4A58F6DF7FD9EEDEEECCEE3DEE31F3B
              333B3B3B33ED0E0BAE9EE497DC737EAFEFF79EDFF93DEEEF8AAA922B22520998
              4519FF5D49A8EAD422ABAA9222E1077E024C01BA42D31070072019DC29F002BC
              BC02009E6FBA2F97C0EE15006A29290174A82A3673F27916CAFBC02C2B4B6A80
              55A9671BF82C703A4DA02AA7F04DAA7AF8D342763E2222B7004F6699AA808C07
              0A55FA3BD054205B8175AA9AC82AFF3C704956191FD0987A9E56D5EA25E23EA7
              1425501E0AAC37C654E6CB9B998EAAE77AADC0A94CF960E01A6399705A17055B
              914432896D59B95E5E16294AC0B22CEFC9A3AF4ABEBCFB6EB973FC9FAFEDEF20
              4540449C704D953CF1C1CB99F281A9041B0F8DF1A7B7DEE28E871F4AE46BE7E3
              4AC98B55F3EA763FD091656AAD6AA85D0052242FF76595920934AD6A2DF7F9FD
              6BB24CED0DED8D9F3CE21C299940435BB39457043E93656A6BEA6A2B5B064C4B
              929209D4B536224656A775DB677735763607B2CBE8A7E08FD23DD0DE4C32166F
              4BEB818AF04575AD4D2B7B08DD76F12E26C72600085404713D0DA5F32CCBACAA
              6DAE07E097F7FDDCFBEDBEA7943C3BDD422222254DB34B22A04A6262783CA387
              C2A1A488D401789EDB56D732B766F59F3C13B11D0BCE310B898823223F33C6C4
              8071634C52445E1791F35EF09644C058961B191ECBE8F56D4D1EA9A934114FD4
              54D5CFF53BDA3FACB6ED14452F22B6257200B8BDBEAACA77F9860DB4D4D65AC0
              959631C745E4BC2684A20BD9A24E21399145A065759B73F88DB73B45E4BD704D
              951133F73EC687468DB1ADA26D19780491CD0FECD9C3D776ECC04AD5FDDDFEFD
              7CEBC107ABBD44E259E08BE7C2B4D4204E4E0C8F660676F3AAF6A031A61368C9
              5EC4264727CA2CBBF01012913518F38D87F6EEE5D69D3B33E001766FDDCA437B
              F76244AE17910B97958058968EF40ECDA4F5868E662B5855B10E686FEC98DBF3
              B98924B3D3337E630CF98EAB003EC7B97BC7962DF2E5ABAECA9B7FFDD6AD5C71
              E9251863EE595602B66574B8672096D6EBDB9AB01D7B2DD0D6D8D9EA07181B1A
              0510CBB6F33A40448C65CC4DDFBDF9E605F6B1C9C905FA9EEB76132C2FBF6159
              0918DBD281537D5E5AAF6B6DC475DD0EDBE7EB6AEA6A09008CF40CCC95B50C05
              26D1CBABC315FE4B5767D6401E7FE515D6DF7A2B3F7EF65719DB351B37E2BA6E
              B988542C1B01CBB674B46FC849EB358DB5246389DA5065E8A2DA96B97DD048DF
              100062847C11608CB9FA4BDBAECC64A92AF73FF334AAAA0FFEFA37245C1700C7
              B258DBDEA6C08E92090818BFE7E25797A09BC0712C7B3A7236581E8F11721354
              A88BAFCC678BEA96AEA61A2ADD38674FF77AC69858C04B105065B232805B5F85
              8A28406545C5B6F6CE4E77A23248241CE0EDA90809D7F380B58160E0ECC1E141
              22E120917090F5EBD629B0B318C6A2D3A851ADDC141DC9E80108DBB69186EE8F
              686DAE03A0B5A13A78F4D8E90DDBAA7D34CC8C33FDD1091111D31E8FD2EE45F9
              77E7268E9F89E059B60024C5DA14DCF515EB70E7DC46F61FC7FA51CB8A039A14
              193E14A8AF90AECB0028BB64B3B17EFF7223456469B39080EDD8F19EDEE18CAD
              A3AD1ED775A9AB9D3BB89DECEEC7B6CD74AAC6A236926EA2AAA9B32BA34F4D8C
              333D39E9078E4F4D4456C766E7BF250482617CE5E575C5302D692103504F277A
              7A871B3FB7651D004D8DB5F8FD65183307B6A76F049FCF9E00AAF2C58020C6B2
              E6BBB51D1F175C7C59462FF3FB33CFE5A1108ECFC97BA42D9940343A7BBABB67
              28E3D6E6A65AA9080594D4EB8E44A6B06C5F0440F3CC4392734CBBFA861BB9FA
              861BF3F655E62FC71827580C4F29DBE9EEE327FB32C8AAC2416AAAE766BA9999
              18920A56583C8044C46F3B0E4B94A27BAA52087C78E2545F460957046868A816
              480F1F2756B02678EA79CB7A6658F21002DEE9CD0AE250284073630D007DFD23
              201229545155E3A1CA8543FA6F2F3DCFF38F3E92B77CF4EC645E7BB694426060
              3A3A8BAA22225CBB7D33D76EDF0C406FFF08D199D96EC776FC852A7BAEA7E9BA
              00E5C120C7DF7BA76067C671A2C5C09474A4741CDB1D1D5BFC76BA7B06993E1B
              3D92D6254F10DB8E33131999F760CBAA0B48C5C5EDC017526907F01E70C04B24
              8AEE874A2260DB76347B2D48CBC953FD0A1C99B72C1EEE6259037DA74E64F4A6
              8E2E5ABA56638C7918B807F8BE88BC085C6C59D6B8AA1E59D4C8C725E07AEEE0
              99DEA145F6EED38300EFCE5B167B60767AEACDF7DF3C90D1C518BE79FF4F0984
              C336701570A5CFEFF7A7D68673067C490426235347F211E8EB1F0138386F59DC
              7F7C76F6A9037F786901B30B376E62DF6BFBB96BDF637CEF174FF2D8FE77D8B6
              EBFAF3C2524A10934CBA1F1C3BDEB72B1761742686AA0E56D7A43F30E4DD50FF
              E5CCD123DAF3D131695BB336630CD7D472F9CEEB968CA5D4EF4287B2D70280B1
              F1491CC7F61618F3E057D569B1ACD79F78E0072576BD504A25703037887BFB47
              B06D6BC19457E8AB4A2236BBF75F7FFE232F3DFE68C10E9289F3FB985D7408A9
              2AF7FE68FE52647070CCA4EC4783C172C9CE3BDD3308E8685A7FEEC5BFF2D6BB
              273971F619460707F05CD7CA6AF79058D6338FFDF0EEAF9E78FF5D76DFB687B6
              3517A29EC7A90F0FF3FA8BCFF1EAD38FE3E12DF4682190C03E165EA2AD57551C
              DB76597CC1B64D55292BF3C573F39C32E73555C5E7F71D5C94E7F369FA6631D5
              A705ECCFD3BE022A2251607B56F95B72CA7C3DFB922FAF2492C97B81DC33E951
              80582C7E170BEF0748C4122F00C467E3F703DB98F3B00F8826E2F105D396AABA
              227205F06DE03B407ADF3F06BCA0AA77AAEA74317CE986A0800756523A970726
              72783D2B222BF19A355B26603E88DFC8C9DCF089C3F9789224BD60FE5FFC6A90
              F3B3C7E40A0058280D90F3B387FCAFFF6EF31F3D366D8A1815163C0000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'EvMulti'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A00000A1E49
              4441546881BD9A7B9056651DC73FBFF32EB0BBEC8DDD05161604596841C1588C
              20A310CDCC6472B269C24A456772ACBC9B5AC6E83879A371D470C48A8609C9B2
              3F2823D3D1D234C33B812BC5C22E2E202CB81716D8CBBBCBBEEFF9F5C739CF39
              CF39EF790D16EDCCBCEF39CFFDFB7B9EEFEFF23CE788AAF2715D222280A3AAD9
              8F6D8C8F420011A901CE011601B3804F009540A15F6510E8065A801DC026E0EF
              AABAFBA40757D561FD80226039F032E0023A8CDF66E03A60CCB0710C03783170
              2B707098A0937E4780FB80AA13C573421412918B808781A949E5B5532674347C
              E68CBD75F5757DB553266426A78A0A0B0EF50FA407FAD9FF4157EADFBB7617BF
              FECEB6C92D7B0FD4E419A213F821B0568F13D871092022A38147802BE265334E
              AB7BEFD2EF2F6B39F3F3F39DD231652314457000A5BA6370746577BA0F24D2A6
              2F9D1E7A796BE3D0EADFFD61EADBDB76CE4A18F219E07255ED3C69014464B2DF
              E16C3BBF61C19CA69BEEB9A1F594FAA9C59EB1010FA80282AA4B75FB5049D591
              74AF57A60482A80BE200B0A7ED40EFED8FFE6AE20BAFFDAB2136F43EE00255DD
              366C01446416F03C30C9E495968FEEFBC9A32B5E6958FCE9221107C50D663C14
              C013A6AA7DA0A4EA70BAD72B1250F5EE09D7E6A6A69ECB7E7CFF595DDD472AAD
              EC6E60A9AABE7AC20288C8143C73576BF26637D4EF5AF9F8CAD6928AD2112251
              D0863AB640D59DC74A2A0F99153097DFC61746557D9984743A7D6CF95D3F1DFF
              F29B5BCFB01A1C06CE56D57792703A79C09702CFD9E03FF785858DABFEF8C89E
              D231651678AB8DDF95D834725DC399107EB84066AC2051545434F2C9FBEF3874
              E957BEF886D57505F0ACEF6B8E4F00E09740BD492CB96051E33DBFBEFB5041C1
              885484E711602E36CF151751F14D6F489B9041369534904C105979FDD503975E
              74FE6B568509C013229283372743442E019699F49C3367B5DCF1D89D5DE088FA
              FECA00178BF3F1BE3D3A11EA777CEA4DDA081856C41161E535DF193C77E13C9B
              36E700D7E6E0B5754044CA80EDC04480A2E2C2DE0D6F3EB9A9A4A2BC30AAA451
              653503133C298250DD3E585A7978A0272C8FCDFA87A6617068E8D8826F7DF78C
              839D5DE3FDAC1E60A6AAB6993AF115F881010F70DF9ABB5E2AA9282FF4E82178
              2BE02BADAA956756C5E3B3A70FB19936D40A66DE12572DC5B6DA8C1A513072FD
              FDB7DBFA500AACB0010702884839D6127D72C19C77E72D9E5FE297F9106CCAD8
              791294A91D1689486C5243A658BE23E059BC4C61CEB469E5172E5E60EBC39522
              1218177B052EC7D378006EBDF7C6DD8A4ADC549A59CEA5932D880FC0B550A91B
              008EA623E259CFA1CF5879C3D59D846B360AB82A9F0000CC98356DC7E4FA534B
              252856EC590E67DA581F2BDF5F7EB5EA7860626C15AB6FD3464D6CE70963FAAA
              2E2B2F3B7761C3DB56EBCBFCBD86875044EA807941E97597EC0244AD5933FCD7
              4018DFEEFB3E21C8F7D3E23D07DC088D85926C8134F409C6A45A94FADEB28B0F
              58024C05E60702004BECC999BF6461CAEB309C25E35D43522739B2D80CBA214D
              22F1529CF3F14424B6F2C65A707A7DB12362F3EE1C5B804526B766D2F883C525
              A30B43905187652E0DCA6C0A61D5D7988D8B5A980840439D0885B0CA84945330
              A2E1B419CD56C9225B80992677FE5973DF370A99E4B04CA4695622123AF8C00D
              BD54ADC82D686EF7E5F3DE50C70A2B022537D64E60D1A7E67E60093013A0C04F
              4C37B9D3674FEF057592801B2436B5C2B21078A0F496778D46A1765FB615B3AB
              C45D9430FBD4498356C6141129707C6D1E6372C74D189B350DC23826EEB0D47A
              B61D94F979F51DB557CDA2478E3393087DA21172A8F4E3ABAAED8202A0AC006F
              731E88ABFDFD87CBB399340029D0EC90896BBC4971FDDA026441F1CA714C3A8B
              9002077464AAAFB3B22AE5D92C17D71570045CA31F02644849015905C7CDAA20
              2EA2A01292D8DF4B0C9495C59D4769412C83DEBD6D876B8EF5ECC77120132F0D
              2FD775719C7CC1AC7775178FE9E9D4EAD323B3491ECA5897B74790486C0B425F
              C5B863F1BA0E90068283A7A3BDFD2922C05C8338DA3007BC1B089600C9BF1BBA
              C5753B66928D5F0804F2EE8303FDF18E7B1C7FF7DF6D720EB6779544EB380671
              046888DB8DD473A2F5C4066CC0DAFA2CD6BF2699D840D1A1B3A3CB9EB50C70D4
              6404F6B5B5B56D6C1458FC8A0992974696138CF82D238C51D8F0D4D100B57C36
              36D55A9B5B0A09AF5655CD98519A4C6EF37B6D33E3C092699107B855D745241E
              A099590EFC88A472BA3062C4C5D9F2C6E6F156B5261BC52B26F7E8D1BE9A9D2D
              EF477A751274222A946B578EA4E3019A4892F24636A7B16DA8A7CC994C561B37
              6F996635FA872DC08B7677EB9F7C7E62988A038D73DDEEC68DA50902B47830A2
              11F5B5B70DB9420AB07DEB966399A1217BD017839154750FF0BA2979EAE94D9F
              F5A810028E034B1630D77B864F71664BAC46CC79F977A3D71BD6FDD63E956806
              B6C4475C671EDA3BBAEB373CBD69B45D9C8F3271F5B0EB398E4A68588CA54980
              1B6C4F4DDADEADC1A18E8ECC4BCFFDD53E2B7ADC9C9DDA02FC06EF7015807B1F
              587F7E26A362C0265326D71FD869552787F2E1563414236AA542AB6548B6E6C1
              87ABAC89E9C73BF6892251D55EE02193DEB7BF63CE838FFEBE262A631EC54D4C
              4757476314899AC83C811EB06B674BF6D90D1BE75A157EA1AAED3902F8D7C3C0
              6E9358F5D886CBB6BEBB6B5488E6C3F4C1C9456D559118C8D8EED7BBC72CD640
              3ACD9DD7DCD0E0BA81AF3884F71E211985AAF603379AF4D050A6F08AABEFFB7A
              F7E19E82C4F082041F61D5732C7836B860D7ACDE3DA44E68B15C372B0FACB8AB
              66EF7BAD41A40CFC48553BF20AE00FF414B0D6A4DB0E76D55DB46CC585E9BE81
              5452B3241F61AEACAB8123B3CF4083AD9084A9088D342B6B7FB6BAE2F93F6DAC
              0F33F90BB0268E375F1C702DD068123B9AF7CE3DEFE25B967677F7A4F23AB078
              77AE4BCA3132C77660F13CABCC7533B276D56395EB57FFDCB63A7B80E5496F6D
              1205F0A9F465BF2100CD2DFBE62E597AD337FFD3B46754B4791E3A398EB5A90F
              4DA4C436ECAAD960EED303837AF7CDB74F5CF7C8EAD916D62EBC171D896F6BF2
              06F4AABA1F380F4BA90F1CEC9C76C1D76EBB7EE5834FD466325989771137A96E
              CE5974EEE18089859AB66DD32B977E75DEDFFEFCF474ABD880DF9E0FE7F1BC62
              9A88C73FDB94513BB17AFB2DD75FF2DC372E3EFB8813C43F7648E1D025E36A3B
              DD8A19664B19469BDEF18C0207F7B565D73CF4D08417363E332B8665B70FBE89
              0FB98EF7255F119E89BD2A5E366E6C45EBD22F9DF5CAB7979DB7FFF49953AD1D
              934B3BE327756BA53FA36180D6DFDFA78D6F6DD60D8F3F31F9AD7FBE3ADDCDE6
              BCC8DF085CA1AA87FE27B6137CCD7A21B00A9896545E563ABA6B7A5DED8EA9A7
              D47C505B53D93B764A7D71C5E4BACAFEDE7E3A3B3B47EE6E6E296EDCDC38B965
              C78EEA04D000EDC06DC0BAE37DCD3ADC37F4370307088F214EF67704B88761BC
              B13F610162822C075E62F89F1ABCCD497E6AF0517EECB104EFB86F26E1C71EC5
              7E9501BC7D7733B093F0638F3DB9BD9DE0D81F8500793BFF3F7C6EF35FBEAD02
              A68C3F38F50000000049454E44AE426082}
          end>
      end
      item
        Name = 'EvPurple'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000095449
              4441546881B59A7B8C55C51DC73F337BEFBE7177D995476945101068C3AB9497
              60BB48B0682D50682CAD6E10435B3098B68942AC7D242DA0498DA03158430A85
              60AC60F191521F95766169951553C0220F914215581676977DB3BB9CE91FF7CC
              39BF33F75C840527D9EC39BF9933BFEFF7F79A3967AE32C6F07935A594069431
              E6E2E7A6E35A10504AF505CA8129C0506008D013C8F5875C00EA818F80434015
              F07763CCF1AB566E8CE9D61F900F2C0076001E60BAF1570D2C018ABB8DA31BC0
              0B8065404D3741C7FD3500CB819E578AE78A424829351B5805DC90A1FF4C6141
              D1C19E4565B5653D7B37E724F33CB4A2ED42ABAEAB3F5350D7507B7D734BE310
              63BCBE1954D4024B81F5E632815D1601A55421F00C50E1F62574E2C897877CB5
              EADE390F9E9A38765A271E689D8A290D78FE85F6C77BC09EFD55C90D9B5797ED
              FDF05F933ABB3ABF12A3F235E03E63CCB9AB26A094EA0F6C03864B793299BDEF
              EE6F2DFCDBA28A5F36599946024F31B1320411496ADD9655391B36AF2A6FEF68
              1BEFA83E01CC30C61CE83601A5D470E04DA09F10374F193763E38A87D69E4924
              1278AEC51D32691E89230BFC76F592A2D7FFB1B9C2607A0A5D75C09DC69877AE
              9880526A00A972F7052B4B2692071F5BB66EEB84D1B77568ADA3A02CD018C051
              CF84FD41F33BF77FB83BEBC15FCDBDA3A3F3C218D15B0FDC6A8CF9E0B20928A5
              8A4895B8C15696979BFFEEF34FEF78B357D997BC4C9624469E1246C3C9869834
              827DB6A9B95E7F77D184C94DCD0DE502D2A7C01863CC1917AB76057E5B1B019F
              57B0FBE5B5EFBFD54780D712AD0F2802C60BAFB5166A3CFF3121F3BC70AA1E85
              25DE6B7FD8BBF3BAC2E2B7059E7EC0467F65BF3401A5D4BDC05C7B9F4C641F78
              E1A95D6F1416945C0C14093307973A3A95765D6289EB50B125ACFD84D63E9B64
              32D7BCB4A6BA2A373BF73D31E57460F12509F8A1F3B81035AD5CBAEEE55E657D
              234693316C15DB7B4BD0B3D78248649C178EF708BD600D5158781DCF3DB66D9B
              52AA46E059EE6F5BE209000F03C180A993EE5A7FCBD8699D9EE7850918800C65
              411213B5A86B2A1962C1187F9EA0C48A476EEA3FCCCCBABD62A3105D073C22A7
              0D925829550C1CF707919DCCADAE7CF1F85F00E59640C93EAD4FA08C4B565B85
              203A5FA60AA581A9F3067EA3ADBDE5EBBEA81D18688C3965FB6DBBCF8207A898
              BBE46DCF73C04B2B3BE0831876ADEFA2D561C8480032DC6C81B073FF6CE1CA4A
              527B2648ED7017DAE9A507F60223001289E4FECACD9FFC397661B24D98D45A38
              25F7EFDDFA2858C5AD0B01092910E3CBEFBE717A7B47DB445F7414186C8C31DA
              077FB3050F306AD8F87F06DB01A94858264C681DF58EBD179E70AB4C8484EB11
              7FBD70BD306E7479B5E0741330C6CE03A99791A02D98F7708DAC085211D25AD2
              4A1688B09A6C6155D2E1B513EC5A8C732BD8A27B7E5E4F18460053E590C9C13C
              4AFF6FE4B0F126001E87D697A55526313E65552F24EBE48F241DD12172437AE9
              862F0E2291481C1208264B0243ADB4478FE2C3D28576B6482E4496D92808B958
              21C2417AC8251D3227F484BFB28706F3282E2AFB484886CAC70659695949EF5A
              E9C2B805CBC6A99BE036D63D677CB04885BCD2D6920856A1C3DEA335BD4BFBD5
              8961039452595A2995051459696971AFD68099AFC05DB0640C07B1EE5BCC73C6
              EB60B2987093FB0AFC354312173A34707D699F36412009146A52EFB841CBCBCF
              EFB2D75A269CAD24B2A288B0D0A216CA3092A0E24A69643DB0FABC746F794061
              7E5117D1D6C32D16012A69CD88C240B197D627CB6B782FD7883074422F449F97
              A08316E8527168694694A796D6A684DCCB049B2EE14A04B02024BC74629ED317
              7A51478DE285E3C3908CE69C073436D7251DFC4DDA18E301E7ADA4BEBEA6405A
              3F2023161C69B170010AC34002B0CFA6E59263C648F9B5EC844C03E7EA4FE78A
              A73A80663BEC88959EADAB294B9B2CD49336B1BB002100B88465A50A077B912A
              265548721E50537BB254F47C6C8CB968C71EB4D2C696C6A112584A47A8C49DD8
              11452D8FBB5879110B4792DF6D82A0BD6F387F6EB018715092DD69A5C678FDF6
              ECADCA8A22134AC4C46E1859166E5D0F2B5358DB237922724096255BFF3DE0D8
              A7875497D72509EC90F36C97FAD66D79A28F542E1355C759CEA9F381724B5254
              26495A7AC97ACD7DD1B7FF9FDDB0BC946819DA1EF41B638E02C1FBE7FE83D5B7
              E091F68221AF3301919CDC9779995B720B62BD20AB16F23FB07B5FE53801FEA0
              3166AF2408B0DE5E7475750EFBFDF3CB0B6CAF8C5F19E79EA3C596D1E03EAD02
              8824769B8E1A4292FCD3ABCF667774B47F4D8CDE602FE40B4D0FE0BFA4BEEB93
              4C66EFDBFEC2B1AD9A44A41264FACF25FAD20A00C27B3AFC8F9405633C6EFBC1
              C0E9EDEDC1CB4C0B30C018532BEC02C6982660B5BDEFECEC18B16CE5FC3E916A
              236AB8BB1ED88E38B041FE201E96DA6DC915D77692154FFFA44880075863C147
              08F8ED49E0137BB3EBBDB7EED9F9CEB69CA0528864736358D6FD8048A67D90D8
              5EA425ACF84AF1C1E16ABDADF2C50A81EF1CD1CF3E5102BE177E2A44058F3EF1
              C339A74E9F48C83D8B4C5C774F1429EBFEBB716CB9F542C00113FB0C70BEF19C
              5EFCE877661A13F9D8BBD418735662CEF46DF48F88B3809C9CFCF75F5A53FDD7
              9292B22E0B3436C68597645EE0DCC75D23646D175AD5B7EF1F59DEDCD2384574
              BD02CC760F3E322C832C0682AFC1172EB48E99F3E3B1779CAC399645A62A8363
              7D2FEAB100B0534EA3E10375F5B55933178C9CEA803F062C883BB58925608C69
              0166903A644891E8681BFDBD07A6CCABDCFD7A4E047024B1A3FB1AB97E488DB6
              DF0DAB3DFFD99135EB47636636B5364E164F9C05BE698C916F6341FBAC038E21
              A40E38FA0B71EB84515337AD7864DDA9BC646EF0705CB94C0FB1548D8C0B9D5F
              FC6E61E9F65DAF56203EAE913A339B618CD99311E3651C31F52375C43442CA93
              89E481D9B7CF7F63C9FC5F37EA4422D866089CB1791158DD973DB7E9F1BC4DAF
              3C33CD39D400F8D8077FF892F82EF3902F1F780AB8DFEDCBD25947870F1A55F5
              FD590F9CBC75E29D1DC48074F751EFFE7B7B72E396D5BDF71FDA33A9ABAB7358
              8CCAADA462BEE133B15DE131EB5D3E911B33F49F2DC8EB71A8A4B8EC4C6949EF
              A6DC9CBC8B5A6BD3DAD692A86FA82D38D770A6574B6BD3CDC6985E1954D490FA
              42BEF1728F59BB7B42FF10709A6B7BD0FD1BBA71627F2D7E6A50492A32AEE6A7
              0645DDC571AD7EECD187E88F3D0693DA14E6FB43DA7C2B1F010E13FED8E344FA
              6C57A8FB5A10C838B952CAD7E156CD6BD6FE0FBD12F9A068728D320000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'EvRed'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000080B49
              4441546881BD9A6B6C54C715C77F73BD6BEF7ABDD86B1B5C509590101CB7C535
              6A1C855297B616AD4250E55A2D05EA241521482695F892144145A2A8544A9386
              923634A4284D4B5AD2848702128D4848696B02180C29C4A886381169FAC00FEC
              3578FDC08F3BFDB07BD7B37767EEFA013DD26AEF9C39E7CCFFCC3DE7DCB93357
              4829B9592484B000A494F64D1BE34638208498055403554019500A44804042E4
              3A10055A818BC0BBC05FA4949F4C797029E5A47E4008783801C606E4247E2781
              1F00D3268D6312C0F3801F011D9304ADFB45811F030513C533A11012422C037E
              0E7C5AD76F09D13E2D14FAA0383FBFA3A4B03016CCC9191520FAAF5FB73AA2D1
              BCCE9E9EE9D7FAFA4A6D293F6518A21D580FFC5E8E13D8B81C104284811781EF
              B9FBFC3EDFC5CAD2D263EB962D6BAB9E3F7F18DB06CB1A1370B781A3EFBFEF7B
              6EEFDE19275B5A160E8F8C7C4E33E47EE021296574CA0E08216E030E114FCC24
              E5F8FD67D7D6D4BCB3B1AEAE4FA767DB3696C911E5FAD9D75ECB79FE8D37160F
              0E0D55BA4C5C029648292F4EDA0121C4E713E0672AEC6B4B172CF8C38E471FED
              F4F97CDA197679E2DD9FA0FAAD5B23FB1B1A1E9450A0B0AF249C383D61078410
              7710AF30250E2FDBE7FBC7CE4D9B0E7CB5BC7CC8728372804EC6A104EF787373
              D6F2CD9BBF39343C5CA1F476015F9652B68CDB01214404380DDCEEF0F282C113
              C75F78E19D928282093F94D2C2C9C00388C662D63D6BD72EBA1A8B7D45617F02
              DC25A5BCE2964FB3208410C06F55F0E160F0C4D9975F4E076FDBCAA5CB2FA59D
              960B061E40242FCF3EFBD24B7FCB0F85FEAA58BB05D899C0E6ED00B00AA8711A
              D97E7F73E3F6ED87C381809D1CC8F95740A4CDA69AB03ABE8167DB36B93939B2
              71FBF6861CBFFF3D45EA3E608DA703428842E0A70AABE78F8F3F7EA0383F5FA6
              0C94292955D026470C6D67220AC3617960F3E68342882E45EA2921C474A303C0
              462029F0ED458B765695978FDAEE994709194D5FA65956DBB6E66E3A543177AE
              5C515DFD3B8555086C506592492C8428265E7BF30082D9D98D1FBFFEFA21202D
              EE3CC955653C9F0719741D9ABD72E5E281C1C12F259A7DC06D52CA4E48BD03AB
              1DF000EB57AC38826DA78277DF761DB90058EE103285945B57E9DF74FFFD4714
              A950026B5C45E9F8BE7391EDF7FFFD91DADA61D36D570770571F5DB86967D6E0
              882EA41E5EBAD40EF8FD4D3AAC168010621EF0198759356F5E631A38430572CF
              B0A54B7457487939622AAF5515152715AD32214479D201E06BAACD0D75759D69
              C63255A0712C17BC007A26BE6DB3B1AEAE8BF8D2DBA16A1873A0CAE16659D6A5
              8A3973521FCFBA78D5858AAB4F7B07750033D9B32CE6CD9E4D96657DA470AB54
              07CA1C6E4138DC9A6654B30CD0DE11537899E474CEB8CBAB3266617E7EABC22A
              531DB8C3E1CE2A2A1A5B6F18C242B786F192373D8DB5096F18C3B22C664522DD
              0A6B0E8025840800B90EB7241249AEEF3D93D875EDB51632551C77C2A7D970E9
              941415F52B3D412144D0225E5793140A0446D306504118C2C254EFED4C89AA5B
              F41974C2B9B9232EED709A45CB59D36720ED6C6940EAAA4E46A7743967200B88
              A98CABFDFDBEF15407ED0B8D6930AFE4D6D876F31CF99E58CCEF92EAB5A494D7
              89AF2F0068EFEACA4D1171878E29D60D0FB6145D13582F1D85D7118D0615AD01
              29E5806339599EDABABB8B8D03E90C67AA48199EBC1309A7B6AEAE22A5A715C6
              CAE805871B8DC5EE742B6AC3628225D304D65892DD0EDA36DDBDBDEACEC805D5
              81A3CA20B7365DB89062356322BA8165785931814DB1EB72F0DCA54B62D4B66F
              57B41A5407D4E52ACFEEDE3D430B4E79026B4BACA98466289F9EAFA6097A6AD7
              AEE92ED691A40352CA0BC039A7E77873F34237E089024903E3F13E9D664753F9
              8E9D3FFF4545BAD9D96651ADEC742E864646CAB7ECD91330C6AF7ACBD3FCF108
              2D1D7077BF46F6177BF7660F0D0FCFD761555F290B808F817C8080DF7FE69FBB
              771FF47C059C2A39B6D531D2C793B72E5FBE747068E8EE44FB1A30DBD9374D4A
              4A297B80E79DF6E0F0F05D0F3DFDF474630DCFB4CBA0039BBC748591473ED56F
              DD5AA88007D8A66EFABAA7F667C07F9DC69F1A1B1F3CDCD4949D34E8950F9ABA
              6FAAF1C66A44AA738D2D2D59FB1B1A1E50BADB1318C76CA90D29E535E0318595
              B7EA99676AFF7DE58A7E79E106A9036ABA6B9A3AAF3A77391ACD5AF6C413DF92
              F1A32A877E9888942499F6465F05563AED5020D07466C78EB722E1F0689AB04A
              37285F62030362FEEAD58B7B0706162AEC7D52CAEFA461353810064EA1BCA9E5
              0602A7DFDDB6EDD0CC4864D43227DC1899125397B88A4E5B34EAAB5AB7AEBAB7
              BF5F2D9B1F0277BB671FD273000029652F702FF01F87D73F3858794F7DFD77DF
              3E752A674CDB1A57CC7B954855FFCFE7CEF92AEBEB6B5DE03B889F11A48187CC
              071C9F05DE22F54CACEF1B9595BB7EB37E7D5BB6DF3FA1335AD396FAC8E8A858
              B3654BD19B274E3C004C53BADA817BA594678D18C771C4740BF02690729695ED
              F79F5FBD64C9DB4FAE5AD59B40E71D32A99E24793F79E595DC5F1F3CF875D783
              0AE2ABCD2552CA8FF0A0F11EF285805FA1EC88399465591F7EA1B4F4D8233535
              97EF5BB0E0BA0EA4BB7DF8CC99EC5FEEDB57F25E6BEBC291919132B74D600FB0
              464A793523B6091EB3D602CF113F70D0F5778683C18BC505059D2591482C9493
              338265D13730E0EBE8E90975F6F44CEFEDEFBF534A3943A70F5C061E9352BE3A
              6E50933CA1DFC08D3DE8EE069E04F26FFA49BDE65383A330E94F0D1A99E2A706
              37EA638F99C4F72A9D8F3DE6123F8C70DE610718FBD8E303C63EF6F8D794C7BE
              110E188DFF1F3EB7F91F52D15338AFA4285C0000000049454E44AE426082}
          end>
      end
      item
        Name = 'EvStarPurple'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000064F49
              4441546881DD5A6B6C145514FECEDC99D916B12D6DB1DA42DB6D4B6995873502
              21561305C1CA4BAD02557C52A55A7CA005431B03F20F23122289898F1FBE628C
              0F0C1A8D418D4AD4E003F101588AADB69642A55A2B6D77E6CECCF147B715B6BB
              DBDD6147AB5F7293CDBDE7F5CD997BEE9DBD979819A120A25400CAB0817F1792
              994F0CEB65660449F8006C06D003804769FB15C0030094A1B84F22F0FA280830
              D6B6E5140200E68E82A0E269368049CC0C1503988D537110401F4617C6012808
              FE5600CC02D03448203544780533EFFDA7228B05445409E0D593BAD2008F2B0D
              1169C18AE619BC2E95D500D678E9C033024494ACAADA2621D43A221AE7951F2F
              33509BE44B4E4D4BC9D400DCE795134F0810D1584DD51A6E5B5AA7AD5CF680AE
              7A9805AF325077C6989431575F713316CEAD427AEA7815C0BD5E384A380122CA
              14425D5BB3A25EF7E9495085865B96DEAFAB425D4B44E989F69770020A94F567
              659C23AEBC6CD9509F975948280122CA2641AB6B5634F854A10DF50F66215891
              129A858412108AD838E11C3FE6942F1936B6706E15323CC842C20810919FC1B7
              D6DEB4415768B859AFB290100244E413426C2EF64F71CA67CC8B28B7604E15D2
              52325524705D5047161900116503F063604758201451A8EBBE52C776F20164D8
              B64DB5376F886A435335542FAFD3373F51F790AEFB6A85509B4C33F09DE33887
              001C02D008A09999CDD325701111DDA2EBBEC90A2945A6342602D0144571D2D3
              C61B3959F9C8CD29F2E59C9DA76467E561B0A5A58CFC662C9C5385D2A2F3D1D6
              D19CDE76A479D6CFBF34CD686E6B94ED475B94BEFE5E8D889CE4A4338E92A234
              F5F79FD81724D584E0EE33560207744D5F25A53CEFF6AA759832F9426467E522
              2B334711424D8EE1C14484102A8A0BA6A2B860EA60978281CF5974F774A1F5C8
              8F4A6BFBE1ECB6232DD98DCDDF5CF4F9BE8F54223AC6CC9BC3D98B34077E37A5
              59AEAAEA176FBDFF92919B5388ECAC3C0811F31BE70A692919985632130BE75C
              8F1BAF598DDEBE138EAEFADA99B91C406B389D88939899BBA5342FEDFAEDE89E
              EAB51566FBD19FBC8A7B18BABA3BB1AA7E91D9D4F2FDCFA665CC62E6C39164A3
              562166EE35A431AFE7CFDFDFAF5E5761B6B436263EDA107474B6E18E07AF34DB
              3B5AF69BD298CDCCEDD1E4472CA3CC6C989671556F7FCF3B35F58BCCC33FED4F
              5CB42168696D44F5BAF9E6F1DF3A3F33A5790933778DA413D33AC0CCA6655995
              01B3EF959AF58BE4FE435F9D7EB42138D0F435EE58BF409EE8FBF30D69199787
              FD132B0C625EC898D99652DE64C8C0F3B50F5D6DEDFDEE13F7D186E0CB6F77E3
              AE86255620D0F78C94661533CB5875E35A8999D9B16DBBDAB2E4F6359B965B9F
              EFFB30EE6043B16BF70EDCF7F032C792F231CBB6EE6466271EFDB8B712CCCCB6
              6DAFB16CF9D6332F6F89F94985437FA00F1BB7DEC98E636FB4D97ED08D0DD77B
              2155D5CF2C299CA68D2C1919C949639032364D02885A69A2C1FD668EB9AC28FF
              3CD7EA8328C82B0500D7865C1120A2B3A465A64FF29F3E8162FF145DD37C656E
              F5DD66A04C51142EC82D71EB7708FE89250030C5ADBE5B02D373CECE3774CD17
              55A8BBA70BB66D459529C89D0C298DF1441476B739125C11108A282B2D3C5F8F
              34FE6B5707B63EDDE02C5E39DD5E7AD76C63D7EE1D702254C7FC89C5000800CE
              75138B2B02AAA6CF2C2E983A4CB7B3EB08B63CB5DEA95C35C3DEB9EB85039625
              977774B66ED9B46D75E086BB2F363EDEF30E428FB4C68E49C1B8D44C032E2772
              DC048828D93403F993FC7FBFB6C78EB763EBD3F5CEB5AB66DA6FBEF7E221CB96
              55861998C6CCAF3273836D5B13DBDA9BB7D53FB2D2BCE19E8BCD0F3EDD798ACD
              C2BC12724B60F0893C8A534F402E183CC2096D006602E0B79F3DC83B9EDCCBD7
              2D5869AB42B374DD7710C07500288AEE04A188C71545C8D2A2E9C6E39B5EE34F
              771CE3AAC535ECD3923E8AA417D4AD0C8971F5C9474CF110B83DC9976C2DBE7C
              852D84B07D7AF2D7002AA2390F63C32F14F11C11D9174C2D0F5456DCC69AAA1F
              FFA7086C07C0BA9EF42580F9F1041EC65689AAEAAF0170827E33E225E06612F7
              02986718FD1732F3BB2EF487C0CC3F486954022803F0265C54A2B83F7299D9D5
              A66B049BDF00584C4471C733AA4EE39939FAAA1706838CFF08E97F818846E331
              EBC9E806FE26F059C860A9E7E19C1E1C007B00FC4FAE1A0409E818B8ECD13D0A
              028CD43A1172D983FEEBD76DFE02DED138A12C0F589A0000000049454E44AE42
              6082}
          end>
      end
      item
        Name = 'EvStarSalmon'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000064C49
              4441546881DD5A6B6C544514FECEDCC7B6A8B5342D6B1FF6815BAB2D147C208A
              440C89C843044B01254A950201B1820A5510310AD1408C51131F3F04E3232410
              1388D1E02B1825A0D604D1AA696901A13CA5402DC5EEBD73678F3F2875D976DB
              DDCB5EAC7EC924373373E67CDF3D999973EF0C31332241442900B42E0DFF2E1C
              663EDDA59699D121C200B00A400B00EEA3E50480A500B44EDE6102D6F70182B1
              9637CE130060641F20154F090118CCCCD07116B7E07CD4036843DFC2E500021D
              CF04E06600B57A5863382A9979FBC562160B886802808FC3AA52014078EC5423
              A2FE5EFAF054008099009EF4D281670288C8344D7D95A689454494E1951F2F23
              30D7D0F48CCC8C3412024BBC72E28900224AF619FA8A8515E546F5EC19269178
              94880678E1CBAB082CF2F97CA995E5E3513E761472FC192404167BE128E10288
              E87243D79656CFB9CFB8B45F323421B0B872BA49A47912052F22B0242DE5325F
              C5E4319D1553EE1C851C7FBA275148A800224AD735EDF1A7E6DD6F9A86D159EF
              6514122A4008B13CCB9FAE4D1B777B97B6B0282474454A980022CA26C2FCE5F3
              1F3075ADEBA7445814AA121985840820229FA6891702B939B87BF488A8FDA6DC
              390AD967A3509D08BF003AB3D15E414499000A000C0450A06922E033CD6B4221
              554044E94A85E8990533414451C7D08440F5EC7BCD479E7FF5099F6956EABAD6
              605976AD0A85EA01ECEE288DCC6C5FA880614434CD679A454250A16DCB1C00A6
              20E2F4B4D4607E8E1F81DC1C5F7E965FE466F99197E5476E961FE9FD2393DAAE
              281B731BAEBD2A0F7B9B8EA4EE3D70785863D3C11BEAF634C97D078F88B6BFDA
              0D220AF54B4E3AA61135B4B50777E16C6ADF00202D1E0175A66154D8520E7DFC
              A1A9185E5A8CBC6C3FB2FD1964E85A720C2F262A342130A8B000830A0BCE5509
              003E0038D9D28ABD078F88C6FD8732F7361DCEACDDBD6FC4D6EF76EA44D4CCCC
              2BBB1B2FDA1C386D4B39D2D4F56DEB3FFAD2CECBF6233FFB0A18BAB7DFF969A9
              29B8715011EE9D301A0B2BCA614BC93ED33CCACC2301ECE9CE26EA2466E63396
              94639B5B5AB78D9B5D2D77EF6BF28C78245A5ADB30E9E1A7AD1F6AEB0E58B67D
              1333D747EBDBE32AC4CC7F49C719DF76A67DCBC479CBECDF1A7F4F38D9481C3A
              761C63662DB6EBF735D55BB6BC99997B7C73BD2EA3CC6CDB8E537626687D78D7
              BCA572E7AFBB13C736020DFB0F616C65B57DF4F8C91ADB962399B9B9379B98F6
              01665652CA99414B7E5056B542D6FC5C77E16C23B0ABAE11E3E73C295B5ADBBE
              B0A4BCA3DB9F58DD20E68D8C999552AA52DAF2CD2955CF385FD7FCE49E6D04B6
              EFACC5E487973BEDEDC10DB6E34C66E660ACB671EDC4CCCC52A9858E0ABD38E3
              89956ACB37DFC7CF36029F6EABC1F445CF29DB966F49A56632B3138FBDAB5442
              29B522C46AE34BEB36C4BC637607291DCC5AB69AA5A3563B4A5571773F6A7B81
              EB5C4808FD9221D7048CDE7B468761E8C848EB6F0338E49A875B435D13C30615
              16444F7C624449204F0350E2D6DE9500224A095AF61525817CB77E3B5112C8D7
              934CF37AB7F66E23701D01541CC873EBB713450373A142A162B7F66E0594660E
              480F5E7649BF1E3B9D6C698574548F7D8A0AAE84749C1422F2BB21E24A8010E2
              BAA1D7469FC07F9C68C18AD7D6F1904995EAA6F279D6C62D5F418542DDF62DCC
              CB812062B89C07AE0498863EBCB4686097D4F4D8895358FECA5ABEBE6C8E7A77
              D367F5B674661CFEA379F5632FBCDE3E62FA82E0475B772072A54CF299C81A90
              6E5D340144A44BE91486E5F3683EF52756BEFE1EDF503657BDB7F9F306299D59
              41CB2E61E68DCCFCACA3D495078E1C5D33FFD997DB6FBDAFCA8E14525C98AFBB
              15706EA05538FF04E4D67347389105402900FE71F3DBFCCBC7EFF082FBEF5186
              AE3B3ED3AC03301500F5609BA1EB628D26843DF8EA81C1F7D72CE3633B36F1C2
              8A724E4E326BA2D975D84E88E0B824FC88291E010F18BAAE1E2C1BAB744D7392
              7C662D80893D11EF668C3C4DD3D611911A3EA4D89A33ED2E3674EDF4C512F012
              00F699E62E001362251D65AC42D330361051A8C36F56BC02DC4C620BC0F8A065
              0D65E64F5CD87782991B2CDB9ECECCA5003601887B3F88F9B74A98D3A7E3B589
              61CC5F00941151DC7CBC3E628A0BF1A6D2C03F11F833A27E2D11F5C563D670B4
              00FF08F836A2B1C8733A170606F0DDD9A7FFC35583B0CB1E2B019CEA0304A395
              E388B8EC41FFF5EB367F031EE339644C0EADC80000000049454E44AE426082}
          end>
      end
      item
        Name = 'EvYellow'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000082949
              4441546881C59A7D90D55519C73FE7B7F75EF695DD65617999306210305017D0
              3058445634379D6CC8322758139C28A51A1D211A6D6A9C86692899404226758C
              89A8CC84A14221021156DC4DA8005908493112D81776D9BB6FEC5D7E4F7FDCFD
              DD7B7EE79EDFBDBB0BD499D9D97B9EF3BC7C9F739EF39CB79F1211AE56514A39
              0022E25E351B57C201A5D448A00228072602E3812140762FCB45A01938011C07
              AA81DD2272EAB28D8BC880FE805C6011F026E0023280BF5A60095038601C0300
              9E077C17383740D0B6BF16E08740717FF1F42B849452F3809F02A303DAEB0B07
              E71D1B5A52D8307CF890B69CECB0AB944347E745A7BEA139AFA1A165586BB47D
              BCEBCAC80013F5C077800DD247607D724029950FAC0316986DA190F3CF696513
              AB1F7BE4BE8FE6CC9ED2138F2647E330EB50BDFF4868D5DA974B6B0ED47D3A16
              EB996C31B915784844CE5FB6034AA931C036E03A9D1E89840F2D7EF09E9D4F2D
              AF8ADAE45CD7C5711C9D005E5DFBBD6AEDCB83563FF7FBDBBBBABA6F36549C02
              2A45A46EC00E28A526013B80511A395A79E7A736BEF0ECD2FA5028E407662DA9
              23602B8F3CB6BAE8D53FBC512542B1466E02EE16919A7E3BA0941A0BEC0312F1
              1A0E87EA36FEFCC9CDB796DF107352407B403301B6B5C769B5B57559F73DF8FD
              BB2F76C7A6688DE781D92272A4CF0E28A58A80BF02E33C5A5E6E4E6DF58E35DB
              478E1CDAEF4529259C026800CDCD6DCE2DB77F6356CB85B6DB34F269609A88D4
              67744029A5805780791AF89ABFBDF5C28EC2825C037CB2375301058D44F00878
              A5AB2BA66E9CB17056CB85B6391AD376E0B3E6AA6EB350A5838F44C247F6EF5A
              D70BDE93F5FE27C5537BD33178D3994CD25CD7253B3B2C35BBD7EDCDCE8E1CD0
              983E037C3D5812504A15032B3552F4A59F2DDB3A7C5891EB67CF30295D1D7490
              23F6BAD711458505B265D3D37F524A356A4C2B7AB72D7607806540A957B9F79E
              F297E656DC14735DB3E7E33DE5A3E9A0AD59C93E42493DA932375E7FADCCFFD2
              DC0D1AA91058AEF324E680526A08F03E3018203B3B527BEADDDF6E0394054D9A
              E28FE7B4EB410659AF8C9DFC40457B67D7ACDE6A27305644CE62703FE4810778
              7CC917FF02AE01BE2F09C80F2009DE8BC2A090326593ED4F2DAF7A436BC8011E
              F62AFA081C06260384C3A143A78FFD6E737AA0F1DE327B3859D77B33CDDA608C
              48507AFDF8A4FBEFEAEAEA9EDE5B7D0F182F22E2F482BFCE030F30F396496F79
              CAFC80D1623D6EC4ECE1645D07E107E82B81F2F8E6D56DE565B59AD438A04CD7
              ACE75B9EF8F603F529CA3CD6C0F8CDBC5D48D569CB563EE604DF934BBF729EF8
              D6DB2B15BA54B966E0D4CD5326F85737B3D774E369DAAC23E84768B161E71B3F
              EE1A4221E784462CD7354CF4A84545F91A9339F13C5B5A4C5B7BD40C2F03AC0D
              A4117A66A8B9AE4B4949E17B1A69A2AE35B1E719593AA4C16E54B7D5DF30B2AF
              C6B6F525C886E3388C1A31AC49238D554A398E522A041478D4D2D2E28E84596B
              08D8C3226572DAE2DBE031277CAA0EBF9E11C38B3BB5860890E700F93A7B7E6E
              764FAA010D44407649C9F73650D69173B566DB1A9194199C9FDB83BF14A46A74
              9C808969980DE4095AC892C05CEB5E295847823FBE534EE16CD309D1D68E9075
              62060E7F3A70860EEBE4D6DB7DA8536CB55E680F195C5147447A80568F72AEF1
              7C9E9FC7CC36E69120FDC2E6D31104D636472C7ACE9C6BCAD1842E02ED1E5722
              759E3BDB3C344599CD58408A4D0BCA229F798E246967CE360DD11A4E8A88EBB5
              1EF3A82DAD6D134C65F6B048B3B7F1B105E9090AA704B721E3D2D47CE15A8DE1
              988E62AF6664F4DBB5477D5A334F44B317D31F5682C0FAF5FA1D7CF7E8074E4F
              8F3B4E137A53776097AEEEC7AB7F33C20A4EDB55DA536C500AB5000FC844414E
              AE58B5A904FFD964574252444E0007BD969A0375334CC08140D26CC8EC1BB780
              B99361D1DC577D68BAC6502722874D8BBFF07EC4623D937EB46A536EF036581F
              721347D0062EC3793ACDA2F9DC8B5B225DDDB1691A43E298A91F6806031F40FC
              662C1209FFFDFDC3BFDE1A0A29E9EB56B9FFC51BE1B4871F1933F9FECACECEC4
              61A60DF8848834A2738A482BB0C6AB7777C7CA1E7E746569700ECF74CB603607
              4F547B98C679963CB1BA58030FB0CE036F4A023C03FCC7ABBCB6B376C1B61D6F
              0F4A0248371F52F37E508E0FCE467EE76ADF399EF5CA963DFA8D7813FE6B1F63
              AC44A2C0E31A29EF6BDF7A66DE87A7EBEDDB0B13A41568D0A8A5E6F9A40C3435
              B53A5F58F0BD7B45445FBC968A88BEA50EBC1BFD2530DFABE7E60C3AF8CEDEE7
              B79514175C4A61F6953487F77E94B6F68BAA6CE6C28A68B4A35C236F01E6990F
              1F410EE40335C0273D5A4E4EE4E09ED7D76C1B3D6AD825FF7E27CD8A6CE5EBFD
              6DBD1F726968B89035E38E2515ADD18E195AC3BF809B44A4D93463B52E226DC0
              5DC0BF3D5A6767F7D499158F7EF9F59DB583FCE29963DE3A772C9BB53DD58743
              536F5DFC79037C03F1878E14F090F9816322F15BE16B347247C5ECA9BFDAB07E
              F9994824DCAF37DAA03B1F80454B5696FCF1B5FD5568976BC4DFCC2A45E4A055
              289303004AA98F117F62BA5EA787C3A1A35F9D5FB9FD07CBAB5A43A11081B93C
              2054BCF6153FD998BBFEC5AD738D470D8093BDE04F90A6F4F5912F1778165868
              B665653927CB6E18B7EF9B8BE77D5479C7F46E1B48B3FEE7DD07226BD76F2E3D
              F08FE33362B11EDFDB5B6F79155824222D19B1F5F399F573C06A604C407B6341
              7ECEF1A12545F5C34B8BA37979832E81437B7B67567D634B7E4363CBB068B463
              828894DAE481B3C453E5C63E831AE00BFD32AEEC437733F0345074D55FEA0D47
              16F27FFED4E04A7EEC3107FFC71EC5BD4E42FC4EBF85D48F3D3EBC6CDB57C281
              40E5FF83CF6DFE0B54B7014A764770AD0000000049454E44AE426082}
          end>
      end
      item
        Name = 'PanelBlue'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000092D49
              4441546881C59A4B6F9C5719C77FCF7B99197BE289EDB8B5495B3569445544A8
              04455DB26681D4068460C9AA482CCAA52C5880BAAEBAA25285CA278056050521
              F80448A8552224D444845C28B951DBE3C41E7B3CF3DE1E16E7F29EB9389D98B8
              3C5232B6DF33E7FC9FFBFF3933A2AA8CCB7B972E351ACD13E790E86545BF0C3C
              09B4DDF30F6E6E06AB055016E71AEC0E0B169A090A3CBBD2616790A3D4FB8B08
              9D660AC09D9D7DFA7981D867AAB03DC8CC7608E56058653BDDAC556597F736EE
              9CEF6FDC7CF39DD75FEF8F639571057E7F63E3DBA2FA06707A4233AF401745FD
              E1008B730D044155414205A09F17CCA70900C75B46812B9B3BA0F8E7ED34A197
              15B536D636ED34218E22D8DFBD7FFDC3BFBCFDAB9FFEE0E75315780FE2E4FAFA
              9B023F3E0878AD80F180620D86B0D84A41304AA094D5A4679FE8CC33DF881184
              ABDD1E22B09F97CC25310AEC66392894AAC49150564AA7D540D5186B2E8DB977
              FD1F7FBC7BEFE637DF79E5951C20729BCF0ADE9BC6FF6F54595D98E3D9950E5B
              FD21F7F7337AC39CDEB0A037CC8355268C10100155A5B41E33BF9B4D631154CD
              DA416EBD22C27E51B2F4CC73DF585B7AEA7D8F44555DD8BC3B1BF8D11C300785
              DE70AAA97FDE69A5238A38599C6B801ACB8B089506BBD88DCB4A8923AF3DA8F2
              F4D231B66FDFF8FE6B5FFFDAAFE5DD8F3E6AA4AD954BC0995915A815E97AA0E3
              A0B1E799579B1B818222D069A688C09E8D7D132A42A9CAB1660AAAFE99DF5E84
              A5B906BD6E776FFDAF7F5A4B1ACD13E7F410E08D8480B5F64490DDEE9943A1AA
              8828AA2679AD3AA82A79E50A83B23DC8468A046A420B944A9563CBCBEDEDC74F
              FD28D1283AC794523A2B7C4110D1F13F7A09BD50553AA25C5E56A84223896C01
              B05E183780401209CE0DF7F6336281F6E36BE722545F38147A8FD358532D7607
              BE1147349298179F5AB140C680790585BCACBCCE2E994365C4BDC16A13D95E91
              A5F35F8880D5C380EF670567D79638BBB6640F118FCAFB63C2B32E17245C441A
              4535BEC0084663F1D54B4428AACA9C059C58792C4D8085C328604D5403B6D672
              552944F2E4F13683A24455E9F687F87C518FB1C64BE8026C2737E794AAA491F7
              3B659424C9AC783FBCD59DA82467D71619E4055F5A5B02942B9BBD3A071C08E0
              64678E6BB671611B9DC30A422B8939D99963372B1D6A00D6F70600E4A5525415
              491405C6333FCEAC4008DE755B505A49ECF17EF1F1E3D63A23790CC09913C6D1
              CF2CC3E5F56DBBA759ED6CDC4E63DFCD4305D258284A57F1D463D8CB8AD91570
              B53C081A5CE970FCC759A6A894340EE3BC966151FA90430441C8CA8A9BF7FB41
              4C29675717BD11CA4A8922A98B84820AB41B09896F1481B41B937A39CD231702
              22B412CF44104C822990C6D19404AE573EB37C0C012A1BE3D7BA3DC0D08AD836
              1311E1D9C78E7377A7CFFD416E51D76BC41A6302A98CFB7E5C11465DE943DE3E
              116BDD6961E4DEEF0E1711DB9CCCCAAC2C896D37BE787BCB9F55542E6C8C94AA
              24166862400BFB79412B8927DCFEC1CDCD11D609CA8B4FADD8DAAF36728C571A
              71C46C22349238C825A3741C8907697A40481A3530963D5B22A380AA494667D1
              C9E36024F583ED1CAB9C6EEF49191655B08FF59DCD21C740F3AA228984C21139
              DB2C5DD5124C181595F58467940F6014E39D340A7E914F8BBB40F2B2723B8ED0
              6BD4ECA9B6B1012416BC39C323F1672640E226A5078BD80D0EC799427161B79F
              57B4D2A8E620027955999C101D0DAF31EF039C986FA2AAB396D18393F24172BD
              DB0B68B079EDB41A001455C5FA6EC67E5EFA12EDAA4B1A452CCD37599E6BD06E
              24FC7373C77B392B2B506567901B92F769201C193B94782ACAC8ABA22C3413F6
              B222C8A1B13056E5CAC6CE84D59A36575DF79CB56C1C5E54CD345623339DD62A
              A70A95BA19DAFCED64679EE5F9A6C5596B50B8FC11A19F152072D40A98EAB060
              AF52007AC382DDAC6065BEE91D1447421CD553DB5C1AFBAEAB28596180A7714C
              5694E465451A47E46575B40AD455ADA60822C1E839B67EB498D54F5D7F09EF98
              9CB23373A18791A2AAB8BAD9F3A05D9D1EE425ED86B1EE95CD1D9A71C4D9D545
              C074E650AE6DED01B6EA4BDD8945846151D24C62F4A87240EAF9D0835755DA8D
              C41724F1ECCFBD29A83298F7BA0EEC26B6D2F1319BEDAE171C8D585ADFCF0ADA
              8DC40EFC268177B39C769A8C5618BBFEF2FAF6C8550D40338E4084D84E74A90B
              A9697DE0EFFFB96F622DE821CFAF2D1D4A0711A1ED13B88E5FC7761DFE0BB7B7
              46A6BBF0922BC8664F39F2B2B243FE941CA86B7230BF3EA4FCEDEED6042D31F7
              3CF878EE0D0D8DBF70AB6B42CC03305CDF29A862728AE0B927050736329B70CD
              E441BCFE6099F696E71EEB8C7473039C3A57A8633C1C8D5DCB082FCB8A528993
              033CE01034EDB0F230446D5C2A55937002176F6FF988F8CA13CB768550942571
              6C38512CE656CE4E9AF5F465C197F65E496C18291C5085A46689D33E3F98553C
              630D39D958F54FA2A89E013033412CA6B1AD1E6B311F4C877E3BE70DA678E0F9
              CF1D2E610F143F2757B67A8C959E203EE4807C33A11470D360D99194D1AF3E79
              C2FF7CF1F616124154B704005E08D68432284A04B8B5DD37FCC8CE21A58EA96E
              F73ABA3E108AD6B9745048FEEBDEAE5F3B82D456A828B81571F7B1CA67A0409D
              B00F16374E22A3A36A5696F6F6A3D6AA72B3C367E68119C491BCDE304710E6D2
              98CDBD21006555FAC44D63537B4B31E19500BBC0B1FF13EE408CE5171AE6B3B6
              CDBD613D0005D4A25450B5DC28CF3401EE029F7FD470FAB9BDE7B4D8448C550F
              84AF98CF1924B8A960B4A9896D7AAA209150EC6CE5892017147DE40AF8066B38
              F008979F26A797478360736F0895D6D789E27892582594BD8D4FEE449556E71F
              3578701CCC5092FA0F30C84B06C5E8BF03C5538D605335F7A422C270FDF61FA2
              62D8FD1DC2F523514195561A7BEEEE9F84801E2011865E44625FA37A8F417723
              CF36FEFD0B5155CE5FFBE43B2AF29B4709DF7C8DC0858E31E37C9A788BBBA90A
              C5283926B7B627BE55C0139D79DC582AAADF7DE9CCEA6FFD27F5E76F7CF24B55
              79F5512A314D7CC8040DCB5D6B4E1343EC0266274224FAD64BA7577F080199CB
              4EAFFE4444DF3A1AD853507DCA5566BDD6961F4730ABEAEDE31FAFBEE61E4F7C
              D9C386D31BC0D3FF13C620EE752C070E291FABEACFCE9D591D09F5090500FE7C
              F56A338B16BE05F2B20A2F887252A1F530A71D6E960B80C140853BA25CA8E0FC
              76D47FFF7BA74E0DC6D7FD179125D34B1ED386A90000000049454E44AE426082}
          end>
      end
      item
        Name = 'PanelBrown'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A00000A5649
              4441546881C59ADB8F5D551DC73FBF7D39E7CC3973EB74A696C2B44D2F465A48
              4CC3258D541FD044126244826F8628F10F3022A2187990444D0C6F3CC2932F60
              22188DF1CD440948502E914AA550A0B4855E984EE7CCB9EECBCF8775D97B9F39
              675A1A8ABF977D66EFB5D7FA5DBFBFEF5A7B44551927675F7CEE4E51EE453802
              EC001646C774CF9DB6BF94A4BB0E0A22305CBFB461BED6F69D24F6BEAA2222A8
              2A49A70D0294F490302253D54BDD3439DFE95F38B9D2FEEBC5949F3FFAF89327
              46E79551039E7AEC87DFB8FBCE230F0387C75A5631E0949B86A4D34604925E07
              CD52AC56FE79EBBA9D0CD72E92274382B84ED6EF10369A249DB5D25873952044
              82A0727F489CBE76F2ECB3AF1D3D7BFFE3CF3CD31B6BC0D3BFF9C96387762E3E
              3CB7BC379CA4F485375E2ADB0F28716BD6FE290836024E1F0454A9CD6D41F31C
              5449FB5DA2461311B1D12A1B0B41188104E4E99020AAA1AA448D2950E5C4F9F6
              C97F1E3F7BC7234F3CF50140E05EFAED2F1F7AF0965D4B8F0422139507B78E6C
              BC2F026AD2239E9E239E9EA33EBB406D760BB5B9050441B31411219A6A814D21
              EF7571738ACFA6208AABCF44D8B36D76E7A13D5B5FF9F1030FCC0044004FFDE2
              0787EFF8FC0DBF12E7B1CD44AC150A88B99A08D850B7578D2D0A599E910D7AD4
              A6E7CCD320A49AB2234ADB088A409E2604716C1DA6B4AEDB659C80B2274D16CF
              DED0FD0BF0A508E0EEAF7EE5416073CF5716B5D58A31C278487C12144A0A61BD
              E16E12359A284ADA6913B76649077D173863B1BA3984B05E47ED32333BF72340
              3AE8996555B975F7B6C30F7DF7DB5F8F3EFAC773BB03B8E7CA942FC420893548
              028A509B6BDAEF11D6A7CC58280C56889A33A82A7932B071139F99825825214F
              06A070E99D379C0F682C6C03200A456EDAB5F468F4B7E75FFAD12DBB16C5468A
              99E5BD9B2ABE78D36D95BFFB1F7F840249679D5A6BC62FE49407A136330F79CE
              606D85A8D1A4A8705B37A887520534CB204B7D6997026AE7CF1102F62DCD7E31
              9A6FD60EF9521A49FFD5B7FFEDC3E8AEF3FB6E1E8984B13C6ECEF8F03B578B2F
              54F3727D7E917C3820A8D5891A4D86EB979020B0E884874ED5DC0302815DDCA2
              9908D466B610C63576CC6B23AA47C162D26913B766CA486695B34AB8D88F2970
              93C3E27B517D7E2B7173C63F0F6B75066B17FDAB415C2B95AED839C4A3529196
              853BD4E49649B50A0608511C45F5B8D5A884A83402806CD027AC3536280FD0D8
              BADDFF4EFB1D50C88676BC98AEDAD8B244D6EFD23EF54EB188D8D429AD5B40A9
              FABA2803822AF457CE559C17A96AE1DC0DACC23C882C924C601D2306ABC97FAD
              462C6C34B16E349E56412460EB815B2A3374CF9FA17BEE94AD0BF1516A6E5FA6
              F3E1491F21B5F512ED3F78F3695497C7EB230E86A9369B09E22C2C5D4DE72E51
              0555240C4A46C2CA9BAFB84788984EDC5CBA1EA8FAB6A8A9DCFF8E36D367CB48
              C15E4EA2A9D6589B0ABB0DDA84B5868902C2CAB1574B8132EAAA427D611B9D33
              EF9AF69067B6C01D5A39D895CD0D28CBC7475FB65E2894DA7AE0D6CBBE27AE73
              1777F0E56B9FF98065191245D8B235E36C1DA9E60522E20AFA3211288B0F6509
              5647E5C2D1974B204A8128D51988A69AA64C4518242B963AA4045164E7B7A864
              0D493A6DA2E634411892E719128666A62C9D6C40EFC287B8A243B5F0589E0301
              E3CAA15058BD87CA94DAFD962034ACB4DBF61E9130F469E5E72BB15D130143B5
              354B218C9030DA24025260BB89A373623001B1CC92AA0A798E840122C2C28DB7
              5ADABC0A0AED53EFD05FBDE04D2A96932242CD19D64E1E2708A3A2FBB8C80058
              07C8A635A0268049678DB835E353C6F194B1FADB4909024F11A482F736F71C65
              B0E36B5B96C8D3A4E406239E08DAB1C3F5553F8F8BC2E63520104F9BCDCAF4F6
              65F23C236A18A4A9CDCC8F1D5FEEA6A2CACA5BAF97ACD5C21887AAC0F48EDDB4
              4F1E27CF52B2418FB0DE04C150F320206ECD56205CB394208A372F6283B3C54A
              8A124D4D175E1E230E95343738BDF2DF57BDB747E98362089933C8C162D86892
              A72961148188CD7FB3A6B89A0C235F2F130D285304B34911AADC6873F19E46D0
              3441A2B850D476590787DE69980CCB9381D956BAA2F7BB3D63B4994251E1CA60
              746CBA6C22A6E958E55182C829537464A14828D59C99E5BDB4DF7F0B03B3AD02
              4000896204A8CF6DF575A1972DE209E2B05E3DE152160FDE3661B4FAB0BBB49A
              DB7DA361BE95615AAA0EA92AD8689225439B4E33BED8C56EA23EB1019368F538
              59F8C221926EBBE2FC897C2A576697F779CED33E750211E85F3CEF8D89A7E790
              28261FF4889A33571701E7F582E488F76EB9BB5D7AF758B18BB4639BDBAE2FD5
              C6B8C9C56D032A868A089A6784710D05C228F6307C15113066383EEF9161CC10
              A7B80380F246A72CC621B9276EE5344A7BEB4453D366E7560691ABAD01AFF4E5
              D2C82A9F763B44532DD2DEBAA91FDB095561F1A0815D91809CCC2815148723C3
              F62AA8324C571160B8B6CAFCFE9B7D24D0312874E9DDFF543AAD00737B0EF8E7
              AE60DDBE75B21833E366CB2FE6699D4E305FC49C07D926659973890E9AD44D07
              7D1FF90D068C5286C98E164F131C7173793B5C5BC13D29B4773C29B37C4A18B6
              2FFA52EA5FBC60A1B3B28100843CCF91C0443DCF52DB03CC980D06B857D35ED7
              6C032778D9295BD998979CD058D856E9E6EBA74F98919688B9AD6CB15DB0DE1A
              F1B820BEAF284AEFDC19F22C25084398D48915B387ADD0F94F2086B30949779D
              A8396D8CF43B4A4B0B6C1EA92A59AF8B41B3AC705CA9CF94E15735370762A9A1
              211B53C8E9EC58E795F086D1396C164453D3B43F78BB4831A331737B0E104DB5
              18B62F1A3E33D5221BF4C855BDF2881035A709EB0D5F0F5932843C27CF3282C8
              9C216D3060BE54B0572BE51D9BF762C1E64A9662A3E0598FFDC6D0258CEB4818
              D934139F4E3910C631799270959DF8F2529B2D3EE6B43F781B11538848B5566A
              B35BFCEFFAEC16D6DE3B669AD3548BB4BB6E60B8DFF10C2AB61C2957ECDE598A
              EF03D74C2C520541503A16192FFE5169E3ED377F6A1872B1435334CFAF4D0446
              C5EF8F5DFF9BC0876677ED0735277B6BEF1D4345C833B38977A9D75CDA4136E8
              D33D7FC6D4D9B5567E32531D23CEBD415034D220F45148BBEB44532DC27AC354
              854284EAFAA7AEF5D58AD534B407C06AEF39BBA2E6B41FAAB6E023E0C3FF87AE
              E3A4CC83825A1D97376EFF6144C993C46761A4F08AC0773E534DAF40CA75E3CE
              E94CEA085A57E6A60F90A6D9E98030FCC367AD5C9E0CC88603F264483E34BF47
              C5A54F36E8533EC228BE6C422FCDFF2CAACAB9179FFD3DC827FE4E76B5920D07
              95335655F321E4E337FF5525746A8FEAAD01F37B0F1606AA2641981F0C0042F2
              9F02BDB1AB5D03714AE7E9B07A7AAD25E5714DAF7ADCE824107962E9F67B8F07
              005B0FDF7B4CD0FBB90CC3FFB4C435AC30AE57FE769D5ADD073E55E6F7DEC4DC
              DE8315EF032F5C5AAD3F0CA52FF54B87EFF99DC2F781E1B537C145C19CE2797A
              E10EC182D01F748DCAE9F7DF7BFD4F7F7FF1BE7D77DD3500AA54E27387BFF9A4
              8A7C197869C39B9FA284B53A415CF7D720AE59A3A4004E77225EC89A8AFEECF9
              174EDCFEBD877E7DC6DDDCF0DF2AEEFEB9179EFB1AA2DF0239022C03E377E4D7
              4E52D0B3204705FE98A5C9D3DB8FDC777E74D0FF00BED91773707804CA000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Panelgreen'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A00000A1F49
              4441546881BD9A5B8C5D5519C77FDFDA7B9FDBCC38032D6DA1586921CAB410C0
              2618E28B31D15704438CF2A2F1C9687833319168E20B2F28F0E28B262626BE68
              0C6062F0452531013422500AD80B6D9152DA613A97CEB9EDB32F9F0FEBB2F799
              99CE9CD2962FEDCC9CBDD65EFBFB7FD7FF5AFB88AAB25E5E38F942339D997B18
              F81AA2F782EC05A6FCF81BCBC701504000553830B397864910A01935581D7541
              4055118433BD7308E2EE5344849669027053EB069A26A113B778AFF721C32225
              4FF33CBF34ECA62BFD53A38BFD3F7EE1F30F3EF9C8C183A3F5BACA7A00CF5D78
              F99B084F009FD980CCC97F96DE61EC368143B307004151DA519395D11A00DD7C
              C074DCE674F70314C8CB9CC4C464658E86DB05509A51C30254C8D5CECBCB0280
              6CB13F1C1C5FFAD933DFFDC9139B02789117E3950BCDA7107E7039C5BDBC7AF1
              1D000A2D88244244989FDDEFEC2B9C58FB1F5E3B11AB50A639028C6A00C40F62
              A7B7A286F598080A8C8A8CC898B01640F7B5737F9BFBD6E35FF9299400C60FAC
              2E349F9E4479AF1440642267316BF523CB2739B27C9C619132285286656A9F2D
              3870D03009B916D6E66559794104556554E6A4C588BCCC699838C469A1D613D3
              F7DDF2E50327FEF294D7C5003CBBF0CAA30ADF9F4479ABB0FFA302F4E6F24907
              4CC2BC5215D4E589FB9F97393151503A2CE32CDF8C129A5183D879D6DF1C4914
              968EA69A8FFDFA8DE7BF0120BF39FDF7D65CA7790CD8372980B4C8E8E67DDEED
              9EADD0847010544B442424AA8884B0C9CA1CB021E513DC9BB961120A2D886B9E
              2DB474EBDB6922B07F7A2F7161CEB67A7B6F8FE73A8D47B652FE9DD5D31BAEDD
              3E73AB5DAD16BFFE6F018C316349AE28024462C8BCDB546998985C0B66931986
              45CA74324537EF332A32121363C460C4906BC174DC4655D9D99AA3611230726B
              57CF7C3D56E421E1CAA461126B690889282ED02BAB5A4CD349075096D24B16A0
              5853DA4455628950A0193583D51B2661588C6C52A34CC56D974B422B6A867C89
              DBF14346E0F0244AF7F341B0B017A959DE7BA413B768472DE61AD3DCBFF3103E
              51B4F65B150CDE4B16AE5F4B104A2D83F2129EA861DC267B8649CCBD31B07B2B
              C57D8476E2B65F867F2E1EB556ACC37156E9E74304A15FABF2A0A1A6E7A5AD40
              460C825068C15C63866EDE0F45C188A99417480BDBBFA6E236E7078BF8B2A6C3
              629F019A5B01D8D8A7BD17245416BCF5C459B3862B12432CD1D8E748226BC99A
              11A663DBE8A7930ED3713B78222F0BEB351776954D14D3881BF156CA03CCCFEE
              B71670454680D7978F07CFD40109AEBBD464DFD41EBA599F8BE9AA9DE53C5568
              698189C7AF01F95ADE77C6D3AA2AA92B1A2274B33ED3711BD0AA916D254AA5BC
              AF2875CBFB5936819D32C0BF168F06ABDE7BE3E738BC633E24B94D5E7BCFA5AC
              C75ADEA3D492524B669229448448229AA6E1E88430D29C5131A26112BAF90004
              9D08800F8BB41C39D7D7C6A4FE5936FCDCB8965421515B4B1050DB71F3B20816
              F25CA8D082416E3B3C28EDB8098A6C1B425E175568980608DC73C3676939E2E5
              E5C27089F7BAE72A86EA3CB55E3A716B2CF67D755ACB7A4C271D579D2C3541A0
              9B0DDC9D1AF8D3A8CCE99898248A753200158EB13A3F26AA41F9F5526851A3DE
              36197BF980A9B81D2C3D9574FC320C8B1185164CC51D544B10712C3609C93C2A
              33B23CDBDA033E86836222DCBFE3D0A67377B777F05EEF43AFE638D374F9E989
              1D584F78AB0C8B748C911831B4A2860B5DDB252C15C93062AA3511B6F640E8B2
              EE499B6C7EEA72FFCEBBB65AA6CAA15AC5A9CF19A77DE2586849240605129350
              6A89AA322887744C4BB64E621716F59F938AAF305ABBEFFDFE0544C4721C6796
              F9D9036E3E0C8A61B0D14CD2613AEEB0B7B38BD8C4C412119B88C4C48808EDA8
              8520DBE580AF13C61A641B0FACBF17A9F24542ED554A558C3188C2AB17DF0E79
              51AA9296B64C7E345C6667730E11D8D99C03C0202CA6ABD810B5EB6D03C027A6
              863E30A9AC653DEADB551B22367406C59029698730F21D36AA058488704BE726
              5E5F3AE648636598F94FEDF761B9B5072E17D3938AAC8B739FC95351CB82D16A
              DC6F4F3DFFF7BCCA39B2DE3949CBD4B1D2091BD9D5482F1F502566401262CA67
              88717CC930EE15EFF791568700795990161969B14D19DD4E4A2D6B8D8BC032C1
              D77B5819ADB13A5A1B537F7E767FF8FBDF17DFAEA9492084AA4A4969FB004243
              E210D0E7061F2162D8D7D9B35D0E4C2E9EA46DF6799DEDC7E4F08E79046158A4
              154315A1284B0A2DC9CA02C6CC04B1896D29CD875709400471CC320ACE87A3CB
              277DE7735794B4C868474D54E0AD9553087070EEC0585757202D339AA63146CD
              55C7E7F8953B71EBEA72C05B38844D0D58F5386BBD96E336F81EB621BFED05CB
              B1AA9D977D46952BFE10C037EEAB0230A6838C332455181423D798347463CB26
              3736753FCFF30D11C8B40854C204D41A604C279D2B2373EBC5ACC75F2B9B2258
              46591F064F8303D84B59CF43C05FF5277453EE24C26E57ED1CDBC9ABE75CB324
              DE5CC6D377AC6209AC665D54D59D2FD96B76CF2C618E20DC3D7707A7BA1F84BB
              039FBA5E00EE9ABB7DCBF1D551D746B1561B998A8C8BFF1758AC4D6871242EA5
              ED0ECBAE1B002FAF2D1DAB7DB216BBEFC63B5D77157AC5804ED472D41B0A677D
              D4F6187F407664E944B52717E817C3B0EA75EEC49B74E03062631CFC86BE3AFF
              54AAD33DBF8FA87331BFE2EAA87B7555683211B232DBE4AAB8B8F7C712D55855
              32DD5CC1EDCCAC67A4B6C6754E629B74898903AB05984DA6C7661DDE310FC0B1
              4B6782D57BD990669CD0CB8780868A2718973F76ED4FC0031ECA26DDAB26C362
              149CA00A5389DD72FA9DDA78208A6B86A2F2EC8597AE64977245322AB3B1D307
              717BDBCD01A48808677B0B21AC06F930EC477BF9A0B6B1B62AB7A4797D43C89E
              624F26B64CC24DEEF8BC9BDB0A154BC4D2C89EEAF9DA5F23DA1A0329DB9C8F7E
              12E21B57C324BCB572CA5D1B0F8EC0471DD3EDF57A1A03E7D9E28DE4C7916131
              1AE745B0E1206CA328AAF6AD4E491910D54BA778C2ED4F4AFA65CF00AF5E4BE5
              A13A430AD47782CD742B6AD28A1A344DC3DD23945AB8930D4226D565B8B07626
              16785EE1E16BA63D8492999519897BF90DF0E6CAC97002E1B5BA7BEE8ECB2D80
              65A5365C1A512350589FE4BB6FDEFB8C59EEA7BF47F5FD6B09C02BE195AFBFC4
              F1DB453FF0D6CABB97BB1DE37668383C9E5A2B305CEC0E564E14BF8BBF7DDB97
              86CF2DBCF463E0B7D74A777F6613DE9F8510B25D2A2DD2B0EBDA6A01FF1E4D44
              D8DDBA913DED9DD5941B78F4C12F3E300C6FEA9F5B78E99720DFBB5620369323
              CB2742F80CDDD1884138B4097B3D3FBC58BD6F70D76E7600149E7C68D7033F84
              1A1B9DDB357A6C65A1C1F504515514A51535373D23F5B2A7B5E332ABE82FF25D
              1FFC28ACB9FECB1ECF2EBCF2A868F904229FFE384AFE77F54C5053DC4EEACED9
              DBC2F8D195774395F2C9B1DE031F0E16AD72B597E77BDA3B4EFFE3CF7FFDD5CF
              BFF3F8E65FF6A8CB1FCEBEDC4E1AFA75451E14382C70B3426B5200B5E7C23A00
              93C8F9C1226551E6593F5D1EAC748F77CF5FFAD33D07BFFAF4665FB7F93F7C7C
              19E218D395EA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'PanelPurple'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A00000A4449
              4441546881AD9AC98F245711C67FF172A9B5AB9771CF8CBC60BC608317590683
              64FBC2724220BC087CE4E09B25382001663920CB424220C0881B7F001236926D
              71400224382033C29231026F83663C6D8F67A6DDE399EEAEAE3D3383C3CBF732
              B3AAAB97F18454AAAAECB744BCF8E28B88572DAACA8C3C8579E9EE8B5F44F461
              117D00B816589A1D08C37ECAFAD91E02F477129AED10056EBCAD531977FAF54D
              04C1EEA68808F56600887DA28A0874966B6C5E1C916693649CF677760697CF6E
              6CAEFD79F5F8D1A79FF8DE972E4FEF2FD3069C78E1C267C13CA370CF6E0A97E5
              ECA92E0059AAA4A91284C62A027CA464C099B7B6C952CD0D4EA83743001AAD10
              55A5DF4D68754240E8ACC45CDE185AE5101445103A2BC1E666F7FD9F3FF6CD4F
              FF18F04A570C38F1E2FAB754E56740B09FF200674FEF802A59664FD06E6A576F
              2D44F6BB4077734C9669E9AF427F6782884069FF95630D3ACB3117CF0F082343
              AF3BA6B510A3AA2CADD641957627FEFD1BFF3BF1F8E3DFFD4A17C0B8C9FF7861
              E31BAAF28B832A0FF8CD87BD842010824058BDAEE9E123521C95208C06099243
              4644ACD122FEA5AAA84210D931AD85C87A40847627A2D58941F8EAD123B73FFF
              DC63CF0500A155FEC267C0FCF2C08A976D009A0B11EE644FBD96635DD51F787B
              29A6D71D03D0EB4EFC5C11D0CC8E132CFE9DB193494A1405B9B9788FA92A8DDA
              C217869FFBD8D3C00F4200D1E0272A1A1E5A7B1144D56A5982C3745CC9CC8712
              BE8D9B278C87298AD268872C372D64DC1C41583BB9ED4198A4F2E4135FFFE16F
              E5EF2F6EDC67B2ECE5432B9F4B6F7BC2DAC96DFF3D4BB50C7550387E638B0B6B
              BDE2F9CC4114CF9756EB4CC6292879DC58D10C9249E6C78AC05BE7FFFA4723A9
              3E72A5CAEFA6474572238C11A46C54E9A56E5CBE809694168A2012536C902636
              56AE69DFF46028A2F7CE53A8BF93E46E14FFDE6CCF475A9A4E4127C7ECB9333B
              8592531E90B257D4E615F7603C4AA937434683945A3D209D64849121B08CCB52
              F386058372DD5C8D9CF2E8AE9E9F56C404625F4668B442DA4B11B7DEBD9C0FC8
              97CA0D0B635385943F6C6532CEC85225AE050842AD11804018193B4624F78288
              4168EDA31BC37E3A0B8F5C5A9DC8DB0A360634F33A790D2D3339456DB2ABC4BA
              8B571134534C202493CC12423E2E996424938CD43F170EC43C2E739E5FDBA93C
              17849BEF5CE48EFB8E70EAB54D26A30C63ACDAE371CA649C79E51447971656B7
              DFBBE2D7D9D99AB0B335A6BB350155C2D890654A10180B4B85CE4ACCA097E711
              6FBDEE63C0CC31E5272596022BC052F7569CB85F464AA49453639A284168C714
              F46847490E9734C9FC1A1FAC0F8AE49715F1B5A701CD76346B93C07090585C96
              E496BB9678F3954B0842926484A12BD2E096BB96190D12DE7FAFEFC79F7E7D13
              B08A8A3F2C3B41732FA58985125826CBD27C98D8A312E1601002F8EF3F2F52DE
              67D84BA9B766AB0E456DB0A92DC22C812971BD3A76344C6D79314C2B39C30492
              CF3504A101F2423190AAC70FE28129CD6C00FAF7595E72956395B20411E5DC99
              9E77FB7894E5EBA85F570031B9F262CB6E17ECC658020802C3F26ACD2D0BBA87
              072E6F0C2B41E73F3B8C0BDC7267B545A8D5C34AC252D51C6AD512A3560F180E
              9252C2767B385740A315D0DBB6746A02EB0955E5E2F941654FC31C1111BFF085
              B55E29C89C21BBCDB14A0EFA499E42EC2C710900988C326F4891BFD4835B55C9
              5265FBD298F6624CBD19D2EA44345A212BC7EAD574BF570C3857F6BB93DC9D14
              351BCA6E1638A51DED7A38E493C3C8E4F1019056180D052D41CAAD17D56C909B
              208766B9ADD80B424E5A9D98EDCB63CBC94986184B9077DC7764AEE18E0A55C5
              97113E91E51AB4DA1147AF6FE67B449624A6CA8DB86601D2EF263417C2D21E45
              0932D700CFB9E0370E42294163566EBE63B1F2FDBDB777FCDC38A7DDA56B6A79
              CD93F8931CF492CAC93BCF7CB03EF41A0FFA090B4B918D450F893D0C58BAA6E6
              3F9F5FEB95EBB95D1968EE4100BD6EE25BCCDEF684D6426461B65B8157220071
              09223FEE34513ACB31AA36112EAFD60E46A3F3E07210E5959C06992AB7DD8160
              13E3CD772E72FAF5AD8A115906228521BDEEC4972A0B4B31597A983C904B399B
              3A397A5D73D7B14EE9463BB4572E2D7BEAAE0074D0A937C299BEC0114699968D
              B1859EB8FE824364E2B2541AAB3DD01445C61F7B6739F673CB16BAA6DDB9C365
              F0E2048ADDB2543139F17737C76C5F1A5F9901AAB6396F77A2BC2E99FEBBF2D6
              AB97CB318900CB47EB28360E9C4C7BC36772575A18C8B2BC1E0AA6363357E801
              C46EAC33C0CEFF2C52698B1DA3B53A51A574D0A9396E6D9794157C393DA33CB9
              47AE4CFF62B3DDC4F520024CC699BFAD730F87BDC495F3954916F382115B1719
              034120C4F58028B649F0865B17BCB126D8A5A139F3E67625D38AC0473F5EF0FB
              BC80AD1AE83E08513C7B462E53970FA05AFF159C6D2B5272EACC387B7AC753AC
              B08B01FE8AD0A5F8B9CDE47C2902BC2880DDA98D872971CDF6B8EFBFDBAFECD1
              6C475C7F6B9BB593DD4A2B391AA64539AEAEB6B22EDC35064460D09B506F86EC
              DFCEEF668172DB3DCB9E5D34571CA011DA5BBC42BF22D42DD0C4C74D9AD993AE
              957B09B1BD72188A85DBACF6D65DCECDF3CA863DC5057156F2A63ADB8A5AC929
              3E1A24DE145F3CAABD9D4813DB3F94C5767BF31A1A5728B902FA1065835FC271
              B928FDBC11777CAFAAB4F2C2CC01A1D6C8ABD792B745EC758A60A9D218482676
              429615F960C6809B3EB138FDE8D0E2147550C0B110D5882A20E409177BE79311
              8605381C83D51A218B47623EB8608BBCC928BBC23CB0AF0105F45C4F30CC63AA
              849D99EA75EBD20854397E438B774F752B1D1B280B4B313B5B13BF6E543357D7
              005FA7E377CE4F4FA937A3B9BD34D87C51E9D9DD12A5B2BE2C590A905D59229B
              2795782F2BEBBB2E651E25A82ACD8588463BB4D7392522C8C195C713953EFBAA
              4348B5E8814524FFF1637F71B192E417B885F1E0AE50EA8D8034D5FCC6CFFAC8
              08ECECB1EEA1A5C0FEE1E6B99F9BC2C8D85ACAB9530B3ADED99A20824D84CE03
              2A9C47F7FF45F270DA40F7F2D8A72617889D9578DF79CE1371DD301AA49536B3
              A8B235FF2125C36826AF5C55E5A1B2A9535EF3EC3B4FE25A40543344B121CAAF
              D5FD2D44B55042B0D5F0988B1B064D5FB8EA06B8AD44EC8F2453321AA433AFFD
              17C35E060C123FE79D8D37FE651E78F4F8CB207FBBDACABBDBEB563B242B7759
              14ECE432AFFBBE71AECFC6B9011BE5B6758AD9EC3C18A7C3ECD2C6DB4F1A802C
              CBBE0FCC1ED587147783677C655BAD7427A30CD0A97AABB8F4A93743EA8D807A
              3324086D3F00904E94B7D75FFAD36F9EFFE9AB06E0C1478F9D00FDF6D5547E71
              A5C6C272446739CEDF6B95BF0B92B349F9D6D9327E6F7BCCE2913A8B47625A9D
              98E642C8D291A2A7DEE8BF79FED4D6C64350BA1BBDFFE163BF42F80E7000401E
              4C1C1DDA578962A942A868E2AD975C9FEC806FE7D951672FFDE79D93E7FEF2C9
              679FFDD11898FD678F979E5FFFBC883C03DCFD61942F27B4F2E7BD64E39CBB79
              2E3CB27A6DC33DB988CAD30F3CB2FAEBD280590300780A73E2DEF52F67993C22
              703F703DECFF6360D502AEA4992BCB58D175C1FC1BF40FF124FADDA7BEB6BC35
              3DE8FFFB1D3D3A4054C5B40000000049454E44AE426082}
          end>
      end
      item
        Name = 'PanelRed'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000093649
              4441546881BD9ADB6B5CC71DC73FBF39E7EC6AA5D50A5B966D25561C72B143D3
              4088B169E85BFB07C426A4375AE8531F5208A550DA8794D03E853EB4145A8AFF
              8052885B12F525F9070AC5A22431294EA04DE5D8B1635B56B4BAECE5DCA60F73
              D939AB95B3ABCAFD8198B36766CEF9FEE677FBCE1C89D69A61F9D7DB6FD7677B
              BD0B4AE4BC86678113C08CEBDFB97E1D01B4D6F4EFDE456B0D227E7E63711180
              E9871EF2F73EBF7205B163B4D6880849ABE5E769AD995E5C24FDFC7310212F8A
              7E37CFD7AFDDBAF5D9C71B1BEF348F1DFBE5F75F7BAD378C558615B8BDBCFC4D
              D1FA75E0D15D9A3905AE5DC3CDEBDDBEBDAB7FFAC409D33EFCB0BFB7FEEEBB43
              6F1692D959F29D1DA388D614FD3E0045AF872E0A5414997B22DC4DD3ECFDADAD
              5FBD72F1E2ABA315B87429BA5DABFD5AB47E652FE04EB657571111B2AD2DF29D
              1D1031AB6AFB6B870E5580A2B51F57F6FBA85A0DAD354A29C2058CA6A6D06549
              D9EBA101B44697250463FEBEBEBE92C3577F70F1620610BB8E71C11B4C067032
              3B4BDC6C02A09284EEAD5B00645B5B60DD249E9DADCC89EA753420405914E8A2
              30004528D3D42B2D2206BC5B04ABD057E6E7CFBEDFEDBE037C1D4001DC7EF3CD
              6F8D0B1E60386ACA7E9F6C7BDBBC48C45BA22C0AA350BB4D91A69459665A0B54
              941AACAE6B45902802A5FCF37CBFB5E673870E7DED0F2FBFFC2A80FCF38D376A
              4792E42AF0D8B80A00EC7CF289710BFB62AD3545B76B5632CF5151E4FD3C6BB7
              7DE0BA5625095A6BCA2CABB88806541C9B2401E83CF78A11248BB648F76F69BA
              10CF27C98B93821FBCCDFA7614797F15A588E2D85B29DBDEF67EAECBD2C78B0E
              57DE81C3B81A658956CA58328EA12C899B4DCA34F5EF382CD268DCBBF7B35844
              2E842B30117E40A28832CF11E7B745014A993E1124B8762D41EB953037CDB55D
              1094226E3406E39C7BD939C71B8D17155A9FD917FA1054148D0CB8F93367062E
              66FBDDEA6BB7004AF93FE7F33ACF8DE2E1C26A8DC4312A4988676650B51A4F2C
              2D1D8E8163FB013FBDB4C4E6871F1A338B9855D7BAE2A7AEC0A93836C0AC0B61
              FD5A80E6A953A838A673E306D9F6B68F136F499B08C0D40789639F0474A7B3A0
              082AEC242222CC3DF5D460356D708615D9556B02B71140D56A3E48DD68EF1A4E
              9402A0CC7393207A3D5492F86EAD358D38563163C8DAE5CBFE854E8E9C3B0722
              C64D80B595150F320431FFDC73F4EEDC01A073F3E6E03965E9412242637191C6
              E222FD7BF728D394BCDB4530ABAEE21855AF435922B65E8855662C0508C1BB95
              76BE6D411F7AE6993DE74E1D3D6ADA8505D2767BC089B09673F181A9E222C2F6
              EA2A00910DE2324D07CA2B65D26B1C8FAF40E80E1AC83B1D5FB4B4D6C60502AA
              50B184D75DFB9AE0E6F6D7D62A312322B44E9FF6D785053EF4205FADD5B80A68
              A8545967057FDFFE76E047B15C82B10214DDAEB782B6EE012049C2DCA953344F
              9EACC495A71E76FECCC993E35920F47FDFDAC08A1B8D6A61B27DA1746FDEF4E0
              1DE94B37374D76B28B5116854F9D3ACB2AC901ADD1798E0A0A24185A3F520147
              6B37AE5C318082959F3F7B96BCD341B0ECD1028BA6A6F65C009F6D1C6315A1D6
              6A9940B5C54FA268E05A4A791E2560823D8EFDC2B8FAA394DADB02EE45214D0E
              FB4297DAD35DDC78FB9CEECD9B2656866B855226C3D854BAF9D147349F786210
              5F8E24DABAA0EA75F26E17D8230B7980611555837089A6A7EF0B184CEA0D81BA
              F8B01A79F02A498C8B8445D0595C84B9D3A70148373640C4B4406C318C0CE270
              3D055BEE03371A5BC23981226596F9673B45B4A5DBCE5ADBABAB9E6E785A1D10
              40E7927B5AC0A54BF77B942BDD17BB03162A10F878A89488609994893FAB50D2
              6CD2FDEC3303388A483736502E56ECBC910AA87A1D802367CF4E00B92A7EE52A
              5A59C06E2333CC48032535B0F1C10700DE62A1448DC6DE163828A97021AD995A
              58083A079B9B6C73D31035AAEE1BD26F5F272C5B7599F0812930B3B454018BD6
              FEB8C549E7D34F01485A2DB2ADAD5D5613A0E8749038361928CB902441E2D8C7
              C3D8957862096268AC0DD38800850117426B43E0020EA61F940BAD5DBE0C04E6
              B7AEB273FD7A65DC9173E7FC75E3F87133B628685FBDEAAFBD383A91E7A82431
              EE3609179A44FCF6D266A170331FF60FCF01BBBBB3F73C4509AAB54A12943B9A
              D92B0B1D84F8C244953F11A6D6703C8340F5C732694A6433A22B9E3A8A4CF04E
              4D11B75A5505B6AF5DABB24CA079F2E4BE9590A07AFBDC3DB4D7CD777646CE1D
              3E0473FC2C9484A12CE44DCD802E4F2AFDF5F5010883A4F2ECF05D7ECEDA9ABF
              EE05D76E1F5D06EE07F82C347DE2C4900B59F0D9D616C9ECEC48538F23B38F3F
              5EF1FDFAE1C3BB070D1D6695694A64B95218FCC3CAEAB24482B915059CB9620B
              7E62EE13BC2CDFDAF259246BB73DE0E6638FB9819577AA243167AA2EDB64192A
              4928CBD2641C4B288541655EBB7CB99A85FC39CF90D69388CB1C49B359D9E8EC
              A2166E758377C7CDA6AFDEEEE8D16172E087BDA2628199471ED917E8502AB9DF
              82CE363749EC297530D0009899A177F76EE55EF8ACB2284C6B8F14DDA18253EE
              C0D368F86DC06DE0A346A312D0C3D27CF45173A1357A69C91C1C773A94F6E386
              FB96E094D441FB40C99C1377323789F8C2A6353A706DA8EED11FA802F5F9F9EA
              B6F38B94084E2CE246837C67C79037DF2DBEA0E5DBDBC4CDE683552069B5F635
              CF057ED26A9960CE73731665BFFC945986AAD528FA7D62A0037CF126F7FF2859
              BB0D0CED0D6CEA74277B1A4845CA18B8053C7E90003A376EEC4A99EECBE53812
              6E659D94EE77100F6B9D4EA634FCE37F05BC4B820D7CE5F7248F008A34DDCD06
              6C7AD640BB2CFF1D23B28CD6DFD83FDA116203D65112A7C0BD95956A8517A1F5
              E493247373A395700980EA5914F6F7AD6EF7AFEA5E9AFE19F8F84015B0E2C10F
              E5FF0ABD1E256E1F117C0F80AA4BDDE974B22F3FFFFC2FE22FBDF4527A7B79F9
              E7A2F51F0F0CB97399A1D6AF64599AE3CA70DB19483C33F4CD456B9A4F3F0DE0
              3F721C11F9CEC20B2FF4FC97FA3BCBCBBF43EB1F1E981223646D656570988551
              A675EAD49E2E54A6E92E0BAA5A0DB4FECDD10B177E0CC1A6FEE8DCDC8F10F9FD
              03431F48C5A7EF27C1395170E4F8DBA379FE133F64D73F7BBCF5D6B7055E07F6
              C5ECD6DF7B6F107896C71C7EF6D9899EE16878E862A2D4AAC04F17CE9F7F231C
              BB6B537FECFCF93F7536364EA3F57711B9047C8CC8AE7F73B9AFEC938A87F3B5
              48BFD4FA3F7951FCA59FE7DFDBACD79F1A060FF05FF527F937C8DBB165000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'PanelYellow'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000009A549
              4441546881BD9AC98F1C7715C73FEF5755BD4C4FDA938CC7C61E139490058508
              119184BF20E2120573F08903484470E008DC124520C429C79C1084338B888384
              9010871C81904540088B6C67F132EEF178B69EE9A5AA7E8FC36FA9EAEE1967C6
              19E74956F5AFE6B7BCF77BDBF7BDB2A82A33F4DA6B69EFDEF5675039AB224F08
              BA0CDC353BD1D18D0FFFEA7EA822222870FCD34FEE371D80DDCDCB0CB657E258
              551101910480E128D7F5ED7CDCBB31BCFEC1B5FEEFDFEF6D3DFFD24BBF5D9BDE
              47A605B87EF195A705791178F8961CEC21808810F6AB0B30D8BE060AA0282080
              AA65B0BDE2DEA82262FC1EC64FB54E305B22C6B0B6392EFEF2F6DACBDF7BFEE5
              EFEC2780F42E9DFF21CA73FE8C03D3DAE5D723E382A02869A3E3C79E77C01623
              372FECAE8AAAF5CC7BD1C4A0B67082F8BF05EDA8C2D299C77FB63A2ABEFBC823
              E7C6006960A277F1FC0BC0F387613CD0E2992766DEADAFFC230AA341B0C8AC17
              6862ECE61A404CEAE7068D5A2041445191678FB7B30CF826780DF4DE7BF52B58
              FD0387BCF9698AA64475EBA89236E628F201F19655410463525AF32728C63B80
              508CFB41166C59D484D3B08446EB6EEE3AFE002A3C7BF2BEB33F17D55F25BD8B
              D9DBC0A347C9B4BB0AF102741C9352DD8F009884B9EE69F2D176E0135B8EE3BC
              62BC1B4D272C6DB4175085DDDDF1F097AFFEFBFE74F542FA14727BCC47526726
              EE14AD9EFE9D6A5971E07D45451060B8B3EACD4BB1E598346BC78B481B730024
              498322DF21C93AA8C278B04166A4B5B0605E4CD5C8D7D823921E94C43313190E
              61C65BA3D4E7D5AF121F71CA12AB2562524C925296390248D27061D5A4289036
              E6E3458937A9CF9C997FCAA07CE9F6D90FD151AB512DC2D4CD6A36DF286A4B94
              B2E6B0C43CA25A908F7728F321653E00A028867E4F4104CE2C351753E0E4C711
              00006F0EF51079FCDE2F0330DA5D6377F33249D60284B218C464A56A110CC664
              8062CB1149D2C49639893449BC169C600969D6C216B957A270ACDB36865B64D8
              83904B585A99C7CC456B64D6DD748DF9604E5E552669BAE8946420501623BF5C
              29C67D8AF12E6539F6EB156304B97EE1950DE0D8C71122D0C6CA3F091284D8DF
              EE9E02759A40201F6ECDAC1393B8D9FEBA9590D5AB6C8C0822C6855655CA728C
              49B22A911D0D695480D44702CDCE2200E3E126524B378AD25D7C208E40E8AF5F
              F226590968CB1C9324315A9924C316E3DB17201F6D4713700E2A042051164392
              B48DA0F46F5E9AC048829064ED89E09E0F373149E62183D0EA9CC4249917C460
              ED189334501C6632490680491B07172020C710594420C93A44D5C7FB84246DBB
              C3BC70F50854D9BD547B99145587959CB3BBF94612072F9246D81E6B73E7477E
              9B436B20466275B759140392D445186BCB704E8D61BFAE06CC50A5C807A43E32
              05A16C9963D256A5D95A6E718C1B4CDA74C9CE96A8EAFE02AC5DFE1B0E1DE28D
              51E82C2C331E6E9335BBF180246D57A10E6A68AA329BE914202231CB062A8B31
              69733E8E93B44977E961B6D72EF8C496C68D6C997BA7BE85062AFBA616E7216B
              766B6654F980B86A243A998BE1820DD1554D34FBC98CECB26A99EF50E6B16C60
              B4BBCEDCB1D3BE1E4828F3A1D718CE81CB1CC4EC2F4038446DE1D3B906B663A0
              4C1BF3336B44C43B1CBE50A95F8A7B2E7CEAD138DF964350180FD667E689A498
              2443604263ADCE09ACCD3126BDB50F0840924654A36A493357A834DA0B7BCE57
              0F21026A4ED2E68409DD7DEA0B354685246D47A69D267649B2C0ECDE20CDA44D
              766EBC7F6B1F08D8842A9EB82A4B6B91648AEE3EFDC589F18D0F5FC7FB7564B0
              4EC3FEF59A5939A1D3C61CD65A8C31589B33D75D66B0BD82A99DD95FBF144D78
              5F01EE59AE30DE78B0114F7160EB60F0B58A403E2F4F093E054EA39F8971FE12
              ABCCE8376161A5ED0385D1BDCCE56024316C3A04B90722552846DB34DA0B8808
              59EB1801F4A14A31DE8DB79D8FFA64CD0E8860BDF4470C25A6D80B4E2C492D5B
              D7C4F3D79FB5BA35F3F24043617BED02530B28C6BB585BFAB5AE86FE04482B33
              98FE4B5587C6A7439CF5B921A159926CAE82267A1B99F820646DC1CD2B6FFA9B
              941806A0D604F314FA47B61C7B0195CDDEBB15E09390C51310E391ABBB106BED
              9D11201C1EF245B8B17A85361DC7065B57271B5A351851452A1BAB33553026B9
              532654537F0DCC555E50A5C58915AA0C776E40D49847B03ECBD7E05F34C9190D
              6CADFEC79F5B2DEE2E1DB8CB384115289B166DF2FE377BEF4ECD905A8557B51D
              010FE22C62128CC8AC0654D5E36E619F7CF591A401956AADC099DA4CFCBF8DEB
              EF10ED04ADC0506DA26269754E386883624CE2A7EE9507C4C3E4F18E4BE933B1
              FB000210208344A64C9A5536E499DC5AFD2FEA730128E578586782B0E0D8D243
              2830ECF71C402C73244911F6D04028051DF395431E86C20A5B8EA86ADD9A7493
              B89BB2D805206DB427DA3201500DFBABE483CD6A7F8FCFF6F481D09B091B1D14
              364CECE1B9749554C8C2A68A46B183E71E693AE7CFD6586B7416EE8D8970B873
              C3EDE9B5A2650149EAB0D3F4E1C74E7CEED00C4F53E84A87DFFD8DF7A7DE0BDD
              E30F568DAC98CD84EED24314A31D3792A9FD54C1240EE1E272C71DC903266DC6
              DF2EFE3B26557442B8D6FC5205D59D9E9C469A1D3656DEA9DF88539849711AF5
              7E75F46D95598AE62FAE7D9E669D1A4C05F56631ECF700DF3C08216A5A432152
              0513D74F040B5579396D74AA0043E0432846DB53C582C45565310CAF22F3AA36
              A6E74F04CCC57A6022BF56CFB47917A1255F16C398BD436BD19623CA7C84F59D
              88D0A9F35148FB2047D25ADC8FBA4B0FED2319DE2F88C55292B6226C08C1AA5E
              F8880898C4BD544815B926B07CD44C3B9B0E4D00E7A0ADF91313735AF34BF1F7
              60FB7AF41507A973CF315E234120B7A7B5055BFDA24C457813E5F1A31680C87E
              F0825BE793D0A9083D9F8D95BF63ADDBA5AACF5D3B515521C9E86D6C5C4DC572
              5E856FDF090104211F6D9135BB91FD9B57DE8A5E1C42EA3DA71FABD6C4A81310
              671D4E1323130A1F5CE9FF295DFA6CFEC7DEC5F41D90CF1FBD08EA99D7890225
              A8663ACB0710E8060A92607C1816111ACD2EA0CC759729AD5D3BB9587EDFC0B9
              52547EC047E9F8B628A42999796DFD878A6972CC86AFF6129F6A8B8A45819B1B
              831F9FFBD60B37E397FADEA5F33F426FEF43F76168FDEADB1330A36E42AA1E86
              FB76A2AAB2B3FE5EBD1202049B1EFFCD838F7DE31C50E58113F79D7D41547FC2
              1DD1444501063886A74CC88746F715A6A63909A959F8D7FF56FF9C37E7BE1EC5
              99F9CF1E977EF78CA87D1178F07699749D6DA8079FC5331F1DE8820642B1E28A
              AA24BCBB2A22CF2DDDFFD55FD4D7CC0800C01B3FCD56EF593AAB2A6781277179
              A27D6001AEBC31090D44585C3EF4D7DC11700DF42D515E2DE6B25F9F3AF5F4EE
              F4A4FF03607E3F5FE0D5625D0000000049454E44AE426082}
          end>
      end
      item
        Name = 'EmptyFrame'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000FD49
              4441546881ED9AB16D02411045DF984BB1A8820A4888E98622EC2E1C5289899D
              50013D20909D627D071CB0DC09094B88BF42F3A409767683FFA4DD682724D125
              225E81416FC3CBAFA4EF5E5712AD4403BC035B4095D6B6CDD89C7217028B0A02
              DE5A8B0B01605241A8FFD644120D07A65CB2067EA88B21302ED6536075141875
              0ECF252D1F12EB462262067C16AD11C08B27CEFD48013729E02605DCA4809B14
              7093026E52C04D0AB849013729E02605DCA4809B147093026E52C04D0AB84901
              3729E0E6F84BB9EBF43F22A2C66FD6921D9C05BE3A9B63EAE790F929460D8A61
              8F37605341C06BB569339E863DE2CAB8CD90F3F5AA85BDA4DEBBFC03CB7F27B7
              E14568E20000000049454E44AE426082}
          end>
      end
      item
        Name = 'SquashedEmptyFrame'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000010849
              4441546881ED99B14A03411445CF0B694549DA40C8B7D80B7EA1AD56FE807E4A
              52F9018A2495785364B2AC23C282E09D9177E0C1F2D8E21E7699626E48A26766
              EE00BF2505DC742F30AF171131032E0D59A6F026E9F3CB4612E5245A030FC001
              50A3732819D743EE127E09EC1A08387576C052D2F00BDD009BD18779073E688B
              3970519E379C32DF9D0556D5CBB7929EFF2AD91422E21A781AAD56F00F4EA114
              7093026E52C04D0AB849013729E02605DCA4809B147093026E52C04D0AB84901
              3729E0E67C3BFD52ED1F23A2C5EBF531A7CCA5E058005BFCC5C5D4D9028BA1A1
              19554CF7C0BE81803FCDBE641C2AA6A89BFA8808E08A36795515F89B406F747F
              0AA5809BEE058E0F46ED819752043A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'EmptyCircle'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000042B49
              4441546881D5DADBAB55451CC0F1CFEC08F39CE32953A8EC669EA3584222FAE8
              8B4210410F053D940F859C08EAB10B841045F454507F4237BA3D541405512AA5
              6625995D244D8D20F34A6A69592F4E0F6B6FF7EC716DDD6BEF7DF639FD60C1AC
              3533BFDFF737F35BB3D65C428CD1644908A10631C6339366A31F0E8410E66135
              5662311661362EA917F907C7B107BBB1191B638CBFF66C3CC6D8D58561DC5F87
              3983D8C5F5051EC468D71C5D808F601D8E76095D761DC753B8AC2A4FA5100A21
              DC85E771759B2207F10DF6E28022742842691EC6B0AC9E2E93C37834C6F84AC7
              501DB6FA285E53DE7ADFE3312CACD08B6378043BDAE87C1BB3FB124258A078F1
              CAE2F756F581A08777E9166C29D1BF0F8B7A72004BEB61912AFE0313A8F5029E
              D909B857F12EA4B68E6079570E60613D265385DB31DE2FF0129BF3B12DB37914
              8B2B3980CBF173A6E8638C4C167C627B181F66B67FC19C8E1CA877E77B99828F
              3063B2E113868BF141C6F07ED9FB56567922ABF8158607059F700CE1CB8C65E2
              BC0E608ED60FD431DC3068F884E7DA8CE777CC3D9F03CF651EDF3355F009D3DD
              19D3B3A50E602E4E2505D74F357CC2B63EE13A99F6424D5326EA2340439E307D
              645D921EC1DAB37789973F6A7AB975AA5BBDA4173E4FF876B6F44008E166C57F
              7C435E9EC4D6EC565E4DD237851096E06C08AD4A3223DE191455057937BB5F4D
              D3819549C69E18E3A18120559018E301C58CAE212B693A9086CFF64141752129
              DB629A0E8C25197B0786535DF625E971A88510863033C99876E193C8E1243D14
              429851D33AF6C3DF0304AA2AA7B2FB59B5D262FF23A939D7ABBC47A693CCCAEE
              4FD6628CA7713A7978E50081AACA1549FAAF18E3BF8D104AC7D7F10102559574
              B4DC437318DD95642C1F184E7549D976D174605392311E4268B77035651242B8
              466B0F7C46D3810D59F93B0701555172A68239F95DFD4EF37775DB54FF3E97FC
              4EA7CB2D3BCA26342F26E9152184F40F754A2584B01A2B92472F9D4D251E5E86
              139A5E6ED6E3B2619F5A3ED4591A5C2724ABD879E167B44EA0D74E0307EECB98
              9E6EC9CF0A8FE237AD13E8B6CB7A03801FCBA2E2906C0FA1ACD29ACCE36FF5B0
              83D203FC2CC55E43CAB2E69C726D2ABF9155DC889903849F814F3286B74ACBB6
              5130AAF8D2A50A3ECDBB6F125B3E87FF099776EC405DD1FCEC7D88F801374E22
              FCA27AC8A6360F61AC6D9D0B285C82FD99C293780817F511BC8607F06766EB20
              969EB76E07CAAFC7CE4C71C4D7B8BD976F457D8CBF4DB1029EEBDF8D0517D4D1
              A1A111C5D72F3712152B7AEBAA84966245E1F17A4896E97CB3D391AFEA36EB1D
              7801D7B5297244B1F4B14FB1CDDA985F0FE12AC55C6399D689492A07F1708CF1
              F58EA1BAE8F66145EB1D51DE7ADD5CC7F0A42EBE37BDBC78C38A15ED4DBA3F6A
              B0558F470DFA79D86395E6618F858A8DC2C67AD369AD873DB660438C717FCFB6
              FBE1405BE503386EF31FBA98A7DBE2E9C64B0000000049454E44AE426082}
          end>
      end
      item
        Name = 'HeatStatusClosed'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000026D49
              4441546881ED99CD6B135114C57FB706416B05C1EF5D8B7413D4852EFD2BEC5A
              5C59150445F06BA188E0BF50A41BC16D57FE0582151742C14D28225A0B7E15B5
              76935AD4E6B8C88B4E8789B1EF2313610E3CF2923BF7DC73F2E6CDDC4C4C12A9
              60660BC0AAA47AAA1A43A988FB852406CCAC666687816DC00E33AB9BD99614B5
              90146D00E3C07D6019506E7C02A681D1A835230937E036F0A340787EAC015706
              C68013FFE01F84E7C7BD413170D3437C675C0CAD6F4E8417CC6C0C9807B67A52
              34817149EF7D35845E85AEE12F1E6018B81C22C07B05CC6C08F800EC0D11002C
              481AF34D0E598131C2C5038C9AD97EDFE41003070272F338E89B1862E067406E
              34AE1003DE578E985CDE06242D028BBEF91934247DF64D0EBD8CCE04E6077384
              DEC8F6012F81114F8A2FC021492BBE1A825640D21270C9371D381F22BE232246
              3F7487CDF5402DE0EA4034731913A7689F12BDC42F0113D1EAC62272267601B7
              80E705DFF81C7003188959336813FF0D66360CBC00BE014725ADA6A893EC47BD
              A426ED5F68DF538987EAA9444F74F64032542B50362A0365A33250362A0365A3
              56B680CDC03D8B7AE6DE36249DAE99D91936AEC447490F5D421D3851C0352369
              D9CC0C982C8837243D71F3ED6676361797A4695763373051C0F158D2BC3BE624
              B0C7E93CE6E23B3B07AEB3B1F57D9A698F2F50DCD31F71F15A97F8948BBF06BE
              16C45B991AC7BB704C668E992B883725F5A5174A8A1A708EDC2994993F72F13C
              DEBAD7F52EF14666BE025CCFC5B3C6DE74E198CDCCEFF2E7149A729FBD83C0A7
              12BD6066AF803545FA97B27013C720EE1724B568EF99DFF8EFEF039581B25119
              281B9581B2D10F039692FC17F2E9F70F0559D0AA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'HeatStatusRaced'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000002F749
              4441546881ED99CF4B155114C73FC7942053C8A0C8858B88B4A885441BA13F21
              AC68D1A285D5C25A654111AD8A5A441048AB366DDAA4B4AB8DD0A268518B20C2
              5685BA909796228951FEE8E5B7C55C631CE795CEBDE3F3C1FBC2E5DD9973CF8F
              EFCC9D7BEE3DCF249117CCEC333021A93D2F1F3579195E2FE442C0CCEACCEC20
              B0196830B3FD66B6290F5F480AD68036E011300D28D1268007404B509F8102AF
              016E03C594C0936D16B8B46108B8E0FB4A04FBCB3DF5F3C04042767FA310B8F5
              8FA7BD005C898D3D021462F20B652500B4FE67DA2C23E0745A8031279F0176F8
              C4E0BB0A5D03D6B4BA481A05CEBACB06A0C72780CC04CCAC1638914557D200F0
              D65D66B2B1049F37B01768F4D07FEA7E5BCDAC29AB111F02BB3C74018663FDE6
              AC467C08143D7401EA42D8F22130E6A10BD10A06D16A94D9960F812160328BA2
              99D500C7DDE57B49335983C84C40D1A2FE38A3FA69609FEB3FC91AC352203E89
              AC1998636D89AC9D288109F80A34942D91491A639589C8CC6ACCAC0B784594C0
              16816E49DF7D62F0DE0BB9A77A87F4375004FA81BBC0C7D8FDDF04DA910621E0
              489C21FD1C906CE3406730BFA10C39124DC00D603011F422D1D6E12AB035A44F
              738E83C3CCEA8111600A382469360F3FB91DEA25FD20FA06E6F30A1EAA558955
              61314FE3D537506E5409941B5502E5C67A10B06086A2ECBE0C791308B64F31B3
              3DC088995D8CDFAFA429B40D98077ACDACCFCC1A217ABDDD898163929E01B81A
              7F478AB17E49D3AEB8752E453E28E98D9915809FC0BD84BC28E9A1F3B1133896
              62E385A44F6ECC49603B504FB46D3F4054AE3F0A2BF7EB2F63DBE3CB2972016D
              4EBEA584BCD7C90B44BBD1A47C2EE6A3A3848DAED8980F29F24560BC92A6502A
              6A896AF771C46B34CF53E4005FDCEF4209F960AC3F055C4FC8E385ACE112365E
              C7FA375939852681CEA027B294135A017817C8D661609468FAF4018D927F797D
              35089507BE11FD69D823E9945C31AC3690F152089607240D99D96E77D2FB8B8A
              FA8893C143851148439540B95125506E54521E48C51F20E14C0B107BB6AD0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'HeatstatusOpen'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000030E49
              4441546881ED984B4855511486BFE5832225A1171641134142B382C041513408
              6A14E230A881840D828810AA4961348868140D02074D9A944118619320A888A0
              419983CACA2CD2A8C85EF6F0715783BD6F77773C27BDE7718F17EE0F1BD639EB
              F99FC7DE7B6D5155928288BC063EAB6A535239CA920A5C28244240442A45640D
              301FA816910611294F2217AA1ADB00EA810BC027403DE303701E58156BCE980A
              17A01398F029DC3B7E0187E60C015BFC45A7C029E02AD0066C06B600ED402F90
              71ECCECD1502C79DA29E01EBFF63BB1178E3D8EF4F950050078C3BC52F9E85CF
              4AE0ADF5F906D4A649A0CB16920136E4E1B7CD790BA752210094DB994581EB21
              FCEF59DF812804A2AC0375C0122B5F0BE1DF938D23224BC3161185C072477E19
              C2FF8523AF085B441402938E1C6695AD0C889517A2101876E4FA10FEAECF70A0
              D50C8842601033A703B4E6E3282202B4D8CB3E551D0D5B4468026AA6926E7BB9
              4944B6E7E1BE0B68B4F2E5B035640B893295D602DF31D3E17BA06E163E6B812F
              8ECFC2D416325BD05E728BD247A035C0AE0CD80D7C25B7F8F9DAE633C4068F04
              1139091C756E3DC6CCF30398CDDE6A6027B91F57810E553D133979D427E03CE1
              3DF8F701DEF10E68892D6F5C812C8945C031E091A7E80CF000380C54C7993396
              4FC80F2252053CC77CF3EB54F5671279126BEA55750CD3A1FD4EAA78289D4ACC
              88EC3F90184A6F206D9408A48D1281B4515404ECEAFE0F8A8680885400BD22D2
              2D2235D9FB454300A8027E60DAD7FB22D20466AFDEEE311C51D51E001169C49C
              677A7149554745A40CD3D078D1AFAA77456408B31F3AEDD14FA96A97CDB18C5C
              7FECE296AA3EB536AD98332801B65A1219A003A6EFD76F3BDBE3033E7A051AAC
              7E5E80FEACD50FE1DF234C38399A0362B439360F7DF4E340A6107BA1445101EC
              F3DC1B71E49B3E7AC89DE34C04E8FB1D791438E2D14F39F260408C3B8E7C82E9
              9F10C0C1583B329F0EED15E6DC278E5835C00DCC5B7D0234A9463BDC2D34C680
              05C015A05955FBC07C424501559D14911DB6D3FB8B627A03788B872223E08712
              81B4512290360A4140920CFE0779E15AF2295792740000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'HeatStatusClosedActive'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000031549
              4441546881ED984F48545114C67F67668C62402AB0A86591A1931654BB36AD83
              828256116D2C5D18154468C5CC804651102D8A20DAB4AC28DA4710E12208219C
              D121084DA82C2A0A47A569664E0B9FF67C3D1DBBF73DA7623E78CC7BF7DC73BE
              F3CDFD7F4555090DE9C408902799DD12164524ACC04B0509A505D2BB6394C69A
              88441E234C51620FB9C11C77B5143455B002D24D8D20DD207B515679AC9F107D
              087A81E4D0485094C108101192CD29A01B882D5C97EFC03992D92BF6C4410898
              4EFE0E70A8625D0564F6EB26A96C871D791083389538CF62920777F200EDA413
              C76DE9ED5AE07CCB46A2E5416099193B13147413BD83EF4D53B06B8158E90CB0
              0CD3FF40895327A76C5230177050A2A8EC03BC5DE34FB1DFC6D95CC0E6A60DC0
              1A1B72071B38DBB2D6D4D95C408C75C6BE5E44CBEB4D5D2DC640B468EEEB45D9
              38968580E23B735F6F288C63990B48E5DE00A346BE7367AD0C17863E9BA6612E
              405511EE19F9BA672D11B3180EECD68142E43290B788F089A9A96B3629D809E8
              1DF880EA89DFCAFD16366F99A2887470F1F5379B14ECF742E9C1DB203D73CAFC
              16367799A2A0674866EEDBD207771E48371F46E52AB0BA42CD8F48A483E4C083
              2068833DD074B5AE6279B9132D1F00699D2D579488F403F7992C5EE7526E3C28
              CA708E9400A7B7C689175F214CC08A6D245F4C864113DEA1FEF2CB09841F4021
              ACE4E13FB895580201520E337AAD05AA8D9A806AA326A0DA085F80AADD9D4505
              842B408D6F8C168D852F62FF3288481478EE7C6654F5484C448E3277B73EA6AA
              8F1C8704B0CB27D63D55FD222211A0CDC79E51D53E80F142395E2F72CC632FAB
              EA2D87A301FFCBADA7AA9A73EAEC071A98EE31DB1D7BFD6C30A6CF4B334F9FAA
              E2EC523B3DB699A7C5B1D7CD63BFAEAA68B27978F464E3171F7BC9C5B1739E18
              6DAE3AFD3EF6BCAAFEFBB3500C68C7D3855CEF4F1CBB176F9DDFD23CF6CCCCCB
              CAE591AF4097C7EEDEE08DCC13E399EBBD875F5DE88653F60EC23CD000A412C3
              409E54B6258870BE833888C00BB35ADE5DBBA0AA256087BB2CDC312012FA3AF0
              CF0FE29A806AA326A0DAA809A8080D6E1DF0C34FA50E21238B5F68E500000000
              49454E44AE426082}
          end>
      end
      item
        Name = 'HeatStatusRacedActive'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000003A449
              4441546881ED9841681C5518C77FDF6403290BA6558AD48BD0426B76BB55040F
              4229F4260A29342808564FD5E6104141624DE3ECD21A2AF1500F1545F0E0C183
              29163DAB20DA9E4A41926D572124555ADB92164B4DA3E9EEFC3DEC6CDC2C136D
              E6CD6489EC1F06DEBCFF7BDFF7FD67BE37F3BE6792480DA5FC2CF0077E79675A
              2EBCB40CAF152C953750DA9BA176B50FCFFB1A63811ACF50B950E173D5927695
              AC8052DF76B0B790ED0336B6B073984E83C6F02FCE26E532190166869F2B228D
              60D6F5EF63F90B38825F7ECFDD711202EAC17F0ABC10C106A04F909DC3631F01
              4F6158C87D48B13CE8E63C89455CCC8F121D3CC884D90CA5F247F8E5A7F1BCDD
              18BF86EC214AF9575DDDBB09182D6C431ABDE7F1FEE459EE569FC4EC72D833C6
              486E8B4B086E0232B56120B3AA39C77EBA4CA097001059BAED759710E20B78CE
              BA900DC49A5B2A7F033A1BDEED8F1D032E0276F46D05EE8F3D5FDE57616B2B23
              8507E39A892F208353EEE231BDD4EE0A1E8A6F2636BAAAB87C8103BA9B6EAA71
              CD3808A85E59FAA2C7F2AC1DFF98E24A6C33B10328562E217E8B35D7CCC01A8B
              778AB18B37E286115F80243C3E8B35B7987F1EA90080D944EC1870FD0F2C7AE3
              480BAB9AF3765F01F820BC9B6361E17D9710DC04BC33790D18BAA7B1F53DD301
              3CEF07A45E84301BE4F8F42D971092D98D16771E453A12B1A8038CD3C8A641FD
              C02300088186295D1877759D5C3D50CABD4860273036FDC7C8EB9837883FF945
              126E932D680EEFDA444F30848201B05D4BFD4278761E38C59DEA49DEADDC4ECA
              653A2525C01B8F66C9567FC698870D8FE19FBB93869BF48AFAF11FE731EE028B
              69050FFF835389351060419AD63B6FA0DDE80868373A02DA8DF405482E75DB32
              9859B6B52F5D0172AA9A97C1CC1E06A6CD6CD8CC961ECA7A4AA107803F81E3C0
              8499F50264CCEC6558B693BF2AE94B0033CB03BB238C4D48BA69661E7030829F
              927406E0F66290BDCFEC95163E90F471E86333D1875BDF49AA8463F6039B8113
              C0016000D86366FD0001A0A6EB8C24C25DEA500BD7B80A21DFBD027F5212F273
              33BFBCB6FD66045F6BF2F1C40A360E368D391FC107C0F5F5944291C800876849
              A1A6F6B721DF8AC6E9726D057EAAD1D8D8E3FD0E1C6EE19B3778B32BD8F8BEA9
              7D8C7A0A6DA09E428F0373403F8DD794CAE5E766E4E72693B015063D4B3D7D4E
              01BDF5939DB4614EE777CDB801F4006F02CF4ABA05AB3DDB5F2DCC4442BF0249
              97CC6C9BA4F9E6FE75B5885B83877526200A1D01ED464740BBB106F54062FF81
              48FC0DCF39CEEE4CA6DDEE0000000049454E44AE426082}
          end>
      end
      item
        Name = 'HeatStatusOpenActive'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000003E749
              4441546881ED985D681C6514869F33D994D285D68211B478556BD2CD36B95324
              57BD9282586D40FC41F1426D152CE4A29668DBD985884A45C4DF0BAFC40BA16A
              95E6C25E1441889442A96836EBA6B1365AFA07A1DAA64949DDCCEBC54C9A7599
              4D9AF96948C90BCB7EF39DEFBCE7BC7CDFCC9C332689D45068FF13B842616853
              5A219CB4886F152C951D286ECE307D61238E730498C4E3112AE50A07349D74A8
              6405EC6D6B25E3F4823D8A585B671D030E62DE5BB8BF8D261532190166869B2B
              00AF0399B9D73205ECC11D7A377EE02404981985DC17886782190FA31F4FFD38
              8C302DC39C368CC7100F6358E0F7296EE99578C19310E0B6BB18059F8D11D093
              B8E513A16BF7E5BB68D297887B01103B290E7D18277C3C01C5FC7DA032A219F8
              1DAB3E843B3C36A7CF9ED67534371F435A8731C1756DE0CDF2F9A829C47B8C8A
              DD88668430E7A9799307E81B3E0BDEF3817F96154E4F9C14A20B78C29A30B606
              2C8771078FDFB4AF5B3E82D951FF42DB22E7401C01ED6DEB915A00F0D41F81E1
              1000623DC5CEBBA2A6115DC03477D7D0FCB1607F4FA76AC8EE899A468C7BA0A9
              3ACBE2352D3CB235CF5E78D5C60BE7A189EA88AAE766E33BAD0BF7578D8F73AE
              F1C2B9115D40DFF028C6199F45DD0BF23533CC1E0FC683B8A54B51D388B10312
              E22B7F4C176EFB969BF6DD977B1AC92FB1BD802322E2BD07CCF603577D26FB9C
              BDB90DF3FA143775607C125C8D3175ED833829C413E0962E60F25F44520B193B
              8A9B0F3F4E45737073CF823700AC4608D90EDE3E75394E0AC954A3C57C1FD21B
              B3AC3688D48FEC240E86D888B1F5C68D2B84C36B4954A4C9F503C5DC7360EF87
              F4017511B988A7972996BF4D226CB20D4D6FC75A567AAF22AF1BACE3C6BC108E
              9D00BE66B2FA31EF54C6930A994E4B09B0AB33CBAAEA087095F12B9DBC77E65A
              1A61D26BEAF7FF3281F12FC6545AC9C36DF05562EEFE352E0C81A5F8E1E936D8
              8165018B8D65018B8D6501B7126696AD9F5B3202CC2C037C6F66DF98D99A99F9
              252300C80293C036E098995F2C66CCEC25083EB8FA382FE9108099E581AE10B2
              0392FE3633077831C45E92F413C0F8D47476B5D9F63ABB27E9B320464B90543D
              7E945409D674037702DF0197816EE0B899ED0250DD6F40124195BA33C42E201F
              D85734B07F24091572A37FF5DC7F29C45EAD89F140038E176AD6FC1C62BF0E78
              E91E21916A1D047E31B79DBA235433FE01D811E27736F8AF36B097660677AC74
              FE017AEBEC5ECDF874038E819A711FFE11326033FE1102E861669B52F9B9B9D3
              7273834970016B80C3F8C7A70274485A524FA109601570107850D2AF90763F90
              202455CD6C8BA489DAF9A5B403D4270F4B4C401896052C3696052C36D21760FF
              7BCB278EFF00E431FC29F7CB25550000000049454E44AE426082}
          end>
      end
      item
        Name = 'HeatOpen'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000042B49
              4441546881D5DADBAB55451CC0F1CFEC08F39CE32953A8EC669EA3584222FAE8
              8B4210410F053D940F859C08EAB10B841045F454507F4237BA3D541405512AA5
              6625995D244D8D20F34A6A69592F4E0F6B6FF7EC716DDD6BEF7DF639FD60C1AC
              3533BFDFF737F35BB3D65C428CD1644908A10631C6339366A31F0E8410E66135
              5662311661362EA917F907C7B107BBB1191B638CBFF66C3CC6D8D58561DC5F87
              3983D8C5F5051EC468D71C5D808F601D8E76095D761DC753B8AC2A4FA5100A21
              DC85E771759B2207F10DF6E28022742842691EC6B0AC9E2E93C37834C6F84AC7
              501DB6FA285E53DE7ADFE3312CACD08B6378043BDAE87C1BB3FB124258A078F1
              CAE2F756F581A08777E9166C29D1BF0F8B7A72004BEB61912AFE0313A8F5029E
              D909B857F12EA4B68E6079570E60613D265385DB31DE2FF0129BF3B12DB37914
              8B2B3980CBF173A6E8638C4C167C627B181F66B67FC19C8E1CA877E77B99828F
              3063B2E113868BF141C6F07ED9FB56567922ABF8158607059F700CE1CB8C65E2
              BC0E608ED60FD431DC3068F884E7DA8CE777CC3D9F03CF651EDF3355F009D3DD
              19D3B3A50E602E4E2505D74F357CC2B63EE13A99F6424D5326EA2340439E307D
              645D921EC1DAB37789973F6A7AB975AA5BBDA4173E4FF876B6F44008E166C57F
              7C435E9EC4D6EC565E4DD237851096E06C08AD4A3223DE191455057937BB5F4D
              D3819549C69E18E3A18120559018E301C58CAE212B693A9086CFF64141752129
              DB629A0E8C25197B0786535DF625E971A88510863033C99876E193C8E1243D14
              429851D33AF6C3DF0304AA2AA7B2FB59B5D262FF23A939D7ABBC47A693CCCAEE
              4FD6628CA7713A7978E50081AACA1549FAAF18E3BF8D104AC7D7F10102559574
              B4DC437318DD95642C1F184E7549D976D174605392311E4268B77035651242B8
              466B0F7C46D3810D59F93B0701555172A68239F95DFD4EF37775DB54FF3E97FC
              4EA7CB2D3BCA26342F26E9152184F40F754A2584B01A2B92472F9D4D251E5E86
              139A5E6ED6E3B2619F5A3ED4591A5C2724ABD879E167B44EA0D74E0307EECB98
              9E6EC9CF0A8FE237AD13E8B6CB7A03801FCBA2E2906C0FA1ACD29ACCE36FF5B0
              83D203FC2CC55E43CAB2E69C726D2ABF9155DC889903849F814F3286B74ACBB6
              5130AAF8D2A50A3ECDBB6F125B3E87FF099776EC405DD1FCEC7D88F801374E22
              FCA27AC8A6360F61AC6D9D0B285C82FD99C293780817F511BC8607F06766EB20
              969EB76E07CAAFC7CE4C71C4D7B8BD976F457D8CBF4DB1029EEBDF8D0517D4D1
              A1A111C5D72F3712152B7AEBAA84966245E1F17A4896E97CB3D391AFEA36EB1D
              7801D7B5297244B1F4B14FB1CDDA985F0FE12AC55C6399D689492A07F1708CF1
              F58EA1BAE8F66145EB1D51DE7ADD5CC7F0A42EBE37BDBC78C38A15ED4DBA3F6A
              B0558F470DFA79D86395E6618F858A8DC2C67AD369AD873DB660438C717FCFB6
              FBE1405BE503386EF31FBA98A7DBE2E9C64B0000000049454E44AE426082}
          end>
      end
      item
        Name = 'HeatRaced'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000042949
              4441546881D59A4B6855471CC67F73456C93781BAB457CD4066F95504111DD99
              8D0137EE5AE842B210E49642B76D17C58DAE152A94EE2B8A8F2C442AEDCA07B4
              DADA16DA28B5350D29A5D53C89A6C690AAD1BF8B999BF3BF937372CF2BD7D30F
              2ECCB933F39DEF9B993333E73FC788088B05634C0940449E2DDA3DF230608C59
              0B74035D4027B0195801BCE48AFC07DC0706807EE02A704544FEC97C731149F5
              035A81F79C986780A4F85D073E00CAA975A410DE061C04C6538A0EFBDD070E03
              ED49F5241A42C69877814F81751145C681BBC00C300B2C017AB143692D5001B6
              BB741846818F45E4446C51315BBD0C9C22BCF586813FB1E37C5E7E045F05F808
              E88BE03C07ACC86508011BB10F9E7F937BAE95171C1E31F8F700D742EA0E029B
              331900B6B916D6C48F49F0D0C6EC6103ECC73E0BBAFE18B023950160931B939A
              F0515CE1490CA87B76003F791CE340672203C0AB6E5C6BA2A749C52735E0EEDD
              0A7CEDF1FC05AC8C65C075E7971E41DA793EB101A76129F095C77501B7F03632
              50F52A3E492B3EAD01A7A305F8C1E3AB2E68005849FD02F5388BF82C069C9ED7
              3D3D13C0AA850C1CCD2A384F034ED33E8FF348A8016015F050157C5004034EDB
              25C539A57BA144802A7606A86139C5C141956E030ECC5D2997BF13B81C2287D6
              27A71E70FABE53BCB7EA7AC018B315BB8FAF61496E6D971F4EAAF45BC6982DC0
              DC10DAAD320578AD59AA12E0BC77DD0D81812E957117BB98150A2232847DA3AB
              A10B02037AF88C364B540AFCACD29D1018A8A88CE9A6C9498E41957E13A0648C
              69015E5619B34D95940C7A74B418639695A89FFBC16EA48A8A87DEF5F25268B1
              FF114ACC77F5E4450889097F7730551291196C14A186222E6235AC56E9691179
              541B427A7E2DD21EC8879E2D072098466FAB0CEDB268D8A1D2B72130F0ADCA58
              877D852C148C31EBA9EF816F203070D92B3FD60C5109F18E776D35ABEDEA4D8A
              BD9DD6E196BEB0179A2F547A4D0E2D961B8C31DDC04EF5D7F1B99472D80E4C12
              B8FC9702F40076677C55714EA2A2D8733D202293C0E7CA65D95578D1D80FEC52
              D79F39AD169EDB32F67DA0E636534C888C3D809D75F4A818C13B4308ABD4E389
              481C0FCDC3007641FDC5E3EB99572EA2F219AF62C3307A9E068065C0458FAB37
              B46C044119BBD269825451BA942DEF8BFF037825B60147D4E13D0F82DDF42D9A
              01ECE9E60D8F6304A844D66940B805B813F24CC4EE8D98C24BC0FBCC8F060E03
              DB16AC1B83FC0DE05688B8F1383DD280DB007B811F43EAF6031B1BEA8BD9426D
              D8D52F4CE410F01B36721CCB0036A2F009F06B04E759629E1D273D667D1B3806
              6C88283201FC8D8D6CCC6267935E6CAC7F0D3692B09DE82DFB30F0A1889C8E2D
              2AC52CD18A6DBD31524EAD21BF7BC021529CD82736E019A962DF25D21E417D4F
              C64F0DF2FCD86337C1C71E9BB00785B578D30CF51F7B5C032E8BC89DCCF7CEC3
              402479133EB7790EEF6A4B011868CF240000000049454E44AE426082}
          end>
      end
      item
        Name = 'HeatClosed'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000003E749
              4441546881D59A4B6B153114C77FB9E2B3F55A6B051FA0A2B6140BBA70DB8D7E
              0317AEDC49DDB8151171A3886BFD088AE06BE142F7157CE06321F8EAC3AA14AC
              B6DAA7B6A5DAD61E1799E99C49E7DA9BE99DE9F50F07324926F99FE424939C33
              4644C80AC698028088CC65D647251430C66C030E03AD4033D0046C04D604557E
              01A3400FD00D3C061E88C8E725772E22A904A8014E0464E6004921CF80934031
              358F14C46B8173C0604AD249320A5C00EA7CF978999031E6287019D85EA2CA10
              D00FCC002B0201F813C84A600BB0B9C4FBDF80D32272BD6C52658E7A11B841F2
              E87D025E006325CA4B8DF873EC9A482ABF0B6CAC880901BBB10BCFEDA4AB44BE
              AF74021D09F91F81A62529001CC09A846E781C785501E2AEBC047E3879DF8183
              A914001AB136A91BFC008C64403E94E184591D049ABD1400EAB1B6AD1B7A8B5D
              9C59910F651678E3E4F5029BCA520030C03DA78177A4DFEBD3C81CF0DAC9BB4F
              F0E15D4C8136E7C5F7C1A8E4455ECF846B4E6DFF5400D844FC033546B636BF98
              B8FD0F030D9A738138CE020DEAB9177BA6592E6C00F479A91E3813ABA146BF01
              9820D2D65D48CB297A3D8CA36641CF401BF6801662ADCF50658C352A5D0B1C9F
              7F5233D049A4A54E578BE8AFF5BBD80C1863F663CFF12126D30E55869850E97D
              C6981660DE840EA94201F6E5C5CA032EA7C31029D0AA0AFAA82EFB0F5183E516
              A2152205B4F90CE7C528058654BA192205F6A802C98D8E3F34B7BD000563CC3A
              E226B332574A7ED0DCD61963561788EFFD6EA56A83CB6DBD7B94F8EF5020BEBF
              823D05562B5C6EE305119902A654E64C8E847C31ADD29322F23B34A11E556072
              24E40BCDAD07A26DB44B15E8E374B541FB93BA2052E0912AD84EDCA4AA0593C4
              1D6A0F2152A0DDA9DC9907234FB89CDA215040443AB0179810EB7322E583A24A
              BF12916E2076A1B9AAD28D58B74AB5E023D6651FE2DA7C4A5D68EA88FB37ABE9
              52A32F3363282FB6EB95B8E4BC98850BD157DCBBF9C57FB9558AC017557982E5
              75AB8C023FD5F3004E0C21C9B175CC69E413CBE3D89AC1FA6275DEB1727DA3B7
              9C17BBC8DFB5E8BADCEFF838778B01695789E91CC8CFB27003790F6CF075AFEF
              22BE1E04EBA91BCE90FC2076CBD47903C09EB4018E16EC455A37384176018E71
              27AF1F38902AC0A194D88975AFBB1DF62498591AE928D14E37B07B517E8B5508
              94A8C57EFD9208F462837C3EA635840DF2B94194506E5366ECD837CC7A04B802
              EC28516504F88ADD020B2C0CB3AE02B662DDF849E8074E89C8CDB24995A3A533
              1B355837FC772A67FF23C0795244ECBD15701469C3DE25D27E239EB2C45F0D2A
              F9B3C721A29F3D1AB1C188D0DF3445FC678F2740BB88F42D6CCDB3EF4A2850B2
              F11C7EB7F90B41CC22609172CA630000000049454E44AE426082}
          end>
      end
      item
        Name = 'HeatStatusToggle'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000004C249
              4441546881D5DA498C55451406E0AF9AB90D882284044D50346242E218254189
              386C5C316C346ADCA821716134C605312E344617BA70809510656190A888B832
              4220888A0281B482016999A591590619A45C5435DC6E1EDD6FB8BC8E27A9D4EB
              7BEBFC75FE3A55A74ED5ED1063F47F9696BE36A051E95F4DA310C2584CC583B8
              0E2371187BB11A8BB026F6853B638C972CB8119FE21C22FEC59FF8053BF14F7E
              1EB10E0FF78477394A4FC63F8353D9B8AF3103C3BAB5E98FFBF14181CC5C0CEA
              5302782B1BB30393AB02622C9666BD9568ED130298998D5883D1358131001F66
              FD85084D2580F1388DEDB51A5FC0E897A75CC4D3CD26B028777C5F43A00CC75F
              D87DB9A752B1D31BB3F15F9502CC0BCDF04271239B9EEB79D584DF2AE46329EC
              4E2D09AFA214094CC1597C5B06708CF120D6624A0821948159498A04C6605F8C
              F15889F8ED68C5FA10C24721846921848125E27721700D0E96098E03B93E8EA7
              F0053685101E2BCB2B450287716519A005199EEBA9B809AF62043EC18210426B
              C33D14A2C652297518585A8863B9B4AFB4149E8DC0122942ADD660982D76F65A
              067DA824E3AF90F2A31515DEB548F953C33B7611F4F60C38B724024F64BC172F
              F1BE058B739BC71B26904157E10CC63768FC406CC5118CECA1DD0869EDFDA1CE
              0CB63BE04429F75FDBC8DCC4BB7964E755D1F695DC767AC30432E03B19F0B37A
              4605CF67FD36BC5E45FB1B72FBF96511E8578812DF614C95860FC6FB596F9774
              DCEC9540D66D477B290432607FCCCEC61CC31B187789B623A4D3DBF6C2C877E4
              DFD512589E2356CDD1A8E2A13EC67816CF8510BE914E67B3302B84B0055BB05F
              DAA4C6E0B6ECB5235891D7D1A04AB83DC8A1ACF35E08E1601E805531C60DBD6A
              56313AFD310DF3A5FCBEF3801FA508B2463A421E2A3CEF2CD57A60A5946E74D7
              6FC74B185CD314EAA5B30DF81D272B74582F819DD826E562DBB05E0AE97B33CE
              763C501681CE85FA7719043021B75D5141FFB414488E49FBD3CCEEFAF5DCCC7D
              99EB5D75E8569227733DA4C2BB019824ADB90ECC09213CDAA5451D1E68912EB1
              4EEBBA1E6AF600AEC5096C9646B827AC8E4CE4B842A650B307628CE7F0721E9D
              FDB5EA774A3ED82C9046FE90DEAF3947496BA2558A8CE70DAAABE06D6964F6A9
              D10352C85C90DB2CED41BF52F929D777D6B5880B46F4C3E7196C8FAEF7A49724
              8071F821BFFF599A8AB510D898EB371B2250580F9DD79067A5B5B1A33B814C76
              12E6B870DFBAAC0EE3A3B4EE0EA2AD61020522F7E2FB4227C7A514796D1EB162
              C8DD9489D66A78B1B4E1448C31E51E654908E16E69D79E2C4598AB71348FD881
              FCF704347AA05F83BB7055A9042A4908E188F44DE1E61261D7E10E0C6DC627A6
              3D185632E6101C8D311E6B06818D182D65AB65C819E95BC4469AF3916FB134E7
              7F2B096FA3E481C53487C01269218F91426DA33250F2C242941346AB08B3B3A4
              F0F7A3C6C267E72E3CFB3C769308B4E25769136AABD3F8CDD26EBF5BE1AAA629
              043289EBA5BCE98CB4C1D562FC3A691A9EC43D5D709B452093B8553A71C54C62
              672F8677E469774ECA7C2F3A955DF68DACBB84104649371E33F2A3CD2EA4D383
              A5FCE81486E216298F5A8667638C5B2F026CA607BA7963A2F45F0047551EFD93
              D2D7CE477AC269BA07BA4B08619094161473A75D5817633CDEAB7E5F136854FE
              0333632D0935EA2E6E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'ClearBackSpace'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000252494441546843ED98E13105311485
              CFAB0015A00274A00354800A50012A4005A80015D0012A400754C07C33C94C26
              93CDCB4B6E981D9B5F8FD9BD7BBF7BCF3DC9EE4C235FB391E7AF09E0AF3B3875
              60EA40630526093516B0F9F67FDF813549A7920E9A4B990EF029E946D2C950FC
              960E6C4A7A94B4DC29F930EC95A4E3D4736A01489AE481F88D4527562C012E25
              1DB9805F0EE4BD03C977103359EC9A0EEC4ABA0B02A34F807A2C7300A4F316E8
              FE411240BD96390095F709231D5C087DC60B5024765E48B62FE93671AD29002E
              70113C644FD2FD40F27EC0B1C0C33910D7CE8653D79A01C49639686B92CEDCDE
              E0F3CE41F8E4FDB5C072BD5F6600CF81657EB8DF29E98449238B1C449C3C128A
              37441380B8A25B925E0AB44D2587204A92E711CD00DB6EC3F2F932940095AE14
              04F786954E55DE44423809D2C16958AF953B6F0C11C2E7926FEE406C990C72ED
              6E9B8298977C330016B9E3CAC5C0A2FD5A8058F3842DB1D8A61940420CEBAA83
              E037108BAE54F239770AE3370110A87588536E43DC79166B32C43E48AD8DE6AC
              3267B1A61DF0C190CF86FB8339404AB98DACC4E74B209A25E40170A027494BEE
              1F8B1C25726E1343C4FB8C1900792F729803968E9558A587609F61E6C2CE9A02
              00115BEB7AE6380D70E9AECD75BC14C5B23407C05A99012F25803856F75AE600
              296B1DD52BA5AF74F852DFBA4BE7BAD7A5033C1029F941ED259F302EAFAFC9EF
              4F355F2586ACB52788F9872D9F2C476D1C243C1A588250796C36F9558E07B574
              C032D1EA58134075E98C6E9C3A6054C8EA305307AA4B6774E3D401A342568719
              7D077E00C2448C31F447C64B0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Sort'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000000E7494441546843ED96CB11C3200C44
              E5CE92CA9254E674664F0EBEC4800492C838F37CC5ACD87DE2B3C8C5BFE5E2EB
              170CFC9A200420E04C80167206E89E5E23F0742B97053691EAD1DD1A3BD44EEB
              6A1978249918957D89080646D38B98D74520A2E0140D8ED12931378A400002CE
              0468216780EEE9BD0422DF48ADB78FB9CE8881EC3752F1C6ADA1C280BB89CF02
              A9046E090B2E49BEAD757A5BC8AA3BED3F0C4C8BBA520802107026400B7D0568
              BD27CCE7BC06289AC0C7C0AA14BD8B08068E9020F06F7B40DB73E1E3D12D14BE
              404D10035A42D9E310C84E58D387809650F63804B213D6F4772ABA1A31506964
              3F0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Exit'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001B3494441546843ED99BB2E05511486
              BF53E924121AA2D57A0209954E47A344212A89DEA5388D44251A0A858A17D0F1
              329E83ACE40CC7D897D997396BEF98A92699B5F6FCDFBAEC59E7EC11955FA3CA
              F533006867D09781256015984F10FA9EE0EB757501DC00A7DE15DC06227E2B71
              0DA7BB0DE00358CEF06215800BE03C8378594205E01E38AC19E00DD86C015C26
              0049467BBB4C3D6002F0ED56BD09F42D3C00F822D4F7F312323007EC002F31B0
              DA000BC0E304602F0642136005786AED78C1105A006BC033B06E289B20082D00
              D1EDFAE27786D004C802A10D900C51028040C8F0681B399CE59413A03D3F856E
              EBE26F9B82AD1039013E431507DA1B216A0210DE3F1003C05419545F42A94DBC
              015C59FA62264D1CD893BFCCCF80EB50F1629FB30762014E80DB18F125001C00
              0FB1E2B501F627E3B4497F15C39C8CD3BB358FD3A2BD0DD139F20D78094DDC40
              048BD7EE81E9EA9152AAF2477DECD6FBED5742092541FC1B00DF9FBBCD202701
              91FB263072EFF3CD9E813BE03869D51F6795F301D7E73D944B054044BE02DBA1
              6A0DF66A008BC018384A8450036874577DCC9A18FCD9B8177B74D4157F00E81A
              A9BEECBE007A7E5F31069917990000000049454E44AE426082}
          end>
      end
      item
        Name = 'import'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001F4494441546843ED98BD2E44411480
              BF2DD4B412A1D01195074078000A74A2A5E305AC17A0A3151D0A1E80E0015442
              A720122DB5464E7247D6B873EF999FBDBB9BCC94BBE7CE7CDF9C3333776E8B01
              6FAD01E7270BF43A839A0C2C02E3C044C3B0AFC01B7053356E9DC011B0D530B8
              3DDC31B0ED62A812D8010E7A0C6F86DF050ECB585C0223C02330D62702EFC00C
              F069F3B8049681CB3E8137182BC09556A00DEC59C10B0D0BDD5AE3ED03C2F5A7
              B932E012B86B48621EC80265259433A02CC15C42A916F15431E3CFCA9937617D
              9101813F2F88D6001F899E0B18F8E942E009F0914822305772906876211BDE74
              E3232102F62E78EF73907996EC6FB80B3E4442C550F73AADEAA408AA83EF8A44
              2A012D7C72891402BEF04925620542E19349C40854C15F00ABD6022AFB4D427C
              76A77F6B3254A00E5EEED2F6EBB0DC27E46E6B8B45498408D4C1CB8155761089
              809C23723A279308119804CE80D992121178695502F27F99C403B00EBCF8ECDD
              2102D2FF28700A2C1583497D1B788D802D710D6C001F3EF0121B2A20CF0E0327
              C0B705AF15301243C026F0E50B1F2B20CFCBE02260B7BA12EA8C77F5A1F289C9
              40D5003E022A5057501670CC4CCE80B6AE7209E512D2D68A232E97502EA15C42
              913350514272987536B90B68BE2B7911756B117B41C404678198D94BF16CCE40
              8A598CE9E30712D68D31561E64D80000000049454E44AE426082}
          end>
      end
      item
        Name = 'settings'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000005C4494441546843ED9965A86E451486
              9F2B228A817F544C145BB1C0C0C440B1BBC50E0CEC0E30B0BB153BB0BB453130
              B1B0B015C544FD23068A88C8036B2EF3CD99FDED7D3E36DE7BE02E383FBE3D33
              6BD63B6BAD77AD993389092E9326B8FD4C0330A53DD8B7072E050E6E01751970
              485FC0FB06F038B0518B714F001B4FAD003E03166931EE7360D1A911C0BCC0B7
              61D8DDC00E85917701DBC7B7F980EFFA00D16708AD0D3C17465D001C5518783E
              70647C5B0778FEFF02B032F07A87CDF601AE8D79870226742E26EE25F1615FE0
              BA0E3A5BF7EEE2815B816581DB80731B365D033805582FC637031E2DE66E0A3C
              12DF3CFDD381671AF41D03EC02BC07EC3A0C681B0063D6D84D62DC7A721AABAC
              029C006C5E6CB234F061F16D29E083E29B9E35B4EE89EFEAD593E6531273C99C
              AA4A1B801780352B2BFF0C6F9C5C19934AB701FE2AC66604EE6BA0D053014F7D
              A68ABE1781B5460160129E170BBF01DE010C8D9AFC039C0DDC0C4893C3449ADD
              1D380E98BE61A2A1B63C307F8C1F1D9E1A33BDC9037303AF650A4E04CE048CE3
              FD0A203F017B018FB5185E0E6F02DC00CC990D68F835913F86E619D9011AAE3F
              944A9A005C0CC824CA27806CF06BB6D8DF52E2628094F8CB388D4FD3670FEAFD
              14907A73B69B2D7E2F1E9365B0C3BA00D0384F3F89F467FF3225C4BE2AA763BD
              3040E9350F98685B67AEF364127F7705313320EB48BF8A74282BFDD15541CC33
              0AF474CA85FB832026ABA90110B58C60B94F62729E94B50AC3EC90B7E5F8058A
              495F870EEB4A9BB8B73A4CF6245F44225F9D2F6ECA010B92896B7C27793F803D
              39647779BC46ADF9122933D5919AAA0D83A297C9061F004E0B261C5833AC0E4C
              075C01EC5FECD24469D60BEB4612C3E6A5F861A54EE1E427795D7E2F25A76EC7
              7E0FB0867155DA0A998BACC69703738486EBA35AE60A6701DE041263D44E59CF
              A49397D9560C03733D86EE39F1414F9B033254A37401E062DB87BD43CBB1959E
              6835E0E5187F2368B7B6A90CB2520CAC0EBC524CCA3B5A7365B761C63BD61580
              6DB2CA15DB04D92017C3ECAAF860714A60CBFDF59E454F39001848C8D823B5E4
              367C790E8E1C422E6C03A0C1A93DBE1238A8E1E4CCA90363CCA64D40B9E41EE8
              15C0EDC04E4342C8B04805C6E45DAE01C0BB59325B300DB7260077003BF71142
              F62CF627F384B29A620B97852A71BFC96A22E79253AC35C142571636EF1BB29C
              F27DF45D437BAC361A3D3E0A4A6EC8E180BD522916B05BB28F9EAEB54391D353
              F2FADBE4AC15347B9D8B0AC516D0B3807F6BDE680220C5C936DB668B648C238A
              3EA9D4D94721B3DFB91090D992DC1BF42A550F480D80EDB26ECC9F472C24F2F3
              CFB55328BE59D0BC1BA79A9086E57EEFC2B50256AAB5E67880E911C071EF19DE
              4F0CE7C95203E0F52E9DBCB1AAE132CB78C4C266E5CD9B3993DBCA3A1E91B104
              92724B4F6CD706C09BD0DBD9242971BC00C663E4B0B902907A93AC50F6434D39
              60D278E5533E8ACBFB6F992219C430334C3618E164932A3DF5545C9A0C8FFC21
              60D6C8B72563B257564965409A00CC05BC0A2C14B3056328D984ED09EC9169F9
              2A9E40CAB6A0CD0B26A94F350B66136F026E8CA6D0D0D168E54B6055E0C7AE00
              9C67A94FA1632E488BB61135F93B5CAD01C6FA30312F3C0043738686895EAAA4
              DD14FB86526A553A79204DD2BDEB573631197DCFA9F5F5CF0216BFDAB38A4569
              DD8A3EF5D84A1B52A53C1D615AC5DAD6CC6D013C98AD2C6F454BC46BC5568576
              E3F6E3E29B73CDA75CDE8A8B7ABA37D8140A64E16CD296C0434D2E6D03E03AAF
              93BEB4C9BF031C9C29F565CE5EDE1659F17F04E5CDCD9B96FF1B507C34F0A1C0
              1CA889B5C83F5FF2F26BE598B95D00B43EB08656DBE4D45DD65AE5BCE5B67BB5
              ED6E93D6BDBB0068DB248D7BFA29146A949753B357CC7401EAAABF3AAF4F00BE
              E6D9412A7766ED77DAD82E76C7F861673BE6956D14247D02707F13B7EC814ABB
              EC894CE85EA46F000F0F79004E06FBFE593EC78F0CA66F00F99B6A9351D537CE
              5111F40D60543B465E370DC0C847D7D3C209EF81FF00B0F61A40C56188A00000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'home'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000023D494441546843ED973F4C15411087
              3F2C889556C6865859416322A1920A2B3AEDAC08055190466C90466984466DFC
              1B0A4265A79D955650194968B4A22234C40A2A430164C85C981C8FB7B3F79677
              9CD96D2EB99D9DF97D33B37B7B3D347CF4345C3F19A0EE0AE60AFCEF1578A180
              C53339EF79B5D00DE00330AA8ABF0193C0566A82F300B80F7C04AE95C4FE051E
              015F5242A4065800660302178167A9205201DCD4AC8F1861DBDA36F24ADAA9CF
              CCFDD06A6C760A9202E0810ABC6AC47C55F13BFAEEBADADC3336BB6AF3B91388
              4E015E013325017380B452AB21ADF3B234F11A785A15A22A40BFB6CCB0092CED
              2027CDF78098BB5A0D69BB62AC6A4BFD8905A90230A6E22F9B60D20672C2EC39
              055C511FD27EC5F8A73E569C3E8ECD6201DE028F4B01A485DEC40435B64F0069
              213BDE01D35E7F5E805BC02760C838FEAD195BF3063BC3EE8E5663C0CCFF041E
              021B21DF1E80090D70C9385B56F1FBA100CEF95E8D316EEC0F34C6523B1F1E80
              C3928329DD844E6D51667208BC2FAD68AB31166010588F92146F7C1BF8659625
              05F000C74B3EBDC2563D03B8B39122F5EAC31DD3D3126E6719E02403EEA4E50A
              98B669F7DF2B199564154F5916B22F5C77ED141241CF9DFB603E0368A652EE01
              5B01C970AB5154E8C257A095C032E085DE0319A08ECB9CF477D116A10A88DD59
              FB44B4D7F2216B3C40689386E6EDA9554B05420243F3B50334BE851A01E0BCEA
              1C9F30E50F55CC5DC9C6497A99CB00DE0CA4FC905588D9BD259EDB68F7D45488
              94012A242DE9925C81A4E9ACE0EC08BCD697313ACCA40E0000000049454E44AE
              426082}
          end>
      end
      item
        Name = 'Help'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000004E0494441546843ED9947C8644510C7
              7F7B5AF0A02B0A62C415BD284604C38AAB07B38859C1C08AF1A06B40761104F5
              2282398098308B398059CC6000C584822228C683D9835EE507DD1F3D6F5EA87E
              33201F6CC1F0867955D555DD5D55FFAA59C222A7258BDC7ED639F07F9FE03C4F
              600B6025B03BB075F1D1C76F8BCF07C09BC00FF3707E5607B607CE00F606F6A8
              34E87DE01DE04EE08B4AD905F6B10EAC0F5C045C08F87D16FA1BB81EB80EF07B
              158D71E014602DB04363A5AF810781EFD3F5C84FD9BC5E5B16CF93806D1BF29F
              03D700F7D47850EBC00DC0F98D05DE021E48C6FF135C7C3D40274E06F66DC8E8
              C069413D5569F479E09042F16FC0D9C013D1C53AF88E016E03362ADE1BF4CB23
              7AA3277013705EA1F033E0C45982AF619CC9E06160C7E2F70F5346EBF523E2C0
              596987B2A2C780E323BB3382E751E0B842EE12E0AA3E3D430E9C907626EBB8A5
              71125DBAB7015600BB017E37659A2A9F0E387533706EC167AC3CD425D7E780E9
              D13C9DB3CD2BC081030658C42E068E0496B6F0BE0DDC18889B97810392BCD9C9
              3AD39A62FB1CB81CB82C293125EE05FCD8E3C061C05DC026815D3E15B8BF876F
              73E0DD947A65BB02D09E29EA72C0A052412E5247034FF52CB8292044D82CF1BC
              08BC0ABC067C05EC94AE9E812FFD0EEC0F7CDAA3F328E0C9F4DEDD7703A72A76
              970356C60B92B0795E8CD347E56969DC76C9C8A64C79BF75E69101BD62A65C27
              AC4156FE09EA72E0236097C46916BA6360214FC09A7026B02615B5361175AA5B
              B2209A9EFB487DB727868F815D230E8824BF498CC2839D8168851DB0878D815F
              1293C17EED808015FB93027658DC2C720BD47602AB80BB134767F00C59DAF1BE
              DC51339A996D88CAEB29C498C04A6D0E94F7DF6B918F7068A1C8FBE7804313E3
              5609F80DC99585742A0EDA1C30DB98C7A5C301179D079555D6605E1D546A7A7E
              36F15A08CD4EBD57A80C60D39FB867562AAFC10BC52944F48A8F72BA9D0AE4B6
              13F803589634FBFC2BB24A0F8FD8C6DD97ACB00755EADB00F833C9F8DC70E804
              4A0714AEEE928A054AE36D76C4FFB56431CD9B1872A0BC42E2A0D1FD6A4AC7A6
              E55F817D802F6BAD074405E221297485CA203E187869C4A28AEC07BC9E646D7A
              8E1DA9C72B27349142415CA651270E02B431740E706B12B4E2365BD1A8CED3D3
              E442FE501A157FDBE34AB314324FA0A437A21637F8CA0C660C194B0BD496859C
              20089FA57943895A1F9A50C2C9C6C440AC0BCCBD570CAA2260AED6B0287F093D
              ECEAF66C0A7639E0902943D7089CEE3348A4FA73D4E2065F09A78D4D87691314
              6D68CC20B5E313618890C1343A26961CB73C9EACAD6E68942B83C719908D454D
              4D28B1CF4F806D6294CCFD9E7C9E1555B7942ED46CEAC54462A3283947CA0D4B
              6D1516FBE419D1E8A65E439D83DE57585C3B13B2B770BC22F2FC37E879733634
              D503947A86E642F25E9D4625592E3A1B0ADA3BC1D69C090DCE49230EB8C233C0
              11C5527652EE4CDF98A5C601E3C32E30CF82940DCD47A30EA8F05EC0794E268B
              9DF0A06FDC1271C206C56197452A53682E2A738D03F297F8262F36EFF1FAE03C
              B436069ABBE83CE7D29E3F384C995EADEFD24779FB5F3F5E15875F5D7F705CD9
              37076D3BCEDA13C83A16F55F4CE5465870C42B22CF3C088BDC7B796C4E44A80E
              CD6A0AE484FEB127D066A49041471C84F5FDCDEAA04AC327065451AF9B7CF374
              60AC0D33C9AD7360A6ED9B83F0A23F81FF0008DEF53185E762FC000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'info'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000042E494441546843ED9947A815491486
              3FB72E0C881B130AAE467414845117868563449C3163405147174E7010441046
              712328C6013161CE19CC2E745C184031A12B41316D440C0BD7F20F558FBA7DBB
              6F5755973E1E78A0B9977BEB9C3A7F8513FE6E450B97562DDC7FBE0368EE1D4C
              B9035D8021407FA0BBF308E373E7B903FC07BC4A01BE2A801F8079C020E0A740
              876E0337801DC09340DDA6E1B100DA007F038B017DAF229F80F5C03A40DF8324
              06C04C6029D02B33D353E000F0D21C0FFBA9613A5E5D9DCFE940CF8CFE63602D
              B03B044128800DC09F9909AE03FB8DF39F3D276F0D08C40C6070464700E678DA
              090AA3E781518EE177C002E084EF6405E326005B810ECEFFBAF43D7CECFAEEC0
              26E077C7E023606A95CB97714EC1E030D0DBF9FDAE89680D71F800F8CDAC9035
              740C98ECB33A11638E02931CBD65C0EA4676CA004C312B636DFC9BD989081F4B
              5536038B9C51BA2B078BB41A015078549CB6D1E60AF073E9F469065C06861B53
              8A4ECA33B921B6118015C03FC68842E240E0751AFF4AAD74066E9AD0ABC12B01
              F95327450074A964C026A95F8153A5D3D60E9806FC627E92EEA1407DE99E343A
              5A7D2D605DC62E02A0CCF89751569C578D132A0AAF022E91230A97A1A29AC9E6
              09E52065FE1A2902700FE86B462A0A6D0F9D19980DEC327A4A4C4119D6E8CD07
              B699EFF7817E3E0054493E3303551EFC08F866D8ACFD8EE687B7110B201565EC
              074ED9A1E4A624D724793BE0AE5CE1E589742846CD0D26753B9907C03DFF2A15
              EC16C64C9E42C74DA475F7200F8022C67833F358E05C0A2F2AD818039C35FAA7
              9DC8F6FF4F7900DC0BDC0750DD13234381AB46F11A302CC688A98F1E165DE43C
              00EF817646419F1F23274E05A02DF0C1F8A0CFF66597D80520E5E02EC94C900A
              8092A95D442F00EE11521D14DBAFA602A0AA40F590A42E17945DE291C0A5663E
              4223808B2197D80DA3621C76363380B986B9901B5E6154F5B77A5C49954496EA
              08B9894C3DB4888326C93B426210543E4BAA94122900644B09311B3584585131
              77CB21AA628BB91400DC624E44D880EC712E022092C996AEB1E5740A006E39AD
              BB2932AD467C1B9A8911F4495500EA1F8E1B6F831B1AE9B997471C901A8B909C
              50058062BF76DE7245C12DA500649B7AD544AA8DBE85A8F6B11C5174532F47C5
              83EE753CFE9A9C909D26CB0DCD02F615AD5A192F24BD35C012C7C0D7E486B29C
              D046A737CFC5E003408A6780718E057144EA8E52D12CA251D43F5B2E48535D00
              46979D575F00B2B307D0765A51B213531D4AB7647D127DA2955692B2A29DF8A3
              CC79FD1F0240E317025B328653D3EB416D6C2800F92E567A7983171C6FCCD17A
              01E89174338F8E4A27F36E20EF05C72AE088CFCADB313100A4DBA25F31B90BA4
              84A37A4549CB1261BE0BA8E644BDB248B3900459633F7607F29C1421262022C2
              1ABD66155125C76B082A5FD4D9712901C4FA5049EF3B804ACB9740B9C5EFC017
              4EABDD310AD690EA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'clone'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000014A494441546843ED993D6E02311085
              BFBD4E2E00220D54D4A4E50C697290349C216D52A7A301910B701DA2510A5628
              B647B36BAF40CFD54AF6BE99F7DEF867BD1D77DEBA3BCF1F1198DAC1A803AFC0
              16985522F0037C00BB127E84C006F82C018FD4FF027CE5B022040EC062A4044B
              3047E0796C02971E60448052D2D6EF8E1149C00DEEC93431C61DE3A1092C7BEA
              EC7BCF6E75A6762095A808389C718B949B0372C0A1746A881CC86D266E75E4C0
              9F02D9BD4A93784099E45E7597A91C9003FF2BA012D23E30706EA88454422AA1
              AB023A0BDD9E08DD2BC4803272C7D0596880CA3A8D96BE76527578AA78AD7EEB
              8A5DB3CFA397BB2902F64FC048B46896BC9148B6C82436B027E01D585762F10D
              BC01E7127E944009B759BF0834933A1128E740ABD5C6AEEE57512172045AAD36
              D508B4586D2C46550251679BBD17F947D62C394F2011F0A85473CC2F06826B31
              8E670DDF0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Edit'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000033F494441546843ED9879C80D511887
              9F2F9148241259229125916489105992C8CE67DFF77DDF65DFF77DDF77591289
              1059924824125922914824129D7AA7DEE6BBF7CE9D7B67FBEACE7FBF3BB799E7
              79CF7B66CE992C72F99195CBF9C908843D829911F061049A00738079C035A7EB
              4769040A01BB818E0AFA38D02591445404CA024780FA3160134A444560AEB44D
              BC62C795888A8001779268079CB51B862960EEDD0930D5B58E44126642378D8A
              401EE979236026693212063EC753298C11C82BF01D54359D244ECA68E5982341
              0BE4038E02ED63CCD67812B78196C0F758333C4881FC52793319ADE30950CD61
              2476016FE23D9E82122820F06D158879DB9E008E3948247C1907215050DAA68D
              2299052C905C351D09BF05CCF2C0F47C6B053F0358A4F26C59F7583F995131F3
              E19FD33AC89CF753A0B0B44D2B05320D58A2F24C60BECAA704FE6F32F07E0A14
              91CAB750205381A52A4F0716AA7C5AE0FF240BEF974051816FAE402603CB6D32
              8B553E23F0BFDDC0FB21504CDAA699029908AC54798AAD8DCE09FC2FB7F05E0B
              1497CAEBF5CA7860B5029B042C53F9BCC0FF4C05DE4B811202DF58818C05D6AA
              3C0158A1F205A033F0235578AF044A0A7C2305321A58AFF2386095CA17A5F231
              97076E84D27D8C9612F886EAA623818D2A8F01D6A87C49E0BFB9018DF7DF7404
              4A0B7C0375F1E1C066954701EB54BE2C6DF3D50BF8745AA88CBCFEEB2990A1C0
              569547001B54BE2295FFE2157CAA02E5A4F27515C86060BBCAC3804D2A5F15F8
              CF5EC2A722505EE0EB289081C04E9587005B54BE2E6DF3C96B78B70215A46D6A
              2B90FEF22DC7FA6910B04D9DBF21F01FFD8077235051E06B29907EC01E950700
              3B54BE296DF3C12FF864052A49DBD454207D807D3619B373B28E5B52F9F77EC2
              272350592A5F4381F4020EA8DCD7D6467704FE9DDFF04E025504BEBA02C9060E
              A9DC1BD8ABF25D817F1B04BC93C063DB5EB5BBAC342DB69EC07E057A4FE05F07
              05EF24A0B7745D65342CB61EC041057A5FE05F0509EF46402F39BA018715E803
              F9E8F43268F85404CC66DB6CD2ADE3A154FE4518F06E0462F13D12F8E761C1A7
              236026B8F930FB2C4CF85405CCE740B3937A1A36BC934014F81C19D2D9D0385E
              3C883F640482A872A27B644620EC11F80FD4919C3180B038370000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'Export'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000001F749
              4441546881ED983F4B1C4118879FD7083990F801041B418816A9AC442D04FF14
              862082454008A4B049A168AF7E044B05B54E95B4A60E214D406C0F2B0589E569
              0807C637CD89CB38B3DEEECCDCDEE2FEE06DDE99619E676759EE46549532A7A7
              6800DF540245A7F402A8AAB38041E000B8006E01ED50DDB6F6DC0306521953E0
              4781DF1D8476D525F03A9300F00238ED02F8FB3A017AB2084C7601B4591336D6
              5EEC19B1F4EA40C3313F74FA8161A337027C3727BA045E5A7A9F54F59B27585B
              119159E0D868D76C734BFF19AD048A4E255074A20888C8BC889C19B514632FD7
              67D4377DC090D17B1563A3D2BF42AE13F80CFC307AF5C82CC9FC04C68CDEB96D
              A2554055AF80ABC0506D47551BC0AF76E696FE15AA048A4E2550742A81A2E325
              20222B22B2E8B17E4E44567D1872FF161291F7C011702722CBAAFA35E3FA19E0
              0B5013919AAAEEE60249BB344AB933FA08FCE3E1C6A009BC4B8C2FF1F856E143
              627C0AB8498CDD016BB95872C0BF31E093120B4F0900D3C01FCBB802E3D1055A
              10EB0E8026F0D625004C00D78EB55B1D398184C48603E42FB06FE91F1AAF4DB2
              B67373E45DF8C44964A95C4F3E884000092FF820021E12DEF0C104724804810F
              2A904122187C7081362482C247114891080E1F4DC02211055E5591D666512222
              9B409FAAEE44DB23A64027F2BCFFD074432A81A2F31F4366965D1A9C2FAF0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'TimeAuto'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000004B6494441546843ED9955A82E551480
              BFAB88F120066262C7836260A382FD6263628282A20F76A20F8A855DA028F860
              82DD0836A86062A0600798984F0662F05DD6C8769FF967EF997F8E70E12CD8FC
              736656EEB5F7AA338F051CE62DE0FA33A6017FF7DC8C51648FC224149F33A0A7
              07E7A38FE98121F2A7A6993360EA2D9C92C1981E5806D80D3812F079D9F8F572
              FF007C0F7C063C05BC1A6B4AF5C7B903BB03070107008BF4D0E865E03AE08E09
              348B01BF95F84DE301153F1AD8A324A4F0FD71E042E0C504EF6E6049E008E0DB
              2EFAA106DC18CAE7BCEF035E88A3E2717109AB276B5B60DF8CF057E06CE02A40
              E5F78FEF6F8767DF9F64C410035E03364D18BA4377C6F25B0D6C061C1C6BF984
              E09E44795F9F079C3BA607F26CEB853C0EF8B046EB169CB5802B813D5BBE1595
              EF9BC8EE07F64904DD041C3350F19CEC2CE0A2E4A5F7C1A0F055897FED11BA18
              383361B62BF06489F980EFA987BDD8E79478D41860B47924617412707589F1C0
              EFE6914783F64760AF080A13D9D518F070122A8DD987562AF76C86B74325DDF5
              C0B1816B54DB6F9A4B9CEEBED1666BE0D30A45D66EB9D8EB001F55D0AE0ABC02
              34D1C90D9B94EC8AD5A861ADD90163F4C9150A886264F1A8A530945E63B69C24
              B7EB08997CD2DDDE1CA88DF396008B025F87E01581DF01CB831A304F582F35A0
              011A3203BA0C30335E507B1613CE66DAE7E3EF6BE3F7F8F8DDAE7429133EF726
              197B6244EA3240255446F0E878046AE016E0F044611F1B836E8DFAA6868F47D0
              A328589E687C2F0FBC03AC1F142615EF43091602FE0CA4CFA3FEF14F6BA2D5E2
              FDC2C05F25465152581709EF021BF435E04B60A520F24CBE5E215443EF0ABCCB
              81D3E2F932E0D4783E300AB6123BEBADE6CE999157EE6BC02FC0E2416483F253
              496224219391B013F04C3CEF083C1DCF8F0186E7122C0D98CC04ABD525A63140
              663F1724BA435F04CE07C07A19BE25F1BAF16E15400F77C152C9A60D3240651A
              B76D02BC591078425262187D1EC8F02D049B687422704D81DFC6C01B81A3B11A
              3D03BAA2D05BC08641A1F0070B025FEA4A3819ADEDE456057E7B279B6063B351
              5F03AC65B60FA2520167926B4D341D4A6E5168ECF55213BA9F035A6BA92E0F1C
              0618B78552517509707AE0EAA949C7C363E6CE0A9702677418982632F3CA6D7D
              3D60E4F92699347495121F036B8680AE5E6117E089C0FB04B0236B83B494F803
              58218948FFC12F95D3B7038704C5A462CC9A3DBD1F259E69D3A2371E6AB1202D
              063B4BF892B0BC9CF64EBC9709D4B54D84B03776D4D205B6A296D68291CEA39A
              82DF2C3D9A72DAB14DD3E4CCE05B324082B4A1A9891E05FD8B9F6D55770E2C3B
              C1B686FF5F263506E42DA5023CE7B301F9BCA973F755A0C600F172C655238F9E
              16A6175CD2AAA947AD0132CC075A37C44CA8A79EADE869CC17C1C2D14854843E
              06C82C1F6C592E58711A4687C01AC0F949A46B7854EB558D986897F7BB638E16
              FBF4CDF3551A62807447010EBB96CBB6DD8CED54CDF068A27209263997E1769B
              96E1EE7780D3B99BFBBA71A801CA315E9F32C278D10071C5D0F9EA3406349B65
              48355B1BBB9B0EAEB49176580E86CDB24D6951A269FD3E860129638F87E1D0C1
              96ABC9B86668875A2EF348FACF8C418AF7BEED53499945E2B13D308BAAB6B39E
              33E07FDFF24CE03FD753E231353844E00000000049454E44AE426082}
          end>
      end>
    Left = 424
    Top = 296
  end
  object VirtualImageList1: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Search'
        Name = 'Search'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Members'
        Name = 'Members'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 3
        CollectionName = 'BatchPrint'
        Name = 'BatchPrint'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Marshall'
        Name = 'Marshall'
      end
      item
        CollectionIndex = 5
        CollectionName = 'TimeKeeper'
        Name = 'TimeKeeper'
      end
      item
        CollectionIndex = 6
        CollectionName = 'AutoBuild'
        Name = 'AutoBuild'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Cycle'
        Name = 'Cycle'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Sync'
        Name = 'Sync'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Swap'
        Name = 'Swap'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Shuffle'
        Name = 'Shuffle'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Switch'
        Name = 'Switch'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Up'
        Name = 'Up'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Down'
        Name = 'Down'
      end
      item
        CollectionIndex = 14
        CollectionName = 'ExpandContent'
        Name = 'ExpandContent'
      end
      item
        CollectionIndex = 15
        CollectionName = 'GridOff'
        Name = 'GridOff'
      end
      item
        CollectionIndex = 16
        CollectionName = 'GridOn'
        Name = 'GridOn'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Report'
        Name = 'Report'
      end
      item
        CollectionIndex = 18
        CollectionName = 'DeleteForever'
        Name = 'DeleteForever'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 20
        CollectionName = 'New'
        Name = 'New'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Lock'
        Name = 'Lock'
      end
      item
        CollectionIndex = 22
        CollectionName = 'VisibilityOff'
        Name = 'VisibilityOff'
      end
      item
        CollectionIndex = 23
        CollectionName = 'VisibilityOn'
        Name = 'VisibilityOn'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Qualify'
        Name = 'Qualify'
      end
      item
        CollectionIndex = 25
        CollectionName = 'UnChecked'
        Name = 'UnChecked'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Checked'
        Name = 'Checked'
      end
      item
        CollectionIndex = 52
        CollectionName = 'HeatstatusOpen'
        Name = 'HeatstatusOpen'
      end
      item
        CollectionIndex = 51
        CollectionName = 'HeatStatusRaced'
        Name = 'HeatStatusRaced'
      end
      item
        CollectionIndex = 50
        CollectionName = 'HeatStatusClosed'
        Name = 'HeatStatusClosed'
      end
      item
        CollectionIndex = 55
        CollectionName = 'HeatStatusOpenActive'
        Name = 'HeatStatusOpenActive'
      end
      item
        CollectionIndex = 54
        CollectionName = 'HeatStatusRacedActive'
        Name = 'HeatStatusRacedActive'
      end
      item
        CollectionIndex = 53
        CollectionName = 'HeatStatusClosedActive'
        Name = 'HeatStatusClosedActive'
      end
      item
        CollectionIndex = 56
        CollectionName = 'HeatOpen'
        Name = 'HeatOpen'
      end
      item
        CollectionIndex = 57
        CollectionName = 'HeatRaced'
        Name = 'HeatRaced'
      end
      item
        CollectionIndex = 58
        CollectionName = 'HeatClosed'
        Name = 'HeatClosed'
      end
      item
        CollectionIndex = 59
        CollectionName = 'HeatStatusToggle'
        Name = 'HeatStatusToggle'
      end
      item
        CollectionIndex = 61
        CollectionName = 'Sort'
        Name = 'Sort'
      end
      item
        CollectionIndex = 62
        CollectionName = 'Exit'
        Name = 'Exit'
      end
      item
        CollectionIndex = 63
        CollectionName = 'import'
        Name = 'import'
      end
      item
        CollectionIndex = 64
        CollectionName = 'settings'
        Name = 'settings'
      end
      item
        CollectionIndex = 65
        CollectionName = 'home'
        Name = 'home'
      end
      item
        CollectionIndex = 66
        CollectionName = 'Help'
        Name = 'Help'
      end
      item
        CollectionIndex = 67
        CollectionName = 'info'
        Name = 'info'
      end
      item
        CollectionIndex = 68
        CollectionName = 'clone'
        Name = 'clone'
      end
      item
        CollectionIndex = 69
        CollectionName = 'Edit'
        Name = 'Edit'
      end
      item
        CollectionIndex = 70
        CollectionName = 'Export'
        Name = 'Export'
      end>
    ImageCollection = ImageCollection1
    Width = 48
    Height = 48
    Left = 176
    Top = 528
  end
  object VirtualImageList2: TVirtualImageList
    Images = <
      item
        CollectionIndex = 25
        CollectionName = 'UnChecked'
        Name = 'UnChecked'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Checked'
        Name = 'Checked'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Qualify'
        Name = 'Qualify'
      end>
    ImageCollection = ImageCollection1
    Width = 40
    Height = 40
    Left = 304
    Top = 528
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = SCM.qryNominateControlList
    ScopeMappings = <>
    Left = 1104
    Top = 168
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 1108
    Top = 109
    object LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      GridControl = Nominate_ControlList
      Columns = <>
    end
    object LinkPropertyToFieldCaption: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'Caption'
      Component = clistEventCaption
      ComponentProperty = 'Caption'
    end
    object LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB2
      GridControl = HeatNavigateControlList
      Columns = <>
    end
    object LinkPropertyToFieldCaption4: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB2
      FieldName = 'Meters'
      Component = lblHeatNavigatorDistance
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldCaption3: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB2
      FieldName = 'Caption'
      Component = dbtxtEventCaption
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldCaption5: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB2
      FieldName = 'EventNum'
      Component = lblHeatNavigatorEventNum
      ComponentProperty = 'Caption'
    end
    object LinkGridToDataSourceBindSourceDB3: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB3
      GridControl = HeatControlList
      Columns = <>
    end
    object LinkPropertyToFieldCaption2: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB3
      FieldName = 'HeatNum'
      Component = Label1
      ComponentProperty = 'Caption'
    end
  end
  object BindSourceDB2: TBindSourceDB
    DataSet = SCM.qryEvent
    ScopeMappings = <>
    Left = 1104
    Top = 232
  end
  object BindSourceDB3: TBindSourceDB
    DataSet = SCM.qryHeat
    ScopeMappings = <>
    Left = 1104
    Top = 296
  end
  object VirtualImageList3: TVirtualImageList
    Images = <
      item
        CollectionIndex = 60
        CollectionName = 'ClearBackSpace'
        Name = 'ClearBackSpace'
      end>
    ImageCollection = ImageCollection1
    Width = 24
    Height = 24
    Left = 416
    Top = 528
  end
  object VirtualImageListMenu: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Search'
        Name = 'Search'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Members'
        Name = 'Members'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 3
        CollectionName = 'BatchPrint'
        Name = 'BatchPrint'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Marshall'
        Name = 'Marshall'
      end
      item
        CollectionIndex = 5
        CollectionName = 'TimeKeeper'
        Name = 'TimeKeeper'
      end
      item
        CollectionIndex = 6
        CollectionName = 'AutoBuild'
        Name = 'AutoBuild'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Cycle'
        Name = 'Cycle'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Sync'
        Name = 'Sync'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Swap'
        Name = 'Swap'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Shuffle'
        Name = 'Shuffle'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Switch'
        Name = 'Switch'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Up'
        Name = 'Up'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Down'
        Name = 'Down'
      end
      item
        CollectionIndex = 14
        CollectionName = 'ExpandContent'
        Name = 'ExpandContent'
      end
      item
        CollectionIndex = 15
        CollectionName = 'GridOff'
        Name = 'GridOff'
      end
      item
        CollectionIndex = 16
        CollectionName = 'GridOn'
        Name = 'GridOn'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Report'
        Name = 'Report'
      end
      item
        CollectionIndex = 18
        CollectionName = 'DeleteForever'
        Name = 'DeleteForever'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 20
        CollectionName = 'New'
        Name = 'New'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Lock'
        Name = 'Lock'
      end
      item
        CollectionIndex = 22
        CollectionName = 'VisibilityOff'
        Name = 'VisibilityOff'
      end
      item
        CollectionIndex = 23
        CollectionName = 'VisibilityOn'
        Name = 'VisibilityOn'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Qualify'
        Name = 'Qualify'
      end
      item
        CollectionIndex = 25
        CollectionName = 'UnChecked'
        Name = 'UnChecked'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Checked'
        Name = 'Checked'
      end
      item
        CollectionIndex = 52
        CollectionName = 'HeatstatusOpen'
        Name = 'HeatstatusOpen'
      end
      item
        CollectionIndex = 51
        CollectionName = 'HeatStatusRaced'
        Name = 'HeatStatusRaced'
      end
      item
        CollectionIndex = 50
        CollectionName = 'HeatStatusClosed'
        Name = 'HeatStatusClosed'
      end
      item
        CollectionIndex = 55
        CollectionName = 'HeatStatusOpenActive'
        Name = 'HeatStatusOpenActive'
      end
      item
        CollectionIndex = 54
        CollectionName = 'HeatStatusRacedActive'
        Name = 'HeatStatusRacedActive'
      end
      item
        CollectionIndex = 53
        CollectionName = 'HeatStatusClosedActive'
        Name = 'HeatStatusClosedActive'
      end
      item
        CollectionIndex = 56
        CollectionName = 'HeatOpen'
        Name = 'HeatOpen'
      end
      item
        CollectionIndex = 57
        CollectionName = 'HeatRaced'
        Name = 'HeatRaced'
      end
      item
        CollectionIndex = 58
        CollectionName = 'HeatClosed'
        Name = 'HeatClosed'
      end
      item
        CollectionIndex = 59
        CollectionName = 'HeatStatusToggle'
        Name = 'HeatStatusToggle'
      end
      item
        CollectionIndex = 61
        CollectionName = 'Sort'
        Name = 'Sort'
      end
      item
        CollectionIndex = 62
        CollectionName = 'Exit'
        Name = 'Exit'
      end
      item
        CollectionIndex = 63
        CollectionName = 'import'
        Name = 'import'
      end
      item
        CollectionIndex = 64
        CollectionName = 'settings'
        Name = 'settings'
      end
      item
        CollectionIndex = 65
        CollectionName = 'home'
        Name = 'home'
      end
      item
        CollectionIndex = 66
        CollectionName = 'Help'
        Name = 'Help'
      end
      item
        CollectionIndex = 67
        CollectionName = 'info'
        Name = 'info'
      end
      item
        CollectionIndex = 68
        CollectionName = 'clone'
        Name = 'clone'
      end
      item
        CollectionIndex = 69
        CollectionName = 'Edit'
        Name = 'Edit'
      end
      item
        CollectionIndex = 70
        CollectionName = 'Export'
        Name = 'Export'
      end
      item
        CollectionIndex = 71
        CollectionName = 'TimeAuto'
        Name = 'TimeAuto'
      end>
    ImageCollection = ImageCollection1
    Width = 32
    Height = 32
    Left = 424
    Top = 352
  end
end
