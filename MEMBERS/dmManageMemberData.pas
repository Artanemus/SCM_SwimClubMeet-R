unit dmManageMemberData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef;

type
  TManageMemberData = class(TDataModule)
    tblContactNumType: TFDTable;
    tblContactNumTypeContactNumTypeID: TFDAutoIncField;
    tblContactNumTypeCaption: TWideStringField;
    tblStroke: TFDTable;
    tblDistance: TFDTable;
    dsMember: TDataSource;
    qryMember: TFDQuery;
    qryMemberMemberID: TFDAutoIncField;
    qryMemberMembershipDue: TSQLTimeStampField;
    qryMemberMembershipNum: TIntegerField;
    qryMemberFirstName: TWideStringField;
    qryMemberLastName: TWideStringField;
    qryMemberFName: TWideStringField;
    qryMemberDOB: TSQLTimeStampField;
    qryMemberSwimmerAge: TIntegerField;
    qryMemberIsActive: TBooleanField;
    qryMemberIsSwimmer: TBooleanField;
    qryMemberIsArchived: TBooleanField;
    qryMemberEmail: TWideStringField;
    qryMemberSwimClubID: TIntegerField;
    qryMemberCreatedOn: TSQLTimeStampField;
    qryMemberArchivedOn: TSQLTimeStampField;
    qryMemberGenderID: TIntegerField;
    qryMemberluGender: TStringField;
    qryMemberluMembershipType: TStringField;
    qryMemberMembershipTypeID: TIntegerField;
    qryMemberluHouse: TStringField;
    qryMemberHouseID: TIntegerField;
    tblMembershipType: TFDTable;
    dsMembershipType: TDataSource;
    tblGender: TFDTable;
    dsGender: TDataSource;
    dsHouse: TDataSource;
    tblHouse: TFDTable;
    dsContactNum: TDataSource;
    qryContactNum: TFDQuery;
    qryContactNumContactNumID: TFDAutoIncField;
    qryContactNumNumber: TWideStringField;
    qryContactNumContactNumTypeID: TIntegerField;
    qryContactNumMemberID: TIntegerField;
    qryContactNumlu: TStringField;
    qrySwimClub: TFDQuery;
    dsSwimClub: TDataSource;
    qryMemberMembershipStr: TWideStringField;
    qryFindMember: TFDQuery;
    qryFindMemberMemberID: TFDAutoIncField;
    qryFindMemberMembershipNum: TIntegerField;
    qryFindMemberFName: TWideStringField;
    qryFindMemberdtDOB: TWideStringField;
    qryFindMemberAge: TIntegerField;
    qryFindMemberIsActive: TBooleanField;
    qryFindMembercGender: TWideStringField;
    qryFindMembercMembershipType: TWideStringField;
    qryFindMemberFirstName: TWideStringField;
    qryFindMemberLastName: TWideStringField;
    qryFindMemberGenderID: TIntegerField;
    qryFindMemberMemberShipTypeID: TIntegerField;
    qryFindMemberIsSwimmer: TBooleanField;
    dsFindMember: TDataSource;
    qAssertMemberID: TFDQuery;
    qryEntrantDataCount: TFDQuery;
    cmdFixNullBooleans: TFDCommand;
    dsMemberPB: TDataSource;
    qryMemberPB: TFDQuery;
    qryMemberPBEventStr: TWideStringField;
    qryMemberPBPB: TTimeField;
    qryMemberPBMemberID: TFDAutoIncField;
    qryMemberPBDistanceID: TFDAutoIncField;
    qryMemberPBStrokeID: TFDAutoIncField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryMemberAfterScroll(DataSet: TDataSet);
    procedure qryMemberAfterInsert(DataSet: TDataSet);
    procedure qryMemberBeforeDelete(DataSet: TDataSet);
    procedure qryMemberAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
    fManageMemberDataActive: boolean;
    fRecordCount: Integer;
    FConnection: TFDConnection;
    procedure UpdateMembersPersonalBest;

  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      AConnection: TFDConnection);
    procedure ActivateTable();
    procedure UpdateDOB(DOB: TDateTime);
    procedure UpdateMember(SwimClubID: Integer;
      hideArchived, hideInactive, hideNonSwimmer: boolean);
    procedure FixNullBooleans();
    function LocateMember(MemberID: Integer): boolean;
    property ManageMemberDataActive: boolean read fManageMemberDataActive
      write fManageMemberDataActive;
    property RecordCount: Integer read fRecordCount;
    property Connection: TFDConnection read FConnection write FConnection;

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
  System.IOUtils, IniFiles, SCMUtility, SCMDefines, Winapi.Windows,
  Winapi.Messages, vcl.Dialogs, System.UITypes, Vcl.Forms;

