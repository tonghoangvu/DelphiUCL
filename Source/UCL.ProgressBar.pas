unit UCL.ProgressBar;

interface

uses
  Classes, Types, Messages, Controls, Graphics, Forms,
  UCL.IntAnimation, UCL.Classes, UCL.ThemeManager, UCL.Utils, UCL.Colors,
  UCL.Form;

type
  TUProgressBar = class(TUCustomControl, IUControl)
    private
      var FillColor, BackColor: TColor;
      var FillRect, BackRect: TRect;

      FAniSet: TIntAniSet;
      FCustomFillColor: TColor;
      FCustomBackColor: TUThemeColorSet;

      FValue: Byte;
      FOrientation: TUOrientation;

      FOnChange: TNotifyEvent;

      //  Internal
      procedure UpdateColors;
      procedure UpdateRects;

      //  Setters
      procedure SetValue(const Value: Byte);
      procedure SetOrientation(const Value: TUOrientation);

      //  Child events
      procedure CustomBackColor_OnChange(Sender: TObject);

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

      procedure GoToValue(Value: Integer);

    published
      property AniSet: TIntAniSet read FAniSet write FAniSet;
      property CustomFillColor: TColor read FCustomFillColor write FCustomFillColor default $25B006;
      property CustomBackColor: TUThemeColorSet read FCustomBackColor write FCustomBackColor;

      property Value: Byte read FValue write SetValue default 0;
      property Orientation: TUOrientation read FOrientation write SetOrientation default oHorizontal;

      property OnChange: TNotifyEvent read FOnChange write FOnChange;

      //  Modify default props
      property Height default 5;
      property Width default 100;
  end;

implementation

{ TUProgressBar }

//  INTERFACE

function TUProgressBar.IsContainer: Boolean;
begin
  Result := false;
end;

procedure TUProgressBar.UpdateTheme(const UpdateChildren: Boolean);
begin
  UpdateColors;
  UpdateRects;
  Repaint;

  //  Do not update children
end;

//  INTERNAL

procedure TUProgressBar.UpdateColors;
var
  TM: TUThemeManager;
  _BackColor: TUThemeColorSet;
begin
  TM := SelectThemeManager(Self);

  //  Update fill color
  if TM = nil then
    FillColor := CustomFillColor
  else
    FillColor := TM.AccentColor;

  //  Update back color
  _BackColor := SelectColorSet(TM, CustomBackColor, PROGRESSBAR_BACK);
  BackColor := _BackColor.GetColor(TM);
end;

procedure TUProgressBar.UpdateRects;
begin
  if Orientation = oHorizontal then
    begin
      FillRect := Rect(0, 0, Round(Value / 100 * Width), Height);
      BackRect := Rect(FillRect.Right, 0, Width, Height);
    end
  else
    begin
      BackRect := Rect(0, 0, Width, Height - Round(Value / 100 * Height));
      FillRect := Rect(0, BackRect.Bottom, Width, Height);
    end;
end;

//  SETTERS

procedure TUProgressBar.SetValue(const Value: Byte);
begin
  if Value <> FValue then
    if Value <= 100 then
      begin
        FValue := Value;
        if Assigned(FOnChange) then
          FOnChange(Self);
        UpdateRects;
        Repaint;
      end;
end;

procedure TUProgressBar.SetOrientation(const Value: TUOrientation);
begin
  if Value <> FOrientation then
    begin
      FOrientation := Value;
      UpdateRects;
      Repaint;
    end;
end;

//  CHILD EVENTS

procedure TUProgressBar.CustomBackColor_OnChange(Sender: TObject);
begin
  UpdateColors;
  Repaint;
end;

//  MAIN CLASS

constructor TUProgressBar.Create(aOwner: TComponent);
begin
  inherited;
  FValue := 0;
  FOrientation := oHorizontal;
  FCustomFillColor := $25B006;

  FCustomBackColor := TUThemeColorSet.Create;
  FCustomBackColor.OnChange := CustomBackColor_OnChange;
  FCustomBackColor.Assign(PROGRESSBAR_BACK);

  FAniSet := TIntAniSet.Create;
  FAniSet.QuickAssign(akOut, afkQuartic, 0, 250, 25);

  //  Modify default props
  Width := 100;
  Height := 5;

  UpdateColors;
  UpdateRects;
end;

destructor TUProgressBar.Destroy;
begin
  FAniSet.Free;
  FCustomBackColor.Free;
  inherited;
end;

//  CUSTOM METHODS

procedure TUProgressBar.Paint;
begin
  inherited;

  //  Paint background
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
  Canvas.FillRect(BackRect);

  //  Paint Fillround
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(FillColor, 255);
  Canvas.FillRect(FillRect);
end;

procedure TUProgressBar.Resize;
begin
  inherited;
  UpdateRects;
end;

procedure TUProgressBar.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$ENDIF});
begin
  inherited;
  UpdateRects;
end;

//  UTILS

procedure TUProgressBar.GoToValue(Value: Integer);
var
  Ani: TIntAni;
begin
  if not Enabled then exit;

  Ani := TIntAni.Create(FValue, Value - FValue,
    procedure (V: Integer)
    begin
      Self.Value := V;
    end, nil);
  Ani.AniSet.Assign(Self.AniSet);
  Ani.Start;
end;

end.
