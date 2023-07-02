unit dmManageMemberData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, dmSCM;

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
    qryMemberSwimmerAge: TIntegerField;
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
    qryMemberABREV: TWideStringField;
    qryMemberMETADATA: TWideMemoField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryMemberAfterDelete(DataSet: TDataSet);
    procedure qryMemberAfterInsert(DataSet: TDataSet);
    procedure qryMemberAfterScroll(DataSet: TDataSet);
    procedure qryMemberBeforeDelete(DataSet: TDataSet);
    procedure qryMemberMETADATAGetText(Sender: TField; var Text: string;
        DisplayText: Boolean);
    procedure qryMemberMETADATASetText(Sender: TField; const Text: string);
    procedure qryMemberRoleLnkluMemberRoleStrChange(Sender: TField);
    procedure qryMemberRoleLnkNewRecord(DataSet: TDataSet);
  private
    FConnection: TFDConnection;
    { Private declarations }
    fManageMemberDataActive: boolean;
    fRecordCount: Integer;
    procedure UpdateMembersPersonalBest;
  public
    { Public declarations }
    constructor CreateWithConnection(AOwner: TComponent;
      AConnection: TFDConnection);
    procedure ActivateTable();
    procedure FixNullBooleans();
    function LocateMember(MemberID: Integer): boolean;
    procedure UpdateDOB(DOB: TDateTime);
    procedure UpdateMember(SwimClubID: Integer;
      hideArchived, hideInactive, hideNonSwimmer: boolean);
    property Connection: TFDConnection read FConnection write FConnection;
    property ManageMemberDataActive: boolean read fManageMemberDataActive
      write fManageMemberDataActive;
    property RecordCount: Integer read fRecordCount;
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
  Winapi.Messages, vcl.Dialogs, System.UITypes, vcl.Forms;

constructor TManageMemberData.CreateWithConnection(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  inherited Create(AOwner);
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
    qryMemberPB.Connection := FConnection;
    // prepare lookup tables.
    tblStroke.Connection := FConnection;
    tblDistance.Connection := FConnection;
    qryMemberRoleLnk.Connection := FConnection;
    tblGender.Connection := FConnection;
    tblHouse.Connection := FConnection;
    tblContactNumType.Connection := FConnection;
    qrySwimClub.Open;
    if qrySwimClub.Active then
    begin
      // Lookup tables used by member
      tblStroke.Open;
      tblDistance.Open;
      qryMemberRoleLnk.Open;
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

procedure TManageMemberData.qryMemberAfterScroll(DataSet: TDataSet);
begin
  // Display Members Personal Best
  UpdateMembersPersonalBest();
  // Post directly to parent form : TForm(Self.GetOwner).Handle;
  // Uses : Vcl.Forms
  if Owner is TForm then
    PostMessage(TForm(Owner).Handle, SCM_AFTERSCROLL, 0, 0);
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

procedure TManageMemberData.qryMemberMETADATAGetText(Sender: TField; var Text:
    string; DisplayText: Boolean);
begin
  Text := Sender.AsString;
end;

procedure TManageMemberData.qryMemberMETADATASetText(Sender: TField; const
    Text: string);
begin
    Sender.AsString := Text;
end;

procedure TManageMemberData.qryMemberRoleLnkluMemberRoleStrChange
  (Sender: TField);
begin
  // test that MemberID has been assigned
//  if qryMemberRoleLnk.FieldByName('MemberID').IsNull then
//  begin
//    qryMemberRoleLnk.FieldByName('MemberID').AsInteger :=
//      dsMember.DataSet.FieldByName('MemberID').AsInteger;
//    qryMemberRoleLnk.FieldByName('IsArchived').AsBoolean := false;
//    qryMemberRoleLnk.FieldByName('IsActive').AsBoolean := false;
//  end;
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
  fld := DataSet.FieldByName('MemberID');
  if (fld.IsNull) then
  begin
    fld.AsInteger := dsMember.DataSet.FieldByName('MemberID').AsInteger;
  end;
//  fld := DataSet.FieldByName('MemberRoleID');
//  if (fld.IsNull) then
//  begin
//    fld.AsInteger := 0;
//  end;
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
  // Post directly to parent form : TForm(Self.GetOwner).Handle;
  // Uses : Vcl.Forms
  if Owner is TForm then
    PostMessage(TForm(Owner).Handle, SCM_UPDATE, 0, 0);

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

end.
