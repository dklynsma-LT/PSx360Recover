function Get-x360RecoverDeviceRestorePoint{
<#
.SYNOPSIS
    Retrieves restore point information for a specified device.

.DESCRIPTION
    This cmdlet retrieves restore point information for a specified device from the x360Recover system. It sends a GET request to the x360Recover API and returns the restore point details for the given device ID.

.PARAMETER deviceId
    The ID of the device to retrieve restore point information for. This parameter is mandatory and can be piped.

.EXAMPLE
    PS> Get-x360RecoverDeviceRestorePoint -deviceId 12345

    Retrieves restore point information for the device with ID 12345.

.INPUTS
    System.Int64. The device ID can be piped to this cmdlet.

.OUTPUTS
    System.Object. The restore point information retrieved from x360Recover.

#>
	[CmdletBinding()]
	[OutputType([Object])]
	[MetadataAttribute(
		'/device/{device_id}/restore_point',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# Returns information about AutoVerify for the given protected system by it's id.
		[Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('device_id','id')]
		[Int64]$deviceId
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
				Write-Verbose ('Getting restore point information for device with id {0}.' -f $deviceId)
				$Resource = ('device/{0}/restore_point' -f $deviceId)
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