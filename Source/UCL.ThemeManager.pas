unit UCL.ThemeManager;

interface

uses
  Classes, Graphics,
  UCL.Classes, UCL.SystemSettings;

type
  TUThemeType = (ttAuto, ttLight, ttDark);
  TUAccentColorType = TColor;

  IUControl = interface
    ['{5098EF5C-0451-490D-A0B2-24C414F21A24}']
    function IsContainer: Boolean;
    procedure UpdateTheme(const UpdateChidlren: Boolean);
  end;

  TUThemeManager = class(TPersistent)
    private
      FTheme: TUTheme;
      FAccentColor: TColor;
      FColorOnBorder: Boolean;

      FThemeType: TUThemeType;
      FAccentColorType: TUAccentColorType;

      FOnChange: TNotifyEvent;

      procedure SetThemeType(const Value: TUThemeType);
      procedure SetAccentColorType(const Value: TUAccentColorType);

    protected
      procedure Changed;

    public
      constructor Create;
      procedure UpdateTheme;

      //  Custom methods
      procedure Assign(Source: TPersistent); override;

    published
      property Theme: TUTheme read FTheme stored false;
      property AccentColor: TColor read FAccentColor stored false;
      property ColorOnBorder: Boolean read FColorOnBorder stored false;

      property ThemeType: TUThemeType read FThemeType write SetThemeType default ttAuto;
      property AccentColorType: TUAccentColorType read FAccentColorType write SetAccentColorType default 0;

      property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

{ TUThemeManager }

//  SETTERS

procedure TUThemeManager.SetThemeType(const Value: TUThemeType);
begin
  if Value <> FThemeType then
    begin
      FThemeType := Value;
      case Value of
        ttAuto:
          if IsAppsUseDarkTheme then
            FTheme := utDark
          else
            FTheme := utLight;

        ttLight:
          FTheme := utLight;

        ttDark:
          FTheme := utDark;
      end;
      UpdateTheme;
    end;
end;

procedure TUThemeManager.SetAccentColorType(const Value: TUAccentColorType);
begin
  if Value <> FAccentColorType then
    begin
      FAccentColorType := Value;
      if Value = 0 then
        FAccentColor := GetAccentColor
      else
        FAccentColor := FAccentColorType;
      Changed;
    end;
end;

//  MAIN CLASS

constructor TUThemeManager.Create;
begin
  inherited;

  //  Default values
  FTheme := utLight;
  FAccentColor := $D77800;
  FColorOnBorder := false;

  FThemeType := ttAuto;
  FAccentColorType := 0;  //  Auto
end;

//  CUSTOM METHODS

procedure TUThemeManager.Assign(Source: TPersistent);
begin
  if Source is TUThemeManager then
    begin
      FThemeType := (Source as TUThemeManager).ThemeType;
      FAccentColorType := (Source as TUThemeManager).AccentColorType;

      FTheme := (Source as TUThemeManager).Theme;
      FAccentColor := (Source as TUThemeManager).AccentColor;
      FColorOnBorder := (Source as TUThemeManager).ColorOnBorder;

      Changed;
    end
  else
    inherited;
end;

//  UTILS

procedure TUThemeManager.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TUThemeManager.UpdateTheme;
begin
  //  Update auto theme
  if ThemeType = ttAuto then
    if IsAppsUseDarkTheme then
      FTheme := utDark
    else
      FTheme := utLight;

  //  Update system accent color
  if AccentColorType = 0 then
    FAccentColor := GetAccentColor;

  //  Update color on border settings
  FColorOnBorder := IsColorOnBorderEnabled;

  Changed;
end;


end.
