function Set-x360RecoverVaultConnThreshold {
<#
.SYNOPSIS
    Sets the connectivity threshold for a specified vault in x360Recover.

.DESCRIPTION
    This cmdlet sets the connectivity threshold for a specified vault in the x360Recover system. It sends a POST request to the x360Recover API with the provided vault ID and threshold value.

.PARAMETER vaultId
    The ID of the vault to set the connectivity threshold for. This parameter is mandatory and can be piped.

.PARAMETER threshold
    The connectivity threshold value to set for the vault. This parameter is mandatory.

.EXAMPLE
    PS> Set-x360RecoverVaultConnThreshold -vaultId 12345 -threshold 10

    Sets the connectivity threshold to 10 for the vault with ID 12345.

.INPUTS
    System.Int64. The vault ID can be piped to this cmdlet.
    System.Int32. The threshold value can be piped to this cmdlet.

.OUTPUTS
    System.Object. The response from the x360Recover API.
#>
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([Object])]
	[MetadataAttribute(
		'/vault/{vault_id}/threshold/connectivity',
		'post'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# Return infomation about a single vault
		[Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('vault_id','id')]
		[Int64]$vaultId,
		# Return infomation about a single vault
		[Parameter(Mandatory, Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Int]$threshold
	)
	process {
		try {
			Write-Verbose ('Setting connectivity thresholds for vaultid {0}.' -f $vaultId)
			$Resource = ('vault/{0}/threshold/connectivity' -f $vaultId)

			$Body = @{}
			$Body.threshold = $threshold

			$RequestParams = @{
				Resource = $Resource
				Body = $Body
			}
			if ($PSCmdlet.ShouldProcess(('Connectivity threshold for vaultid {0}' -f $vaultId), 'Set')) {
				$Result = New-x360RecoverPOSTRequest @RequestParams
				if ($Result -eq 200) {
					Write-Information ('Connectivity threshold for vaultid {0} updated successfully.' -f $vaultId)
				}
			}
		} catch {
			New-x360RecoverError -ErrorRecord $_
		}
	}
}