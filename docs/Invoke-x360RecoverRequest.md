---
external help file: PSx360Recover-help.xml
Module Name: PSx360Recover
online version:
schema: 2.0.0
---

# Invoke-x360RecoverRequest

## SYNOPSIS
Sends an HTTP request to the specified URI using the specified method.

## SYNTAX

```
Invoke-x360RecoverRequest [-Method] <String> [-Uri] <String> [[-Body] <String>] [-Raw]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet sends an HTTP request to the specified URI using the specified method.
It supports GET, POST, PUT, PATCH, and DELETE methods.
Optionally, it can include a request body and return the raw response.

## EXAMPLES

### EXAMPLE 1
```
Invoke-x360RecoverRequest -Method GET -Uri "https://axapi.axcient.com/x360recover/device"
```

Sends a GET request to the x360 Device endpoint and returns JSON reponse.

### EXAMPLE 2
```
Invoke-x360RecoverRequest -Method POST -Uri "https://axapi.axcient.com/x360recover" -Body '{"key":"value"}'
```

Sends a POST request with the specified body to the specified URI and returns the response.

### EXAMPLE 3
```
Invoke-x360RecoverRequest -Method GET -Uri "https://axapi.axcient.com/x360recover/organization" -Raw
```

Sends a GET request to the x360Organization endpoint and returns the raw response.

## PARAMETERS

### -Method
The HTTP method to use.
Valid values are GET, POST, PUT, PATCH, and DELETE.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Uri
The URI to send the request to.
Must be a valid HTTP or HTTPS URI.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Body
The body of the request.
Must be a valid JSON string if provided.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw
If specified, returns the raw response without converting from JSON.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
