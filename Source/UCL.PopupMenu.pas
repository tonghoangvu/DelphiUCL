unit UCL.PopupMenu;

interface

uses
  Classes, Types, Windows, Forms, Controls, Menus, Graphics, Messages,
  UCL.IntAnimation,
  UCL.Classes, UCL.ThemeManager, UCL.Utils, UCL.Graphics,
  UCL.Form, UCL.ListButton, UCL.Colors;

type
  TIndexNotifyEvent = procedure (Sender: TObject; Index: Integer) of object;

  TUPopupMenu = class(TPopupMenu, IUControl)
    private
      var BackColor: TColor;

      FAniSet: TIntAniSet;

      FItemWidth: Integer;
      FItemHeight: Integer;
      FTopSpace: Integer;
      FImageKind: TUImageKind;

      FOnItemClick: TIndexNotifyEvent;

      //  Child events
      procedure PopupForm_OnDeactivate(Sender: TObject);
      procedure PopupItem_OnClick(Sender: TObject);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      //  Interface
      function IsContainer: Boolean;
      procedure UpdateTheme(const UpdateChildren: Boolean);

      //  Utils
      procedure Popup(X, Y: Integer); override;
      procedure PopupAtPoint(P: TPoint); overload;
      procedure PopupAtMouse; overload;

      procedure ExtractPackedContent(Input: string; out Icon, Text, Detail: string);

    published
      property AniSet: TIntAniSet read FAniSet write FAniSet;

      property ItemWidth: Integer read FItemWidth write FItemWidth default 200;
      property ItemHeight: Integer read FItemHeight write FItemHeight default 32;
      property TopSpace: Integer read FTopSpace write FTopSpace default 5;
      property ImageKind: TUImageKind read FImageKind write FImageKind default ikFontIcon;

      property OnItemClick: TIndexNotifyEvent read FOnItemClick write FOnItemClick;
  end;

implementation

{ TUPopupMenu }

//  INTERFACE

function TUPopupMenu.IsContainer: Boolean;
begin
  Result := true;
end;

procedure TUPopupMenu.UpdateTheme(const UpdateChildren: Boolean);
var
  TM: TUThemeManager;
begin
  //  Update colors
  if (Owner is TForm) and (Owner <> nil) then
    TM := SelectThemeManager(Owner as TControl)
  else
    TM := nil;

  if TM = nil then
    BackColor := $E6E6E6
  else if TM.Theme = utLight then
    BackColor := $E6E6E6
  else
    BackColor := $1F1F1F;

  CloseMenu;
  //  Do not update children
end;

//  CHILD EVENT

procedure TUPopupMenu.PopupForm_OnDeactivate(Sender: TObject);
var
  Form: TForm;
begin
  if not ((Sender is TForm) and (Sender <> nil)) then exit;
  Form := Sender as TForm;
  Form.Close;
end;

procedure TUPopupMenu.PopupItem_OnClick(Sender: TObject);
begin
  if (Sender is TUListButton) and (Assigned(FOnItemClick)) then
    FOnItemClick(Self, (Sender as TUListButton).Tag);
end;

//  MAIN CLASS

constructor TUPopupMenu.Create(aOwner: TComponent);
begin
  inherited;
  BackColor := $E6E6E6;

  FItemWidth := 200;
  FItemHeight := 32;
  FTopSpace := 5;
  FImageKind := ikFontIcon;

  FAniSet := TIntAniSet.Create;
  FAniSet.QuickAssign(akOut, afkQuartic, 0, 120, 12);
end;

destructor TUPopupMenu.Destroy;
begin
  FAniSet.Free;
  inherited;
end;

//  UTILS

procedure TUPopupMenu.ExtractPackedContent(Input: string; out Icon, Text, Detail: string);
var
  SeparatorPos: Integer;
begin
  if Length(Input) = 0 then
    begin
      Icon := '';
      Text := '';
      Detail := '';
    end
  else
    begin
      Icon := Input[1];
      Input := Copy(Input, 2, Length(Input) - 1);
      SeparatorPos := Pos('|', Input);
      if SeparatorPos = 0 then
        begin
          Text := Input;
          Detail := '';
        end
      else
        begin
          Text := Copy(Input, 1, SeparatorPos - 1);
          Detail := Copy(Input, SeparatorPos + 1, Length(Input) - SeparatorPos);
        end;
    end;
end;

procedure TUPopupMenu.Popup(X, Y: Integer);
var
  Form: TUForm;
  i, ItemCount: Integer;
  MenuItem: TMenuItem;
  UItem: TUListButton;
  Icon, Text, Detail: string;
  Ani: TIntAni;

  DPI: Integer;
  Ratio: Single;
  TotalItemsHeight: Integer;
  Spacing: Integer;
  ItemW: Integer;
begin
  //  High DPI
  if Owner is TUForm then
    DPI := (Owner as TUForm).PPI
  else
    DPI := 96;
  Ratio := DPI / 96;

  //  Getting something
  ItemCount := Self.Items.Count;
  if ItemCount = 0 then exit;

  Spacing := Round(TopSpace * Ratio);
  ItemW := Round(ItemWidth * Ratio);

  //  Create popup form
  Form := TUForm.CreateNew(Self);
  Form.OnDeactivate := PopupForm_OnDeactivate;

  Form.DoubleBuffered := true;
  Form.BorderStyle := bsToolWindow;
  Form.Color := BackColor;

  Form.Padding.Bottom := Spacing;
  Form.ClientWidth := ItemW;
  Form.ClientHeight := 0;

  //  Build items
  TotalItemsHeight := 0;
  for i := 0 to ItemCount - 1 do
    begin
      MenuItem := Self.Items[i];

      UItem := TUListButton.Create(Form);
      UItem.Tag := i;
      UItem.Parent := Form;
      UItem.ParentFont := true;
      UItem.Enabled := MenuItem.Enabled;
      UItem.OnClick := PopupItem_OnClick;

      UItem.Hint := MenuItem.Hint;
      UItem.Images := Self.Images;
      UItem.ImageIndex := MenuItem.ImageIndex;

      ExtractPackedContent(MenuItem.Caption, Icon, Text, Detail);
      UItem.FontIcon := Icon;
      UItem.Caption := Text;
      UItem.Detail := Detail;
      UItem.ImageKind := Self.ImageKind;

      UItem.Align := alBottom;
      UItem.Width := ItemWidth;
      UItem.Height := ItemHeight;
      UItem.ShowHint := true;

      //  Scale item
      UItem.ScaleForPPI(DPI);
      UItem.Font.Height := MulDiv(UItem.Font.Height, DPI, 96);  //  Scaling for text font

      //  Increase total items height
      Inc(TotalItemsHeight, UItem.Height);
    end;

  //  Set popup position (after show)
  Form.Left := X;
  Form.Top := Y;
  Form.Visible := true;

  //  Animation
  Ani := TIntAni.Create(0, TotalItemsHeight + 2 * Spacing,
    procedure (Value: Integer)
    begin
      Form.ClientHeight := Value;
    end, nil);
  Ani.AniSet.Assign(AniSet);
  Ani.Start;
end;

procedure TUPopupMenu.PopupAtMouse;
begin
  Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TUPopupMenu.PopupAtPoint(P: TPoint);
begin
  Popup(P.X, P.Y);
end;

end.
