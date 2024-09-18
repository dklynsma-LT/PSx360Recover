function Get-x360RecoverClient {
	[CmdletBinding(DefaultParameterSetName = 'Multi')]
	[OutputType([Object])]
	[MetadataAttribute(
		'/client',
		'get',
		'/client/{client_id}',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		[Parameter(Mandatory, ParameterSetName = 'Single', Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Parameter(Mandatory, ParameterSetName = 'Multi', Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('client_id')]
		[int64]$clientId,
		# Include short appliance information to response or not
		[Parameter(ParameterSetName = 'Multi', Position = 1)]
		[Alias('include_appliances')]
		[nullable[bool]]$includeAppliances
	)
	begin {
		$CommandName = $MyInvocation.InvocationName
		write-verbose $MyInvocation
		$Parameters = (Get-Command -Name $CommandName).Parameters
		$QSCollection = New-x360RecoverQuery -CommandName $CommandName -Parameters $Parameters
	}
	process {
		try {
			if ($clientId) {
				Write-Verbose ('Getting client with id {0}.' -f $clientId)
				$Resource = ('client/{0}' -f $clientId)
				$RequestParams = @{
					Resource = $Resource
					QSCollection = $QSCollection
				}
			} else {
				Write-Verbose 'Retreiving all clients'
				$Resource = 'client'
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
					if ($clientId) {
						throw ('Client with id {0} not found.' -f $clientId)
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