unit rptMarshallReportC;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dmSCM, frxClass, frxDBSet;

type
  TMarshallReportC = class(TDataModule)
    qryMain: TFDQuery;
    frxDBMain: TfrxDBDataset;
    qryTEAM: TFDQuery;
    qryINDV: TFDQuery;
    dsMain: TDataSource;
    frxDBTEAM: TfrxDBDataset;
    frxDBINDV: TfrxDBDataset;
    frxReport1: TfrxReport;
    qryClubInfoRpt: TFDQuery;
    frxClubInfo: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MarshallReportC: TMarshallReportC;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
