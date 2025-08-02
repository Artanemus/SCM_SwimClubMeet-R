unit dmCore;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dmSCM, Vcl.BaseImageCollection,
  SVGIconImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  SVGIconVirtualImageList;

type
  TCore = class(TDataModule)
    dsSwimClub: TDataSource;
    dsSession: TDataSource;
    dsEvent: TDataSource;
    dsHeat: TDataSource;
    qrySession: TFDQuery;
    qrySessionSessionID: TFDAutoIncField;
    qrySessionSwimClubID: TIntegerField;
    qrySessionSessionStatusID: TIntegerField;
    qrySessionSessionStart: TSQLTimeStampField;
    qrySessionStatus: TWideStringField;
    qrySessionCaption: TWideStringField;
    qrySessionClosedDT: TSQLTimeStampField;
    qryEvent: TFDQuery;
    qryHeat: TFDQuery;
    qryHeatHeatID: TFDAutoIncField;
    qryHeatEventID: TIntegerField;
    qryHeatHeatTypeID: TIntegerField;
    qryHeatHeatStatusID: TIntegerField;
    qryHeatHeatNum: TIntegerField;
    qryHeatcStatus: TWideStringField;
    qryHeatCloseDT: TSQLTimeStampField;
    qrySwimClub: TFDQuery;
    qrySwimClubSwimClubID: TFDAutoIncField;
    qrySwimClubNickName: TWideStringField;
    qrySwimClubCaption: TWideStringField;
    qrySwimClubEmail: TWideStringField;
    qrySwimClubContactNum: TWideStringField;
    qrySwimClubWebSite: TWideStringField;
    qrySwimClubHeatAlgorithm: TIntegerField;
    qrySwimClubEnableTeamEvents: TBooleanField;
    qrySwimClubEnableSwimOThon: TBooleanField;
    qrySwimClubEnableExtHeatTypes: TBooleanField;
    qrySwimClubEnableMembershipStr: TBooleanField;
    qrySwimClubEnableSimpleDisqualification: TBooleanField;
    qrySwimClubNumOfLanes: TIntegerField;
    qrySwimClubLenOfPool: TIntegerField;
    qrySwimClubStartOfSwimSeason: TSQLTimeStampField;
    qrySwimClubCreatedOn: TSQLTimeStampField;
    qrySwimClubLogoDir: TMemoField;
    qrySwimClubLogoImg: TBlobField;
    qrySwimClubLogoType: TWideStringField;
    qrySwimClubPoolTypeID: TIntegerField;
    qrySwimClubSwimClubTypeID: TIntegerField;
    qryLane: TFDQuery;
    dsLane: TDataSource;
    qryNominee: TFDQuery;
    dsNominee: TDataSource;
    qryTeam: TFDQuery;
    dsTeam: TDataSource;
    dsSplitTime: TDataSource;
    dsWatchTime: TDataSource;
    qrySplitTime: TFDQuery;
    qryWatchTime: TFDQuery;
    qryTeamLink: TFDQuery;
    dsTeamLink: TDataSource;
    qrySwimClubNumOfSwimmersInTEAMS: TIntegerField;
    tblStroke: TFDTable;
    tblDistance: TFDTable;
    luStroke: TDataSource;
    luDistance: TDataSource;
    qryEventEventID: TFDAutoIncField;
    qryEventEventNum: TIntegerField;
    qryEventCaption: TWideStringField;
    qryEventScheduleDT: TTimeField;
    qryEventRallyOpenDT: TSQLTimeStampField;
    qryEventRallyCloseDT: TSQLTimeStampField;
    qryEventOpenDT: TSQLTimeStampField;
    qryEventCloseDT: TSQLTimeStampField;
    qryEventSessionID: TIntegerField;
    qryEventStrokeID: TIntegerField;
    qryEventDistanceID: TIntegerField;
    qryEventEventStatusID: TIntegerField;
    qryEventRoundID: TIntegerField;
    qryEventGenderID: TIntegerField;
    qryEventParalympicTypeID: TIntegerField;
    qryEventNomineeCount: TIntegerField;
    qryEventEntrantCount: TIntegerField;
    qryEventEventTypeID: TIntegerField;
    LookUpDistance: TStringField;
    LookUpStroke: TStringField;
    qryEventShortCaption: TWideStringField;
    SVGEvStatusList: TSVGIconVirtualImageList;
    SVGCoreCollection: TSVGIconImageCollection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Core: TCore;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
