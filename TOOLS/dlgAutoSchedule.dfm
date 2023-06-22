object AutoSchedule: TAutoSchedule
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Auto-Schedule'
  ClientHeight = 331
  ClientWidth = 668
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 21
  object Label4: TLabel
    Left = 456
    Top = 120
    Width = 49
    Height = 21
    Caption = '(MINS)'
  end
  object Label13: TLabel
    Left = 189
    Top = 18
    Width = 289
    Height = 25
    Caption = 'Auto schedule swimming events.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 58
    Top = 120
    Width = 305
    Height = 21
    Caption = 'The average turn-around time for each heat.'
  end
  object Label15: TLabel
    Left = 100
    Top = 169
    Width = 263
    Height = 21
    Caption = 'The interval that seperates each event.'
  end
  object Label16: TLabel
    Left = 456
    Top = 169
    Width = 49
    Height = 21
    Caption = '(MINS)'
  end
  object Label17: TLabel
    Left = 177
    Top = 70
    Width = 177
    Height = 21
    Caption = 'Event #1 commences at ...'
  end
  object Label19: TLabel
    Left = 223
    Top = 227
    Width = 140
    Height = 21
    Caption = 'Session finishes at ...'
  end
  object Label20: TLabel
    Left = 535
    Top = 227
    Width = 82
    Height = 21
    Caption = '(Estimated) '
  end
  object Panel1: TPanel
    Left = 0
    Top = 285
    Width = 668
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 622
    ExplicitWidth = 465
    DesignSize = (
      668
      46)
    object btnCancel: TButton
      Left = 209
      Top = 8
      Width = 75
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOk: TButton
      Left = 290
      Top = 8
      Width = 169
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'AUTO Schedule'
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
  object tpHeatInterval: TTimePicker
    Left = 369
    Top = 114
    Width = 81
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 1
    Time = 0.001388888888888889
    TimeFormat = 'nn'
    OnChange = tpChange
  end
  object tpEventInterval: TTimePicker
    Left = 369
    Top = 163
    Width = 81
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 2
    Time = 0.003472222222222222
    TimeFormat = 'nn'
    OnChange = tpChange
  end
  object tpEventStart: TTimePicker
    Left = 369
    Top = 64
    Width = 160
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 3
    Time = 0.770833333333333400
    TimeFormat = 'HH:nn ampm'
    OnChange = tpChange
  end
  object TimePickerSessionEnds: TTimePicker
    Left = 369
    Top = 221
    Width = 160
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 4
    Time = 0.770833333333333400
    TimeFormat = 'hh:nn ampm'
  end
  object qrySession: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SessionID AS INTEGER;'
      'SET @SessionID = :SESSIONID;'
      ''
      'SELECT SessionStart FROM SESSION WHERE SessionID = @SessionID;')
    Left = 32
    Top = 216
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qryEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EventID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.UpdateTableName = 'SwimClubMeet.dbo.Event'
    UpdateOptions.KeyFields = 'EventID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      '-- Drop a temporary table called '#39'#CountHeats'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'tempDB..#CountHeats'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #CountHeats;'
      ''
      'DECLARE @SessionID AS INTEGER;'
      'SET @SessionID = :SESSIONID;'
      ''
      
        '-- Create the temporary table from a physical table called '#39'Heat' +
        'Indivual'#39' in schema '#39'dbo'#39' in database '#39'SwimClubMeet'#39
      'SELECT COUNT(HeatID) AS HeatCount'
      '     , [HeatIndividual].EventID'
      'INTO #CountHeats'
      'FROM [SwimClubMeet].[dbo].[HeatIndividual]'
      '    INNER JOIN [Event]'
      '        ON [HeatIndividual].[EventID] = [Event].[EventID]'
      'WHERE [Event].[SessionID] = @SessionID'
      'GROUP BY [HeatIndividual].[EventID]'
      ''
      '-- calculate swimming time for heat heat  for each event'
      ''
      'IF OBJECT_ID('#39'tempDB..#HeatTime'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #HeatTime;'
      '    '
      '--  TODO ... TODO ...'
      ''
      'SELECT [Event].EventID'
      '     , [Event].EventNum'
      '     , [Event].ScheduleDT'
      '     , Distance.Meters'
      '     , HeatCount'
      '     , HeatTimeTOT'
      'FROM [Event]'
      '    INNER JOIN Distance'
      '        ON [Event].DistanceID = Distance.DistanceID'
      '    LEFT JOIN #CountHeats'
      '        ON [Event].[EventID] = #CountHeats.EventID'
      '    LEFT JOIN #HeatTime'
      '        ON [Event].[EventID] = #HeatTime.EventID'
      'WHERE SessionID = @SessionID'
      'ORDER BY EventNum;')
    Left = 112
    Top = 216
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
