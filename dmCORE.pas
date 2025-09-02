unit dmCORE;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.StrUtils,
  System.DateUtils,
  WinApi.Windows,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.BaseImageCollection,
  System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, vcl.Dialogs,
  FireDAC.UI.Intf, FireDAC.VCLUI.Error, FireDAC.Comp.UI,
	SVGIconVirtualImageList, SVGIconImageCollection,
  uSettings, uDefines, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait
  ;

type
  TCORE = class(TDataModule)
		dsEvent: TDataSource;
		dsHeat: TDataSource;
		dsLane: TDataSource;
		dsNominee: TDataSource;
		dsSession: TDataSource;
		dsSplitTime: TDataSource;
		dsSwimClub: TDataSource;
		dsTeam: TDataSource;
		dsWatchTime: TDataSource;
		LookUpDistance: TStringField;
		LookUpStroke: TStringField;
		luDistance: TDataSource;
		luStroke: TDataSource;
		qryEvent: TFDQuery;
		qryEventCaption: TWideStringField;
		qryEventDistanceID: TIntegerField;
		qryEventEntrantCount: TIntegerField;
		qryEventEventID: TFDAutoIncField;
		qryEventEventNum: TIntegerField;
		qryEventEventStatusID: TIntegerField;
		qryEventEventTypeID: TIntegerField;
		qryEventGenderID: TIntegerField;
		qryEventNomineeCount: TIntegerField;
		qryEventParalympicTypeID: TIntegerField;
		qryEventRoundID: TIntegerField;
		qryEventSessionID: TIntegerField;
		qryEventShortCaption: TWideStringField;
		qryEventStrokeID: TIntegerField;
		qryHeat: TFDQuery;
		qryHeatEventID: TIntegerField;
		qryHeatHeatID: TFDAutoIncField;
		qryHeatHeatNum: TIntegerField;
		qryHeatHeatStatusID: TIntegerField;
		qryHeatHeatTypeID: TIntegerField;
		qryLane: TFDQuery;
		qryNominee: TFDQuery;
		qrySession: TFDQuery;
		qrySplitTime: TFDQuery;
		qrySwimClub: TFDQuery;
		qryTeam: TFDQuery;
		qryTeamLink: TFDQuery;
		qryWatchTime: TFDQuery;
		tblDistance: TFDTable;
		tblStroke: TFDTable;
    LookUpEventTypeID: TIntegerField;
    qryHeatStrokeID: TIntegerField;
    dsTeamLink: TDataSource;
    qryMember: TFDQuery;
    dsMemberLink: TDataSource;
    dsMember: TDataSource;
    qryMemberLink: TFDQuery;
    qryEventStartTime: TTimeField;
    qryEventEventCategoryID: TIntegerField;
    qryEventDistanceStr: TWideStringField;
    qryEventStrokeStr: TWideStringField;
    qryHeatCaption: TWideStringField;
    qryHeatStartTime: TTimeField;
    qrySessionSessionID: TFDAutoIncField;
    qrySessionSessionDT: TSQLTimeStampField;
    qrySessionCaption: TWideStringField;
    qrySessionNomineeCount: TIntegerField;
    qrySessionEntrantCount: TIntegerField;
    qrySessionCreatedOn: TSQLTimeStampField;
    qrySessionModifiedOn: TSQLTimeStampField;
    qrySessionSwimClubID: TIntegerField;
    qrySessionSessionStatusID: TIntegerField;
    TempConnection: TFDConnection;
		procedure DataModuleCreate(Sender: TObject);
		procedure DataModuleDestroy(Sender: TObject);
    procedure qryEventAfterScroll(DataSet: TDataSet);
    procedure qryHeatAfterScroll(DataSet: TDataSet);
    procedure qrySessionAfterScroll(DataSet: TDataSet);
    procedure qrySessionBeforePost(DataSet: TDataSet);
    procedure qrySessionNewRecord(DataSet: TDataSet);
    procedure qrySessionSessionDTGetText(Sender: TField; var Text: string;
        DisplayText: Boolean);
    procedure qrySessionSessionDTSetText(Sender: TField; const Text: string);
    procedure qrySwimClubAfterScroll(DataSet: TDataSet);
	private
    FIsActive: boolean;
    msgHandle: HWND;  // TForm.dtfrmExec ...   // Both DataModules

	public
		function ActivateCore(): boolean;
		function DeActivateCore(): boolean;
    property IsActive: boolean read FIsActive write FIsActive;
    property MSG_Handle: HWND read msgHandle write msgHandle;  // Both DataModules
	end;

