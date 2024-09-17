<#
    .SYNOPSIS
        Help test suite for the x360Recover module.
#>
$ModuleName = Get-ChildItem -Path '.\Source\*' -Include '*.psd1' -Exclude 'build.psd1' | Select-Object -ExpandProperty BaseName
BeforeDiscovery {
    $ModuleName = Get-ChildItem -Path '.\Source\*' -Include '*.psd1' -Exclude 'build.psd1' | Select-Object -ExpandProperty BaseName
    if (Get-Module -Name $ModuleName) {
        Remove-Module $ModuleName -Force
    }
    $ModulePath = Resolve-Path -Path ".\Output\module\$ModuleName" | Sort-Object -Property BaseName | Select-Object -Last 1 -ExpandProperty Path
    $ManifestPath = Get-ChildItem -Path ('{0}\*\*.psd1' -f $ModulePath) -Exclude 'build.psd1' | Select-Object -ExpandProperty FullName
    Import-Module $ManifestPath -Verbose:$False

	Add-type -Path ".\Source\Binaries\MetadataAttribute.dll"
}
BeforeAll {
}
Describe ('{0} - Help Content' -f $ModuleName) -Tags 'Module' {
    # Get a list of the exported functions.
    $Module = Get-Module -Name $ModuleName
    $FunctionList = $Module.ExportedFunctions.Values
    Context 'Function <_>' -ForEach $FunctionList {
        $Help = Get-Help -Name $_ -Full | Select-Object -Property *
        if ($Help.PSObject.Properties.Name -contains 'Examples') {
            $Examples = $Help.Examples.Example
        } else {
            $Examples = $null
        }
        $Parameters = ([System.Management.Automation.CommandMetadata]$_).Parameters
        $AST = Get-Content -Path ('function:/{0}' -f $_) -ErrorAction Ignore | Select-Object -ExpandProperty AST
        # Help content tests.
        ## Help content exists.
        It 'has help content' -TestCases $Help {
            $_ | Should -Not -BeNullOrEmpty
        }
        ## Synopsis exists.
        It 'contains a synopsis' -TestCases $Help {
            $_.Synopsis | Should -Not -BeNullOrEmpty
        }
        ## Description exists.
        It 'contains a description' -TestCases $Help {
            $_.Description | Should -Not -BeNullOrEmpty
        }
        ## Example exists.
        It 'has at least one usage example' -TestCases $Help {
            $_.PSObject.Properties.Name | Should -Contain -ExpectedValue 'Examples' -Because 'at least one example is required for each function.'
            if ($_.PSObject.Properties.Name -contains 'Examples') {
                $_.Examples.PSObject.Properties.Name | Should -Contain -ExpectedValue 'Example' -Because 'at least one example is required for each function.'
            }
            if (-not [String]::IsNullOrEmpty($_.Examples.Example.Code) -and $_.PSObject.Properties.Name -contains 'Examples' -and $_.Examples.PSObject.Properties.Name -contains 'Example' -and $_.Examples.Example.PSObject.Properties.Name -contains 'Code' -and $_.Examples.Example.Code.PSObject.Properties.Name -contains 'Count') {
                $_.Examples.Example.Code.Count | Should -BeGreaterOrEqual 1 -Because 'at least one example is required for each function.'
            }
        }
        ## Examples have a title.
        ### This test is not currently meaningful because it is not possible to set an example title using Comment Based Help at this time. However examples do get a default `Example n` title where n is the sequential number of the example. Ref: https://github.com/PowerShell/PowerShell/issues/20712.
        It 'has a title for each example' -TestCases $Examples -Skip:(-not $Examples) {
            $_.Title | Should -Not -BeNullOrEmpty
        }
        ## Examples have a description.
        It 'has a description for each example' -TestCases $Examples -Skip:(-not $Examples) {
            $_.Remarks | Should -Not -BeNullOrEmpty -Because ('example {0} should have a description' -f $_.Title)
        }
        # AST tests.
    }
}

AfterAll {
    $ModuleName = Get-ChildItem -Path '.\Source' -Filter '*.psd1' | Select-Object -ExpandProperty BaseName
    if (Get-Module -Name $ModuleName) {
        Remove-Module $ModuleName -Force
    }
}