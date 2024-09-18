## Functions

| Function | Synopsis |
| --- | --- |
| [Connect-x360Recover](./docs/Connect-x360Recover.md) | 
Connect-x360Recover [-ApiKey <string>] [-Instance <string>] [-UseSecretManagement] [-VaultName <string>] [-WriteToSecretVault] [<CommonParameters>]

Connect-x360Recover -VaultName <string> -WriteToSecretVault [-ApiKey <string>] [-Instance <string>] [-UseSecretManagement] [-SecretPrefix <string>] [<CommonParameters>]

Connect-x360Recover -VaultName <string> [-UseSecretManagement] [-WriteToSecretVault] [-ReadFromSecretVault] [-SecretPrefix <string>] [<CommonParameters>]
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
| [Get-x360RecoverVault](./docs/Get-x360RecoverVault.md) | 
Get-x360RecoverVault [[-vaultType] <string>] [[-active] <bool>] [[-withUrl] <bool>] [[-limit] <long>] [[-includeDevices] <bool>] [<CommonParameters>]

Get-x360RecoverVault [[-vaultId] <int>] [<CommonParameters>]
 |
| [Get-x360RecoverVaultConnThreshold](./docs/Get-x360RecoverVaultConnThreshold.md) | 
Get-x360RecoverVaultConnThreshold [-vaultId] <int> [<CommonParameters>]
 |
| [Invoke-x360RecoverRequest](./docs/Invoke-x360RecoverRequest.md) | 
Invoke-x360RecoverRequest [-Method] <string> [-Uri] <string> [[-Body] <string>] [-Raw] [<CommonParameters>]
 |

#
