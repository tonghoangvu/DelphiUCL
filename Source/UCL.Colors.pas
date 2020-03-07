unit UCL.Colors;

interface

uses
  Classes, Graphics, Controls,
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

  TUStateColorSet = class(TPersistent)
    private
      FEnabled: Boolean;

      FLightNone: TColor;
      FLightHover: TColor;
      FLightPress: TColor;
      FLightSelectedNone: TColor;
      FLightSelectedHover: TColor;
      FLightSelectedPress: TColor;

      FDarkNone: TColor;
      FDarkHover: TColor;
      FDarkPress: TColor;
      FDarkSelectedNone: TColor;
      FDarkSelectedHover: TColor;
      FDarkSelectedPress: TColor;

      FOnChange: TNotifyEvent;

      procedure SetEnabled(const Value: Boolean);
      procedure SetStateColor(Index: Integer; const Value: TColor);

    protected
      procedure Changed;

    public
      constructor Create;
      procedure Assign(Source: TPersistent); override;

      procedure SetLightColor(None, Hover, Press, SNone, SHover, SPress: TColor);
      procedure SetDarkColor(None, Hover, Press, SNone, SHover, SPress: TColor);
      function GetColor(const TM: TUThemeManager; State: TUControlState; IsSelected: Boolean): TColor;

    published
      property Enabled: Boolean read FEnabled write SetEnabled;   //  No default

      property LightNone: TColor index 0 read FLightNone write SetStateColor;
      property LightHover: TColor index 1 read FLightHover write SetStateColor;
      property LightPress: TColor index 2 read FLightPress write SetStateColor;
      property LightSelectedNone: TColor index 3 read FLightSelectedNone write SetStateColor;
      property LightSelectedHover: TColor index 4 read FLightSelectedHover write SetStateColor;
      property LightSelectedPress: TColor index 5 read FLightSelectedPress write SetStateColor;

      property DarkNone: TColor index 6 read FDarkNone write SetStateColor;
      property DarkHover: TColor index 7 read FDarkHover write SetStateColor;
      property DarkPress: TColor index 8 read FDarkPress write SetStateColor;
      property DarkSelectedNone: TColor index 9 read FDarkSelectedNone write SetStateColor;
      property DarkSelectedHover: TColor index 10 read FDarkSelectedHover write SetStateColor;
      property DarkSelectedPress: TColor index 11 read FDarkSelectedPress write SetStateColor;

      property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

var
  //  Tooltip
  TOOLTIP_SHADOW: Boolean;
  TOOLTIP_BORDER_THICKNESS: Byte;
  TOOLTIP_FONT_NAME: string;
  TOOLTIP_FONT_SIZE: Byte;
  TOOLTIP_BACK: TUThemeColorSet;
  TOOLTIP_BORDER: TUThemeColorSet;

  //  Form
  FORM_FONT_NAME: string;
  FORM_FONT_SIZE: Byte;
  FORM_BACK: TUThemeColorSet;

  //  Progress bar
  PROGRESSBAR_BACK: TUThemeColorSet;

  //  Panel
  PANEL_BACK: TUThemeColorSet;

  //  Scrollbox
  SCROLLBOX_BACK: TUThemeColorSet;

  //  Caption bar
  CAPTIONBAR_BACK: TUThemeColorSet;

  //  Button
  BUTTON_BACK: TUStateColorSet;
  BUTTON_BORDER: TUStateColorSet;

  //  List button
  LISTBUTTON_BACK: TUStateColorSet;

  //  Quick button
  QUICKBUTTON_BACK: TUThemeColorSet;

  //  Slider
  SLIDER_BACK: TUStateColorSet;
  SLIDER_CURSOR: TUStateColorSet;

  //  Hyperlink
  HYPERLINK_FONT_NAME: string;
  HYPERLINK_FONT_SIZE: Byte;
  HYPERLINK_TEXT: TUStateColorSet;

  //  Edit
  EDIT_BACK: TUThemeColorSet;
  EDIT_BORDER: TUStateColorSet;

