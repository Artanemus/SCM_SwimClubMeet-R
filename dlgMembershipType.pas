unit dlgmemberShipType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.VCLUI.Wait;

type
  TMembershipType = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel4: TPanel;
    DBGrid1: TDBGrid;
    TabSheet3: TTabSheet;
    Label2: TLabel;
    Label1: TLabel;
    btnMemShipTypeMember: TButton;
    btnMemShipTypeTable: TButton;
    Panel3: TPanel;
    btnClose: TButton;
    qryMembershipType: TFDQuery;
    qryMembershipTypeMembershipTypeID: TFDAutoIncField;
    qryMembershipTypeCaption: TWideStringField;
    qryMembershipTypeIsSwimmer: TBooleanField;
    qryMembershipTypeSort: TIntegerField;
    qryMembershipTypeAgeFrom: TIntegerField;
    qryMembershipTypeAgeTo: TIntegerField;
    qryMembershipTypeLongCaption: TWideStringField;
    qryMembershipTypeStartOfSwimSeason: TSQLTimeStampField;
    dsMembershipType: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure DBGrid1ColExit(Sender: TObject);
  private
    { Private declarations }
    fSwimClubID: integer;
    fConnection: TFDConnection;
    fColorEditBoxFocused: TColor;
    fColorEditBoxNormal: TColor;
    fColorBgColor: TColor;

    procedure DrawCheckBoxes(oGrid: TObject; Rect: TRect; Column: TColumn;
  fontColor, bgColor: TColor);

  public
    { Public declarations }
    property Connection: TFDConnection write FConnection;

  end;

var
  MembershipType: TMembershipType;

implementation

uses vcl.Themes;

{$R *.dfm}

procedure TMembershipType.btnCloseClick(Sender: TObject);
begin
  dsMembershipType.DataSet.CheckBrowseMode;
  ModalResult := mrOk;
end;

procedure TMembershipType.DBGrid1CellClick(Column: TColumn);
begin
  if Assigned(Column.Field) and (Column.Field.DataType = ftBoolean) then
  begin
    Column.Grid.DataSource.DataSet.CheckBrowseMode;
    Column.Grid.DataSource.DataSet.Edit;
    Column.Field.AsBoolean := not Column.Field.AsBoolean;
  end;
end;

procedure TMembershipType.DBGrid1ColEnter(Sender: TObject);
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

procedure TMembershipType.DBGrid1ColExit(Sender: TObject);
begin
  with Sender as TDBGrid do
  if Assigned(SelectedField) and   (SelectedField.DataType = ftBoolean) then
    Options := Options + [dgEditing];
end;

procedure TMembershipType.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  clFont, clBg: TColor;
begin
  // NOTE : DEFAULT DRAWING IS DISABLED ....
  if (Column.Field.FieldName = 'IsSwimmer') then
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

procedure TMembershipType.DrawCheckBoxes(oGrid: TObject; Rect: TRect; Column: TColumn;
  fontColor, bgColor: TColor);
var
  MyRect: TRect;
  oField: TField;
  iPos, iFactor: integer;
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

procedure TMembershipType.FormCreate(Sender: TObject);
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

procedure TMembershipType.FormDestroy(Sender: TObject);
begin
  qryMembershipType.Close;
end;

procedure TMembershipType.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    dsMembershipType.DataSet.CheckBrowseMode;
    ModalResult := mrCancel;
  end;
end;

procedure TMembershipType.FormShow(Sender: TObject);
begin
  // -------------------------------------
  // C O N N E C T   L O C A L   D A T A S E T S  .
  // -------------------------------------
  if assigned(fConnection) then
  begin
    qryMembershipType.Connection := fConnection;
    // Activate tables/queries contained in this dialogue
    qryMembershipType.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    qryMembershipType.Prepare;
    qryMembershipType.Open;
  end;
end;

end.
