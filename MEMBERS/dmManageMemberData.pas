unit dmManageMemberData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, dmSCM, Windows, Winapi.Messages, SCMDefines
//  ,VclTee.TeEngine,
//  VclTee.TeeSpline, VclTee.Series, VclTee.TeeProcs, VclTee.Chart,
//  VclTee.DBChart
  ;

type
  TManageMemberData = class(TDataModule)
    cmdFixNullBooleans: TFDCommand;
    dsContactNum: TDataSource;
    dsFindMember: TDataSource;
    dsGender: TDataSource;
    dsHouse: TDataSource;
    dsMember: TDataSource;
    dsMemberPB: TDataSource;
    dsMemberRoleLnk: TDataSource;
    dsSwimClub: TDataSource;
    qAssertMemberID: TFDQuery;
    qryContactNum: TFDQuery;
    qryContactNumContactNumID: TFDAutoIncField;
    qryContactNumContactNumTypeID: TIntegerField;
    qryContactNumlu: TStringField;
    qryContactNumMemberID: TIntegerField;
    qryContactNumNumber: TWideStringField;
    qryEntrantDataCount: TFDQuery;
    qryFindMember: TFDQuery;
    qryFindMemberAge: TIntegerField;
    qryFindMembercGender: TWideStringField;
    qryFindMemberdtDOB: TWideStringField;
    qryFindMemberFirstName: TWideStringField;
    qryFindMemberFName: TWideStringField;
    qryFindMemberGenderID: TIntegerField;
    qryFindMemberIsActive: TBooleanField;
    qryFindMemberIsSwimmer: TBooleanField;
    qryFindMemberLastName: TWideStringField;
    qryFindMemberMemberID: TFDAutoIncField;
    qryFindMemberMembershipNum: TIntegerField;
    qryMember: TFDQuery;
    qryMemberArchivedOn: TSQLTimeStampField;
    qryMemberCreatedOn: TSQLTimeStampField;
    qryMemberDOB: TSQLTimeStampField;
    qryMemberEmail: TWideStringField;
    qryMemberFirstName: TWideStringField;
    qryMemberFName: TWideStringField;
    qryMemberGenderID: TIntegerField;
    qryMemberHouseID: TIntegerField;
    qryMemberIsActive: TBooleanField;
    qryMemberIsArchived: TBooleanField;
    qryMemberIsSwimmer: TBooleanField;
    qryMemberLastName: TWideStringField;
    qryMemberluGender: TStringField;
    qryMemberluHouse: TStringField;
    qryMemberMemberID: TFDAutoIncField;
    qryMemberMembershipNum: TIntegerField;
    qryMemberMembershipStr: TWideStringField;
    qryMemberPB: TFDQuery;
    qryMemberPBDistanceID: TFDAutoIncField;
    qryMemberPBEventStr: TWideStringField;
    qryMemberPBMemberID: TFDAutoIncField;
    qryMemberPBPB: TTimeField;
    qryMemberPBStrokeID: TFDAutoIncField;
    qryMemberRoleLnk: TFDQuery;
    qryMemberSwimClubID: TIntegerField;
    qrySwimClub: TFDQuery;
    tblContactNumType: TFDTable;
    tblContactNumTypeCaption: TWideStringField;
    tblContactNumTypeContactNumTypeID: TFDAutoIncField;
    tblDistance: TFDTable;
    tblGender: TFDTable;
    tblHouse: TFDTable;
    tblMemberRole: TFDTable;
    tblStroke: TFDTable;
    qryMemberRoleLnkMemberRoleID: TIntegerField;
    qryMemberRoleLnkMemberID: TIntegerField;
    qryMemberRoleLnkCreatedOn: TSQLTimeStampField;
    qryMemberRoleLnkIsActive: TBooleanField;
    qryMemberRoleLnkIsArchived: TBooleanField;
    qryMemberRoleLnkluMemberRoleStr: TStringField;
    qryMemberTAGS: TWideMemoField;
    qryMemberRoleLnkElectedOn: TSQLTimeStampField;
    qryMemberRoleLnkRetiredOn: TSQLTimeStampField;
    dsMemberEvents: TDataSource;
    qryMemberEvents: TFDQuery;
    qryMemberEventsEventID: TFDAutoIncField;
    qryMemberEventsMemberID: TIntegerField;
    qryMemberEventsFName: TWideStringField;
    qryMemberEventsEventStr: TWideStringField;
    qryMemberEventsRaceTime: TTimeField;
    qryMemberEventsEventDate: TStringField;
    qryChart: TFDQuery;
    dsChart: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryMemberAfterInsert(DataSet: TDataSet);
    procedure qryMemberAfterPost(DataSet: TDataSet);
    procedure qryMemberAfterScroll(DataSet: TDataSet);
    procedure qryMemberBeforeDelete(DataSet: TDataSet);
    procedure qryMemberBeforeScroll(DataSet: TDataSet);
    procedure qryMemberDOBGetText(Sender: TField; var Text: string; DisplayText:
        Boolean);
    procedure qryMemberDOBSetText(Sender: TField; const Text: string);
    procedure qryMemberMETADATAGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryMemberMETADATASetText(Sender: TField; const Text: string);
    procedure qryMemberRoleLnkBeforePost(DataSet: TDataSet);
    procedure qryMemberRoleLnkElectedOnGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryMemberRoleLnkElectedOnSetText(Sender: TField;
      const Text: string);
    procedure qryMemberRoleLnkNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    FConnection: TFDConnection;
    fManageMemberDataActive: Boolean;
    fRecordCount: Integer;
    fHandle: HWND;

    procedure UpdateMembersPersonalBest;

  protected
    procedure WndProc(var wndMsg: TMessage); virtual;

  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      AConnection: TFDConnection);

    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    procedure ActivateTable();
    procedure FixNullBooleans();
    function LocateMember(MemberID: Integer): Boolean;
    procedure UpdateDOB(DOB: TDateTime);
    procedure UpdateMember(SwimClubID: Integer;
      hideArchived, hideInactive, hideNonSwimmer: Boolean);
    procedure UpdateElectedOn(aDate: TDate);
    procedure UpdateRetiredOn(aDate: TDate);
    procedure UpdateChart(aMemberID, aDistanceID, aStrokeID: integer; DoCurrSeason: boolean = true);

    property Connection: TFDConnection read FConnection write FConnection;
    property ManageMemberDataActive: Boolean read fManageMemberDataActive
      write fManageMemberDataActive;
    property RecordCount: Integer read fRecordCount;
    property Handle: HWND read fHandle;

  end;

