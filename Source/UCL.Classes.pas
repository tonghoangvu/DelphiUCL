unit UCL.Classes;

interface

uses
  Classes, Graphics;

type
  TUTheme = (utLight, utDark);
  TUOrientation = (oHorizontal, oVertical);
  TUDirection = (dLeft, dTop, dRight, dBottom);
  TUControlState = (csNone, csHover, csPress, csDisabled, csFocused);

  TUImageKind = (ikFontIcon, ikImage);

  TDefColor = array [TUTheme, TUControlState] of TColor;

  AccentPolicy = packed record
    AccentState: Integer;
    AccentFlags: Integer;
    GradientColor: Integer;
    AnimationId: Integer;
  end;

  WindowCompositionAttributeData = packed record
    Attribute: Cardinal;
    Data: Pointer;
    SizeOfData: Integer;
  end;

  TQuadColor = packed record
    case Boolean of
      True: (Blue, Green, Red, Alpha: Byte);
      False: (Quad: Cardinal);
  end;

  PQuadColor = ^TQuadColor;
  PPQuadColor = ^PQuadColor;

implementation

end.
