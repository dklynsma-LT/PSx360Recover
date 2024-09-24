function Get-x360RecoverVaultConnThreshold {
	<#
.SYNOPSIS
    Retrieves the connectivity threshold information for a specified x360Recover vault.

.DESCRIPTION
    This cmdlet retrieves the connectivity threshold information for a specified x360Recover vault by its ID. It sends a GET request to the x360Recover API and returns the connectivity threshold details.

.PARAMETER vaultId
    The ID of the vault to retrieve connectivity threshold information for. This parameter is mandatory and can be piped.

.EXAMPLE
    PS> Get-x360RecoverVaultConnThreshold -vaultId 12345

    Retrieves the connectivity threshold information for the vault with ID 12345.

.INPUTS
    System.Int32. The vault ID can be piped to this cmdlet.

.OUTPUTS
    System.Object. The connectivity threshold information for the specified vault.
#>
	[CmdletBinding()]
	[OutputType([Object])]
	[MetadataAttribute(
		'/vault/{vault_id}/threshold/connectivity',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# Return infomation about a single vault
		[Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('vault_id','id')]
		[Int]$vaultId
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
				Write-Verbose ('Getting connectivity threshold for vault with id {0}.' -f $vaultId)
				$Resource = ('vault/{0}/threshold/connectivity' -f $vaultId)
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