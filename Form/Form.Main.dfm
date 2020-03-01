object formDemo: TformDemo
  Left = 0
  Top = 0
  Caption = 'Demo UCL'
  ClientHeight = 530
  ClientWidth = 650
  Color = clWhite
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sliderHorz: TUSlider
    Left = 30
    Top = 230
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 10066329
    CustomBackColor.LightHover = 6710886
    CustomBackColor.LightPress = 10066329
    CustomBackColor.LightSelectedNone = 10066329
    CustomBackColor.LightSelectedHover = 6710886
    CustomBackColor.LightSelectedPress = 10066329
    CustomBackColor.DarkNone = 6710886
    CustomBackColor.DarkHover = 10066329
    CustomBackColor.DarkPress = 6710886
    CustomBackColor.DarkSelectedNone = 6710886
    CustomBackColor.DarkSelectedHover = 10066329
    CustomBackColor.DarkSelectedPress = 6710886
    CustomCursorColor.Enabled = False
    CustomCursorColor.LightNone = 14120960
    CustomCursorColor.LightHover = 1513239
    CustomCursorColor.LightPress = 13421772
    CustomCursorColor.LightSelectedNone = 14120960
    CustomCursorColor.LightSelectedHover = 1513239
    CustomCursorColor.LightSelectedPress = 13421772
    CustomCursorColor.DarkNone = 14120960
    CustomCursorColor.DarkHover = 15921906
    CustomCursorColor.DarkPress = 7763574
    CustomCursorColor.DarkSelectedNone = 14120960
    CustomCursorColor.DarkSelectedHover = 15921906
    CustomCursorColor.DarkSelectedPress = 7763574
  end
  object textCustom: TUText
    Left = 30
    Top = 470
    Width = 77
    Height = 16
    Caption = 'Custom text'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'System'
    Font.Style = []
    ParentFont = False
  end
  object textHeading: TUText
    Left = 30
    Top = 310
    Width = 74
    Height = 28
    Caption = 'Heading'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TextKind = tkHeading
  end
  object textTitle: TUText
    Left = 30
    Top = 270
    Width = 53
    Height = 38
    Caption = 'Title'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 14120960
    Font.Height = -28
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TextKind = tkTitle
    UseAccentColor = True
  end
  object textEntry: TUText
    Left = 30
    Top = 350
    Width = 33
    Height = 17
    Caption = 'Entry'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
    TextKind = tkEntry
  end
  object textNormal: TUText
    Left = 30
    Top = 380
    Width = 69
    Height = 17
    Caption = 'Normal text'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TextKind = tkNormal
  end
  object textDescription: TUText
    Left = 30
    Top = 410
    Width = 60
    Height = 15
    Caption = 'Description'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6710886
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TextKind = tkDescription
  end
  object textDisabled: TUText
    Left = 30
    Top = 440
    Width = 51
    Height = 17
    Caption = 'Disabled'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6710886
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TextKind = tkNormal
  end
  object linkEmpty: TUHyperlink
    Left = 180
    Top = 320
    Width = 126
    Height = 17
    Caption = 'Not set URL hyperlink'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 14120960
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    CustomTextColor.Enabled = False
    CustomTextColor.LightNone = 14120960
    CustomTextColor.LightHover = clGray
    CustomTextColor.LightPress = clMedGray
    CustomTextColor.LightSelectedNone = 14120960
    CustomTextColor.LightSelectedHover = clGray
    CustomTextColor.LightSelectedPress = clMedGray
    CustomTextColor.DarkNone = 14120960
    CustomTextColor.DarkHover = clMedGray
    CustomTextColor.DarkPress = clGray
    CustomTextColor.DarkSelectedNone = 14120960
    CustomTextColor.DarkSelectedHover = clMedGray
    CustomTextColor.DarkSelectedPress = clGray
  end
  object linkGoogle: TUHyperlink
    Left = 180
    Top = 340
    Width = 80
    Height = 17
    Caption = 'Go to Google'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 14120960
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    CustomTextColor.Enabled = False
    CustomTextColor.LightNone = 14120960
    CustomTextColor.LightHover = clGray
    CustomTextColor.LightPress = clMedGray
    CustomTextColor.LightSelectedNone = 14120960
    CustomTextColor.LightSelectedHover = clGray
    CustomTextColor.LightSelectedPress = clMedGray
    CustomTextColor.DarkNone = 14120960
    CustomTextColor.DarkHover = clMedGray
    CustomTextColor.DarkPress = clGray
    CustomTextColor.DarkSelectedNone = 14120960
    CustomTextColor.DarkSelectedHover = clMedGray
    CustomTextColor.DarkSelectedPress = clGray
    URL = 'https://google.com/'
  end
  object linkDisabled: TUHyperlink
    Left = 180
    Top = 360
    Width = 142
    Height = 17
    Cursor = crDefault
    Caption = 'Go to Google (disabled)'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    CustomTextColor.Enabled = False
    CustomTextColor.LightNone = 14120960
    CustomTextColor.LightHover = clGray
    CustomTextColor.LightPress = clMedGray
    CustomTextColor.LightSelectedNone = 14120960
    CustomTextColor.LightSelectedHover = clGray
    CustomTextColor.LightSelectedPress = clMedGray
    CustomTextColor.DarkNone = 14120960
    CustomTextColor.DarkHover = clMedGray
    CustomTextColor.DarkPress = clGray
    CustomTextColor.DarkSelectedNone = 14120960
    CustomTextColor.DarkSelectedHover = clMedGray
    CustomTextColor.DarkSelectedPress = clGray
    URL = 'https://google.com/'
  end
  object linkCustomColor: TUHyperlink
    Left = 180
    Top = 380
    Width = 168
    Height = 17
    Caption = 'Go to Google (custom color)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    CustomTextColor.Enabled = True
    CustomTextColor.LightNone = clGreen
    CustomTextColor.LightHover = clGray
    CustomTextColor.LightPress = clMedGray
    CustomTextColor.LightSelectedNone = clGreen
    CustomTextColor.LightSelectedHover = clGray
    CustomTextColor.LightSelectedPress = clMedGray
    CustomTextColor.DarkNone = clGreen
    CustomTextColor.DarkHover = clMedGray
    CustomTextColor.DarkPress = clGray
    CustomTextColor.DarkSelectedNone = clGreen
    CustomTextColor.DarkSelectedHover = clMedGray
    CustomTextColor.DarkSelectedPress = clGray
    URL = 'https://google.com/'
  end
  object sliderVert: TUSlider
    Left = 160
    Top = 220
    Width = 25
    Height = 50
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 10066329
    CustomBackColor.LightHover = 6710886
    CustomBackColor.LightPress = 10066329
    CustomBackColor.LightSelectedNone = 10066329
    CustomBackColor.LightSelectedHover = 6710886
    CustomBackColor.LightSelectedPress = 10066329
    CustomBackColor.DarkNone = 6710886
    CustomBackColor.DarkHover = 10066329
    CustomBackColor.DarkPress = 6710886
    CustomBackColor.DarkSelectedNone = 6710886
    CustomBackColor.DarkSelectedHover = 10066329
    CustomBackColor.DarkSelectedPress = 6710886
    CustomCursorColor.Enabled = False
    CustomCursorColor.LightNone = 14120960
    CustomCursorColor.LightHover = 1513239
    CustomCursorColor.LightPress = 13421772
    CustomCursorColor.LightSelectedNone = 14120960
    CustomCursorColor.LightSelectedHover = 1513239
    CustomCursorColor.LightSelectedPress = 13421772
    CustomCursorColor.DarkNone = 14120960
    CustomCursorColor.DarkHover = 15921906
    CustomCursorColor.DarkPress = 7763574
    CustomCursorColor.DarkSelectedNone = 14120960
    CustomCursorColor.DarkSelectedHover = 15921906
    CustomCursorColor.DarkSelectedPress = 7763574
    Orientation = oVertical
    Min = 1
    Max = 5
    Value = 1
  end
  object panelTest: TUPanel
    Left = 30
    Top = 110
    Width = 250
    Height = 100
    Hint = 'This is a hint'
    Caption = 'Move mouse here to show tooltip'
    Color = 15132390
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    CustomBackColor.Enabled = False
    CustomBackColor.Color = 15132390
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
    Height = 51
    Caption = 'Reload'
    TabOrder = 2
    OnClick = buttonReloadClick
  end
  object captionbarMain: TUCaptionBar
    Left = 0
    Top = 0
    Width = 650
    Caption = '   Caption bar'
    Color = 15921906
    TabOrder = 3
    CustomBackColor.Enabled = False
    CustomBackColor.Color = 15921906
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
    Value = 30
  end
  object buttonFocus: TUButton
    Left = 320
    Top = 150
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
  object buttonToggle: TUButton
    Left = 320
    Top = 190
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
  object buttonNoFocus: TUButton
    Left = 470
    Top = 150
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
  object buttonTransparent: TUButton
    Left = 470
    Top = 190
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
  object buttonHighlight: TUButton
    Left = 470
    Top = 230
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
  object buttonDisabled: TUButton
    Left = 320
    Top = 230
    Caption = 'Disabled button'
    Enabled = False
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
  object progressVert: TUProgressBar
    Left = 540
    Top = 50
    Width = 5
    Height = 60
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
    Value = 30
    Orientation = oVertical
  end
  object buttonList1: TUListButton
    Left = 370
    Top = 280
    Width = 251
    Height = 41
    Caption = 'Selectable list button 1'
    TabOrder = 13
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -16
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 15132390
    CustomBackColor.LightHover = 13619151
    CustomBackColor.LightPress = 12105912
    CustomBackColor.LightSelectedNone = 127
    CustomBackColor.LightSelectedHover = 103
    CustomBackColor.LightSelectedPress = 89
    CustomBackColor.DarkNone = 2039583
    CustomBackColor.DarkHover = 3487029
    CustomBackColor.DarkPress = 5000268
    CustomBackColor.DarkSelectedNone = 89
    CustomBackColor.DarkSelectedHover = 103
    CustomBackColor.DarkSelectedPress = 127
    FontIcon = #57492
    Detail = 'Click me'
  end
  object buttonVList1: TUListButton
    Left = 370
    Top = 410
    Width = 121
    Height = 90
    Caption = 'Click me'
    TabOrder = 14
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -16
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 15132390
    CustomBackColor.LightHover = 13619151
    CustomBackColor.LightPress = 12105912
    CustomBackColor.LightSelectedNone = 127
    CustomBackColor.LightSelectedHover = 103
    CustomBackColor.LightSelectedPress = 89
    CustomBackColor.DarkNone = 2039583
    CustomBackColor.DarkHover = 3487029
    CustomBackColor.DarkPress = 5000268
    CustomBackColor.DarkSelectedNone = 89
    CustomBackColor.DarkSelectedHover = 103
    CustomBackColor.DarkSelectedPress = 127
    Orientation = oVertical
    FontIcon = #57492
    Detail = 'Not selectable'
    AllowSelected = False
  end
  object buttonList2: TUListButton
    Left = 370
    Top = 320
    Width = 251
    Height = 41
    Caption = 'Selectable list button 2'
    TabOrder = 15
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -16
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 15132390
    CustomBackColor.LightHover = 13619151
    CustomBackColor.LightPress = 12105912
    CustomBackColor.LightSelectedNone = 127
    CustomBackColor.LightSelectedHover = 103
    CustomBackColor.LightSelectedPress = 89
    CustomBackColor.DarkNone = 2039583
    CustomBackColor.DarkHover = 3487029
    CustomBackColor.DarkPress = 5000268
    CustomBackColor.DarkSelectedNone = 89
    CustomBackColor.DarkSelectedHover = 103
    CustomBackColor.DarkSelectedPress = 127
    FontIcon = #57492
    Detail = 'Click me'
  end
  object buttonList3: TUListButton
    Left = 370
    Top = 360
    Width = 251
    Height = 41
    Caption = 'Selectable list button 3'
    TabOrder = 16
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -16
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 15132390
    CustomBackColor.LightHover = 13619151
    CustomBackColor.LightPress = 12105912
    CustomBackColor.LightSelectedNone = 127
    CustomBackColor.LightSelectedHover = 103
    CustomBackColor.LightSelectedPress = 89
    CustomBackColor.DarkNone = 2039583
    CustomBackColor.DarkHover = 3487029
    CustomBackColor.DarkPress = 5000268
    CustomBackColor.DarkSelectedNone = 89
    CustomBackColor.DarkSelectedHover = 103
    CustomBackColor.DarkSelectedPress = 127
    FontIcon = #57492
    Detail = 'Click me'
  end
  object buttonVList2: TUListButton
    Left = 500
    Top = 410
    Width = 121
    Height = 90
    Caption = 'Click me'
    TabOrder = 17
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -16
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    CustomBackColor.Enabled = False
    CustomBackColor.LightNone = 15132390
    CustomBackColor.LightHover = 13619151
    CustomBackColor.LightPress = 12105912
    CustomBackColor.LightSelectedNone = 127
    CustomBackColor.LightSelectedHover = 103
    CustomBackColor.LightSelectedPress = 89
    CustomBackColor.DarkNone = 2039583
    CustomBackColor.DarkHover = 3487029
    CustomBackColor.DarkPress = 5000268
    CustomBackColor.DarkSelectedNone = 89
    CustomBackColor.DarkSelectedHover = 103
    CustomBackColor.DarkSelectedPress = 127
    Orientation = oVertical
    FontIcon = #57492
    Detail = 'Not selectable'
    AllowSelected = False
  end
  object comboChooseScaleRatio: TComboBox
    Left = 30
    Top = 80
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 18
    Text = '100%'
    OnSelect = comboChooseScaleRatioSelect
    Items.Strings = (
      '100%'
      '125%'
      '150%'
      '175%'
      '200%')
  end
end
