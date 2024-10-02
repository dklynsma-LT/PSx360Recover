task RebuildDocs {
	# a workaround because we can't import platyPS within the same session as the build script without causing a conflict
	# so all of this - starts a script in a new session and outputs back to the current session
	$stdOutTempFile = "$env:TEMP\$((New-Guid).Guid)"
	$stdErrTempFile = "$env:TEMP\$((New-Guid).Guid)"

	try {
		$startProcessParams = @{
			FilePath = 'pwsh'
			ArgumentList = ".\.build\tasks\RebuildDocs.ps1"
			RedirectStandardOutput = $stdOutTempFile
			RedirectStandardError = $stdErrTempFile
			PassThru = $true;
			Wait = $true;
			NoNewWindow = $true;
		}
		$cmd = Start-Process @startProcessParams
		$cmdOutput = Get-Content -Path $stdOutTempFile -Raw
		$cmdError = Get-Content -Path $stdErrTempFile -Raw
		if ($cmd.ExitCode -ne 0) {
			if ($cmdError) {
				throw $cmdError.Trim()
			}
			if ($cmdOutput) {
				throw $cmdOutput.Trim()
			}
		} else {
			if ([string]::IsNullOrEmpty($cmdOutput) -eq $false) {
				Write-Output -InputObject $cmdOutput
			}
		}
	} catch {
		throw $_
	} finally {
		if (Test-Path -Path $stdOutTempFile) {
			Remove-Item -Path $stdOutTempFile -Force
		}
		if (Test-Path -Path $stdErrTempFile) {
			Remove-Item -Path $stdErrTempFile -Force
		}
	}
}