#Code that runs when the module is imported
function Initialize-Module {
	# Set the x360Recover instances.
	[hashtable]$Script:x360RInstances = @{
		'prod' = 'https://axapi.axcient.com'
		'mock' = 'https://ax-pub-recover.wiremockapi.cloud'
	}
}
