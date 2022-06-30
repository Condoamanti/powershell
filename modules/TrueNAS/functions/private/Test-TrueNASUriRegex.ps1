function Test-TrueNASUriRegex
{
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
        [STRING] $Uri,

        [Parameter(Mandatory = $true)]
        [ValidateSet("ServerName", "AccessToken", "BaseUri", "FullAPIUri")]
        [STRING] $Type
    )
    Begin
    {
    }
    Process
    {
        switch ($Type) {
            "ServerName" {
                $Regex = "(^[a-zA-Z0-9-]{1,15})\.([a-zA-Z0-9-]{1,15})\.([a-zA-Z0-9-]{1,10})$"
                if ($Uri -notmatch $Regex) {
                    throw "$_ is not a valid fully qualified domain name or does not match the requirements of pattern '$Regex'"
                }
            }
            "AccessToken" {
                $Regex = "(^\d\-[a-zA-Z0-9]{1,64})$"
                if ($Uri -notmatch $Regex) {
                    throw "$_ is not a valid access token length or does not match the requirements of pattern '$Regex'"
                }
            }
            "BaseUri" {
                $Regex = "(^https?:\/\/([a-zA-Z0-9-]{1,15})\.([a-zA-Z0-9-]{1,15})\.([a-zA-Z0-9-]{1,10})\:(\d{1,5})\/api\/v(\d{1}\.\d{1}))$"
                if ($Uri -notmatch $Regex) {
                    throw "$_ is not a valid BaseUri or does not match the requirements of pattern '$Regex'"
                }
            }
            "FullAPIUri" {
                $Regex = "(^https?:\/\/([a-zA-Z0-9-]{1,15})\.([a-zA-Z0-9-]{1,15})\.([a-zA-Z0-9-]{1,10})\:(\d{1,5})\/api\/v(\d{1}\.\d{1})(\/[a-zA-Z0-9-_]{1,20}){1,6}\/?)$"
                if ($Uri -notmatch $Regex) {
                    throw "$_ is not a valid Uri or does not match the requirements of pattern '$Regex'"
                }
            }
        }

        return $Regex
    }
    End
    {
    }
}