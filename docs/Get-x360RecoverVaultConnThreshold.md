---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverVaultConnThreshold

## SYNOPSIS
Retrieves the connectivity threshold information for a specified x360Recover vault.

## SYNTAX

```
Get-x360RecoverVaultConnThreshold [-vaultId] <Int32> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves the connectivity threshold information for a specified x360Recover vault by its ID.
It sends a GET request to the x360Recover API and returns the connectivity threshold details.

## EXAMPLES

### EXAMPLE 1
```
Get-x360RecoverVaultConnThreshold -vaultId 12345
```

Retrieves the connectivity threshold information for the vault with ID 12345.

## PARAMETERS

### -vaultId
The ID of the vault to retrieve connectivity threshold information for.
This parameter is mandatory and can be piped.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: vault_id, id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
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

### System.Int32. The vault ID can be piped to this cmdlet.
## OUTPUTS

### System.Object. The connectivity threshold information for the specified vault.
## NOTES

## RELATED LINKS
