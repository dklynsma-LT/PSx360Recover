function Get-x360RecoverSecrets {
	[CmdletBinding()]
	[OutputType([System.Void])]
	param(
		# The vault name to use for retrieving the secrets.
		[String]$VaultName,
		# The prefix to use for the secret names.
		[String]$SecretPrefix = 'x360Recover'
	)
	$Secrets = @{
		ConnectionInfo = @{
			'URL' = ('{0}URL' -f $SecretPrefix)
			'Instance' = ('{0}Instance' -f $SecretPrefix)
			'ApiKey' = ('{0}ApiKey' -f $SecretPrefix)
			'UseSecretManagement' = ('{0}UseSecretManagement' -f $SecretPrefix)
			'WriteToSecretVault' = ('{0}WriteToSecretVault' -f $SecretPrefix)
			'ReadFromSecretVault' = ('{0}ReadFromSecretVault' -f $SecretPrefix)
			'VaultName' = ('{0}VaultName' -f $SecretPrefix)
		}
	}
	# Setup the the script scoped variables for the connection and authentication information.
	if ($null -eq $Script:x360RConnectionInformation) { $Script:x360RConnectionInformation = @{} }
	# Retrieve the connection information from the secret vault.
	foreach ($ConnectionSecret in $Secrets.ConnectionInfo.GetEnumerator()) {
		Write-Verbose ('Processing secret {0} for vault retrieval.' -f $ConnectionSecret.Key)
		$SecretName = $ConnectionSecret.Key
		$VaultSecretName = $ConnectionSecret.Value
		$SecretValue = Get-Secret -Name $VaultSecretName -Vault $VaultName -AsPlainText -ErrorAction SilentlyContinue
		if ($null -eq $SecretValue) {
			Write-Verbose ('Secret {0} is null. Skipping.' -f $SecretName)
			continue
		}
		Write-Verbose ('Secret {0} retrieved from secret vault {1}.' -f $SecretName, $VaultName)
		$Script:x360RConnectionInformation.$SecretName = $SecretValue
	}
	# if we values for UseSecretManagement, WriteToSecretVault, and ReadFromSecretVault, convert them to booleans.
	if ($null -ne $Script:x360RConnectionInformation.UseSecretManagement) {
		$Script:x360RConnectionInformation.UseSecretManagement = [Boolean]::Parse($Script:x360RConnectionInformation.UseSecretManagement)
	}
	if ($null -ne $Script:x360RConnectionInformation.WriteToSecretVault) {
		$Script:x360RConnectionInformation.WriteToSecretVault = [Boolean]::Parse($Script:x360RConnectionInformation.WriteToSecretVault)
	}
	if ($null -ne $Script:x360RConnectionInformation.ReadFromSecretVault) {
		$Script:x360RConnectionInformation.ReadFromSecretVault = [Boolean]::Parse($Script:x360RConnectionInformation.ReadFromSecretVault)
	}
	# Verify we have the required connection information.
	if ([String]::IsNullOrEmpty($Script:x360RConnectionInformation.URL)) {
		Write-Error 'x360Recover URL is not set.'
		exit 1
	}
	if ([String]::IsNullOrEmpty($Script:x360RConnectionInformation.Instance)) {
		Write-Error 'x360Recover instance is not set.'
		exit 1
	}
	if ([String]::IsNullOrEmpty($Script:x360RConnectionInformation.APIKey)) {
		Write-Error 'x360Recover API key is not set.'
		exit 1
	}

	$Script:x360RConnectionInformation.UseSecretManagement = $true
	$Script:x360RConnectionInformation.WriteToSecretVault = $true
	$Script:x360RConnectionInformation.VaultName = $VaultName
	$Script:x360RConnectionInformation.ReadFromSecretVault = $true
}