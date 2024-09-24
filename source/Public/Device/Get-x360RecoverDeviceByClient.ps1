function Get-x360RecoverDeviceByClient {
<#
.SYNOPSIS
    Retrieves device information for a specified client from x360Recover.

.DESCRIPTION
    This cmdlet retrieves device information for a specified client from the x360Recover system. It can filter devices based on the service ID and whether they are D2C (Direct-to-Cloud) devices.

.PARAMETER clientId
    The ID of the client to retrieve device information for. This parameter is mandatory and can be piped.

.PARAMETER serviceId
    The SID of the service (4 symbols). This parameter is optional.

.PARAMETER d2cOnly
    If specified, includes only D2C (Direct-to-Cloud) devices. This parameter is optional.

.EXAMPLE
    PS> Get-x360RecoverDeviceByClient -clientId 12345

    Retrieves device information for the client with ID 12345.

.EXAMPLE
    PS> Get-x360RecoverDeviceByClient -clientId 12345 -serviceId "ABCD"

    Retrieves device information for the client with ID 12345 and service ID "ABCD".

.EXAMPLE
    PS> Get-x360RecoverDeviceByClient -clientId 12345 -d2cOnly $true

    Retrieves only D2C devices for the client with ID 12345.

.INPUTS
    System.Int64. The client ID can be piped to this cmdlet.

.OUTPUTS
    System.Object. The device information retrieved from x360Recover.

#>
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