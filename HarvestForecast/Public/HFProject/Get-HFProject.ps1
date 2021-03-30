function Get-HFProject {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$Name,

        [Parameter(Mandatory = $false)]
        [int]$Id,

        [Parameter(Mandatory = $false)]
        [datetime]$StartDate = (Get-Date)
    )

    BEGIN {
        $VerbosePrefix = "Get-HFProject:"

        $ThisDate = Get-Date -Date $StartDate -Format 'yyyy-MM-dd'
        $UriPath = 'aggregate/future_scheduled_hours/' + $ThisDate
        $FutureScheduledHours = Invoke-HFApiQuery -UriPath $UriPath

        $Clients = Get-HFClient

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
            $ThisObject.ClientName = ($Clients | Where-Object { $_.id -eq $r.client_id } ).Name
            $ThisObject.Tag = $r.tags
            $ThisObject.HarvestId = $r.harvest_id
            $ThisObject.Archived = $r.archived
            $ThisObject.UpdatedAt = $r.updated_at
            $ThisObject.UpdatedById = $r.updated_by_id

            $ThisObject.FutureScheduledHours = ($FutureScheduledHours.future_scheduled_hours | Where-Object { $_.project_id -eq $r.id -and $_.person_id } | Measure-Object allocation -Sum).Sum
            $ThisObject.FutureScheduledPlaceholderHours = ($FutureScheduledHours.future_scheduled_hours | Where-Object { $_.project_id -eq $r.id -and $_.placeholder_id } | Measure-Object allocation -Sum).Sum
            $ThisObject.FutureScheduledHoursTotal = $ThisObject.FutureScheduledHours + $ThisObject.FutureScheduledPlaceholderHours

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
