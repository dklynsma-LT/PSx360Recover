---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Connect-x360Recover

## SYNOPSIS
Connects to the x360Recover API instance.

## SYNTAX

### Default Auth (Default)
```
Connect-x360Recover [-ApiKey <String>] [-Instance <String>] [-UseSecretManagement] [-VaultName <String>]
 [-WriteToSecretVault] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Secret Vault Write
```
Connect-x360Recover [-ApiKey <String>] [-Instance <String>] [-UseSecretManagement] -VaultName <String>
 [-WriteToSecretVault] [-VaultEntryPrefix <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Secret Vault Read
```
Connect-x360Recover [-UseSecretManagement] -VaultName <String> [-WriteToSecretVault] [-ReadFromSecretVault]
 [-VaultEntryPrefix <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function initializes the module, checks for the SecretManagement module, and retrieves secrets from a secret vault if specified.
It also sets up the connection information for the x360Recover API instance.

## EXAMPLES

### EXAMPLE 1
```
Connect-x360Recover -Api 'your-api-key' -Instance 'prod'
```

Connects to the production instance of the x360Recover API using the provided API key.

### EXAMPLE 2
```
Connect-x360Recover -UseSecretManagement -VaultName 'MyVault' -ReadFromSecretVault
```

Connects to the x360Recover API using credentials stored in the 'MyVault' secret vault.

## PARAMETERS

### -ApiKey
APi Key for authentication

```yaml
Type: String
Parameter Sets: Default Auth, Secret Vault Write
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Instance
The Axcient API Instance to connect to.
Choose from 'prod' or 'mock'.

```yaml
Type: String
Parameter Sets: Default Auth, Secret Vault Write
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSecretManagement
Switch to use the SecretManagement module to store and retrieve the API key.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -VaultName
The name of the secret vault to use.

```yaml
Type: String
Parameter Sets: Default Auth
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: Secret Vault Write, Secret Vault Read
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WriteToSecretVault
Switch to write the updated credentials to the secret vault.

```yaml
Type: SwitchParameter
Parameter Sets: Default Auth, Secret Vault Read
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: SwitchParameter
Parameter Sets: Secret Vault Write
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReadFromSecretVault
Switch to read the credentials from the secret vault.

```yaml
Type: SwitchParameter
Parameter Sets: Secret Vault Read
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -VaultEntryPrefix
The prefix to add to the name of the secrets stored in the secret vault.

```yaml
Type: String
Parameter Sets: Secret Vault Write, Secret Vault Read
Aliases:

Required: False
Position: Named
Default value: X360Recover
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

### System.Void
## NOTES
Ensure that the SecretManagement module is installed and a secret vault is created if using the secret management features.

## RELATED LINKS
