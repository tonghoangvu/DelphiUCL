unit UCL.Panel;

interface

uses
  Classes, SysUtils, Controls, ExtCtrls, Windows, Forms, Graphics,
  UCL.Classes, UCL.ThemeManager, UCL.Colors, UCL.Utils;

type
  TUPanel = class(TPanel, IUControl)
    private
      FCustomBackColor: TUThemeColorSet;

      //  Child events
      procedure CustomBackColor_OnChange(Sender: TObject);

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
  UCL.Form;

{ TUPanel }

//  INTERFACE

function TUPanel.IsContainer: Boolean;
begin
  Result := true;
end;

procedure TUPanel.UpdateTheme(const UpdateChildren: Boolean);
var
  i: Integer;

  ParentForm: TCustomForm;
  TM: TUThemeManager;
  _BackColor: TUThemeColorSet;
begin
  //  Select style
  ParentForm := GetParentForm(Self, true);
  if ParentForm is TUForm then
    TM := (ParentForm as TUForm).ThemeManager
  else
    TM := nil;
  if (TM = nil) or (CustomBackColor.Enabled) then
    _BackColor := CustomBackColor
  else
    _BackColor := PANEL_BACK;

  //  Get values from style
  Color := _BackColor.GetColor(TM);
  Font.Color := GetTextColorFromBackground(Color);

  //  Update children
  if IsContainer and UpdateChildren then
    for i := 0 to ControlCount - 1 do
      if Supports(Controls[i], IUControl) then
        (Controls[i] as IUControl).UpdateTheme(UpdateChildren);
end;

//  CHILD EVENTS

procedure TUPanel.CustomBackColor_OnChange(Sender: TObject);
begin
  UpdateTheme(true);
end;

//  MAIN CLASS

constructor TUPanel.Create(aOwner: TComponent);
begin
  inherited;
  FCustomBackColor := TUThemeColorSet.Create;
  FCustomBackColor.OnChange := CustomBackColor_OnChange;
  FCustomBackColor.Assign(PANEL_BACK);

  //  Modify props
  BevelOuter := bvNone;
  ParentBackground := false;
end;

destructor TUPanel.Destroy;
begin
  FCustomBackColor.Free;
  inherited;
end;

end.
