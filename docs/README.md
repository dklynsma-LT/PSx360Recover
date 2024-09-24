## Functions

| Function | Synopsis |
| --- | --- |
| [Connect-x360Recover](./docs/Connect-x360Recover.md) | Connects to the x360Recover API instance. |
| [Get-x360RecoverAppliance](./docs/Get-x360RecoverAppliance.md) | Retrieves information about x360Recover appliances. |
| [Get-x360RecoverApplianceByClient](./docs/Get-x360RecoverApplianceByClient.md) | 
Get-x360RecoverApplianceByClient [-clientId] <long> [[-includeDevices] <bool>] [<CommonParameters>]
 |
| [Get-x360RecoverBackupJob](./docs/Get-x360RecoverBackupJob.md) | 
Get-x360RecoverBackupJob [-clientId] <long> [-deviceId] <long> [<CommonParameters>]

Get-x360RecoverBackupJob [-clientId] <long> [-deviceId] <long> [-jobId] <long> [<CommonParameters>]
 |
| [Get-x360RecoverBackupJobHistory](./docs/Get-x360RecoverBackupJobHistory.md) | 
Get-x360RecoverBackupJobHistory [-clientId] <long> [-deviceId] <long> [-jobId] <long> [[-limit] <long>] [[-offset] <long>] [[-jobsAfter] <datetime>] [<CommonParameters>]
 |
| [Get-x360RecoverClient](./docs/Get-x360RecoverClient.md) | 
Get-x360RecoverClient [[-includeAppliances] <bool>] [<CommonParameters>]

Get-x360RecoverClient [-clientId] <long> [[-includeAppliances] <bool>] [<CommonParameters>]
 |
| [Get-x360RecoverDevice](./docs/Get-x360RecoverDevice.md) | 
Get-x360RecoverDevice [[-limit] <long>] [[-offset] <long>] [<CommonParameters>]

Get-x360RecoverDevice [[-deviceId] <long>] [<CommonParameters>]
 |
| [Get-x360RecoverDeviceAutoVerify](./docs/Get-x360RecoverDeviceAutoVerify.md) | 
Get-x360RecoverDeviceAutoVerify [-deviceId] <long> [<CommonParameters>]
 |
| [Get-x360RecoverDeviceByClient](./docs/Get-x360RecoverDeviceByClient.md) | 
Get-x360RecoverDeviceByClient [-clientId] <long> [[-serviceId] <string>] [[-d2cOnly] <bool>] [<CommonParameters>]
 |
| [Get-x360RecoverDeviceRestorePoint](./docs/Get-x360RecoverDeviceRestorePoint.md) | 
Get-x360RecoverDeviceRestorePoint [-deviceId] <long> [<CommonParameters>]
 |
| [Get-x360RecoverOrganization](./docs/Get-x360RecoverOrganization.md) | Retrieves organization information from x360Recover. |
| [Get-x360RecoverVault](./docs/Get-x360RecoverVault.md) | 
Get-x360RecoverVault [[-vaultType] <string>] [[-active] <bool>] [[-withUrl] <bool>] [[-limit] <long>] [[-includeDevices] <bool>] [<CommonParameters>]

Get-x360RecoverVault [[-vaultId] <int>] [<CommonParameters>]
 |
| [Get-x360RecoverVaultConnThreshold](./docs/Get-x360RecoverVaultConnThreshold.md) | 
Get-x360RecoverVaultConnThreshold [-vaultId] <int> [<CommonParameters>]
 |
| [Invoke-x360RecoverRequest](./docs/Invoke-x360RecoverRequest.md) | Sends an HTTP request to the specified URI using the specified method. |

#
