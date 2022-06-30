function Show-DefaultTrueNASServer {
<#
    .SYNOPSIS

    .DESCRIPTION

    .EXAMPLE

    .EXAMPLE

    .EXAMPLE

    .EXAMPLE
#>
    if ($script:defaultTrueNASServer) {
        return $script:defaultTrueNASServer
    } else {
        Write-Error -Message "Currently there is no available default TrueNAS server. Please connect to a TrueNAS server first using the 'Connect-TrueNAS' function." -Category ObjectNotFound -CategoryActivity "Show-DefaultTrueNASServer" -CategoryReason "ServerObjectFailureException" -ErrorAction Stop
    }
}