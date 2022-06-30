function Connect-TrueNASServer {
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
                Mandatory = $true,
                Position = 0)]
            [ValidateNotNullOrEmpty()]
            [ValidateScript({Test-TrueNASUriRegex -Uri $_ -Type "ServerName"})]
            [STRING] $ServerName,
    
            [Parameter(
                Mandatory = $true,
                ParametersetName = 'AccessToken',
                Position = 1)]
            [ValidateNotNullOrEmpty()]
            [ValidateScript({Test-TrueNASUriRegex -Uri $_ -Type "AccessToken"})]
            [STRING] $AccessToken,
    
            [Parameter(
                Mandatory = $true,
                ParametersetName = 'DefaultParameterSet',
                Position = 1)]
            [PSCREDENTIAL] $Credential,
    
            [Parameter(
                Mandatory = $false)]
            [ValidateSet("latest", "2.0")]
            [STRING] $ApiVersion = "latest",
    
            [Parameter(
                Mandatory = $false)]
            [ValidateSet("http", "https")]
            [STRING] $Schema = "https",
    
            [Parameter(
                Mandatory = $false)]
            [ValidateRange(1,65535)]
            [INT32] $Port = 443,
    
            [Parameter(
                Mandatory = $false)]
            [ValidateSet("Detailed", "Quiet")]
            [STRING] $InformationLevel = "Detailed"
        )
    
        Begin
        {
            # Validate if the variable $script:defaultTrueNASServers contains a connection already established based on server name.
            If ($script:defaultTrueNASServers.servername -contains $ServerName)
            {
                Write-Verbose "Removing existing connection for TrueNAS server [$ServerName]."
                $script:defaultTrueNASServers = $script:defaultTrueNASServers | Where-Object {$_.servername -ne $ServerName}
            }
    
            # Determine API version selected
            switch ($ApiVersion) {
                "2" {
                    $ApiVersion = "2.0"
                }
                default {
                    $ApiVersion = "2.0"
                }
            }
    
            # Create base URI for API access
            $BaseUri = "$($Schema)://$($ServerName):$($Port)/api/v$($ApiVersion)"
    
            # Create initial connection validation headers
            $Headers = @{}
    
            # If $Credential specified than use Basic authentication, otherwise use Bearer authentication
            If ($Credential) {
                # Base64 encode username and password
                $Base64Authorization = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($Credential.UserName):$($Credential.GetNetworkCredential().Password)"))
                $Headers.Add("Authorization", "Basic $Base64Authorization")
            } else {
                $Headers.Add("Authorization", "Bearer $AccessToken")
            }
        }
        Process
        {
            try {
                # Invoke web request call to TrueNAS system info endpoint
                $WebRequest = Invoke-WebRequest -Uri "$BaseUri/system/info" -Headers $Headers -Method "Get" -ContentType "application/json" -SessionVariable TrueNASWebSession
                $WebRequestContent = $WebRequest.Content | ConvertFrom-Json
                $script:defaultTrueNASServer = $WebRequestContent
                
                # Add properties to defaultTrueNASServer variable
                $script:defaultTrueNASServer | Add-Member -MemberType NoteProperty -Name "servername" -Value $ServerName
                $script:defaultTrueNASServer | Add-Member -MemberType NoteProperty -Name "baseuri" -Value $BaseUri
                $script:defaultTrueNASServer | Add-Member -MemberType NoteProperty -Name "session" -Value $TrueNASWebSession

                # Add TrueNASServer to default servers list if it does not exist already
                if ($script:defaultTrueNASServers -notcontains $script:defaultTrueNASServer) {
                    $script:defaultTrueNASServers += $script:defaultTrueNASServer
                }
            }
            catch {
                Write-Error $_ -ErrorAction Stop
            }
        }
        End
        {
            switch ($InformationLevel) {
                "Detailed" {
                    return $script:defaultTrueNASServer
                }
                "Quiet" {
                    $WebRequest.StatusCode
                }
            }
        }
    }
    