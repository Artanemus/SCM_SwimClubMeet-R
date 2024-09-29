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
    dsRNominee: TDataSource;
    qryCountRNominee: TFDQuery;
    qryTNum: TFDQuery;
    qryLastTeamNameID: TFDQuery;
    qryRNominee: TFDQuery;
    cmdInsertTeamEntrant: TFDCommand;
  private
    fAutoBuildRelayDataActive: Boolean;
    FConnection: TFDConnection;
  public
    constructor CreateWithConnection(AOwner: TComponent; AConnection: TFDConnection);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure ActivateTable();
    function GetLastTeamNameID(AEventID: integer): integer;
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
    qryRNominee.Connection := FConnection;
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



function TABRelayData.GetLastTeamNameID(AEventID: integer): integer;
begin
  result := 0;
  if AEventID = 0 then exit;
  if Assigned(FConnection) and FConnection.Connected then
  begin
    qryLastTeamNameID.Close;
    qryLastTeamNameID.ParamByName('EVENTID').AsInteger := AEventID;
    qryLastTeamNameID.Prepare;
    qryLastTeamNameID.Open;
    if qryLastTeamNameID.Active then
      result := qryLastTeamNameID.FieldByName('LastTeamNameID').AsInteger;
    qryLastTeamNameID.Close;
  end;
end;

end.
