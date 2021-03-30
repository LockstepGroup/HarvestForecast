function Remove-HFAssignment {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [HFAssignment]$HFAssignment
    )

    BEGIN {
        $VerbosePrefix = "Remove-HFAssignment:"
        $ReturnObject = @()
    }

    PROCESS {
        $UriPath = 'assignments' + '/' + $HFAssignment.Id
        $Method = 'DELETE'

        $DeleteObject = Invoke-HFApiQuery -UriPath $UriPath -Method $Method
        $ReturnObject += $DeleteObject
    }

    END {
        $ReturnObject
    }
}