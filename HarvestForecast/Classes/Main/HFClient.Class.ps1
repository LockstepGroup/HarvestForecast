Class HFClient {
    [int]$Id
    [string]$Name
    [int]$HarvestId
    [bool]$Archived
    [datetime]$UpdatedAt
    [int]$UpdatedById

    $FullData

    # ToJson()
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
    }

    #region Initiators
    ########################################################################

    # empty initiator
    HFClient() {
    }

    ########################################################################
    #endregion Initiators
}

