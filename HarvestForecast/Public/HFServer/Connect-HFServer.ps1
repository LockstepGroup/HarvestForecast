function Connect-HFServer {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$ApiToken = $global:HFApiToken,

        [Parameter(Mandatory = $false)]
        [string]$AccountId = $global:HFAccountId,

        [Parameter(Mandatory = $false)]
        [switch]$Quiet
    )

    BEGIN {
        $VerbosePrefix = "Connect-HFServer:"
    }

    PROCESS {
        $Params = @{}

        if ($ApiToken) {
            $Params.ApiToken = $ApiToken
        }

        if ($AccountId) {
            $Params.AccountId = $AccountId
        }

        $ReturnObject = New-HFServer @Params
        $Global:HFServer = $ReturnObject

        # test connection with whoami call
        $Response = Invoke-HFApiQuery -UriPath 'whoami'
    }

    END {
        if (-not $Quiet) {
            $Global:HFServer
        }
    }
}