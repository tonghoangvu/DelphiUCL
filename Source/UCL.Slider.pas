unit UCL.Slider;

interface

uses
  Classes, Windows, Messages, Controls, Graphics,
  UCL.Classes, UCL.ThemeManager, UCL.Colors, UCL.Utils;

type
  TUSlider = class(TUGraphicControl, IUControl)
    private
      var BarHeight: Integer;
      var CurWidth, CurHeight, CurCorner: Integer;
      var ActiveRect, NormalRect, CurRect: TRect;
      var ActiveColor, BackColor, CurColor: TColor;

      FCustomBackColor: TUStateColorSet;
      FCustomCursorColor: TUStateColorSet;

      FIsSliding: Boolean;

      FControlState: TUControlState;
      FOrientation: TUOrientation;
      FMin: Integer;
      FMax: Integer;
      FValue: Integer;

      FOnChange: TNotifyEvent;

      //  Internal
      procedure UpdateColors;
      procedure UpdateRects;

      //  Setters
      procedure SetControlState(const Value: TUControlState);
      procedure SetOrientation(const Value: TUOrientation);
      procedure SetMin(const Value: Integer);
      procedure SetMax(const Value: Integer);
      procedure SetValue(const Value: Integer);

      //  Child events
      procedure CustomBackColor_OnChange(Sender: TObject);
      procedure CustomCursorColor_OnChange(Sender: TObject);

      //  Messages
      procedure CM_MouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure CM_MouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

      procedure WM_LButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
      procedure WM_MouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
      procedure WM_LButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;

    protected
      procedure Paint; override;
      procedure Resize; override;
      procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$ENDIF}); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      //  Interface
      function IsContainer: Boolean;
      procedure UpdateTheme(const UpdateChildren: Boolean);

    published
      property ControlState: TUControlState read FControlState write SetControlState default csNone;
      property CustomBackColor: TUStateColorSet read FCustomBackColor write FCustomBackColor;
      property CustomCursorColor: TUStateColorSet read FCustomCursorColor write FCustomCursorColor;

      property IsSliding: Boolean read FIsSliding;
      property Orientation: TUOrientation read FOrientation write SetOrientation default oHorizontal;
      property Min: Integer read FMin write SetMin default 0;
      property Max: Integer read FMax write SetMax default 100;
      property Value: Integer read FValue write SetValue default 0;

      property OnChange: TNotifyEvent read FOnChange write FOnChange;

      //  Modify default props
      property Height default 25;
      property Width default 100;
  end;

implementation

{ TUSlider }

//  INTERFACE

function TUSlider.IsContainer: Boolean;
begin
  Result := false;
end;

procedure TUSlider.UpdateTheme(const UpdateChildren: Boolean);
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;

//  INTERNAL

procedure TUSlider.UpdateColors;
var
  TM: TUThemeManager;
  IsDark: Boolean;
  _BackColor: TUStateColorSet;
  _CurColor: TUStateColorSet;
begin
  TM := SelectThemeManager(Self);
  if (TM <> nil) and (TM.Theme = utDark) then
    IsDark := true
  else
    IsDark := false;

  //  Disabled
  if not Enabled then
    begin
      if not IsDark then
        ActiveColor := $CCCCCC
      else
        ActiveColor := $333333;
      BackColor := ActiveColor;
      CurColor := ActiveColor;
    end

  //  Normal
  else
    begin
      if TM = nil then
        ActiveColor := $D77800
      else
        ActiveColor := TM.AccentColor;

      _BackColor := SelectColorSet(TM, CustomBackColor, SLIDER_BACK);
      _CurColor := SelectColorSet(TM, CustomCursorColor, SLIDER_CURSOR);

      BackColor := _BackColor.GetColor(TM, ControlState, false);
      if ControlState = csNone then
        CurColor := ActiveColor
      else
        CurColor := _CurColor.GetColor(TM, ControlState, false);
    end;
end;

procedure TUSlider.UpdateRects;
begin
  if Orientation = oHorizontal then
    begin
      ActiveRect.Left := 0;
      ActiveRect.Top := (Height - BarHeight) div 2;
      ActiveRect.Right := Round((Width - CurWidth) * (Value - Min) / (Max - Min));
      ActiveRect.Bottom := ActiveRect.Top + BarHeight;

      NormalRect.Left := ActiveRect.Right + 1;
      NormalRect.Top := ActiveRect.Top;
      NormalRect.Right := Width;
      NormalRect.Bottom := ActiveRect.Bottom;

      CurRect.Left := ActiveRect.Right;
      CurRect.Top := Height div 2 - CurHeight div 2;
      CurRect.Right := CurRect.Left + CurWidth;
      CurRect.Bottom := CurRect.Top + CurHeight;
    end
  else
    begin
      NormalRect.Left := (Width - BarHeight) div 2;
      NormalRect.Top := 0;
      NormalRect.Right := NormalRect.Left + BarHeight;
      NormalRect.Bottom := Round((Height - CurHeight) * ({Value - Min}Max - Value) / (Max - Min));

      ActiveRect.Left := NormalRect.Left;
      ActiveRect.Top := NormalRect.Bottom + 1;
      ActiveRect.Right := NormalRect.Right;
      ActiveRect.Bottom := Height;

      CurRect.Left := (Width - CurWidth) div 2;
      CurRect.Top := NormalRect.Bottom;
      CurRect.Right := CurRect.Left + CurWidth;
      CurRect.Bottom := CurRect.Top + CurHeight;
    end;
end;

//  SETTERS

procedure TUSlider.SetControlState(const Value: TUControlState);
begin
  if Value <> FControlState then
    begin
      FControlState := Value;
      UpdateColors;
      Repaint;
    end;
