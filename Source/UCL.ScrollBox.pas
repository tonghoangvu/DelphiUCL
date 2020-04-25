unit UCL.ScrollBox;

interface

uses
  Classes, Types, SysUtils, Windows, Messages, Graphics, FlatSB,
  Controls, StdCtrls, Forms, Dialogs, ExtCtrls,
  UCL.IntAnimation,
  UCL.Classes, UCL.Utils, UCL.ThemeManager, UCL.Colors;

type
  TUScrollBarStyle = (sbsMini, sbsFull, sbsNo);

  TUMiniScrollBar = class(TCustomPanel)
    private
      procedure WM_NCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

    public
      constructor Create(aOwner: TComponent); override;

    published
      property Visible default false;
  end;

  TUScrollBox = class(TScrollBox, IUControl)
    private
      var MouseLeave: Boolean;
      var MiniSB: TUMiniScrollBar;
      var MINI_SB_THICKNESS: Byte;
      var MINI_SB_MARGIN: Byte;
      var MINI_SB_COLOR: TColor;

      FAniSet: TIntAniSet;
      FCustomBackColor: TUThemeColorSet;

      FScrollCount: Integer;
      FScrollOrientation: TUOrientation;
      FScrollBarStyle: TUScrollBarStyle;
      FLengthPerStep: Integer;
      FMaxScrollCount: Integer;

      //  Child events
      procedure CustomBackColor_OnChange(Sender: TObject);

      //  Messages
      procedure WM_Size(var Msg: TWMSize); message WM_SIZE;
      procedure CM_MouseWheel(var Msg: TCMMouseWheel); message CM_MOUSEWHEEL;
      procedure CM_MouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure CM_MouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

    protected
      procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$ENDIF}); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      //  Interface
      function IsContainer: Boolean;
      procedure UpdateTheme(const UpdateChildren: Boolean);

      //  Utils
      procedure SetOldSBVisible(IsVisible: Boolean);
      procedure SetMiniSBVisible(IsVisible: Boolean);
      procedure UpdateMiniSB;
      procedure ClearBox;

    published
      property AniSet: TIntAniSet read FAniSet write FAniSet;
      property CustomBackColor: TUThemeColorSet read FCustomBackColor write FCustomBackColor;

      property ScrollCount: Integer read FScrollCount;
      property ScrollOrientation: TUOrientation read FScrollOrientation write FScrollOrientation default oVertical;
      property ScrollBarStyle: TUScrollBarStyle read FScrollBarStyle write FScrollBarStyle default sbsMini;
      property LengthPerStep: Integer read FLengthPerStep write FLengthPerStep default 2;
      property MaxScrollCount: Integer read FMaxScrollCount write FMaxScrollCount default 8;

      //  Modify default props
      property BorderStyle default bsNone;
  end;

implementation

{ TUScrollBox }

//  INTERFACE

function TUScrollBox.IsContainer: Boolean;
begin
  Result := true;
end;

procedure TUScrollBox.UpdateTheme(const UpdateChildren: Boolean);
var
  i: Integer;
  TM: TUThemeManager;
  _BackColor: TUThemeColorSet;
begin
  TM := SelectThemeManager(Self);
  _BackColor := SelectColorSet(TM, CustomBackColor, SCROLLBOX_BACK);

  //  Update background color
  Color := _BackColor.GetColor(TM);

  //  Update children
  if IsContainer and UpdateChildren then
    for i := 0 to ControlCount - 1 do
      if Supports(Controls[i], IUControl) then
        (Controls[i] as IUControl).UpdateTheme(UpdateChildren);
end;

//  CHILD EVENTS

procedure TUScrollBox.CustomBackColor_OnChange(Sender: TObject);
begin
  //  For container
  UpdateTheme(true);
end;

//  MAIN CLASS

constructor TUScrollBox.Create(aOwner: TComponent);
begin
  inherited;
  MouseLeave := true;
  MINI_SB_THICKNESS := 2;
  MINI_SB_MARGIN := 3;
  MINI_SB_COLOR := $7A7A7A;   //  Both light and dark

  MiniSB := TUMiniScrollBar.Create(Self);
  MiniSB.Color := MINI_SB_COLOR;
  MiniSB.Parent := Self;
  MiniSB.SetSubComponent(true);
  MiniSB.Visible := false;
  MiniSB.Width := 0;

  FScrollCount := 0;
  FScrollOrientation := oVertical;
  FScrollBarStyle := sbsMini;
  FLengthPerStep := 2;
  FMaxScrollCount := 8;

  FAniSet := TIntAniSet.Create;
  FAniSet.QuickAssign(akOut, afkQuintic, 0, 120, 11);

  FCustomBackColor := TUThemeColorSet.Create;
  FCustomBackColor.OnChange := CustomBackColor_OnChange;
  FCustomBackColor.Assign(SCROLLBOX_BACK);

  //  Modify default props
  BorderStyle := bsNone;
  VertScrollBar.Tracking := true;
  HorzScrollBar.Tracking := true;
end;

destructor TUScrollBox.Destroy;
begin
  MiniSB.Free;
  FCustomBackColor.Free;
  FAniSet.Free;
  inherited;
end;

//  CUSTOM METHODS

procedure TUScrollBox.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$ENDIF});
begin
  inherited;
  MINI_SB_THICKNESS := MulDiv(MINI_SB_THICKNESS, M, D);
  MINI_SB_MARGIN := MulDiv(MINI_SB_MARGIN, M, D);
  FLengthPerStep := MulDiv(FLengthPerStep, M, D);
