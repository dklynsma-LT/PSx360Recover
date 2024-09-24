---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverClient

## SYNOPSIS
Retrieves client information from x360Recover.

## SYNTAX

### Multi (Default)
```
Get-x360RecoverClient [[-includeAppliances] <Boolean>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### Single
```
Get-x360RecoverClient [-clientId] <Int64> [[-includeAppliances] <Boolean>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves client information from the x360Recover system.
It can retrieve information for a specific client by ID or for multiple clients.
Optionally, it can include short appliance information in the response.

## EXAMPLES

### EXAMPLE 1
```
Get-x360RecoverClient -clientId 12345
```

Retrieves information for the client with ID 12345.

### EXAMPLE 2
```
Get-x360RecoverClient -includeAppliances $true
```

Retrieves information for all clients and includes short appliance information in the response.

## PARAMETERS

### -clientId
The ID of the client to retrieve information for.
This parameter is used in the 'Single' parameter set and can be piped.

```yaml
Type: Int64
Parameter Sets: Single
Aliases: client_id, id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -includeAppliances
If specified, includes short appliance information in the response.
This parameter can be used in both 'Single' and 'Multi' parameter sets.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_appliances

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

### System.Object. The client information retrieved from x360Recover.
## NOTES

## RELATED LINKS
