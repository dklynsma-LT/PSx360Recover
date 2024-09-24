function Get-x360RecoverBackupJobHistory {
<#
.SYNOPSIS
    Retrieves the backup job history for a specified client, device, and job.

.DESCRIPTION
    This cmdlet retrieves the backup job history for a specified client, device, and job from the x360Recover system. It supports pagination and filtering by start time.

.PARAMETER clientId
    The ID of the client to retrieve backup job history for. This parameter is mandatory.

.PARAMETER deviceId
    The ID of the device to retrieve backup job history for. This parameter is mandatory.

.PARAMETER jobId
    The ID of the job to retrieve backup job history for. This parameter is mandatory.

.PARAMETER limit
    The maximum number of records to return for pagination. This parameter is optional.

.PARAMETER offset
    The number of records to skip for pagination. This parameter is optional.

.PARAMETER jobsAfterUnixEpoch
    The minimum backup start time value as a Unix timestamp. This parameter is optional.

.PARAMETER jobsAfter
    The minimum backup start time value as a DateTime object. This parameter is optional.

.EXAMPLE
    PS> Get-x360RecoverBackupJobHistory -clientId 123 -deviceId 456 -jobId 789

    Retrieves the backup job history for the specified client, device, and job.

.EXAMPLE
    PS> Get-x360RecoverBackupJobHistory -clientId 123 -deviceId 456 -jobId 789 -limit 10 -offset 20

    Retrieves the backup job history for the specified client, device, and job with pagination.

.EXAMPLE
    PS> Get-x360RecoverBackupJobHistory -clientId 123 -deviceId 456 -jobId 789 -jobsAfter (Get-Date "2023-01-01")

    Retrieves the backup job history for the specified client, device, and job starting after January 1, 2023.

.INPUTS
    System.Int32. The client ID, device ID, and job ID can be piped to this cmdlet.

.OUTPUTS
    System.Object. The backup job history information retrieved from x360Recover.

#>
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
		[int64]$jobsAfterUnixEpoch,
		# unix timestamp of minimum backup start time value
		[Parameter(Position = 5)]
		[dateTime]$jobsAfter

	)
	begin {
		$CommandName = $MyInvocation.InvocationName
		Write-verbose $MyInvocation
		$Parameters = (Get-Command -Name $CommandName).Parameters
		#if the datetime parameter is passed, convert it to unix epoch
		if ($jobStartTime) {
			[Int64]$jobsAfterUnixEpoch = ConvertTo-UnixEpoch -DateTime $jobsAfter
			$null = $Parameters.Remove('jobsAfter')
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