function Disconnect-TrueNASServer {
<#
    .SYNOPSIS

    .DESCRIPTION

    .EXAMPLE

    .EXAMPLE

    .EXAMPLE

    .EXAMPLE
#>
    [CmdletBinding(SupportsShouldProcess,
                    DefaultParameterSetName = 'DefaultParameterSet')]
    [Alias()]
    [OutputType([ARRAY[]])]
    Param
    (
        # Specifies the TrueNAS server that is being connected too.
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Test-TrueNASUriRegex -Uri $_ -Type "ServerName"})]
        [ValidateScript({ if ($null -eq $script:defaultTrueNASServer) {Throw "You are not currently connected to any TrueNAS servers. Please connect to a TrueNAS server first using the 'Connect-TrueNASServer' cmdlet."} else {$true} })]
        [Parameter(Mandatory = $true,
                    ParametersetName = 'DefaultParameterSet',
                    Position = 0)]
        [STRING]$ServerName
    )
    Begin
    {
    }
    Process
    {
        $ConfirmPreference = "Medium"
        if ($pscmdlet.ShouldProcess("$ServerName", "Disconnect-TrueNASServer")) {
            # Validate if the variable $script:defaultTrueNASServers contains a connection established and remove it.
            if ($script:defaultTrueNASServers.servername -contains $ServerName) {
                Write-Verbose "Removing existing connection for TrueNAS server [$ServerName]."
                $script:defaultTrueNASServers = $script:defaultTrueNASServers | Where-Object {$_.servername -ne $ServerName}

                # Validate if the variable $script:defaultTrueNASServer contains a connection established and remove it.
                if ($script:defaultTrueNASServer.servername -eq $ServerName) {
                    $script:defaultTrueNASServer = $null
                }
            } else {
                Write-Error $_ -ErrorAction Stop
            }
        }
    }
    End
    {
    }
}