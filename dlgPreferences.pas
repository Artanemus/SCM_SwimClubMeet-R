unit dlgPreferences;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtDlgs, Vcl.WinXCtrls;

type
  TPreferences = class(TForm)
    Bevel1: TBevel;
    btn1: TSpeedButton;
    btnClearClubLogo: TButton;
    btnClose: TButton;
    btnLoadClubLogo: TButton;
    btnSaveClubLogo: TButton;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit9: TDBEdit;
    DBImage1: TDBImage;
    DBText1: TDBText;
    dsSwimClub: TDataSource;
    dtpStartOfSwimSeason: TDateTimePicker;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lblSeedDepth1: TLabel;
    lblSeedDepth2: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    prefCheckUnNomination: TCheckBox;
    prefDisplayDivisions: TCheckBox;
    prefDisplaySwimmerCAT: TCheckBox;
    prefEnableDCodes: TCheckBox;
    prefEnableSplitTimesForINDV: TCheckBox;
    prefEnableSplitTimesForTEAM: TCheckBox;
    prefEnableTeamEvents: TCheckBox;
    prefExcludeOutsideLanes: TCheckBox;
    prefGenerateEventDescription: TCheckBox;
    prefGenerateEventDescStr: TEdit;
    prefGroupBy: TRadioGroup;
    prefHeatAlgorithm: TRadioGroup;
    prefImportSeedTime: TRadioGroup;
    prefRaceTimeTopPercent: TSpinEdit;
    prefSeperateGender: TCheckBox;
    prefShowDebugInfo: TCheckBox;
    prefUseDefRaceTime: TCheckBox;
    prefUseWindowsDefTheme: TCheckBox;
    qrySwimClub: TFDQuery;
    rgpSeedMethod: TRadioGroup;
    SavePictureDialog1: TSavePictureDialog;
    spnSeedDepth: TSpinEdit;
    tab1: TTabSheet;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    tblSystem: TFDTable;
    TabSheet7: TTabSheet;
    edtMemberChartDataPoints: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    prefHideTitlePanel: TCheckBox;
    procedure btnClearClubLogoClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnLoadClubLogoClick(Sender: TObject);
    procedure btnSaveClubLogoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
  private
    FConnection: TFDConnection;
//    procedure AssignClubLogoToImage(AImage: TImage); //--
    procedure AssignDTtoStartOfSwimSeason();
    procedure AssignStartOfSwimSeasonToDT();
    procedure ReadPreferences(IniFileName: string);
    procedure WritePreferences(IniFileName: string);
  public
    constructor Create(AOwner: TComponent; AConnection: TFDConnection);
      reintroduce; overload;
    property Connection: TFDConnection read FConnection write FConnection;
//    property MemberChartDataPoints: integer read fMemberChartDataPoints write fMemberChartDataPoints;
  end;

var
  Preferences: TPreferences;

implementation

{$R *.dfm}

uses SCMUtility, IniFiles, Imaging.jpeg, Imaging.pngimage, System.UITypes;

constructor TPreferences.Create(AOwner: TComponent; AConnection: TFDConnection);
begin
  inherited Create(AOwner);
  if Assigned(AConnection) then
    FConnection := AConnection
  else
    FConnection := nil;
end;

