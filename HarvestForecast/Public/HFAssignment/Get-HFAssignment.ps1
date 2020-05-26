function Get-HFAssignment {
    [CmdletBinding()]
    Param (
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
        $ApiParams.UriPath = 'assignments' + $QueryString

        $Response = Invoke-HfApiQuery @ApiParams
        $Response = $Response.assignments

        foreach ($r in $Response) {
            $ThisObject = New-HFAssignment
            $ThisObject.FullData = $r

            $ThisObject.Id = $r.id
            $ThisObject.StartDate = $r.start_date
            $ThisObject.EndDate = $r.end_date
            $ThisObject.Allocation = $r.allocation
            $ThisObject.Notes = $r.notes
            $ThisObject.UpdatedAt = $r.updated_at
            $ThisObject.UpdateById = $r.updated_by_id
            $ThisObject.ProjectId = $r.project_id
            $ThisObject.PersonId = $r.person_id
            $ThisObject.PlaceholderId = $r.placeholder_id
            $ThisObject.RepeatedAssignmentSetId = $r.repeated_assignment_set_id
            $ThisObject.ActiveOnDaysOff = $r.active_on_days_off

            $ReturnObject += $ThisObject
        }
    }

    END {
        $ReturnObject
    }
}