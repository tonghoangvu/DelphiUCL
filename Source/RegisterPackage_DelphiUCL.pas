unit RegisterPackage_DelphiUCL;

interface

uses
  Classes;

procedure Register;

implementation

uses
  UCL.Form
  , UCL.Panel
  , UCL.CaptionBar
  , UCL.ProgressBar
  , UCL.Button
  , UCL.Slider
  , UCL.Text
  ;

procedure Register;
begin
  RegisterComponents('Delphi UCL', [
    TUPanel,
    TUCaptionBar,
    TUProgressBar,
    TUButton,
    TUSlider,
    TUText
  ]);
end;

end.
