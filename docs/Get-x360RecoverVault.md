---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverVault

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### Multi (Default)
```
Get-x360RecoverVault [[-vaultType] <String>] [[-active] <Boolean>] [[-withUrl] <Boolean>] [[-limit] <Int64>]
 [[-includeDevices] <Boolean>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Single
```
Get-x360RecoverVault [[-vaultId] <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
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

### -active
{{ Fill active Description }}

```yaml
Type: Boolean
Parameter Sets: Multi
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -includeDevices
{{ Fill includeDevices Description }}

```yaml
Type: Boolean
Parameter Sets: Multi
Aliases: include_devices

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
Parameter Sets: Multi
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vaultId
{{ Fill vaultId Description }}

```yaml
Type: Int32
Parameter Sets: Single
Aliases: vault_id, id

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -vaultType
{{ Fill vaultType Description }}

```yaml
Type: String
Parameter Sets: Multi
Aliases: vault_type
Accepted values: Private, Cloud

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -withUrl
{{ Fill withUrl Description }}

```yaml
Type: Boolean
Parameter Sets: Multi
Aliases: with_url

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

### System.Int32

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
