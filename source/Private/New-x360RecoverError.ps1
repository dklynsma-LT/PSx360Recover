using namespace System.Collections.Generic
using namespace System.Management.Automation
function New-x360RecoverError {
<#
.SYNOPSIS
    Generates a detailed error message for x360Recover API errors.

.DESCRIPTION
    This cmdlet processes an ErrorRecord object and generates a detailed error message for x360Recover API errors. It handles various error scenarios, including HTTP request exceptions and JSON error details, and constructs a comprehensive error message.

.PARAMETER ErrorRecord
    The ErrorRecord object containing the error details. This parameter is mandatory.

.PARAMETER HasResponse
    Indicates whether the error includes an HTTP response. This parameter is optional.

.EXAMPLE
    PS> try {
    >>     # Some code that triggers an error
    >> } catch {
    >>     $errorRecord = $_
    >>     New-x360RecoverError -ErrorRecord $errorRecord -HasResponse
    >> }

    Processes the caught error and generates a detailed error message for the x360Recover API error.

.INPUTS
	None. You cannot pipe objects to this function.

.OUTPUTS
	None. This function throws a terminating error with the processed error details..

#>
	[CmdletBinding()]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification = 'Private function - no need to support.')]
	param (
		[Parameter(Mandatory = $true)]
		[errorrecord]$ErrorRecord,
		[Parameter()]
		[switch]$HasResponse
	)

	if (($Error.Exception -is [System.Net.Http.HttpRequestException]) -or ($Error.Exception -is [System.Net.WebException])) {
		Write-Verbose 'Generating x360Recover error output.'
		$ExceptionMessage = [Hashset[String]]::New()
		$APIResultMatchString = '*The x360Recover API said*'
		$HTTPResponseMatchString = '*The API returned the following HTTP*'
		if ($ErrorRecord.ErrorDetails) {
			Write-Verbose 'ErrorDetails contained in error record.'
			$ErrorDetailsIsJson = Test-Json -Json $ErrorRecord.ErrorDetails -ErrorAction SilentlyContinue
			if ($ErrorDetailsIsJson) {
				Write-Verbose 'ErrorDetails is JSON.'
				$ErrorDetails = $ErrorRecord.ErrorDetails | ConvertFrom-Json
				Write-Verbose "Raw error details: $($ErrorDetails | Out-String)"
				if ($null -ne $ErrorDetails) {
					if (($null -ne $ErrorDetails.resultCode) -and ($null -ne $ErrorDetails.errorMessage)) {
						Write-Verbose 'ErrorDetails contains resultCode and errorMessage.'
						$ExceptionMessage.Add("The x360Recover API said $($ErrorDetails.resultCode): $($ErrorDetails.errorMessage).") | Out-Null
					} elseif ($null -ne $ErrorDetails.resultCode) {
						Write-Verbose 'ErrorDetails contains resultCode.'
						$ExceptionMessage.Add("The x360Recover API said $($ErrorDetails.resultCode).") | Out-Null
					} elseif ($null -ne $ErrorDetails.error) {
						Write-Verbose 'ErrorDetails contains error.'
						$ExceptionMessage.Add("The x360Recover API said $($ErrorDetails.error).") | Out-Null
					} elseif ($null -ne $ErrorDetails) {
						Write-Verbose 'ErrorDetails is not null.'
						$ExceptionMessage.Add("The x360Recover API said $($ErrorRecord.ErrorDetails).") | Out-Null
					} else {
						Write-Verbose 'ErrorDetails is null.'
						$ExceptionMessage.Add('The x360Recover API returned an error.') | Out-Null
					}
				}
			} elseif ($ErrorRecord.ErrorDetails -like $APIResultMatchString -and $ErrorRecord.ErrorDetails -like $HTTPResponseMatchString) {
				$Errors = $ErrorRecord.ErrorDetails -Split "`r`n"
				if ($Errors -is [array]) {
					ForEach-Object -InputObject $Errors {
						$ExceptionMessage.Add($_) | Out-Null
					}
				} elseif ($Errors -is [string]) {
					$ExceptionMessage.Add($_)
				}
			}
		} else {
			$ExceptionMessage.Add('The x360Recover API returned an error but did not provide a result code or error message.') | Out-Null
		}
		if (($ErrorRecord.Exception.Response -and $HasResponse) -or $ExceptionMessage -notlike $HTTPResponseMatchString) {
			$Response = $ErrorRecord.Exception.Response
			Write-Verbose "Raw HTTP response: $($Response | Out-String)"
			if ($Response.StatusCode.value__ -and $Response.ReasonPhrase) {
				$ExceptionMessage.Add("The API returned the following HTTP error response: $($Response.StatusCode.value__) $($Response.ReasonPhrase)") | Out-Null
			} else {
				$ExceptionMessage.Add('The API returned an HTTP error response but did not provide a status code or reason phrase.')
			}
		} else {
			$ExceptionMessage.Add('The API did not provide a response code or status.') | Out-Null
		}
		$Exception = [System.Exception]::New(
			$ExceptionMessage,
			$ErrorRecord.Exception
		)
		$x360RecoverError = [ErrorRecord]::New(
			$ErrorRecord,
			$Exception
		)
		$UniqueExceptions = $ExceptionMessage | Get-Unique
		$x360RecoverError.ErrorDetails = [String]::Join("`r`n", $UniqueExceptions)
	} else {
		Write-Verbose 'Not generating x360Recover error output.'
		Write-Verbose "Raw error record: $($ErrorRecord | Out-String)"
		$x360RecoverError = $ErrorRecord
	}
	$PSCmdlet.throwTerminatingError($x360RecoverError)
}