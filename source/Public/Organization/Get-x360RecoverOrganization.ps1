function Get-x360RecoverOrganization {
	[CmdletBinding()]
	[OutputType([Object])]
	[MetadataAttribute(
		'/organization',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
	)
	begin {
		$CommandName = $MyInvocation.InvocationName
		write-verbose $MyInvocation
		$Parameters = (Get-Command -Name $CommandName).Parameters
		$QSCollection = New-x360RecoverQuery -CommandName $CommandName -Parameters $Parameters
	}
	process {
		try {
			Write-Verbose 'Retreiving organization information'
			$Resource = 'organization'
			$RequestParams = @{
				Resource = $Resource
				QSCollection = $QSCollection
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