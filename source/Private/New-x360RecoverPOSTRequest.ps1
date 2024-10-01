function New-x360RecoverPOSTRequest {
	<#
.SYNOPSIS
    Sends a POST request to the specified x360Recover API resource.

.DESCRIPTION
    This cmdlet sends a POST request to the specified x360Recover API resource. It constructs the request URI using the provided resource and query string parameters, and includes the specified body in the request. The cmdlet returns the response from the API.

.PARAMETER Resource
    The resource to send the request to. This parameter is mandatory.

.PARAMETER QSCollection
    A hashtable used to build the query string. This parameter is optional.

.PARAMETER Body
    A hashtable or object used to build the body of the request. This parameter is optional.

.EXAMPLE
    PS> $qs = @{ param1 = "value1"; param2 = "value2" }
    PS> $body = @{ key1 = "value1"; key2 = "value2" }
    PS> New-x360RecoverPOSTRequest -Resource "devices" -QSCollection $qs -Body $body

    Sends a POST request to the "devices" resource with the specified query string parameters and body.

.EXAMPLE
    PS> $body = @{ key1 = "value1"; key2 = "value2" }
    PS> New-x360RecoverPOSTRequest -Resource "devices/12345" -Body $body

    Sends a POST request to the "devices/12345" resource with the specified body.

.INPUTS
    System.String. The resource can be piped to this cmdlet.
    System.Collections.Hashtable. The query string parameters and body can be piped to this cmdlet.

.OUTPUTS
    System.Object. The response from the x360Recover API.

#>
	[CmdletBinding()]
	[OutputType([Object])]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification = 'Private function - no need to support.')]
	param (
		# The resource to send the request to.
		[Parameter(Mandatory = $True)]
		[String]$Resource,
		# A hashtable used to build the query string.
		[Hashtable]$QSCollection,
		# A hashtable used to build the body of the request.
		[Object]$Body
	)
	if ($null -eq $Script:x360RConnectionInformation) {
		throw "Missing x360Recover connection information, please run 'Connect-x360Recover' first."
	}
	try {
		if ($QSCollection) {
			Write-Verbose "Query string in New-x360RecoverPOSTRequest contains: $($QSCollection | Out-String)"
			$QueryStringCollection = [System.Web.HTTPUtility]::ParseQueryString([String]::Empty)
			Write-Verbose 'Building [HttpQSCollection] for New-x360RecoverPOSTRequest'
			foreach ($Key in $QSCollection.Keys) {
				$QueryStringCollection.Add($Key, $QSCollection.$Key)
			}
		} else {
			Write-Verbose 'Query string collection not present...'
		}
		Write-Verbose "URI is $($Script:x360RConnectionInformation.URL)"
		$RequestUri = [System.UriBuilder]"$($Script:x360RConnectionInformation.URL)"
		Write-Verbose "Path is $($Resource)"
		$RequestUri.Path = $Resource
		if ($QueryStringCollection) {
			Write-Verbose "Query string is $($QueryStringCollection.toString())"
			$RequestUri.Query = $QueryStringCollection.toString()
		} else {
			Write-Verbose 'Query string not present...'
		}
		$WebRequestParams = @{
			Method = 'POST'
			Uri = $RequestUri.ToString()
		}
		if ($Body) {
			Write-Verbose 'Building [HttpBody] for New-x360RecoverPOSTRequest'
			$WebRequestParams.Body = (ConvertTo-Json -InputObject $Body -Depth 100)
			Write-Verbose "Raw body is $($WebRequestParams.Body)"
		} else {
			Write-Verbose 'No body provided for New-x360RecoverPOSTRequest'
		}
		Write-Verbose "Building new x360RecoverRequest with params: $($WebRequestParams | Out-String)"
		try {
			$Result = Invoke-x360RecoverRequest @WebRequestParams
			Write-Verbose "x360Recover request returned $($Result | Out-String)"
			if ($Result['results']) {
				return $Result.results
			} elseif ($Result['result']) {
				return $Result.result
			} else {
				return $Result
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