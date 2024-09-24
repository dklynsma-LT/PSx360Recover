---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverDeviceByClient

## SYNOPSIS
Retrieves device information for a specified client from x360Recover.

## SYNTAX

```
Get-x360RecoverDeviceByClient [-clientId] <Int64> [[-serviceId] <String>] [[-d2cOnly] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves device information for a specified client from the x360Recover system.
It can filter devices based on the service ID and whether they are D2C (Direct-to-Cloud) devices.

## EXAMPLES

### EXAMPLE 1
```
Get-x360RecoverDeviceByClient -clientId 12345
```

Retrieves device information for the client with ID 12345.

### EXAMPLE 2
```
Get-x360RecoverDeviceByClient -clientId 12345 -serviceId "ABCD"
```

Retrieves device information for the client with ID 12345 and service ID "ABCD".

### EXAMPLE 3
```
Get-x360RecoverDeviceByClient -clientId 12345 -d2cOnly $true
```

Retrieves only D2C devices for the client with ID 12345.

## PARAMETERS

### -clientId
The ID of the client to retrieve device information for.
This parameter is mandatory and can be piped.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: client_id, id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -serviceId
The SID of the service (4 symbols).
This parameter is optional.

```yaml
Type: String
Parameter Sets: (All)
Aliases: service_id

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -d2cOnly
If specified, includes only D2C (Direct-to-Cloud) devices.
This parameter is optional.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: d2c_only

Required: False
Position: 3
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

### System.Int64. The client ID can be piped to this cmdlet.
## OUTPUTS

### System.Object. The device information retrieved from x360Recover.
## NOTES

## RELATED LINKS
