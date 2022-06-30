function Get-TrueNASVirtualMachine {
<#
    .SYNOPSIS

    .DESCRIPTION

    .EXAMPLE

    .EXAMPLE

    .EXAMPLE

    .EXAMPLE
#>
    [CmdletBinding(DefaultParameterSetName = 'DefaultParameterSet')]
    [Alias()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Name",
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [STRING] $Name,

        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Id",
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [INT64] $Id,

        [Parameter(
            Mandatory = $false,
            ParameterSetName = "DefaultParameterSet",
            Position = 1)]
        [Parameter(ParameterSetName = "Name")]
        [Parameter(ParameterSetName = "Id")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Test-TrueNASUriRegex -Uri $_ -Type "BaseUri"})]
        [STRING] $BaseUri = $script:defaultTrueNASServer.baseuri,

        [Parameter(
            Mandatory = $false,
            ParameterSetName = "DefaultParameterSet",
            Position = 2)]
        [Parameter(ParameterSetName = "Name")]
        [Parameter(ParameterSetName = "Id")]
        [ValidateSet("Detailed", "Quiet")]
        [STRING] $InformationLevel = "Detailed"
    )

    Begin
    {
    }
    Process
    {
        try {
            # Invoke web request call to TrueNAS vm endpoint
            $WebRequest = Invoke-TrueNasRestMethod -Uri "$BaseUri/vm" -Method "Get"

            if ($Id -lt 1 -and $Name.Length -lt 1) {
                $WebRequestResponse = $WebRequest
            } elseif ($Name.Length -gt 1) {
                $WebRequestResponse = $WebRequest | Where-Object {$_.name -like "$Name"}
            } elseif ($Id -gt 1) {
                $WebRequestResponse = $WebRequest | Where-Object {$_.id -eq $Id}
            }

            switch ($InformationLevel) {
                "Detailed" {
                    return $WebRequestResponse
                }
                "Quiet" {
                    $WebRequest.StatusCode
                }
            }

        } catch {
            Write-Error $_ -ErrorAction Stop
        }
    }
    End
    {
    }
}