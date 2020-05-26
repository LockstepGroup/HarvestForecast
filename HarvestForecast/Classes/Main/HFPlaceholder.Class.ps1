Class HFPlaceholder {
    [int]$Id

    [string]$Name
    [bool]$Archived
    [string[]]$Roles
    [datetime]$UpdatedAt
    [int]$UpdatedById

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
    HFPlaceholder() {
    }

    ########################################################################
    #endregion Initiators
}