function SelectThemeManager(Control: TControl): TUThemeManager;
function SelectColorSet(const TM: TUThemeManager;
  CustomColorset, DefaultColorset: TUThemeColorSet): TUThemeColorSet; overload;
function SelectColorSet(const TM: TUThemeManager;
  CustomColorset, DefaultColorset: TUStateColorSet): TUStateColorSet; overload;
function SelectAccentColor(const TM: TUThemeManager; CustomAccentColor: TColor): TColor;

implementation

uses
  Forms,
  UCL.Form;

{ Utils }

function SelectThemeManager(Control: TControl): TUThemeManager;
var
  ParentForm: TCustomForm;
begin
  ParentForm := GetParentForm(Control, true);
  if (ParentForm <> nil) and (ParentForm is TUForm) then
    Result := (ParentForm as TUForm).ThemeManager
  else
    Result := nil;
end;

function SelectColorSet(const TM: TUThemeManager;
  CustomColorset, DefaultColorset: TUThemeColorSet): TUThemeColorSet;
begin
  if CustomColorset = nil then exit(nil);

  if (TM = nil) or (CustomColorset.Enabled) then
    Result := CustomColorset
  else
    Result := DefaultColorset;
end;

function SelectColorSet(const TM: TUThemeManager;
  CustomColorset, DefaultColorset: TUStateColorSet): TUStateColorSet;
begin
  if CustomColorset = nil then exit(nil);

  if (TM = nil) or (CustomColorset.Enabled) then
    Result := CustomColorset
  else
    Result := DefaultColorset;
end;

function SelectAccentColor(const TM: TUThemeManager; CustomAccentColor: TColor): TColor;
begin
  if TM = nil then
    Result := CustomAccentColor
  else
    Result := TM.AccentColor;
end;

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
        FColor := Value;
    1:
      if Value <> FLightColor then
        FLightColor := Value;
    2:
      if Value <> FDarkColor then
        FDarkColor := Value;
  end;

  if Index in [0..2] then
    Changed;
end;

//  MAIN CLASS

constructor TUThemeColorSet.Create;
begin
  inherited;
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

{ TUStateColorSet }

//  SETTERS

procedure TUStateColorSet.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
    begin
      FEnabled := Value;
      Changed;
    end;
end;

procedure TUStateColorSet.SetStateColor(Index: Integer; const Value: TColor);
begin
  case Index of
    0:
      if Value <> FLightNone then
        FLightNone := Value;
    1:
      if Value <> FLightHover then
        FLightHover := Value;
    2:
      if Value <> FLightPress then
        FLightPress := Value;
    3:
      if Value <> FLightSelectedNone then
        FLightSelectedNone := Value;
    4:
      if Value <> FLightSelectedHover then
        FLightSelectedHover := Value;
    5:
      if Value <> FLightSelectedPress then
        FLightSelectedPress := Value;

    6:
      if Value <> FDarkNone then
        FDarkNone := Value;
    7:
      if Value <> FDarkHover then
        FDarkHover := Value;
    8:
      if Value <> FDarkPress then
        FDarkPress := Value;
    9:
      if Value <> FDarkSelectedNone then
        FDarkSelectedNone := Value;
    10:
      if Value <> FDarkSelectedHover then
        FDarkSelectedHover := Value;
    11:
      if Value <> FDarkSelectedPress then
        FDarkSelectedPress := Value;
  end;

  if Index in [0..11] then
    Changed;
end;

//  MAIN CLASS

constructor TUStateColorSet.Create;
begin
  inherited;
  FEnabled := false;
  FLightNone := $F2F2F2;
  FLightHover := $E6E6E6;
  FLightPress := $CCCCCC;
  FLightSelectedNone := $F2F2F2;
  FLightSelectedHover := $E6E6E6;
  FLightSelectedPress := $CCCCCC;
  FDarkNone := $2B2B2B;
  FDarkHover := $333333;
  FDarkPress := $3B3B3B;
  FDarkSelectedNone := $2B2B2B;
  FDarkSelectedHover := $333333;
  FDarkSelectedPress := $3B3B3B;
