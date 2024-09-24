function New-x360RecoverQuery {
<#
.SYNOPSIS
    Builds a query string or hash table for x360Recover API requests.

.DESCRIPTION
    This cmdlet constructs a query string or hash table from the provided command name and parameters. It supports options to format arrays as comma-separated values and to return the result as a string.

.PARAMETER CommandName
    The name of the command for which the query is being built. This parameter is mandatory.

.PARAMETER Parameters
    A hash table of parameters to include in the query. This parameter is mandatory.

.PARAMETER CommaSeparatedArrays
    If specified, arrays will be formatted as comma-separated values in the query string. This parameter is optional.

.PARAMETER AsString
    If specified, the query will be returned as a string. Otherwise, it will be returned as a hash table. This parameter is optional.

.EXAMPLE
    PS> $params = @{ param1 = "value1"; param2 = "value2" }
    PS> New-x360RecoverQuery -CommandName "Get-x360RecoverDevice" -Parameters $params

    Builds a query string or hash table for the "Get-x360RecoverDevice" command using the specified parameters.

.EXAMPLE
    PS> $params = @{ param1 = "value1"; param2 = @("value2", "value3") }
    PS> New-x360RecoverQuery -CommandName "Get-x360RecoverDevice" -Parameters $params -CommaSeparatedArrays -AsString

    Builds a query string for the "Get-x360RecoverDevice" command using the specified parameters, formatting arrays as comma-separated values, and returns the result as a string.

.INPUTS
    System.String. The command name can be piped to this cmdlet.
    System.Collections.Hashtable. The parameters can be piped to this cmdlet.

.OUTPUTS
    System.String or System.Collections.Hashtable. The constructed query string or hash table.

#>
	[CmdletBinding()]
	[OutputType([String], [HashTable])]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification = 'Private function - no need to support.')]
	param (
		[Parameter(Mandatory = $True)]
		[String]$CommandName,
		[Parameter(Mandatory = $True)]
		[HashTable]$Parameters,
		[Switch]$CommaSeparatedArrays,
		[Switch]$AsString
	)
	Write-Verbose "Building parameters for $($CommandName). Use '-Debug' with '-Verbose' to see parameter values as they are built."
	$QSCollection = [HashTable]@{}
	Write-Verbose "$($Parameters.Values | Out-String)"
	foreach ($Parameter in $Parameters.Values) {
		# Skip system parameters.
		if (([System.Management.Automation.Cmdlet]::CommonParameters).Contains($Parameter.Name)) {
			Write-Verbose "Excluding system parameter $($Parameter.Name)."
			Continue
		}
		# Skip optional system parameters.
		if (([System.Management.Automation.Cmdlet]::OptionalCommonParameters).Contains($Parameter.Name)) {
			Write-Verbose "Excluding optional system parameter $($Parameter.Name)."
			Continue
		}
		$ParameterVariable = Get-Variable -Name $Parameter.Name -ErrorAction SilentlyContinue
		Write-Verbose "Parameter variable: $($ParameterVariable | Out-String)"
		if (($Parameter.ParameterType.Name -eq 'String') -or ($Parameter.ParameterType.Name -eq 'String[]')) {
			Write-Verbose "Found String or String Array param $($ParameterVariable.Name) with value $($ParameterVariable.Value)."
			if ([String]::IsNullOrEmpty($ParameterVariable.Value)) {
				Write-Verbose "Skipping unset param $($ParameterVariable.Name)"
				Continue
			} else {
				if ($Parameter.Aliases) {
					# Use the first alias as the query.
					$Query = ([String]$Parameter.Aliases[0])
				} else {
					# If no aliases then use the name.
					$Query = ([String]$ParameterVariable.Name)
				}
				$Value = $ParameterVariable.Value
				if (($Value -is [Array]) -and ($CommaSeparatedArrays)) {
					Write-Verbose 'Building comma separated array string.'
					$QueryValue = $Value -join ','
					$QSCollection.Add($Query, $QueryValue)
					Write-Verbose "Adding parameter $($Query) with value $($QueryValue)"
				} elseif (($Value -is [Array]) -and (-not $CommaSeparatedArrays)) {
					foreach ($ArrayValue in $Value) {
						$QSCollection.Add($Query, $ArrayValue)
						Write-Verbose "Adding parameter $($Query) with value(s) $($ArrayValue)"
					}
				} else {
					$QSCollection.Add($Query, $Value)
					Write-Verbose "Adding parameter $($Query) with value $($Value)"
				}
			}
		}
		if ($Parameter.ParameterType.Name -eq 'SwitchParameter') {
			Write-Verbose "Found Switch param $($ParameterVariable.Name) with value $($ParameterVariable.Value)."
			if ($ParameterVariable.Value -eq $False) {
				Write-Verbose "Skipping unset param $($ParameterVariable.Name)"
				Continue
			} else {
				if ($Parameter.Aliases) {
					# Use the first alias as the query string name.
					$Query = ([String]$Parameter.Aliases[0])
				} else {
					# If no aliases then use the name.
					$Query = ([String]$ParameterVariable.Name)
				}
				$Value = ([String]$ParameterVariable.Value).ToLower()
				$QSCollection.Add($Query, $Value)
				Write-Verbose "Adding parameter $($Query) with value $($Value)"
			}
		}
		if ($Parameter.ParameterType.Name -eq 'Boolean') {
			Write-Verbose "Found Boolean param $($ParameterVariable.Name) with value $($ParameterVariable.Value)."
			if ($Parameter.Aliases) {
				# Use the first alias as the query string name.
				$Query = ([String]$Parameter.Aliases[0])
			} else {
				# If no aliases then use the name.
				$Query = ([String]$ParameterVariable.Name)
			}
			$Value = ([String]$ParameterVariable.Value).ToLower()
			$QSCollection.Add($Query, $Value)
			Write-Verbose "Adding parameter $($Query) with value $($Value)"
		}
		if (($Parameter.ParameterType.Name -eq 'Int32') -or ($Parameter.ParameterType.Name -eq 'Int64') -or ($Parameter.ParameterType.Name -eq 'Int32[]') -or ($Parameter.ParameterType.Name -eq 'Int64[]')) {
			Write-Verbose "Found Int or Int Array param $($ParameterVariable.Name) with value $($ParameterVariable.Value)."
			if (($ParameterVariable.Value -eq 0) -or ($null -eq $ParameterVariable.Value)) {
				Write-Verbose "Skipping unset param $($ParameterVariable.Name)"
				Continue
			} else {
				if ($Parameter.Aliases) {
					# Use the first alias as the query string name.
					$Query = ([String]$Parameter.Aliases[0])
				} else {
					# If no aliases then use the name.
					$Query = ([String]$ParameterVariable.Name)
				}
				$Value = $ParameterVariable.Value
				if (($Value -is [Array]) -and ($CommaSeparatedArrays)) {
					Write-Verbose 'Building comma separated array string.'
					$QueryValue = $Value -join ','
					$QSCollection.Add($Query, $QueryValue)
					Write-Verbose "Adding parameter $($Query) with value $($QueryValue)"
				} elseif (($Value -is [Array]) -and (-not $CommaSeparatedArrays)) {
					foreach ($ArrayValue in $Value) {
						$QSCollection.Add($Query, $ArrayValue)
						Write-Verbose "Adding parameter $($Query) with value $($ArrayValue)"
					}
				} else {
					$QSCollection.Add($Query, $Value)
					Write-Verbose "Adding parameter $($Query) with value $($Value)"
				}
			}
		}
		if (($Parameter.ParameterType.Name -eq 'DateTime') -or ($Parameter.ParameterType.Name -eq 'DateTime[]')) {
			Write-Verbose "Found DateTime or DateTime Array param $($ParameterVariable.Name) with value $($ParameterVariable.Value)."
			if ($null -eq $ParameterVariable.Value) {
				Write-Verbose "Skipping unset param $($ParameterVariable.Name)"
				Continue
			} else {
				if ($Parameter.Aliases) {
					# Use the first alias as the query.
					$Query = ([String]$Parameter.Aliases[0])
				} else {
					# If no aliases then use the name.
					$Query = ([String]$ParameterVariable.Name)
				}
				$Value = $ParameterVariable.Value
				if (($Value -is [Array]) -and ($CommaSeparatedArrays)) {
					Write-Verbose 'Building comma separated array string.'
					$QueryValue = $Value -join ','
					$QSCollection.Add($Query, $QueryValue.ToUnixEpoch())
					Write-Verbose "Adding parameter $($Query) with value $($QueryValue)"
				} elseif (($Value -is [Array]) -and (-not $CommaSeparatedArrays)) {
					foreach ($ArrayValue in $Value) {
						$QSCollection.Add($Query, $ArrayValue)
						Write-Verbose "Adding parameter $($Query) with value $($ArrayValue)"
					}
				} else {
					$QSCollection.Add($Query, $Value)
					Write-Verbose "Adding parameter $($Query) with value $($Value)"
				}
			}
		}
	}
	Write-Verbose "Query collection contains $($QSCollection | Out-String)"
	if ($AsString) {
		$QSBuilder.Query = $QSCollection.ToString()
		$Query = $QSBuilder.Query.ToString()
		return $Query
	} else {
		return $QSCollection
	}
}