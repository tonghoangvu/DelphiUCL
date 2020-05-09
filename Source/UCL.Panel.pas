unit UCL.Panel;

interface

uses
  Classes, SysUtils, Controls, ExtCtrls, Windows, Forms, Graphics,
  UCL.Classes, UCL.ThemeManager, UCL.Colors, UCL.Utils;

type
  TUPanel = class(TPanel, IUControl)
    private
      var AccentColor, BackColor, TextColor: TColor;

      FBarMargin: Integer;
      FBarPosition: TUDirection;
      FBarThickness: Integer;
      FBarVisible: Boolean;
      FCustomAccentColor: TColor;
      FCustomBackColor: TUThemeColorSet;
      FTransparent: Boolean;

      //  Internal
      procedure UpdateColors;

      //  Setters
      procedure SetBarMargin(const Value: Integer);
      procedure SetBarPosition(const Value: TUDirection);
      procedure SetBarThickness(const Value: Integer);
      procedure SetBarVisible(const Value: Boolean);
      procedure SetCustomAccentColor(const Value: TColor);
      procedure SetTransparent(const Value: Boolean);

      //  Child events
      procedure CustomBackColor_OnChange(Sender: TObject);

    protected
      procedure Paint; override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      //  Interface
      function IsContainer: Boolean;
      procedure UpdateTheme(const UpdateChildren: Boolean);

    published
      property BarMargin: Integer read FBarMargin write SetBarMargin default 10;
      property BarPosition: TUDirection read FBarPosition write SetBarPosition default dLeft;
      property BarThickness: Integer read FBarThickness write SetBarThickness default 5;
      property BarVisible: Boolean read FBarVisible write SetBarVisible default false;
      property CustomAccentColor: TColor read FCustomAccentColor write SetCustomAccentColor default $D77800;
      property CustomBackColor: TUThemeColorSet read FCustomBackColor write FCustomBackColor;
      property Transparent: Boolean read FTransparent write SetTransparent default false;

      //  Modify props
      property BevelOuter default bvNone;
      property ParentBackground default false;
      property FullRepaint default false;
  end;

implementation

uses
  UCL.Form, UCL.Graphics;

{ TUPanel }

//  INTERFACE

function TUPanel.IsContainer: Boolean;
begin
  Result := true;
end;

procedure TUPanel.UpdateTheme(const UpdateChildren: Boolean);
var
  i: Integer;
begin
  UpdateColors;
  Invalidate;

  //  Update children
  if IsContainer and UpdateChildren then
    for i := 0 to ControlCount - 1 do
      if Supports(Controls[i], IUControl) then
        (Controls[i] as IUControl).UpdateTheme(UpdateChildren);
end;

//  INTERNAL

procedure TUPanel.UpdateColors;
var
  TM: TUThemeManager;
  _BackColor: TUThemeColorSet;
begin
  //  Preparing
  TM := SelectThemeManager(Self);

  //  Update accent color
  AccentColor := SelectAccentColor(TM, CustomAccentColor);

  //  Update back color
  _BackColor := SelectColorSet(TM, CustomBackColor, PANEL_BACK);
  BackColor := _BackColor.GetColor(TM);

  //  Update text color (depends on BackColor)
  TextColor := GetTextColorFromBackground(BackColor);

  //  Update Color for container (let children using ParentColor)
  Color := BackColor;
end;

//  SETTERS

procedure TUPanel.SetBarMargin(const Value: Integer);
begin
  if Value <> FBarMargin then
    begin
      FBarMargin := Value;
      Invalidate;
    end;
end;

procedure TUPanel.SetBarPosition(const Value: TUDirection);
begin
  if Value <> FBarPosition then
    begin
      FBarPosition := Value;
      Invalidate;
    end;
end;

procedure TUPanel.SetBarThickness(const Value: Integer);
begin
  if Value <> FBarThickness then
    begin
      FBarThickness := Value;
      Invalidate;
    end;
end;

procedure TUPanel.SetBarVisible(const Value: Boolean);
begin
  if Value <> FBarVisible then
    begin
      FBarVisible := Value;
      Invalidate;
    end;
end;

procedure TUPanel.SetCustomAccentColor(const Value: TColor);
begin
  if Value <> FCustomAccentColor then
    begin
      FCustomAccentColor := Value;
      Invalidate;
    end;
end;

procedure TUPanel.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then
    begin
      FTransparent := Value;
      ParentBackground := Value;
      Invalidate;
    end;
end;

//  CHILD EVENTS

procedure TUPanel.CustomBackColor_OnChange(Sender: TObject);
begin
  //  For container
  UpdateTheme(true);
end;

//  MAIN CLASS

constructor TUPanel.Create(aOwner: TComponent);
begin
  inherited;
  AccentColor := $D77800;
  BackColor := $E6E6E6;
  TextColor := GetTextColorFromBackground(BackColor);

  FBarMargin := 10;
  FBarPosition := dLeft;
  FBarThickness := 5;
  FBarVisible := false;

  FCustomAccentColor := $D77800;

  FCustomBackColor := TUThemeColorSet.Create;
  FCustomBackColor.OnChange := CustomBackColor_OnChange;
  FCustomBackColor.Assign(PANEL_BACK);
  FTransparent := false;

  //  Modify props
  BevelOuter := bvNone;
  ParentBackground := false;
  FullRepaint := false;

  Color := $E6E6E6;
end;

destructor TUPanel.Destroy;
begin
  FCustomBackColor.Free;
  inherited;
end;

//  CUSTOM METHODS

procedure TUPanel.Paint;
var
  BarRect: TRect;
begin
  //  Do not inherited

  //  Paint background
  if not Transparent then
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := BackColor;
      Canvas.FillRect(Rect(0, 0, Width, Height));
    end;

  //  Paint bar
  if BarVisible then
    begin
      Canvas.Brush.Color := AccentColor;
      case BarPosition of
        dLeft:
          BarRect := Rect(0, BarMargin, BarThickness, Height - BarMargin);
        dTop:
          BarRect := Rect(BarMargin, 0, Width - BarMargin, BarThickness);
        dRight:
          BarRect := Rect(Width - BarThickness, BarMargin, Width, Height - BarMargin);
        dBottom:
          BarRect := Rect(BarMargin, Height - BarThickness, Width - BarMargin, Height);
      end;
      Canvas.FillRect(BarRect);
    end;

  //  Paint text
  if ShowCaption then
    begin
      Canvas.Font.Assign(Font);
      Canvas.Font.Color := TextColor;
      Canvas.Brush.Style := bsClear;
      DrawTextRect(Canvas, Alignment, VerticalAlignment, Rect(0, 0, Width, Height), Caption, false);
    end;
end;

end.
