unit Form.Main;

interface

uses
  UCL.Form, UCL.Classes, UCL.ThemeManager,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, UCL.Panel, UCL.Utils,
  UCL.Graphics, UCL.CaptionBar, UCL.ProgressBar, UCL.Button, UCL.Slider,
  UCL.Text, UCL.Hyperlink, UCL.ListButton, UCL.QuickButton, UCL.DragReorder,
  UCL.ScrollBox, UCL.Edit;

type
  TformDemo = class(TUForm)
    panelTest: TUPanel;
    comboChooseTheme: TComboBox;
    buttonReload: TButton;
    captionbarMain: TUCaptionBar;
    buttonRandomProgress: TButton;
    progressHorz: TUProgressBar;
    buttonFocus: TUButton;
    buttonToggle: TUButton;
    buttonNoFocus: TUButton;
    buttonTransparent: TUButton;
    buttonHighlight: TUButton;
    buttonDisabled: TUButton;
    sliderHorz: TUSlider;
    textCustom: TUText;
    textHeading: TUText;
    textTitle: TUText;
    textEntry: TUText;
    textNormal: TUText;
    textDescription: TUText;
    textDisabled: TUText;
    linkEmpty: TUHyperlink;
    linkGoogle: TUHyperlink;
    linkDisabled: TUHyperlink;
    linkCustomColor: TUHyperlink;
    sliderVert: TUSlider;
    progressVert: TUProgressBar;
    buttonVListMultiSelection: TUListButton;
    comboChooseScaleRatio: TComboBox;
    qbuttonQuit: TUQuickButton;
    qbuttonFullScreen: TUQuickButton;
    qbuttonMin: TUQuickButton;
    qbuttonMax: TUQuickButton;
    qbuttonHighlight: TUQuickButton;
    boxList: TUScrollBox;
    buttonVListDragReorder: TUListButton;
    buttonVListAddItem: TUListButton;
    editSomething: TUEdit;
    procedure FormCreate(Sender: TObject);
    procedure comboChooseThemeSelect(Sender: TObject);
    procedure buttonReloadClick(Sender: TObject);
    procedure buttonRandomProgressClick(Sender: TObject);
    procedure comboChooseScaleRatioSelect(Sender: TObject);
    procedure sliderVertChange(Sender: TObject);
    procedure buttonVListMultiSelectionClick(Sender: TObject);
    procedure buttonVListDragReorderClick(Sender: TObject);
    procedure qbuttonFullScreenClick(Sender: TObject);
    procedure buttonVListAddItemClick(Sender: TObject);
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

procedure TformDemo.buttonVListAddItemClick(Sender: TObject);
var
  Item: TUListButton;
begin
  Item := TUListButton.Create(boxList);
  Item.Parent := boxList;
  Item.Caption := 'List button ' + boxList.ControlCount.ToString;
  Item.Align := alTop;
  Item.SelectMode := smFocus;
end;

procedure TformDemo.buttonVListDragReorderClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to boxList.ControlCount - 1 do
    if boxList.Controls[i] is TUListButton then
      begin
        if buttonVListDragReorder.Selected then
          AssignDragVertHandle(boxList.Controls[i] as TUListButton)
        else
          RemoveDragHandle(boxList.Controls[i] as TUListButton);
      end;
end;

procedure TformDemo.buttonVListMultiSelectionClick(Sender: TObject);
var
  Value: TUSelectMode;
  i: Integer;
begin
  if buttonVListMultiSelection.Selected then
    Value := smToggle
  else
    Value := smFocus;

  for i := 0 to boxList.ControlCount - 1 do
    if boxList.Controls[i] is TUListButton then
      (boxList.Controls[i] as TUListButton).SelectMode := Value;
end;

procedure TformDemo.buttonRandomProgressClick(Sender: TObject);
begin
  Randomize;
  progressHorz.GoToValue(Random(100));
  progressVert.GoToValue(Random(100));
end;

procedure TformDemo.comboChooseScaleRatioSelect(Sender: TObject);
begin
  case comboChooseScaleRatio.ItemIndex of
    0:
      ScaleForPPI(96);
    1:
      ScaleForPPI(120);
    2:
      ScaleForPPI(144);
    3:
      ScaleForPPI(168);
    4:
      ScaleForPPI(192);
  end;
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

procedure TformDemo.qbuttonFullScreenClick(Sender: TObject);
begin
  FullScreen := not FullScreen;
  if FullScreen then
    qbuttonFullScreen.Caption := ''
  else
    qbuttonFullScreen.Caption := '';
end;

procedure TformDemo.sliderVertChange(Sender: TObject);
begin
  progressVert.Value := sliderVert.Value;
end;

end.
