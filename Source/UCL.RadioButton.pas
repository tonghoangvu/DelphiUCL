unit UCL.RadioButton;

interface

uses
  Classes, Messages, Windows, Controls, Graphics,
  UCL.Classes, UCL.ThemeManager, UCL.Colors, UCL.Utils, UCL.Graphics;

type
  TURadioButton = class(TUGraphicControl, IUControl)
    private
      var ActiveColor, TextColor: TColor;
      var IconRect, TextRect: TRect;

      FIconFont: TFont;
      FIsChecked: Boolean;
      FTransparent: Boolean;
      FCustomAccentColor: TColor;
      FTextSpacing: Integer;
      FGroup: string;

      //  Internal
      procedure UpdateColors;
      procedure UpdateRects;

      //  Setters
      procedure SetIsChecked(const Value: Boolean);
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
      property IsChecked: Boolean read FIsChecked write SetIsChecked default false;
      property Transparent: Boolean read FTransparent write SetTransparent default true;
      property CustomAccentColor: TColor read FCustomAccentColor write SetCustomAccentColor default $D77800;
      property TextSpacing: Integer read FTextSpacing write SetTextSpacing default 6;
      property Group: string read FGroup write FGroup nodefault;

      //  Modify default props
      property Caption;
      property ParentColor default true;
  end;

implementation

uses
  UCL.FontIcons;

{ TURadioButton }

//  INTERFACE

function TURadioButton.IsContainer: Boolean;
begin
  Result := false;
end;

procedure TURadioButton.UpdateTheme(const UpdateChildren: Boolean);
begin
  UpdateColors;
  UpdateRects;
  Repaint;

  //  Do not update children
end;

//  INTERNAL

procedure TURadioButton.UpdateColors;
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

procedure TURadioButton.UpdateRects;
begin
  IconRect := Rect(0, 0, Height, Height);   //  Left square
  TextRect := Rect(Height + TextSpacing, 0, Width, Height);
end;

//  SETTERS

procedure TURadioButton.SetIsChecked(const Value: Boolean);
var
  i: Integer;
begin
  if Value <> FIsChecked then
    begin
      FIsChecked := Value;

      //  Uncheck all items with the same group
      if Value then
        for i := 0 to Parent.ControlCount - 1 do
          if
            (Parent.Controls[i] <> Self)
            and (Parent.Controls[i] is TURadioButton)
            and ((Parent.Controls[i] as TURadioButton).Group = Group)
          then
            (Parent.Controls[i] as TURadioButton).IsChecked := false;

      Repaint;
    end;
end;

procedure TURadioButton.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then
    begin
      FTransparent := Value;
      Repaint;
    end;
end;

procedure TURadioButton.SetCustomAccentColor(const Value: TColor);
begin
  if Value <> FCustomAccentColor then
    begin
      FCustomAccentColor := Value;
      UpdateColors;
      Repaint;
    end;
end;

procedure TURadioButton.SetTextSpacing(const Value: Integer);
begin
  if Value <> FTextSpacing then
    begin
      FTextSpacing := Value;
      UpdateRects;
      Repaint;
    end;
end;

//  MAIN CLASS

constructor TURadioButton.Create(aOwner: TComponent);
begin
  inherited;

  FIconFont := TFont.Create;
  FIconFont.Name := 'Segoe MDL2 Assets';
  FIconFont.Size := 15;

  FIsChecked := false;
  FTransparent := true;
  FCustomAccentColor := $D77800;
  FTextSpacing := 6;

  ParentColor := true;
  Height := 30;
  Width := 100;

  UpdateColors;
  UpdateRects;
end;

destructor TURadioButton.Destroy;
begin
  FIconFont.Free;
  inherited;
end;

//  CUSTOM METHODS

procedure TURadioButton.Paint;
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
  if not IsChecked then
    begin
      Canvas.Font.Color := TextColor;
      DrawTextRect(Canvas, taCenter, taVerticalCenter, IconRect, UF_RADIO_OUTLINE, Transparent);
    end
  else
    begin
      Canvas.Font.Color := ActiveColor;
      DrawTextRect(Canvas, taCenter, taVerticalCenter, IconRect, UF_RADIO_OUTLINE, Transparent);

      Canvas.Font.Color := TextColor;
      DrawTextRect(Canvas, taCenter, taVerticalCenter, IconRect, UF_RADIO_SMALL, Transparent);
    end;
end;

procedure TURadioButton.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$ENDIF});
begin
  inherited;
  FIconFont.Height := MulDiv(FIconFont.Height, M, D);
  FTextSpacing := MulDiv(FTextSpacing, M, D);
  UpdateRects;
end;

//  MESSAGES

procedure TURadioButton.WM_LButtonUp(var Msg: TWMLButtonUp);
begin
  if not Enabled then exit;
  if PtInRect(IconRect, Msg.Pos) then
    IsChecked := true;
  inherited;
end;

procedure TURadioButton.CM_EnabledChanged(var Msg: TMessage);
begin
  UpdateColors;
  Repaint;
  inherited;
end;

end.
