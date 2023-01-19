unit dlgEntrantPickerCTRL;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Actions,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TEntrantPickerCTRL = class(TForm)
    Label1: TLabel;
    DBGrid1: TDBGrid;
    Nominate_Edit: TEdit;
    btnPost: TButton;
    btnCancel: TButton;
    btnToggleName: TButton;
    dsQuickPickCtrl: TDataSource;
    qryQuickPickCtrl: TFDQuery;
    qryQuickPickCtrlMemberID: TFDAutoIncField;
    qryQuickPickCtrlFName: TWideStringField;
    qryQuickPickCtrlTTB: TTimeField;
    qryQuickPickCtrlPB: TTimeField;
    qryQuickPickCtrlAGE: TIntegerField;
    qryQuickPickCtrlGender: TWideStringField;
    FDCommandUpdateEntrant: TFDCommand;
    qryQuickPickCtrlGenderID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPostClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnToggleNameClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Nominate_EditChange(Sender: TObject);
  private
    { Private declarations }
    fToggleNameState: boolean;
    fEntrantID: integer;
    fEventID: integer;
    FConnection: TFDConnection;
    prefUseDefRaceTime: boolean;
    prefRaceTimeTopPercent: double;
    prefHeatAlgorithm: integer;
    ToggleState: Array [0 .. 4] of boolean;

    function AssertConnection(AConnection: TFDConnection): boolean;
    function UpdateEntrantData(): boolean;
    function LocateMemberID(AMemberID: Integer; ADataSet: TDataSet): boolean;
    procedure UpdateGridTitleBar(ColumnID: integer);

  public
    { Public declarations }
    function Prepare(AConnection: TFDConnection; AEntrantID: integer): boolean;
  end;

var
  EntrantPickerCTRL: TEntrantPickerCTRL;

implementation

{$R *.dfm}

uses SCMUtility, System.IniFiles, dmSCMNom;
{ TEntrantPickerCTRL }

function TEntrantPickerCTRL.AssertConnection(AConnection
  : TFDConnection): boolean;
begin
  result := false;
  if Assigned(AConnection) then
    if AConnection.Connected then
      result := true;
end;

procedure TEntrantPickerCTRL.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TEntrantPickerCTRL.btnPostClick(Sender: TObject);
begin
  if not qryQuickPickCtrl.Active then
    exit;
  if UpdateEntrantData then
    ModalResult := mrOk;
end;

procedure TEntrantPickerCTRL.btnToggleNameClick(Sender: TObject);
var
  MemberID: integer;
begin
  fToggleNameState := not fToggleNameState;
  with dsQuickPickCTRL.DataSet as TFDQuery do
  begin
    MemberID := FieldByName('MemberID').AsInteger;
    DisableControls;
    Close;
    ParamByName('TOGGLENAME').AsBoolean := fToggleNameState;
    Prepare;
    Open;
    if (Active) then
      LocateMemberID(MemberID, dsQuickPickCTRL.DataSet);
    EnableControls();
  end;
end;

procedure TEntrantPickerCTRL.DBGrid1DblClick(Sender: TObject);
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
    if (Coord.Y <> 0) then
      btnPostClick(Sender);
  end
  else
    btnPostClick(Sender);
end;


procedure TEntrantPickerCTRL.DBGrid1TitleClick(Column: TColumn);
begin
  // toggle the state of ASC or DESC.
  ToggleState[Column.ID] := not ToggleState[Column.ID];
  UpdateGridTitleBar(Column.ID);
end;

procedure TEntrantPickerCTRL.FormCreate(Sender: TObject);
var
  iniFileName: String;
  ifile: TIniFile;
  i: integer;
begin

  prefUseDefRaceTime := true;
  prefRaceTimeTopPercent := 50.0;
  prefHeatAlgorithm := 1;  // Base is zero
  fEntrantID := 0;

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
    if i = 1 then
      prefUseDefRaceTime := true
    else
      prefUseDefRaceTime := false;

    prefRaceTimeTopPercent := ifile.ReadFloat('Preferences',
      'RaceTimeTopPercent', 50);
    // TTB defaults to (1) .. the entrant's average of top 3 race-times
    // Base is zero
    prefHeatAlgorithm := ifile.ReadInteger('Preferences', 'HeatAlgorithm', 1);
    ifile.Free;
  end;

   UpdateGridTitleBar(0);

end;

procedure TEntrantPickerCTRL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  ModalResult := mrCancel;
end;

