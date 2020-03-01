unit UCL.Panel;

interface

uses
  Classes, SysUtils, Controls, ExtCtrls, Windows, Forms, Graphics,
  UCL.Classes, UCL.ThemeManager, UCL.Colors, UCL.Utils;

type
  TUPanel = class(TPanel, IUControl)
    private
      var BackColor, TextColor: TColor;

      FCustomBackColor: TUThemeColorSet;

      //  Internal
      procedure UpdateColors;

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
      property CustomBackColor: TUThemeColorSet read FCustomBackColor write FCustomBackColor;

      //  Modify props
      property BevelOuter default bvNone;
      property ParentBackground default false;
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
  Repaint;

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
  TM := SelectThemeManager(Self);

  //  Update back color
  _BackColor := SelectColorSet(TM, CustomBackColor, PANEL_BACK);
  BackColor := _BackColor.GetColor(TM);

  //  Update text color (depends on BackColor)
  TextColor := GetTextColorFromBackground(BackColor);
end;

//  CHILD EVENTS

procedure TUPanel.CustomBackColor_OnChange(Sender: TObject);
begin
  UpdateColors;
  Repaint;
end;

//  MAIN CLASS

constructor TUPanel.Create(aOwner: TComponent);
begin
  inherited;
  BackColor := $E6E6E6;
  TextColor := GetTextColorFromBackground(BackColor);

  FCustomBackColor := TUThemeColorSet.Create;
  FCustomBackColor.OnChange := CustomBackColor_OnChange;
  FCustomBackColor.Assign(PANEL_BACK);

  //  Modify props
  BevelOuter := bvNone;
  ParentBackground := false;

  Color := $E6E6E6;
end;

destructor TUPanel.Destroy;
begin
  FCustomBackColor.Free;
  inherited;
end;

//  CUSTOM METHODS

procedure TUPanel.Paint;
begin
  //  Paint background
  Canvas.Brush.Color := BackColor;
  Canvas.FillRect(Rect(0, 0, Width, Height));

  //  Paint text
  if ShowCaption then
    begin
      Canvas.Font.Assign(Font);
      Canvas.Font.Color := TextColor;
      DrawTextRect(Canvas, Alignment, VerticalAlignment, Rect(0, 0, Width, Height), Caption, false);
    end;
end;

end.