end;

//  UTILS

procedure TUScrollBox.SetOldSBVisible(IsVisible: Boolean);
begin
  if not (csDesigning in ComponentState) then
    FlatSB_ShowScrollBar(Handle, SB_BOTH, IsVisible);
end;

procedure TUScrollBox.SetMiniSBVisible(IsVisible: Boolean);
begin
  MiniSB.Visible := IsVisible;
  if IsVisible then
    begin
      UpdateMiniSB;
      MiniSB.BringToFront;
    end;
end;

procedure TUScrollBox.UpdateMiniSB;
var
  SB: TControlScrollBar;
  ControlSize: Integer;
  ThumbPos, ThumbSize: Integer;
begin
  //  Get orientation values
  if ScrollOrientation = oVertical then
    begin
      SB := VertScrollBar;
      ControlSize := Height;
    end
  else
    begin
      SB := HorzScrollBar;
      ControlSize := Width;
    end;

  if (SB.Range = 0) or (SB.Range < ControlSize) then
    begin
      MiniSB.Visible := false;
      exit;
    end;

  ThumbSize := Round(ControlSize * ControlSize / SB.Range);
  ThumbPos := Round(ControlSize * SB.Position / SB.Range);

  if ScrollOrientation = oVertical then
    (MiniSB as TControl).SetBounds(Width - MINI_SB_MARGIN - MINI_SB_THICKNESS, ThumbPos, MINI_SB_THICKNESS, ThumbSize)
  else
    (MiniSB as TControl).SetBounds(ThumbPos, Height - MINI_SB_MARGIN - MINI_SB_THICKNESS, ThumbSize, MINI_SB_THICKNESS);
end;

procedure TUScrollBox.ClearBox;
var
  i: Integer;
begin
  i := 0;
  while ControlCount > i do
    if Controls[i] = MiniSB then
      inc(i)
    else
      Controls[i].Free;
end;

//  MESSAGES

procedure TUScrollBox.CM_MouseWheel(var Msg: TCMMouseWheel);
var
  SB: TControlScrollBar;
  Ani: TIntAni;
  Sign: Integer;
begin
  inherited;

  if not PtInRect(GetClientRect, ScreenToClient(Mouse.CursorPos)) then
    exit;

  if ScrollOrientation = oVertical then
    SB := VertScrollBar
  else
    SB := HorzScrollBar;

  //  Scroll by touchpad
  if (Abs(Msg.WheelDelta) < 100) or (csDesigning in ComponentState) then
    begin
      if csDesigning in ComponentState then
        Msg.WheelDelta := 10 * Msg.WheelDelta div Abs(Msg.WheelDelta);

      DisableAlign;
      SB.Position := SB.Position - Msg.WheelDelta;
      if ScrollBarStyle = sbsMini then
        UpdateMiniSB;
      EnableAlign;
    end

  //  Scroll by mouse
  else
    begin
      if FScrollCount >= MaxScrollCount then exit;

      if FScrollCount = 0 then
        begin
          DisableAlign;
          Mouse.Capture := Handle;
        end;

      inc(FScrollCount);
      Sign := Msg.WheelDelta div Abs(Msg.WheelDelta);

      Ani := TIntAni.Create(1, +LengthPerStep, nil, nil);
      Ani.AniSet.Assign(Self.AniSet);

      if ScrollBarStyle = sbsMini then
        Ani.OnSync :=
          procedure (V: Integer)
          begin
            SB.Position := SB.Position - V * Sign;
            UpdateMiniSB;
          end
      else
        Ani.OnSync :=
          procedure (V: Integer)
          begin
            SB.Position := SB.Position - V * Sign;
          end;

      Ani.OnDone :=
        procedure
        begin
          if ScrollBarStyle <> sbsFull then
            SetOldSBVisible(false);
          dec(FScrollCount);
          if FScrollCount = 0 then
            begin
              EnableAlign;
              Mouse.Capture := 0;
            end;
        end;
      Ani.Start;
    end;
end;

procedure TUScrollBox.CM_MouseEnter(var Msg: TMessage);
begin
  inherited;
  if Win32MajorVersion <> 10 then
    SetFocus;

  if
    (MouseLeave) and
    (PtInRect(GetClientRect, ScreenToClient(Mouse.CursorPos)))
  then
    begin
      if ScrollBarStyle <> sbsFull then
        SetOldSBVisible(false);
      if ScrollBarStyle = sbsMini then
        SetMiniSBVisible(true);
    end;
end;

procedure TUScrollBox.CM_MouseLeave(var Msg: TMessage);
begin
  inherited;
  MouseLeave := true;
  if ScrollBarStyle = sbsMini then
    if not PtInRect(GetClientRect, ScreenToClient(Mouse.CursorPos)) then
      begin
        MouseLeave := true;
        SetMiniSBVisible(false);
      end;
end;

procedure TUScrollBox.WM_Size(var Msg: TWMSize);
begin
  inherited;
  if ScrollBarStyle <> sbsFull then
    SetOldSBVisible(false);
end;

{ TUMiniScrollBar }

constructor TUMiniScrollBar.Create(aOwner: TComponent);
begin
  inherited;

  BevelOuter := bvNone;
  FullRepaint := false;
  DoubleBuffered := true;
  Visible := false;

  {$IF CompilerVersion > 29}
    StyleElements := [];
  {$ENDIF}
end;

procedure TUMiniScrollBar.WM_NCHitTest(var Msg: TWMNCHitTest);
begin
  Msg.Result := HTTRANSPARENT;
end;

end.