end;

//  METHODS

procedure TUStateColorSet.Assign(Source: TPersistent);
begin
  if Source is TUStateColorSet then
    begin
      FEnabled := (Source as TUStateColorSet).Enabled;

      FLightNone := (Source as TUStateColorSet).LightNone;
      FLightHover := (Source as TUStateColorSet).LightHover;
      FLightPress := (Source as TUStateColorSet).LightPress;
      FLightSelectedNone := (Source as TUStateColorSet).LightSelectedNone;
      FLightSelectedHover := (Source as TUStateColorSet).LightSelectedHover;
      FLightSelectedPress := (Source as TUStateColorSet).LightSelectedPress;

      FDarkNone := (Source as TUStateColorSet).DarkNone;
      FDarkHover := (Source as TUStateColorSet).DarkHover;
      FDarkPress := (Source as TUStateColorSet).DarkPress;
      FDarkSelectedNone := (Source as TUStateColorSet).DarkSelectedNone;
      FDarkSelectedHover := (Source as TUStateColorSet).DarkSelectedHover;
      FDarkSelectedPress := (Source as TUStateColorSet).DarkSelectedPress;
    end
  else
    inherited;
end;

procedure TUStateColorSet.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

//  UTILS

procedure TUStateColorSet.SetLightColor(None, Hover, Press, SNone, SHover,
  SPress: TColor);
begin
  FLightNone := None;
  FLightHover := Hover;
  FLightPress := Press;
  FLightSelectedNone := SNone;
  FLightSelectedHover := SHover;
  FLightSelectedPress := SPress;
  Changed;
end;

procedure TUStateColorSet.SetDarkColor(None, Hover, Press, SNone, SHover,
  SPress: TColor);
begin
  FDarkNone := None;
  FDarkHover := Hover;
  FDarkPress := Press;
  FDarkSelectedNone := SNone;
  FDarkSelectedHover := SHover;
  FDarkSelectedPress := SPress;
  Changed;
end;

function TUStateColorSet.GetColor(const TM: TUThemeManager;
  State: TUControlState; IsSelected: Boolean): TColor;
var
  ResultCode: Byte;
begin
  ResultCode := 0;

  //  Calculating color index
  if (TM <> nil) and (TM.Theme = utDark) then
    inc(ResultCode, 6);   //  Skip 6 light color

  if IsSelected then
    inc(ResultCode, 3);   //  Skip more 3 dark not selected color

  inc(ResultCode, Ord(State));

  //  Get color by index
  case ResultCode of
    0:
      Result := LightNone;
    1:
      Result := LightHover;
    2:
      Result := LightPress;
    3:
      Result := LightSelectedNone;
    4:
      Result := LightSelectedHover;
    5:
      Result := LightSelectedPress;
    6:
      Result := DarkNone;
    7:
      Result := DarkHover;
    8:
      Result := DarkPress;
    9:
      Result := DarkSelectedNone;
    10:
      Result := DarkSelectedHover;
    11:
      Result := DarkSelectedPress;
    else
      Result := 0;
  end;
end;

