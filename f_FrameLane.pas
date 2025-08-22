unit f_FrameLane;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Vcl.ExtCtrls, Vcl.WinXPanels,

  uDefines,
  dmSCM,dmCORE, dmIMG,
  uSwimClub, uSession, uEvent, uHeat, uLane,
  Vcl.Menus, Vcl.Buttons, System.Actions, Vcl.ActnList


  ;

type
  TFrameLane = class(TFrame)
    gLane: TDBAdvGrid;
    pnlgLane: TPanel;
    pnlStack: TStackPanel;
    spbtnLaneDown: TSpeedButton;
    spbtnLaneUp: TSpeedButton;
    spbtnLaneDelete: TSpeedButton;
    spbtnLaneReport: TSpeedButton;
    spbtnLaneDeleteForever: TSpeedButton;
    spbtnLaneEdit: TSpeedButton;
    spbtnLanePlus: TSpeedButton;
    spbtnLaneMinus: TSpeedButton;
    ShapeLaneBar1: TShape;
    actnlistLane: TActionList;
    pumenuLane: TPopupMenu;
    actnLane_MoveUp: TAction;
    actnLane_Movedown: TAction;
    actnLane_Edit: TAction;
    actnLane_Plus: TAction;
    actnLane_Minus: TAction;
    actnLane_Delete: TAction;
    actnLane_DeleteForever: TAction;
    actnLane_Report: TAction;
    actnLane_Empty: TAction;
    actnLane_Strike: TAction;
    actnLane_Swap: TAction;
    spbtnLane_Swap: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
