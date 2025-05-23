unit dlgSplitTimeINDV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dmSCM, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.Buttons, Vcl.WinXCtrls;

type
  TSplitTimeINDV = class(TForm)
    btnPost: TButton;
    DBGridRaceTime: TDBGrid;
    DBGridSplit: TDBGrid;
    dsEntrant: TDataSource;
    dsSplit: TDataSource;
    ImageCollection1: TImageCollection;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    qryEntrant: TFDQuery;
    qryEntrantRaceTime: TTimeField;
    qrySplit: TFDQuery;
    qrySplitLapNum: TIntegerField;
    qrySplitSplitTime: TTimeField;
    sbtnDelete: TSpeedButton;
    sbtnMoveDown: TSpeedButton;
    sbtnNew: TSpeedButton;
    spbtnMoveUp: TSpeedButton;
    VirtualImageList1: TVirtualImageList;
    qryEntrantEntrantID: TFDAutoIncField;
    qryEntrantFullName: TWideStringField;
    qrySplitSplitID: TFDAutoIncField;
    qrySplitEntrantID: TIntegerField;
    RelativePanel1: TRelativePanel;
    procedure btnPostClick(Sender: TObject);
    procedure DBGridRaceTimeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure qryEntrantRaceTimeSetText(Sender: TField; const Text: string);
    procedure qrySplitNewRecord(DataSet: TDataSet);
    procedure sbtnDeleteClick(Sender: TObject);
    procedure sbtnMoveDownClick(Sender: TObject);
    procedure sbtnNewClick(Sender: TObject);
    procedure spbtnMoveUpClick(Sender: TObject);
    procedure TimeFieldGetText(Sender: TField; var Text: string; DisplayText:
        Boolean);
    procedure TimeFieldSetText(Sender: TField; const Text: string);
  private
    fConnection: TFDConnection;
    fMaxLapNum: integer;
    { Private declarations }
    fEntrantID: integer;
    procedure RenumberLaps(aEntrantID: integer);
  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);
    property EntrantID: integer read fEntrantID write fEntrantID;
  end;

var
  SplitTimeINDV: TSplitTimeINDV;

implementation

{$R *.dfm}

constructor TSplitTimeINDV.CreateWithConnection(AOwner: TComponent;
  aConnection: TFDConnection);
begin
   inherited Create(AOwner);
  fConnection := aConnection;
end;

procedure TSplitTimeINDV.btnPostClick(Sender: TObject);
begin
  dsEntrant.DataSet.CheckBrowseMode;
  dsSplit.DataSet.CheckBrowseMode;
  ModalResult := mrOk;
end;

procedure TSplitTimeINDV.DBGridRaceTimeKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) then Key := 0;
end;

procedure TSplitTimeINDV.FormCreate(Sender: TObject);
begin
  fEntrantID := 0;
  fMaxLapNum := 0;
  if not Assigned(fConnection) then
    raise Exception.Create('Connection not assigned.');
  qryEntrant.Connection := fConnection;
  qrySplit.Connection := fConnection;
end;

procedure TSplitTimeINDV.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    dsEntrant.DataSet.Cancel;
    dsSplit.DataSet.Cancel;
    Key := 0;
    fEntrantID := 0;
    ModalResult := mrCancel;
  end;
end;

procedure TSplitTimeINDV.FormShow(Sender: TObject);
begin
  if fEntrantID = 0 then Close;

  qryEntrant.Close;
  qryEntrant.ParamByName('ENTRANTID').AsInteger := fEntrantID;
  qryEntrant.Prepare;
  qryEntrant.Open;
  qrySplit.Close;
  qrySplit.ParamByName('ENTRANTID').AsInteger := fEntrantID;
  qrySplit.Prepare;
  qrySplit.Open;

  // Team not found
  if not qryEntrant.Active or qryEntrant.IsEmpty then Close;
  // Renumber Laps
  if not qrySplit.IsEmpty then
  begin
    dsSplit.DataSet.DisableControls;
    RenumberLaps(fEntrantID);
    dsSplit.DataSet.Refresh;
    dsSplit.DataSet.EnableControls;
  end;
  // MAX = RecordCount (after renumber)
  fMaxLapNum := qrySplit.RecordCount;

  Caption := qryEntrant.FieldByName('FullName').AsString;

