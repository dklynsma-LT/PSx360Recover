function Get-x360RecoverApplianceByClient {
<#
.SYNOPSIS
    Retrieves appliance information for a specified client from x360Recover.

.DESCRIPTION
    This cmdlet retrieves appliance information for a specified client from the x360Recover system. It can filter appliances based on the client ID and optionally include detailed information.

.PARAMETER clientId
    The ID of the client to retrieve appliance information for. This parameter is mandatory and can be piped.

.PARAMETER includeDetails
    If specified, includes detailed information for each appliance. This parameter is optional.

.EXAMPLE
    PS> Get-x360RecoverApplianceByClient -clientId 12345

    Retrieves appliance information for the client with ID 12345.

.EXAMPLE
    PS> Get-x360RecoverApplianceByClient -clientId 12345 -includeDetails $true

    Retrieves detailed appliance information for the client with ID 12345.

.INPUTS
    System.Int64. The client ID can be piped to this cmdlet.

.OUTPUTS
    System.Object. The appliance information retrieved from x360Recover.

#>
	[CmdletBinding()]
	[OutputType([Object])]
	[MetadataAttribute(
		'/client/{client_id}/appliance',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# The ID of the appliance to return
		[Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('client_id','id')]
		[int64]$clientId,
		# Include short appliance information to response or not
		[Parameter(Position = 1)]
		[Alias('include_devices')]
		[nullable[bool]]$includeDevices
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
				Write-Verbose ('Getting appliance with client id {0}.' -f $clientId)
				$Resource = ('client/{0}/appliance' -f $clientId)
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
					if ($applianceId) {
						throw ('Appliance with client id {0} not found.' -f $client)
					} else {
						throw 'No appliances found.'
					}
				}
			}
		} catch {
			New-x360RecoverError -ErrorRecord $_
		}
	}
}