unit UCL.Colors;

interface

uses
  Classes, Graphics,
  UCL.Classes, UCL.ThemeManager;

type
  TUThemeColorSet = class(TPersistent)
    private
      FEnabled: Boolean;
      FColor: TColor;
      FLightColor: TColor;
      FDarkColor: TColor;
      FOnChange: TNotifyEvent;

      procedure SetEnabled(const Value: Boolean);
      procedure SetThemeColor(Index: Integer; const Value: TColor);

    protected
      procedure Changed;

    public
      constructor Create; overload;
      constructor Create(Color, LightColor, DarkColor: TColor); overload;

      procedure Assign(Source: TPersistent); override;
      procedure SetColor(Color, LightColor, DarkColor: TColor);
      function GetColor(const TM: TUThemeManager): TColor;

    published
      property Enabled: Boolean read FEnabled write SetEnabled;   //  No default
      property Color: TColor index 0 read FColor write SetThemeColor;
      property LightColor: TColor index 1 read FLightColor write SetThemeColor;
      property DarkColor: TColor index 2 read FDarkColor write SetThemeColor;

      property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

var
  TOOLTIP_SHADOW: Boolean;
  TOOLTIP_BORDER_THICKNESS: Byte;
  TOOLTIP_FONT_NAME: string;
  TOOLTIP_FONT_SIZE: Byte;

  FORM_FONT_NAME: string;
  FORM_FONT_SIZE: Byte;

  TOOLTIP_BACK: TUThemeColorSet;
  TOOLTIP_BORDER: TUThemeColorSet;
  FORM_BACK: TUThemeColorSet;
  PANEL_BACK: TUThemeColorSet;

implementation

{ TUThemeColorSet }

//  SETTERS

procedure TUThemeColorSet.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
    begin
      FEnabled := Value;
      Changed;
    end;
end;

procedure TUThemeColorSet.SetThemeColor(Index: Integer; const Value: TColor);
begin
  case Index of
    0:
      if Value <> FColor then
        begin
          FColor := Value;
          Changed;
        end;
    1:
      if Value <> FLightColor then
        begin
          FLightColor := Value;
          Changed;
        end;
    2:
      if Value <> FDarkColor then
        begin
          FDarkColor := Value;
          Changed;
        end;
  end;
end;

//  MAIN CLASS

constructor TUThemeColorSet.Create;
begin
  inherited Create;
  FEnabled := false;
  FColor := clBtnFace;
  FLightColor := $FFFFFF;
  FDarkColor := $000000;
end;

constructor TUThemeColorSet.Create(Color, LightColor, DarkColor: TColor);
begin
  inherited Create;
  SetColor(Color, LightColor, DarkColor);
end;

//  METHODS

procedure TUThemeColorSet.Assign(Source: TPersistent);
begin
  if Source is TUThemeColorSet then
    begin
      FEnabled := (Source as TUThemeColorSet).Enabled;
      FColor := (Source as TUThemeColorSet).Color;
      FLightColor := (Source as TUThemeColorSet).LightColor;
      FDarkColor := (Source as TUThemeColorSet).DarkColor;
    end
  else
    inherited;
end;

procedure TUThemeColorSet.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

//  UTILS

procedure TUThemeColorSet.SetColor(Color, LightColor, DarkColor: TColor);
begin
  FColor := Color;
  FLightColor := LightColor;
  FDarkColor := DarkColor;
  Changed;
end;

function TUThemeColorSet.GetColor(const TM: TUThemeManager): TColor;
begin
  if TM = nil then
    Result := Color
  else if TM.Theme = utLight then
    Result := LightColor
  else
    Result := DarkColor;
end;

initialization
  TOOLTIP_SHADOW := false;
  TOOLTIP_BORDER_THICKNESS := 1;
  TOOLTIP_FONT_NAME := 'Segoe UI';
  TOOLTIP_FONT_SIZE := 8;

  FORM_FONT_NAME := 'Segoe UI';
  FORM_FONT_SIZE := 10;

  TOOLTIP_BACK := TUThemeColorSet.Create(0, $F2F2F2, $2B2B2B);
  TOOLTIP_BORDER := TUThemeColorSet.Create(0, $CCCCCC, $767676);
  FORM_BACK := TUThemeColorSet.Create(0, $FFFFFF, $000000);
  PANEL_BACK := TUThemeColorSet.Create(0, $E6E6E6, $1F1F1F);

finalization
  TOOLTIP_BACK.Free;
  TOOLTIP_BORDER.Free;
  FORM_BACK.Free;
  PANEL_BACK.Free;


end.
