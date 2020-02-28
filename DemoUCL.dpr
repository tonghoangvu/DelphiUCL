program DemoUCL;

uses
  Vcl.Forms,
  Form.Main in 'Form\Form.Main.pas' {Form85};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm85, Form85);
  Application.Run;
end.
