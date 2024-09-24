function Get-x360RecoverDevice {
<#
.SYNOPSIS
    Retrieves AutoVerify information for a specified device.

.DESCRIPTION
    This cmdlet retrieves AutoVerify information for a specified device from the x360Recover system. It sends a GET request to the x360Recover API and returns the AutoVerify details for the given device ID.

.PARAMETER deviceId
    The ID of the device to retrieve AutoVerify information for. This parameter is mandatory and can be piped.

.EXAMPLE
    PS> Get-x360RecoverDeviceAutoVerify -deviceId 12345

    Retrieves AutoVerify information for the device with ID 12345.

.INPUTS
    System.Int64. The device ID can be piped to this cmdlet.

.OUTPUTS
    System.Object. The AutoVerify information retrieved from x360Recover.

#>
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
				$gResults = New-x360RecoverGETRequest @RequestParams
				return $gResults
			} catch {
				if (-not $gResults) {
					if ($deviceId) {
						throw ('Device with id {0} not found.' -f $deviceId)
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