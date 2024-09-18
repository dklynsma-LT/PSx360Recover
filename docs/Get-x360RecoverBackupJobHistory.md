---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverBackupJobHistory

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

```
Get-x360RecoverBackupJobHistory [-clientId] <Int64> [-deviceId] <Int64> [-jobId] <Int64> [[-limit] <Int64>]
 [[-offset] <Int64>] [[-jobStartTimeUnixEpoch] <Int64>] [[-jobStartTime] <DateTime>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -clientId
{{ Fill clientId Description }}

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: client_id

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -deviceId
{{ Fill deviceId Description }}

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: device_id, id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -jobId
{{ Fill jobId Description }}

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: job_id

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -jobStartTime
{{ Fill jobStartTime Description }}

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -jobStartTimeUnixEpoch
{{ Fill jobStartTimeUnixEpoch Description }}

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: starttime_begin, startTimeBegin

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
{{ Fill limit Description }}

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -offset
{{ Fill offset Description }}

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int64

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
