unit dlgSwimmerCategory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.VCLUI.Wait, dmSCM, Vcl.DBCtrls;

type
  TSwimmerCategory = class(TForm)
    btnClose: TButton;
    btnSwimCategoryDetailed: TButton;
    btnSwimCategoryTable: TButton;
    DBGrid1: TDBGrid;
    dsSwimmerCategory: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    qrySwimmerCategory: TFDQuery;
    qrySwimmerCategoryAgeFrom: TIntegerField;
    qrySwimmerCategoryAgeTo: TIntegerField;
    qrySwimmerCategoryCaption: TWideStringField;
    qrySwimmerCategoryIsActive: TBooleanField;
    qrySwimmerCategoryIsArchived: TBooleanField;
    qrySwimmerCategoryLongCaption: TWideStringField;
    qrySwimmerCategorySwimmerCategoryID: TFDAutoIncField;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    DBNavigator1: TDBNavigator;
    qrySwimmerCategoryTAG: TWideStringField;
    qryLUTAG: TFDQuery;
    qrySwimmerCategoryTAGID: TIntegerField;
    qrySwimmerCategoryluTAGID: TStringField;
    procedure btnCloseClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure qrySwimmerCategoryBeforePost(DataSet: TDataSet);
  private
    fColorBgColor: TColor;
    fColorEditBoxFocused: TColor;
    fColorEditBoxNormal: TColor;
    fConnection: TFDConnection;
    { Private declarations }
    fSwimClubID: Integer;
    procedure DrawCheckBoxes(oGrid: TObject; Rect: TRect; Column: TColumn;
      fontColor, bgColor: TColor);
  public
    { Public declarations }
    property Connection: TFDConnection write fConnection;
  end;

var
  SwimmerCategory: TSwimmerCategory;

implementation

uses Vcl.Themes;

{$R *.dfm}

procedure TSwimmerCategory.btnCloseClick(Sender: TObject);
begin
  dsSwimmerCategory.DataSet.CheckBrowseMode;
  ModalResult := mrOk;
end;

procedure TSwimmerCategory.DBGrid1CellClick(Column: TColumn);
begin
  if Assigned(Column.Field) and (Column.Field.DataType = ftBoolean) then
  begin
    Column.Grid.DataSource.DataSet.CheckBrowseMode;
    Column.Grid.DataSource.DataSet.Edit;
    Column.Field.AsBoolean := not Column.Field.AsBoolean;
  end;
end;

procedure TSwimmerCategory.DBGrid1ColEnter(Sender: TObject);
begin
  // By default, two clicks on the same cell enacts the cell editing mode.
  // The grid draws a TEditBox over the cell, killing the checkbox draw UI.
  with Sender as TDBGrid do
  begin
    if Assigned(SelectedField) and (SelectedField.DataType = ftBoolean) then
    begin
      Options := Options - [dgEditing];
    end;
  end;
end;

procedure TSwimmerCategory.DBGrid1ColExit(Sender: TObject);
begin
  with Sender as TDBGrid do
    if Assigned(SelectedField) and (SelectedField.DataType = ftBoolean) then
      Options := Options + [dgEditing];
end;

procedure TSwimmerCategory.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  clFont, clBg: TColor;
begin
  // NOTE : DEFAULT DRAWING IS DISABLED ....
  if (Column.Field.FieldName = 'IsActive') or
    (Column.Field.FieldName = 'IsArchived') then
  begin
    if gdFocused in State then
      clFont := fColorEditBoxFocused
    else
      clFont := fColorEditBoxNormal;
    clBg := fColorBgColor;
    DrawCheckBoxes(Sender, Rect, Column, clFont, clBg);
    // draw 'Focused' frame  (for boolean datatype only)
    if gdFocused in State then
      TDBGrid(Sender).Canvas.DrawFocusRect(Rect);
  end
  else
  begin
    TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if gdFocused in State then
      TDBGrid(Sender).Canvas.DrawFocusRect(Rect);
  end;
end;

procedure TSwimmerCategory.DrawCheckBoxes(oGrid: TObject; Rect: TRect;
  Column: TColumn; fontColor, bgColor: TColor);
var
  MyRect: TRect;
  oField: TField;
  iPos, iFactor: Integer;
  bValue: boolean;
  g: TDBGrid;
  points: Array [0 .. 4] of TPoint;
