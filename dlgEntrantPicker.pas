unit dlgEntrantPicker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  System.Actions, Vcl.ActnList, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.VirtualImage,
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, SCMDefines;

type
  TEntrantPicker = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    btnPost: TButton;
    btnCancel: TButton;
    btnToggleName: TButton;
    Nominate_Edit: TEdit;
    qryQuickPick: TFDQuery;
    qryQuickPickMemberID: TIntegerField;
    qryQuickPickFName: TWideStringField;
    qryQuickPickTTB: TTimeField;
    qryQuickPickPB: TTimeField;
    qryQuickPickAGE: TIntegerField;
    qryQuickPickGender: TWideStringField;
    dsQuickPick: TDataSource;
    FDCommandUpdateEntrant: TFDCommand;
    qryQuickPickEventID: TIntegerField;
    qryQuickPickGenderID: TIntegerField;
    ImageCollection1: TImageCollection;
    VirtualImage2: TVirtualImage;
    procedure btnCancelClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Nominate_EditChange(Sender: TObject);
    procedure btnToggleNameClick(Sender: TObject);
  private
    { Private declarations }
    fToggleNameState: boolean;
    fID: Integer; // Either EntrantID or TeamEntrantID
    FConnection: TFDConnection;
    fEventType: scmEventType;
    prefUseDefRaceTime: boolean;
    prefRaceTimeTopPercent: double;
    prefHeatAlgorithm: Integer;
    ToggleState: Array [0 .. 4] of boolean;

    function AssertConnection(AConnection: TFDConnection): boolean;
    function UpdateEntrantData(): boolean;
    function LocateMemberID(AMemberID: Integer; ADataSet: TDataSet): boolean;
    procedure UpdateGridTitleBar(ColumnID: Integer);
    function NormalizeDistanceID(aDistanceID: integer): integer;
    function GetEventDistanceID(aEventID: integer): integer;

  public
    { Public declarations }
    function Prepare(AConnection: TFDConnection;
  EntrantIDTeamEntrantID: Integer; aEventType: scmEventType): boolean;
  end;

var
  EntrantPicker: TEntrantPicker;

implementation

{$R *.dfm}

uses SCMUtility, IniFiles, System.Math;

function TEntrantPicker.AssertConnection(AConnection: TFDConnection): boolean;
begin
  result := false;
  if Assigned(AConnection) then
    if AConnection.Connected then result := true;
end;

procedure TEntrantPicker.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TEntrantPicker.btnPostClick(Sender: TObject);
begin
  if not qryQuickPick.Active then exit;
  if UpdateEntrantData then
    ModalResult := mrOk else
    ModalResult := mrCancel;
end;

procedure TEntrantPicker.btnToggleNameClick(Sender: TObject);
var
  MemberID: Integer;
begin
  fToggleNameState := not fToggleNameState;
  with dsQuickPick.DataSet as TFDQuery do
  begin
    MemberID := FieldByName('MemberID').AsInteger;
    DisableControls;
    Close;
    ParamByName('TOGGLENAME').AsBoolean := fToggleNameState;
    Prepare;
    Open;
    if (Active) then LocateMemberID(MemberID, dsQuickPick.DataSet);
    EnableControls();
  end;
end;

procedure TEntrantPicker.DBGrid1DblClick(Sender: TObject);
var
  Pt: TPoint;
  Coord: TGridCoord;
begin
  // if titles are enabled - check that the double click didn't
  // occur in the title bar.
  if (dgTitles in TDBGrid(Sender).Options) then
  begin
    Pt := TDBGrid(Sender).ScreenToClient(Mouse.CursorPos);
    Coord := TDBGrid(Sender).MouseCoord(Pt.X, Pt.Y);
    // row zero is title bar.
    if (Coord.Y <> 0) then btnPostClick(Sender);
  end
  else btnPostClick(Sender);
end;

procedure TEntrantPicker.DBGrid1TitleClick(Column: TColumn);
begin
  // toggle the state of ASC or DESC.
  ToggleState[Column.ID] := not ToggleState[Column.ID];
  UpdateGridTitleBar(Column.ID);
end;

procedure TEntrantPicker.FormCreate(Sender: TObject);
var
  iniFileName: String;
  ifile: TIniFile;
  i: Integer;
