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

      property Color stored false;
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
  TM: TUThemeManager;
  _BackColor: TUThemeColorSet;
  i: Integer;
begin
  TM := SelectThemeManager(Self);

  //  Update back color
  _BackColor := SelectColorSet(TM, CustomBackColor, PANEL_BACK);
  Color := _BackColor.GetColor(TM);

  //  Update text color (depends on BackColor)
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