var
  CORE: TCORE;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dmSCM;

{$R *.dfm}

function TCORE.ActivateCore: boolean;
var
  msg: string;
begin
	FIsActive := false;
	if not Assigned(SCM) or not SCM.scmConnection.Connected then exit;
	try
		// MASTER.
		qrySwimClub.Open;
    if qrySwimClub.Active then
    begin
      qrySwimClub.First;
      // lookup tables.
      tblStroke.Open;
      tblDistance.Open;
      // DETAILED TABLES.
      qrySession.IndexName := 'indxShowAll'; // Locked and unlocked sessions.
      qrySession.Open;
      qryEvent.Open;
      qryHeat.Open;
      qryLane.Open;
      qryWatchTime.Open;
      qrySplitTime.open;
      qryTeam.Open;
      qryTeamLink.Open;
      FIsActive := true;
    end
    else
    begin
      msg := '''
        Master table [dbo].[SwimClub] failed to open.
        Unable to activate the core tables!
        ''';
      raise Exception.Create('msg');
    end;
	except
		on E: EFDDBEngineException do begin
			raise;
		end;
	end;
	FIsActive := false;
end;

procedure TCORE.DataModuleCreate(Sender: TObject);
begin
	FIsActive := false;
end;

procedure TCORE.DataModuleDestroy(Sender: TObject);
begin
	// cleanup ...
end;

function TCORE.DeActivateCore: boolean;
begin
	FIsActive := false;
	// Detailed tables.
  qrySession.Close;
	qryEvent.Close;
	qryHeat.Close;
	qryLane.Close;
	qryWatchTime.Close;
	qrySplitTime.Close;
	qryTeam.Close;
	qryTeamLink.Close;
	// lookup tables.
	tblStroke.Close;
	tblDistance.Close;
  // Master.
	qrySwimClub.Close;
end;

procedure TCORE.qryEventAfterScroll(DataSet: TDataSet);
begin
  if (msgHandle <> 0) then
  begin
    PostMessage(msgHandle, SCM_SCROLL_EVENT, 0,0);
  end;
end;

procedure TCORE.qryHeatAfterScroll(DataSet: TDataSet);
begin
  if (msgHandle <> 0) then
  begin
    PostMessage(msgHandle, SCM_SCROLL_HEAT, 0,0);
  end;
end;

procedure TCORE.qrySessionAfterScroll(DataSet: TDataSet);
begin
  if (msgHandle <> 0) then
  begin
    PostMessage(msgHandle, SCM_SCROLL_SESSION, 0,0);
  end;
end;

procedure TCORE.qrySessionBeforePost(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('SessionStatusID').IsNull) then
      DataSet.FieldByName('SessionStatusID').AsInteger := 1;
end;

procedure TCORE.qrySessionNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('SwimClubID').AsInteger :=
    qrySwimClub.FieldByName('SwimClubID').AsInteger; // Master-Detail
  DataSet.FieldByName('SessionDT').AsDateTime := Now();
  DataSet.FieldByName('CreatedOn').AsDateTime := Now();
  DataSet.FieldByName('SessionStatusID').AsInteger := 1; // Open.
end;

procedure TCORE.qrySessionSessionDTGetText(Sender: TField; var Text: string;
    DisplayText: Boolean);
var
  fs: TFormatSettings;
  DT: TDateTime;
  AHour: Word;
begin
  fs.DateSeparator := '-';
  fs.TimeSeparator := ':';
  fs.ShortDateFormat := 'yyyy-mm-dd hh:nn';
  DT := Now;
  AHour := DT.GetHour;
  DT.SetTime(AHour, 0, 0, 0);

  if Sender.IsNull then
  begin
    Text := Datetostr(DT, fs);
  end
  else
    // which is best ... (will always use ShortDateFormat)
    // Text := DateTimeToStr(Sender.AsDateTime, fs);
    // or use this method?
    // AI answers: FormatDateTime is preferred for custom formats.
    Text := FormatDateTime('yyyy-mm-dd hh:nn', Sender.AsDateTime, fs);
