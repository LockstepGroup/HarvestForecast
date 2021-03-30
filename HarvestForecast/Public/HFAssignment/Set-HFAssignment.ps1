function Set-HFAssignment {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [HFAssignment]$HFAssignment
    )

    BEGIN {
        $VerbosePrefix = "Set-HFAssignment:"

        $ReturnObject = @()
    }

    PROCESS {
        $UriPath = 'assignments'

        if ($HFAssignment.Id -gt 0) {
            $Method = 'PUT'
            $UriPath += '/' + $HFAssignment.Id
        } else {
            $Method = 'POST'
        }

        $SetObject = Invoke-HFApiQuery -UriPath $UriPath -Body $HFAssignment.ToJson() -Method $Method
        $ReturnObject += Get-HFAssignment -Id $SetObject.assignment.id
    }

    END {
        $ReturnObject
    }
}
