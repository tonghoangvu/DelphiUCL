unit UCL.Edit;

interface

uses
  Classes, Windows, Messages, Controls, StdCtrls, ExtCtrls, Graphics, Forms,
  UCL.Classes, UCL.ThemeManager, UCL.Utils, UCL.Graphics, UCL.Colors;

type
  TUEdit = class(TEdit, IUControl)
    private
      var BorderThickness: Integer;
      var BorderColor, BackColor, TextColor: TColor;

      FControlState: TUControlState;
      FCustomBackColor: TUThemeColorSet;
      FCustomBorderColor: TUStateColorSet;

      FTransparent: Boolean;

      //  Internal
      procedure UpdateColors;

      //  Setters
      procedure SetControlState(const Value: TUControlState);
      procedure SetTransparent(const Value: Boolean);

      //  Child events
      procedure CustomBackColor_OnChange(Sender: TObject);
      procedure CustomBorderColor_OnChange(Sender: TObject);

      //  Messages
      procedure WM_NCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
      procedure WM_LButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
      procedure WM_LButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
      procedure WM_SetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
      procedure WM_KillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;

      procedure CM_MouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure CM_MouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
      procedure CM_EnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;

    protected
      procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$ENDIF}); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      //  Interface
      function IsContainer: Boolean;
      procedure UpdateTheme(const UpdateChildren: Boolean);

    published
      property ControlState: TUControlState read FControlState write SetControlState default csNone;
      property CustomBackColor: TUThemeColorSet read FCustomBackColor write FCustomBackColor;
      property CustomBorderColor: TUStateColorSet read FCustomBorderColor write FCustomBorderColor;

      property Transparent: Boolean read FTransparent write SetTransparent default false;

      //  Modify default props
      property BorderStyle default bsNone;
      property BevelKind default bkFlat;
      property Ctl3D default false;
      property AutoSize default false;
      property Height default 30;
  end;

implementation

{ TUEdit }

//  INTERFACE

function TUEdit.IsContainer: Boolean;
begin
  Result := false;
end;

procedure TUEdit.UpdateTheme(const UpdateChildren: Boolean);
begin
  UpdateColors;

  if Color <> BackColor then
    Color := BackColor;

  ParentFont := true;
  if Font.Color <> TextColor then
    Font.Color := TextColor;
  Invalidate;

  //  Do not update children
end;

//  INTERNAL

procedure TUEdit.UpdateColors;
var
  TM: TUThemeManager;
  AccentColor: TColor;
  _BackColor: TUThemeColorSet;
  _BorderColor: TUStateColorSet;
begin
  TM := SelectThemeManager(Self);
  AccentColor := SelectAccentColor(TM, $D77800);

  //  Disabled
  if not Enabled then
    begin
      BackColor := $D8D8D8;
      BorderColor := $CCCCCC;
      TextColor := clGray;
    end

  else
    begin
      if Transparent and (ControlState = csNone) then
        begin
          ParentColor := true;
          BackColor := Color;
        end
      else
        begin
          _BackColor := SelectColorSet(TM, CustomBackColor, EDIT_BACK);
          BackColor := _BackColor.GetColor(TM);
        end;

      if Focused or (ControlState = csPress) then
        BorderColor := AccentColor
      else
        begin
          _BorderColor := SelectColorSet(TM, CustomBorderColor, EDIT_BORDER);
          BorderColor := _BorderColor.GetColor(TM, ControlState, Focused);
        end;

      TextColor := GetTextColorFromBackground(BackColor);
    end;
end;

//  SETTERS

procedure TUEdit.SetControlState(const Value: TUControlState);
begin
  if Value <> FControlState then
    begin
      FControlState := Value;
      UpdateTheme(false);
    end;
end;

procedure TUEdit.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then
    begin
      FTransparent := Value;
      UpdateTheme(false);
    end;
end;

//  CHILD EVENTS

procedure TUEdit.CustomBackColor_OnChange(Sender: TObject);
begin
  UpdateTheme(false);
end;

procedure TUEdit.CustomBorderColor_OnChange(Sender: TObject);
begin
  UpdateTheme(false);
end;

//  MAIN CLASS

constructor TUEdit.Create(aOwner: TComponent);
begin
  inherited;

  BorderThickness := 2;

  FControlState := csNone;
  FTransparent := false;

  FCustomBackColor := TUThemeColorSet.Create;
  FCustomBackColor.OnChange := CustomBackColor_OnChange;
  FCustomBackColor.Assign(EDIT_BACK);

  FCustomBorderColor := TUStateColorSet.Create;
  FCustomBorderColor.OnChange := CustomBorderColor_OnChange;
  FCustomBorderColor.Assign(EDIT_BORDER);

  //  Modify default props
  AutoSize := false;
  BorderStyle := bsNone;
  BevelKind := bkFlat;
  BorderWidth := 3;
  Ctl3D := false;
  Height := 30;

  UpdateColors;
end;

destructor TUEdit.Destroy;
begin
  FCustomBackColor.Free;
  FCustomBorderColor.Free;
  inherited;
end;

//  CUSTOM METHODS

procedure TUEdit.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$ENDIF});
begin
  inherited;
  BorderThickness := MulDiv(BorderThickness, M, D);
  BorderWidth := MulDiv(BorderWidth, M, D);
end;

//  MESSAGE

procedure TUEdit.WM_NCPaint(var Msg: TWMNCPaint);
var
  Canvas: TCanvas;
  DC: HDC;
begin
  inherited;

  DC:= GetWindowDC(Handle);
  SaveDC(DC);
  try
    Canvas:= TCanvas.Create;
    try
      Canvas.Handle := DC;
      Canvas.Lock;
      Canvas.Brush.Style := bsClear;

      DrawBorder(Canvas, Rect(0, 0, Width, Height), BorderColor, BorderThickness);
    finally
      Canvas.Unlock;
      Canvas.free;
    end;
  finally
    RestoreDC(DC, -1);
    ReleaseDC(Handle, DC);
  end;
end;

procedure TUEdit.WM_SetFocus(var Msg: TWMSetFocus);
begin
  UpdateTheme(false);
  inherited;
end;

procedure TUEdit.WM_KillFocus(var Msg: TWMKillFocus);
begin
  UpdateTheme(false);
  inherited;
end;

procedure TUEdit.WM_LButtonDown(var Msg: TWMLButtonDown);
begin
  if not Enabled then exit;
  ControlState := csPress;
  inherited;
end;

procedure TUEdit.WM_LButtonUp(var Msg: TWMLButtonUp);
var
  MousePoint: TPoint;
begin
  if not Enabled then exit;

  MousePoint := ScreenToClient(Mouse.CursorPos);
  if PtInRect(GetClientRect, MousePoint) then
    ControlState := csHover
  else
    ControlState := csNone;

  inherited;
end;

procedure TUEdit.CM_MouseEnter(var Msg: TMessage);
begin
  if not Enabled then exit;
  ControlState := csHover;
  inherited;
end;

procedure TUEdit.CM_MouseLeave(var Msg: TMessage);
begin
  if not Enabled then exit;
  ControlState := csNone;
  inherited;
end;

procedure TUEdit.CM_EnabledChanged(var Msg: TMessage);
begin
  UpdateTheme(false);
  inherited;
end;

end.
