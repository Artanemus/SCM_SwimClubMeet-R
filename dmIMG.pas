unit dmIMG;

interface

uses
  System.SysUtils, System.Classes, Vcl.BaseImageCollection,
	SVGIconImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  SVGIconVirtualImageList;

type
  TIMG = class(TDataModule)
    SVGEventStatus: TSVGIconVirtualImageList;
    SVGCoreCollection: TSVGIconImageCollection;
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
