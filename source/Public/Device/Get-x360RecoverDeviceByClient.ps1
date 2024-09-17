function Get-x360RecoverDeviceByClient {
	[CmdletBinding()]
	[OutputType([Object])]
	[MetadataAttribute(
		'/client/{client_id}/device',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# Return infomation about a single vault
		[Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('client_id','id')]
		[Int64]$clientId,
		# the SID of the service (4 symbols)
		[ValidateLength(4,4)]
		[Parameter(Position = 1)]
		[Alias('service_id')]
		[string]$serviceId,
		# Include D2C devices only
		[Parameter(Position = 2)]
		[Alias('d2c_only')]
		[nullable[boolean]]$d2cOnly
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
				Write-Verbose ('Getting devices for client id {0}.' -f $clientId)
				$Resource = ('client/{0}/device' -f $clientId)
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