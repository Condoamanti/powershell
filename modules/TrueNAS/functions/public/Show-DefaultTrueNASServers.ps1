function Show-DefaultTrueNASServers {
<#
    .SYNOPSIS

    .DESCRIPTION

    .EXAMPLE

    .EXAMPLE

    .EXAMPLE

    .EXAMPLE
#>
    if ($script:defaultTrueNASServers) {
        return $script:defaultTrueNASServers
    } else {
        Write-Error -Message "Currently there are no available default TrueNAS servers. Please connect to a TrueNAS server first using the 'Connect-TrueNAS' function." -Category ObjectNotFound -CategoryActivity "Show-DefaultTrueNASServers" -CategoryReason "ServerObjectFailureException" -ErrorAction Stop
    }
}