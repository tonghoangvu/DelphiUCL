unit UCL.Form;

interface

uses
  SysUtils, Classes, Windows, Forms, Controls, Graphics, Dialogs, Messages,
  UCL.Classes, UCL.ThemeManager, UCL.Colors, UCL.Utils, UCL.SystemSettings;

type
  TUForm = class(TForm, IUControl)
    private
      const
        FORM_BORDER_ACTIVE_LIGHT = $707070;
        FORM_BORDER_ACTIVE_DARK = $6D6B68;
        FORM_BORDER_INACTIVE_LIGHT = $AAAAAA;
        FORM_BORDER_INACTIVE_DARK = $A5A29A;

      var BorderColor: TColor;

      FThemeManager: TUThemeManager;
      FCustomBackColor: TUThemeColorSet;

      FIsActive: Boolean;
      FPPI: Integer;
      FFitDesktop: Boolean;

      //  Internal
      function IsWin7: Boolean;
      function IsResizable: Boolean;
      function HasBorder: Boolean;
      function GetBorderSpace: Integer;
      function CanDrawBorder: Boolean;
      procedure UpdateBorderColor;
      procedure DoDrawBorder;

      //  Child events
      procedure ThemeManager_OnChange(Sender: TObject);
      procedure CustomBackColor_OnChange(Sender: TObject);

      //  Messages
      procedure WM_Activate(var Msg: TWMActivate); message WM_ACTIVATE;
      procedure WM_DPIChanged(var Msg: TWMDpi); message WM_DPICHANGED;
      procedure WM_DWMColorizationColorChanged(var Msg: TMessage); message WM_DWMCOLORIZATIONCOLORCHANGED;
      procedure WM_NCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
      procedure WM_NCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

    protected
      {$IF CompilerVersion < 30}
        FCurrentPPI: Integer;
        FIsScaling: Boolean;
        function GetDesignDpi: Integer; virtual;
        function GetParentCurrentDpi: Integer; virtual;
      {$ENDIF}

      procedure CreateParams(var Params: TCreateParams); override;
      procedure Paint; override;
      procedure Resize; override;

    public
      constructor Create(aOwner: TComponent); override;
      constructor CreateNew(aOwner: TComponent; Dummy: Integer = 0); override;
      procedure InitForm;
      destructor Destroy; override;

      //  Interface
      function IsContainer: Boolean;
      procedure UpdateTheme(const UpdateChildren: Boolean);

    published
      property ThemeManager: TUThemeManager read FThemeManager write FThemeManager;
      property CustomBackColor: TUThemeColorSet read FCustomBackColor write FCustomBackColor;

      property IsActive: Boolean read FIsActive default true;
      property PPI: Integer read FPPI write FPPI default 96;
      property FitDesktop: Boolean read FFitDesktop write FFitDesktop default false;

      property Padding stored false;
  end;

implementation

uses
  UCL.Tooltip;

{ TUForm }

//  INTERFACE

function TUForm.IsContainer: Boolean;
begin
  Result := true;
end;

procedure TUForm.UpdateTheme(const UpdateChildren: Boolean);
var
  i: Integer;

  TM: TUThemeManager;
  _BackColor: TUThemeColorSet;
begin
  TM := ThemeManager;

  //  Update back color
  _BackColor := SelectColorSet(TM, CustomBackColor, FORM_BACK);
  Color := _BackColor.GetColor(TM);

  //  Update tooltip style
  if TM = nil then
    HintWindowClass := THintWindow
  else if TM.Theme = utLight then
    HintWindowClass := TULightTooltip
  else
    HintWindowClass := TUDarkTooltip;

  //  Update children
  if IsContainer and UpdateChildren then
    begin
      LockWindowUpdate(Handle);
      for i := 0 to ControlCount - 1 do
        if Supports(Controls[i], IUControl) then
          (Controls[i] as IUControl).UpdateTheme(UpdateChildren);
      LockWindowUpdate(0);
    end;
end;

//  INTERNAL

function TUForm.IsWin7: Boolean;
begin
  Result := CheckMaxWin32Version(6, 3);
end;

function TUForm.IsResizable: Boolean;
begin
  Result := BorderStyle in [bsSizeable, bsSizeToolWin];
