function Get-HFProject {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$Name,

        [Parameter(Mandatory = $false)]
        [int]$Id
    )

    BEGIN {
        $VerbosePrefix = "Get-HFProject:"

        $ReturnObject = @()
    }

    PROCESS {
        $ApiParams = @{}
        $ApiParams.UriPath = 'projects'

        $Response = Invoke-HFApiQuery @ApiParams
        $Response = $Response.projects

        foreach ($r in $Response) {
            $ThisObject = New-HFProject
            $ThisObject.FullData = $r

            $ThisObject.Id = $r.id
            $ThisObject.Name = $r.name
            $ThisObject.Color = $r.color
            $ThisObject.Code = $r.code
            $ThisObject.Notes = $r.notes
            $ThisObject.ClientId = $r.client_id
            $ThisObject.Tag = $r.tags
            $ThisObject.HarvestId = $r.harvest_id
            $ThisObject.Archived = $r.archived
            $ThisObject.UpdatedAt = $r.updated_at
            $ThisObject.UpdatedById = $r.updated_by_id

            if ($null -ne $r.start_date) {
                $ThisObject.StartDate = $r.start_date
            }
            if ($null -ne $r.end_date) {
                $ThisObject.EndDate = $r.end_date
            }

            $ReturnObject += $ThisObject
        }
    }

    END {
        if ($Name) {
            $ReturnObject | Where-Object { $_.Name -eq $Name }
        } elseif ($Id) {
            $ReturnObject | Where-Object { $_.Id -eq $Id }
        } else {
            $ReturnObject
        }
    }
}
