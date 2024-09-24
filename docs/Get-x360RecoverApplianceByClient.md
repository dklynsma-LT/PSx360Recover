---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverApplianceByClient

## SYNOPSIS
Retrieves appliance information for a specified client from x360Recover.

## SYNTAX

```
Get-x360RecoverApplianceByClient [-clientId] <Int64> [[-includeDevices] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves appliance information for a specified client from the x360Recover system.
It can filter appliances based on the client ID and optionally include detailed information.

## EXAMPLES

### EXAMPLE 1
```
Get-x360RecoverApplianceByClient -clientId 12345
```

Retrieves appliance information for the client with ID 12345.

### EXAMPLE 2
```
Get-x360RecoverApplianceByClient -clientId 12345 -includeDetails $true
```

Retrieves detailed appliance information for the client with ID 12345.

## PARAMETERS

### -clientId
The ID of the client to retrieve appliance information for.
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

### -includeDevices
Include short appliance information to response or not

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_devices

Required: False
Position: 2
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

### System.Object. The appliance information retrieved from x360Recover.
## NOTES

## RELATED LINKS
