unit RegisterPackage_DelphiUCL;

interface

uses
  Classes;

procedure Register;

implementation

uses
  UCL.Form
  , UCL.Panel
  ;

procedure Register;
begin
  RegisterComponents('Delphi UCL', [
    TUPanel
  ]);
end;

end.
