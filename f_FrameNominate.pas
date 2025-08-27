unit f_FrameNominate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid,
  dmIMG, dmSCM, dmCORE, uSwimClub, uSession, uEvent, uHeat, ulane,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls

  ;

type
  TFrameNominate = class(TFrame)
    pnlMessage: TPanel;
    pnlDetail: TPanel;
    gNominate: TDBAdvGrid;
    dsNominate: TDataSource;
    qryNominate: TFDQuery;
    dbtxtNominateFullName: TDBText;
  private
    function AssertCORE(): boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

function TFrameNominate.AssertCORE: boolean;
begin
  result := false;
  if Assigned(CORE) and CORE.IsActive then
    result := true;
end;



(*

procedure TMain.Refresh_Nominate(DoBookmark: boolean = true);
var
  bm: TBookmark;
begin
  if not AssertConnection then exit;
  bm := nil;
  // Update the CORE.dsQmember's table
  // (may have changed if the user has been editing the member's table
  // in the member's dialogue)
  with CORE.dsNominee.DataSet do
  begin
    DisableControls;
    if Active and not IsEmpty then bm := GetBookmark;
    Close;
    Open;
    if Active then
    begin
      try
        // NOTE: Posts nominate-scroll event - forces a nominate_controllist update.
        if Assigned(bm) then GotoBookmark(bm);
      finally;
      end;
    end;
		Nominate_ControlList.ItemCount := SCM.qryNominateEvent.RecordCount;
    EnableControls;
  end;
end;
*)

(*
procedure TMain.clistCheckBoxClick(Sender: TObject);
var
  MemberID, EventID, EventNum: integer;
  DoNominate: boolean;
  nom: TSCMNom;
begin
  if not AssertConnection then exit;

  MemberID := CORE.dsNominee.DataSet.FieldByName('MemberID').AsInteger;
  if (MemberID = 0) then exit;

  // PERFORM THE TOGGLE
  DoNominate := not DoNominate;
  // Class to nominate/unnominate safely
  nom := TSCMNom.CreateWithConnection(self, SCM.scmConnection);
  if (DoNominate) then nom.NominateMember(MemberID, EventID)
  else
    // Returns true if member was unNominated.
    // May have required that a Lane was emptied of member.
    // TSCMnom will post message SCM_LANEWASCLEANED
      nom.UnNominateMember(MemberID, EventID);
  nom.Free;
  // CLOSE, SET new PARMS and OPEN the database used by the controllist.
  // This is needed for images in event Nominate_ControlListBeforeDrawItem
  SCM.Nominate_UpdateControlList(uSession.PK, MemberID);
  // locate to the last selected ControlList record.
  // SCM.Nominate_LocateEventNum(gridEvent.DataSet, EventNum);
  // paint the member tomatoe red in the nominate_grid
  Nominate_Grid.Invalidate;

  // Requery CORE.qryEvent to update entrant count.
//  PostMessage(Handle, SCM_UPDATEENTRANTCOUNT, 0, 0);
  // Set flag for statusbar update.
//  PostMessage(Handle, SCM_UPDATESTATUSBAR, 0, 0);


end;


*)

end.
