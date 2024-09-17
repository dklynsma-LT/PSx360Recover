function Get-x360RecoverVault {
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
		[Alias('vault_id')]
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
				$vaultResults = New-x360RecoverGETRequest @RequestParams
				return $vaultResults
			} catch {
				if (-not $vaultResults) {
					if ($vaultId) {
						throw ('Vault with id {0} not found.' -f $organisationId)
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