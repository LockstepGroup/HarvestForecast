function Invoke-HFApiQuery {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $False)]
        [string]$UriPath,

        [Parameter(Mandatory = $false)]
        [string]$Body = '',

        [Parameter(Mandatory = $false)]
        [string]$Method = 'GET'
    )

    BEGIN {
        $VerbosePrefix = "Invoke-HFApiQuery:"
    }

    PROCESS {
        if (-not $Global:HFServer) {
            Throw "$VerbosePrefix no active connection to ConnectWise Manage, please use Connect-CwmServer to get started."
        } else {
            $Global:HFServer.UriPath = $UriPath
            $ReturnObject = $Global:HFServer.invokeApiQuery($Body, $Method)
        }
    }

    END {
        $ReturnObject
    }
}