Class HFProject {
    [int]$Id
    [string]$Name
    [string]$Color
    [string]$Code
    [string]$Notes
    [datetime]$StartDate
    [datetime]$EndDate
    [int]$HarvestId
    [bool]$Archived
    [datetime]$UpdatedAt
    [int]$UpdatedById
    [int]$ClientId
    [string]$ClientName
    [string[]]$Tag

    [int]$FutureScheduledHours
    [int]$FutureScheduledPlaceholderHours
    [int]$FutureScheduledHoursTotal

    $FullData

    # ToJson()
    [string] ToJson() {
        $Output = @{
            project = @{
                name       = $this.Name
                color      = $this.Color
                code       = $this.Code
                notes      = $this.Notes
                start_date = $this.StartDate
                end_date   = $this.EndDate
                tags       = $this.Tag
                archived   = $this.Archived
                harvest_id = $This.HarvestId
                client_id  = $this.ClientId
            }
        }

        if ($Output.project.harvest_id -eq 0) {
            $Output.project.harvest_id = $null
        }

        if ($Output.project.start_date -eq (Get-Date 1/1/0001)) {
            $Output.project.start_date = $null
        }

        if ($Output.project.end_date -eq (Get-Date 1/1/0001)) {
            $Output.project.end_date = $null
        }

        $Output = $Output | ConvertTo-Json -Compress
        return $Output
    }

    #region Initiators
    ########################################################################

    # empty initiator
    HFProject() {
    }

    ########################################################################
    #endregion Initiators
}