end;

procedure TSplitTimeINDV.qryEntrantRaceTimeSetText(Sender: TField; const Text: string);
var
  dt: TDateTime;
  LFormatSettings: TFormatSettings;
  i: integer;
  s: string;
begin
  LFormatSettings := TFormatSettings.Create;
  LFormatSettings.TimeSeparator := ':';
  LFormatSettings.DecimalSeparator := '.';
  // I think StrToTime uses ShortTimeFormat
  LFormatSettings.LongTimeFormat := 'nn:ss.zzz';
  LFormatSettings.ShortTimeFormat := 'nn:ss.zzz';

  if Text.IsNullOrEmpty(Text) then Sender.Clear
  else
  begin
    // EditMask fills blanks with zeros. Text however isn't.
    s := Text;
    for i := 1 to Length(s) do
    begin
      if (s[i] = ' ') then s[i] := '0';
    end;
    // conversion to TTime
    try
      dt := StrToTime(s, LFormatSettings);
      Sender.AsDateTime := dt;
    except
      on E: EConvertError do
      begin
        ShowMessage('Invalid race-time format: ' + E.Message);
      end;
    end;
  end;
end;

procedure TSplitTimeINDV.qrySplitNewRecord(DataSet: TDataSet);
var
fld: Tfield;
begin
  fMaxLapNum := fMaxLapNum + 1;
  DataSet.FieldByName('EntrantID').AsInteger := fEntrantID;
  fld := DataSet.FindField('LapNum');
  if Assigned(fld) then fld.ReadOnly := false;
    Dataset.FieldByName('LapNum').AsInteger := fMaxLapNum;
  if Assigned(fld) then fld.ReadOnly := true;
end;

procedure TSplitTimeINDV.RenumberLaps(aEntrantID: integer);
var
  qry: TFDQuery;
  i: integer;
  sl: TStringList;
begin
  if not Assigned(fConnection) then exit;  // no connection
  sl := TStringList.Create;
  // Legal, qryEvent has master..child relationship with dsSession.
  sl.Add('USE [SwimClubMeet]; ');
  sl.Add('SELECT [SplitID], [LapNum] FROM [dbo].[Split] ');
  sl.Add('WHERE [EntrantID] = ' + IntToStr(aEntrantID));
  sl.Add(' ORDER BY [LapNum];');
  // Find valid EventNum
  qry := TFDQuery.Create(self);
  qry.Connection := fConnection;
  qry.SQL := sl;
  qry.UpdateOptions.KeyFields := 'SplitID';
  qry.UpdateOptions.UpdateTableName := 'SwimClubMeet..Split';
  qry.Open;
  if (qry.Active) then
  begin
    i := 1;
    // Clean up list after each new record - renumber event number
    while not qry.Eof do
    begin
      qry.Edit;
      qry.FieldByName('LapNum').AsInteger := i;
      qry.Post;
      i := i + 1;
      qry.Next;
    end;
  end;
  qry.Close;
  qry.Free;
  sl.Free;
end;

procedure TSplitTimeINDV.sbtnDeleteClick(Sender: TObject);
begin
  dsSplit.DataSet.delete;
  dsSplit.DataSet.DisableControls;
  RenumberLaps(fEntrantID);
  dsSplit.DataSet.Refresh;
  dsSplit.DataSet.EnableControls;
  fMaxLapNum := dsSplit.DataSet.RecordCount;
end;

procedure TSplitTimeINDV.sbtnMoveDownClick(Sender: TObject);
var
  bm: TBookmark;
  enA, enB: integer;
  ds: TDataSet;
  fld: TField;
begin
  ds := DBGridSplit.DataSource.DataSet;
  if not Assigned(SCM) then exit;
  if not ds.Active then exit;
  if ds.IsEmpty then exit;
  if SCM.IsLastRecord(ds) then
  begin
    beep;
    exit;
  end;

  fld := ds.FindField('LapNum');
  if Assigned(fld) then fld.ReadOnly := false;
  ds.DisableControls();
  bm := ds.Bookmark;
  enA := ds.FieldByName('LapNum').AsInteger;
  enB := 0;
  try
    ds.Next;
    enB := ds.FieldByName('LapNum').AsInteger;
    ds.Edit;
    ds.FieldByName('LapNum').AsInteger := enA;
    ds.Post;
  finally
    ds.Bookmark := bm;
    ds.Edit;
    ds.FieldByName('LapNum').AsInteger := enB;
    ds.Post;
  end;
  ds.Refresh;
  if Assigned(fld) then fld.ReadOnly := true;
  ds.EnableControls();
