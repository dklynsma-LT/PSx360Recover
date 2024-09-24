function Get-x360RecoverClient {
<#
.SYNOPSIS
    Retrieves client information from x360Recover.

.DESCRIPTION
    This cmdlet retrieves client information from the x360Recover system. It can retrieve information for a specific client by ID or for multiple clients. Optionally, it can include short appliance information in the response.

.PARAMETER clientId
    The ID of the client to retrieve information for. This parameter is used in the 'Single' parameter set and can be piped.

.PARAMETER includeAppliances
    If specified, includes short appliance information in the response. This parameter can be used in both 'Single' and 'Multi' parameter sets.

.EXAMPLE
    PS> Get-x360RecoverClient -clientId 12345

    Retrieves information for the client with ID 12345.

.EXAMPLE
    PS> Get-x360RecoverClient -includeAppliances $true

    Retrieves information for all clients and includes short appliance information in the response.

.INPUTS
    System.Int64. The client ID can be piped to this cmdlet.

.OUTPUTS
    System.Object. The client information retrieved from x360Recover.

#>
	[CmdletBinding(DefaultParameterSetName = 'Multi')]
	[OutputType([Object])]
	[MetadataAttribute(
		'/client',
		'get',
		'/client/{client_id}',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		[Parameter(Mandatory, ParameterSetName = 'Single', Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('client_id','id')]
		[int64]$clientId,
		# Include short appliance information to response or not
		[Parameter(ParameterSetName = 'Multi', Position = 1)]
		[Parameter(ParameterSetName = 'Single', Position = 1)]
		[Alias('include_appliances')]
		[nullable[bool]]$includeAppliances
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
				Write-Verbose ('Getting client with id {0}.' -f $clientId)
				$Resource = ('client/{0}' -f $clientId)
				$RequestParams = @{
					Resource = $Resource
					QSCollection = $QSCollection
				}
			} else {
				Write-Verbose 'Retreiving all clients'
				$Resource = 'client'
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
						throw 'No clients found.'
					}
				}
			}
		} catch {
			New-x360RecoverError -ErrorRecord $_
		}
	}
}