
function Connect-x360Recover {
	[CmdletBinding( DefaultParameterSetName = 'Default Auth' )]
	[OutputType([System.Void])]
	param (
		[Parameter(ParameterSetName = 'Default Auth')]
		[Parameter( ParameterSetName = 'Secret Vault Write' )]
		[string]$ApiKey,
		# The Axcient API Instance to connect to. Choose From 'prod' or 'mock'.
		[Parameter(ParameterSetName = 'Default Auth')]
		[Parameter( ParameterSetName = 'Secret Vault Write' )]
		[ValidateSet('prod', 'mock')]
		[string]$Instance,
		# Use the SecretManagement module to store and retrieve the API key.
		[Parameter(ParameterSetName = 'Default Auth')]
		[Parameter(ParameterSetName = 'Secret Vault Write')]
		[Parameter(ParameterSetName = 'Secret Vault Read')]
		[switch]$UseSecretManagement,
		# The name of the secret vault to use.
		[Parameter(ParameterSetName = 'Default Auth')]
		[Parameter( Mandatory, ParameterSetName = 'Secret Vault Write' )]
		[Parameter( Mandatory, ParameterSetName = 'Secret Vault Read' )]
		[String]$VaultName,
		# Write the updated credentials to the secret vault.
		[Parameter(ParameterSetName = 'Default Auth')]
		[Parameter(Mandatory,ParameterSetName = 'Secret Vault Write')]
		[Parameter(ParameterSetName = 'Secret Vault Read')]
		[switch]$WriteToSecretVault,
		# Read the credentials from the secret vault.
		[Parameter(ParameterSetName = 'Secret Vault Read')]
		[switch]$ReadFromSecretVault,
		# The prefix to add to the name of the secrets stored in the secret vault.
		[Parameter( ParameterSetName = 'Secret Vault Write' )]
		[Parameter( ParameterSetName = 'Secret Vault Read' )]
		[String]$SecretPrefix = 'x360Recover'

	)

	begin {
		Initialize-Module
	}

	process {
		# Test for secret managment module
		if ($UseSecretManagement -or $Script:x360RConnectionInformation.UseSecretManagement) {
			if (-not (Get-Module -Name 'Microsoft.PowerShell.SecretManagement' -ListAvailable)) {
				Write-Error 'Secret management module not installed, please install the module and try again.'
				exit 1
			}
			if (-not (Get-SecretVault)) {
				Write-Error 'No secret vaults found, please create a secret vault and try again.'
				exit 1
			}
			if ($ReadFromSecretVault -or $Script:x360RConnectionInformation.ReadFromSecretVault) {
				Write-Verbose 'Reading authentication information from secret vault.'
				Get-x360RecoverSecrets -VaultName $VaultName
			}
		}
		# Get the x360 instance URL.
		if ($Instance) {
			Write-Verbose "Using instance $($Instance) with URL $($Script:x360RInstances[$Instance])"
			$URL = $Script:x360RInstances[$Instance]
		}
		# Build a script-scoped variable to hold the connection information.
		if ($null -eq $Script:x360RConnectionInformation) {
			$ConnectionInformation = @{
				URL = $URL
				Instance = $Instance
				ApiKey = $ApiKey
				UseSecretManagement = $UseSecretManagement
				VaultName = $VaultName
				WriteToSecretVault = $WriteToSecretVault
				SecretPrefix = $SecretPrefix
			}
			Set-Variable -Name 'x360RConnectionInformation' -Value $ConnectionInformation -Visibility Private -Scope Script -Force
		}
		Write-Verbose "Connection information set to: $($Script:x360RConnectionInformation | Format-List | Out-String)"
		# If we're using secret management, store the authentication information we need.
		if ($Script:x360RConnectionInformation.UseSecretManagement -and $Script:x360RConnectionInformation.WriteToSecretVault) {
			$SecretManagementParams = @{
				URL = $Script:x360RConnectionInformation.URL
				Instance = $Script:x360RConnectionInformation.Instance
				ApiKey = $Script:x360RConnectionInformation.ApiKey
				UseSecretManagement = $Script:x360RConnectionInformation.UseSecretManagement
				VaultName = $Script:x360RConnectionInformation.VaultName
				WriteToSecretVault = $Script:x360RConnectionInformation.WriteToSecretVault
				ReadFromSecretVault = $Script:x360RConnectionInformation.ReadFromSecretVault
				SecretPrefix = $Script:x360RConnectionInformation.SecretPrefix
			}
			Write-Verbose 'Using secret management to store credentials.'
			Set-x360RecoverSecrets @SecretManagementParams
		}

	}

	end {

	}
}