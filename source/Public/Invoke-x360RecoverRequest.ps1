
function Invoke-x360RecoverRequest {

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
		[String]$Uri,
		# The body of the request.
		[Parameter(Position = 2)]
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
		try {
			Write-Verbose ('Making a {0} request to {1}' -f $WebRequestParams.Method, $WebRequestParams.Uri)
			$WebRequestParams = @{
				Method = $Method
				Uri = $Uri
			}
			if ($Body) {
				Write-Verbose ('Body is {0}' -f ($Body | Out-String))
				$WebRequestParams.Add('Body', $Body)
			} else {
				Write-Verbose 'No body present.'
			}

			$Response = Invoke-WebRequest @WebRequestParams -Headers $AuthHeaders
			Write-Verbose ('Response status code: {0}' -f $Response.StatusCode)
			Write-Verbose ('Response headers: {0}' -f ($Response.Headers | Out-String))
			Write-Verbose ('Raw response: {0}' -f ($Response | Out-String))
			if ($Response.Content) {
				$ResponseContent = $Response.Content
			} else {
				$ResponseContent = 'No content'
			}
			if ($Response.Content) {
				Write-Verbose ('Response content: {0}' -f ($ResponseContent | Out-String))
			} else {
				Write-Verbose 'No response content.'
			}
			if ($Raw) {
				Write-Verbose 'Raw switch present, returning raw response.'
				$Results = $Response.Content
			} else {
				Write-Verbose 'Raw switch not present, converting response from JSON.'
				$Results = $Response.Content | ConvertFrom-Json
			}
			if ($null -eq $Results) {
				if ($Response.StatusCode -and $WebRequestParams.Method -ne 'GET') {
					Write-Verbose ('Request completed with status code {0}. No content in the response - returning Status Code.' -f $Response.StatusCode)
					$Results = $Response.StatusCode
				} else {
					Write-Verbose 'Request completed with no results and/or no status code.'
					$Results = @{}
				}
			}
			return $Results
		} catch {
			Write-Verbose ('Caught an exception: {0}' -f $_)
			throw $_
		}
	}
}