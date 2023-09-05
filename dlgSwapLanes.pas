unit dlgSwapLanes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ExtCtrls, dmSCM;

type
  TSwapLanes = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Shape1: TShape;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBNavigator3: TDBNavigator;
    DBNavigator4: TDBNavigator;
    Panel2: TPanel;
    btnCancel: TButton;
    btnSwapLanes: TButton;
    tblEntrantA: TFDTable;
    tblEntrantB: TFDTable;
    tblHeatA: TFDTable;
    tblHeatB: TFDTable;
    tblEvent: TFDTable;
    dsHeatA: TDataSource;
    dsEvent: TDataSource;
    dsHeatB: TDataSource;
    dsEntrantB: TDataSource;
    dsEntrantA: TDataSource;
    tblFNameB: TFDTable;
    tblFNameA: TFDTable;
    dsFNameA: TDataSource;
    dsFNameB: TDataSource;
    procedure btnSwapLanesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SwapLanes: TSwapLanes;

implementation

{$R *.dfm}
{ TSwapLanes }

procedure TSwapLanes.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TSwapLanes.btnSwapLanesClick(Sender: TObject);
begin
  SCM.Entrant_SwapLanes(tblEntrantA.FieldByName('EntrantID').AsInteger,
    tblEntrantB.FieldByName('EntrantID').AsInteger);
  ModalResult := mrOk;
end;

procedure TSwapLanes.FormCreate(Sender: TObject);
var
  Opts: TLocateOptions;
  i: integer;
  fEventID: integer;
begin

  if Assigned(SCM) then
  begin
    // As SCM is a TEMPORY connection - ASSERT assignment for FireDAC.
    tblEvent.Connection := SCM.scmConnection;
    tblFNameA.Connection := SCM.scmConnection;
    tblFNameB.Connection := SCM.scmConnection;
    tblHeatA.Connection := SCM.scmConnection;
    tblHeatB.Connection := SCM.scmConnection;
    tblEntrantA.Connection := SCM.scmConnection;
    tblEntrantB.Connection := SCM.scmConnection;

    // enable all datasets
    tblEvent.Open;
    tblHeatA.Open;
    tblHeatB.Open;
    tblEntrantA.Open;
    tblEntrantB.Open;
    tblFNameA.Open;
    tblFNameB.Open;

    // source eventID
    fEventID := SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger;
    dsEvent.DataSet.Filter := '[EventID] = ' + IntToStr(fEventID);
    // Master Source - init ...
    if not dsEvent.DataSet.Filtered then
      dsEvent.DataSet.Filtered := true;
    // assign the current selected heatNum
    i := SCM.dsHeat.DataSet.FieldByName('HeatID').AsInteger;
    dsHeatA.DataSet.Locate('HeatID', i, Opts);
    dsHeatB.DataSet.Locate('HeatID', i, Opts);
    // assign the current select entrant (lane)
    i := SCM.dsEntrant.DataSet.FieldByName('EntrantID').AsInteger;
    dsEntrantA.DataSet.Locate('EntrantID', i, Opts);
    dsEntrantB.DataSet.Locate('EntrantID', i, Opts);

  end;
end;

procedure TSwapLanes.FormDestroy(Sender: TObject);
begin
  tblEvent.Close;
  tblHeatA.Close;
  tblHeatB.Close;
  tblEntrantA.Close;
  tblEntrantB.Close;
  tblFNameA.Close;
  tblFNameB.Close;
end;

procedure TSwapLanes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    ModalResult := mrCancel;
end;

{$REGION 'DEPRECIATED CODE - USE FUNCTION IN SCM'}
(*
  function TSwapLanes.SwapAcrossHeats_MoveDown(var AHeatID: integer;
  var AEntrantID: integer): boolean;
  var
  Opts: TLocateOptions;
  i: integer;
  success: boolean;
  begin
  result := false;
  AHeatID := 0;
  AEntrantID := 0;
  // Get the destination heat number. (current heat number + 1)
  i := SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger + 1;
  // check : within range. Is it a valid heat number?
  if (i <= SCM.dsHeat.DataSet.RecordCount) then
  begin
  // locate that destination heat
  success := dsHeatB.DataSet.Locate('HeatNum', i, Opts);
  if (success) then
  begin
  // it this heat closed? (LOCKED)
  if not SCM.IsClosedHeat(dsHeatB.DataSet.FieldByName('HeatID').AsInteger)
  then
  begin
  // Locate the entrant record for the first lane of the destination heat.
  success := dsEntrantB.DataSet.Locate('Lane', 1, Opts);
  if (success) then
  begin
  // do the swap ....
  SCM.SwapLanes(tblEntrantA.FieldByName('EntrantID').AsInteger,
  tblEntrantB.FieldByName('EntrantID').AsInteger);
  // return info on the destination heat\entrant
  AHeatID := dsHeatB.DataSet.FieldByName('HeatID').AsInteger;
  AEntrantID := dsEntrantB.DataSet.FieldByName('EntrantID').AsInteger;
  result := true;
  end;
  end;
  end;
  end;
  end;

  function TSwapLanes.SwapAcrossHeats_MoveUp(AHeatID,
  AEntrantID: integer): boolean;
  var
  Opts: TLocateOptions;
  i: integer;
  success: boolean;
  begin
  aHeatID := NULL;
  aEntrantID := NULL;
  result := false;
  // Construction has done all initialisation of SOURCE
  // Prepare DESTINATION
  // get the destination heat number - subtract 1 from current
  i := SCM.dsHeat.DataSet.FieldByName('HeatNum').AsInteger - 1;
  success := false;
  // check range
  if (i > 0) then begin
  // locate that destination heat
  success := dsHeatB.DataSet.Locate('HeatNum',i, Opts);
  if (success) then begin
  if not SCM.IsClosedHeat(dsHeatB.DataSet.FieldByName('HeatID')	.AsInteger) then
  begin
  i := SCM.dsSwimClub.DataSet.FieldByName('NumOfLanes')	.AsInteger;
  // Locate the last lane in that destination heat
  dsEntrantB.DataSet.Locate('Lane',i, Opts);
  if (success) then
  begin
  // perform the swap ....
  btnSwapLanesClick(self);
  // last step - update form
  aHeatID := dsHeatB.DataSet.FieldByName('HeatID').AsInteger;
  aEntrantID := dsEntrantB.DataSet.FieldByName('EntrantID').AsInteger;
  end;
  end;
  end;
  end;
  end;
*)
{$ENDREGION}

end.
