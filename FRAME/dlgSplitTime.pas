unit dlgSplitTime;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dmSCM, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.Buttons;

type
  TSplitTime = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    btnPost: TButton;
    qryTeamSplit: TFDQuery;
    dsTeamSplit: TDataSource;
    qryTeamSplitTeamSplitID: TFDAutoIncField;
    qryTeamSplitSplitTime: TTimeField;
    qryTeamSplitTeamID: TIntegerField;
    qryTeam: TFDQuery;
    dsTeam: TDataSource;
    qryTeamTeamID: TFDAutoIncField;
    qryTeamRaceTime: TTimeField;
    qryTeamTeamNameStr: TWideStringField;
    qryTeamSplitLapNum: TIntegerField;
    btnCancel: TButton;
    DBGrid2: TDBGrid;
    VirtualImageList1: TVirtualImageList;
    ImageCollection1: TImageCollection;
    spbtnMoveUp: TSpeedButton;
    sbtnMoveDown: TSpeedButton;
    sbtnNew: TSpeedButton;
    sbtnDelete: TSpeedButton;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure qryTeamRaceTimeSetText(Sender: TField; const Text: string);
    procedure qryTeamSplitNewRecord(DataSet: TDataSet);
    procedure sbtnDeleteClick(Sender: TObject);
    procedure sbtnMoveDownClick(Sender: TObject);
    procedure sbtnNewClick(Sender: TObject);
    procedure spbtnMoveUpClick(Sender: TObject);
    procedure TimeFieldGetText(Sender: TField; var Text: string; DisplayText:
        Boolean);
    procedure TimeFieldSetText(Sender: TField; const Text: string);
  private
    { Private declarations }
    fTeamID: integer;
    fConnection: TFDConnection;
    fDefLapNum: integer;
    procedure RenumberLaps(aTeamID: integer);
//    function LocateTeam(ATeamID: Integer): Boolean;
// !00:00.000;1;0
  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      aConnection: TFDConnection);
    property TeamID: integer read FTeamID write FTeamID;
  end;

var
  SplitTime: TSplitTime;

implementation

{$R *.dfm}

procedure TSplitTime.btnCancelClick(Sender: TObject);
begin
  dsTeam.DataSet.Cancel;
  dsTeamSplit.DataSet.Cancel;
  fTeamID := 0;
  ModalResult := mrCancel;
end;

procedure TSplitTime.FormCreate(Sender: TObject);
begin
  fTeamID := 0;
  fDefLapNum := 0;
  if not Assigned(fConnection) then
    raise Exception.Create('Connection not assigned.');
  qryTeam.Connection := fConnection;
  qryTeamSplit.Connection := fConnection;
end;

procedure TSplitTime.btnPostClick(Sender: TObject);
begin
  if (dsTeam.DataSet.State = dsEdit) or (dsTeam.DataSet.State = dsInsert) then
      dsTeam.DataSet.Post;
  if (dsTeamSplit.DataSet.State = dsEdit) or
    (dsTeamSplit.DataSet.State = dsInsert) then dsTeamSplit.DataSet.Post;
  ModalResult := mrOk;
end;

constructor TSplitTime.CreateWithConnection(AOwner: TComponent;
  aConnection: TFDConnection);
begin
   inherited Create(AOwner);
  fConnection := aConnection;
end;

procedure TSplitTime.DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) then Key := 0;
end;

procedure TSplitTime.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    dsTeam.DataSet.Cancel;
    dsTeamSplit.DataSet.Cancel;
    Key := 0;
    fTeamID := 0;
    ModalResult := mrCancel;
  end;
end;

procedure TSplitTime.FormShow(Sender: TObject);
begin
  if TeamID = 0 then Close;

  qryTeam.Close;
  qryTeam.ParamByName('TEAMID').AsInteger := fTeamID;
  qryTeam.Prepare;
  qryTeam.Open;
  qryTeamSplit.Close;
  qryTeamSplit.ParamByName('TEAMID').AsInteger := fTeamID;
  qryTeamSplit.Prepare;
  qryTeamSplit.Open;

  // Team not found
  if not qryTeam.Active or qryTeam.IsEmpty then Close;

  if not qryTeamSplit.IsEmpty then
  begin
    dsTeamSplit.DataSet.DisableControls;
    RenumberLaps(fTeamID);
    dsTeamSplit.DataSet.Refresh;
    dsTeamSplit.DataSet.EnableControls;
  end;

  fDefLapNum := qryteamSplit.RecordCount;

  Caption := qryTeam.FieldByName('TeamNameStr').AsString;

