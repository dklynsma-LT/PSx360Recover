
function Invoke-x360RecoverRequest {
	<#
	.SYNOPSIS
		Sends an HTTP request to the specified URI using the specified method.

	.DESCRIPTION
		This cmdlet sends an HTTP request to the specified URI using the specified method. It supports GET, POST, PUT, PATCH, and DELETE methods. Optionally, it can include a request body and return the raw response.

	.PARAMETER Method
		The HTTP method to use. Valid values are GET, POST, PUT, PATCH, and DELETE.

	.PARAMETER Uri
		The URI to send the request to. Must be a valid HTTP or HTTPS URI.

	.PARAMETER Body
		The body of the request. Must be a valid JSON string if provided.

	.PARAMETER Raw
		If specified, returns the raw response without converting from JSON.

	.EXAMPLE
		PS> Invoke-x360RecoverRequest -Method GET -Uri "https://axapi.axcient.com/x360recover/device"

		Sends a GET request to the x360 Device endpoint and returns JSON reponse.

	.EXAMPLE
		PS> Invoke-x360RecoverRequest -Method POST -Uri "https://axapi.axcient.com/x360recover" -Body '{"key":"value"}'

		Sends a POST request with the specified body to the specified URI and returns the response.

	.EXAMPLE
		PS> Invoke-x360RecoverRequest -Method GET -Uri "https://axapi.axcient.com/x360recover/organization" -Raw

		Sends a GET request to the x360Organization endpoint and returns the raw response.

	.NOTES

	#>
	[Cmdletbinding()]
	[OutputType([Object])]
	[MetadataAttribute('IGNORE')]
	param (
		# HTTP method to use.
		[Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
		[ValidateSet('GET', 'POST', 'PUT', 'PATCH', 'DELETE')]
		[String]$Method,
		# The URI to send the request to.
		[Parameter(Mandatory, Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[ValidatePattern('^https?://')]
		[String]$Uri,
		# The body of the request.
		[Parameter(Position = 2)]
		[ValidateScript({ try { $null = $args[0] | ConvertFrom-Json; $true } catch { $false } })]
		[String]$Body,
		# Return the raw response - don't convert from JSON.
		[Switch]$Raw

	)
	begin {
		if ($null -eq $Script:x360RConnectionInformation) {
			throw "Missing x360Recover connection information, please run 'Connect-x360Recover' first."
		}

		$AuthHeaders = @{
			'x-api-key' = $Script:x360RConnectionInformation.APIKey
			'accept' = 'application/json'
		}
	}
	process {
        $WebRequestParams = @{
            Method = $Method
            Uri = $Uri
            Headers = $AuthHeaders
        }

        if ($Body) {
            Write-Verbose ('Body is {0}' -f ($Body | Out-String))
            $WebRequestParams.Add('Body', $Body)
        } else {
            Write-Verbose 'No body present.'
        }

        try {
            Write-Verbose ('Making a {0} request to {1}' -f $Method, $Uri)
            $Response = Invoke-WebRequest @WebRequestParams
            Write-Verbose ('Response status code: {0}' -f $Response.StatusCode)
            Write-Verbose ('Response headers: {0}' -f ($Response.Headers | Out-String))
            Write-Verbose ('Raw response: {0}' -f ($Response | Out-String))

			if ($Response.Content) {
				if ($Raw) {
					Write-Verbose 'Raw switch present, returning raw response.'
					return $Response.Content
				} else {
					Write-Verbose 'Raw switch not present, converting response from JSON.'
					return $Response.Content | ConvertFrom-Json
				}
			}
			else {
				Write-Verbose 'No response content.'
				if ($Response.StatusCode -and $WebRequestParams.Method -ne 'GET') {
					Write-Verbose ('Request completed with status code {0}. No content in the response - returning Status Code.' -f $Response.StatusCode)
					return $Response.StatusCode
				} else {
					Write-Verbose 'Request completed with no results and/or no status code.'
					return @{}
				}
			}
		} catch {
			Write-Verbose ('Caught an exception: {0}' -f $_)
			throw $_
		}
	}
}