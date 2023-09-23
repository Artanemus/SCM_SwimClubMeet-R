unit dlgTeamNamePicker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dmSCM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.StdCtrls;

type
  TTeamNamePicker = class(TForm)
    qryTeamNames: TFDQuery;
    dsTeamNames: TDataSource;
    Grid: TDBGrid;
    qryTeamNamesTeamNameID: TFDAutoIncField;
    qryTeamNamesstrTeamName: TWideStringField;
    btnOk: TButton;
    RelativePanel1: TRelativePanel;
    procedure btnOkClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FConnection: TFDConnection;
    fTeamID, fTeamNameID: integer;
  public
    { Public declarations }
    procedure Prepare(AConnection: TFDConnection; aTeamID: integer);

  end;

var
  TeamNamePicker: TTeamNamePicker;

implementation

{$R *.dfm}

procedure TTeamNamePicker.btnOkClick(Sender: TObject);
var
  SQL: string;
  aTeamNameID: integer;
begin
  Modalresult := mrCancel;
  // Assign TeamNameID to table Team with ID TeamID
  if Assigned(FConnection) and qryTeamNames.Active then
  begin
    SQL := 'UPDATE SwimClubMeet.dbo.Team SET Team.TeamNameID = :ID1 ' +
      'WHERE Team.TeamID = :ID2';
    aTeamNameID := Grid.DataSource.DataSet.FieldByName('TeamNameID').AsInteger;
    if (aTeamNameID > 0) then
    begin
      FConnection.ExecSQL(SQL, [aTeamNameID, fTeamID]);
      Modalresult := mrOk;
    end;
  end;
end;

procedure TTeamNamePicker.GridDblClick(Sender: TObject);
begin
  btnOkClick(Sender);
end;

procedure TTeamNamePicker.FormCreate(Sender: TObject);
begin
  fTeamID := 0;
  fTeamNameID := 0;
end;

procedure TTeamNamePicker.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
  if Key = VK_RETURN then
    btnOkClick(Sender);
end;

procedure TTeamNamePicker.Prepare(AConnection: TFDConnection; aTeamID: integer);
var
v: variant; // EventID;
SQL: string;
begin
  if Assigned(AConnection) then
  begin
    fConnection := AConnection;
    fTeamID := aTeamID;
    // find the event ID for the team....
    SQL := 'SELECT [Event].EventID FROM SwimClubMeet.dbo.Team ' +
    'INNER JOIN HeatIndividual ON Team.HeatID = HeatIndividual.HeatID  ' +
    'INNER JOIN [Event] ON HeatIndividual.EventID = [Event].EventID ' +
    'WHERE Team.TeamID = :ID';
    v := fConnection.ExecSQLScalar(SQL, [aTeamID]);
    if VarIsNull(v) or VarIsEmpty(v) or (v=0)  then exit;
    qryTeamNames.Connection  := FConnection;
    qryTeamNames.ParamByName('EVENTID').AsInteger := v;
    qryTeamNames.Prepare;
    qryTeamNames.Open;
  end;
end;

end.
