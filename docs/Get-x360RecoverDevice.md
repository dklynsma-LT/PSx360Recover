---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverDevice

## SYNOPSIS
Retrieves AutoVerify information for a specified device.

## SYNTAX

### Multi (Default)
```
Get-x360RecoverDevice [[-limit] <Int64>] [[-offset] <Int64>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### Single
```
Get-x360RecoverDevice [[-deviceId] <Int64>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves AutoVerify information for a specified device from the x360Recover system.
It sends a GET request to the x360Recover API and returns the AutoVerify details for the given device ID.

## EXAMPLES

### EXAMPLE 1
```
Get-x360RecoverDeviceAutoVerify -deviceId 12345
```

Retrieves AutoVerify information for the device with ID 12345.

## PARAMETERS

### -deviceId
The ID of the device to retrieve AutoVerify information for.
This parameter is mandatory and can be piped.

```yaml
Type: Int64
Parameter Sets: Single
Aliases: device_id, id

Required: False
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -limit
Records limit for pagination

```yaml
Type: Int64
Parameter Sets: Multi
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -offset
Records offset for pagination

```yaml
Type: Int64
Parameter Sets: Multi
Aliases:

Required: False
Position: 3
Default value: 0
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

### System.Int64. The device ID can be piped to this cmdlet.
## OUTPUTS

### System.Object. The AutoVerify information retrieved from x360Recover.
## NOTES

## RELATED LINKS
