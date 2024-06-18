unit dmMemberHouse;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dmSCM;

type
  TMemberHouse = class(TDataModule)
    qryMinHouse: TFDQuery;
    qryMinHouseAGE: TFDQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    FConnection: TFDConnection;
    fManageHouseDataActive: Boolean;
    constructor CreateWithConnection(AOwner: TComponent;
      AConnection: TFDConnection);
    function MinHouse(AConnection: TFDConnection; ASwimClubID: integer): integer;

  public
    { Public declarations }
  end;

var
  MemberHouse: TMemberHouse;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}


{$R *.dfm}

{ TMemberHouse }

constructor TMemberHouse.CreateWithConnection(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  self.Create(AOwner);
  FConnection := AConnection;
end;

procedure TMemberHouse.DataModuleDestroy(Sender: TObject);
begin
//  DeallocateHWND(fHandle);
  inherited;
end;

function TMemberHouse.MinHouse(AConnection: TFDConnection;
  ASwimClubID: integer): integer;
begin
  with qryMinHouse do
  begin
    result := 0;
    if Active then
      Close;
    Connection := AConnection;
    ParamByName('SWIMCLUBID').AsInteger := ASwimClubID;
    Prepare;
    Open;
    if Active then
    begin
      if not FieldByName('HouseID').IsNull then
        result := FieldByName('HouseID').AsInteger;
    end;
  end;
end;

procedure TMemberHouse.DataModuleCreate(Sender: TObject);
//var
//IniFileName: string;
begin
  inherited;
//  fHandle := AllocateHWnd(WndProc);
//  prefChartMaxRecords := CHARTMAXRECORDS;

  // r e a d   p r e f e r e n c e .
//  IniFileName := SCMUtility.GetSCMPreferenceFileName();
//  if (FileExists(IniFileName)) then
//    ReadPreferences(IniFileName);
end;

end.
