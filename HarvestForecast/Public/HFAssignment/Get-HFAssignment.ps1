function Get-HFAssignment {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false, Position = 0)]
        [int]$Id,

        [Parameter(Mandatory = $false)]
        [datetime]$StartDate = (Get-Date)
    )

    BEGIN {
        $VerbosePrefix = "Get-HFAssignment:"

        $QueryString = @{}
        $QueryString.state = 'active'
        $QueryString.start_date = (Get-Date -Date $StartDate -Format 'yyyy-MM-dd').ToString()

        $QueryString = $global:HFServer.createQueryString($QueryString)

        $ReturnObject = @()
    }

    PROCESS {
        $ApiParams = @{}
        $ApiParams.UriPath = 'assignments'

        if ($Id) {
            $ApiParams.UriPath += '/' + $Id
        } else {
            $ApiParams.UriPath += $QueryString
        }

        $Response = Invoke-HfApiQuery @ApiParams
        if ($Response.assignment) {
            $Response = $Response.assignment
        } else {
            $Response = $Response.assignments
        }

        foreach ($r in $Response) {
            $Params = @{}
            $Params.AllocationInSeconds = $r.allocation
            $Params.ProjectId = $r.project_id
            $Params.StartDate = $r.start_date
            $Params.EndDate = $r.end_date

            if ($r.person_id) {
                $Params.PersonId = $r.person_id
            } elseif ($r.placeholder_id) {
                $Params.PlaceholderId = $r.placeholder_id
            } else {
                $Params.Everyone = $true
            }

            Write-Verbose "$VerbosePrefix $($r.id): PersonId: $($Params.PersonId), PlaceholderId: $($Params.PlaceholderId)"
            $ThisObject = New-HFAssignment @Params
            $ThisObject.FullData = $r

            $ThisObject.Id = $r.id
            $ThisObject.Notes = $r.notes
            $ThisObject.UpdatedAt = $r.updated_at
            $ThisObject.UpdateById = $r.updated_by_id
            $ThisObject.RepeatedAssignmentSetId = $r.repeated_assignment_set_id
            $ThisObject.ActiveOnDaysOff = $r.active_on_days_off

            $ReturnObject += $ThisObject
        }
    }

    END {
        $ReturnObject
    }
}