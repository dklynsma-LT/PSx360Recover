![Axcient Logo](https://axcient.com/wp-content/webp-express/webp-images/doc-root/wp-content/uploads/2023/11/logo_main.png.webp)
# PSx360Recover

A Powershell API wrapper for the new Axcient x360Recover Public API (https://developer.axcient.com). This project HEAVILY inspired by Mikey O'Tooles' work on the NinjaOne Powershell API (https://github.com/homotechsual/NinjaOne) with tidbits from Adam Burley's work on the AxcientAPI PSModule (https://github.com/adamburley/AxcientAPI).

As Adam states, the API is in early access and subject to change and bugs should be expected.

## Getting Started

**Compatibility**: PowerShell 5.1 or PowerShell 7 Core

```PowerShell
PS > Import-Module PSx360Recover
PS > Connect-x360Recover -ApiKey 'yourlongkey' -Instance 'prod'
PS > Get-x360RecoverOrganization
```

## Functions

| Function | Synopsis |
| --- | --- |

## Output Levels

All commandlets support the `-Verbose` parameter which will output detailed information about what the commandlet is doing. If you want to see this output you can use the `-Verbose` parameter on any commandlet. For example:

```Powershell
PS > Get-x360RecoverDevice -Verbose
```

All commandlets also support the `-Debug` paramter which may provide addtional troubleshooting information about what the commandlet is doing. If you want to see this output, use the `-Debug` parameter on any commandlet. For example:

```Powershell
PS > Get-x360RecoverDevice -Verbose
```

## Documentation
Documentation on the Axcient x360Recover API is available at https://developer.axcient.com.

Code generated documentation on the commands included in this module can be found in the Docs directory. Work smarter not harder they say. :smirk:

## TODO

1. [ ] Add comment based help to all functions
2. [ ] Resolve Pester test findings
3. [ ] Use in live environments for other bugs or usability issues.
4. [ ] Add -all parameter on get requests to deal with pagination.
5. [ ] Implement set endpoint