unit dlgmemberShipType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TMembershipType = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel4: TPanel;
    DBGrid1: TDBGrid;
    TabSheet3: TTabSheet;
    Label2: TLabel;
    Label1: TLabel;
    btnMemShipTypeMember: TButton;
    btnMemShipTypeTable: TButton;
    Panel3: TPanel;
    btnClose: TButton;
    qryMembershipType: TFDQuery;
    qryMembershipTypeMembershipTypeID: TFDAutoIncField;
    qryMembershipTypeCaption: TWideStringField;
    qryMembershipTypeIsSwimmer: TBooleanField;
    qryMembershipTypeSort: TIntegerField;
    qryMembershipTypeAgeFrom: TIntegerField;
    qryMembershipTypeAgeTo: TIntegerField;
    qryMembershipTypeLongCaption: TWideStringField;
    qryMembershipTypeStartOfSwimSeason: TSQLTimeStampField;
    dsMembershipType: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MembershipType: TMembershipType;

implementation

{$R *.dfm}

end.