procedure TManageMemberData.ActivateTable;
begin
  fManageMemberDataActive := false;
  if Assigned(FConnection) and FConnection.Connected then
  begin
    qrySwimClub.Connection := FConnection;
    qryMember.Connection := FConnection;
    qryContactNum.Connection := FConnection;
    qryMemberPB.Connection :=FConnection;
    // prepare lookup tables.
    tblStroke.Connection := FConnection;
    tblDistance.Connection := FConnection;
    tblMembershipType.Connection := FConnection;
    tblGender.Connection := FConnection;
    tblHouse.Connection := FConnection;
    tblContactNumType.Connection := FConnection;
    qrySwimClub.Open;
    if qrySwimClub.Active then
    begin
      // Lookup tables used by member
      tblStroke.Open;
      tblDistance.Open;
      tblMembershipType.Open;
      tblGender.Open;
      tblHouse.Open;
      qryMember.Open;
      if qryMember.Active then
      begin
        // Lookup table used by contactnum
        tblContactNumType.Open;
        qryContactNum.Open;
        if qryContactNum.Active then
        begin
          fManageMemberDataActive := True;
        end;
      end;
    end;
  end;
end;

constructor TManageMemberData.CreateWithConnection(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  inherited Create(AOwner);
  FConnection := AConnection;
end;

procedure TManageMemberData.DataModuleCreate(Sender: TObject);
begin
  // TODO:
  if Assigned(FConnection) then
    ActivateTable;
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

function TManageMemberData.LocateMember(MemberID: Integer): boolean;
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

procedure TManageMemberData.qryMemberAfterDelete(DataSet: TDataSet);
begin
  // Refresh display ?
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

  // DB : v1,1,5,0 v1,1,5,1 - required.
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

procedure TManageMemberData.qryMemberAfterScroll(DataSet: TDataSet);
begin
  // Display Members Personal Best
  UpdateMembersPersonalBest();
  // Post directly to parent form : TForm(Self.GetOwner).Handle;
  // Uses : Vcl.Forms
  if Owner is TForm then
    PostMessage(TForm(Owner).Handle, MANAGEMEMBER_AFTERSCROLL, 0, 0);
end;

procedure TManageMemberData.qryMemberBeforeDelete(DataSet: TDataSet);
var
  SQL: string;
  MemberID, result: Integer;
begin
  // Best to finalize any editing - prior to calling execute statements.
  DataSet.CheckBrowseMode;
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
    qryMember.DisableControls; // will it stop refresh of contact table?
    // remove all the relationships in associated tables for this member
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[ContactNum] WHERE MemberID = ' +
      IntToStr(MemberID) + ';';
    FConnection.ExecSQL(SQL);
    { TODO -oBen -cGeneral : db.Split and dbo.TeamSplit need to be handled prior to cleaning dbo.Entrant. }
    SQL := 'UPDATE [SwimClubMeet].[dbo].[Entrant] SET [MemberID] = NULL, ' +
      '[RaceTime] = NULL, [TimeToBeat] = NULL, [PersonalBest] = NULL, ' +
      '[IsDisqualified] = 0,[IsScratched] = 0 WHERE MemberID = ' +
      IntToStr(MemberID) + ';';
    FConnection.ExecSQL(SQL);
    { TODO -oBen -cGeneral : TeamEntrant table design incomplete. Additional fields needed. }
    SQL := 'UPDATE [SwimClubMeet].[dbo].[TeamEntrant] SET [MemberID] = NULL,  [RaceTime] = NULL WHERE MemberID = '
      + IntToStr(MemberID) + ';';
    FConnection.ExecSQL(SQL);
    { TODO -oBen -cGeneral : DELETE from TeamNominee - remove all member's nominations to relay events. }
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[Nominee] WHERE MemberID = ' +
      IntToStr(MemberID) + ';';
    FConnection.ExecSQL(SQL);

    { TODO -oBen -cGeneral : Remove link }
    (*
    SQL := 'DELETE FROM [SwimClubMeet].[dbo].[lnkSwimClubMember] WHERE MemberID = '
      + IntToStr(MemberID) + ' AND SwimClubID = ' +
      IntToStr(qrySwimClub.FieldByName('SwimClubID').AsInteger) + ';';
    FConnection.ExecSQL(SQL);
    *)

    qryMember.EnableControls;
  end;
end;

procedure TManageMemberData.UpdateDOB(DOB: TDateTime);
begin
  if Assigned(qryMember.Connection) and (qryMember.Active) then
  begin
    qryMember.DisableControls;
    qryMember.Edit;
    qryMember.FieldByName('DOB').AsDateTime := DOB;
    qryMember.Post;
    qryMember.EnableControls;
  end;

end;

procedure TManageMemberData.UpdateMember(SwimClubID: Integer;
  hideArchived, hideInactive, hideNonSwimmer: boolean);
begin
  if not Assigned(FConnection) then
    exit;
  if not qrymember.Active then exit;

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
  // Post directly to parent form : TForm(Self.GetOwner).Handle;
  // Uses : Vcl.Forms
  if Owner is TForm then
    PostMessage(TForm(Owner).Handle, MANAGEMEMBER_UPDATE, 0, 0);

end;

procedure TManageMemberData.UpdateMembersPersonalBest;
begin
  if not Assigned(FConnection) then
    exit;
  if not dsMember.DataSet.Active then
    exit;
  // to improve loading performance of the Member's Dialogue
  // the 'personal bests' for a member are loaded on demand.
  qrymemberPb.DisableControls;
  qryMemberPB.Close();
  qryMemberPB.ParamByName('MEMBERID').AsInteger :=
    dsMember.DataSet.FieldByName('MemberID').AsInteger;
  // ensures params changes are used
  qryMemberPB.Prepare();
  qryMemberPB.Open();
  qrymemberPb.enableControls;
end;

end.