end;

function TUForm.HasBorder: Boolean;
begin
  Result := BorderStyle in [bsDialog, bsSingle, bsSizeable];
end;

function TUForm.GetBorderSpace: Integer;
begin
  case BorderStyle of
    bsSingle:
      Result :=
        GetSystemMetrics(SM_CYFIXEDFRAME);

    bsDialog, bsToolWindow:
      Result :=
        GetSystemMetrics(SM_CYDLGFRAME);

    bsSizeable, bsSizeToolWin:
      Result :=
        GetSystemMetrics(SM_CYSIZEFRAME) +
        GetSystemMetrics(SM_CXPADDEDBORDER);

    else
      Result := 0;
  end;

  //  Modify for Windows 7
  if IsWin7 then
    case BorderStyle of
      bsSingle:
        dec(Result, 3);

      bsDialog, bsToolWindow:
        dec(Result, 3);

      bsSizeable, bsSizeToolWin:
        dec(Result, 2);
    end;
end;

function TUForm.CanDrawBorder: Boolean;
begin
  Result :=
    (WindowState = wsNormal) and
    HasBorder and
    (not IsWin7);
end;

procedure TUForm.UpdateBorderColor;
var
  TM: TUThemeManager;
begin
  TM := ThemeManager;

  if TM = nil then
    BorderColor := FORM_BORDER_ACTIVE_LIGHT

  //  Active window
  else if IsActive then
    begin
      if ThemeManager.ColorOnBorder then
        BorderColor := GetAccentColor   //  System accent color
      else if ThemeManager.Theme = utLight then
        BorderColor := FORM_BORDER_ACTIVE_LIGHT
      else
        BorderColor := FORM_BORDER_ACTIVE_DARK;
    end

  //  In active window
  else
    begin
      if ThemeManager.Theme = utLight then
        BorderColor := FORM_BORDER_INACTIVE_LIGHT
      else
        BorderColor := FORM_BORDER_INACTIVE_DARK;
    end;
end;

procedure TUForm.DoDrawBorder;
begin
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(Color, 255);
  Canvas.Pen.Color := BorderColor;
  Canvas.MoveTo(0, 0);
  Canvas.LineTo(Width, 0);  //  Top border
end;

//  CHILD EVENTS

procedure TUForm.ThemeManager_OnChange(Sender: TObject);
begin
  UpdateTheme(True);
end;

procedure TUForm.CustomBackColor_OnChange(Sender: TObject);
begin
  UpdateTheme(true);
end;

//  MAIN CLASS

procedure TUForm.InitForm;
var
  CurrentScreen: TMonitor;
begin
  FThemeManager := TUThemeManager.Create;
  FThemeManager.OnChange := ThemeManager_OnChange;
  FCustomBackColor := TUThemeColorSet.Create;
  FCustomBackColor.OnChange := CustomBackColor_OnChange;
  FCustomBackColor.Assign(FORM_BACK);

  Font.Name := FORM_FONT_NAME;
  Font.Size := FORM_FONT_SIZE;

  //  Default props
  FIsActive := true;
  FFitDesktop := true;

  //  Get PPI
  CurrentScreen := Screen.MonitorFromWindow(Handle);
  FPPI := CurrentScreen.PixelsPerInch;
  {$IF CompilerVersion < 30}
    FIsScaling := false;
    FCurrentPPI := FPPI;
  {$ENDIF}

  if IsWin7 and (BorderStyle = bsSizeable) then
    begin
      SetWindowLong(Handle, GWL_STYLE,
        GetWindowLong(Handle, GWL_STYLE) and not WS_CAPTION or WS_MINIMIZEBOX);
      SetWindowPos(handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_DRAWFRAME);
    end;

  //  First update theme
  FThemeManager.UpdateTheme;
end;

constructor TUForm.Create(aOwner: TComponent);
begin
  inherited;
  InitForm;
end;

constructor TUForm.CreateNew(aOwner: TComponent; Dummy: Integer);
begin
  inherited;
  InitForm;
end;

destructor TUForm.Destroy;
begin
  FThemeManager.Free;
  inherited;
end;

//  CUSTOM METHODS

