function Get-x360BackupJob {
	[CmdletBinding()]
	[OutputType([Object])]
	[MetadataAttribute(
		'/client/{client_id}/device/{device_id}/job',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# The unique ID of the client
		[Parameter(Mandatory, Position = 0)]
		[Alias('client_id')]
		[Int64]$clientId,
		# The unique ID of the device
		[Parameter(Mandatory, Position = 1)]
		[Alias('device_id')]
		[string]$deviceId
	)
	begin {
		$CommandName = $MyInvocation.InvocationName
		write-verbose $MyInvocation
		$Parameters = (Get-Command -Name $CommandName).Parameters
		$QSCollection = New-x360RecoverQuery -CommandName $CommandName -Parameters $Parameters
	}
	process {
		try {
			if ($clientId -and $deviceId) {
				Write-Verbose ('Getting backup jobs for client id {0} and device id {1}.' -f $clientId,$deviceId)
				$Resource = ('client/{0}/device/{1}/job' -f $clientId,$deviceId)
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