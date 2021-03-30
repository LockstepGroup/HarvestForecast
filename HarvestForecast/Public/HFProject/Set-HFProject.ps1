function Set-HFProject {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [HFProject]$HFProject
    )

    BEGIN {
        $VerbosePrefix = "Set-HFProject:"

        $ReturnObject = @()
    }

    PROCESS {
        $UriPath = 'projects'

        if ($HFProject.Id -gt 0) {
            $Method = 'PUT'
            $UriPath += '/' + $HFProject.Id
        } else {
            $Method = 'POST'
        }

        $SetObject = Invoke-HFApiQuery -UriPath $UriPath -Body $HFProject.ToJson() -Method $Method
        $ReturnObject += Get-HFProject -Id $SetObject.project.id
    }

    END {
        $ReturnObject
    }
}
