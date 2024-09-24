function Get-x360RecoverBackupJob {
<#
.SYNOPSIS
    Retrieves backup job information for a specified client and device.

.DESCRIPTION
    This cmdlet retrieves backup job information for a specified client and device from the x360Recover system. It can retrieve information for a specific job by ID or for all jobs associated with a client and device.

.PARAMETER clientId
    The unique ID of the client. This parameter is mandatory and can be piped.

.PARAMETER deviceId
    The unique ID of the device. This parameter is mandatory and can be piped.

.PARAMETER jobId
    The unique ID of the job. This parameter is mandatory for the 'Single' parameter set and can be piped.

.EXAMPLE
    PS> Get-x360RecoverBackupJob -clientId 12345 -deviceId 67890

    Retrieves all backup jobs for the specified client and device.

.EXAMPLE
    PS> Get-x360RecoverBackupJob -clientId 12345 -deviceId 67890 -jobId 112233

    Retrieves the backup job with the specified job ID for the specified client and device.

.INPUTS
    System.Int64. The client ID, device ID, and job ID can be piped to this cmdlet.

.OUTPUTS
    System.Object. The backup job information retrieved from x360Recover.

#>
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