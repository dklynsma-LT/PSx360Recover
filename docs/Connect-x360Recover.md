---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Connect-x360Recover

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### Default Auth (Default)
```
Connect-x360Recover [-ApiKey <String>] [-Instance <String>] [-UseSecretManagement] [-VaultName <String>]
 [-WriteToSecretVault] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Secret Vault Write
```
Connect-x360Recover [-ApiKey <String>] [-Instance <String>] [-UseSecretManagement] -VaultName <String>
 [-WriteToSecretVault] [-SecretPrefix <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Secret Vault Read
```
Connect-x360Recover [-UseSecretManagement] -VaultName <String> [-WriteToSecretVault] [-ReadFromSecretVault]
 [-SecretPrefix <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
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

### -ApiKey
{{ Fill ApiKey Description }}

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
{{ Fill Instance Description }}

```yaml
Type: String
Parameter Sets: Default Auth, Secret Vault Write
Aliases:
Accepted values: prod, mock

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReadFromSecretVault
{{ Fill ReadFromSecretVault Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Secret Vault Read
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretPrefix
{{ Fill SecretPrefix Description }}

```yaml
Type: String
Parameter Sets: Secret Vault Write, Secret Vault Read
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSecretManagement
{{ Fill UseSecretManagement Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VaultName
{{ Fill VaultName Description }}

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
{{ Fill WriteToSecretVault Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Default Auth, Secret Vault Read
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: SwitchParameter
Parameter Sets: Secret Vault Write
Aliases:

Required: True
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

### None

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
