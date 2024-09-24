---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverBackupJobHistory

## SYNOPSIS
Retrieves the backup job history for a specified client, device, and job.

## SYNTAX

```
Get-x360RecoverBackupJobHistory [-clientId] <Int64> [-deviceId] <Int64> [-jobId] <Int64> [[-limit] <Int64>]
 [[-offset] <Int64>] [[-jobsAfterUnixEpoch] <Int64>] [[-jobsAfter] <DateTime>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves the backup job history for a specified client, device, and job from the x360Recover system.
It supports pagination and filtering by start time.

## EXAMPLES

### EXAMPLE 1
```
Get-x360RecoverBackupJobHistory -clientId 123 -deviceId 456 -jobId 789
```

Retrieves the backup job history for the specified client, device, and job.

### EXAMPLE 2
```
Get-x360RecoverBackupJobHistory -clientId 123 -deviceId 456 -jobId 789 -limit 10 -offset 20
```

Retrieves the backup job history for the specified client, device, and job with pagination.

### EXAMPLE 3
```
Get-x360RecoverBackupJobHistory -clientId 123 -deviceId 456 -jobId 789 -jobsAfter (Get-Date "2023-01-01")
```

Retrieves the backup job history for the specified client, device, and job starting after January 1, 2023.

## PARAMETERS

### -clientId
The ID of the client to retrieve backup job history for.
This parameter is mandatory.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: client_id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -deviceId
The ID of the device to retrieve backup job history for.
This parameter is mandatory.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: device_id, id

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -jobId
The ID of the job to retrieve backup job history for.
This parameter is mandatory.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: job_id

Required: True
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limit
The maximum number of records to return for pagination.
This parameter is optional.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -offset
The number of records to skip for pagination.
This parameter is optional.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -jobsAfterUnixEpoch
The minimum backup start time value as a Unix timestamp.
This parameter is optional.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: starttime_begin, startTimeBegin

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -jobsAfter
The minimum backup start time value as a DateTime object.
This parameter is optional.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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

### System.Int32. The client ID, device ID, and job ID can be piped to this cmdlet.
## OUTPUTS

### System.Object. The backup job history information retrieved from x360Recover.
## NOTES

## RELATED LINKS
