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
    qryXNominees: TFDQuery;
    dsXNominees: TDataSource;
    FDCommandUpdateEntrant: TFDCommand;
    qryRNominee: TFDQuery;
    qryRNomineeFName: TWideStringField;
    qryRNomineeTTB: TTimeField;
    qryRNomineePB: TTimeField;
    qryRNomineeAGE: TIntegerField;
    qryRNomineeGender: TWideStringField;
    qryRNomineeMemberID: TIntegerField;
    qryRNomineeEventID: TIntegerField;
    qryRNomineeGenderID: TIntegerField;
    dsRNominee: TDataSource;
    qryCountRNominee: TFDQuery;
    WideStringField: TWideStringField;
    TimeField1: TTimeField;
    TimeField2: TTimeField;
    IntegerField1: TIntegerField;
    WideStringField2: TWideStringField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
  private
    { Private declarations }
    fHandle: HWND;
    fAutoBuildRelayDataActive: Boolean;
    FConnection: TFDConnection;

  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent; AConnection: TFDConnection);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure ReadPreferences(aIniFileName: string);
    procedure ActivateTable();


  end;

var
  ABRelayData: TABRelayData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses SCMUtility;

{$R *.dfm}

{ TAutoBuildRelayData }

procedure TABRelayData.ActivateTable;
begin
  fAutoBuildRelayDataActive := false;
  if Assigned(FConnection) and FConnection.Connected then
  begin
    qryRNominee.Connection := FConnection;
    qryRNominee.Open;
    if qryRNominee.Active then
    begin
      fAutoBuildRelayDataActive := true;
    end;
  end;
end;

constructor TABRelayData.Create(AOwner: TComponent);
var
IniFileName: string;
begin
  inherited;
//  fHandle := AllocateHWnd(WndProc);

  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then ReadPreferences(IniFileName);
end;

constructor TABRelayData.CreateWithConnection(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  self.Create(AOwner);
  FConnection := AConnection;
end;

destructor TABRelayData.Destroy;
begin
//  DeallocateHWND(fHandle);
  inherited;
end;

procedure TABRelayData.ReadPreferences(aIniFileName: string);
begin
  ;
end;

end.
