object formDemo: TformDemo
  Left = 0
  Top = 0
  Caption = 'Demo UCL'
  ClientHeight = 500
  ClientWidth = 700
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object panelTest: TUPanel
    Left = 30
    Top = 110
    Width = 250
    Height = 100
    Hint = 'This is a hint'
    Caption = 'Demo panel'
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    CustomBackColor.Enabled = False
    CustomBackColor.Color = clBlack
    CustomBackColor.LightColor = 15132390
    CustomBackColor.DarkColor = 2039583
  end
  object comboChooseTheme: TComboBox
    Left = 30
    Top = 50
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = 'System theme'
    OnSelect = comboChooseThemeSelect
    Items.Strings = (
      'System theme'
      'Light theme'
      'Dark theme')
  end
  object buttonReload: TButton
    Left = 160
    Top = 50
    Width = 121
    Height = 41
    Caption = 'Reload'
    TabOrder = 2
    OnClick = buttonReloadClick
  end
  object captionbarMain: TUCaptionBar
    Left = 0
    Top = 0
    Width = 700
    Caption = '   Caption bar'
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    CustomBackColor.Enabled = False
    CustomBackColor.Color = clBlack
    CustomBackColor.LightColor = 15921906
    CustomBackColor.DarkColor = 2829099
  end
  object buttonRandomProgress: TButton
    Left = 320
    Top = 70
    Width = 201
    Height = 41
    Caption = 'Random progress bar'
    TabOrder = 4
    OnClick = buttonRandomProgressClick
  end
  object progressHorz: TUProgressBar
    Left = 320
    Top = 50
    Width = 200
    Caption = 'progressHorz'
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkQuartic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 250
    AniSet.Step = 25
    CustomBackColor.Enabled = False
    CustomBackColor.Color = 15132390
    CustomBackColor.LightColor = 13421772
    CustomBackColor.DarkColor = 3355443
  end
  object UButton1: TUButton
    Left = 330
    Top = 240
    Caption = 'Focus button'
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 13421772
    CustomBackColor.LightHover = 13421772
    CustomBackColor.LightPress = 10066329
    CustomBackColor.LightSelectedNone = 13421772
    CustomBackColor.LightSelectedHover = 13421772
    CustomBackColor.LightSelectedPress = 10066329
    CustomBackColor.DarkNone = 3355443
    CustomBackColor.DarkHover = 3355443
    CustomBackColor.DarkPress = 6710886
    CustomBackColor.DarkSelectedNone = 3355443
    CustomBackColor.DarkSelectedHover = 3355443
    CustomBackColor.DarkSelectedPress = 6710886
    CustomBorderColor.Enabled = False
    CustomBorderColor.LightNone = 13421772
    CustomBorderColor.LightHover = 8026746
    CustomBorderColor.LightPress = 10066329
    CustomBorderColor.LightSelectedNone = 8026746
    CustomBorderColor.LightSelectedHover = 8026746
    CustomBorderColor.LightSelectedPress = 10066329
    CustomBorderColor.DarkNone = 3355443
    CustomBorderColor.DarkHover = 8750469
    CustomBorderColor.DarkPress = 6710886
    CustomBorderColor.DarkSelectedNone = 8750469
    CustomBorderColor.DarkSelectedHover = 8750469
    CustomBorderColor.DarkSelectedPress = 6710886
  end
  object UButton2: TUButton
    Left = 330
    Top = 280
    Caption = 'Toggle button'
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 13421772
    CustomBackColor.LightHover = 13421772
    CustomBackColor.LightPress = 10066329
    CustomBackColor.LightSelectedNone = 13421772
    CustomBackColor.LightSelectedHover = 13421772
    CustomBackColor.LightSelectedPress = 10066329
    CustomBackColor.DarkNone = 3355443
    CustomBackColor.DarkHover = 3355443
    CustomBackColor.DarkPress = 6710886
    CustomBackColor.DarkSelectedNone = 3355443
    CustomBackColor.DarkSelectedHover = 3355443
    CustomBackColor.DarkSelectedPress = 6710886
    CustomBorderColor.Enabled = False
    CustomBorderColor.LightNone = 13421772
    CustomBorderColor.LightHover = 8026746
    CustomBorderColor.LightPress = 10066329
    CustomBorderColor.LightSelectedNone = 8026746
    CustomBorderColor.LightSelectedHover = 8026746
    CustomBorderColor.LightSelectedPress = 10066329
    CustomBorderColor.DarkNone = 3355443
    CustomBorderColor.DarkHover = 8750469
    CustomBorderColor.DarkPress = 6710886
    CustomBorderColor.DarkSelectedNone = 8750469
    CustomBorderColor.DarkSelectedHover = 8750469
    CustomBorderColor.DarkSelectedPress = 6710886
    IsToggleButton = True
  end
  object UButton3: TUButton
    Left = 480
    Top = 240
    Caption = 'No focus button'
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 13421772
    CustomBackColor.LightHover = 13421772
    CustomBackColor.LightPress = 10066329
    CustomBackColor.LightSelectedNone = 13421772
    CustomBackColor.LightSelectedHover = 13421772
    CustomBackColor.LightSelectedPress = 10066329
    CustomBackColor.DarkNone = 3355443
    CustomBackColor.DarkHover = 3355443
    CustomBackColor.DarkPress = 6710886
    CustomBackColor.DarkSelectedNone = 3355443
    CustomBackColor.DarkSelectedHover = 3355443
    CustomBackColor.DarkSelectedPress = 6710886
    CustomBorderColor.Enabled = False
    CustomBorderColor.LightNone = 13421772
    CustomBorderColor.LightHover = 8026746
    CustomBorderColor.LightPress = 10066329
    CustomBorderColor.LightSelectedNone = 8026746
    CustomBorderColor.LightSelectedHover = 8026746
    CustomBorderColor.LightSelectedPress = 10066329
    CustomBorderColor.DarkNone = 3355443
    CustomBorderColor.DarkHover = 8750469
    CustomBorderColor.DarkPress = 6710886
    CustomBorderColor.DarkSelectedNone = 8750469
    CustomBorderColor.DarkSelectedHover = 8750469
    CustomBorderColor.DarkSelectedPress = 6710886
    AllowFocus = False
  end
  object UButton4: TUButton
    Left = 480
    Top = 280
    Caption = 'Transparent button'
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 13421772
    CustomBackColor.LightHover = 13421772
    CustomBackColor.LightPress = 10066329
    CustomBackColor.LightSelectedNone = 13421772
    CustomBackColor.LightSelectedHover = 13421772
    CustomBackColor.LightSelectedPress = 10066329
    CustomBackColor.DarkNone = 3355443
    CustomBackColor.DarkHover = 3355443
    CustomBackColor.DarkPress = 6710886
    CustomBackColor.DarkSelectedNone = 3355443
    CustomBackColor.DarkSelectedHover = 3355443
    CustomBackColor.DarkSelectedPress = 6710886
    CustomBorderColor.Enabled = False
    CustomBorderColor.LightNone = 13421772
    CustomBorderColor.LightHover = 8026746
    CustomBorderColor.LightPress = 10066329
    CustomBorderColor.LightSelectedNone = 8026746
    CustomBorderColor.LightSelectedHover = 8026746
    CustomBorderColor.LightSelectedPress = 10066329
    CustomBorderColor.DarkNone = 3355443
    CustomBorderColor.DarkHover = 8750469
    CustomBorderColor.DarkPress = 6710886
    CustomBorderColor.DarkSelectedNone = 8750469
    CustomBorderColor.DarkSelectedHover = 8750469
    CustomBorderColor.DarkSelectedPress = 6710886
    Transparent = True
  end
  object UButton5: TUButton
    Left = 480
    Top = 320
    Caption = 'Highlight button'
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 13421772
    CustomBackColor.LightHover = 13421772
    CustomBackColor.LightPress = 10066329
    CustomBackColor.LightSelectedNone = 13421772
    CustomBackColor.LightSelectedHover = 13421772
    CustomBackColor.LightSelectedPress = 10066329
    CustomBackColor.DarkNone = 3355443
    CustomBackColor.DarkHover = 3355443
    CustomBackColor.DarkPress = 6710886
    CustomBackColor.DarkSelectedNone = 3355443
    CustomBackColor.DarkSelectedHover = 3355443
    CustomBackColor.DarkSelectedPress = 6710886
    CustomBorderColor.Enabled = False
    CustomBorderColor.LightNone = 13421772
    CustomBorderColor.LightHover = 8026746
    CustomBorderColor.LightPress = 10066329
    CustomBorderColor.LightSelectedNone = 8026746
    CustomBorderColor.LightSelectedHover = 8026746
    CustomBorderColor.LightSelectedPress = 10066329
    CustomBorderColor.DarkNone = 3355443
    CustomBorderColor.DarkHover = 8750469
    CustomBorderColor.DarkPress = 6710886
    CustomBorderColor.DarkSelectedNone = 8750469
    CustomBorderColor.DarkSelectedHover = 8750469
    CustomBorderColor.DarkSelectedPress = 6710886
    Highlight = True
  end
end