procedure TUForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or 200000;
end;

procedure TUForm.Paint;
begin
  inherited;
  if CanDrawBorder then
    DoDrawBorder;
end;

procedure TUForm.Resize;
var
  CurrentScreen: TMonitor;
  Space: Integer;
begin
  inherited;

  if CanDrawBorder then
    Padding.Top := 1
  else
    Padding.Top := 0;

  if
    FitDesktop and
    (WindowState = wsMaximized) and
    (BorderStyle in [bsDialog, bsSizeToolWin, bsToolWindow])
  then
    begin
      CurrentScreen := Screen.MonitorFromWindow(Handle);
      Space := GetBorderSpace;

      Top := - Space;
      Left :=  - Space;
      Width := CurrentScreen.WorkareaRect.Width + 2 * Space;
      Height := CurrentScreen.WorkAreaRect.Height + 2 * Space;
    end;
end;

//  MESSAGES

procedure TUForm.WM_Activate(var Msg: TWMActivate);
begin
  inherited;
  FIsActive := Msg.Active <> WA_INACTIVE;

  //  Redraw border
  if CanDrawBorder then
    begin
      UpdateBorderColor;
      DoDrawBorder;
    end;
end;

procedure TUForm.WM_DPIChanged(var Msg: TWMDpi);
begin
  PPI := Msg.XDpi;
  inherited;
  ScaleForPPI(PPI);
end;

procedure TUForm.WM_DWMColorizationColorChanged(var Msg: TMessage);
begin
  inherited;
  if ThemeManager <> nil then
    ThemeManager.UpdateTheme;
end;

procedure TUForm.WM_NCCalcSize(var Msg: TWMNCCalcSize);
var
  CaptionBarHeight: Integer;
begin
  inherited;
  if BorderStyle = bsNone then exit;

  if IsWin7 and (BorderStyle = bsSizeable) then
    CaptionBarHeight := 0
  else
    CaptionBarHeight := GetSystemMetrics(SM_CYCAPTION);
  if WindowState = wsNormal then
    inc(CaptionBarHeight, GetBorderSpace);

  dec(Msg.CalcSize_Params.rgrc[0].Top, CaptionBarHeight);
end;

procedure TUForm.WM_NCHitTest(var Msg: TWMNCHitTest);
var
  ResizeSpace: Integer;
  AllowResize: Boolean;
begin
  inherited;
  ResizeSpace := GetBorderSpace;

  AllowResize :=
    (WindowState = wsNormal) and
    (IsResizable);

  if AllowResize and (Msg.YPos - BoundsRect.Top <= ResizeSpace) then  //  Resize top border
    begin
      if Msg.XPos - BoundsRect.Left <= 2 * ResizeSpace then
        Msg.Result := HTTOPLEFT
      else if BoundsRect.Right - Msg.XPos <= 2 * ResizeSpace then
        Msg.Result := HTTOPRIGHT
      else
        Msg.Result := HTTOP;
    end;
end;

//  COMPATIBLE CODE

{$REGION 'Compatible code'}

{$IF CompilerVersion < 30}

function TUForm.GetDesignDpi: Integer;
var
  LForm: TCustomForm;
begin
  LForm := GetParentForm(Self);

  if (LForm <> nil) and (LForm is TForm) then
    Result := TForm(LForm).PixelsPerInch
  else
    Result := Windows.USER_DEFAULT_SCREEN_DPI;
end;

function TUForm.GetParentCurrentDpi: Integer;
begin
//  if Parent <> nil then
//    Result := Parent.GetParentCurrentDpi
//  else
    Result := FCurrentPPI;
end;

procedure TUForm.ScaleForPPI(NewPPI: Integer);
begin
  if not FIsScaling and (NewPPI > 0) then begin
    FIsScaling := True;
    try
      if FCurrentPPI = 0 then
        FCurrentPPI := GetDesignDpi;

      if NewPPI <> FCurrentPPI then begin
        ChangeScale(NewPPI, FCurrentPPI{, True});
        FCurrentPPI := NewPPI;
      end
    finally
      FIsScaling := False;
    end;
  end;
end;

{$ENDIF}

{$ENDREGION}

end.
