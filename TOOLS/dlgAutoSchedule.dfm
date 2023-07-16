object AutoSchedule: TAutoSchedule
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Auto-Schedule'
  ClientHeight = 365
  ClientWidth = 671
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
    Left = 447
    Top = 120
    Width = 70
    Height = 21
    Caption = '(MIN:SEC)'
  end
  object Label13: TLabel
    Left = 191
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
    Left = 34
    Top = 120
    Width = 305
    Height = 21
    Caption = 'The average turn-around time for each heat.'
  end
  object Label15: TLabel
    Left = 76
    Top = 169
    Width = 263
    Height = 21
    Caption = 'The interval that seperates each event.'
  end
  object Label16: TLabel
    Left = 447
    Top = 169
    Width = 70
    Height = 21
    Caption = '(MIN:SEC)'
  end
  object Label17: TLabel
    Left = 153
    Top = 70
    Width = 177
    Height = 21
    Caption = 'Event #1 commences at ...'
  end
  object Label19: TLabel
    Left = 199
    Top = 267
    Width = 140
    Height = 21
    Caption = 'Session finishes at ...'
  end
  object Label20: TLabel
    Left = 511
    Top = 267
    Width = 82
    Height = 21
    Caption = '(Estimated) '
  end
  object Label1: TLabel
    Left = 110
    Top = 219
    Width = 229
    Height = 21
    Alignment = taRightJustify
    Caption = 'Round events up to the nearest ...'
    Visible = False
  end
  object Label2: TLabel
    Left = 407
    Top = 219
    Width = 108
    Height = 21
    Caption = 'minute interval.'
    Visible = False
  end
  object btnInfo1: TVirtualImage
    Left = 503
    Top = 102
    Width = 25
    Height = 26
    ImageCollection = ImageCollection1
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 0
    ImageName = 'Info'
    OnClick = btnInfo1Click
    OnMouseLeave = btnInfoMouseLeave
  end
  object btnInfo2: TVirtualImage
    Left = 503
    Top = 147
    Width = 25
    Height = 26
    ImageCollection = ImageCollection1
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 0
    ImageName = 'Info'
    OnClick = btnInfo2Click
    OnMouseLeave = btnInfoMouseLeave
  end
  object Panel1: TPanel
    Left = 0
    Top = 319
    Width = 671
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 318
    ExplicitWidth = 667
    DesignSize = (
      671
      46)
    object btnCancel: TButton
      Left = 194
      Top = 8
      Width = 75
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
      ExplicitLeft = 190
    end
    object btnOk: TButton
      Left = 275
      Top = 8
      Width = 169
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'AUTO Schedule'
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 271
    end
  end
  object tpHeatInterval: TTimePicker
    Left = 345
    Top = 114
    Width = 96
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 1
    Time = 0.001388888888888889
    TimeFormat = 'nn:ss'
    OnChange = tpChange
  end
  object tpEventInterval: TTimePicker
    Left = 345
    Top = 163
    Width = 96
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 2
    Time = 0.003472222222222222
    TimeFormat = 'nn:ss'
    OnChange = tpChange
  end
  object tpEventStart: TTimePicker
    Left = 345
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
    Left = 345
    Top = 261
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
  object spinRoundUp: TSpinEdit
    Left = 345
    Top = 216
    Width = 56
    Height = 31
    Increment = 5
    MaxValue = 10
    MinValue = 0
    TabOrder = 5
    Value = 5
    Visible = False
    OnChange = spinRoundUpChange
  end
  object btnSessionStartTime: TButton
    Left = 511
    Top = 68
    Width = 131
    Height = 28
    Caption = 'Session Start'
    ImageIndex = 0
    ImageName = 'ClearBackSpace'
    Images = VirtualImageList1
    TabOrder = 6
    OnClick = btnSessionStartTimeClick
  end
  object qryEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'EventID'
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss'
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
      ''
      'SELECT MAX([Entrant].[TimeToBeat]) AS MaxSwimTime'
      '     , [Event].[EventID] AS EventID'
      '     , [HeatIndividual].[HeatID] AS HeatID     '
      'INTO #HeatTime'
      'FROM [SwimClubMeet].[dbo].[Entrant]'
      '    INNER JOIN [HeatIndividual]'
      '        ON [Entrant].[HeatID] = [HeatIndividual].[HeatID]'
      '    INNER JOIN [Event]'
      '        ON [HeatIndividual].[EventID] = [Event].[EventID]'
      'WHERE [Entrant].[TimeToBeat] IS NOT NULL'
      '      AND [Event].[SessionID] = @SessionID'
      'GROUP BY [Event].[EventID], [HeatIndividual].[HeatID];'
      ''
      'IF OBJECT_ID('#39'tempDB..#TOTHeatTime'#39', '#39'U'#39') IS NOT NULL'
      '    DROP TABLE #TOTHeatTime;'
      '    '
      
        'SELECT CONVERT(TIME, DATEADD(MILLISECOND,SUM(dbo.SwimTimeToMilli' +
        'seconds(MaxSwimTime) ) , 0), 114) AS TOTEvSwimTime, EventID'
      'INTO #TOTHeatTime'
      'FROM #HeatTime'
      'GROUP BY EventID'
      ''
      ''
      ''
      'SELECT [Event].EventID'
      '     , [Event].EventNum'
      '     , [Event].ScheduleDT'
      '     , Distance.Meters'
      '     , HeatCount'
      '     , TOTEvSwimTime'
      'FROM [Event]'
      '    INNER JOIN Distance'
      '        ON [Event].DistanceID = Distance.DistanceID'
      '    LEFT JOIN #CountHeats'
      '        ON [Event].[EventID] = #CountHeats.EventID'
      '    LEFT JOIN #TOTHeatTime'
      '        ON [Event].[EventID] = #TOTHeatTime.EventID'
      'WHERE SessionID = @SessionID'
      'ORDER BY EventNum;')
    Left = 56
    Top = 24
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object BalloonHint1: TBalloonHint
    Delay = 50
    Left = 32
    Top = 168
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Info'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000042E494441546843ED9947A815491486
              3FB72E0C881B130AAE467414845117868563449C3163405147174E7010441046
              712328C6013161CE19CC2E745C184031A12B41316D440C0BD7F20F558FBA7DBB
              6F5755973E1E78A0B9977BEB9C3A7F8513FE6E450B97562DDC7FBE0368EE1D4C
              B9035D8021407FA0BBF308E373E7B903FC07BC4A01BE2A801F8079C020E0A740
              876E0337801DC09340DDA6E1B100DA007F038B017DAF229F80F5C03A40DF8324
              06C04C6029D02B33D353E000F0D21C0FFBA9613A5E5D9DCFE940CF8CFE63602D
              B03B044128800DC09F9909AE03FB8DF39F3D276F0D08C40C6070464700E678DA
              090AA3E781518EE177C002E084EF6405E326005B810ECEFFBAF43D7CECFAEEC0
              26E077C7E023606A95CB97714EC1E030D0DBF9FDAE89680D71F800F8CDAC9035
              740C98ECB33A11638E02931CBD65C0EA4676CA004C312B636DFC9BD989081F4B
              5536038B9C51BA2B078BB41A015078549CB6D1E60AF073E9F469065C06861B53
              8A4ECA33B921B6118015C03FC68842E240E0751AFF4AAD74066E9AD0ABC12B01
              F95327450074A964C026A95F8153A5D3D60E9806FC627E92EEA1407DE99E343A
              5A7D2D605DC62E02A0CCF89751569C578D132A0AAF022E91230A97A1A29AC9E6
              09E52065FE1A2902700FE86B462A0A6D0F9D19980DEC327A4A4C4119D6E8CD07
              B699EFF7817E3E0054493E3303551EFC08F866D8ACFD8EE687B7110B201565EC
              074ED9A1E4A624D724793BE0AE5CE1E589742846CD0D26753B9907C03DFF2A15
              EC16C64C9E42C74DA475F7200F8022C67833F358E05C0A2F2AD818039C35FAA7
              9DC8F6FF4F7900DC0BDC0750DD13234381AB46F11A302CC688A98F1E165DE43C
              00EF817646419F1F23274E05A02DF0C1F8A0CFF66597D80520E5E02EC94C900A
              8092A95D442F00EE11521D14DBAFA602A0AA40F590A42E17945DE291C0A5663E
              4223808B2197D80DA3621C76363380B986B9901B5E6154F5B77A5C49954496EA
              08B9894C3DB4888326C93B426210543E4BAA94122900644B09311B3584585131
              77CB21AA628BB91400DC624E44D880EC712E022092C996AEB1E5740A006E39AD
              BB2932AD467C1B9A8911F4495500EA1F8E1B6F831B1AE9B997471C901A8B909C
              50058062BF76DE7245C12DA500649B7AD544AA8DBE85A8F6B11C5174532F47C5
              83EE753CFE9A9C909D26CB0DCD02F615AD5A192F24BD35C012C7C0D7E486B29C
              D046A737CFC5E003408A6780718E057144EA8E52D12CA251D43F5B2E48535D00
              46979D575F00B2B307D0765A51B213531D4AB7647D127DA2955692B2A29DF8A3
              CC79FD1F0240E317025B328653D3EB416D6C2800F92E567A7983171C6FCCD17A
              01E89174338F8E4A27F36E20EF05C72AE088CFCADB313100A4DBA25F31B90BA4
              84A37A4549CB1261BE0BA8E644BDB248B3900459633F7607F29C1421262022C2
              1ABD66155125C76B082A5FD4D9712901C4FA5049EF3B804ACB9740B9C5EFC017
              4EABDD310AD690EA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'ClearBackSpace'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000252494441546843ED98E13105311485
              CFAB0015A00274A00354800A50012A4005A80015D0012A400754C07C33C94C26
              93CDCB4B6E981D9B5F8FD9BD7BBF7BCF3DC9EE4C235FB391E7AF09E0AF3B3875
              60EA40630526093516B0F9F67FDF813549A7920E9A4B990EF029E946D2C950FC
              960E6C4A7A94B4DC29F930EC95A4E3D4736A01489AE481F88D4527562C012E25
              1DB9805F0EE4BD03C977103359EC9A0EEC4ABA0B02A34F807A2C7300A4F316E8
              FE411240BD96390095F709231D5C087DC60B5024765E48B62FE93671AD29002E
              70113C644FD2FD40F27EC0B1C0C33910D7CE8653D79A01C49639686B92CEDCDE
              E0F3CE41F8E4FDB5C072BD5F6600CF81657EB8DF29E98449238B1C449C3C128A
              37441380B8A25B925E0AB44D2587204A92E711CD00DB6EC3F2F932940095AE14
              04F786954E55DE44423809D2C16958AF953B6F0C11C2E7926FEE406C990C72ED
              6E9B8298977C330016B9E3CAC5C0A2FD5A8058F3842DB1D8A61940420CEBAA83
              E037108BAE54F239770AE3370110A87588536E43DC79166B32C43E48AD8DE6AC
              3267B1A61DF0C190CF86FB8339404AB98DACC4E74B209A25E40170A027494BEE
              1F8B1C25726E1343C4FB8C1900792F729803968E9558A587609F61E6C2CE9A02
              00115BEB7AE6380D70E9AECD75BC14C5B23407C05A99012F25803856F75AE600
              296B1DD52BA5AF74F852DFBA4BE7BAD7A5033C1029F941ED259F302EAFAFC9EF
              4F355F2586ACB52788F9872D9F2C476D1C243C1A588250796C36F9558E07B574
              C032D1EA58134075E98C6E9C3A6054C8EA305307AA4B6774E3D401A342568719
              7D077E00C2448C31F447C64B0000000049454E44AE426082}
          end>
      end>
    Left = 32
    Top = 224
  end
  object VirtualImageList1: TVirtualImageList
    Images = <
      item
        CollectionIndex = 1
        CollectionName = 'ClearBackSpace'
        Name = 'ClearBackSpace'
      end>
    ImageCollection = ImageCollection1
    Width = 24
    Height = 24
    Left = 40
    Top = 72
  end
end
