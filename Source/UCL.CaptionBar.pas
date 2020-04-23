unit UCL.CaptionBar;

interface

uses
  Classes, Windows, Messages, Controls, ExtCtrls, Forms, Graphics, SysUtils, Types,
  UCL.Classes, UCL.ThemeManager, UCL.Utils, UCL.Colors, UCL.Form;

type
  TUCaptionBar = class(TPanel, IUControl)
    private
      var BackColor, TextColor: TColor;

      FCustomBackColor: TUThemeColorSet;

      FCollapsed: Boolean;
      FDragToMove: Boolean;
      FSystemMenuEnabled: Boolean;

      //  Internal
      procedure UpdateColors;

      //  Setters
      procedure SetCollapsed(const Value: Boolean);

      //  Child events
      procedure CustomBackColor_OnChange(Sender: TObject);

      //  Messages
      procedure WM_LButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
      procedure WM_LButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
      procedure WM_RButtonUp(var Msg: TMessage); message WM_RBUTTONUP;
      procedure WM_NCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
      procedure CM_MouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure CM_MouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

    protected
      procedure Paint; override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      //  Interface
      function IsContainer: Boolean;
      procedure UpdateTheme(const UpdateChildren: Boolean);

    published
      property CustomBackColor: TUThemeColorSet read FCustomBackColor write FCustomBackColor;

      property Collapsed: Boolean read FCollapsed write SetCollapsed default false;
      property DragToMove: Boolean read FDragToMove write FDragToMove default true;
      property SystemMenuEnabled: Boolean read FSystemMenuEnabled write FSystemMenuEnabled default true;

      //  Modify default value
      property Align default alTop;
      property Alignment default taLeftJustify;
      property BevelOuter default bvNone;
      property Height default 32;
      property ParentBackground default false;
  end;

implementation

uses
  UCL.IntAnimation,
  UCL.Graphics;

{ TUCaptionBar }

//  INTERFACE

function TUCaptionBar.IsContainer: Boolean;
begin
  Result := true;
end;

procedure TUCaptionBar.UpdateTheme(const UpdateChildren: Boolean);
var
  i: Integer;
begin
  UpdateColors;
  Repaint;

  //  Update children
  if IsContainer and UpdateChildren then
    for i := 0 to ControlCount - 1 do
      if Supports(Controls[i], IUControl) then
        (Controls[i] as IUControl).UpdateTheme(UpdateChildren);
end;

//  INTERNAL

procedure TUCaptionBar.UpdateColors;
var
  TM: TUThemeManager;
  _BackColor: TUThemeColorSet;
begin
  //  Preparing
  TM := SelectThemeManager(Self);

  //  Update back color
  _BackColor := SelectColorSet(TM, CustomBackColor, CAPTIONBAR_BACK);
  BackColor := _BackColor.GetColor(TM);

  //  Update text color (depends on back color)
  TextColor := GetTextColorFromBackground(BackColor);

  //  Update Color for container (let children using ParentColor)
  Color := BackColor;
end;

//  SETTERS

procedure TUCaptionBar.SetCollapsed(const Value: Boolean);
var 
  Ani: TIntAni;
  Delta: Integer;
begin
  if Value <> FCollapsed then
    begin
      FCollapsed := Value;

      if csDesigning in ComponentState then
        exit;

      ShowCaption := not Value;
      if Value then
        Padding.Bottom := 1
      else
        Padding.Bottom := 0;
      if Value then
        Delta := 1 - Height
      else
        Delta := 32 - Height;

      Ani := TIntAni.Create(Height, Delta,
        procedure (V: Integer)
        begin
          Height := V;
        end, nil);
      Ani.AniSet.QuickAssign(akOut, afkQuartic, 0, 120, 12);
      Ani.Start;
    end;
end;

//  CHILD EVENTS

procedure TUCaptionBar.CustomBackColor_OnChange(Sender: TObject);
begin
  //  For container
  UpdateTheme(true);
end;

//  MAIN CLASS

