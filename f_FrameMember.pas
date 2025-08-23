unit f_FrameMember;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.WinXPanels,
  Vcl.ExtCtrls, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid,
  Vcl.VirtualImage, Vcl.StdCtrls,

  dmIMG, Vcl.Buttons, Vcl.Menus, System.Actions, Vcl.ActnList;

type
  TFrameMember = class(TFrame)
    gMember: TDBAdvGrid;
    pnlDetail: TPanel;
    pnlStack: TStackPanel;
    pnlBody: TPanel;
    pnlHeader: TPanel;
    btnClearSearch: TButton;
    memberName_Edit: TEdit;
    vimgSearch: TVirtualImage;
    pnlMessage: TPanel;
    lblMessage: TLabel;
    spbtnNominateReport: TSpeedButton;
    ShapeNomBar1: TShape;
    spbtnNominateSortMember: TSpeedButton;
    actnlistMember: TActionList;
    pumenuMember: TPopupMenu;
    actnMemberSwitch: TAction;
    actnMemberReport: TAction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
