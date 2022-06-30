function Get-TrueNASSystemGeneral {
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
            [ValidateScript({Test-TrueNASUriRegex -Uri $_ -Type "BaseUri"})]
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
                $WebRequest = Invoke-TrueNasRestMethod -Uri "$BaseUri/system/general"-Method "Get"
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