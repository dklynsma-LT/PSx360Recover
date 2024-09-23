---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverAppliance

## SYNOPSIS
{{ Fill in the Synopsis }}

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
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -applianceId
{{ Fill applianceId Description }}

```yaml
Type: Int64
Parameter Sets: Single
Aliases: appliance_id, id

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -includeDevices
{{ Fill includeDevices Description }}

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

### -serviceId
{{ Fill serviceId Description }}

```yaml
Type: String
Parameter Sets: Multi
Aliases: service_id

Required: False
Position: 1
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
