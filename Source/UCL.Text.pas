unit UCL.Text;

interface

uses
  Classes, Windows, Controls, StdCtrls, Graphics,
  UCL.Classes, UCL.ThemeManager, UCL.Colors;

type
  TUTextKind = (tkCustom, tkNormal, tkDescription, tkEntry, tkHeading, tkTitle);

  TUText = class(TLabel, IUControl)
    private
      var LastFont: TFont;

      FEnabled: Boolean;
      FTextKind: TUTextKind;
      FUseAccentColor: Boolean;

      //  Setters
      procedure SetEnabled(const Value: Boolean); reintroduce;
      procedure SetTextKind(const Value: TUTextKind);
      procedure SetUseAccentColor(const Value: Boolean);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      //  Interface
      function IsContainer: Boolean;
      procedure UpdateTheme(const UpdateChildren: Boolean);

    published
      property Enabled: Boolean read FEnabled write SetEnabled default true;
        //  Override custom Enabled to fix double shadow on disabled text in dark theme
      property TextKind: TUTextKind read FTextKind write SetTextKind default tkCustom;
      property UseAccentColor: Boolean read FUseAccentColor write SetUseAccentColor default false;
  end;

implementation

{ TUText }

//  INTERFACE

function TUText.IsContainer: Boolean;
begin
  Result := false;
end;

procedure TUText.UpdateTheme(const UpdateChildren: Boolean);
var
  TM: TUThemeManager;
begin
  TM := SelectThemeManager(Self);

  //  Disabled or desciption
  if (not Enabled) or (TextKind = tkDescription) then
    Font.Color := $666666

  //  Accent color
  else if UseAccentColor then
    Font.Color := SelectAccentColor(TM, $D77800)

  //  Light theme
  else if (TM = nil) or (TM.Theme = utLight) then
    Font.Color := $000000

  //  Dark theme
  else
    Font.Color := $FFFFFF;

  //  Do not update children
end;

//  SETTERS

procedure TUText.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
    begin
      FEnabled := Value;
      UpdateTheme(true);
    end;
end;

procedure TUText.SetTextKind(const Value: TUTextKind);
begin
  if Value <> FTextKind then
    begin
      //  Save current font
      if FTextKind = tkCustom then
        LastFont.Assign(Font);

      FTextKind := Value;

      if Value = tkCustom then
        //  Load the last saved font
        Font.Assign(LastFont)
      else
        begin
          //  Font name
          if Value = tkEntry then
            Font.Name := 'Segoe UI Semibold'
          else
            Font.Name := 'Segoe UI';

          //  Font size
          case Value of
            tkNormal:
              Font.Size := 10;
            tkDescription:
              Font.Size := 9;
            tkEntry:
              Font.Size := 10;
            tkHeading:
              Font.Size := 15;
            tkTitle:
              Font.Size := 21;
          end;
        end;

      UpdateTheme(true);
    end;
end;

procedure TUText.SetUseAccentColor(const Value: Boolean);
begin
  if Value <> FUseAccentColor then
    begin
      FUseAccentColor := Value;
      UpdateTheme(true);
    end;
end;

//  MAIN CLASS

constructor TUText.Create(aOwner: TComponent);
begin
  inherited;
  FEnabled := true;
  FTextKind := tkCustom;
  FUseAccentColor := false;

  LastFont := TFont.Create;
end;

destructor TUText.Destroy;
begin
  LastFont.Free;
  inherited;
end;

end.
