unit dlgExportSessionJSON;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, XSuperObject, XSuperJSON,
  FireDAC.Comp.Client, FireDAC.Stan.Param, dmSCM, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids;

type
  TExportSessionJSON = class(TForm)
    savedlgJSON: TSaveDialog;
    pnlFooter: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    lblDescription: TLabel;
    qryJSON: TFDQuery;
    dbgridJSON: TDBGrid;
    dsJSON: TDataSource;
    pnlHeader: TPanel;
    qryJSONSessionID: TFDAutoIncField;
    qryJSONSessionStart: TSQLTimeStampField;
    qryJSONEventID: TFDAutoIncField;
    qryJSONEventNum: TIntegerField;
    qryJSONDistanceID: TIntegerField;
    qryJSONStrokeID: TIntegerField;
    qryJSONHEATID: TIntegerField;
    qryJSONHeatNum: TIntegerField;
    qryJSONLane: TIntegerField;
    qryJSONMemberID: TIntegerField;
    qryJSONFirstName: TWideStringField;
    qryJSONMiddleInitial: TWideStringField;
    qryJSONLastName: TWideStringField;
    qryJSONDOB: TSQLTimeStampField;
    qryJSONGenderID: TIntegerField;
    qryJSONRegisterNum: TIntegerField;
    qryJSONMembershipNum: TIntegerField;
    qryJSONHouseID: TIntegerField;
    qryJSONFNAME: TWideStringField;
    qryJSONDISTSTROKE: TWideStringField;
    qryJSONRaceTime: TTimeField;
    qryJSONPersonalBest: TTimeField;
    lblPBDescription: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure ExportRaceTimesToJSON2;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExportSessionJSON: TExportSessionJSON;

implementation

{$R *.dfm}
uses System.DateUtils;

procedure TExportSessionJSON.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TExportSessionJSON.btnOKClick(Sender: TObject);
begin
  ExportRaceTimesToJSON2;
  Close;
end;

procedure TExportSessionJSON.FormCreate(Sender: TObject);
begin
  if Assigned(SCM) and (SCM.scmConnection.Connected = true) then
  begin
    qryJSON.Connection := SCM.scmConnection;
    qryJSON.ParamByName('SESSIONID').AsInteger := SCM.Session_ID;
    qryJSON.Prepare;
    qryJSON.Open;
    if not qryJSON.Active then abort;
  end
  else abort;

end;

procedure TExportSessionJSON.ExportRaceTimesToJSON2;
var
  RaceTimesJSON, SessionObj, EventObj, HeatObj, EntrantObj, MemberObj: ISuperObject;
  EventArray, HeatArray, EntrantArray: ISuperArray;
  FileName, s: string;
  dt: TDateTime;
  CurrentEventID, CurrentHeatID: Integer;
begin
  // Initialize the SaveDialog properties
  savedlgJSON.Title := 'Save JSON File';
  savedlgJSON.Filter := 'JSON Files|*.json';
  savedlgJSON.DefaultExt := 'json';



  qryJSON.First;

  dt := qryJSON.FieldByName('SessionStart').AsDateTime;
  try
    s := '_' + FormatDateTime('yyyy-mm-dd', dt);
  except on E: Exception do
    s := '';
  end;

  // Suggest a filename
  savedlgJSON.FileName := 'Session' + s + '.json';

  // Show the savedlgJSON and get the filename
  if savedlgJSON.Execute then
  begin
    // Define the file name and path
    FileName := savedlgJSON.FileName;

    RaceTimesJSON := SO;
    SessionObj := SO;
    EventArray := SA([]);
    CurrentEventID := -1;
    CurrentHeatID := -1;

    while not qryJSON.Eof do
    begin
      if qryJSON.FieldByName('EventID').AsInteger <> CurrentEventID then
      begin
        if CurrentEventID <> -1 then
        begin
          EventObj.A['Heats'] := HeatArray;
          EventArray.Add(EventObj);
        end;
        EventObj := SO;
        HeatArray := SA([]);
        CurrentEventID := qryJSON.FieldByName('EventID').AsInteger;
        EventObj.I['EventID'] := CurrentEventID;
        EventObj.I['EventNum'] := qryJSON.FieldByName('EventNum').AsInteger;
        EventObj.I['DistanceID'] := qryJSON.FieldByName('DistanceID').AsInteger;
        EventObj.I['StrokeID'] := qryJSON.FieldByName('StrokeID').AsInteger;
        EventObj.S['DISTSTROKE'] := qryJSON.FieldByName('DISTSTROKE').AsString;
      end;

      if qryJSON.FieldByName('HEATID').AsInteger <> CurrentHeatID then
      begin
        if CurrentHeatID <> -1 then
        begin
          HeatObj.A['Entrants'] := EntrantArray;
          HeatArray.Add(HeatObj);
        end;
        HeatObj := SO;
        EntrantArray := SA([]);
        CurrentHeatID := qryJSON.FieldByName('HEATID').AsInteger;
        HeatObj.I['HeatID'] := CurrentHeatID;
        HeatObj.I['HeatNum'] := qryJSON.FieldByName('HeatNum').AsInteger;
      end;

      EntrantObj := SO;
      EntrantObj.I['Lane'] := qryJSON.FieldByName('Lane').AsInteger;
      EntrantObj.I['MemberID'] := qryJSON.FieldByName('MemberID').AsInteger;
      EntrantObj.S['FNAME'] := qryJSON.FieldByName('FNAME').AsString;
      EntrantObj.Time['RaceTime'] := TTime(qryJSON.FieldByName('RaceTime').AsDateTime);
      EntrantObj.Time['PersonalBest'] := TTime(qryJSON.FieldByName('PersonalBest').AsDateTime);

      MemberObj := SO;
      MemberObj.S['FirstName'] := qryJSON.FieldByName('FirstName').AsString;
      MemberObj.S['MiddleInitial'] := qryJSON.FieldByName('MiddleInitial').AsString;
      MemberObj.S['LastName'] := qryJSON.FieldByName('LastName').AsString;
      MemberObj.D['DOB'] := qryJSON.FieldByName('DOB').AsDateTime;
      MemberObj.I['GenderID'] := qryJSON.FieldByName('GenderID').AsInteger;
      MemberObj.S['RegisterNum'] := qryJSON.FieldByName('RegisterNum').AsString;
      MemberObj.S['MembershipNum'] := qryJSON.FieldByName('MembershipNum').AsString;
      MemberObj.I['HouseID'] := qryJSON.FieldByName('HouseID').AsInteger;

      EntrantObj.O['Member'] := MemberObj;
      EntrantArray.Add(EntrantObj);
      qryJSON.Next;
    end;

    // Add the last heat and event
    if CurrentHeatID <> -1 then
    begin
      HeatObj.A['Entrants'] := EntrantArray;
      HeatArray.Add(HeatObj);
    end;
    if CurrentEventID <> -1 then
    begin
      EventObj.A['Heats'] := HeatArray;
      EventArray.Add(EventObj);
    end;

    SessionObj.A['Events'] := EventArray;
    SessionObj.I['SessionID'] := qryJSON.FieldByName('SessionID').AsInteger;
    SessionObj.D['SessionStart'] := qryJSON.FieldByName('SessionStart').AsDateTime;

    RaceTimesJSON.O['Session'] := SessionObj;
    // Write JSON to file
    RaceTimesJSON.SaveTo(FileName, True);
  end;
end;



procedure TExportSessionJSON.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if (Key = VK_ESCAPE) then
    close;
end;



end.