{ TPreferences }
{
procedure TPreferences.AssignClubLogoToImage(AImage: TImage);
var
  Stream: TStream;
  aJpgImage: TJPEGImage;
  aPngImage: TPngImage;
  aBmpImage: TBitmap;
  fn, s: String;
begin
  // Clear TImage
  AImage.Picture.Assign(nil);
  if not Assigned(FConnection) then
    exit;
  if not qrySwimClub.Active then
    exit;
  if qrySwimClub.FieldByName('LogoDir').IsNull then
    exit;

  // I N I T I A L I Z E .
  Stream := nil;
  aJpgImage := nil;
  aPngImage := nil;
  aBmpImage := nil;

  fn := qrySwimClub.FieldByName('LogoDir').AsString;
  if fn.IsEmpty then
    exit;
  s := ExtractFileExt(fn);
  s := LowerCase(s);

  if ((s = '.jpg') or (s = '.jpeg')) then
  begin
    try
      begin
        aJpgImage := TJPEGImage.Create;
        Stream := qrySwimClub.CreateBlobStream
          (qrySwimClub.FieldByName('LogoImg'), bmRead);
        Stream.Seek(0, 0);
        aJpgImage.LoadFromStream(Stream);
        AImage.Picture.Assign(aJpgImage);
      end;
    finally
      begin
        aJpgImage.free;
        Stream.free;
      end;
    end;
  end
  else if (s = '.png') then
  begin
    try
      begin
        aPngImage := TPngImage.Create;
        Stream := qrySwimClub.CreateBlobStream
          (qrySwimClub.FieldByName('LogoImg'), bmRead);
        Stream.Seek(0, 0);
        aPngImage.LoadFromStream(Stream);
        AImage.Picture.Assign(aPngImage);
      end;
    finally
      begin
        aPngImage.free;
        Stream.free;
      end;
    end;
  end
  else if (s = '.bmp') then
  begin
    try
      begin
        aBmpImage := TBitmap.Create;
        Stream := qrySwimClub.CreateBlobStream
          (qrySwimClub.FieldByName('LogoImg'), bmRead);
        Stream.Seek(0, 0);
        aBmpImage.LoadFromStream(Stream);
        AImage.Picture.Bitmap.Assign(aBmpImage);
      end;
    finally
      begin
        aBmpImage.free;
        Stream.free;
      end;
    end;
  end;
end;
}
procedure TPreferences.AssignDTtoStartOfSwimSeason;
begin
  if (Assigned(FConnection) and (qrySwimClub.Active)) then
  begin
    if qrySwimClub.FieldByName('StartOfSwimSeason').AsDateTime <>
      dtpStartOfSwimSeason.Date then
    begin
      qrySwimClub.Edit;
      qrySwimClub.FieldByName('StartOfSwimSeason').AsDateTime :=
        dtpStartOfSwimSeason.Date;
      qrySwimClub.Post;
    end;
  end;
end;

procedure TPreferences.AssignStartOfSwimSeasonToDT;
var
  dt: TDateTime;
begin
  if (Assigned(FConnection) and (qrySwimClub.Active)) then
  begin
    dt := qrySwimClub.FieldByName('StartOfSwimSeason').AsDateTime;
    if (dt > 0) then
      dtpStartOfSwimSeason.Date := dt
    else
      dtpStartOfSwimSeason.Date := Date;
  end;
end;

procedure TPreferences.btnClearClubLogoClick(Sender: TObject);
begin
  if (Assigned(FConnection) and (qrySwimClub.Active)) then
  begin
    qrySwimClub.Edit;
    qrySwimClub.FieldByName('LogoDir').Clear;
    qrySwimClub.FieldByName('LogoImg').Clear;
    qrySwimClub.FieldByName('LogoType').Clear;
    qrySwimClub.Post;
  end;
end;

procedure TPreferences.btnCloseClick(Sender: TObject);
begin
  // w r i t e   o u t   d a t a b a s e   c h a n g e s .
  if (Assigned(FConnection)) and (qrySwimClub.Active) then
  begin
    AssignDTtoStartOfSwimSeason;
    qrySwimClub.CheckBrowseMode;
    qrySwimClub.Close;
  end;

  ModalResult := mrOk;
end;

procedure TPreferences.btnLoadClubLogoClick(Sender: TObject);
var
  s: string;
  FileStream: TFileStream;
  BlobStream: TStream;
