function Get-x360RecoverAppliance {
<#
.SYNOPSIS
    Retrieves information about x360Recover appliances.

.DESCRIPTION
    This cmdlet retrieves information about x360Recover appliances. It can retrieve information for a specific appliance by ID or for all appliances. Optionally, it can include short appliance information in the response.

.PARAMETER applianceId
    The ID of the appliance to return. This parameter is mandatory for the 'Single' parameter set and can be piped.

.PARAMETER serviceId
    Unique serial number of the service (4 symbols). This parameter is used in the 'Multi' parameter set.

.PARAMETER includeDevices
    Include short appliance information in the response or not. This parameter is optional.

.EXAMPLE
    PS> Get-x360RecoverAppliance -applianceId 12345

    Retrieves information for the appliance with ID 12345.

.EXAMPLE
    PS> Get-x360RecoverAppliance -serviceId "ABCD"

    Retrieves information for all appliances associated with the service ID "ABCD".

.EXAMPLE
    PS> Get-x360RecoverAppliance -includeDevices $true

    Retrieves information for all appliances and includes short appliance information in the response.

.NOTES

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