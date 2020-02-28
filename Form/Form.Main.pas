unit Form.Main;

interface

uses
  UCL.Form, UCL.Classes, UCL.ThemeManager,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, UCL.Panel, UCL.Utils,
  UCL.Graphics, UCL.CaptionBar, UCL.ProgressBar;

type
  TformDemo = class(TUForm)
    panelTest: TUPanel;
    comboChooseTheme: TComboBox;
    buttonReload: TButton;
    captionbarMain: TUCaptionBar;
    buttonRandomProgress: TButton;
    progressHorz: TUProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure comboChooseThemeSelect(Sender: TObject);
    procedure buttonReloadClick(Sender: TObject);
    procedure buttonRandomProgressClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formDemo: TformDemo;

implementation

{$R *.dfm}

procedure TformDemo.buttonReloadClick(Sender: TObject);
begin
  ThemeManager.UpdateTheme;
end;

procedure TformDemo.buttonRandomProgressClick(Sender: TObject);
begin
  Randomize;
  progressHorz.GoToValue(Random(100));
end;

procedure TformDemo.comboChooseThemeSelect(Sender: TObject);
begin
  ThemeManager.ThemeType := TUThemeType(comboChooseTheme.ItemIndex);
end;

procedure TformDemo.FormCreate(Sender: TObject);
begin
  panelTest.Hint :=
    'This is line 1' + sLineBreak +
    'This is line 2' + sLineBreak +
    'This is a multi-line tooltip';
end;

end.
