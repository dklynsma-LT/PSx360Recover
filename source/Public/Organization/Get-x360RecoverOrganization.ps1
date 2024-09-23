function Get-x360RecoverOrganization {
<#
.SYNOPSIS
    Retrieves organization information from x360Recover.

.DESCRIPTION
    This cmdlet retrieves organization information from x360Recover using a GET request.

.EXAMPLE
    PS> Get-x360RecoverOrganization

.NOTES

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