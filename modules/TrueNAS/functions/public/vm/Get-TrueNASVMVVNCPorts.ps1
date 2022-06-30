function Get-TrueNASVMVVNCPorts {
    <#
        .SYNOPSIS
    
        .DESCRIPTION
    
        .EXAMPLE
    
        .EXAMPLE
    
        .EXAMPLE
    
        .EXAMPLE
    #>
        [CmdletBinding()]
        [Alias()]
        [OutputType([System.Collections.Hashtable])]
        Param
        (
            [Parameter(
                Mandatory = $false,
                Position = 1)]
            [ValidateNotNullOrEmpty()]
            [ValidateScript({
                If ($_ -match "(^https?:\/\/([a-zA-Z0-9-]{1,15})\.([a-zA-Z0-9-]{1,15})\.([a-zA-Z0-9-]{1,10})\:(\d{1,5})\/api\/v(\d{1}\.\d{1}))$") {
                    $true
                } else {
                    Write-Error -Message "$_ is not a valid BaseUri or does not match the requirements of pattern `"(^https?:\/\/([a-zA-Z0-9-]{1,15})\.([a-zA-Z0-9-]{1,15})\.([a-zA-Z0-9-]{1,10})\:(\d{1,5})\/api\/v(\d{1}\.\d{1}))$`"" -ErrorAction Stop
                }})]
            [STRING] $BaseUri = $script:defaultTrueNASServer.baseuri,

            [Parameter(
                Mandatory = $false)]
            [ValidateSet("Detailed", "Quiet")]
            [STRING] $InformationLevel = "Detailed"
        )
    
        Begin
        {
        }
        Process
        {
            try {
                # Invoke web request call to TrueNAS version endpoint
                $WebRequest = Invoke-TrueNasRestMethod -Uri "$BaseUri/vm/vnc_port_wizard" -Method "Get"
            }
            catch {
                Write-Error $_ -ErrorAction Stop
            }
        }
        End
        {
            switch ($InformationLevel) {
                "Detailed" {
                    return $WebRequest
                }
                "Quiet" {
                    $WebRequest.StatusCode
                }
            }
        }
    }