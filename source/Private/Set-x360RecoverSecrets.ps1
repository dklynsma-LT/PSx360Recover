function Set-x360RecoverSecrets {
<#
.SYNOPSIS
    Sets the x360Recover connection information in a secret vault.

.DESCRIPTION
    This cmdlet sets the x360Recover connection information, including the URL, instance name, and API key, in a specified secret vault. It supports reading from and writing to the secret vault using the SecretManagement module.

.PARAMETER URL
    The URL of the x360Recover API instance.

.PARAMETER Instance
    The x360Recover instance name.

.PARAMETER ApiKey
    The client secret of the application.

.PARAMETER UseSecretManagement
    Use the Key Vault to store the connection information. This parameter is mandatory.

.PARAMETER VaultName
    The name of the secret vault to use.

.PARAMETER WriteToSecretVault
    Whether to write updated connection information to the secret vault.

.PARAMETER ReadFromSecretVault
    Whether to read the connection information from the secret vault.

.PARAMETER SecretPrefix
    The prefix to use for the secret names. Default is 'x360Recover'.

.EXAMPLE
    PS> Set-x360RecoverSecrets -URL "https://axapi.axcient.com/x360recover" -Instance "prod" -ApiKey "your-api-key" -UseSecretManagement -VaultName "MyVault" -WriteToSecretVault

    Sets the x360Recover connection information in the "MyVault" secret vault.

.INPUTS
    None. You cannot pipe objects to this cmdlet.

.OUTPUTS
    System.Void. This cmdlet does not produce any output.

#>
	[CmdletBinding()]
	[OutputType([System.Void])]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification = 'Private function - no need to support.')]
	# Suppress the PSSA warning about using ConvertTo-SecureString with -AsPlainText. There's no viable alternative.
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText', '', Justification = 'No viable alternative.')]
	# Suppress the PSSA warning about invoking empty members which is caused by our use of dynamic member names. This is a false positive.
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidInvokingEmptyMembers', '', Justification = 'False positive.')]
	param(
		# The URL of the x360Recover API instance.
		[URI]$URL,
		# The x360Recover instance name.
		[String]$Instance,
		# The client secret of the application.
		[String]$ApiKey,
		# Use the Key Vault to store the connection information.
		[Parameter(Mandatory)]
		[Switch]$UseSecretManagement,
		# The name of the secret vault to use.
		[String]$VaultName,
		# Whether to write updated connection information to the secret vault.
		[Switch]$WriteToSecretVault,
		# Whether to read the connection information from the secret vault.
		[Switch]$ReadFromSecretVault,
		# The prefix to use for the secret names.
		[String]$SecretPrefix = 'x360Recover'
	)
	# Check if the secret vault exists.
	$SecretVault = Get-SecretVault -Name $VaultName -ErrorAction SilentlyContinue
	if ($null -eq $SecretVault) {
		Write-Error ('Secret vault {0} does not exist.' -f $VaultName)
		exit 1
	}
	# Make sure we've been told to write to the secret vault.
	if ($false -eq $WriteToKeyVault) {
		Write-Error 'WriteToKeyVault must be specified.'
		exit 1
	}
	# Write the connection information to the secret vault.
	$Secrets = [Hashtable]@{}
	if ($null -ne $Script:x360RConnectionInformation.URL) {
		$Secrets.('{0}URL' -f $SecretPrefix) = $Script:x360RConnectionInformation.URL
	}
	if ($null -ne $Script:x360RConnectionInformation.Instance) {
		$Secrets.('{0}Instance' -f $SecretPrefix) = $Script:x360RConnectionInformation.Instance
	}
	if ($null -ne $Script:x360RConnectionInformation.ApiKey) {
		$Secrets.('{0}ApiKey' -f $SecretPrefix) = $Script:x360RConnectionInformation.ApiKey
	}
	if ($null -ne $Script:x360RConnectionInformation.UseSecretManagement) {
		$Secrets.('{0}UseSecretManagement' -f $SecretPrefix) = $Script:x360RConnectionInformation.UseSecretManagement.ToString()
	}
	if ($null -ne $Script:x360RConnectionInformation.WriteToSecretVault) {
		$Secrets.('{0}WriteToSecretVault' -f $SecretPrefix) = $Script:x360RConnectionInformation.WriteToSecretVault.ToString()
	}
	if ($null -ne $Script:x360RConnectionInformation.ReadFromSecretVault) {
		$Secrets.('{0}ReadFromSecretVault' -f $SecretPrefix) = $Script:x360RConnectionInformation.ReadFromSecretVault.ToString()
	}
	if ($null -ne $Script:x360RConnectionInformation.VaultName) {
		$Secrets.('{0}VaultName' -f $SecretPrefix) = $Script:x360RConnectionInformation.VaultName
	}
	foreach ($Secret in $Secrets.GetEnumerator()) {
		Write-Verbose ('Processing secret {0} for vault storage.' -f $Secret.Key)
		Write-Debug ('Secret {0} has type {1}.' -f $Secret.Key, $Secret.Value.GetType().Name)
		Write-Debug ('Secret {0} has value {1}.' -f $Secret.Key, $Secret.Value.ToString())
		$SecretName = $Secret.Key
		$SecretValue = $Secret.Value
		if ([String]::IsNullOrEmpty($SecretValue) -or ($null -eq $SecretValue)) {
			Write-Verbose ('Secret {0} is null. Skipping.' -f $SecretName)
			continue
		}
		Set-Secret -Vault $VaultName -Name $SecretName -Secret $SecretValue -ErrorAction Stop
		Write-Verbose ('Secret {0} written to secret vault {1}.' -f $SecretName, $VaultName)
	}
}