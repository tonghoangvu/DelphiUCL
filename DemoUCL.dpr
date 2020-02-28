program DemoUCL;

uses
  Vcl.Forms,
  Form.Main in 'Form\Form.Main.pas' {formDemo};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformDemo, formDemo);
  Application.Run;
end.
