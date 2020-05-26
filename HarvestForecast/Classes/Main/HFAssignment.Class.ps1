Class HFAssignment {
    [int]$Id
    [datetime]$StartDate
    [datetime]$EndDate
    [int]$Allocation
    [string]$Notes
    [datetime]$UpdatedAt
    [int]$UpdateById
    [int]$ProjectId
    [int]$PersonId
    [int]$PlaceholderId
    [int]$RepeatedAssignmentSetId
    [bool]$ActiveOnDaysOff

    $FullData

    # {"assignment":{"start_date":"2020-06-01","end_date":"2020-06-02","allocation":28800,"active_on_days_off":false,"repeated_assignment_set_id":null,"project_id":"358131","person_id":"87972","placeholder_id":null}}

    # ToJson()
    [string] ToJson() {
        $Output = @{
            assignment = @{
                start_date = (Get-Date -Date $this.StartDate -Format 'yyyy-MM-dd').ToString()
                end_date   = (Get-Date -Date $this.EndDate -Format 'yyyy-MM-dd').ToString()
                allocation = $This.Allocation
                project_id = $this.ProjectId
            }
        }

        if ($this.PersonId) {
            $Output.assignment.person_id = $this.PersonId
        }

        if ($this.PlaceholderId) {
            $Output.assignment.placeholder_id = $this.PlaceholderId
        }

        $Output = $Output | ConvertTo-Json -Compress
        return $Output
    }

    #region Initiators
    ########################################################################

    # empty initiator
    HFAssignment() {
    }

    ########################################################################
    #endregion Initiators
}
