unit Form.Main;

interface

uses
  //  VCL
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus,

  //  UCL
  UCL.Classes, UCL.Graphics, UCL.Utils, UCL.ThemeManager, UCL.IntAnimation, UCL.DragReorder,
  UCL.Form, UCL.CaptionBar, UCL.Panel, UCL.ProgressBar, UCL.Button, UCL.Slider, UCL.Text,
  UCL.Hyperlink, UCL.ListButton, UCL.QuickButton, UCL.ScrollBox, UCL.Edit, UCL.PopupMenu,
  UCL.CheckBox, UCL.RadioButton, UCL.HoverPanel;

type
  TformDemo = class(TUForm)
    panelTest: TUPanel;
    comboChooseTheme: TComboBox;
    buttonReload: TButton;
    captionbarMain: TUCaptionBar;
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
    buttonVListRefreshEffect: TUListButton;
    checkbox2States: TUCheckBox;
    checkbox3States: TUCheckBox;
    radioA: TURadioButton;
    radioB: TURadioButton;
    buttonRandomProgress: TUButton;
    popupEdit: TUPopupMenu;
    popupItemCut: TMenuItem;
    popupitemCopy: TMenuItem;
    popupitemPaste: TMenuItem;
    hoverpanelItemAction: TUHoverPanel;
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
    procedure buttonVListRefreshEffectClick(Sender: TObject);
    procedure popupEditItemClick(Sender: TObject; Index: Integer);
    procedure Item_Click(Sender: TObject);
    procedure hoverpanelItemActionIconClick(Sender: TObject; Index: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formDemo: TformDemo;

implementation

uses
  UCL.FontIcons;

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
  Item.Caption := 'List button ' + (boxList.ControlCount - 1).ToString;
  Item.FontIcon := UF_SEARCH;
  Item.Align := alTop;
  Item.ListStyle := lsBottomDetail;
  Item.Height := 55;
  Item.SelectMode := smSelect;
  Item.OnClick := Item_Click;
  Item.Parent := boxList;
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
    Value := smSelect;

  for i := 0 to boxList.ControlCount - 1 do
    if boxList.Controls[i] is TUListButton then
      (boxList.Controls[i] as TUListButton).SelectMode := Value;
end;

procedure TformDemo.buttonVListRefreshEffectClick(Sender: TObject);
var
  Ani: TIntAni;
  Control: TWinControl;
  Space: Integer;
begin
  Control := boxList;
  Space := 25;

  Ani := TIntAni.Create(0, Space,
    procedure (V: Integer)
    begin
      SetOpacity(Control.Handle, Round(255 * V / Space));
      Control.Padding.Top := Space - V;
    end,
    procedure
    begin
      StopOpacity(Handle, false);
    end);
  Ani.AniSet.QuickAssign(akOut, afkQuartic, 0, 120, 12);
  Ani.Start;
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

procedure TformDemo.hoverpanelItemActionIconClick(Sender: TObject;
  Index: Integer);
begin
  case Index of
    0:
      ShowMessage('Edit button clicked');
    1:
      ShowMessage('Remove button clicked');
  end;
end;

procedure TformDemo.Item_Click(Sender: TObject);
begin
  if Sender is TWinControl then
    hoverpanelItemAction.ClipTo(Sender as TWinControl);
end;

procedure TformDemo.popupEditItemClick(Sender: TObject; Index: Integer);
var
  Edit: TCustomEdit;
begin
  Self.SetFocus;  //  Close popup
  if popupEdit.PopupComponent is TCustomEdit then
    begin
      Edit := popupEdit.PopupComponent as TCustomEdit;
      case Index of
        0:  //  Cut
          Edit.CutToClipboard;
        1:  //  Copy
          Edit.CopyToClipboard;
        2:  //  Paste
          Edit.PasteFromClipboard;
      end;
    end;
end;

procedure TformDemo.qbuttonFullScreenClick(Sender: TObject);
begin
  FullScreen := not FullScreen;
  if FullScreen then
    qbuttonFullScreen.Caption := UF_EXIT_FULL_SCREEN
  else
    qbuttonFullScreen.Caption := UF_FULL_SCREEN;
end;

procedure TformDemo.sliderVertChange(Sender: TObject);
begin
  progressVert.Value := sliderVert.Value;
end;

end.
