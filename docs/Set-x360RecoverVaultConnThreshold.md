---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Set-x360RecoverVaultConnThreshold

## SYNOPSIS
Sets the connectivity threshold for a specified vault in x360Recover.

## SYNTAX

```
Set-x360RecoverVaultConnThreshold [-vaultId] <Int64> [-threshold] <Int32> [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet sets the connectivity threshold for a specified vault in the x360Recover system.
It sends a POST request to the x360Recover API with the provided vault ID and threshold value.

## EXAMPLES

### EXAMPLE 1
```
Set-x360RecoverVaultConnThreshold -vaultId 12345 -threshold 10
```

Sets the connectivity threshold to 10 for the vault with ID 12345.

## PARAMETERS

### -vaultId
The ID of the vault to set the connectivity threshold for.
This parameter is mandatory and can be piped.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: vault_id, id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -threshold
The connectivity threshold value to set for the vault.
This parameter is mandatory.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
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

### System.Int64. The vault ID can be piped to this cmdlet.
### System.Int32. The threshold value can be piped to this cmdlet.
## OUTPUTS

### System.Object. The response from the x360Recover API.
## NOTES

## RELATED LINKS
