unit UCL.Slider;

interface

uses
  Classes, Windows, Messages, Controls, Graphics,
  UCL.Classes, UCL.ThemeManager, UCL.Colors, UCL.Utils;

type
  TUSlider = class(TUCustomControl, IUControl)
    private

    protected

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      //  Interface


    published

  end;

implementation

end.
