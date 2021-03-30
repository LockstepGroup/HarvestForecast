function New-HFServer {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$ApiToken = $global:HFApiToken,

        [Parameter(Mandatory = $false)]
        [string]$AccountId = $global:HFAccountId
    )

    BEGIN {
        $VerbosePrefix = "New-HFServer:"
    }

    PROCESS {
        $ReturnObject = [HFServer]::new()


        if ($ApiToken) {
            $ReturnObject.ApiToken = $ApiToken
        }

        if ($AccountId) {
            $ReturnObject.AccountId = $AccountId
        }
    }

    END {
        $ReturnObject
    }
}
