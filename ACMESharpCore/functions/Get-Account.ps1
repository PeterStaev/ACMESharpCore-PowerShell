function Get-Account {
    <#
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNull()]
        [uri] $Url, 

        [Parameter(Mandatory = $true, Position = 1)]
        [ValidateNotNull()]
        [ACMESharp.Crypto.JOSE.JwsAlgorithm] $JwsAlgorithm,

        [Parameter(Mandatory = $true, Position = 2)]
        [ValidateNotNullOrEmpty()]
        [string] $KeyId,

        [Parameter(Mandatory = $true, Position = 3)]
        [ValidateNotNullOrEmpty()]
        [string] $Nonce = $Script:Nonce
    )

    $requestBody = New-SignedMessage -Url $Url -Payload @{} -JwsAlgorithm $JwsAlgorithm -KeyId $KeyId -Nonce $Nonce

    $response = Invoke-AcmeWebRequest $Url -Method POST -JsonBody $requestBody
    return [AcmeAccount]::new($response, $KeyId, $JwsAlgorithm);
}