initialization
  //  Tooltip
  TOOLTIP_SHADOW := false;
  TOOLTIP_BORDER_THICKNESS := 1;
  TOOLTIP_FONT_NAME := 'Segoe UI';
  TOOLTIP_FONT_SIZE := 8;
  TOOLTIP_BACK := TUThemeColorSet.Create(0, $F2F2F2, $2B2B2B);
  TOOLTIP_BORDER := TUThemeColorSet.Create(0, $CCCCCC, $767676);

  //  Form
  FORM_FONT_NAME := 'Segoe UI';
  FORM_FONT_SIZE := 10;
  FORM_BACK := TUThemeColorSet.Create(0, $FFFFFF, $000000);

  //  Progress bar
  PROGRESSBAR_BACK := TUThemeColorSet.Create($E6E6E6, $CCCCCC, $333333);

  //  Panel
  PANEL_BACK := TUThemeColorSet.Create($E6E6E6, $E6E6E6, $1F1F1F);

  //  Scrollbox
  SCROLLBOX_BACK := TUThemeColorSet.Create($E6E6E6, $E6E6E6, $1F1F1F);

  //  Caption bar
  CAPTIONBAR_BACK := TUThemeColorSet.Create($F2F2F2, $F2F2F2, $2B2B2B);

  //  Button
  BUTTON_BACK := TUStateColorSet.Create;
  BUTTON_BACK.SetLightColor($CCCCCC, $CCCCCC, $999999, $CCCCCC, $CCCCCC, $999999);
  BUTTON_BACK.SetDarkColor($333333, $333333, $666666, $333333, $333333, $666666);
  BUTTON_BORDER := TUStateColorSet.Create;
  BUTTON_BORDER.SetLightColor($CCCCCC, $7A7A7A, $999999, $7A7A7A, $7A7A7A, $999999);
  BUTTON_BORDER.SetDarkColor($333333, $858585, $666666, $858585, $858585, $666666);

  //  List button
  LISTBUTTON_BACK := TUStateColorSet.Create;
  LISTBUTTON_BACK.SetLightColor($E6E6E6, $CFCFCF, $B8B8B8, 127, 103, 89);
  LISTBUTTON_BACK.SetDarkColor($1F1F1F, $353535, $4C4C4C, 89, 103, 127);

  //  Quick button
  QUICKBUTTON_BACK := TUThemeColorSet.Create(0, $CFCFCF, $3C3C3C);

  //  Slider
  SLIDER_BACK := TUStateColorSet.Create;
  SLIDER_BACK.SetLightColor($999999, $666666, $999999, $999999, $666666, $999999);
  SLIDER_BACK.SetDarkColor($666666, $999999, $666666, $666666, $999999, $666666);
  SLIDER_CURSOR := TUStateColorSet.Create;
  SLIDER_CURSOR.SetLightColor($D77800, $171717, $CCCCCC, $D77800, $171717, $CCCCCC);
  SLIDER_CURSOR.SetDarkColor($D77800, $F2F2F2, $767676, $D77800, $F2F2F2, $767676);

  //  Hyperlink
  HYPERLINK_FONT_NAME := 'Segoe UI';
  HYPERLINK_FONT_SIZE := 10;
  HYPERLINK_TEXT := TUStateColorSet.Create;
  HYPERLINK_TEXT.SetLightColor($D77800, clGray, clMedGray, $D77800, clGray, clMedGray);
  HYPERLINK_TEXT.SetDarkColor($D77800, clMedGray, clGray, $D77800, clMedGray, clGray);

  //  Edit
  EDIT_BACK := TUThemeColorSet.Create($FFFFFF, $FFFFFF, $000000);
  EDIT_BORDER := TUStateColorSet.Create;
  EDIT_BORDER.SetLightColor($999999, $666666, $D77800, $D77800, $D77800, $D77800);
  EDIT_BORDER.SetDarkColor($666666, $999999, $D77800, $D77800, $D77800, $D77800);

finalization
  TOOLTIP_BACK.Free;
  TOOLTIP_BORDER.Free;

  FORM_BACK.Free;

  PROGRESSBAR_BACK.Free;

  PANEL_BACK.Free;

  SCROLLBOX_BACK.Free;

  CAPTIONBAR_BACK.Free;

  BUTTON_BACK.Free;
  BUTTON_BORDER.Free;

  LISTBUTTON_BACK.Free;

  QUICKBUTTON_BACK.Free;

  SLIDER_BACK.Free;
  SLIDER_CURSOR.Free;

  HYPERLINK_TEXT.Free;

  EDIT_BACK.Free;
  EDIT_BORDER.Free;

end.
