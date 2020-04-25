unit UCL.HoverPanel;

interface

uses
  Classes, SysUtils, Types, Graphics, Controls, Messages,
  UCL.Classes, UCL.ThemeManager, UCL.Graphics, UCL.Utils;

type
  TIndexNotifyEvent = procedure (Sender: TObject; Index: Integer) of object;

  TUHoverPanel = class(TUGraphicControl)
    private
      var IconIndex, LastIconIndex: Integer;
      var IsDown: Boolean;

      FAlignOnClip: TAlign;
      FIcons: string;
      FIconWidth: Integer;
      FIconClick: TIndexNotifyEvent;

      //  Setters
      procedure SetAlignOnClip(const Value: TAlign);
      procedure SetIcons(const Value: string);
      procedure SetIconWidth(const Value: Integer);

      //  Messages
      procedure WM_LButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
      procedure WM_LButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
      procedure WM_MouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
      procedure CM_MouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

    protected
      procedure Paint; override;

    public
      constructor Create(aOwner: TComponent); override;

      procedure ClipTo(Parent: TWinControl);
      procedure Release;

    published
      property AlignOnClip: TAlign read FAlignOnClip write SetAlignOnClip default alRight;
      property Icons: string read FIcons write SetIcons nodefault;
      property IconWidth: Integer read FIconWidth write SetIconWidth default 35;
      property IconClick: TIndexNotifyEvent read FIconClick write FIconClick;
      property Color stored false;
  end;

implementation

{ TUHoverPanel }

//  SETTERS

procedure TUHoverPanel.SetAlignOnClip(const Value: TAlign);
begin
  if Value <> FAlignOnClip then
    begin
      FAlignOnClip := Value;
      if Visible then
        Align := Value;
    end;
end;

procedure TUHoverPanel.SetIcons(const Value: string);
begin
  if Value <> FIcons then
    begin
      FIcons := Value;
      if Visible then
        Repaint;
    end;
end;

procedure TUHoverPanel.SetIconWidth(const Value: Integer);
begin
  if Value <> FIconWidth then
    begin
      FIconWidth := Value;
      if Visible then
        Repaint;
    end;
end;

//  MAIN CLASS

constructor TUHoverPanel.Create(aOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csDoubleClicks];

  IconIndex := -1;
  LastIconIndex := -1;
  IsDown := false;

  FAlignOnClip := alRight;
  FIcons := '';
  FIconWidth := 35;

  ParentColor := true;
  Font.Name := 'Segoe MDL2 Assets';
  Font.Size := 12;
  Height := 40;
  Width := 70;
  Visible := false;
end;

//  CSUTOM METHODS

procedure TUHoverPanel.Paint;
var
  IconRect: TRect;
  i: Integer;
begin
  inherited;
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(Font);

  for i := 0 to Length(Icons) - 1 do
    begin
      if i = IconIndex then
        begin
          if IsDown then
            IconRect := Rect(i * IconWidth, 0, (i + 1) * IconWidth, Height - 6)
          else
            IconRect := Rect(i * IconWidth, 0, (i + 1) * IconWidth, Height - 10);
        end
      else
        IconRect := Rect(i * IconWidth, 0, (i + 1) * IconWidth, Height);
      DrawTextRect(Canvas, taCenter, taVerticalCenter, IconRect, Icons[i + 1], false);
    end;
end;

//  UTILS

procedure TUHoverPanel.ClipTo(Parent: TWinControl);
begin
  Self.Parent := Parent;
  Visible := true;
  Align := AlignOnClip;
  ParentColor := true;
end;

procedure TUHoverPanel.Release;
begin
  Self.Parent := nil;
  Visible := false;
end;

//  MESSAGES

procedure TUHoverPanel.WM_LButtonDown(var Msg: TWMLButtonDown);
begin
  inherited;
  IsDown := true;
  Repaint;
end;

procedure TUHoverPanel.WM_LButtonUp(var Msg: TWMLButtonUp);
var
  MousePoint: TPoint;
begin
  inherited;

  MousePoint := ScreenToClient(Mouse.CursorPos);
  if PtInRect(GetClientRect, MousePoint) then
    begin
      if (IconIndex <> -1) and Assigned(FIconClick) then
        FIconClick(Self, IconIndex);
    end;
  IsDown := false;
  Repaint;
end;

procedure TUHoverPanel.WM_MouseMove(var Msg: TWMMouseMove);
begin
  inherited;
  IconIndex := Msg.XPos div IconWidth;
  if IconIndex <> LastIconIndex then
    begin
      LastIconIndex := IconIndex;
      Repaint;
    end;
end;

procedure TUHoverPanel.CM_MouseLeave(var Msg: TMessage);
begin
  inherited;
  IconIndex := -1;
  if IconIndex <> LastIconIndex then
    begin
      LastIconIndex := IconIndex;
      Repaint;
    end;
end;

end.
