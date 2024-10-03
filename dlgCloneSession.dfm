object CloneSession: TCloneSession
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Clone Session ...'
  ClientHeight = 211
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  TextHeight = 19
  object lblDescription: TLabel
    Left = 94
    Top = 8
    Width = 322
    Height = 113
    AutoSize = False
    Caption = 
      'Clone the current selected session, including all of it'#39's events' +
      '.'#13#10#13#10'A new session will be created and assigned todays'#39' date. '
    WordWrap = True
  end
  object vimgClone: TVirtualImage
    Left = 0
    Top = 8
    Width = 73
    Height = 65
    ImageCollection = imgcolClone
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 0
    ImageName = 'Clone'
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 158
    Width = 424
    Height = 53
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 326
    object btnClone: TButton
      Left = 215
      Top = 10
      Width = 99
      Height = 31
      Caption = 'Clone'
      Default = True
      TabOrder = 0
      OnClick = btnCloneClick
    end
    object btnCancel: TButton
      Left = 110
      Top = 10
      Width = 99
      Height = 31
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object qrySrcEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    SQL.Strings = (
      ''
      'SELECT'
      '      [EventID]'
      '      ,[EventNum]'
      '      ,[Caption]'
      '      ,[SessionID]'
      '      ,[RallyOpenDT]'
      '      ,[StrokeID]'
      '      ,[RallyCloseDT]'
      '      ,[DistanceID]'
      '      ,[OpenDT]'
      '      ,[EventStatusID]'
      '      ,[CloseDT]'
      '      ,[ScheduleDT]'
      '  FROM [dbo].[Event]'
      'WHERE [SessionID] = :SESSIONID')
    Left = 344
    Top = 96
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 30
      end>
  end
  object tblSession: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SessionID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Session'
    UpdateOptions.KeyFields = 'SessionID'
    TableName = 'SwimClubMeet..Session'
    Left = 144
    Top = 96
  end
  object tblEvent: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EventID'
    Connection = SCM.scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Event'
    UpdateOptions.KeyFields = 'EventID'
    TableName = 'SwimClubMeet..Event'
    Left = 248
    Top = 96
  end
  object imgcolClone: TImageCollection
    Images = <
      item
        Name = 'Clone'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000014A494441546843ED993D6E02311085
              BFBD4E2E00220D54D4A4E50C697290349C216D52A7A301910B701DA2510A5628
              B647B36BAF40CFD54AF6BE99F7DEF867BD1D77DEBA3BCF1F1198DAC1A803AFC0
              16985522F0037C00BB127E84C006F82C018FD4FF027CE5B022040EC062A4044B
              3047E0796C02971E60448052D2D6EF8E1149C00DEEC93431C61DE3A1092C7BEA
              EC7BCF6E75A6762095A808389C718B949B0372C0A1746A881CC86D266E75E4C0
              9F02D9BD4A93784099E45E7597A91C9003FF2BA012D23E30706EA88454422AA1
              AB023A0BDD9E08DD2BC4803272C7D0596880CA3A8D96BE76527578AA78AD7EEB
              8A5DB3CFA397BB2902F64FC048B46896BC9148B6C82436B027E01D585762F10D
              BC01E7127E944009B759BF0834933A1128E740ABD5C6AEEE57512172045AAD36
              D508B4586D2C46550251679BBD17F947D62C394F2011F0A85473CC2F06826B31
              8E670DDF0000000049454E44AE426082}
          end>
      end>
    Left = 24
    Top = 96
  end
end
