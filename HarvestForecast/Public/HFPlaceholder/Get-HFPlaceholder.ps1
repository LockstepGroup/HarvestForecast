function Get-HFPlaceholder {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [int]$Id
    )

    BEGIN {
        $VerbosePrefix = "Get-HFPlaceholder:"

        $ReturnObject = @()
    }

    PROCESS {
        $ApiParams = @{}
        $ApiParams.UriPath = 'placeholders'

        $Response = Invoke-HFApiQuery @ApiParams
        $Response = $Response.placeholders

        foreach ($r in $Response) {
            $ThisObject = New-HFPlaceholder
            $ThisObject.FullData = $r

            $ThisObject.Id = $r.id

            $ThisObject.Name = $r.name
            $ThisObject.Archived = $r.archived
            $ThisObject.Roles = $r.roles
            $ThisObject.UpdatedAt = $r.updated_at
            $ThisObject.UpdatedById = $r.updated_by_id

            $ReturnObject += $ThisObject
        }
    }

    END {
        if ($Id) {
            $ReturnObject | Where-Object { $_.Id -eq $Id }
        } else {
            $ReturnObject
        }
    }
}
