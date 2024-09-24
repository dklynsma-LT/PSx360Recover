---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverBackupJob

## SYNOPSIS
Retrieves backup job information for a specified client and device.

## SYNTAX

### Multi (Default)
```
Get-x360RecoverBackupJob [-clientId] <Int64> [-deviceId] <Int64> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### Single
```
Get-x360RecoverBackupJob [-clientId] <Int64> [-deviceId] <Int64> [-jobId] <Int64>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves backup job information for a specified client and device from the x360Recover system.
It can retrieve information for a specific job by ID or for all jobs associated with a client and device.

## EXAMPLES

### EXAMPLE 1
```
Get-x360RecoverBackupJob -clientId 12345 -deviceId 67890
```

Retrieves all backup jobs for the specified client and device.

### EXAMPLE 2
```
Get-x360RecoverBackupJob -clientId 12345 -deviceId 67890 -jobId 112233
```

Retrieves the backup job with the specified job ID for the specified client and device.

## PARAMETERS

### -clientId
The unique ID of the client.
This parameter is mandatory and can be piped.

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
The unique ID of the device.
This parameter is mandatory and can be piped.

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
The unique ID of the job.
This parameter is mandatory for the 'Single' parameter set and can be piped.

```yaml
Type: Int64
Parameter Sets: Single
Aliases: job_id

Required: True
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
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

### System.Int64. The client ID, device ID, and job ID can be piped to this cmdlet.
## OUTPUTS

### System.Object. The backup job information retrieved from x360Recover.
## NOTES

## RELATED LINKS
