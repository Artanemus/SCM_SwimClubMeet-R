unit uFrameHeat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Data.DB,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.WinXCtrls, System.Actions,
  Vcl.ActnList,
  uSwimClub, uSession, uEvent, uHeat, uLane,
  dmSCM,dmCORE, dmIMG
  ;

type
  TFrameHeat = class(TFrame)
    gridHeat: TDBAdvGrid;
    rpnlHeatBtns: TRelativePanel;
    ShapeHeatBar1: TShape;
    ShapeHeatBar2: TShape;
    ShapeHeatBar3: TShape;
    ShapeHeatDot1: TShape;
    ShapeHeatDot2: TShape;
    ShapeHeatDot3: TShape;
    spbtnHeatAutoBuild: TSpeedButton;
    spbtnHeatBatchPrintSet: TSpeedButton;
    spbtnHeatDelete: TSpeedButton;
    spbtnHeatDown: TSpeedButton;
    spbtnHeatMarshall: TSpeedButton;
    spbtnHeatNew: TSpeedButton;
    spbtnHeatReport: TSpeedButton;
    spbtnHeatTimeKeeper: TSpeedButton;
    spbtnHeatToggleStatus: TSpeedButton;
    spbtnHeatUp: TSpeedButton;
    actnHeatList: TActionList;
    actnHeat_MoveUp: TAction;
    actnHeat_MoveDown: TAction;
    actnHeat_ToogleStatus: TAction;
    actnHeat_New: TAction;
    actnHeat_Delete: TAction;
    actnHeat_AutoBuild: TAction;
    actnHeat_MarshallSheet: TAction;
    actnHeat_TimeKeeperSheet: TAction;
    actnHeat_PrintSheets: TAction;
    actnHeat_Report: TAction;
    procedure actnHeat_MoveUpDownExecute(Sender: TObject);
    procedure actnHeat_DefaultUpdate(Sender: TObject);
    procedure actnHeat_NewExecute(Sender: TObject);
    procedure actnHeat_ToogleStatusExecute(Sender: TObject);
    procedure gridHeatGetDisplText(Sender: TObject; ACol, ARow: Integer; var Value:
        string);
  private
    { Private declarations }
    function AssertSCM(): boolean;
    function AssertCORE(): boolean;
  public
    { Public declarations }
  end;

implementation
uses
  SCMUtility;

{$R *.dfm}

procedure TFrameHeat.actnHeat_MoveUpDownExecute(Sender: TObject);
var
  aHeatID, recA, recB: integer;
  fld: TField;
  recPos: TRecordPos;
begin
  if not AssertCORE then exit;
  recPos := SCMUtility.GetRecordPosition(CORE.qryHeat);
  if recPos = rpMiddle then
  begin
    gridHeat.BeginUpdate;
    CORE.qryHeat.DisableControls();
    CORE.qryHeat.CheckBrowseMode;
    fld := CORE.qryHeat.FindField('HeatNum');
    if Assigned(fld) and fld.ReadOnly then fld.ReadOnly := false;
    try
      aHeatID := uHeat.PK;
      recA := CORE.qryHeat.FieldByName('HeatNum').AsInteger;
      recB := 0;
      try
        if TAction.UnitName.Contains('Down') then
          CORE.qryHeat.Next()
        else if TAction.UnitName.Contains('Up')  then
          CORE.qryHeat.Prior()
        else exit;

        recB := CORE.qryHeat.FieldByName('HeatNum').AsInteger;
        CORE.qryHeat.Edit();
        CORE.qryHeat.FieldByName('HeatNum').AsInteger := recA;
        CORE.qryHeat.Post();
        recA := 0;
        if uHeat.Locate(aHeatID) then
        begin
          CORE.qryHeat.Edit();
          CORE.qryHeat.FieldByName('HeatNum').AsInteger := recB;
          CORE.qryHeat.Post();
        end;
      except on E: Exception do
        begin
          CORE.qryHeat.Cancel;
          { if recA = 0 then  uHeat.RenumberLanes(true); }
          exit;
        end;
      end;
    finally
      if Assigned(fld) then fld.ReadOnly := true;
      CORE.qryHeat.EnableControls();
      gridHeat.EndUpdate;
    end;
  end;
end;

procedure TFrameHeat.actnHeat_DefaultUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if AssertCORE then
    if not uSession.IsEmptyOrLocked then
      if not CORE.qryHeat.IsEmpty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TFrameHeat.actnHeat_NewExecute(Sender: TObject);
begin
  gridHeat.BeginUpdate;
  CORE.qryHeat.DisableControls();
  CORE.qryHeat.CheckBrowseMode;
  try
    {
    // The event must have Distance and stroke Assigned!!!
    if CORE.dsEvent.DataSet.FieldByName('DistanceID').IsNull or
      CORE.dsEvent.DataSet.FieldByName('StrokeID').IsNull then
        raise Exception.Create
        ('Error: The event has not been assigned a distance and stroke.');
    }
    uHeat.NewHeat;
    {uHeat.RenumberLanesAdv(true);}
  finally
    CORE.qryHeat.EnableControls();
    gridHeat.EndUpdate;
  end;
end;

procedure TFrameHeat.actnHeat_ToogleStatusExecute(Sender: TObject);
var
  status: integer;
begin
  gridHeat.BeginUpdate;
  CORE.qryHeat.DisableControls();
  CORE.qryHeat.CheckBrowseMode;
  try
    status := uHeat.HeatStatusID;
    case status of
      1: Inc(status);
      2: Inc(status);
      3: status := 1;
    else
      status := 1; // default.
    end;
        try
      CORE.qryHeat.CheckBrowseMode;
      CORE.qryHeat.Edit;
      CORE.qryHeat.FieldByName('HeatStatusID').AsInteger := status;
      CORE.qryHeat.Post;
    except on E: Exception do
      begin
        CORE.qryHeat.Cancel;
        exit;
      end;
    end;
  finally
    CORE.qryHeat.EnableControls();
    gridHeat.EndUpdate;
  end;
end;

function TFrameHeat.AssertCORE: boolean;
begin
  result := false;
  if Assigned(CORE) and CORE.IsActive then
    result := true;
end;

function TFrameHeat.AssertSCM: boolean;
begin
  result := false;
  if Assigned(SCM) and SCM.IsActive then
    result := true;
end;

procedure TFrameHeat.gridHeatGetDisplText(Sender: TObject; ACol, ARow: Integer;
    var Value: string);
begin
/// <remarks>
///  The TDBAdvGrid is set to display a SVG image in the cell.
///  Calling here 'additionally' display a heat number.
///  The cell's font must be increased and the contents centered aligned.
/// </remarks>
  if (ACol = 1) and (ARow > 0) then
    Value := IntToStr(CORE.qryHeat.FieldByName('HeatNum').Asinteger)
  else
    Value := '';
end;




end.
