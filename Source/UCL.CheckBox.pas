unit UCL.CheckBox;

interface

uses
  Classes, Messages, Windows, Controls, Graphics,
  UCL.Classes, UCL.ThemeManager, UCL.Colors, UCL.Utils, UCL.Graphics;

type
  TUCheckBoxState = (cbsChecked, cbsUnchecked, cbsGrayed);

  TUCheckBox = class(TUGraphicControl, IUControl)
    private
      var ActiveColor, TextColor: TColor;
      var IconRect, TextRect: TRect;

      FIconFont: TFont;
      FAllowGrayed: Boolean;
      FState: TUCheckBoxState;
      FTransparent: Boolean;
      FCustomAccentColor: TColor;
      FTextSpacing: Integer;

      //  Internal
      procedure UpdateColors;
      procedure UpdateRects;

      //  Setters
      procedure SetAllowGrayed(const Value: Boolean);
      procedure SetState(const Value: TUCheckBoxState);
      procedure SetTransparent(const Value: Boolean);
      procedure SetCustomAccentColor(const Value: TColor);
      procedure SetTextSpacing(const Value: Integer);

      //  Messages
      procedure WM_LButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
      procedure CM_EnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;

    protected
      procedure Paint; override;
      procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$ENDIF}); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      //  Interface
      function IsContainer: Boolean;
      procedure UpdateTheme(const UpdateChildren: Boolean);

    published
      property IconFont: TFont read FIconFont write FIconFont;
      property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed default false;
      property State: TUCheckBoxState read FState write SetState default cbsUnchecked;
      property Transparent: Boolean read FTransparent write SetTransparent default true;
      property CustomAccentColor: TColor read FCustomAccentColor write SetCustomAccentColor default $D77800;
      property TextSpacing: Integer read FTextSpacing write SetTextSpacing default 6;

      //  Modify default props
      property Caption;
      property ParentColor default true;
  end;

implementation

{ TUCheckBox }

uses UCL.FontIcons;

//  INTERFACE

function TUCheckBox.IsContainer: Boolean;
begin
  Result := false;
end;

procedure TUCheckBox.UpdateTheme(const UpdateChildren: Boolean);
begin
  UpdateColors;
  UpdateRects;
  Repaint;

  //  Do not update children
end;

//  INTERNAL

procedure TUCheckBox.UpdateColors;
var
  TM: TUThemeManager;
begin
  TM := SelectThemeManager(Self);

  if not Enabled then
    begin
      ActiveColor := $808080;
      TextColor := $808080;
    end
  else
    begin
      ActiveColor := SelectAccentColor(TM, CustomAccentColor);
      if (TM <> nil) and (TM.Theme = utDark) then
        TextColor := $FFFFFF
      else
        TextColor := $000000;
    end;
end;

procedure TUCheckBox.UpdateRects;
begin
  IconRect := Rect(0, 0, Height, Height);   //  Left square
  TextRect := Rect(Height + TextSpacing, 0, Width, Height);
end;

//  SETTERS

procedure TUCheckBox.SetAllowGrayed(const Value: Boolean);
begin
  if Value <> FAllowGrayed then
    begin
      FAllowGrayed := Value;
      if (not Value) and (FState = cbsGrayed) then
        begin
          FState := cbsUnchecked;
          Repaint;
        end;
    end;
end;

procedure TUCheckBox.SetState(const Value: TUCheckBoxState);
begin
  if Value <> FState then
    begin
      if (not AllowGrayed) and (Value = cbsGrayed) then
        FState := cbsUnchecked
      else
        FState := Value;
      Repaint;
    end;
end;

procedure TUCheckBox.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then
    begin
      FTransparent := Value;
      Repaint;
    end;
end;

procedure TUCheckBox.SetCustomAccentColor(const Value: TColor);
begin
  if Value <> FCustomAccentColor then
    begin
      FCustomAccentColor := Value;
      UpdateColors;
      Repaint;
    end;
end;

procedure TUCheckBox.SetTextSpacing(const Value: Integer);
begin
  if Value <> FTextSpacing then
    begin
      FTextSpacing := Value;
      UpdateRects;
      Repaint;
    end;
end;

//  MAIN CLASS

constructor TUCheckBox.Create(aOwner: TComponent);
begin
  inherited;

  FIconFont := TFont.Create;
  FIconFont.Name := 'Segoe MDL2 Assets';
  FIconFont.Size := 15;

  FAllowGrayed := false;
  FState := cbsUnchecked;
  FTransparent := true;
  FCustomAccentColor := $D77800;
  FTextSpacing := 6;

  ParentColor := true;
  Height := 30;
  Width := 180;

  UpdateColors;
  UpdateRects;
end;

destructor TUCheckBox.Destroy;
begin
  FIconFont.Free;
  inherited;
end;

//  CUSTOM METHODS

procedure TUCheckBox.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$ENDIF});
begin
  inherited;
  FIconFont.Height := MulDiv(FIconFont.Height, M, D);
  FTextSpacing := MulDiv(FTextSpacing, M, D);
  UpdateRects;
end;

procedure TUCheckBox.Paint;
begin
  inherited;

  //  Paint background
  if not Transparent then
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Handle := CreateSolidBrushWithAlpha(Color, 255);
      Canvas.FillRect(Rect(0, 0, Width, Height));
    end;

  //  Draw text
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(Font);
  Canvas.Font.Color := TextColor;
  DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, TextRect, Caption, Transparent);

  //  Draw icon
  Canvas.Font.Assign(IconFont);
  case State of
    cbsChecked:
      begin
        Canvas.Font.Color := ActiveColor;
        DrawTextRect(Canvas, taCenter, taVerticalCenter, IconRect, UF_CHECKBOX_CHECKED, Transparent);
      end;

    cbsUnchecked:
      begin
        Canvas.Font.Color := TextColor;
        DrawTextRect(Canvas, taCenter, taVerticalCenter, IconRect, UF_CHECKBOX_OUTLINE, Transparent);
      end;

    cbsGrayed:
      begin
        Canvas.Font.Color := ActiveColor;
        DrawTextRect(Canvas, taCenter, taVerticalCenter, IconRect, UF_CHECKBOX_OUTLINE, Transparent);

        Canvas.Font.Color := TextColor;
        DrawTextRect(Canvas, taCenter, taVerticalCenter, IconRect, UF_CHECKBOX_SMALL, Transparent);
      end;
  end;
end;

//  MESSAGES

procedure TUCheckBox.WM_LButtonUp(var Msg: TWMLButtonUp);
begin
  if not Enabled then exit;
  if PtInRect(IconRect, Msg.Pos) then
    begin
      if AllowGrayed then   //  Unchecked > Checked > Grayed > ...
        case State of
          cbsUnchecked:
            State := cbsChecked;
          cbsChecked:
            State := cbsGrayed;
          cbsGrayed:
            State := cbsUnchecked;
        end
      else
        case State of
          cbsUnchecked:
            State := cbsChecked;
          cbsChecked:
            State := cbsUnchecked;
          cbsGrayed:
            State := cbsUnchecked;
        end;
    end;

  inherited;
end;

procedure TUCheckBox.CM_EnabledChanged(var Msg: TMessage);
begin
  UpdateColors;
  Repaint;
  inherited;
end;

end.