begin
  prefUseDefRaceTime := true;
  prefRaceTimeTopPercent := 50.0;
  prefHeatAlgorithm := 1; // Base is zero
  fID := 0;
  fEventType := etUnknown;

  // ---------------------------------------------------------
  // A S S I G N   P R E F E R E N C E S ...
  // ---------------------------------------------------------
  iniFileName := GetSCMPreferenceFileName();
  if (FileExists(iniFileName)) then
  begin
    ifile := TIniFile.Create(iniFileName);
    // if TTB is 0 - use the def qualify time + percent....
    // reading integer resolves tri-states used by check boxes.
    i := ifile.ReadInteger('Preferences', 'UseDefRaceTime', 1);
    if i = 1 then prefUseDefRaceTime := true
    else prefUseDefRaceTime := false;

    prefRaceTimeTopPercent := ifile.ReadFloat('Preferences',
      'RaceTimeTopPercent', 50);
    // TTB defaults to (1) .. the entrant's average of top 3 race-times
    // Base is zero
    prefHeatAlgorithm := ifile.ReadInteger('Preferences', 'HeatAlgorithm', 1);
    ifile.Free;
  end;

  UpdateGridTitleBar(0);

end;

procedure TEntrantPicker.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then ModalResult := mrCancel;
end;

function TEntrantPicker.GetEventDistanceID(aEventID: integer): integer;
var
SQL: string;
v: variant;
begin
  result := 0;
  if not AssertConnection(FConnection) then exit;
  SQL := 'SELECT [DistanceID] FROM [SwimClubMeet].[dbo].[Event] '
  + 'WHERE [Event].[EventID] = :ID';
  v := FConnection.ExecSQLScalar(SQL, [aEventID]);
  if VarIsNull(v) or VarIsEmpty(v) or (v = 0) then exit;
  result := v;
end;

function TEntrantPicker.LocateMemberID(AMemberID: Integer;
  ADataSet: TDataSet): boolean;
var
  SearchOptions: TLocateOptions;
begin
  SearchOptions := SearchOptions + [loPartialKey];
  try
    result := ADataSet.Locate('MemberID', AMemberID, SearchOptions);
  except
    on E: Exception do result := false;
  end;
end;

procedure TEntrantPicker.Nominate_EditChange(Sender: TObject);
var
  fs: string;
begin
  with dsQuickPick.DataSet do
  begin
    if Active then
    begin
      fs := '';
      DisableControls;
      // update filter string ....
      if (Length(Nominate_Edit.Text) > 0) then
      begin
        fs := fs + '[FName] LIKE ' + QuotedStr('%' + Nominate_Edit.Text + '%');
      end;
      // assign filter
      if fs.IsEmpty then Filtered := false
      else
      begin
        Filter := fs;
        if not Filtered then Filtered := true;
      end;
      EnableControls;
    end;
  end;
end;

function TEntrantPicker.Prepare(AConnection: TFDConnection;
  EntrantIDTeamEntrantID: Integer; aEventType: scmEventType): boolean;
var
  SQL: string;
  v: variant;
  aEventID, aNormalizedDistanceID, aDistanceID: Integer;
begin
  result := false;
  if not AssertConnection(AConnection) then exit;

  // store for later use
  FConnection := AConnection;
  fID := EntrantIDTeamEntrantID;
  fEventType := aEventType;

  if aEventType = etINDV then
      SQL := 'SELECT [HeatIndividual].[EventID] FROM [SwimClubMeet].[dbo].[Entrant] '
      + 'INNER JOIN HeatIndividual ON [Entrant].[HeatID] = [HeatIndividual].[HeatID] '
      + 'WHERE [Entrant].[EntrantID] = :ID';

  if aEventType = etTEAM then
      SQL := 'SELECT [HeatIndividual].[EventID] FROM [SwimClubMeet].[dbo].[TeamEntrant] '
      + 'INNER JOIN Team ON [TeamEntrant].[TeamID] = [Team].[TeamID] ' +
      'INNER JOIN HeatIndividual ON [Team].[HeatID] = [HeatIndividual].[HeatID] '
      + 'WHERE [TeamEntrant].[TeamEntrantID] = :ID';

  v := FConnection.ExecSQLScalar(SQL, [fID]);
  if VarIsNull(v) or VarIsEmpty(v) or (v = 0) then exit;
  aEventID := v;

  aDistanceID := GetEventDistanceID(aEventID);
  // this is used by scalar functions dbo.TTB and dbo.PB.
  aNormalizedDistanceID := NormalizeDistanceID(aDistanceID);

  // ASSIGN CRITICAL PARAMS
  qryQuickPick.Connection := AConnection;
  qryQuickPick.ParamByName('EVENTID').AsInteger := aEventID;
  qryQuickPick.ParamByName('TOGGLENAME').AsBoolean := fToggleNameState;
  qryQuickPick.ParamByName('ALGORITHM').AsInteger := prefHeatAlgorithm;
  qryQuickPick.ParamByName('CALCDEFAULT').AsInteger :=
    Integer(prefUseDefRaceTime); // Safe - always 0 or 1.
  qryQuickPick.ParamByName('BOTTOMPERCENT').AsFloat :=
    double(prefRaceTimeTopPercent);
  qryQuickPick.ParamByName('EVENTTYPE').AsInteger := ord(aEventType);
  qryQuickPick.ParamByName('DISTANCEID').AsInteger := aNormalizedDistanceID;

  qryQuickPick.Prepare();
  qryQuickPick.Open();
  if (qryQuickPick.Active) then
  begin
    result := true;
  end;
