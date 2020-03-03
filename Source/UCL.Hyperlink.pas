unit UCL.Hyperlink;

interface

uses
  Classes, Windows, Messages, ShellAPI, Controls, StdCtrls, Graphics,
  UCL.Classes, UCL.ThemeManager, UCL.Colors;

type
  TUHyperlink = class(TLabel, IUControl)
    private
      FControlState: TUControlState;
      FCustomTextColor: TUStateColorSet;

      FEnabled: Boolean;
      FOpenLink: Boolean;   //  Open link or Click action?
      FURL: string;

      FOnOpenURL: TNotifyEvent;

      //  Setters
      procedure SetControlState(const Value: TUControlState);
      procedure SetEnabled(const Value: Boolean); reintroduce;

      //  Child events
      procedure CustomTextColor_OnChange(Sender: TObject);

      //  Messages
      procedure WM_LButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
      procedure WM_LButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
      procedure WM_LButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;

      procedure CM_MouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure CM_MouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      //  Interface
      function IsContainer: Boolean;
      procedure UpdateTheme(const UpdateChildren: Boolean);

    published
      property ControlState: TUControlState read FControlState write SetControlState default csNone;
      property CustomTextColor: TUStateColorSet read FCustomTextColor write FCustomTextColor;

      property Enabled: Boolean read FEnabled write SetEnabled default true;
      property OpenLink: Boolean read FOpenLink write FOpenLink default true;
      property URL: string read FURL write FURL;

      property OnOpenURL: TNotifyEvent read FOnOpenURL write FOnOpenURL;

      //  Modify default props
      property Cursor default crHandPoint;
  end;

implementation

{ TUHyperlink }

//  INTERFACE

function TUHyperlink.IsContainer: Boolean;
begin
  Result := false;
end;

procedure TUHyperlink.UpdateTheme(const UpdateChildren: Boolean);
var
  TM: TUThemeManager;
  _TextColor: TUStateColorSet;
begin
  //  Preparing
  TM := SelectThemeManager(Self);

  //  Update font color
  if not Enabled then
    Font.Color := $808080
  else if TM = nil then
    Font.Color := CustomTextColor.GetColor(TM, ControlState, false)
  else
    begin
      //  Get font color from color set
      _TextColor := SelectColorSet(TM, CustomTextColor, HYPERLINK_TEXT);
      if (ControlState = csNone) and (not CustomTextColor.Enabled) then
        Font.Color := TM.AccentColor
      else
        Font.Color := _TextColor.GetColor(TM, ControlState, false);
    end;
end;

//  SETTERS

procedure TUHyperlink.SetControlState(const Value: TUControlState);
begin
  if Value <> FControlState then
    begin
      FControlState := Value;
      UpdateTheme(true);
    end;
end;

procedure TUHyperlink.SetEnabled(const Value: Boolean);
begin
  if Value <> Enabled then
    begin
      FEnabled := Value;
      if not Value then
        Cursor := crDefault
      else
        Cursor := crHandPoint;
      UpdateTheme(true);
    end;
end;

//  CHILD EVENTS

procedure TUHyperlink.CustomTextColor_OnChange(Sender: TObject);
begin
  UpdateTheme(true);
end;

//  MAIN CLASS

constructor TUHyperlink.Create(aOwner: TComponent);
begin
  inherited;
  FControlState := csNone;
  FEnabled := true;
  FOpenLink := true;
  FURL := '';

  FCustomTextColor := TUStateColorSet.Create;
  FCustomTextColor.OnChange := CustomTextColor_OnChange;
  FCustomTextColor.Assign(HYPERLINK_TEXT);

  //  Modify default props
  Cursor := crHandPoint;
  Font.Name := HYPERLINK_FONT_NAME;
  Font.Size := HYPERLINK_FONT_SIZE;

  UpdateTheme(true);
end;

destructor TUHyperlink.Destroy;
begin
  FCustomTextColor.Free;
  inherited;
end;

//  MESSAGES

procedure TUHyperlink.WM_LButtonDblClk(var Msg: TWMLButtonDblClk);
begin
  if not Enabled then exit;
  ControlState := csPress;
  inherited;
end;

procedure TUHyperlink.WM_LButtonDown(var Msg: TWMLButtonDown);
begin
  if not Enabled then exit;
  ControlState := csPress;
  inherited;
end;

procedure TUHyperlink.WM_LButtonUp(var Msg: TWMLButtonUp);
begin
  if not Enabled then exit;
  ControlState := csHover;
  if OpenLink and (URL <> '') then
    begin
      if Assigned(FOnOpenURL) then
        FOnOpenURL(Self);
      ShellExecute(0, '', PWideChar(URL), '', '', SW_SHOWNORMAL);
    end;
  inherited;
end;

procedure TUHyperlink.CM_MouseEnter(var Msg: TMessage);
begin
  if not Enabled then exit;
  ControlState := csHover;
  inherited;
end;

procedure TUHyperlink.CM_MouseLeave(var Msg: TMessage);
begin
  if not Enabled then exit;
  ControlState := csNone;
  inherited;
end;

end.