end;

procedure TCORE.qrySessionSessionDTSetText(Sender: TField; const Text: string);
var
  fs: TFormatSettings;
  DT: TDateTime;
begin
  fs.DateSeparator := '-';
  fs.TimeSeparator := ':';
  fs.ShortDateFormat := 'yyyy-mm-dd hh:nn';

  if Text = '' then
    Sender.Clear
  else
  begin
    try
      DT := StrToDateTime(Text, fs);
      Sender.AsDateTime := DT;
    except
      on E: EConvertError do
      begin
        ShowMessage(E.ClassName + #10 + E.Message);
      end;
    end;
  end;
end;

procedure TCORE.qrySwimClubAfterScroll(DataSet: TDataSet);
begin
  if (msgHandle <> 0) then
  begin
    PostMessage(msgHandle, SCM_SCROLL_SWIMCLUB, 0,0);
  end;
end;



(*
		procedure qrySessionAfterDelete(DataSet: TDataSet);
		procedure qrySessionAfterPost(DataSet: TDataSet);
		procedure qrySessionAfterScroll(DataSet: TDataSet);
		procedure qrySessionBeforePost(DataSet: TDataSet);
		procedure qrySessionNewRecord(DataSet: TDataSet);
		procedure qrySessionSessionStartGetText(Sender: TField; var Text: string;
			DisplayText: Boolean);
		procedure qrySessionSessionStartSetText(Sender: TField; const Text: string);
*)



(*
	procedure qryEventAfterDelete(DataSet: TDataSet);
	procedure qryEventAfterInsert(DataSet: TDataSet);
	procedure qryEventAfterPost(DataSet: TDataSet);
	procedure qryEventAfterScroll(DataSet: TDataSet);
	procedure qryEventBeforeEdit(DataSet: TDataSet);
	procedure qryEventBeforeInsert(DataSet: TDataSet);
	procedure qryEventBeforePost(DataSet: TDataSet);
	procedure qryEventDistanceIDValidate(Sender: TField);
	procedure qryEventEventStatusIDGetText(Sender: TField; var Text: string;
		DisplayText: Boolean);
	procedure qryEventNewRecord(DataSet: TDataSet);
	procedure qryEventScheduleDTGetText(Sender: TField; var Text: string;
		DisplayText: Boolean);
	procedure qryEventScheduleDTSetText(Sender: TField; const Text: string);


*)


(*
		procedure qryHeatAfterDelete(DataSet: TDataSet);
		procedure qryHeatAfterInsert(DataSet: TDataSet);
		procedure qryHeatAfterPost(DataSet: TDataSet);
		procedure qryHeatAfterScroll(DataSet: TDataSet);
		procedure qryHeatNewRecord(DataSet: TDataSet);

*)



(*
procedure T_Event.qryEventAfterDelete(DataSet: TDataSet);
begin

  	if Owner is TForm then
  	begin
  			PostMessage(TForm(Owner).Handle, SCM_RENUMBEREVENTS, 0, 0);
		end;

end;

procedure T_Event.qryEventAfterInsert(DataSet: TDataSet);
var
fld: TField;
begin
  fld := DataSet.FieldByName('EventStatusID');
	fld.ReadOnly := true;
end;

procedure T_Event.qryEventAfterPost(DataSet: TDataSet);
var
  i, v: integer;
  DistanceID, StrokeID, entrantCount: integer;
//  EventType : scmEventType;
	Caption: string;

begin
  // NOTE: DataSet.State := dsBrowse
	v := DataSet.FieldByName('EventNum').AsVariant;
	if VarIsNull(v) or VarIsEmpty(v) or (v = 0) then
	begin
    i := DataSet.RecordCount;
    DataSet.FieldByName('EventNum').ReadOnly := false;
    DataSet.Edit;
    DataSet.FieldByName('EventNum').AsInteger := i;
    DataSet.Post;

  		if Owner is TForm then
					PostMessage(TForm(Owner).Handle, SCM_RENUMBEREVENTS, 0, 0);

	end;
  // Don’t need to put the dataset into edit mode to change readmode
  if (DataSet.FieldByName('EventNum').ReadOnly = false) then
    DataSet.FieldByName('EventNum').ReadOnly := true;

	DistanceID := DataSet.FieldByName('DistanceID').AsInteger;
  StrokeID := DataSet.FieldByName('StrokeID').AsInteger;
	if ((DistanceID <> fLastDistanceID) or (StrokeID <> fLastStrokeID)) then
  begin
    i := DataSet.FieldByName('EventID').AsInteger;
    entrantCount := Event_GetEntrantCount(i);
    if (entrantCount > 0) then
    begin
      // display warning message
      MessageDlg('If an Event''s distance or stroke is changed' + slinebreak +
        'then the nominees attached to that event also reflect' + slinebreak +
				'those changes.', mtWarning, [mbOK], 0);

      // clear the caption ....
      DataSet.Edit;
      DataSet.FieldByName('Caption').Clear;
      DataSet.Post;

		end;
	end;

	Caption := DataSet.FieldByName('Caption').AsString;

	if Caption.IsEmpty then  // ADD A DEFAULT CAPTION
	begin
		if (prefGenerateEventDescription) then
		begin
			if not prefGenerateEventDescStr.IsEmpty then
			begin
				DataSet.Edit;
				DataSet.FieldByName('Caption').AsString := prefGenerateEventDescStr;
				DataSet.Post;
			end;
		end;
	end;

end;

procedure T_Event.qryEventAfterScroll(DataSet: TDataSet);
begin

  	if Owner is TForm then
				PostMessage(TForm(Owner).Handle, SCM_EVENTSCROLL, 0, 0);


end;

procedure T_Event.qryEventBeforeEdit(DataSet: TDataSet);
begin
  // This is used later in the qryEvent BeforePost to determine if
  // a warning message is displayed. wit: 'Nominees will be swimming a
  // different stroke/distance'.
  fLastDistanceID := DataSet.FieldByName('DistanceID').AsInteger;
  fLastStrokeID := DataSet.FieldByName('StrokeID').AsInteger;;
end;

procedure T_Event.qryEventBeforeInsert(DataSet: TDataSet);
var
fld: TField;
begin
  fld := DataSet.FieldByName('EventStatusID');
  fld.ReadOnly := false;
end;

procedure T_Event.qryEventBeforePost(DataSet: TDataSet);
begin
	{TODO -oBSA -cGeneral : Auto assignment on empty fields.}
	// [dbo].[Event].[RoundID] - set to preliminary.. default Preliminary.(P)
	// [dbo].[Event].[GenderID] - set to MIXED via dbo.GenderPrefix.(Mixed ..X)
end;

procedure T_Event.qryEventDistanceIDValidate(Sender: TField);
var
  v1, v2, v3: variant;
  i: integer;
  SQL: string;
begin
  // Check unknown (typically occurs on 'new event')
  if VarIsNull(Sender.CurValue) or VarIsEmpty(Sender.CurValue) then exit;

  // INDV or TEAM
  SQL := 'SELECT EventTypeID FROM SwimClubMeet2.dbo.Distance WHERE [DistanceID] = :ID';
	v1 := SCM.SCM.scmConnection.ExecSQLScalar(SQL, [Sender.CurValue], [ftInteger]);
	v2 := SCM.SCM.scmConnection.ExecSQLScalar(SQL, [Sender.Value], [ftInteger]);
  if v1 <> v2 then // switching event type ...
  begin
    // test for Heats
    SQL := 'SELECT Count(HeatID) FROM SwimClubMeet2.dbo.Heat WHERE [EventID] = :ID';
    i := Event_ID;
		v3 := SCM.SCM.scmConnection.ExecSQLScalar(SQL, [i]);
    if (v3 <> 0) then
    begin
      Raise Exception.Create
        ('When an event has heats it cannot be switched between INDV and RELAY');
    end;
  end;
end;

procedure T_Event.qryEventEventStatusIDGetText(Sender: TField; var Text: string;
	DisplayText: Boolean);
begin
	// column should only show a tick ...
	// TODO: disable selection of the column.
	Text := '';
end;

procedure T_Event.qryEventNewRecord(DataSet: TDataSet);
begin
	DataSet.FieldByName('EventStatusID').AsInteger := 1;
	DataSet.FieldByName('DistanceID').AsInteger := 1;
  DataSet.FieldByName('StrokeID').AsInteger := 1;
  DataSet.FieldByName('EventStatusID').AsInteger := 1;
end;

procedure T_Event.qryEventScheduleDTGetText(Sender: TField; var Text: string;
	DisplayText: Boolean);
begin
  if Sender.IsNull then Text := ''
  else Text := FormatDateTime('hh:nn', Sender.AsDateTime);
end;

procedure T_Event.qryEventScheduleDTSetText(Sender: TField; const Text: string);
var
  dt: TDateTime;
  fs: TFormatSettings;
  s: string;
begin
  if Length(Text) = 0 then
  begin
    Sender.Clear;
    exit;
  end;

	s := ReplaceText(Text, ' ', '0'); // tidy-up : replace editmask spaces
  fs := TFormatSettings.Create; // class record - free not required.
  if TryStrToTime(s, dt, fs) then
  begin
    Sender.AsDateTime := dt; // NOTE: Only time portion is used by DB.
  end;

end;

*)





(*
procedure T_Session.qrySessionAfterDelete(DataSet: TDataSet);
begin
  if Owner is TForm then
      PostMessage(TForm(Owner).Handle, SCM_TABSHEETDISPLAYSTATE, 1, 0);
end;

procedure T_Session.qrySessionAfterPost(DataSet: TDataSet);
begin
  // if the session table is empty ... then the events GUI is invisible
  // after any post (or insert) assert that events is visible
  //
  if Owner is TForm then
      PostMessage(TForm(Owner).Handle, SCM_TABSHEETDISPLAYSTATE, 1, 0);
end;

procedure T_Session.qrySessionAfterScroll(DataSet: TDataSet);
begin
  { TODO -oBSA -cGeneral : WIN API Messaging }
  if Owner is TForm then
      PostMessage(TForm(Owner).Handle, SCM_SESSIONSCROLL, 0, 0);
end;

procedure T_Session.qrySessionBeforePost(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('SessionStatusID').IsNull) then
      DataSet.FieldByName('SessionStatusID').AsInteger := 1;
end;

procedure T_Session.qrySessionNewRecord(DataSet: TDataSet);
begin
	{
    The main difference between AfterInsert and NewRecord is that all changes
    you do in NewRecord don't set the modified flag for the dataset, so you can
    set your default values and before posting the record you can still check
    for the modified property to see if the user has actually changed the data.
	}
  DataSet.FieldByName('SessionStart').AsDateTime := Now;
  DataSet.FieldByName('SessionStatusID').AsInteger := 1;
end;

procedure T_Session.qrySessionSessionStartGetText(Sender: TField; var Text: string;
	DisplayText: Boolean);
var
  fs: TFormatSettings;
  s: string;
  i, i2: integer;
  MonthPreceeds: Boolean;
begin
  // Furnish the locale format settings record
  fs := TFormatSettings.Create();
  s := fs.ShortDateFormat;
  // AMERICAN or WORLD month-day order ...
  i := Pos('D', UpperCase(s));
  i2 := Pos('M', UpperCase(s));
  MonthPreceeds := false;
  if (i2 < i) then MonthPreceeds := true;
  // DisplayText is true if the field's value is to be used for display only;
  // false if the string is to be used for editing the field's value.
	if (DisplayText) then
    // The format as set by the LOCALE
    // Numerous display possibilities YY/MM/DD hh:mm ttt or mm/dd/yyyy etc ....
			Text := FormatDateTime(fs.ShortDateFormat + ' ' + fs.ShortTimeFormat,
      Sender.AsDateTime, fs)
  else
    // FORMAT 'STRICT' - USED WHEN EDITING .....
    // Using FS ensures correct values are pulled ....
    if (MonthPreceeds) then
        Text := FormatDateTime('MM/dd/yy HH:nn', Sender.AsDateTime, fs)
    else Text := FormatDateTime('dd/MM/yy HH:nn', Sender.AsDateTime, fs);
end;

procedure T_Session.qrySessionSessionStartSetText(Sender: TField;
	const Text: string);
var
  year, month, day, Hour, Min, txt: string;
  sa: TStringDynArray;
  dt: TDateTime;
  i, i2: integer;
  MonthPreceeds: Boolean;
  fs: TFormatSettings;

begin
  MonthPreceeds := false;
  fs := fs.Create();
  i := Pos('D', UpperCase(fs.ShortDateFormat));
  i2 := Pos('M', UpperCase(fs.ShortDateFormat));
  if (i2 < i) then MonthPreceeds := true;

  // Text excludes literal character used in editmask!
  txt := Text;
  // Insert missing literal characters - required to get SlitString running
  if (Length(txt) = 14) then
  begin
    if (txt[1] = ' ') then txt[1] := '0';
    if (txt[2] = ' ') then txt[2] := '0';
    if (txt[4] = ' ') then txt[4] := '0';
    if (txt[5] = ' ') then txt[5] := '0';
    if (txt[7] = ' ') then txt[7] := '0';
    if (txt[8] = ' ') then txt[8] := '0';
    if (txt[9] = ' ') then txt[9] := '_';
    if (txt[10] = ' ') then txt[10] := '0';
    if (txt[11] = ' ') then txt[11] := '0';
    if (txt[13] = ' ') then txt[13] := '0';
    if (txt[14] = ' ') then txt[14] := '0';
  end
  // Error trap - probably unnessary - hence no error message
  else exit;
  // may not be required ...
  txt := txt.Trim;
  // strips out datetime elements ready for encoding
  sa := SplitString(txt, '/_:');
  if (High(sa) = 4) then
  begin
    // AMERICAN "mm/dd/yy"
    if (MonthPreceeds) then
    begin
      month := sa[0];
      day := sa[1];
    end
    // WORLD "dd/mm/yy"
    else
    begin
      day := sa[0];
      month := sa[1];
    end;
    year := sa[2];
    Hour := sa[3];
    Min := sa[4];
  end
  // Another error trap - most probably unnessary
  else exit;

  // encoding two digit years may be illegal
  if (StrToIntDef(year, 0) = 0) then
    // fixes users input of '00'
      year := IntToStr(YearOf(Today()))
  else year := '20' + year;

  try
    begin
      dt := EncodeDateTime(StrToIntDef(year, 0), StrToIntDef(month, 0),
        StrToIntDef(day, 0), StrToIntDef(Hour, 0), StrToIntDef(Min, 0), 0, 0);
      Sender.AsDateTime := dt;
    end
  except
    on E: Exception do
        MessageDlg('Illegal session date.', mtError, [mbOK], 0, mbOK);
  end;

end;



*)


(*

procedure T_Heat.qryHeatAfterDelete(DataSet: TDataSet);
begin
  if Owner is TForm then // Heat_Renumber();
      PostMessage(TForm(Owner).Handle, SCM_RENUMBERHEATS, 0, 0);
end;

procedure T_Heat.qryHeatAfterInsert(DataSet: TDataSet);
begin
  fIsNewRecord := true;
end;

procedure T_Heat.qryHeatAfterPost(DataSet: TDataSet);
var
aHeatID: integer;
begin
  if fIsNewRecord then
    begin
      fIsNewRecord := false;
      aHeatID := DataSet.FieldByName('HeatID').AsInteger;
      PadLanes(aHeatID);
			CORE.qryLane.Refresh;
      CORE.qryTeam.Refresh;
    end;

//  if Owner is TForm then // Heat_Renumber();
//      PostMessage(TForm(Owner).Handle, SCM_RENUMBERHEATS, 0, 0);

  // lblMsgTab3.Caption 'Heat Raced' 'Heat Closed'
  //
//  if Owner is TForm then
//      PostMessage(TForm(Owner).Handle, SCM_TABSHEETDISPLAYSTATE, 3, 0);
end;

procedure T_Heat.qryHeatAfterScroll(DataSet: TDataSet);
begin
  // REQUIRED 30/7/2023
  // This is needed to update the entrant grid's 'enabled' state.
  PostMessage(TForm(Owner).Handle, SCM_HEATSCROLL, 0, 0);
end;

procedure T_Heat.qryHeatNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('HeatStatusID').AsInteger := 1; // Open
  DataSet.FieldByName('HeatNum').AsInteger := DataSet.RecordCount + 1;
  // By default HeatType = 'Heat' (not quarter, semi or final')
  DataSet.FieldByName('HeatTypeID').AsInteger := 1;
end;


*)





end.
