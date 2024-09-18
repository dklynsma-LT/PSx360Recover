function Get-x360RecoverBackupJobHistory {
	[CmdletBinding()]
	[OutputType([Object])]
	[MetadataAttribute(
		'/client/{client_id}/device/{device_id}/job/{job_id}/history',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# The unique ID of the client
		[Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
		[Alias('client_id')]
		[Int64]$clientId,
		# The unique ID of the device
		[Parameter(Mandatory, Position = 1, ValueFromPipelineByPropertyName)]
		[Alias('device_id','id')]
		[int64]$deviceId,
		# The unique ID of the job
		[Parameter(Mandatory, Position = 2, ValueFromPipelineByPropertyName)]
		[Alias('job_id')]
		[int64]$jobId,
		# Records limit for pagination
		[Parameter(Position = 3)]
		[Int64]$limit,
		# Records offset for pagination
		[Parameter(Position = 4)]
		[Int64]$offset,
		# unix timestamp of minimum backup start time value
		[Parameter(Position = 5)]
		[Alias('starttime_begin','startTimeBegin')]
		[int64]$jobStartTimeUnixEpoch,
		# unix timestamp of minimum backup start time value
		[Parameter(Position = 5)]
		[dateTime]$jobStartTime

	)
	begin {
		$CommandName = $MyInvocation.InvocationName
		Write-verbose $MyInvocation
		$Parameters = (Get-Command -Name $CommandName).Parameters
		#if the datetime parameter is passed, convert it to unix epoch
		if ($jobStartTime) {
			[Int64]$jobStartTimeUnixEpoch = ConvertTo-UnixEpoch -DateTime $jobStartTime
			$null = $Parameters.Remove('jobStartTime')
		}
		$QSCollection = New-x360RecoverQuery -CommandName $CommandName -Parameters $Parameters
	}
	process {
		try {
			if ($clientId -and $deviceId -and $jobId) {
				Write-Verbose ('Getting backup job history with client id {0}, device id {1}, and job id {2}.' -f $clientId,$deviceId,$jobId)
				$Resource = ('client/{0}/device/{1}/job/{2}/history' -f $clientId,$deviceId,$jobId)
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
					if ($clientId -and $deviceId) {
						throw ('History with client id {0}, device id {1}, and job id {2} not found.' -f $clientId,$deviceId,$jobId)
					} else {
						throw 'No job history found.'
					}
				}
			}
		} catch {
			New-x360RecoverError -ErrorRecord $_
		}
	}
}