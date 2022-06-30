function Invoke-TrueNasRestMethod {
<#
    .SYNOPSIS

    .DESCRIPTION

    .EXAMPLE
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType()]
    Param(
        [Parameter(
            Mandatory = $true,
            Position = 1)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Test-TrueNASUriRegex -Uri $_ -Type "FullAPIUri"})]
        [STRING] $Uri,

        [Parameter(Mandatory = $false)]
        [ValidateSet("Get", "Put", "Post", "Delete")]
        [STRING] $Method = "Get",

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        $WebSession = $script:defaultTrueNASServer.session,

        [Parameter(Mandatory = $false)]
        [PSOBJECT] $Body
    )
    Begin
    {
    }
    Process
    {
        if ($null -eq $script:defaultTrueNASServer) {
            Throw "Not Connected. Connect to the TrueNas with Connect-TrueNasServer"
        }

        try {
            if ($Body) {
                $WebRequest = Invoke-RestMethod $Uri -Method $Method -Body ($Body | ConvertTo-Json -Compress -Depth 5) -WebSession $WebSession
            } else {
                $WebRequest = Invoke-RestMethod $Uri -Method $Method -WebSession $WebSession
            }
        }
        catch {
            Write-Error $_ -ErrorAction Stop
        }
        return $WebRequest
    }
}