end;

procedure TUSlider.SetOrientation(const Value: TUOrientation);
var
  TempSize: Integer;
begin
  if Value <> FOrientation then
    begin
      FOrientation := Value;

      //  Switch CurWidth and CurHeight
      TempSize := CurWidth;
      CurWidth := CurHeight;
      CurHeight := TempSize;

      UpdateRects;
      Repaint;
    end;
end;

procedure TUSlider.SetMin(const Value: Integer);
begin
  if Value <> FMin then
    begin
      FMin := Value;
      UpdateRects;
      Repaint;
    end;
end;

procedure TUSlider.SetMax(const Value: Integer);
begin
  if Value <> FMax then
    begin
      FMax := Value;
      UpdateRects;
      Repaint;
    end;
end;

procedure TUSlider.SetValue(const Value: Integer);
begin
  if Value <> FValue then
    begin
      FValue := Value;
      if Assigned(FOnChange) then
        FOnChange(Self);
      UpdateRects;
      Repaint;
    end;
end;

//  CHILD EVENTS

procedure TUSlider.CustomBackColor_OnChange(Sender: TObject);
begin
  UpdateColors;
  Repaint;
end;

procedure TUSlider.CustomCursorColor_OnChange(Sender: TObject);
begin
  UpdateColors;
  Repaint;
end;

//  MAIN CLASS

constructor TUSlider.Create(aOwner: TComponent);
begin
  inherited;
  CurWidth := 8;
  CurHeight := 23;
  CurCorner := 5;
  BarHeight := 2;

  FIsSliding := false;
  FControlState := csNone;
  FOrientation := oHorizontal;
  FMin := 0;
  FMax := 100;
  FValue := 0;

  FCustomBackColor := TUStateColorSet.Create;
  FCustomBackColor.OnChange := CustomBackColor_OnChange;
  FCustomBackColor.Assign(SLIDER_BACK);

  FCustomCursorColor := TUStateColorSet.Create;
  FCustomCursorColor.OnChange := CustomCursorColor_OnChange;
  FCustomCursorColor.Assign(SLIDER_CURSOR);

  //  Modify default props
  Height := 25;
  Width := 100;

  UpdateColors;
  UpdateRects;
end;

destructor TUSlider.Destroy;
begin
  FCustomBackColor.Free;
  FCustomCursorColor.Free;
  inherited;
end;

//  CUSTOM METHODS

procedure TUSlider.Paint;
begin
  inherited;

  //  Paint active part
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(ActiveColor, 255);
  Canvas.FillRect(ActiveRect);

  //  Paint normal part
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
  Canvas.FillRect(NormalRect);

  //  Paint cursor
  Canvas.Pen.Color := CurColor;
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(CurColor, 255);
  Canvas.RoundRect(CurRect, CurCorner, CurCorner);
  Canvas.FloodFill(CurRect.Left + CurRect.Width div 2, CurRect.Top + CurRect.Height div 2, CurColor, fsSurface);
end;

procedure TUSlider.Resize;
begin
  inherited;
  UpdateRects;
end;

procedure TUSlider.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$ENDIF});
begin
  inherited;
  CurWidth := MulDiv(CurWidth, M, D);
  CurHeight := MulDiv(CurHeight, M, D);
  CurCorner := MulDiv(CurCorner, M, D);
  BarHeight := MulDiv(BarHeight, M, D);
  UpdateRects;
end;

//  MESSAGES

procedure TUSlider.CM_MouseEnter(var Msg: TMessage);
begin
  if not Enabled then exit;
  ControlState := csHover;
  inherited;
end;

procedure TUSlider.CM_MouseLeave(var Msg: TMessage);
begin
  if not Enabled then exit;
  ControlState := csNone;
  inherited;
end;

procedure TUSlider.WM_LButtonDown(var Msg: TWMLButtonDown);
var
  TempValue: Integer;
begin
  if not Enabled then exit;

  FControlState := csPress;
  UpdateColors;
  FIsSliding := true;

  //  If press in cursor
  if
    (Msg.XPos < CurRect.Left)
    or (Msg.XPos > CurRect.Right)
    or (Msg.YPos < CurRect.Top)
    or (Msg.YPos > CurRect.Bottom)
  then
    begin
      //  Change Value by click position, click point is center of cursor
      if Orientation = oHorizontal then
        TempValue := Min + Round((Msg.XPos - CurWidth div 2) * (Max - Min) / (Width - CurWidth))
      else
        TempValue := Max - Round((Msg.YPos - CurHeight div 2) * (Max - Min) / (Height - CurHeight));

      //  Keep value in range [Min..Max]
      if TempValue < Min then
        TempValue := Min
      else if TempValue > Max then
        TempValue := Max;

      Value := TempValue;
    end
  else
    Repaint;

  inherited;
end;

procedure TUSlider.WM_MouseMove(var Msg: TWMMouseMove);
var
  TempValue: Integer;
begin
  if not Enabled then exit;

  if FIsSliding then
    begin
      if Orientation = oHorizontal then
        TempValue := Min + Round((Msg.XPos - CurWidth div 2) * (Max - Min) / (Width - CurWidth))
      else
        TempValue := Max - Round((Msg.YPos - CurHeight div 2) * (Max - Min) / (Height - CurHeight));

      //  Keep value in range [Min..Max]
      if TempValue < Min then
        TempValue := Min
      else if TempValue > Max then
        TempValue := Max;

      Value := TempValue;
    end;

  inherited;
end;

procedure TUSlider.WM_LButtonUp(var Msg: TWMLButtonUp);
begin
  if not Enabled then exit;
  ControlState := csNone;
  FIsSliding := false;
  inherited;
end;

end.