end;

function TEntrantPicker.UpdateEntrantData(): boolean;
begin
  result := false;
  if not AssertConnection(FConnection) then exit;
  if dsQuickPick.DataSet.IsEmpty then exit;
  if (fID = 0) then exit;
  with dsQuickPick.DataSet do
  begin

    FDCommandUpdateEntrant.Connection := FConnection;
    FDCommandUpdateEntrant.ParamByName('MemberID').AsInteger :=
      FieldByName('MemberID').AsInteger;
    // FDCommandUpdateEntrant.ParamByName('ENTRANTID').AsInteger := fID;
    FDCommandUpdateEntrant.ParamByName('TTB').AsTime := FieldByName('TTB')
      .AsDateTime;
    FDCommandUpdateEntrant.ParamByName('PB').AsTime := FieldByName('PB')
      .AsDateTime;
    FDCommandUpdateEntrant.ParamByName('EVENTTYPE').AsInteger :=
      ord(fEventType);
    FDCommandUpdateEntrant.ParamByName('ID').AsInteger :=  fID;

    FDCommandUpdateEntrant.Prepare;
    FDCommandUpdateEntrant.Execute;
    result := true;
  end;
end;

procedure TEntrantPicker.UpdateGridTitleBar(ColumnID: Integer);
var
  idx: Integer;
  s: string;
begin
  DBGrid1.Columns[0].Title.Caption := 'Nominees';
  DBGrid1.Columns[1].Title.Caption := 'TimeToBeat';
  DBGrid1.Columns[2].Title.Caption := 'Personal Best';
  DBGrid1.Columns[3].Title.Caption := 'AGE';
  DBGrid1.Columns[4].Title.Caption := 'Gender';

  // This cryptic method works provided all indexes are listed in the
  // correct order and all are active...
  //
  idx := (ColumnID * 2) + Integer(ToggleState[ColumnID]);
  qryQuickPick.Indexes[idx].Selected := true;
  if ToggleState[ColumnID] then s := (#$02C4 + ' ')
  else s := (#$02C5 + ' ');

  DBGrid1.Columns[ColumnID].Title.Caption := s + DBGrid1.Columns[ColumnID]
    .Title.Caption;
end;

function TEntrantPicker.NormalizeDistanceID(aDistanceID: integer): integer;
var
  tbl: TFDTable;
  SearchOptions: TLocateOptions;
  foundit: Boolean;
  meters, aEventTypeID: integer;
begin
  result := 0; // Flags - failed to normalize.
  if not Assigned(fConnection) then exit;
  tbl := TFDTable.Create(self);
  tbl.TableName := 'SwimClubMeet..Distance';
  tbl.Connection := FConnection;
  tbl.IndexFieldNames := 'DistanceID';
  tbl.UpdateOptions.ReadOnly := true;
  tbl.Open;
  if tbl.Active then
  Begin
    // locate the
    foundit := tbl.Locate('DistanceID', aDistanceID, SearchOptions);
    if foundit then
    begin
      meters := tbl.FieldByName('Meters').AsInteger;
      aEventTypeID := tbl.FieldByName('EventTypeID').AsInteger;
      if aEventTypeID = 1 then // INDV EVENT
          result := aDistanceID
      else if aEventTypeID = 2 then // TEAM EVENT
      Begin
        // Total meters divided by number of swimmers.
        // It's ASSUMED that relays have 4 swimmer (Olympic Standard).
        meters := (meters div 4);
        // XReference : The distance swum by each swimmer in the relay.
        // Result is the ID of a INDV event.
        foundit := tbl.Locate('Meters; EventTypeID', VarArrayOf([meters, 1]),
          SearchOptions);
        // This normalized distance is required/used by scalar
        // functions dbo.TTB and dbo.PB
        if foundit then result := tbl.FieldByName('DistanceID').AsInteger;
      End;
    end;
  End;
  tbl.Close;
  tbl.Free;
end;

end.
