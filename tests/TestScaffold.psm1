function Get-ModuleName {
    return 'PSx360Recover'
}
function Get-Endpoints ([uri]$SchemaURI = 'https://developer.axcient.com/wp-content/plugins/swagger-ui-display/specs/x360Recover.yaml') {
    $Endpoints = [System.Collections.Generic.List[PSObject]]::new()
    $ProgressPreference = 'SilentlyContinue'
    $SchemaObject = Invoke-WebRequest -Uri $SchemaURI -UseBasicParsing | ConvertFrom-Yaml
    $ProgressPreference = 'Continue'
    foreach ($Path in $SchemaObject.paths.GetEnumerator()) {
        foreach ($Method in $Path.Value.GetEnumerator()) {
            $Endpoints.Add(
                @{
                    Path = $Path.Name
                    Method = $Method.Name
                }
            )
        }
    }
    return $Endpoints
}

function Import-ModuleToBeTested {
    $ModuleName = Get-ModuleName
    if (Get-Module -Name $ModuleName) {
        Remove-Module $ModuleName -Force
    }
    $ManifestPath = Get-ChildItem -Path (Join-Path -Path . -ChildPath 'Source') -Filter ('{0}.psd1' -f $ModuleName) | Select-Object -ExpandProperty FullName
    Import-Module $ManifestPath -Verbose:$False -Force
}

function Get-FunctionList {
    $ModuleName = Get-ModuleName
    $Module = Get-Module -Name $ModuleName
    $FunctionList = $Module.ExportedFunctions.Values
    return $FunctionList
}

function Get-MetadataElement {
    param(
        [Parameter(Mandatory)]
        [System.Management.Automation.Language.FunctionDefinitionAst]$AST
    )
    $MetadataFinder = { $args[0] -is [System.Management.Automation.Language.AttributeAst] -and $args[0].TypeName.Name -eq 'MetadataAttribute' -and $args[0].Parent -is [System.Management.Automation.Language.ParamBlockAst] }
    $MetadataElement = $AST.FindAll($MetadataFinder, $true)
    return $MetadataElement
}

function Get-PositionalArguments {
    param(
        [Parameter(Mandatory)]
        [System.Collections.Generic.List[System.Management.Automation.Language.AttributeAst]]$MetadataElement
    )
    if ($MetadataElement[0].PSObject.Properties.Name -match 'PositionalArguments') {
        $PositionalArguments = $MetadataElement[0].PositionalArguments
    } else {
        $PositionalArguments = @{}
    }
    return $PositionalArguments
}
function Get-Metadata {
    param(
        [System.Collections.ObjectModel.ReadOnlyCollection[System.Management.Automation.Language.StringConstantExpressionAst]]$PositionalArguments
    )
    if ($PositionalArguments.Count -gt 0 -and ($PositionalArguments.Count % 2 -eq 0)) {
        $Metadata = for ($i = 0; $i -lt $PositionalArguments.Count; $i += 2) {
            [hashtable]@{
                Endpoint = $PositionalArguments[$i].Value
                Method = $PositionalArguments[$i + 1].Value
            }
        }
    } else {
        $Metadata = @{}
    }
    return $Metadata
}

function Get-AllMetadata {
    $FunctionList = Get-FunctionList
    $AllMetadata = foreach ($Function in $FunctionList) {
        $AST = $Function.ScriptBlock.Ast
        $MetadataElement = Get-MetadataElement -AST $AST
        $PositionalArguments = Get-PositionalArguments -MetadataElement $MetadataElement
        $Metadata = Get-Metadata -PositionalArguments $PositionalArguments
        $Metadata
    }
    return $AllMetadata
}