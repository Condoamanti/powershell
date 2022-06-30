function Set-DefaultTrueNASServer {
<#
    .SYNOPSIS

    .DESCRIPTION

    .EXAMPLE

    .EXAMPLE

    .EXAMPLE

    .EXAMPLE
#>
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    [OutputType([ARRAY[]])]
    Param
    (
        # Specifies the TrueNAS server that is being connected too.
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Test-TrueNASUriRegex -Uri $_ -Type "ServerName"})]
        [Parameter(Mandatory = $true,
                    Position = 0)]
        [STRING] $ServerName
    )
    Begin
    {
        #Validate if there is a $script:defaultTrueNASServer value
        if (!$script:defaultTrueNASServer) {
            Write-Error -Message "Currently there are no available default TrueNAS servers. Please connect to a TrueNAS server first using the 'Connect-TrueNAS' function." -Category ObjectNotFound -CategoryActivity "Set-DefaultTrueNASServer" -CategoryTargetName $ServerName -ErrorAction Stop
        }
    }
    Process
    {
        $ConfirmPreference = "Medium"
        if ($pscmdlet.ShouldProcess("$ServerName", "Set-DefaultTrueNASServer")) {
            # Validate if the variable $script:defaultTrueNASServer contains a connection already established based on server name.
            if ($script:defaultTrueNASServer.servername -contains $ServerName) {
                Write-Verbose "Setting default TrueNAS server [$ServerName]."
                $script:defaultTrueNASServer = $script:defaultTrueNASServers | Where-Object {$_.servername -eq $ServerName}
            } else {
                Write-Error -Exception "Could not find any of the servers specified by the name [$ServerName]. Please verify you are currently connected to TrueNAS servers using the Show-DefaultTrueNASServers function." -Category ObjectNotFound -CategoryActivity "Set-DefaultTrueNASServer" -CategoryTargetName $ServerName -ErrorAction Stop
            }
        }
    }
    End
    {
        return "here"
    }
}