const
  SCMMEMBERPREF = 'SCM_MemberPref.ini';
  USEDSHAREDINIFILE = True; // NOTE: Always true. 26/09/2022

var
  ManageMemberData: TManageMemberData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses
  System.IOUtils, IniFiles, SCMUtility,
  vcl.Dialogs, System.UITypes, vcl.Forms, System.DateUtils;

constructor TManageMemberData.Create(AOwner: TComponent);
begin
  inherited;
  fHandle := AllocateHWnd(WndProc);
end;

constructor TManageMemberData.CreateWithConnection(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  self.Create(AOwner);
  FConnection := AConnection;
end;

procedure TManageMemberData.ActivateTable;
begin
  fManageMemberDataActive := false;
  if Assigned(FConnection) and FConnection.Connected then
  begin
    qrySwimClub.Connection := FConnection;
    qryMember.Connection := FConnection;
    qryContactNum.Connection := FConnection;
    qryMemberRoleLnk.Connection := FConnection;
    qryMemberPB.Connection := FConnection;
    qryMemberEvents.Connection := FConnection;
    qryChart.Connection := FConnection;

    // prepare lookup tables.
    tblStroke.Connection := FConnection;
    tblDistance.Connection := FConnection;
    tblGender.Connection := FConnection;
    tblHouse.Connection := FConnection;
    tblContactNumType.Connection := FConnection;
    tblMemberRole.Connection := FConnection;

    qrySwimClub.Open;
    if qrySwimClub.Active then
    begin
      // Lookup tables used by member
      tblStroke.Open;
      tblDistance.Open;
      tblGender.Open;
      tblHouse.Open;
      tblContactNumType.Open;
      tblMemberRole.Open;

      qryMember.Open;
      if qryMember.Active then
      begin
        // Lookup table used by contactnum
        qryContactNum.Open;
        qryMemberRoleLnk.Open;
        qryMemberPB.Open;
        qryMemberEvents.Open;
        qryChart.Open;
        if qryContactNum.Active then
        begin
          fManageMemberDataActive := True;
        end;
      end;
    end;
  end;
end;

procedure TManageMemberData.DataModuleCreate(Sender: TObject);
begin
  if Assigned(FConnection) then
    ActivateTable;
end;

destructor TManageMemberData.Destroy;
begin
  DeallocateHWND(fHandle);
  inherited;
end;

procedure TManageMemberData.FixNullBooleans;
begin
  if Assigned(FConnection) then
  begin
    cmdFixNullBooleans.Connection := FConnection;
    if FConnection.Connected then
      cmdFixNullBooleans.Execute();
  end;
end;

function TManageMemberData.LocateMember(MemberID: Integer): Boolean;
var
  SearchOptions: TLocateOptions;
begin
  result := false;
  SearchOptions := [loPartialKey];
  try
    begin
      result := qryMember.Locate('MemberID', MemberID, SearchOptions);
    end
  except
    on E: Exception do
      // lblErrMsg.Caption := 'SCM DB access error.';
  end;
end;

procedure TManageMemberData.qryMemberAfterInsert(DataSet: TDataSet);
var
  fld: TField;
begin
  fld := DataSet.FieldByName('IsArchived');
  if (fld.IsNull) then
  begin
    fld.AsBoolean := false;
  end;
  fld := DataSet.FieldByName('IsActive');
  if (fld.IsNull) then
  begin
    fld.AsBoolean := True;
  end;
  fld := DataSet.FieldByName('IsSwimmer');
  if (fld.IsNull) then
  begin
    fld.AsBoolean := True;
  end;

  // DB : v1,1,5,0 v1,1,5,1 v1,1,5,2 v1,1,5,3 - required.
  fld := DataSet.FieldByName('SwimClubID');
  if (fld.IsNull) then
  begin
    fld.AsInteger := dsSwimClub.DataSet.FieldByName('SwimClubID').AsInteger;
  end;

  // DB : v1,1,6,0 - CREATE LINK
  // build many-to-many relationship with SwimClub and member.
  (*
    SQL := 'INSERT lnkSwimClubMember Value ....
  *)

end;

procedure TManageMemberData.qryMemberAfterPost(DataSet: TDataSet);
begin
  // As there is a calculation field (FNAME) in this query - the call to
  // refresh ensures that the main forms header banner will display the new
  // member's name.
  // ie. frmManageMember.DBTextFullName uses field qrMember.FNAME.
  qryMember.Refresh;
  if Owner is TForm then
    // Updates the display of the member's age.
    PostMessage(TForm(Owner).Handle, SCM_AFTERPOST, 0, 0);
end;

procedure TManageMemberData.qryMemberAfterScroll(DataSet: TDataSet);
begin
  // Display Members Personal Best
  UpdateMembersPersonalBest();
  // Updates the display of the member's age.
  if Owner is TForm then
    PostMessage(TForm(Owner).Handle, SCM_AFTERSCROLL, 0, 0);

  // Update chart query?

end;

procedure TManageMemberData.qryMemberBeforeDelete(DataSet: TDataSet);
var
  SQL: string;
  MemberID, result: Integer;
  tmpQry: TFDQuery;
begin
  // Best to finalize any editing - prior to calling execute statements.
  // DataSet.CheckBrowseMode;



  MemberID := DataSet.FieldByName('MemberID').AsInteger;
  if MemberID <> 0 then
  begin
    // second chance to abort delete - but only displayed if there is entrant data with race-times
    // could have used SCMConnection.ExecScalar(SQL, [MemberID]).
    qryEntrantDataCount.Connection := FConnection;
    // FYI - assignment of connection typically sets DS state to closed.
    qryEntrantDataCount.Close;
    qryEntrantDataCount.ParamByName('MEMBERID').AsInteger := MemberID;
    qryEntrantDataCount.Prepare;
    qryEntrantDataCount.Open;
    if qryEntrantDataCount.Active then
    begin
      if qryEntrantDataCount.FieldByName('TOT').AsInteger > 0 then
      begin
        result := MessageDlg('This member has race-time data!' + sLineBreak +
          'Are you sure you want to delete the member?',
          TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0, mbNo);
        if IsNegativeResult(result) then
        begin
          qryEntrantDataCount.Close; // tidy up...?
          Abort;
        end;
      end;
      qryEntrantDataCount.Close;
    end;

    // remove all C O N T A C T N U Mbers for this member.
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[ContactNum] WHERE MemberID = ' +
      IntToStr(MemberID) + ';';
    FConnection.ExecSQL(SQL);
    // remove all R O L E S assigned to this member held in linked-list.
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[MemberRoleLink] WHERE MemberID = '
      + IntToStr(MemberID) + ';';
    FConnection.ExecSQL(SQL);

    // remove all split data for indv events
    SQL := 'SELECT EntrantID FROM [SwimClubMeet].[dbo].Entrant WHERE MemberID = ' +
      IntToStr(MemberID) + ';';
    tmpQry := TFDQuery.Create(self);
    tmpQry.Connection := FConnection;
    tmpQry.SQL.Add(SQL);
    tmpQry.IndexFieldNames := 'EntrantID';
    tmpQry.Open;
    if tmpQry.Active then
    begin
      while not tmpQry.Eof do
      begin
        SQL := 'DELETE FROM [SwimClubMeet].[dbo].[Split] WHERE EntrantID = ' +
          IntToStr(tmpQry.FieldByName('EntrantID').AsInteger) + ';';
        FConnection.ExecSQL(SQL);
        tmpQry.Next;
      end;
    end;
    tmpQry.Close;
    tmpQry.Free;

    // Remove all split data assigned to TeamEntrant for TEAM EVENT
    // NOTE: no individual split data store for members in relays.
    // Split data is linked to dbo.Team.

    // ENTRANTS
    SQL := 'UPDATE [SwimClubMeet].[dbo].[Entrant] SET [MemberID] = NULL, ' +
      '[RaceTime] = NULL, [TimeToBeat] = NULL, [PersonalBest] = NULL, ' +
      '[IsDisqualified] = 0,[IsScratched] = 0, DisqualifyCodeID = NULL WHERE MemberID = ' +
      IntToStr(MemberID) + ';';
    FConnection.ExecSQL(SQL);
    // TEAM ENTRANTS
    SQL := 'UPDATE [SwimClubMeet].[dbo].[TeamEntrant] SET [MemberID] = NULL, ' +
      '[RaceTime] = NULL, [TimeToBeat] = NULL, [PersonalBest] = NULL, ' +
      '[IsDisqualified] = 0,[IsScratched] = 0, DisqualifyCodeID = NULL WHERE MemberID = ' +
      IntToStr(MemberID) + ';';
    FConnection.ExecSQL(SQL);

    // DELETE MEMBERS NOMINATIONS TO EVENTS
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[Nominee] WHERE MemberID = ' +
      IntToStr(MemberID) + ';';
    FConnection.ExecSQL(SQL);

    { TODO -oBen -cGeneral : Version 1.5.5.4 uses a linked list to SwimClub ... }
    (*
      SQL := 'DELETE FROM [SwimClubMeet].[dbo].[lnkSwimClubMember] WHERE MemberID = '
      + IntToStr(MemberID) + ' AND SwimClubID = ' +
      IntToStr(qrySwimClub.FieldByName('SwimClubID').AsInteger) + ';';
      FConnection.ExecSQL(SQL);
    *)


  end;
end;

procedure TManageMemberData.qryMemberBeforeScroll(DataSet: TDataSet);
begin
  if (DataSet.State = dsEdit) or (DataSet.State = dsInsert) then
    DataSet.CheckBrowseMode; // auto-commit changes ...
end;

procedure TManageMemberData.qryMemberDOBGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
var
  LFormatSettings: TFormatSettings;
begin
  LFormatSettings := TFormatSettings.Create; // Use the system locale
  if (Sender.IsNull) or (DateOf(Sender.AsDateTime) = 0) then Text := ''
  else Text := FormatDateTime('ddddd', Sender.AsDateTime, LFormatSettings);
end;

procedure TManageMemberData.qryMemberDOBSetText(Sender: TField;
  const Text: string);
var
  dt: TDateTime;
  LFormatSettings: TFormatSettings;
begin
  LFormatSettings := TFormatSettings.Create; // Use the system locale
  if Text.IsNullOrEmpty(Text) then Sender.Clear
  else
  begin
    try
      dt := StrToDate(Text, LFormatSettings);
      Sender.AsDateTime := dt;
    except
      on E: EConvertError do
      begin
        ShowMessage('Invalid date format: ' + E.Message);
      end;
    end;
  end;
end;

procedure TManageMemberData.qryMemberMETADATAGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := Sender.AsString;
end;

procedure TManageMemberData.qryMemberMETADATASetText(Sender: TField;
  const Text: string);
begin
  Sender.AsString := Text;
end;

procedure TManageMemberData.qryMemberRoleLnkBeforePost(DataSet: TDataSet);
var
  // SQL: string;
  // v: variant;
  fld: TField;
begin
  // Validate MemberRoleID
  fld := DataSet.FieldByName('MemberRoleID');
  if Assigned(fld) AND (fld.IsNull) then
  begin
    // raise Exception.Create('A member''s role must be assigned.');
    Abort;
  end;

  {
    // test for duplicity ...
    SQL := 'SELECT COUNT(MemberRoleID) FROM dbo.MemberRoleLink WHERE MemberRoleID = '
    + IntToStr(fld.AsInteger);
    v := FConnection.ExecSQLScalar(SQL);
    if (v <> 0) then
    begin
    // raise Exception.Create('A member cannot have the same role twice.');
    Abort;
    end;
  }

  // NULL NOT ALLOWED
  fld := DataSet.FieldByName('IsArchived');
  if Assigned(fld) AND (fld.IsNull) then
    fld.AsBoolean := false;
  // NULL NOT ALLOWED
  fld := DataSet.FieldByName('IsActive');
  if Assigned(fld) AND (fld.IsNull) then
    fld.AsBoolean := false;
  // Creation date.
  fld := DataSet.FieldByName('CreatedOn');
  if Assigned(fld) AND (fld.IsNull) then
    fld.AsDateTime := Now;

end;

procedure TManageMemberData.qryMemberRoleLnkElectedOnGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
var
  LFormatSettings: TFormatSettings;
begin
  // Set up format settings using current system locale
  LFormatSettings := TFormatSettings.Create;
  if (Sender.IsNull) or (DateOf(Sender.AsDateTime) = 0) then
    Text := ''
  else
    Text := FormatDateTime('dd.mm.yy', Sender.AsDateTime, LFormatSettings);
end;

procedure TManageMemberData.qryMemberRoleLnkElectedOnSetText(Sender: TField;
  const Text: string);
var
  dt: TDateTime;
  LFormatSettings: TFormatSettings;
begin
  // // Set up format settings using current system locale
  LFormatSettings := TFormatSettings.Create;
  {
    LFormatSettings.DateSeparator := '-';
    LFormatSettings.ShortDateFormat := 'yyyy-mm-dd';
    LFormatSettings.TimeSeparator := ':';
    LFormatSettings.LongTimeFormat := 'hh:nn:ss';
  }
  if Text.IsNullOrEmpty(Text) then
    Sender.Clear
  else
  begin
    try
      dt := StrToDate(Text, LFormatSettings);
      Sender.AsDateTime := dt;
    except
      on E: EConvertError do
      begin
        ShowMessage('Invalid date format: ' + E.Message);
      end;
    end;
  end;
end;

procedure TManageMemberData.qryMemberRoleLnkNewRecord(DataSet: TDataSet);
var
  fld: TField;
begin
  fld := DataSet.FieldByName('IsArchived');
  if (fld.IsNull) then
  begin
    fld.AsBoolean := false;
  end;
  fld := DataSet.FieldByName('IsActive');
  if (fld.IsNull) then
  begin
    fld.AsBoolean := True;
  end;
  fld := DataSet.FieldByName('CreatedOn');
  fld.AsDateTime := Now;

  // fld := DataSet.FieldByName('MemberID');
  // if (fld.IsNull) then
  // begin
  // fld.AsInteger := DataSet.FieldByName('MemberID').AsInteger;
  // end;
  // fld := DataSet.FieldByName('MemberRoleID');
  // if (fld.IsNull) then
  // begin
  // fld.AsInteger := 0;
  // end;
end;

procedure TManageMemberData.UpdateChart(aMemberID, aDistanceID, aStrokeID: integer; DoCurrSeason: boolean = true);
begin
  if not Assigned(FConnection) then
    exit;
  if not qryChart.Active then
    exit;
  qryChart.DisableControls;
  qryChart.Close;
  if (aMemberID = 0) and (qryMember.Active) then
    aMemberID := qryMember.FieldByName('MemberID').AsInteger;
  if aMemberID <> 0 then
  begin
    qryChart.ParamByName('MEMBERID').AsInteger := aMemberID;
    qryChart.ParamByName('DISTANCEID').AsInteger := aDistanceID;
    qryChart.ParamByName('STROKEID').AsInteger := aStrokeID;
    qryChart.ParamByName('DOCURRSEASON').AsBoolean:= DoCurrSeason;
    qryChart.Prepare;
    qryChart.Open;
    if qryChart.Active then
    begin
      // signal success?
    end
  end;
  qryChart.EnableControls;
end;

procedure TManageMemberData.UpdateDOB(DOB: TDateTime);

begin
  if Assigned(qryMember.Connection) and (qryMember.Active) then
  begin
    qryMember.DisableControls;
    qryMember.edit;
    qryMember.FieldByName('DOB').AsDateTime := DOB;
    qryMember.Post;
    qryMember.EnableControls;
  end;
end;

procedure TManageMemberData.UpdateElectedOn(aDate: TDate);
begin
  if Assigned(qryMember.Connection) and (qryMember.Active) then
  begin
    qryMember.DisableControls;
    qryMember.edit;
    qryMember.FieldByName('ElectedOn').AsDateTime := aDate;
    qryMember.Post;
    qryMember.EnableControls;
  end;
end;

procedure TManageMemberData.UpdateMember(SwimClubID: Integer;
  hideArchived, hideInactive, hideNonSwimmer: Boolean);
begin
  if not Assigned(FConnection) then
    exit;
  if not qryMember.Active then
    exit;

  qryMember.DisableControls;
  qryMember.Close;
  if SwimClubID <> 0 then
  begin
    qryMember.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
    qryMember.ParamByName('HIDE_ARCHIVED').AsBoolean := hideArchived;
    qryMember.ParamByName('HIDE_INACTIVE').AsBoolean := hideInactive;
    qryMember.ParamByName('HIDE_NONSWIMMERS').AsBoolean := hideNonSwimmer;
    qryMember.Prepare;
    qryMember.Open;
    if qryMember.Active then
    begin
      fRecordCount := qryMember.RecordCount;
      if not Assigned(qryContactNum.Connection) then
        qryContactNum.Connection := FConnection;
      if not qryContactNum.Active then
        qryContactNum.Open;
    end
    else
      fRecordCount := 0;
  end;
  qryMember.EnableControls;


end;

procedure TManageMemberData.UpdateMembersPersonalBest;
begin
  if not Assigned(FConnection) then
    exit;
  if not dsMember.DataSet.Active then
    exit;
  // to improve loading performance of the Member's Dialogue
  // the 'personal bests' for a member are loaded on demand.
  qryMemberPB.DisableControls;
  qryMemberPB.Close();
  qryMemberPB.ParamByName('MEMBERID').AsInteger :=
    dsMember.DataSet.FieldByName('MemberID').AsInteger;
  // ensures params changes are used
  qryMemberPB.Prepare();
  qryMemberPB.Open();
  qryMemberPB.EnableControls;
end;

procedure TManageMemberData.UpdateRetiredOn(aDate: TDate);
begin
  if Assigned(qryMember.Connection) and (qryMember.Active) then
  begin
    qryMember.DisableControls;
    qryMember.edit;
    qryMember.FieldByName('RetiredOn').AsDateTime := aDate;
    qryMember.Post;
    qryMember.EnableControls;
  end;
end;

procedure TManageMemberData.WndProc(var wndMsg: TMessage);
var
  dt, currDt: TDateTime;
  fldName: string;
  st: TSystemTime;
begin
  if (wndMsg.WParam = 0) then
    exit;

  if (wndMsg.Msg = SCM_DOBUPDATED) OR (wndMsg.Msg = SCM_ELECTEDONUPDATED) OR
    (wndMsg.Msg = SCM_RETIREDONUPDATED) then
  BEGIN
    case wndMsg.Msg of
      SCM_DOBUPDATED:
        fldName := 'DOB';
      SCM_ELECTEDONUPDATED:
        fldName := 'ElectedOn';
      SCM_RETIREDONUPDATED:
        fldName := 'RetiredOn';
    end;

    try
      st := pSystemTime(wndMsg.WParam)^;
      if (st.wYear = 0) then
        dt := 0
      else
      begin
        dt := SystemTimeToDateTime(st);
      end;
    except
      on E: Exception do
        raise;
    end;
    {TODO -oBSA -cGeneral : IsNul?}
    currDt := dsMember.DataSet.FieldByName(fldName).AsDateTime;
    if dt <> currDt then
    BEGIN
      dsMember.DataSet.DisableControls;
      if (dsMember.DataSet.State <> dsEdit) or
        (dsMember.DataSet.State <> dsInsert) then
      begin
        dsMember.DataSet.CheckBrowseMode;
        dsMember.DataSet.edit;
      end;
      if (dt = 0) then
        dsMember.DataSet.FieldByName(fldName).Clear
      else
        dsMember.DataSet.FieldByName(fldName).AsDateTime := dt;
      dsMember.DataSet.Post;
      dsMember.DataSet.EnableControls;
    END;

  END;

end;

end.
