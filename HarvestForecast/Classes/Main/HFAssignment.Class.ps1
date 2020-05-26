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

<#     # ToJson()
    [string] ToJson() {
        $Output = @{
            client = @{
                name       = $this.Name
                archived   = $this.Archived
                harvest_id = $This.HarvestId
            }
        }

        if ($Output.client.harvest_id -eq 0) {
            $Output.client.harvest_id = $null
        }

        $Output = $Output | ConvertTo-Json -Compress
        return $Output
    } #>

    #region Initiators
    ########################################################################

    # empty initiator
    HFAssignment() {
    }

    ########################################################################
    #endregion Initiators
}
