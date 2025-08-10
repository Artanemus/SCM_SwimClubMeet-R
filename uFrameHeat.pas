unit uFrameHeat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, DBAdvGrid,
  dmCORE, dmIMG, Vcl.ExtCtrls, Vcl.Buttons, Vcl.WinXCtrls, System.Actions,
  Vcl.ActnList, dmSCM, uSwimClub, uSession, uEvent, uHeat, uLane;

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
    actn_HeatMoveDown: TAction;
    actnHeat_ToogleStatus: TAction;
    actnHeat_New: TAction;
    actnHeat_Delete: TAction;
    actnHeat_AutoBuild: TAction;
    actnHeat_MarshallSheet: TAction;
    actnHeat_TimeKeeperSheet: TAction;
    actnHeat_PrintSheets: TAction;
    actnHeat_Report: TAction;
    procedure actnHeat_MoveUpExecute(Sender: TObject);
    procedure actnHeat_MoveUpUpdate(Sender: TObject);
    procedure gridHeatGetDisplText(Sender: TObject; ACol, ARow: Integer; var Value:
        string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrameHeat.actnHeat_MoveUpExecute(Sender: TObject);
var
  bm: TBookmark;
  enA, enB: integer;
  fld: TField;
begin
  // TActionUpdate determines if this routine can be called
  // m o v e   e v e n t   u  p  .
  if not AssertConnection then exit;
  With CORE.dsHeat.DataSet do
  begin
    if not SCM.IsFirstRecord(CORE.dsHeat.DataSet) then
    begin
      DisableControls();
      try
        begin
          bm := Bookmark;
          enA := FieldByName('HeatNum').AsInteger;
          enB := 0;
          fld := CORE.qryHeat.FindField('HeatNum');
          try
            begin
              // 3.10.2020 ensure field is writable
              if Assigned(fld) then fld.ReadOnly := false;
              Prior();
              enB := FieldByName('HeatNum').AsInteger;
              Edit();
              FieldByName('HeatNum').AsInteger := enA;
              Post();
            end;
          finally
            Bookmark := bm;
            Edit();
            FieldByName('HeatNum').AsInteger := enB;
            Post();
            // 3.10.2020
            if Assigned(fld) then fld.ReadOnly := true;
          end;
        end;
      finally
        // RE-ORDER and RE-CUE ...
        Refresh();
        EnableControls();
      end;
    end;
  end;
end;

procedure TFrameHeat.actnHeat_MoveUpUpdate(Sender: TObject);
var
  DoEnable: boolean;
begin
  DoEnable := false;
  if Assigned(SCM) and SCM.IsActive then
    if not uSession.IsEmptyOrLocked then
      if not dmCore.qryHeat.Empty then DoEnable := true;
  TAction(Sender).Enabled := DoEnable;
end;

procedure TFrameHeat.gridHeatGetDisplText(Sender: TObject; ACol, ARow: Integer;
    var Value: string);
begin
  if (ACol = 1) and (ARow > 0) then
  begin
    Value := IntToStr(CORE.qryHeat.FieldByName('HeatNum').Asinteger);
  end
  else
    Value := '';

end;

end.
