unit dlgCloneSession;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, Vcl.StdCtrls, Vcl.ExtCtrls, dmSCM,
  Vcl.VirtualImage, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TCloneSession = class(TForm)
    qrySrcEvent: TFDQuery;
    tblSession: TFDTable;
    tblEvent: TFDTable;
    lblDescription: TLabel;
    pnlFooter: TPanel;
    btnClone: TButton;
    btnCancel: TButton;
    vimgClone: TVirtualImage;
    imgcolClone: TImageCollection;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCloneClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function CloneExecute: boolean;
  public
    { Public declarations }
  end;

//var
//  CloneSession: TCloneSession;

implementation

{$R *.dfm}

procedure TCloneSession.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TCloneSession.btnCloneClick(Sender: TObject);
begin
  if CloneExecute then
    ModalResult := mrOk
  else
  begin
    ModalResult := mrCancel;
  end;
end;

function TCloneSession.CloneExecute: boolean;
var
  i: integer;
begin
  result := false;
  i := 1;
  // Session must no be empty
  if not Assigned(SCM) then
    exit;
  if SCM.dsSession.DataSet.IsEmpty then
    exit;

  qrySrcEvent.Connection := SCM.scmConnection;
  qrySrcEvent.ParamByName('SESSIONID').AsInteger := SCM.Session_ID;
  qrySrcEvent.Prepare;
  qrySrcEvent.Open;
  if not qrySrcEvent.Active then
    exit;
  if qrySrcEvent.IsEmpty then
    exit;

  // create the clone session.
  // ------------------------------
  try
    tblSession.Insert;
    tblSession.FieldByName('SessionStart').AsDateTime := Now();
    tblSession.FieldByName('SwimClubID').AsInteger :=
      SCM.dsSession.DataSet.FieldByName('SwimClubID').AsInteger;
    tblSession.FieldByName('SessionStatusID').AsInteger := 1;
    tblSession.FieldByName('Caption').AsString := 'CLONE OF: ' +
      SCM.dsSession.DataSet.FieldByName('Caption').AsString;
    tblSession.Post;
  except
    on E: Exception do
      exit;
  end;
  // create cloned events
  // ------------------------------
  qrySrcEvent.First;
  while not qrySrcEvent.Eof do
  begin
    tblEvent.Insert();
    // Assert event numbering
    tblEvent.FieldByName('EventNum').AsInteger := i;
    tblEvent.FieldByName('Caption').AsString :=
      qrySrcEvent.FieldByName('Caption').AsString;;
    // Stroke
    tblEvent.FieldByName('StrokeID').AsInteger :=
      qrySrcEvent.FieldByName('StrokeID').AsInteger;
    // Distance
    tblEvent.FieldByName('DistanceID').AsInteger :=
      qrySrcEvent.FieldByName('DistanceID').AsInteger;
    // Assign new inserted session ...
    tblEvent.FieldByName('SessionID').AsInteger :=
      tblSession.FieldByName('SessionID').AsInteger;
    // Status = open
    tblEvent.FieldByName('EventStatusID').AsInteger := 1;

    // Schedule TTime for the event...
    tblEvent.FieldByName('ScheduleDT').AsDateTime :=
      qrySrcEvent.FieldByName('ScheduleDT').AsDateTime;

    // RallyOpenDT .. RallyCloseDT .. OpenDT .. CloseDT

    tblEvent.Post();
    i := i + 1;
    qrySrcEvent.Next;
  end;
  qrySrcEvent.Close();
  result := true;
end;

procedure TCloneSession.FormCreate(Sender: TObject);
begin
  if not Assigned(SCM) then
    raise Exception.Create('SCM data module not assigned.');
  tblSession.Connection := SCM.scmConnection;
  tblEvent.Connection := SCM.scmConnection;
  tblEvent.Open;
  tblSession.Open;
  if not(tblEvent.Active and tblSession.Active) then
    raise Exception.Create('SCM error activating tables.');
end;

procedure TCloneSession.FormDestroy(Sender: TObject);
begin
  tblSession.Close();
  tblEvent.Close();
end;

procedure TCloneSession.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Key := 0;
    ModalResult := mrCancel;
  end;
end;

end.