constructor TUCaptionBar.Create(aOwner: TComponent);
begin
  inherited;
  BackColor := $F2F2F2;
  TextColor := GetTextColorFromBackground(BackColor);

  FCollapsed := false;
  FDragToMove := true;
  FSystemMenuEnabled := true;

  FCustomBackColor := TUThemeColorSet.Create;
  FCustomBackColor.OnChange := CustomBackColor_OnChange;
  FCustomBackColor.Assign(CAPTIONBAR_BACK);

  //  Default props
  Align := alTop;
  Alignment := taLeftJustify;
  Caption := '   Caption bar';
  BevelOuter := bvNone;
  Height := 32;
  ParentBackground := false;

  Color := $F2F2F2;
end;

destructor TUCaptionBar.Destroy;
begin
  FCustomBackColor.Free;
  inherited;
end;

//  CUSTOM METHODS

procedure TUCaptionBar.Paint;
begin
  //  Do not inherited

  //  Paint background
  Canvas.Brush.Color := BackColor;
  Canvas.FillRect(Rect(0, 0, Width, Height));

  //  Draw text
  if ShowCaption then
    begin
      Canvas.Font.Assign(Font);
      Canvas.Font.Color := TextColor;
      DrawTextRect(Canvas, Alignment, VerticalAlignment, Rect(0, 0, Width, Height), Caption, false);
    end;
end;

//  MESSAGE

procedure TUCaptionBar.WM_LButtonDblClk(var Msg: TWMLButtonDblClk);
var
  ParentForm: TCustomForm;
begin
  inherited;

  ParentForm := GetParentForm(Self, true);
  if ParentForm is TForm then
    if biMaximize in (ParentForm as TForm).BorderIcons then
      begin
        if ParentForm is TUForm then
          if (ParentForm as TUForm).FullScreen then
            exit;

        if ParentForm.WindowState = wsMaximized then
          ParentForm.WindowState := wsNormal
        else if ParentForm.WindowState = wsNormal then
          ParentForm.WindowState := wsMaximized;
      end;
end;

procedure TUCaptionBar.WM_LButtonDown(var Msg: TWMLButtonDown);
begin
  inherited;
  if DragToMove then
    begin
      ReleaseCapture;
      Parent.Perform(WM_SYSCOMMAND, $F012, 0);
    end;
end;

procedure TUCaptionBar.WM_RButtonUp(var Msg: TMessage);
const
  WM_SYSMENU = 787;
var
  P: TPoint;
begin
  inherited;
  if SystemMenuEnabled then
    begin
      P.X := Msg.LParamLo;
      P.Y := Msg.LParamHi;
      P := ClientToScreen(P);
      Msg.LParamLo := P.X;
      Msg.LParamHi := P.Y;
      PostMessage(Parent.Handle, WM_SYSMENU, 0, Msg.LParam);
    end;
end;

procedure TUCaptionBar.WM_NCHitTest(var Msg: TWMNCHitTest);
var
  P: TPoint;
  ParentForm: TCustomForm;
begin
  inherited;

  ParentForm := GetParentForm(Self, true);
  if (ParentForm.WindowState = wsNormal) and (Align = alTop) then
    begin
      P := Point(Msg.Pos.x, Msg.Pos.y);
      P := ScreenToClient(P);
      if P.Y < 5 then
        Msg.Result := HTTRANSPARENT;  //  Send event to parent
    end;
end;

procedure TUCaptionBar.CM_MouseEnter(var Msg: TMessage);
var
  ParentForm: TCustomForm;
begin
  inherited;
  ParentForm := GetParentForm(Self, true);
  if (ParentForm is TUForm) and ((ParentForm as TUForm).FullScreen) then
    Collapsed := false;
end;

procedure TUCaptionBar.CM_MouseLeave(var Msg: TMessage);
var
  ParentForm: TCustomForm;
begin
  inherited;
  ParentForm := GetParentForm(Self, true);
  if (ParentForm is TUForm) and ((ParentForm as TUForm).FullScreen) then
    if not PtInRect(GetClientRect, ScreenToClient(Mouse.CursorPos)) then
      Collapsed := true;
end;

end.
