---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Get-x360RecoverVault

## SYNOPSIS
Retrieves information about x360Recover vaults.

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
This cmdlet retrieves information about x360Recover vaults.
It can retrieve information for a specific vault by ID or for multiple vaults based on various filters such as vault type, active status, URL presence, and limit.
Optionally, it can include the device list for each vault.

## EXAMPLES

### EXAMPLE 1
```
Get-x360RecoverVault -vaultId 12345
```

Retrieves information for the vault with ID 12345.

### EXAMPLE 2
```
Get-x360RecoverVault -vaultType 'Private' -active $true -limit 10
```

Retrieves information for up to 10 active private vaults.

### EXAMPLE 3
```
Get-x360RecoverVault -withUrl $true -includeDevices $true
```

Retrieves information for vaults with a URL present and includes the device list for each vault.

## PARAMETERS

### -vaultId
The ID of the vault to return.
This parameter is used in the 'Single' parameter set and can be piped.

```yaml
Type: Int32
Parameter Sets: Single
Aliases: vault_id, id

Required: False
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -vaultType
Filter to return only private or only cloud vaults.
This parameter is used in the 'Multi' parameter set.

```yaml
Type: String
Parameter Sets: Multi
Aliases: vault_type

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -active
Filter to return only vaults with active status.
This parameter is used in the 'Multi' parameter set.

```yaml
Type: Boolean
Parameter Sets: Multi
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -withUrl
Filter to return only vaults with a URL present.
This parameter is used in the 'Multi' parameter set.

```yaml
Type: Boolean
Parameter Sets: Multi
Aliases: with_url

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
The maximum number of vaults to return in the response.
This parameter is used in the 'Multi' parameter set.

```yaml
Type: Int64
Parameter Sets: Multi
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -includeDevices
If specified, returns the device list for each vault.
This parameter is used in the 'Multi' parameter set.

```yaml
Type: Boolean
Parameter Sets: Multi
Aliases: include_devices

Required: False
Position: 6
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

### System.Int32. The vault ID can be piped to this cmdlet.
## OUTPUTS

### System.Object. The information about the specified vault(s).
## NOTES

## RELATED LINKS
