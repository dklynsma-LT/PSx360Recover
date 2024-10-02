$PSGalleryAPIKey = Get-Secret -name PSGalleryAPIKey -AsPlainText
Publish-Module -Path .\Output\module\PSx360Recover\0.1.0 -NuGetApiKey $PSGalleryAPIKey -Verbose