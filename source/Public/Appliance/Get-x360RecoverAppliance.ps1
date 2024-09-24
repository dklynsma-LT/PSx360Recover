function Get-x360RecoverAppliance {
<#
.SYNOPSIS
    Retrieves appliance information from x360Recover.

.DESCRIPTION
    This cmdlet retrieves appliance information from the x360Recover system. It can retrieve information for a specific appliance by ID or for multiple appliances based on various filters such as service ID and whether to include device information.

.PARAMETER applianceId
    The ID of the appliance to retrieve information for. This parameter is used in the 'Single' parameter set and can be piped.

.PARAMETER serviceId
    The service ID to filter appliances. This parameter is optional.

.PARAMETER includeDevices
    If specified, includes short appliance information in the response. This parameter can be used in both 'Single' and 'Multi' parameter sets.

.EXAMPLE
    PS> Get-x360RecoverAppliance -applianceId 12345

    Retrieves information for the appliance with ID 12345.

.EXAMPLE
    PS> Get-x360RecoverAppliance -serviceId "ABCD" -includeDevices $true

    Retrieves information for appliances with service ID "ABCD" and includes short appliance information in the response.

.INPUTS
    System.Int64. The appliance ID can be piped to this cmdlet.

.OUTPUTS
    System.Object. The appliance information retrieved from x360Recover.

#>
	[CmdletBinding(DefaultParameterSetName = 'Multi')]
	[OutputType([Object])]
	[MetadataAttribute(
		'/appliance',
		'get',
		'/appliance/{appliance_id}',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# The ID of the appliance to return
		[Parameter(Mandatory, ParameterSetName = 'Single', Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('appliance_id','id')]
		[int64]$applianceId,
		# Unique serial number of the service(4 symbols)
		[ValidateLength(4,4)]
		[Parameter(ParameterSetName = 'Multi', Position = 1)]
		[Alias('service_id')]
		[string]$serviceId,
		# Include short appliance information to response or not
		[Parameter(ParameterSetName = 'Single', Position = 2)]
		[Parameter(ParameterSetName = 'Multi', Position = 2)]
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
			if ($applianceId) {
				Write-Verbose ('Getting appliance with id {0}.' -f $applianceId)
				$Resource = ('appliance/{0}' -f $applianceId)
				$RequestParams = @{
					Resource = $Resource
					QSCollection = $QSCollection
				}
			} else {
				Write-Verbose 'Retreiving all appliances'
				$Resource = 'appliance'
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
						throw ('Appliance with id {0} not found.' -f $applianceId)
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