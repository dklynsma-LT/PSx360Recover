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
| [Connect-x360Recover](./docs/Connect-x360Recover.md) | Connects to the x360Recover API instance. |
| [Get-x360RecoverAppliance](./docs/Get-x360RecoverAppliance.md) | Retrieves appliance information from x360Recover. |
| [Get-x360RecoverApplianceByClient](./docs/Get-x360RecoverApplianceByClient.md) | Retrieves appliance information for a specified client from x360Recover. |
| [Get-x360RecoverBackupJob](./docs/Get-x360RecoverBackupJob.md) | Retrieves backup job information for a specified client and device. |
| [Get-x360RecoverBackupJobHistory](./docs/Get-x360RecoverBackupJobHistory.md) | Retrieves the backup job history for a specified client, device, and job. |
| [Get-x360RecoverClient](./docs/Get-x360RecoverClient.md) | Retrieves client information from x360Recover. |
| [Get-x360RecoverDevice](./docs/Get-x360RecoverDevice.md) | Retrieves AutoVerify information for a specified device. |
| [Get-x360RecoverDeviceAutoVerify](./docs/Get-x360RecoverDeviceAutoVerify.md) | Retrieves AutoVerify information for a specified device. |
| [Get-x360RecoverDeviceByClient](./docs/Get-x360RecoverDeviceByClient.md) | Retrieves device information for a specified client from x360Recover. |
| [Get-x360RecoverDeviceRestorePoint](./docs/Get-x360RecoverDeviceRestorePoint.md) | Retrieves restore point information for a specified device. |
| [Get-x360RecoverOrganization](./docs/Get-x360RecoverOrganization.md) | Retrieves organization information from x360Recover. |
| [Get-x360RecoverVault](./docs/Get-x360RecoverVault.md) | Retrieves information about x360Recover vaults. |
| [Get-x360RecoverVaultConnThreshold](./docs/Get-x360RecoverVaultConnThreshold.md) | Retrieves the connectivity threshold information for a specified x360Recover vault. |
| [Invoke-x360RecoverRequest](./docs/Invoke-x360RecoverRequest.md) | Sends an HTTP request to the specified URI using the specified method. |
