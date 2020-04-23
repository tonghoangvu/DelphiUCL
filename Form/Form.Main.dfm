object formDemo: TformDemo
  Left = 0
  Top = 0
  Caption = 'Demo UCL'
  ClientHeight = 510
  ClientWidth = 870
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
    Left = 130
    Top = 240
    Width = 150
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
    Value = 30
  end
  object textCustom: TUText
    Left = 30
    Top = 430
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
    Top = 270
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
    Top = 230
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
    Top = 310
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
    Top = 340
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
    Top = 370
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
    Top = 400
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
    Left = 140
    Top = 280
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
    Left = 140
    Top = 320
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
    Left = 140
    Top = 300
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
    Left = 140
    Top = 340
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
    Left = 575
    Top = 50
    Width = 25
    Height = 60
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
    Value = 30
    OnChange = sliderVertChange
  end
  object checkbox2States: TUCheckBox
    Left = 140
    Top = 430
    Width = 180
    Height = 30
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    State = cbsChecked
    Caption = '2 states checkbox'
  end
  object checkbox3States: TUCheckBox
    Left = 140
    Top = 460
    Width = 180
    Height = 30
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    AllowGrayed = True
    State = cbsGrayed
    Caption = '3 states checkbox'
  end
  object radioA: TURadioButton
    Left = 330
    Top = 430
    Width = 180
    Height = 30
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    Group = ''
    Caption = 'Radio button A'
  end
  object radioB: TURadioButton
    Left = 330
    Top = 460
    Width = 180
    Height = 30
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    IsChecked = True
    Group = ''
    Caption = 'Radio button B'
  end
  object panelTest: TUPanel
    Left = 30
    Top = 110
    Width = 270
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
    Width = 140
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
    Left = 180
    Top = 50
    Width = 120
    Height = 50
    Caption = 'Reload'
    TabOrder = 2
    OnClick = buttonReloadClick
  end
  object captionbarMain: TUCaptionBar
    Left = 0
    Top = 0
    Width = 870
    Caption = '   Demo UCL app'
    Color = 15921906
    TabOrder = 3
    CustomBackColor.Enabled = False
    CustomBackColor.Color = 15921906
    CustomBackColor.LightColor = 15921906
    CustomBackColor.DarkColor = 2829099
    object qbuttonQuit: TUQuickButton
      Left = 825
      Top = 0
      Hint = 'Close'
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      CustomBackColor.Enabled = False
      CustomBackColor.Color = clBlack
      CustomBackColor.LightColor = 15132390
      CustomBackColor.DarkColor = 1644825
      ButtonStyle = qbsQuit
      Caption = #57606
      ExplicitLeft = 150
    end
    object qbuttonFullScreen: TUQuickButton
      Left = 645
      Top = 0
      Hint = 'Full screen'
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = qbuttonFullScreenClick
      CustomBackColor.Enabled = False
      CustomBackColor.Color = clBlack
      CustomBackColor.LightColor = 15132390
      CustomBackColor.DarkColor = 1644825
      Caption = #59200
      ExplicitLeft = 150
    end
    object qbuttonMin: TUQuickButton
      Left = 735
      Top = 0
      Hint = 'Minimize'
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      CustomBackColor.Enabled = False
      CustomBackColor.Color = clBlack
      CustomBackColor.LightColor = 15132390
      CustomBackColor.DarkColor = 1644825
      ButtonStyle = qbsMin
      Caption = #59192
      ExplicitLeft = 150
    end
    object qbuttonMax: TUQuickButton
      Left = 780
      Top = 0
      Hint = 'Maximize'
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      CustomBackColor.Enabled = False
      CustomBackColor.Color = clBlack
      CustomBackColor.LightColor = 15132390
      CustomBackColor.DarkColor = 1644825
      ButtonStyle = qbsMax
      Caption = #57347
      ExplicitLeft = 150
    end
    object qbuttonHighlight: TUQuickButton
      Left = 690
      Top = 0
      Hint = 'Back'
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      CustomBackColor.Enabled = False
      CustomBackColor.Color = clBlack
      CustomBackColor.LightColor = 15132390
      CustomBackColor.DarkColor = 1644825
      ButtonStyle = qbsHighlight
      Caption = #57510
      ExplicitLeft = 150
    end
  end
  object progressHorz: TUProgressBar
    Left = 330
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
    Left = 330
    Top = 140
    Width = 130
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
    Left = 330
    Top = 180
    Width = 130
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
    Top = 140
    Width = 130
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
    Top = 180
    Width = 130
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
    Top = 220
    Width = 130
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
    Left = 330
    Top = 220
    Width = 130
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
    Left = 550
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
  object buttonVListMultiSelection: TUListButton
    Left = 330
    Top = 260
    Width = 130
    Height = 70
    Caption = 'Multi selection'
    TabOrder = 12
    OnClick = buttonVListMultiSelectionClick
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
    ListStyle = lsVertical
    FontIcon = #57692
    SelectMode = smToggle
    Detail = ''
  end
  object comboChooseScaleRatio: TComboBox
    Left = 30
    Top = 80
    Width = 140
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 13
    Text = '100%'
    OnSelect = comboChooseScaleRatioSelect
    Items.Strings = (
      '100%'
      '125%'
      '150%'
      '175%'
      '200%')
  end
  object buttonVListDragReorder: TUListButton
    Left = 330
    Top = 340
    Width = 130
    Height = 70
    Caption = 'Drag reorder'
    TabOrder = 15
    OnClick = buttonVListDragReorderClick
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
    ListStyle = lsVertical
    FontIcon = #57604
    SelectMode = smToggle
    Detail = ''
  end
  object buttonVListAddItem: TUListButton
    Left = 470
    Top = 260
    Width = 130
    Height = 70
    Caption = 'Add item'
    ParentColor = True
    TabOrder = 16
    OnClick = buttonVListAddItemClick
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
    ListStyle = lsVertical
    FontIcon = #57609
    Detail = ''
  end
  object editSomething: TUEdit
    Left = 140
    Top = 380
    Width = 170
    Color = clWhite
    PopupMenu = popupEdit
    TabOrder = 17
    TextHint = 'Enter something here'
    CustomBackColor.Enabled = False
    CustomBackColor.Color = clWhite
    CustomBackColor.LightColor = clWhite
    CustomBackColor.DarkColor = clBlack
    CustomBorderColor.Enabled = False
    CustomBorderColor.LightNone = 10066329
    CustomBorderColor.LightHover = 6710886
    CustomBorderColor.LightPress = 14120960
    CustomBorderColor.LightSelectedNone = 14120960
    CustomBorderColor.LightSelectedHover = 14120960
    CustomBorderColor.LightSelectedPress = 14120960
    CustomBorderColor.DarkNone = 6710886
    CustomBorderColor.DarkHover = 10066329
    CustomBorderColor.DarkPress = 14120960
    CustomBorderColor.DarkSelectedNone = 14120960
    CustomBorderColor.DarkSelectedHover = 14120960
    CustomBorderColor.DarkSelectedPress = 14120960
  end
  object buttonVListRefreshEffect: TUListButton
    Left = 470
    Top = 340
    Width = 130
    Height = 70
    Caption = 'Refresh effect'
    TabOrder = 18
    OnClick = buttonVListRefreshEffectClick
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
    ListStyle = lsVertical
    FontIcon = #57673
    Detail = ''
  end
  object buttonRandomProgress: TUButton
    Left = 330
    Top = 70
    Width = 200
    Height = 40
    Caption = 'Random progress bar'
    OnClick = buttonRandomProgressClick
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
  object boxList: TUScrollBox
    Left = 630
    Top = 32
    Width = 240
    Height = 478
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Align = alRight
    Color = 15132390
    ParentColor = False
    TabOrder = 14
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkQuintic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 120
    AniSet.Step = 11
    CustomBackColor.Enabled = False
    CustomBackColor.Color = 15132390
    CustomBackColor.LightColor = 15132390
    CustomBackColor.DarkColor = 2039583
  end
  object popupEdit: TUPopupMenu
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkQuartic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 120
    AniSet.Step = 12
    CustomBackColor.Enabled = False
    CustomBackColor.Color = 15132390
    CustomBackColor.LightColor = 15132390
    CustomBackColor.DarkColor = 2039583
    OnItemClick = popupEditItemClick
    Left = 550
    Top = 430
    object popupItemCut: TMenuItem
      Caption = #57707'Cut|Ctrl+X'
      Hint = 'Remove the selected content and put it on the clipboard'
    end
    object popupitemCopy: TMenuItem
      Caption = #57711'Copy|Ctrl+C'
      Hint = 'Copy the selected content to the clipboard'
    end
    object popupitemPaste: TMenuItem
      Caption = #57709'Paste|Ctrl+V'
      Hint = 'Insert the contents of the clipboard at the current location'
    end
  end
end