begin

  // NOTE: TOpenPictureDialog.options - ofPathMustExist, ofFileMustExist.
  if (OpenPictureDialog1.Execute) then
  begin
    qrySwimClub.Edit;
    try
      // part 1 : deal with the blob  - .png, .bmp, .jpeg, .jpg
      // qrySwimClub.FieldByName('LogoImg').Clear;

      BlobStream := qrySwimClub.CreateBlobStream
        (qrySwimClub.FieldByName('LogoImg'), bmWrite);
      FileStream := TFileStream.Create(OpenPictureDialog1.FileName,
        fmOpenRead or fmShareDenyNone);
      BlobStream.CopyFrom(FileStream, FileStream.Size);
      FileStream.free;
      BlobStream.free;
      // part 2 : directory info and image type
      // the filename is used to identify the graphic type.
      qrySwimClub.FieldByName('LogoDir').AsString :=
        OpenPictureDialog1.FileName;
      s := ExtractFileExt(OpenPictureDialog1.FileName);
      s := LowerCase(s);
      qrySwimClub.FieldByName('LogoType').AsString := s;
      qrySwimClub.Post;
    except
      qrySwimClub.Cancel;
    end;

    // (qrySwimClub.FieldByName('LogoImg') as TBlobField)
    // .LoadFromFile(OpenPictureDialog1.FileName);

    // Display the new logo into the UI
    // AssignClubLogoToImage(LogoImage);
  end;
end;

procedure TPreferences.btnSaveClubLogoClick(Sender: TObject);
var
  FileStream: TFileStream;
  BlobStream: TStream;
begin
  // test table is connected and open
  if not(qrySwimClub.Active) then
    exit;
  if (SavePictureDialog1.Execute) then
  begin
    FileStream := TFileStream.Create(SavePictureDialog1.FileName, fmCreate);
    BlobStream := qrySwimClub.CreateBlobStream
      (qrySwimClub.FieldByName('LogoImg'), bmRead);
    FileStream.CopyFrom(BlobStream, BlobStream.Size);
    BlobStream.free;
    FileStream.free;
  end;
end;

procedure TPreferences.FormCreate(Sender: TObject);
var
  IniFileName: string;
begin
  // I N I T  L O C A L   U I   P A R A M S .
  PageControl1.TabIndex := 0;
  dtpStartOfSwimSeason.Date := Date;
  rgpSeedMethod.Enabled := true;
  spnSeedDepth.Enabled := true;
  lblSeedDepth1.Enabled := true;
  lblSeedDepth2.Enabled := true;
  rgpSeedMethod.ItemIndex := 0;
  // r e a d   p r e f e r e n c e .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then
    ReadPreferences(IniFileName);
  // ensures a data connection is viable - if the main data module is active
  if Assigned(FConnection) then
  begin
    DBImage1.DataField := 'LogoImg';
    qrySwimClub.Connection := FConnection;
    qrySwimClub.Open;
    if (qrySwimClub.Active = true) then
    begin
      AssignStartOfSwimSeasonToDT;
    end;
  end;
end;

procedure TPreferences.FormDestroy(Sender: TObject);
var
  IniFileName: string;
begin
  // w r i t e   p r e f e r e n c e s .
  IniFileName := SCMUtility.GetSCMPreferenceFileName();
  if (FileExists(IniFileName)) then
    WritePreferences(IniFileName);
end;

procedure TPreferences.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_escape then
  begin
    // special note:
    // By default all database changes are saved.
    btnCloseClick(self);
    Key := 0;
  end;
end;

procedure TPreferences.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  if (Assigned(FConnection) and (qrySwimClub.Active)) then
  begin
    if (PageControl1.TabIndex = 0) or (PageControl1.TabIndex = 1) then
      qrySwimClub.CheckBrowseMode;
  end;
  AllowChange := true;
end;

procedure TPreferences.ReadPreferences(IniFileName: string);
var
  iFile: TIniFile;
  i, iUnChecked, iChecked: integer;
