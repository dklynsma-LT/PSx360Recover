function Get-x360RecoverBackupJob {
	[CmdletBinding( DefaultParameterSetName = 'Multi' )]
	[OutputType([Object])]
	[MetadataAttribute(
		'/client/{client_id}/device/{device_id}/job',
		'get',
		'/client/{client_id}/device/{device_id}/job/{job_id}',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# The unique ID of the client
		[Parameter(Mandatory, ParameterSetName = 'Multi', Position = 0, ValueFromPipelineByPropertyName)]
		[Parameter(Mandatory, ParameterSetName = 'Single', Position = 0,  ValueFromPipelineByPropertyName)]
		[Alias('client_id')]
		[Int64]$clientId,
		# The unique ID of the device
		[Parameter(Mandatory, ParameterSetName = 'Multi', Position = 1, ValueFromPipelineByPropertyName)]
		[Parameter(Mandatory, ParameterSetName = 'Single', Position = 1, ValueFromPipelineByPropertyName)]
		[Alias('device_id','id')]
		[int64]$deviceId,
		# The unique ID of the job
		[Parameter(Mandatory, ParameterSetName = 'Single', Position = 2,ValueFromPipelineByPropertyName)]
		[Alias('job_id')]
		[int64]$jobId
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
				if ($jobId) {
					Write-Verbose ('Getting backup job with client id {0}, device id {1}, and job id {2}.' -f $clientId,$deviceId,$jobId)
					$Resource = ('client/{0}/device/{1}/job/{2}' -f $clientId,$deviceId,$jobId)
					$RequestParams = @{
						Resource = $Resource
						QSCollection = $QSCollection
					}
				} else {
				Write-Verbose ('Getting backup jobs for client id {0} and device id {1}.' -f $clientId,$deviceId)
				$Resource = ('client/{0}/device/{1}/job' -f $clientId,$deviceId)
				$RequestParams = @{
					Resource = $Resource
					QSCollection = $QSCollection
					}
				}
			}
			try {
				$gResults = New-x360RecoverGETRequest @RequestParams
				return $gResults
			} catch {
				if (-not $gResults) {
					if ($clientId -and $deviceId) {
						throw ('Job with client id {0} and device id {1} not found.' -f $clientId,$deviceId)
					} else {
						throw 'No jobs found.'
					}
				}
			}
		} catch {
			New-x360RecoverError -ErrorRecord $_
		}
	}
}