function Get-HFAssignment {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false, Position = 0)]
        [int]$Id,

        [Parameter(Mandatory = $false)]
        [datetime]$StartDate = (Get-Date),

        [Parameter(Mandatory = $false)]
        [datetime]$EndDate = ((Get-Date).AddDays(180))
    )
    #TODO allow user to specify more than 180 days and do multiple pulls

    BEGIN {
        $VerbosePrefix = "Get-HFAssignment:"

        $TimeSpan = New-TimeSpan -Start $StartDate -End $EndDate
        $TotalDays = $TimeSpan.Days + 1
        $Global:testdays = $TotalDays

        $QueryString = @{}
        $QueryString.state = 'active'
        $QueryString.start_date = (Get-Date -Date $StartDate -Format 'yyyy-MM-dd').ToString()
        $QueryString.end_date = (Get-Date -Date $EndDate -Format 'yyyy-MM-dd').ToString()

        $QueryString = $global:HFServer.createQueryString($QueryString)

        $ReturnObject = @()
    }

    PROCESS {
        if ($TotalDays -gt 180) {
            $DaysLeft = $TotalDays
            $ThisStartDate = $StartDate
            $ThisEndDate = $StartDate.AddDays(179)

            do {
                Write-Verbose "$VerbosePrefix DaysLeft: $DaysLeft, $ThisStartDate - $ThisEndDate"
                $ReturnObject += Get-HFAssignment -StartDate $ThisStartDate -EndDate $ThisEndDate -Verbose:$false

                $DaysLeft -= 179
                $ThisStartDate = $ThisEndDate.AddDays(1)

                if ($DaysLeft -lt 180) {
                    $ThisEndDate = $EndDate
                } else {
                    $ThisEndDate = $ThisStartDate.AddDays(179)
                }


            } while ( $DaysLeft -gt 0 )




        } else {
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
    }

    END {
        if ( -not $Id) {
            $global:HFServer.HFAssignment = $ReturnObject
        }
        $ReturnObject
    }
}