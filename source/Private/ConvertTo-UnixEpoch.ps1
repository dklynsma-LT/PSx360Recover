function ConvertTo-UnixEpoch {
<#
.SYNOPSIS
    Converts a PowerShell DateTime object to a Unix Epoch timestamp.

.DESCRIPTION
    This cmdlet takes a PowerShell DateTime object and returns a Unix Epoch timestamp representing the same date/time. It supports input as a DateTime object, a string, or an integer.

.PARAMETER DateTime
    The PowerShell DateTime object, string, or integer to convert. This parameter is mandatory.

.EXAMPLE
    PS> ConvertTo-UnixEpoch -DateTime (Get-Date)

    Converts the current date and time to a Unix Epoch timestamp.

.EXAMPLE
    PS> ConvertTo-UnixEpoch -DateTime "2023-01-01T00:00:00"

    Converts the specified date and time string to a Unix Epoch timestamp.

.EXAMPLE
    PS> ConvertTo-UnixEpoch -DateTime 1672531200

    Converts the specified Unix Epoch timestamp to a Unix Epoch timestamp (returns the same value).

.INPUTS
    System.Object. The DateTime parameter can be a DateTime object, string, or integer.

.OUTPUTS
    System.Int. The Unix Epoch timestamp.

#>
	[CmdletBinding()]
	[OutputType([Int])]
	param (
		# The PowerShell DateTime object to convert.
		[Parameter(
			Mandatory = $True
		)]
		[Object]$DateTime
	)
	if ($DateTime -is [String]) {
		$DateTime = [DateTime]::Parse($DateTime)
	} elseif ($DateTime -is [Int]) {
								(Get-Date 01.01.1970).AddSeconds($unixTimeStamp)
	} elseif ($DateTime -is [DateTime]) {
		$DateTime = $DateTime
	} else {
		Write-Error 'The DateTime parameter must be a DateTime object, a string, or an integer.'
		Exit 1
	}
	$UniversalDateTime = $DateTime.ToUniversalTime()
	$UnixEpochTimestamp = Get-Date -Date $UniversalDateTime -UFormat %s
	Write-Verbose "Converted $DateTime to Unix Epoch timestamp $UnixEpochTimestamp"
	return $UnixEpochTimestamp
}