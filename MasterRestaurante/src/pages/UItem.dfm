object ItemForm: TItemForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'ItemForm'
  ClientHeight = 95
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LBTexto: TLabel
    Left = 49
    Top = 39
    Width = 41
    Height = 13
    Caption = 'Item N'#186':'
  end
  object EditItem: TJvValidateEdit
    Left = 113
    Top = 31
    Width = 92
    Height = 32
    Hint = 'Quantidade do Item'
    AutoSize = False
    CriticalPoints.MaxValueIncluded = False
    CriticalPoints.MinValueIncluded = False
    DecimalPlaces = 4
    EditText = '0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ZeroEmpty = True
    OnKeyPress = EditItemKeyPress
  end
end
