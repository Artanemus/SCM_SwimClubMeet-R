unit dlgSplitTime;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dmSCM, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TSplitTime = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    qryTeamSplit: TFDQuery;
    dsTeamSplit: TDataSource;
    qryTeamSplitTeamSplitID: TFDAutoIncField;
    qryTeamSplitSplitTime: TTimeField;
    qryTeamSplitTeamID: TIntegerField;
    qryTeamSplitTeamName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fTeamID: integer;
  public
    { Public declarations }
    property TeamID: integer read FTeamID write FTeamID;
  end;

var
  SplitTime: TSplitTime;

implementation

{$R *.dfm}

procedure TSplitTime.FormCreate(Sender: TObject);
begin
  qryTeamSplit.Connection := SCM.scmConnection;
end;

procedure TSplitTime.Button1Click(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TSplitTime.FormShow(Sender: TObject);
begin
  qryTeamSplit.Close;
  qryTeamSplit.ParamByName('TEAMID').AsInteger := fTeamID;
  qryTeamSplit.Prepare;
  qryTeamSplit.Open;
//  if not qryTeamSplit.Active then
//    Abort;
end;

end.
