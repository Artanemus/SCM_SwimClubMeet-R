unit dlgHouse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.ExtDlgs, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  frxClass, frxDBSet, frxExportPDF, frxExportBaseDialog, frxExportXLS;

type
  THouse = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    shapeHouseColor: TShape;
    LogoImage: TImage;
    DBEdit1: TDBEdit;
    DBGrid2: TDBGrid;
    edtSearchHouseMember: TEdit;
    DBEdit2: TDBEdit;
    btnLoadHouseLogo: TButton;
    TabSheet4: TTabSheet;
    Label8: TLabel;
    btnUpdate: TButton;
    Edit2: TEdit;
    DBGrid3: TDBGrid;
    TabSheet3: TTabSheet;
    Label10: TLabel;
    btnHouseMemberRpt: TButton;
    Panel2: TPanel;
    btnClose: TButton;
    qryHouse: TFDQuery;
    qryHouseHouseID: TFDAutoIncField;
    qryHouseCaption: TWideStringField;
    qryHouseMotto: TWideStringField;
    qryHouseColor: TIntegerField;
    qryHouseLogoDir: TMemoField;
    qryHouseLogoImg: TBlobField;
    dsHouse: TDataSource;
    ColorDialog1: TColorDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    qryHouseMember: TFDQuery;
    qryHouseMemberHouseID: TIntegerField;
    qryHouseMemberMemberID: TFDAutoIncField;
    qryHouseMemberMembershipNum: TIntegerField;
    qryHouseMemberFName: TWideStringField;
    qryHouseMemberAGE: TIntegerField;
    dsHouseMember: TDataSource;
    DBNavigator1: TDBNavigator;
    frxHouseRpt: TfrxReport;
    qryHouseRpt: TFDQuery;
    frxXLSExport1: TfrxXLSExport;
    frxPDFExport1: TfrxPDFExport;
    frxDSHouseRpt: TfrxDBDataset;
    Label7: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure qryHouseColorGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure shapeHouseColorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure qryHouseLogoDirGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure btnLoadHouseLogoClick(Sender: TObject);
    procedure edtSearchHouseMemberChange(Sender: TObject);
    procedure btnHouseMemberRptClick(Sender: TObject);
    procedure qryHouseAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    fConnection: TFDConnection;

    procedure AssignHouseLogo(DataSet: TDataSet);
    procedure AssignHouseColor(DataSet: TDataSet);

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override; // optional
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);

    property Connection: TFDConnection read fConnection write fConnection;

  end;

var
  House: THouse;

implementation

{$R *.dfm}

uses Imaging.jpeg, Imaging.pngimage;

constructor THouse.Create(AOwner: TComponent);
begin
  inherited;
  fConnection := nil;
end;

constructor THouse.CreateWithConnection(AOwner: TComponent;
  aConnection: TFDConnection);
begin
  inherited Create(AOwner);
  fConnection := aConnection;
end;

procedure THouse.AssignHouseColor(DataSet: TDataSet);
var
  iColor: Integer;
begin
  // Assign the select color in the TColorBox
  iColor := DataSet.FieldByName('Color').AsInteger;
  if (iColor = 0) then
  begin
    shapeHouseColor.Brush.Color := clWhite;
  end
  else
    shapeHouseColor.Brush.Color := TColor(iColor);
end;

procedure THouse.AssignHouseLogo(DataSet: TDataSet);
var
  Stream: TStream;
  aJpgImage: TJPEGImage;
  aPngImage: TPngImage;
  fn, s: String;
begin
  if not(DataSet.FieldByName('LogoDir').IsNull) then
  begin
    // INITIALIZE
    stream := nil;
    aJpgImage := nil;
    aPngImage := nil;

    fn := DataSet.FieldByName('LogoDir').AsString;

    if not(fn.IsEmpty()) then
    begin
      s := ExtractFileExt(fn);
      s := LowerCase(s);
      if ((s = '.jpg') or (s = '.jpeg')) then
      begin
        try
          begin
            aJpgImage := TJPEGImage.Create;
            Stream := DataSet.CreateBlobStream
              (DataSet.FieldByName('LogoImg'), bmRead);
            // Stream.Position :=0;
            Stream.Seek(0, 0);
            aJpgImage.LoadFromStream(Stream);
            LogoImage.Picture.Assign(aJpgImage);
          end;
        finally
          begin
            aJpgImage.free;
            Stream.free;
          end;
        end;
      end
      else if (s = '.png') then
      begin
        try
          begin
            aPngImage := TPngImage.Create;
            Stream := DataSet.CreateBlobStream
              (DataSet.FieldByName('LogoImg'), bmRead);
            // Stream.Position :=0;
            Stream.Seek(0, 0);
            aPngImage.LoadFromStream(Stream);
            LogoImage.Picture.Assign(aPngImage);
          end;
        finally
          begin
            aPngImage.free;
            Stream.free;
          end;
        end;
      end
      else if (s = '.bmp') then
      begin
        try
          begin
            Stream := DataSet.CreateBlobStream
              (DataSet.FieldByName('LogoImg'), bmRead);
            // Stream.Position :=0;
            Stream.Seek(0, 0);
            // works because Bitmap type is registered with TImage
            LogoImage.Picture.Graphic.LoadFromStream(Stream);
          end;
        finally
          begin
            Stream.free;
          end;
        end;
      end
      else
      begin
        //
        LogoImage.Picture.Assign(nil);
      end;
    end;
  end;