end;

procedure TSplitTime.qryTeamRaceTimeSetText(Sender: TField; const Text: string);
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
    // EditMask does say fill with zeros. Apparently not working.
    s := Text;
    for i := 1 to Length(s) do
    begin
      if (s[i] = ' ') then s[i] := '0';
    end;

    try
      dt := StrToTime(s, LFormatSettings);
      Sender.AsDateTime := dt;
    except
      on E: EConvertError do
      begin
        ShowMessage('Invalid time format: ' + E.Message);
      end;
    end;
  end;
end;

procedure TSplitTime.qryTeamSplitNewRecord(DataSet: TDataSet);
begin
  fDefLapNum := fDefLapNum + 1;
  DataSet.FieldByName('TeamID').AsInteger := fTeamID;
  Dataset.FieldByName('LapNum').AsInteger := fDefLapNum;
end;

procedure TSplitTime.TimeFieldGetText(Sender: TField; var Text: string;
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

procedure TSplitTime.TimeFieldSetText(Sender: TField; const Text: string);
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

{
function TSplitTime.LocateTeam(ATeamID: Integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  if not qryTeam.Active then exit;
  SearchOptions := [];
  result := qryTeam.Locate('TeamID', ATeamID, SearchOptions);
end;
}

procedure TSplitTime.RenumberLaps(aTeamID: integer);
var
  qry: TFDQuery;
  i, aTeamSplitID: integer;
  sl: TStringList;
begin
  if not Assigned(fConnection) then exit;  // no connection
  sl := TStringList.Create;
  // Legal, qryEvent has master..child relationship with dsSession.
  sl.Add('USE [SwimClubMeet]; ');
  sl.Add('SELECT [TeamSplitID], [LapNum] FROM [dbo].[TeamSplit] ');
  sl.Add('WHERE [TeamID] = ' + IntToStr(aTeamID));
  sl.Add(' ORDER BY [LapNum];');
  // Find valid EventNum
  qry := TFDQuery.Create(self);
  qry.Connection := fConnection;
  qry.SQL := sl;
  qry.UpdateOptions.KeyFields := 'TeamSplitID';
  qry.UpdateOptions.UpdateTableName := 'SwimClubMeet..TeamSplit';
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

procedure TSplitTime.sbtnDeleteClick(Sender: TObject);
var
  aTeamSlitID: integer;
  SQL: string;
begin
//  if (dsTeamSplit.DataSet.State = dsEdit) then
    dsTeamSplit.DataSet.delete;

  {
  aTeamSlitID := dsTeamSplit.DataSet.FieldByName('TeamSplitID').AsInteger;
//  dsTeamSplit.DataSet.CheckBrowseMode;
  dsTeamSplit.DataSet.DisableControls;
  SQL := 'DELETE FROM SwimClubMeet.dbo.TeamSplit WHERE TeamSplit.TeamSplitID = :ID';
  fConnection.ExecSQL(SQL, [aTeamSlitID]);
  dsTeamSplit.DataSet.EnableControls;
  dsTeamSplit.DataSet.Refresh;
  }
end;

procedure TSplitTime.sbtnMoveDownClick(Sender: TObject);
var
  bm: TBookmark;
  enA, enB: integer;
  ds: TDataSet;
  fld: TField;
begin
  ds := DBGrid1.DataSource.DataSet;
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

procedure TSplitTime.sbtnNewClick(Sender: TObject);
var
fld:TField;
begin

    fld := dsTeamSplit.DataSet.FindField('LapNum');
    if Assigned(fld) then fld.ReadOnly := false;
    dsTeamSplit.DataSet.insert;
    dsTeamSplit.DataSet.post;
    if Assigned(fld) then fld.ReadOnly := true;

  if not qryTeamSplit.IsEmpty then
  begin
    dsTeamSplit.DataSet.DisableControls;
    RenumberLaps(fTeamID);
    dsTeamSplit.DataSet.Refresh;

    dsTeamSplit.DataSet.EnableControls;
  end;
  dsTeamSplit.DataSet.Last;
end;

procedure TSplitTime.spbtnMoveUpClick(Sender: TObject);
// move event up
var
  bm: TBookmark;
  enA, enB: integer;
  ds: TDataSet;
  fld: TField;
begin
  ds := dbGrid1.DataSource.DataSet;
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




end.
