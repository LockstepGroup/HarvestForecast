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
        $UriPath = 'clients'

        if ($HFClient.Id -gt 0) {
            $Method = 'PUT'
            $UriPath += '/' + $HFClient.Id
        } else {
            $Method = 'POST'
        }

        $SetObject = Invoke-HFApiQuery -UriPath $UriPath -Body $HFClient.ToJson() -Method $Method
        $ReturnObject += Get-HFClient -Id $SetObject.client.id
    }

    END {
        $ReturnObject
    }
}
