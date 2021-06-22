param (
    [Parameter(Mandatory = $true)]
    [string]
    $Name,

    [Parameter()]
    [string[]]
    $ResourceType
)

if (!$ResourceType) {
    Get-AzResource -ResourceGroupName $Name |
        ForEach-Object -Process {
            Remove-AzResource -ResourceId $_.Id -Force
        }
}
else {
    foreach ($rt in $ResourceType) {
        Get-AzResource -ResourceGroupName $Name -ResourceType $rt |
            ForEach-Object -Process {
                Remove-AzResource -ResourceId $_.Id -Force
            }
    }
}
