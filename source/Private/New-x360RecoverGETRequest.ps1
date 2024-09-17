function New-x360RecoverGETRequest {
	[CmdletBinding()]
	[OutputType([Object])]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification = 'Private function - no need to support.')]
	param (
		# The resource to send the request to.
		[Parameter( Mandatory = $True )]
		[String]$Resource,
		# A hashtable used to build the query string.
		[HashTable]$QSCollection,
		# return the raw response.
		[Switch]$Raw
	)
	if ($null -eq $Script:x360RConnectionInformation) {
		throw "Missing NinjaOne connection information, please run 'Connect-NinjaOne' first."
	}
	try {
		if ($QSCollection) {
			Write-Verbose "Query string in New-x360RecoverGETRequest contains: $($QSCollection | Out-String)"
			$QueryStringCollection = [System.Web.HTTPUtility]::ParseQueryString([String]::Empty)
			Write-Verbose 'Building [HttpQSCollection] for New-x360RecoverGETRequest'
			foreach ($Key in $QSCollection.Keys) {
				$QueryStringCollection.Add($Key, $QSCollection.$Key)
			}
		} else {
			Write-Verbose 'Query string collection not present...'
		}
		Write-Verbose "URI is $($Script:x360RConnectionInformation.URL)"
		$RequestUri = [System.UriBuilder]"$($Script:x360RConnectionInformation.URL)"
		$RequestUri.Path = $Resource
		if ($QueryStringCollection) {
			$RequestUri.Query = $QueryStringCollection.toString()
		} else {
			Write-Verbose 'No query string collection present.'
		}
		$WebRequestParams = @{
			Method = 'GET'
			Uri = $RequestUri.ToString()
		}
		if ($Raw) {
			$WebRequestParams.Add('Raw', $Raw)
		} else {
			Write-Verbose 'Raw switch not present.'
		}
		if ($WebRequestParams) {
			Write-Verbose "WebRequestParams contains: $($WebRequestParams | Out-String)"
		} else {
			Write-Verbose 'WebRequestParams is empty.'
		}
		try {
			$Result = Invoke-x360RecoverRequest @WebRequestParams
			if ($Result) {
				Write-Verbose "x360Recover request returned:: $($Result | Out-String)"
				$Properties = ($Result | Get-Member -MemberType 'NoteProperty')
				if ($Properties.name -contains 'results') {
					Write-Verbose "returning 'results' property.'"
					Write-Verbose "Result type is $($Result.results.GetType())"
					return $Result.results
				} elseif ($Properties.name -contains 'result') {
					Write-Verbose "returning 'result' property."
					Write-Verbose "Result type is $($Result.result.GetType())"
					return $Result.result
				} else {
					Write-Verbose 'returning raw.'
					Write-Verbose "Result type is $($Result.GetType())"
					return $Result
				}
			} else {
				Write-Verbose 'x360Recover request returned nothing.'
			}
		} catch {
			$ExceptionType = if ($IsCoreCLR) {
				[Microsoft.PowerShell.Commands.HttpResponseException]
			} else {
				[System.Net.WebException]
			}
			if ($_.Exception -is $ExceptionType) {
				throw
			} else {
				New-x360RecoverError -ErrorRecord $_
			}
		}
	} catch {
		$ExceptionType = if ($IsCoreCLR) {
			[Microsoft.PowerShell.Commands.HttpResponseException]
		} else {
			[System.Net.WebException]
		}
		if ($_.Exception -is $ExceptionType) {
			throw
		} else {
			New-x360RecoverError -ErrorRecord $_
			-ErrorRecord $_
		}
	}
}