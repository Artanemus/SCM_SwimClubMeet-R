unit dmABRelayData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dmSCM,
  Windows, Winapi.Messages;

type
  TABRelayData = class(TDataModule)
    FDCommandUpdateEntrant: TFDCommand;
    qryRelayNominee: TFDQuery;
    dsRelayNominee: TDataSource;
    qryCountRNominee: TFDQuery;
  private
    fAutoBuildRelayDataActive: Boolean;
    FConnection: TFDConnection;
  public
    constructor CreateWithConnection(AOwner: TComponent; AConnection: TFDConnection);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure ActivateTable();
  end;

var
  ABRelayData: TABRelayData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TABRelayData.ActivateTable;
begin
  fAutoBuildRelayDataActive := false;
  if Assigned(FConnection) and FConnection.Connected then
  begin
    qryRelayNominee.Connection := FConnection;
    qryCountRNominee.Connection  := FConnection;
    fAutoBuildRelayDataActive := true;
  end;
end;

constructor TABRelayData.Create(AOwner: TComponent);
begin
  inherited;
end;

constructor TABRelayData.CreateWithConnection(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  self.Create(AOwner);
  FConnection := AConnection;
  ActivateTable;
end;

destructor TABRelayData.Destroy;
begin
  inherited;
end;



end.
