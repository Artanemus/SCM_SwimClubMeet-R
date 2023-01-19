unit dlgDOBPicker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCalendars, System.DateUtils;

type
  TDOBPicker = class(TForm)
    CalendarView1: TCalendarView;
    procedure CalendarView1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DOBPicker: TDOBPicker;

implementation

{$R *.dfm}

procedure TDOBPicker.CalendarView1DblClick(Sender: TObject);
var
d1, d2: TDateTime;
begin
  // Sometimes a double click can produce a null result?
  // To produce a reliable result - assignment needed
  // TControl may be threaded and CalendarView1.Date isn't read correctly
  // when used inline.
  d1 := Date();
  d2 := CalendarView1.Date;
  if (WithinPastYears(d1, d2, 99))  then
    ModalResult := mrOk;
end;

end.
