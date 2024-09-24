function Get-x360RecoverOrganization {
<#
.SYNOPSIS
    Retrieves organization information from x360Recover.

.DESCRIPTION
    This cmdlet retrieves organization information from x360Recover using a GET request. It fetches details about the organization configured in the x360Recover system.

.PARAMETER None
    This cmdlet does not take any parameters.

.EXAMPLE
    PS> Get-x360RecoverOrganization

    Retrieves information about the organization from x360Recover.

.INPUTS
    None. You cannot pipe objects to this cmdlet.

.OUTPUTS
    System.Object. The organization information retrieved from x360Recover.

#>
	[CmdletBinding()]
	[OutputType([Object])]
	[MetadataAttribute(
		'/organization',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param()
	begin {	}
	process {
		try {
			Write-Verbose 'Retreiving organization information'
			$Resource = 'organization'
			$RequestParams = @{
				Resource = $Resource
			}

			try {
				$gResults = New-x360RecoverGETRequest @RequestParams
				return $gResults
			} catch {
				if (-not $gResults) {
					throw 'Organization not found.'
				}
			}
		} catch {
			New-x360RecoverError -ErrorRecord $_
		}
	}
}