end;

procedure THouse.btnCloseClick(Sender: TObject);
begin
  modalresult := mrok;
end;

procedure THouse.btnHouseMemberRptClick(Sender: TObject);
begin
  if Assigned(fConnection) then
  begin
    qryHouseRpt.Connection := fConnection;
    qryHouseRpt.Open;
    frxHouseRpt.ShowReport;
    qryHouseRpt.Close;
  end;
end;

procedure THouse.btnLoadHouseLogoClick(Sender: TObject);
begin
  if Assigned(fConnection) then
  begin
    if (qryHouse.Active) then
    begin
      // Execute an open picture dialog.
      if (OpenPictureDialog1.Execute()) then
      begin
        // First check if the file exists.
        if (FileExists(OpenPictureDialog1.FileName)) then
        begin
          qryHouse.Edit;
          // the filename is used to identify the graphic type.
          qryHouse.FieldByName('LogoDir').AsString :=
            OpenPictureDialog1.FileName;
          (qryHouse.FieldByName('LogoImg') as TBlobField)
            .LoadFromFile(OpenPictureDialog1.FileName);
          qryHouse.Post;
          // Display the new logo into the UI
          AssignHouseLogo(qryHouse);
        end
        else
        begin
          // Otherwise, raise an exception.
          raise Exception.Create('File does not exist.')
            at @THouse.btnLoadHouseLogoClick;
        end;
      end;
    end
    else
      Beep;
  end;
end;

procedure THouse.edtSearchHouseMemberChange(Sender: TObject);
var
  fs: String;
  ds: TDataSet;
begin
  if Assigned(fConnection) then
  begin
    if (dsHouseMember.DataSet.Active) then
    begin
      fs := '';
      ds := dsHouseMember.DataSet;
      ds.DisableControls;
      // update filter string ....
      if (Length(edtSearchHouseMember.Text) > 0) then
        fs := fs + '[FName] LIKE ' +
          QuotedStr('%' + edtSearchHouseMember.Text + '%');
      // assign filter
      if (fs.IsEmpty) then
        ds.Filtered := false
      else
      begin
        ds.Filter := fs;
        if not(ds.Filtered) then
          ds.Filtered := true;
      end;
      ds.EnableControls;
    end;
  end;
end;

procedure THouse.FormCreate(Sender: TObject);
begin
  PageControl1.TabIndex := 0;
  if Assigned(fConnection) then
  begin
    qryHouse.Connection := fConnection;
    qryHouseMember.Connection := fConnection;
    qryHouse.Open;
    qryHouseMember.Open;
  end;
end;

procedure THouse.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_escape then
  begin
    // finalize edits
    modalresult := mrok;
  end;
end;

procedure THouse.qryHouseAfterScroll(DataSet: TDataSet);
begin
  // Display house logo and color in the UI.
  AssignHouseLogo(DataSet);
  AssignHouseColor(DataSet);
end;

procedure THouse.qryHouseColorGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  // DisplayText is true if the field's value is to be used for display only;
  // false if the string is to be used for editing the field's value.
  if (DisplayText) then
  begin
    Text := '';
  end
  else
    Text := Sender.AsString;
end;

procedure THouse.qryHouseLogoDirGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  // DisplayText is true if the field's value is to be used for display only;
  // false if the string is to be used for editing the field's value.
  if (DisplayText) then
    Text := Sender.AsString
  else
    Text := Sender.AsString;
end;

procedure THouse.shapeHouseColorMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  iColor: Integer;
begin
  if Assigned(fConnection) then
  begin
    // pick the house color
    if (qryHouse.Active) then
    begin
      if (qryHouse.IsEmpty()) then
      begin
        ColorDialog1.Color := clWhite;
        shapeHouseColor.Brush.Color := clWhite;
      end
      else
      begin
        iColor := qryHouse.FieldByName('Color').AsInteger;
        if (iColor = 0) then
          ColorDialog1.Color := clWhite
        else
          ColorDialog1.Color := TColor(iColor);
      end;
      if (ColorDialog1.Execute()) then
      begin
        qryHouse.Edit();
        qryHouse.FieldByName('Color').AsInteger := ColorDialog1.Color;
        qryHouse.Post();
        shapeHouseColor.Brush.Color := ColorDialog1.Color;
      end;

    end;
  end;
end;

end.
