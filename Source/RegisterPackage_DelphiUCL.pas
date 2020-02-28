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
  ;

procedure Register;
begin
  RegisterComponents('Delphi UCL', [
    TUPanel,
    TUCaptionBar,
    TUProgressBar
  ]);
end;

end.
