function Get-x360RecoverApplianceByClient {
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
		[Alias('client_id')]
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