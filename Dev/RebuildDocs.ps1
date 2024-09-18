# Import our module
$ModuleName = Get-ChildItem -Path '.\Source\*' -Include '*.psd1' -Exclude 'build.psd1' | Select-Object -ExpandProperty BaseName
if (Get-Module -Name $ModuleName) {
	Remove-Module $ModuleName -Force
}
$ModulePath = Resolve-Path -Path ".\Output\module\$ModuleName" | Sort-Object -Property BaseName | Select-Object -Last 1 -ExpandProperty Path
$ManifestPath = Get-ChildItem -Path ('{0}\*\*.psd1' -f $ModulePath) -Exclude 'build.psd1' | Select-Object -ExpandProperty FullName
Import-Module $ManifestPath -Verbose:$False

# Import platyPS
Import-Module platyPS -Force
Add-type -Path ".\Source\Binaries\MetadataAttribute.dll"
New-MarkDownHelp -Module $ModuleName -OutputFolder '.\docs' -ExcludeDontShow -Force

# Create summary page
$summaryContent = "## Functions`n`n| Function | Synopsis |`n| --- | --- |`n"
$commands = (Get-Module -Name $ModuleName).ExportedCommands.Keys
foreach ($command in $commands) {
	$cHelpSummary = Get-Help -Name $command -Full | Select-Object -ExpandProperty Synopsis
	$summaryContent += "| [$command](./docs/$command.md) | $cHelpSummary |`n"
}
$summaryContent += "`n#"
$summaryContent | Set-Content -Path '.\docs\README.md'
#$ReadmeContent = [regex]::Replace($ReadmeContent,"## Functions\n\n(?'helpfiles'.*?)\n\n#{1}",$summaryContent,[System.Text.RegularExpressions.RegexOptions]::Singleline)

$ReadmeContent | Set-Content -Path '.\README.md'