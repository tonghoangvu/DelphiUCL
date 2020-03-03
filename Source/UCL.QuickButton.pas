unit UCL.QuickButton;

interface

uses
  Classes, Types, Messages, Controls, Forms, Graphics,
  UCL.Classes, UCL.ThemeManager, UCL.Utils, UCL.Graphics, UCL.Colors;

type
  TUQuickButtonStyle = (qbsNone, qbsQuit, qbsMax, qbsMin, qbsHighlight);

  TUQuickButton = class(TUGraphicControl, IUControl)
    private
      var BackColor, TextColor: TColor;

      FCustomBackColor: TUThemeColorSet;
      FCustomAccentColor: TColor;

      FButtonState: TUControlState;
      FButtonStyle: TUQuickButtonStyle;

      //  Internal
      procedure UpdateColors;

      //  Child events
      procedure CustomBackColor_OnChange(Sender: TObject);

      //  Setters
      procedure SetButtonState(const Value: TUControlState);
      procedure SetButtonStyle(const Value: TUQuickButtonStyle);
      procedure SetCustomAccentColor(const Value: TColor);

      //  Messages
      procedure WM_LButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
      procedure WM_LButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
      procedure WM_LButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
      procedure CM_MouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure CM_MouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

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
      property CustomAccentColor: TColor read FCustomAccentColor write SetCustomAccentColor default $D77800;

      property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;
      property ButtonStyle: TUQuickButtonStyle read FButtonStyle write SetButtonStyle default qbsNone;

      //  Modify default props
      property Height default 32;
      property Width default 45;
      property Caption;
  end;

implementation

{ TUQuickButton }

//  INTERFACE

function TUQuickButton.IsContainer: Boolean;
begin
  Result := false;
end;

procedure TUQuickButton.UpdateTheme(const UpdateChildren: Boolean);
begin
  UpdateColors;
  Repaint;

  //  Do not update children
end;

//  INTERNAL

procedure TUQuickButton.UpdateColors;
var
  TM: TUThemeManager;
  _BackColor: TUThemeColorSet;
  IsDark: Boolean;
  BaseColor, AccentColor: TColor;
begin
  //  Prepairing
  TM := SelectThemeManager(Self);
  IsDark := (TM <> nil) and (TM.Theme = utDark);
  AccentColor := SelectAccentColor(TM, CustomAccentColor);

  //  Get background color
  if ButtonState = csNone then
    begin
      ParentColor := true;
      BackColor := Color;
    end
  else
    begin
      //  Select BaseColor
      case ButtonStyle of
        qbsQuit:
          BaseColor := $2311E8;
        qbsHighlight:
          BaseColor := AccentColor;
        else
          begin
            _BackColor := SelectColorSet(TM, CustomBackColor, QUICKBUTTON_BACK);
            if ButtonStyle = qbsQuit then
              BaseColor := $2311E8
            else
              BaseColor := _BackColor.GetColor(TM);
          end;
      end;

      //  Change BaseColor to BackColor
      case ButtonState of
        csHover:
          BackColor := BaseColor;
        csPress:
          if ButtonStyle in [qbsHighlight, qbsQuit] then
            begin
              BackColor := BrightenColor(BaseColor, 10);
            end
          else
            begin
              if not IsDark then
                BackColor := ColorChangeLightness(BaseColor, 160)
              else
                BackColor := ColorChangeLightness(BaseColor, 80);
            end;
      end;
    end;

  //  Get text color from background
  TextColor := GetTextColorFromBackground(BackColor);
end;

//  SETTERS

procedure TUQuickButton.SetButtonState(const Value: TUControlState);
begin
  if Value <> FButtonState then
    begin
      FButtonState := Value;
      UpdateColors;
      Repaint;
    end;
end;

procedure TUQuickButton.SetButtonStyle(const Value: TUQuickButtonStyle);
begin
  if Value <> FButtonStyle then
    begin
      FButtonStyle := Value;

      case Value of
        qbsNone, qbsHighlight:  //  Custom caption 
          ;
        qbsQuit:
          Caption := '';
        qbsMax:
          Caption := '';
        qbsMin:
          Caption := '';
      end;
    end;
end;

procedure TUQuickButton.SetCustomAccentColor(const Value: TColor);
begin
  if Value <> FCustomAccentColor then
    begin
      FCustomAccentColor := Value;
      UpdateColors;
      Repaint;
    end;
end;

//  CHILD EVENTS

procedure TUQuickButton.CustomBackColor_OnChange(Sender: TObject);
begin
  UpdateColors;
  Repaint;
end;

//  MAIN CLASS

constructor TUQuickButton.Create(aOwner: TComponent);
begin
  inherited;
  FButtonState := csNone;
  FButtonStyle := qbsNone;
  FCustomAccentColor := $D77800;

  FCustomBackColor := TUThemeColorSet.Create;
  FCustomBackColor.OnChange := CustomBackColor_OnChange;
  FCustomBackColor.Assign(QUICKBUTTON_BACK);

  //  Modify default props
  Caption := '';
  Font.Name := 'Segoe MDL2 Assets';
  Font.Size := 10;
  Height := 32;
  Width := 45;

  UpdateColors;
end;

destructor TUQuickButton.Destroy;
begin
  FCustomBackColor.Free;
  inherited;
end;

//  CUSTOM METHODS

procedure TUQuickButton.Paint;
begin
  inherited;

  //  Paint background
  if ButtonState <> csNone then
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
      Canvas.FillRect(Rect(0, 0, Width, Height));
    end;

  //  Draw text
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(Font);
  Canvas.Font.Color := TextColor;
  DrawTextRect(Canvas, taCenter, taVerticalCenter, Rect(0, 0, Width, Height), Caption, true);
end;

//  MESSAGES

procedure TUQuickButton.WM_LButtonDblClk(var Msg: TWMLButtonDblClk);
begin
  if not Enabled then exit;
  ButtonState := csPress;
  inherited;
end;

procedure TUQuickButton.WM_LButtonDown(var Msg: TWMLButtonDown);
begin
  if not Enabled then exit;
  ButtonState := csPress;
  inherited;
end;

procedure TUQuickButton.WM_LButtonUp(var Msg: TWMLButtonUp);
var
  ParentForm: TCustomForm;
  MousePoint: TPoint;
begin
  if not Enabled then exit;

  MousePoint := ScreenToClient(Mouse.CursorPos);
  if PtInRect(GetClientRect, MousePoint) then
    begin
      //  Default actions for Quit, Max, Min sysbutton
      if ButtonStyle in [qbsQuit, qbsMax, qbsMin] then
        begin
          ParentForm := GetParentForm(Self, true);
          case ButtonStyle of
            qbsQuit:
              ParentForm.Close;
            qbsMin:
              ParentForm.WindowState := wsMinimized;
            qbsMax:
              if ParentForm.WindowState <> wsNormal then
                ParentForm.WindowState := wsNormal
              else
                ParentForm.WindowState := wsMaximized;
          end;
        end;
    end;

  ButtonState := csHover;
  inherited;
end;

procedure TUQuickButton.CM_MouseEnter(var Msg: TMessage);
begin
  if not Enabled then exit;
  ButtonState := csHover;
  inherited;
end;

procedure TUQuickButton.CM_MouseLeave(var Msg: TMessage);
begin
  if not Enabled then exit;
  ButtonState := csNone;
  inherited;
end;

end.
