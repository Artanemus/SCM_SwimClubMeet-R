unit frame_TEAM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids;

type
  TframeTEAM = class(TFrame)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Grid: TDBGrid;
    GridEntrant: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Enable_GridEllipse();
  end;

implementation

{$R *.dfm}

{ TframeTEAM }
uses dlgEntrantPickerCTRL, dlgEntrantPicker, dlgDCodePicker, system.UITypes;

procedure TframeTEAM.Enable_GridEllipse;
var
  i: integer;
  col: TColumn;
begin
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    col := Grid.Columns.Items[i];
    // MOD 23.06.27
    if (col.FieldName = 'TeamName') then
    begin
      col.ButtonStyle := cbsEllipsis;
      Grid.Repaint;
      break;
    end;
  end;
end;

end.
