unit dmIMG;

interface

uses
  System.SysUtils, System.Classes, Vcl.BaseImageCollection,
	SVGIconImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  SVGIconVirtualImageList, Vcl.ImageCollection;

type
  TIMG = class(TDataModule)
    SVGEventStatus: TSVGIconVirtualImageList;
    SVGCollection: TSVGIconImageCollection;
    PNGCollection: TImageCollection;
    imgMenu: TVirtualImageList;
    imgList3: TVirtualImageList;
    imgNominate: TVirtualImageList;
    imgForm: TVirtualImageList;
    SVGHeatStatus: TSVGIconVirtualImageList;
    SVGHeatStroke: TSVGIconVirtualImageList;
    SVGHeatCntrl: TSVGIconVirtualImageList;
    SVGSessionCntrl: TSVGIconVirtualImageList;
    SVGEventCntrl: TSVGIconVirtualImageList;
    SVGMemberCntrl: TSVGIconVirtualImageList;
    SVGNominateGrid: TSVGIconVirtualImageList;
    SVGSessPopupMenu: TSVGIconVirtualImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IMG: TIMG;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