begin
  iFile := TIniFile.Create(IniFileName);
{
Using Ord is generally considered best practice when converting an
enumeration to its corresponding integer value in Delphi.
}
  iUnChecked := Ord(TCheckBoxState.cbUnchecked);
  iChecked := Ord(TCheckBoxState.cbChecked);

  // 2024/08/31  Add more screen real estate.
  i := iFile.ReadInteger('Preferences', 'HideTitlePanel',  iUnChecked);
  prefHideTitlePanel.State := TCheckBoxState(i);


  i := iFile.ReadInteger('Preferences', 'ShowDebugInfo', iUnChecked);
  prefShowDebugInfo.State := TCheckBoxState(i);

  i := iFile.ReadInteger('Preferences', 'UseWindowsDefTheme', iUnChecked);
  prefUseWindowsDefTheme.State := TCheckBoxState(i);

  // TTB defaults to (1) .. the entrant's average of top 3 race-times
  prefHeatAlgorithm.ItemIndex :=
    (iFile.ReadInteger('Preferences', 'HeatAlgorithm', 1));

  // default to - get an average race-time of other swimmers
  i := iFile.ReadInteger('Preferences', 'UseDefRaceTime', iChecked);
  prefUseDefRaceTime.State := TCheckBoxState(i);
  i := iFile.ReadInteger('Preferences', 'CheckUnNomination', iUnChecked);
  prefCheckUnNomination.State := TCheckBoxState(i);

  // The bottom percent to select from ... default is 50%
  prefRaceTimeTopPercent.Value :=
    (iFile.ReadInteger('Preferences', 'RaceTimeTopPercent', 50));

  // defaullt - do nothing - ignore
  prefImportSeedTime.ItemIndex := iFile.ReadInteger('Preferences',
    'ImportSeedTime', 0);

  // auto-create heats - this option will omit gutter lanes
  i := iFile.ReadInteger('Preferences', 'ExcludeOutsideLanes', iUnChecked);
  prefExcludeOutsideLanes.State := TCheckBoxState(i);

  // auto-create heats - seperate male from female
  i := iFile.ReadInteger('Preferences', 'SeperateGender', iUnChecked);
  prefSeperateGender.State := TCheckBoxState(i);
  prefGroupBy.ItemIndex := iFile.ReadInteger('Preferences', 'GroupBy', 0);
  rgpSeedMethod.ItemIndex := iFile.ReadInteger('Preferences', 'SeedMethod', 0);

  // Generate event descriptions
  i := iFile.ReadInteger('Preferences', 'GenerateEventDescription', iUnChecked);
  prefGenerateEventDescription.State := TCheckBoxState(i);
  prefGenerateEventDescStr.Text := iFile.ReadString('Preferences',
    'GenerateEventDescStr', ' - Individual, all genders, all ages.');

  // Generate event descriptions (TEAM)
//  i := iFile.ReadInteger('Preferences', 'GenerateTEAMDescription', iUnChecked);
//  prefGenerateTEAMDescription.State := TCheckBoxState(i);
//  prefGenerateTEAMDescStr.Text := iFile.ReadString('Preferences',
//    'GenerateEventTeamDescStr', ' - RELAY.');

  rgpSeedMethod.ItemIndex := iFile.ReadInteger('Preferences', 'SeedMethod', 0);

  { /* 2020-11-01 auto-build v2 seed method */ }
  rgpSeedMethod.ItemIndex := iFile.ReadInteger('Preferences', 'SeedMethod', 0);
  { /* 2020-11-01 auto-build v2 seed depth for Circle Seed */ }
  spnSeedDepth.Value := (iFile.ReadInteger('Preferences', 'SeedDepth', 3));

  // 2023.06.26
  prefEnableTeamEvents.Checked := iFile.ReadBool('Preferences',
    'EnableTeamEvents', true);
  prefEnableDCodes.Checked := iFile.ReadBool('Preferences',
    'EnableDCodes', false);
  prefDisplaySwimmerCAT.Checked := iFile.ReadBool('Preferences',
    'DisplaySwimmerCAT', false);
  prefDisplayDivisions.Checked := iFile.ReadBool('Preferences',
    'DisplayDivisions', false);
  //2024/1/1
  prefEnableSplitTimesForINDV.Checked := iFile.ReadBool('Preferences',
    'EnableSplitTimesForINDV', false);
  prefEnableSplitTimesForTeam.Checked := iFile.ReadBool('Preferences',
    'EnableSplitTimesForTEAM', false);

  // 2024/03/19 Value used by TFDQuery qryChart to select TOP ###
  i := iFile.ReadInteger('ManageMemberData', 'MemberChartDataPoints', 26);
  edtMemberChartDataPoints.Text := IntToStr(i);

  iFile.free;
