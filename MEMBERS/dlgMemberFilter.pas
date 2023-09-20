unit dlgMemberFilter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection,
  Vcl.StdCtrls, Vcl.ButtonGroup, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, SCMUtility, SCMDefines;

type

  TFilterState = record
    HideArchived:Boolean;
    HideInactive: boolean;
    HideNonSwimmer: boolean;
  end;

  TMemberFilter = class(TForm)
    btngrpFilter: TButtonGroup;
    btnClear: TButton;
    btnClose: TButton;
    filterImageCollection: TImageCollection;
    filterImageList32x32: TVirtualImageList;
    filterActionManager: TActionManager;
    actnHideArchived: TAction;
    actnHideInActive: TAction;
    actnHideNonSwimmer: TAction;
    actnClose: TAction;
    actnClear: TAction;
    procedure actnClearExecute(Sender: TObject);
    procedure actnClearUpdate(Sender: TObject);
    procedure actnCloseExecute(Sender: TObject);
    procedure actnHideArchivedExecute(Sender: TObject);
    procedure actnHideArchivedUpdate(Sender: TObject);
    procedure actnHideInActiveExecute(Sender: TObject);
    procedure actnHideInActiveUpdate(Sender: TObject);
    procedure actnHideNonSwimmerExecute(Sender: TObject);
    procedure actnHideNonSwimmerUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    fHideArchived: boolean;
    fHideInActive: boolean;
    fHideNonSwimmer: boolean;
    procedure ReadPreferences();
    procedure WritePreferences();
  public
    { Public declarations }
    property HideArchived: boolean read FHideArchived write FHideArchived;
    property HideInActive: boolean read fHideInActive write fHideInActive;
    property HideNonSwimmer: boolean read fHideNonSwimmer write fHideNonSwimmer;
  end;

const
  INIFILE_SECTION = 'SCM_Member';

var
  MemberFilter: TMemberFilter;

implementation

{$R *.dfm}

Uses IniFiles;

procedure TMemberFilter.actnClearExecute(Sender: TObject);
var
  i: TCollectionItem;
begin
  fHideArchived := false;
  fHideInActive := false;
  fHideNonSwimmer := false;
  for i in btngrpFilter.items do
  begin
    TgrpButtonItem(i).ImageName := 'UnChecked';
  end;
end;

procedure TMemberFilter.actnClearUpdate(Sender: TObject);
begin
  if fHideArchived or fHideInActive or fHideNonSwimmer then
  begin
    TAction(Sender).ImageName := 'filter_alt_off';
    TAction(Sender).Enabled := true;
  end
  else
  begin
    TAction(Sender).ImageName := 'filter_alt';
    TAction(Sender).Enabled := false;
  end;
end;

procedure TMemberFilter.actnCloseExecute(Sender: TObject);
begin
  WritePreferences;
  ModalResult := mrOK;
end;

procedure TMemberFilter.actnHideArchivedExecute(Sender: TObject);
begin
//  TAction(Sender).Checked := not TAction(Sender).Checked;
  fHideArchived := TAction(Sender).Checked;
  UpdateAction(TAction(Sender));
  PostMessage(TForm(Owner).Handle, SCM_UPDATE, 0, 0);
end;

procedure TMemberFilter.actnHideArchivedUpdate(Sender: TObject);
begin
  if fHideArchived then  actnHideArchived.ImageName := 'Checked' else
  actnHideArchived.ImageName := 'UnChecked';
end;

procedure TMemberFilter.actnHideInActiveExecute(Sender: TObject);
begin
//  TAction(Sender).Checked := not TAction(Sender).Checked;
  fHideInActive := TAction(Sender).Checked;
  UpdateAction(TAction(Sender));
  PostMessage(TForm(Owner).Handle, SCM_UPDATE, 0, 0);
end;

procedure TMemberFilter.actnHideInActiveUpdate(Sender: TObject);
begin
  if fHideInActive then  actnHideInActive.ImageName := 'Checked' else
  actnHideInActive.ImageName := 'UnChecked';
end;

procedure TMemberFilter.actnHideNonSwimmerExecute(Sender: TObject);
begin
//  TAction(Sender).Checked := not TAction(Sender).Checked;
  fHideNonswimmer := TAction(Sender).Checked;
  UpdateAction(TAction(Sender));
  PostMessage(TForm(Owner).Handle, SCM_UPDATE, 0, 0);
end;

procedure TMemberFilter.actnHideNonSwimmerUpdate(Sender: TObject);
begin
  if fHideNonSwimmer then  actnHideNonSwimmer.ImageName := 'Checked' else
  actnHideNonSwimmer.ImageName := 'UnChecked';
end;

procedure TMemberFilter.FormDestroy(Sender: TObject);
begin
  WritePreferences;
end;

procedure TMemberFilter.FormCreate(Sender: TObject);
begin
  fHideArchived := false;
  fHideInActive := false;
  fHideNonSwimmer := false;
end;

procedure TMemberFilter.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then actnClose.Execute;
end;

procedure TMemberFilter.FormShow(Sender: TObject);
begin
  ReadPreferences;
  // action and group buttons icons sync.
  if fHideArchived then
  begin
    actnHideArchived.ImageName := 'Checked';
    actnHideArchived.Checked := true;
  end
  else
  begin
    actnHideArchived.ImageName := 'UnChecked';
    actnHideArchived.Checked := false;
  end;

  if fHideInActive then
  begin
    actnHideInActive.ImageName := 'Checked';
    actnHideInActive.Checked := true;
  end
  else
  begin
    actnHideInActive.ImageName := 'UnChecked';
    actnHideInActive.Checked := false;
  end;

  if fHideNonSwimmer then
  begin
    actnHideNonSwimmer.ImageName := 'Checked';
    actnHideNonSwimmer.Checked := true;
  end
  else
  begin
    actnHideNonSwimmer.ImageName := 'UnChecked';
    actnHideNonSwimmer.Checked := false;
  end;

  UpdateAction(actnClear);

end;

{ TMemberFilter }

procedure TMemberFilter.ReadPreferences;
var
  iFile: TIniFile;
  iniFileName: string;
begin
  iniFileName := SCMUtility.GetSCMPreferenceFileName;
  if not FileExists(iniFileName) then exit;
  iFile := TIniFile.Create(iniFileName);
  fHideArchived := iFile.ReadBool(INIFILE_SECTION, 'HideArchived', true);
  fHideInActive := iFile.ReadBool(INIFILE_SECTION, 'HideInActive', false);
  fHideNonSwimmer := iFile.ReadBool(INIFILE_SECTION, 'HideNonSwimmer', false);
  iFile.Free;
end;

procedure TMemberFilter.WritePreferences;
var
  iFile: TIniFile;
  iniFileName: string;
begin
  iniFileName := SCMUtility.GetSCMPreferenceFileName;
  if not FileExists(iniFileName) then exit;
  iFile := TIniFile.Create(iniFileName);
  iFile.WriteBool(INIFILE_SECTION, 'HideArchived', fHideArchived);
  iFile.WriteBool(INIFILE_SECTION, 'HideInActive', fHideInActive);
  iFile.WriteBool(INIFILE_SECTION, 'HideNonSwimmer', fHideNonSwimmer);
  iFile.Free;
end;

end.
