---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverAppliance

## SYNOPSIS
Retrieves information about x360Recover appliances.

## SYNTAX

### Multi (Default)
```
Get-x360RecoverAppliance [[-serviceId] <String>] [[-includeDevices] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Single
```
Get-x360RecoverAppliance [-applianceId] <Int64> [[-includeDevices] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves information about x360Recover appliances.
It can retrieve information for a specific appliance by ID or for all appliances.
Optionally, it can include short appliance information in the response.

## EXAMPLES

### EXAMPLE 1
```
Get-x360RecoverAppliance -applianceId 12345
```

Retrieves information for the appliance with ID 12345.

### EXAMPLE 2
```
Get-x360RecoverAppliance -serviceId "ABCD"
```

Retrieves information for all appliances associated with the service ID "ABCD".

### EXAMPLE 3
```
Get-x360RecoverAppliance -includeDevices $true
```

Retrieves information for all appliances and includes short appliance information in the response.

## PARAMETERS

### -applianceId
The ID of the appliance to return.
This parameter is mandatory for the 'Single' parameter set and can be piped.

```yaml
Type: Int64
Parameter Sets: Single
Aliases: appliance_id, id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -serviceId
Unique serial number of the service (4 symbols).
This parameter is used in the 'Multi' parameter set.

```yaml
Type: String
Parameter Sets: Multi
Aliases: service_id

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -includeDevices
Include short appliance information in the response or not.
This parameter is optional.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_devices

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

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
