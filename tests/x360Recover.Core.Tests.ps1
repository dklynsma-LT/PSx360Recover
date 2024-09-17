<#
    .SYNOPSIS
        Core test suite for the PSx360Recover module.
#>

$ModuleName = Get-ChildItem -Path '.\Source' -Filter '*.psd1' | Select-Object -ExpandProperty BaseName

BeforeAll {
    $ModuleName = Get-ChildItem -Path '.\Source' -Filter '*.psd1' | Select-Object -ExpandProperty BaseName
    $ManifestPath = Get-ChildItem -Path '.\Source' -Filter '*.psd1'  | Select-Object -ExpandProperty FullName
    if (Get-Module -Name $ModuleName) {
        Remove-Module $ModuleName -Force
    }
    Import-Module $ManifestPath -Verbose:$False
    $Script:ModuleInformation = Import-Module -Name $ManifestPath -PassThru

}

Describe ('{0} - Core Tests' -f $ModuleName) -Tags 'Module' {
    It 'Manifest is valid' {
        {
            Test-ModuleManifest -Path $ManifestPath -ErrorAction Stop -WarningAction SilentlyContinue
        } | Should -Not -Throw
    }

    It 'Root module is correct' {
        $Script:ModuleInformation.RootModule | Should -Be ".\$($ModuleName).psm1"
    }

    It 'Has a description' {
        $Script:ModuleInformation.Description | Should -Not -BeNullOrEmpty
    }

    It 'GUID is correct' {
        $Script:ModuleInformation.GUID | Should -Be '34e3f7e5-2f13-4b03-9a20-425791bedb0a'
    }

    It 'Version is valid' {
        $Script:ModuleInformation.Version -As [Version] | Should -Not -BeNullOrEmpty
    }

    It 'Copyright is present' {
        $Script:ModuleInformation.Copyright | Should -Not -BeNullOrEmpty
    }

    It 'License URI is correct' {
        $Script:ModuleInformation.LicenseUri | Should -Not -BeNullOrEmpty
    }

    It 'Project URI is correct' {
        $Script:ModuleInformation.ProjectUri | Should -Not -BeNullOrEmpty
    }

    It 'PowerShell Gallery tags is not empty' {
        $Script:ModuleInformation.Tags.count | Should -Not -BeNullOrEmpty
    }

    It 'PowerShell Gallery tags do not contain spaces' {
        foreach ($Tag in $Script:ModuleInformation.Tags) {
            $Tag -NotMatch '\s' | Should -Be $True
        }
    }
}

Describe ('{0} - Module Load Test' -f $ModuleName) -Tags 'Module' {
    It 'Passed Module load' {
        Get-Module -Name 'x360Recover' | Should -Not -Be $null
    }
}

AfterAll {
    Remove-Module $ModuleName -Force
}