end;

procedure TPreferences.WritePreferences(IniFileName: string);
var
  iFile: TIniFile;
  i: integer;
begin
  iFile := TIniFile.Create(IniFileName);

  // 2024/08/31
  iFile.WriteInteger('Preferences', 'HideTitlePanel',
    integer(prefHideTitlePanel.State));


  iFile.WriteInteger('Preferences', 'ShowDebugInfo',
    integer(prefShowDebugInfo.State));
  iFile.WriteInteger('Preferences', 'UseWindowsDefTheme',
    integer(prefUseWindowsDefTheme.State));
  iFile.WriteInteger('Preferences', 'HeatAlgorithm',
    integer(prefHeatAlgorithm.ItemIndex));
  iFile.WriteInteger('Preferences', 'UseDefRaceTime',
    integer(prefUseDefRaceTime.State));
  iFile.WriteInteger('Preferences', 'CheckUnNomination',
    integer(prefCheckUnNomination.State));
  iFile.WriteInteger('Preferences', 'RaceTimeTopPercent',
    (prefRaceTimeTopPercent.Value));
  iFile.WriteInteger('Preferences', 'ImportSeedTime',
    (prefImportSeedTime.ItemIndex));
  iFile.WriteInteger('Preferences', 'ExcludeOutsideLanes',
    integer(prefExcludeOutsideLanes.State));
  iFile.WriteInteger('Preferences', 'SeperateGender',
    integer(prefSeperateGender.State));
  iFile.WriteInteger('Preferences', 'GroupBy', prefGroupBy.ItemIndex);

  // generate event description
  iFile.WriteInteger('Preferences', 'GenerateEventDescription',
    integer(prefGenerateEventDescription.State));
  iFile.WriteString('Preferences', 'GenerateEventDescStr',
    prefGenerateEventDescStr.Text);

  // generate event description (TEAM)
//  iFile.WriteInteger('Preferences', 'GenerateTEAMDescription',
//    integer(prefGenerateTEAMDescription.State));
//  iFile.WriteString('Preferences', 'GenerateTEAMDescStr',
//    prefGenerateTEAMDescStr.Text);

  { 2020-11-01 auto-build v2 seed method }
  iFile.WriteInteger('Preferences', 'SeedMethod', rgpSeedMethod.ItemIndex);
  { 2020-11-01 auto-build v2 seed depth for Circle Seed }
  iFile.WriteInteger('Preferences', 'SeedDepth', (spnSeedDepth.Value));

  // 2023.06.26
  iFile.WriteBool('Preferences', 'EnableTeamEvents',
    prefEnableTeamEvents.Checked);
  iFile.WriteBool('Preferences', 'EnableDCodes',
    prefEnableDCodes.Checked);
  iFile.WriteBool('Preferences', 'DisplaySwimmerCAT', prefDisplaySwimmerCAT.Checked);
  iFile.WriteBool('Preferences', 'DisplayDivision',   prefDisplayDivisions.Checked);

  //2024/1/1
  iFile.WriteBool('Preferences', 'EnableSplitTimesForINDV',
    prefEnableSplitTimesForINDV.Checked);
  iFile.WriteBool('Preferences', 'EnableSplitTimesForTEAM',
    prefEnableSplitTimesForTEAM.Checked);

  // 2024/03/19 Value used by TFDQuery qryChart to select TOP ###
  try
    i := Round(StrToFloatDef(edtMemberChartDataPoints.Text, 0));
  except
    on E: Exception do i := 26;
  end;
  if (i < 10) then i := 10;
  if (i > 1000) then i := 1000;
  iFile.WriteInteger('ManageMemberData', 'MemberChartDataPoints', i);


  iFile.free;
end;

end.
