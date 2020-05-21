function Set-HFClient {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [HFClient]$HFClient
    )

    BEGIN {
        $VerbosePrefix = "Set-HFClient:"

        $ReturnObject = @()
    }

    PROCESS {
        $ReturnObject += Invoke-HFApiQuery -UriPath 'clients' -Body $HFClient.ToJson() -Method 'POST'
    }

    END {
        $ReturnObject
    }
}
