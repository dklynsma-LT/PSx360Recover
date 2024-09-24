
function Connect-x360Recover {
<#
.SYNOPSIS
    Connects to the x360Recover API instance.

.DESCRIPTION
    This function initializes the module, checks for the SecretManagement module, and retrieves secrets from a secret vault if specified. It also sets up the connection information for the x360Recover API instance.

.PARAMETER Api
    The API Key for authentication.

.PARAMETER Instance
    The Axcient API Instance to connect to. Choose from 'prod' or 'mock'.

.PARAMETER UseSecretManagement
    Switch to use the SecretManagement module to store and retrieve the API key.

.PARAMETER VaultName
    The name of the secret vault to use.

.PARAMETER WriteToSecretVault
    Switch to write the updated credentials to the secret vault.

.PARAMETER ReadFromSecretVault
    Switch to read the credentials from the secret vault.

.PARAMETER VaultEntryPrefix
    The prefix to add to the name of the secrets stored in the secret vault.

.EXAMPLE
    Connect-x360Recover -Api 'your-api-key' -Instance 'prod'

    Connects to the production instance of the x360Recover API using the provided API key.

.EXAMPLE
    Connect-x360Recover -UseSecretManagement -VaultName 'MyVault' -ReadFromSecretVault

    Connects to the x360Recover API using credentials stored in the 'MyVault' secret vault.

.INPUTS
	None. You cannot pipe objects to this function.

.OUTPUTS
    None. This function does not produce any output.

.NOTES
    Ensure that the SecretManagement module is installed and a secret vault is created if using the secret management features.
#>
	[CmdletBinding( DefaultParameterSetName = 'Default Auth' )]
	[OutputType([System.Void])]
	param (
		# APi Key for authentication
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
		[String]$VaultEntryPrefix = 'x360Recover'

	)

	begin {
		# Set the x360Recover instances.
		[hashtable]$Script:x360RInstances = @{
			'prod' = 'https://axapi.axcient.com/x360recover'
			'mock' = 'https://ax-pub-recover.wiremockapi.cloud'
		}
	}

	process {
		# Test for secret managment module
		if ($UseSecretManagement -or $Script:x360RConnectionInformation.UseSecretManagement) {
			if (-not (Get-Module -Name 'Microsoft.PowerShell.SecretManagement' -ListAvailable)) {
				Write-Error 'Secret management module not installed, please install the module and try again.'
				throw 'Secret management module not installed, please install the module and try again.'
			}
			if (-not (Get-SecretVault)) {
				Write-Error 'No secret vaults found, please create a secret vault and try again.'
				throw 'No secret vaults found, please create a secret vault and try again.'
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
		else {
			Write-Verbose 'No instance specified, using default production instance.'
			$URL = $Script:x360RInstances['prod']
		}

		$ConnectionInformation = @{
			URL = $URL
			Instance = $Instance
			ApiKey = $ApiKey
			UseSecretManagement = $UseSecretManagement
			VaultName = $VaultName
			WriteToSecretVault = $WriteToSecretVault
			SecretPrefix = $VaultEntryPrefix
		}
		Set-Variable -Name 'x360RConnectionInformation' -Value $ConnectionInformation -Visibility Private -Scope Script -Force

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