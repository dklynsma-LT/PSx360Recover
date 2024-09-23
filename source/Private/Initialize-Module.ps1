# Called from the Connect-x360Recover function to initialize the x360Recover module by setting script wide variables.
# Maybe not necessary?
function Initialize-Module {
	<#
    .SYNOPSIS
        Initializes the x360Recover module by setting instance URLs.

    .DESCRIPTION
        This function sets the URLs for the x360Recover instances (production and mock).

    .NOTES
        Ensure this function is called before any other functions that depend on the instance URLs.
    #>
	# Set the x360Recover instances.
	[hashtable]$Script:x360RInstances = @{
		'prod' = 'https://axapi.axcient.com/x360recover'
		'mock' = 'https://ax-pub-recover.wiremockapi.cloud'
	}
}