end;

procedure TSplitTimeINDV.sbtnNewClick(Sender: TObject);
var
  fld: TField;
begin
  // LapNum ... ReadOnly
  fld := dsSplit.DataSet.FindField('LapNum');
  if Assigned(fld) then fld.ReadOnly := false;
  dsSplit.DataSet.insert;
  dsSplit.DataSet.Post;
  if Assigned(fld) then fld.ReadOnly := true;
  dsSplit.DataSet.Last;
end;

procedure TSplitTimeINDV.spbtnMoveUpClick(Sender: TObject);
// move event up
var
  bm: TBookmark;
  enA, enB: integer;
  ds: TDataSet;
  fld: TField;
begin
  ds := DBGridSplit.DataSource.DataSet;
  if not Assigned(SCM) then exit;
  if not ds.Active then exit;
  if ds.IsEmpty then exit;
  if SCM.IsFirstRecord(ds) then
  begin
    beep;
    exit;
  end;

  fld := ds.FindField('LapNum');
  if Assigned(fld) then fld.ReadOnly := false;
  ds.DisableControls();
  bm := ds.Bookmark;
  enA := ds.FieldByName('LapNum').AsInteger;
  enB := 0;
  try
    begin
      ds.Prior;
      enB := ds.FieldByName('LapNum').AsInteger;
      ds.Edit;
      ds.FieldByName('LapNum').AsInteger := enA;
      ds.Post;
    end;
  finally
    begin
      ds.Bookmark := bm;
      ds.Edit;
      ds.FieldByName('LapNum').AsInteger := enB;
      ds.Post;
    end;
  end;
  if Assigned(fld) then fld.ReadOnly := true;
  ds.Refresh;
  ds.EnableControls();
end;

procedure TSplitTimeINDV.TimeFieldGetText(Sender: TField; var Text: string;
    DisplayText: Boolean);
var
  Hour, Min, Sec, MSec: word;
begin
  // CALLED BY TimeToBeat AND PersonalBest (Read Only fields)
  // this FIXES display format issues.
  DecodeTime(Sender.AsDateTime, Hour, Min, Sec, MSec);
  // DisplayText is true if the field's value is to be used for display only;
  // false if the string is to be used for editing the field's value.
  // "%" [index ":"] ["-"] [width] ["." prec] type
  if DisplayText then
  begin
    if (Min > 0) then Text := Format('%0:2u:%1:2.2u.%2:3.3u', [Min, Sec, MSec])
    else if ((Min = 0) and (Sec > 0)) then
        Text := Format('%1:2u.%2:3.3u', [Min, Sec, MSec])
    else if ((Min = 0) and (Sec = 0)) then Text := '';
  end
  else Text := Format('%0:2.2u:%1:2.2u.%2:3.3u', [Min, Sec, MSec]);
end;

procedure TSplitTimeINDV.TimeFieldSetText(Sender: TField; const Text: string);
var
  Min, Sec, MSec: word;
  s: string;
  dt: TDateTime;
  i: integer;
  failed: Boolean;
begin
  s := Text;
  failed := false;
  // Take the user input that was entered into the time mask and replace
  // spaces with '0'. Resulting in a valid TTime string.
  // UnicodeString is '1-based'
  for i := 1 to Length(s) do
  begin
    if (s[i] = ' ') then s[i] := '0';
  end;
  // SubString is '0-based'
  Min := StrToIntDef(s.SubString(0, 2), 0);
  Sec := StrToIntDef(s.SubString(3, 2), 0);
  MSec := StrToIntDef(s.SubString(6, 3), 0);
  try
    begin
      dt := EncodeTime(0, Min, Sec, MSec);
      Sender.AsDateTime := dt;
    end;
  except
    failed := true;
  end;

  if failed then Sender.Clear; // Sets the value of the field to NULL
end;



end.
