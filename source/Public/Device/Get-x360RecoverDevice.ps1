function Get-x360RecoverDevice {
	[CmdletBinding( DefaultParameterSetName = 'Multi' )]
	[OutputType([Object])]
	[MetadataAttribute(
		'/device',
		'get',
		'/device/{device_id}',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# Return infomation about a single vault
		[Parameter(ParameterSetName = 'Single', Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('device_id','id')]
		[Int64]$deviceId,
		# Records limit for pagination
		[Parameter(ParameterSetName = 'Multi', Position = 1)]
		[Int64]$limit,
		# Records offset for pagination
		[Parameter(ParameterSetName = 'Multi', Position = 2)]
		[Int64]$offset
	)
	begin {
		$CommandName = $MyInvocation.InvocationName
		write-verbose $MyInvocation
		$Parameters = (Get-Command -Name $CommandName).Parameters
		$QSCollection = New-x360RecoverQuery -CommandName $CommandName -Parameters $Parameters
	}
	process {
		try {
			if ($deviceId) {
				Write-Verbose ('Getting device with id {0}.' -f $deviceId)
				$Resource = ('device/{0}' -f $deviceId)
				$RequestParams = @{
					Resource = $Resource
					QSCollection = $QSCollection
				}
			} else {
				Write-Verbose 'Retreiving all devices'
				$Resource = 'device'
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
						throw ('Device with id {0} not found.' -f $organisationId)
					} else {
						throw 'No devices found.'
					}
				}
			}
		} catch {
			New-x360RecoverError -ErrorRecord $_
		}
	}
}