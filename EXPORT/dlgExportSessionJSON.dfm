object ExportSessionJSON: TExportSessionJSON
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Export Session ...'
  ClientHeight = 680
  ClientWidth = 722
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 21
  object pnlFooter: TPanel
    Left = 0
    Top = 633
    Width = 722
    Height = 47
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    ExplicitTop = 471
    ExplicitWidth = 595
    object btnOK: TButton
      Left = 633
      Top = 16
      Width = 89
      Height = 30
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 529
      Top = 16
      Width = 89
      Height = 30
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object dbgridJSON: TDBGrid
    Left = 0
    Top = 41
    Width = 722
    Height = 592
    Align = alClient
    DataSource = dsJSON
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack, dgThumbTracking]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 722
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 595
    object lblDescription: TLabel
      Left = 221
      Top = 0
      Width = 279
      Height = 21
      Alignment = taCenter
      Caption = 'Save the selected session to a JSON file?'
    end
    object lblPBDescription: TLabel
      Left = 132
      Top = 18
      Width = 458
      Height = 17
      Alignment = taCenter
      Caption = 
        'Personal best is calculated at time of session, prior to entrant' +
        ' swimming event.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object savedlgJSON: TSaveDialog
    Left = 232
    Top = 48
  end
  object qryJSON: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'EventNum;HeatNum;Lane'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayTime]
    FormatOptions.FmtDisplayDateTime = 'yyyy-mm-dd HH:MM'
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      '          '
      '          '
      '          '
      '          SELECT [Session].[SessionID],'
      '          [Session].SessionStart,'
      '          [Event].EventID,'
      '          [Event].EventNum,'
      '          [Event].DistanceID,'
      '          [Event].StrokeID,'
      '          [Entrant].[HEATID],'
      '          [HeatIndividual].HeatNum,'
      '          [Entrant].Lane, '
      '          [Entrant].MemberID,'
      '          [Member].FirstName,'
      '          [Member].MiddleInitial,'
      '          [Member].LastName,'
      '          [Member].DOB,'
      '          [Member].GenderID,'
      '          [Member].RegisterNum, '
      '          [Member].MembershipNum,'
      '          [Member].HouseID,'
      '          CONCAT(FirstName, '#39' '#39', LastName) AS FNAME,'
      
        '          CONCAT(distance.caption, '#39' '#39', stroke.caption) AS DISTS' +
        'TROKE,'
      '          RaceTime,'
      '          PersonalBest'
      '          FROM [dbo].[Session]'
      
        '          LEFT JOIN [Event] ON [Session].SessionID = [Event].Ses' +
        'sionID'
      
        '          LEFT JOIN [Stroke] ON [Event].StrokeID = Stroke.Stroke' +
        'ID'
      
        '          LEFT JOIN [Distance] ON [Event].DistanceID = Distance.' +
        'DistanceID'
      
        '          LEFT JOIN [HeatIndividual] ON [HeatIndividual].[EventI' +
        'D] = [Event].EventID'
      
        '          LEFT JOIN [Entrant] ON [HeatIndividual].[HeatID] = [En' +
        'trant].[HEATID]'
      
        '          LEFT JOIN [Member] ON [Entrant].[MemberID] = [Member].' +
        '[MemberID]'
      
        '          WHERE [Session].SessionID = :SESSIONID AND Entrant.Mem' +
        'berID IS NOT NULL'
      '          AND RaceTime IS NOT NULL;')
    Left = 152
    Top = 48
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 116
      end>
    object qryJSONSessionID: TFDAutoIncField
      FieldName = 'SessionID'
      Origin = 'SessionID'
      ProviderFlags = [pfInWhere, pfInKey]
      Visible = False
    end
    object qryJSONSessionStart: TSQLTimeStampField
      FieldName = 'SessionStart'
      Origin = 'SessionStart'
      Visible = False
      DisplayFormat = 'yyyy-mm-dd HH:MM'
    end
    object qryJSONEventID: TFDAutoIncField
      FieldName = 'EventID'
      Origin = 'EventID'
      Visible = False
    end
    object qryJSONEventNum: TIntegerField
      DisplayLabel = 'Ev#'
      DisplayWidth = 3
      FieldName = 'EventNum'
      Origin = 'EventNum'
    end
    object qryJSONDistanceID: TIntegerField
      FieldName = 'DistanceID'
      Origin = 'DistanceID'
      Visible = False
    end
    object qryJSONStrokeID: TIntegerField
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
      Visible = False
    end
    object qryJSONHEATID: TIntegerField
      FieldName = 'HEATID'
      Origin = 'HEATID'
      Visible = False
    end
    object qryJSONHeatNum: TIntegerField
      DisplayLabel = 'Ht#'
      DisplayWidth = 3
      FieldName = 'HeatNum'
      Origin = 'HeatNum'
    end
    object qryJSONLane: TIntegerField
      DisplayWidth = 4
      FieldName = 'Lane'
      Origin = 'Lane'
    end
    object qryJSONMemberID: TIntegerField
      FieldName = 'MemberID'
      Origin = 'MemberID'
      Visible = False
    end
    object qryJSONFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'FirstName'
      Visible = False
      Size = 128
    end
    object qryJSONMiddleInitial: TWideStringField
      FieldName = 'MiddleInitial'
      Origin = 'MiddleInitial'
      Visible = False
      Size = 4
    end
    object qryJSONLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'LastName'
      Visible = False
      Size = 128
    end
    object qryJSONDOB: TSQLTimeStampField
      FieldName = 'DOB'
      Origin = 'DOB'
      Visible = False
      DisplayFormat = 'yyyy-mm-dd HH:MM'
    end
    object qryJSONGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
      Visible = False
    end
    object qryJSONRegisterNum: TIntegerField
      FieldName = 'RegisterNum'
      Origin = 'RegisterNum'
      Visible = False
    end
    object qryJSONMembershipNum: TIntegerField
      FieldName = 'MembershipNum'
      Origin = 'MembershipNum'
      Visible = False
    end
    object qryJSONHouseID: TIntegerField
      FieldName = 'HouseID'
      Origin = 'HouseID'
      Visible = False
    end
    object qryJSONFNAME: TWideStringField
      DisplayLabel = 'Swimmer'
      DisplayWidth = 22
      FieldName = 'FNAME'
      Origin = 'FNAME'
      ReadOnly = True
      Required = True
      Size = 257
    end
    object qryJSONDISTSTROKE: TWideStringField
      DisplayLabel = 'Event'
      DisplayWidth = 16
      FieldName = 'DISTSTROKE'
      Origin = 'DISTSTROKE'
      ReadOnly = True
      Required = True
      Size = 257
    end
    object qryJSONRaceTime: TTimeField
      DisplayLabel = 'Race-Time'
      FieldName = 'RaceTime'
      Origin = 'RaceTime'
      DisplayFormat = 'nn:ss.zzz'
    end
    object qryJSONPersonalBest: TTimeField
      DisplayLabel = 'PB'
      FieldName = 'PersonalBest'
      Origin = 'PersonalBest'
      DisplayFormat = 'nn:ss.zzz'
    end
  end
  object dsJSON: TDataSource
    DataSet = qryJSON
    Left = 320
    Top = 48
  end
end