begin
  // ---------------------------------------------------------------------------
  // Draw a very basic checkbox (ticked) - not a nice as TCheckListBox
  // ---------------------------------------------------------------------------
  g := TDBGrid(oGrid);
  // is the cell checked?
  oField := Column.Field;
  if (oField.value = -1) then
    bValue := true
  else
    bValue := false;

  g.Canvas.Pen.Color := fontColor; //
  g.Canvas.Brush.Color := bgColor;
  g.Canvas.Brush.Style := bsSolid;
  g.Canvas.FillRect(Rect);

  // calculate margins
  MyRect.Top := Trunc((Rect.Bottom - Rect.Top - 17) / 2) + Rect.Top;
  MyRect.Left := Trunc((Rect.Right - Rect.Left - 17) / 2) + Rect.Left;
  MyRect.Bottom := MyRect.Top + 16;
  MyRect.Right := MyRect.Left + 16;

  // USES PEN - draw the box (with cell margins)
  points[0].x := MyRect.Left;
  points[0].y := MyRect.Top;
  points[1].x := MyRect.Right;
  points[1].y := MyRect.Top;
  points[2].x := MyRect.Right;
  points[2].y := MyRect.Bottom;
  points[3].x := MyRect.Left;
  points[3].y := MyRect.Bottom;
  points[4].x := MyRect.Left;
  points[4].y := MyRect.Top;

  g.Canvas.Polyline(points);

  iPos := MyRect.Left;
  iFactor := 1;
  // USES PEN - DRAW A TICK - Cross would be nicer?
  if bValue then
  begin
    // 16x16 grid. Pen width is 1 pixel.
    // tick falls
    g.Canvas.MoveTo(iPos + (iFactor * 2), MyRect.Top + 8);
    g.Canvas.LineTo(iPos + (iFactor * 2), MyRect.Top + 11);
    g.Canvas.MoveTo(iPos + (iFactor * 3), MyRect.Top + 9);
    g.Canvas.LineTo(iPos + (iFactor * 3), MyRect.Top + 12);
    g.Canvas.MoveTo(iPos + (iFactor * 4), MyRect.Top + 10);
    g.Canvas.LineTo(iPos + (iFactor * 4), MyRect.Top + 13);
    g.Canvas.MoveTo(iPos + (iFactor * 5), MyRect.Top + 11);
    g.Canvas.LineTo(iPos + (iFactor * 5), MyRect.Top + 14);
    // bottom ... flattens
    g.Canvas.MoveTo(iPos + (iFactor * 6), MyRect.Top + 12);
    g.Canvas.LineTo(iPos + (iFactor * 6), MyRect.Top + 15);
    g.Canvas.MoveTo(iPos + (iFactor * 7), MyRect.Top + 12);
    g.Canvas.LineTo(iPos + (iFactor * 7), MyRect.Top + 15);
    // tick rises
    g.Canvas.MoveTo(iPos + (iFactor * 8), MyRect.Top + 11);
    g.Canvas.LineTo(iPos + (iFactor * 8), MyRect.Top + 14);
    g.Canvas.MoveTo(iPos + (iFactor * 9), MyRect.Top + 10);
    g.Canvas.LineTo(iPos + (iFactor * 9), MyRect.Top + 13);
    g.Canvas.MoveTo(iPos + (iFactor * 10), MyRect.Top + 9);
    g.Canvas.LineTo(iPos + (iFactor * 10), MyRect.Top + 12);
    g.Canvas.MoveTo(iPos + (iFactor * 11), MyRect.Top + 8);
    g.Canvas.LineTo(iPos + (iFactor * 11), MyRect.Top + 11);
    g.Canvas.MoveTo(iPos + (iFactor * 12), MyRect.Top + 7);
    g.Canvas.LineTo(iPos + (iFactor * 12), MyRect.Top + 10);
    g.Canvas.MoveTo(iPos + (iFactor * 13), MyRect.Top + 6);
    g.Canvas.LineTo(iPos + (iFactor * 13), MyRect.Top + 9);
    g.Canvas.MoveTo(iPos + (iFactor * 14), MyRect.Top + 5);
    g.Canvas.LineTo(iPos + (iFactor * 14), MyRect.Top + 8);
    g.Canvas.MoveTo(iPos + (iFactor * 15), MyRect.Top + 4);
    g.Canvas.LineTo(iPos + (iFactor * 15), MyRect.Top + 7);
    g.Canvas.MoveTo(iPos + (iFactor * 16), MyRect.Top + 3);
    g.Canvas.LineTo(iPos + (iFactor * 16), MyRect.Top + 6);
  end;
end;

procedure TSwimmerCategory.FormCreate(Sender: TObject);
var
  css: TCustomStyleServices;
begin
  // i n i t   p a r a m s  .
  // -------------------------------------
  PageControl1.TabIndex := 0;
  fSwimClubID := 1;

  // Special color assignment - used in TDBGrid painting...
  // -------------------------------------------
  css := TStyleManager.Style[TStyleManager.ActiveStyle.Name];
  if Assigned(css) then
  begin
    fColorEditBoxFocused := css.GetStyleFontColor(sfEditBoxTextFocused);
    fColorEditBoxNormal := css.GetStyleFontColor(sfEditBoxTextNormal);
    fColorBgColor := css.GetStyleColor(scGrid);
  end
  else
  begin
    fColorEditBoxFocused := clWebTomato;
    fColorEditBoxNormal := clWindowText;
    fColorBgColor := clAppWorkSpace;
  end;
end;

procedure TSwimmerCategory.FormDestroy(Sender: TObject);
begin
  qrySwimmerCategory.Close;
end;

procedure TSwimmerCategory.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    dsSwimmerCategory.DataSet.CheckBrowseMode;
    ModalResult := mrCancel;
  end;
end;

procedure TSwimmerCategory.FormShow(Sender: TObject);
begin
  // -------------------------------------
  // C O N N E C T   L O C A L   D A T A S E T S  .
  // -------------------------------------
  if Assigned(fConnection) then
  begin
    qrySwimmerCategory.Connection := fConnection;
    // Activate tables/queries contained in this dialogue
    qrySwimmerCategory.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    qrySwimmerCategory.Prepare;
    qrySwimmerCategory.Open;
  end;
end;

procedure TSwimmerCategory.qrySwimmerCategoryBeforePost(DataSet: TDataSet);
var
fld: TField;
begin
  // IsArchived and IsActive NULLS NOT ALLOWED
  fld := DataSet.FieldByName('IsArchived');
  if Assigned(fld) AND (fld.IsNull) then
    fld.AsBoolean := false;
  fld := DataSet.FieldByName('IsActive');
  if Assigned(fld) AND (fld.IsNull) then
    fld.AsBoolean := false;
  {TODO -oBSA -cGeneral : Check TAG qualifies against SwimmerCategory
    for current SwimClubID ... dbo.ClubType }
end;

end.
