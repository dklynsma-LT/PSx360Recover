function Get-x360RecoverAppliance {
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
		[Alias('appliance_id')]
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