function TEntrantPickerCTRL.LocateMemberID(AMemberID: integer;
  ADataSet: TDataSet): boolean;
var
  SearchOptions: TLocateOptions;
begin
  SearchOptions := SearchOptions + [loPartialKey];
  try
    result := ADataSet.Locate('MemberID', AMemberID, SearchOptions);
  except
    on E: Exception do
      result := false;
  end;
end;

procedure TEntrantPickerCTRL.Nominate_EditChange(Sender: TObject);
var
  fs: string;
begin
  with dsQuickPickCTRL.DataSet do
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
      if fs.IsEmpty then
        Filtered := false
      else
      begin
        Filter := fs;
        if not Filtered then
          Filtered := true;
      end;
      EnableControls;
    end;
  end;
end;

function TEntrantPickerCTRL.Prepare(AConnection: TFDConnection;
  AEntrantID: integer): boolean;
var
  SQL, rtnstr: string;
begin
  result := false;
  if not AssertConnection(AConnection) then
    exit;

  FConnection := AConnection;
  fEntrantID := AEntrantID;

  // find the event ID for the entrant record.
  SQL := 'SELECT [HeatIndividual].[EventID] FROM [SwimClubMeet].[dbo].[Entrant] '
    + 'INNER JOIN HeatIndividual ON [Entrant].[HeatID] = [HeatIndividual].[HeatID] '
    + 'WHERE [Entrant].[EntrantID] = :ENTRANTID';

  rtnstr := AConnection.ExecSQLScalar(SQL, [AEntrantID]);
  fEventID := StrToIntDef(rtnstr, 0);
  if (fEventID = 0) then
    exit;

  // ASSIGN CRITICAL PARAMS
  qryQuickPickCtrl.Connection := AConnection;
  qryQuickPickCtrl.ParamByName('EVENTID').AsInteger := fEventID;
  qryQuickPickCtrl.ParamByName('TOGGLENAME').AsBoolean := fToggleNameState;
  qryQuickPickCtrl.ParamByName('ALGORITHM').AsInteger := prefHeatAlgorithm;
  qryQuickPickCtrl.ParamByName('CALCDEFAULT').AsInteger :=
    integer(prefUseDefRaceTime); // Safe - always 0 or 1.
  qryQuickPickCtrl.ParamByName('BOTTOMPERCENT').AsFloat :=
    double(prefRaceTimeTopPercent);
  qryQuickPickCtrl.Prepare();
  qryQuickPickCtrl.Open();
  if (qryQuickPickCtrl.Active) then
  begin
    result := true;
  end;
end;

function TEntrantPickerCTRL.UpdateEntrantData: boolean;
var
  nom: TSCMNom;
begin
  result := false;
  if not AssertConnection(FConnection) then
    exit;
  if (fEntrantID = 0) then
    exit;
  if (fEventID = 0) then
    exit;
  with dsQuickPickCtrl.DataSet do
  begin
    // U P D A T E   N O M I N A T I O N S .
    nom := TSCMNom.CreateWithConnection(Self, FConnection);
    nom.NominateMember(FieldByName('MemberID').AsInteger, fEventID);
    nom.Free;

    // U P D A T E   E N T R A N T D A T A .
    FDCommandUpdateEntrant.Connection := FConnection;
    FDCommandUpdateEntrant.ParamByName('MEMBERID').AsInteger :=
      FieldByName('MemberID').AsInteger;
    FDCommandUpdateEntrant.ParamByName('ENTRANTID').AsInteger := fEntrantID;
    FDCommandUpdateEntrant.ParamByName('TTB').AsTime := FieldByName('TTB')
      .AsDateTime;
    FDCommandUpdateEntrant.ParamByName('PB').AsTime := FieldByName('PB')
      .AsDateTime;
    FDCommandUpdateEntrant.Prepare;
    FDCommandUpdateEntrant.Execute;
  end;
end;

procedure TEntrantPickerCTRL.UpdateGridTitleBar(ColumnID: integer);
var
idx: integer;
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
  idx := ColumnID + Integer(ToggleState[ColumnID]);
  qryQuickPickCtrl.Indexes[idx].Selected := true;
  if ToggleState[ColumnID] then
    s := (#$02C4 + ' ')
  else
    s := (#$02C5 + ' ');

  DBGrid1.Columns[ColumnID].Title.Caption := s + DBGrid1.Columns[ColumnID]
    .Title.Caption;
end;

end.
