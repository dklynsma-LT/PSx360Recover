function Get-x360RecoverVault {
<#
.SYNOPSIS
    Retrieves information about x360Recover vaults.

.DESCRIPTION
    This cmdlet retrieves information about x360Recover vaults. It can retrieve information for a specific vault by ID or for multiple vaults based on various filters such as vault type, active status, URL presence, and limit. Optionally, it can include the device list for each vault.

.PARAMETER vaultId
    The ID of the vault to return. This parameter is used in the 'Single' parameter set and can be piped.

.PARAMETER vaultType
    Filter to return only private or only cloud vaults. This parameter is used in the 'Multi' parameter set.

.PARAMETER active
    Filter to return only vaults with active status. This parameter is used in the 'Multi' parameter set.

.PARAMETER withUrl
    Filter to return only vaults with a URL present. This parameter is used in the 'Multi' parameter set.

.PARAMETER limit
    The maximum number of vaults to return in the response. This parameter is used in the 'Multi' parameter set.

.PARAMETER includeDevices
    If specified, returns the device list for each vault. This parameter is used in the 'Multi' parameter set.

.EXAMPLE
    PS> Get-x360RecoverVault -vaultId 12345

    Retrieves information for the vault with ID 12345.

.EXAMPLE
    PS> Get-x360RecoverVault -vaultType 'Private' -active $true -limit 10

    Retrieves information for up to 10 active private vaults.

.EXAMPLE
    PS> Get-x360RecoverVault -withUrl $true -includeDevices $true

    Retrieves information for vaults with a URL present and includes the device list for each vault.

.INPUTS
    System.Int32. The vault ID can be piped to this cmdlet.

.OUTPUTS
    System.Object. The information about the specified vault(s).

#>
	[CmdletBinding( DefaultParameterSetName = 'Multi' )]
	[OutputType([Object])]
	[MetadataAttribute(
		'/vault',
		'get',
		'/vault/{vault_id}',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# Return infomation about a single vault
		[Parameter(ParameterSetName = 'Single', Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('vault_id','id')]
		[Int]$vaultId,
		#Filter only private or only cloud vaults
		[Parameter(ParameterSetName = 'Multi', Position = 1)]
		[ValidateSet('Private', 'Cloud')]
		[Alias('vault_type')]
		[string]$vaultType,
		# Filter only vaults with active status
		[Parameter(ParameterSetName = 'Multi', Position = 2)]
		[nullable[bool]]$active,
		# Filter by URL presence
		[Parameter(ParameterSetName = 'Multi', Position = 3)]
		[Alias('with_url')]
		[nullable[bool]]$withUrl,
		# Max amount of vaults in response
		[Parameter(ParameterSetName = 'Multi', Position = 4)]
		[Int64]$limit,
		# Return device list for each vault if True
		[Parameter(ParameterSetName = 'Multi', Position = 5)]
		[Alias('include_devices')]
		[nullable[bool]]$includeDevices
	)
	begin {
		$CommandName = $MyInvocation.InvocationName
		write-verbose $MyInvocation
		$Parameters = (Get-Command -Name $CommandName).Parameters
		$QSCollection = New-x360RecoverQuery -CommandName $CommandName -Parameters $Parameters
	}
	process {
		try {
			if ($vaultId) {
				Write-Verbose ('Getting vault with id {0}.' -f $vaultId)
				$Resource = ('vault/{0}' -f $vaultId)
				$RequestParams = @{
					Resource = $Resource
					QSCollection = $QSCollection
				}
			} else {
				Write-Verbose 'Retreiving all vaults'
				$Resource = 'vault'
				$RequestParams = @{
					Resource = $Resource
					QSCollection = $QSCollection
				}
			}
			try {
				$gResults = New-x360RecoverGETRequest @RequestParams
				return $gResults
			} catch {
				if (-not $gResults) {
					if ($vaultId) {
						throw ('Vault with id {0} not found.' -f $vaultId)
					} else {
						throw 'No vaults found.'
					}
				}
			}
		} catch {
			New-x360RecoverError -ErrorRecord $_
		}
	}
}