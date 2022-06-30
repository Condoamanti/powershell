Function New-MSTSCSession
{
<#
.Synopsis
   Creates a new Microsoft terminal services client session for the computer specified with the user name and password or credentials provided.
.DESCRIPTION
   The New-MSTSCSession cmdlet creates a new Microsoft terminal services client session for the computer specified with the user name and password or credentials provided.

.EXAMPLE
   C:\PS>New-MSTSCSession -ComputerName "MSN-065" -User "jpancake" -Password "P@ssW0rd" -Fullscreen

   Creates a new Microsoft terminal services client session for the computer "MSN-065" using the username "jpancake" and the password "P@ssW0rd" using the full screen resolution.
.EXAMPLE
   C:\PS>New-MSTSCSession -ComputerName "MSN-900" -Credential (Get-Credential)

   Creates a new Microsoft terminal services client session for the computer "MSN-900" using the credentials provided from the command "Get-Credential".

.EXAMPLE
   C:\PS>$NetworkCredentials = Get-Credential -UserName "spancake@contoso.com" -Message "Please enter the network username and password."
   C:\PS>New-MSTSCSession -ComputerName "MSN-1608" -Credential $NetworkCredentials

   Creates a variable named "NetworkCredentials" which is the users network username and password. Then function then creates a new Microsoft terminal services client session is provided the credentials from the variable "$NetworkCredentials".
#>
    [CmdletBinding(SupportsShouldProcess,
                    DefaultParametersetName = 'Credential')]
    [Alias()]
    [OutputType([STRING[]])]
    Param
    (
        # Specifies the computer that is being connected to via the Microsoft terminal services client session.
        [Parameter(Mandatory = $true,
                    ValueFromPipeline = $true,
                    ValueFromPipelineByPropertyName = $true,
                    Position = 0)]
        [STRING]$ComputerName,

        # Specifies a user name to be used for logging into the computer.
        [Parameter(Mandatory = $true,
                    ValueFromPipeline = $true,
                    ValueFromPipelineByPropertyName = $true,
                    ParametersetName = 'UserPassword',
                    Position = 1)]
        [STRING] $UserName,

        # Specifies the password to be used for logging into the computer.
        [Parameter(Mandatory = $true,
                    ValueFromPipeline = $true,
                    ValueFromPipelineByPropertyName = $true,
                    ParametersetName = 'UserPassword',
                    Position = 2)]
        [STRING] $Password,

        # Specifies a stored credential to be used as the authentication for passing the user name and password.
        [Parameter(Mandatory = $true,
                    ParametersetName = 'Credential',
                    Position = 1)]
        [PSCREDENTIAL]$Credential,

        # MSTSC Setting (Admin)
        [Parameter(Mandatory = $false)]
        [SWITCH]$Admin,

        # MSTSC Setting (MultiMon)
        [Parameter(Mandatory = $false)]
        [SWITCH]$MultiMon,

        # MSTSC Setting (FullScreen)
        [Parameter(Mandatory = $false)]
        [SWITCH]$FullScreen,

        # MSTSC Setting (Public)
        [Parameter(Mandatory = $false)]
        [SWITCH]$Public,

        # MSTSC Setting (Width)
        [Parameter(Mandatory = $false)]
        [INT]$Width,

        # MSTSC Setting (Height)
        [Parameter(Mandatory = $false)]
        [INT]$Height,

        # MSTSC Setting (Wait)
        [Parameter(Mandatory = $false)]
        [SWITCH]$Wait
    )

    Begin
    {
        [STRING]$MstscArguments = $null
        Switch ($true)
        {
            {$Admin}
            {
                $MstscArguments += '/admin '
            }
            {$MultiMon}
            {
                $MstscArguments += '/multimon '
            }
            {$FullScreen}
            {
                $MstscArguments += '/f '
            }
            {$Public}
            {
                $MstscArguments += '/public '
            }
            {$Width}
            {
                $MstscArguments += "/w:$Width "
            }
            {$Height}
            {
                $MstscArguments += "/h:$Height "
            }
        }

        If ($Credential)
        {
            $UserName = $Credential.UserName
            $Password = $Credential.GetNetworkCredential().Password
        }
    }
    Process
    {
            $ProcessInfo = New-Object System.Diagnostics.ProcessStartInfo
            $Process = New-Object System.Diagnostics.Process

            if ($ComputerName.Contains(':'))
            {
                $ComputerCmdkey = ($ComputerName -split ':')[0]
            }
            Else
            {
                $ComputerCmdkey = $ComputerName
            }

            $ProcessInfo.FileName = "$($env:SystemRoot)\system32\cmdkey.exe"
            $ProcessInfo.Arguments = "/generic:TERMSRV/$ComputerCmdkey /user:$UserName /pass:$Password"
            $ProcessInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
            $Process.StartInfo = $ProcessInfo
            if ($PSCmdlet.ShouldProcess($ComputerCmdkey,'Adding credentials to store'))
            {
                [void]$Process.Start()
            }

            $ProcessInfo.FileName = "$($env:SystemRoot)\system32\mstsc.exe"
            $ProcessInfo.Arguments = "$MstscArguments /v $ComputerName"
            $ProcessInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Normal
            $Process.StartInfo = $ProcessInfo
            if ($PSCmdlet.ShouldProcess($ComputerName,'Connecting mstsc')) 
            {
                [void]$Process.Start()
                if ($Wait)
                {
                    $null = $Process.WaitForExit()
                }
            }

            $ProcessInfo.FileName = "$($env:SystemRoot)\system32\cmdkey.exe"
            $ProcessInfo.Arguments = "/delete TERMSRV/$ComputerName"
    }
    End
    {
    }
}