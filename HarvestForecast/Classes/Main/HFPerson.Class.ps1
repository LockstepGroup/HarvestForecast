Class HFPerson {
    [int]$Id
    [string]$FirstName
    [string]$LastName
    [string]$Email
    [bool]$Login
    [bool]$Admin
    [bool]$Archived
    [bool]$Subscribed
    [string]$AvatarUrl
    [string[]]$Roles
    [datetime]$UpdatedAt
    [int]$UpdatedById
    [int]$HarvestUserId
    [int]$WeeklyCapacity
    [string[]]$WorkingDays
    [bool]$ColorBlind
    [int]$PersonalFeedTokenId

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
    HFPerson() {
    }

    ########################################################################
    #endregion Initiators
}
