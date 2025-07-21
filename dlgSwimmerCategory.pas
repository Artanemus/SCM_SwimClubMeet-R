unit dlgSwimmerCategory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.VCLUI.Wait, dmSCM, Vcl.DBCtrls, Vcl.Buttons, AdvUtil, AdvObj,
  BaseGrid, AdvGrid, DBAdvGrid, Vcl.BaseImageCollection, SVGIconImageCollection,
	System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, SVGIconVirtualImageList,
	SVGIconImage,

	Vcl.Styles;

type
  TSwimmerCategory = class(TForm)
    btnClose: TButton;
    btnSwimCategoryDetailed: TButton;
    btnSwimCategoryTable: TButton;
    dsSwimmerCategory: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
    gridCAT: TDBAdvGrid;
    gridImageCollection: TSVGIconImageCollection;
    GridImageList: TSVGIconVirtualImageList;
    qrySwimmerCategoryNavIcon: TIntegerField;
    Image1: TImage;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
		procedure gridCATCustomCellBkgDraw(Sender: TObject; Canvas: TCanvas; ACol,
				ARow: Integer; AState: TGridDrawState; ARect: TRect; Printing: Boolean);
		procedure gridCATCustomCellDraw(Sender: TObject; Canvas: TCanvas; ACol, ARow:
				Integer; AState: TGridDrawState; ARect: TRect; Printing: Boolean);
    procedure qrySwimmerCategoryBeforePost(DataSet: TDataSet);
  private
    fColorBgColor: TColor;
    fColorEditBoxFocused: TColor;
    fColorEditBoxNormal: TColor;
		fConnection: TFDConnection;
		fColorFocusEffect: TColor;
		{ Private declarations }
		fSwimClubID: Integer;
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
		fColorFocusEffect := css.GetStyleColor(scButtonHot);
	end
	else
	begin
		fColorEditBoxFocused := clWebTomato;
		fColorEditBoxNormal := clWindowText;
		fColorBgColor := clAppWorkSpace;
		fColorFocusEffect := clHighLight;
	end;

	 { CHECKBOX Glyphs
	 - Enable TDBAdvGrid.ShowBooleanFields
	 - Create CheckBox SVGs for TSVGIconImageCollection.
	 - SET TDBAdvGrid.ControlLook.ControlStyle .. csGlyph
	 - SET TDBAdvGrid.ControlLook.CheckSize no effect. (uses GridImageList.Size)
	 - Assign ControlLook.CheckedGlyph, UnCheckedGlyph OnFormCreate.
	 - During design mode I assigned a fully empty-transparent
			(Alpha - 32 bit) BitMap. It required GIMP to do this. This correctly
			set the tranparency and is the simpliest way to deal with the problem.
			Writing the values 'in code' failed.
	 }

	if GridImageList.Count > 3 then //Check if index 3 exists
	begin
		try
			GridImageList.GetBitmap(1, gridCAT.ControlLook.UnCheckedGlyph);
			GridImageList.GetBitmap(2, gridCAT.ControlLook.CheckedGlyph);
		except on E: Exception do
			ShowMessage('Error loading Check/UnCheck Glyph bitmaps from TSVGIconVirtualList.');
		end;
	end;

	{ OPTIONS Editing...
	- Deals with TMS intermittent bug - can't perform editing in grid.
	- Additionally ... gridCAT.EditMode (boolean) keyboard shorcut F2.
	}
	gridCAT.Options := gridCAT.Options + [goEditing];

	{
	Query is sorted on PK.
	This makes insert of new record a little bit more manageable.
	}
	gridCAT.EditPostMode := epRow;

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

procedure TSwimmerCategory.gridCATCustomCellBkgDraw(Sender: TObject; Canvas:
		TCanvas; ACol, ARow: Integer; AState: TGridDrawState; ARect: TRect;
		Printing: Boolean);
begin
	{
	FOR RECORD INDICATOR ....
	if the rowIndicator is assigned (+ALPHA) - this background will be painted over
	with the FixColor.
	if not assigned - you get to see the background color.

		if ACol = 0 then
		begin
			if ARow = TDBAdvGrid(Sender).DataSource.DataSet.RecNo then
			begin
				Canvas.Brush.Color := $00CCA3B7; // fColorBgColor Set the brush color.
				Canvas.FillRect(ARect); // Fill background first.
			end;
		end;
	}

end;

procedure TSwimmerCategory.gridCATCustomCellDraw(Sender: TObject; Canvas:
  TCanvas; ACol, ARow: Integer; AState: TGridDrawState; ARect: TRect;
  Printing: Boolean);
begin
  { Record indicator:
   - RowIndicator = false
   - Toogle ParentFont if UI still shows default indicator icon.
	 - Create SVG RowIndicator for TSVGIconImageCollection.
	 }

	if ARow = TDBAdvGrid(Sender).DataSource.DataSet.RecNo then
  begin
    case ACol of
      0:
        begin
          GridImageList.Draw(Canvas, ARect.Left, ARect.Top + 10, 0);
        end;
		end;
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
