function Remove-HFProject {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [HFProject]$HFProject
    )

    BEGIN {
        $VerbosePrefix = "Remove-HFProject:"

        $ReturnObject = @()
    }

    PROCESS {
        $UriPath = 'projects' + '/' + $HFProject.Id
        $Method = 'DELETE'

        $DeleteObject = Invoke-HFApiQuery -UriPath $UriPath -Body $HFProject.ToJson() -Method $Method
        $ReturnObject += Get-HFProject -Id $SetObject.project.id
    }

    END {
        $ReturnObject
    }
}