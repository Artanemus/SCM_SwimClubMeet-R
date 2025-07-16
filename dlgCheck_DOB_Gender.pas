unit dlgCheck_DOB_Gender;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, dmSCM, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TCheck_DOB_Gender = class(TForm)
    pnlFooter: TPanel;
    pnlHeader: TPanel;
    pnlBody: TPanel;
    dbgDOBGender: TDBGrid;
    btnOK: TButton;
		qryErronous_DOB_GENDER: TFDQuery;
    dsErronous_DOB_GENDER: TDataSource;
    qryErronous_DOB_GENDEREventID: TIntegerField;
    qryErronous_DOB_GENDERMemberID: TIntegerField;
    qryErronous_DOB_GENDERFName: TWideStringField;
    qryErronous_DOB_GENDERGenderID: TIntegerField;
    qryErronous_DOB_GENDERDate: TWideStringField;
    qryErronous_DOB_GENDERCaption: TWideStringField;
    qryErronous_DOB_GENDERDOB: TSQLTimeStampField;
    lblHeader: TLabel;
    lblHeader2: TLabel;
		procedure btnOKClick(Sender: TObject);
		procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
		{ Public declarations }
		function CheckExec(aConnection: TFDConnection; aEventID: integer): boolean;
	end;

var
  Check_DOB_Gender: TCheck_DOB_Gender;

implementation

{$R *.dfm}

procedure TCheck_DOB_Gender.btnOKClick(Sender: TObject);
begin
ModalResult := mrCancel;
end;

function TCheck_DOB_Gender.CheckExec(aConnection: TFDConnection; aEventID:
  integer): boolean;
begin
  result := false;
  if Assigned(aConnection) then
  begin
    qryErronous_DOB_GENDER.Connection := aConnection;
    qryErronous_DOB_GENDER.ParamByName('EVENTID').AsInteger := aEventID;
		qryErronous_DOB_GENDER.Prepare;
		try
			begin
				qryErronous_DOB_GENDER.Open;
				if qryErronous_DOB_GENDER.Active then
					if qryErronous_DOB_GENDER.RecordCount > 0 then
						result := true;
			end;
    except on E: Exception do
      begin
				qryErronous_DOB_GENDER.Close;
			end;
		end;
  end;
end;

procedure TCheck_DOB_Gender.FormKeyDown(Sender: TObject; var Key: Word; Shift:
		TShiftState);
begin
if Key = VK_ESCAPE then
  ModalResult := mrCancel;
end;

end.
