Class HFColor {
    [string]$Name
    [string]$Label

    #region Initiators
    ########################################################################

    # empty initiator
    HFColor() {
    }

    ########################################################################
    #endregion Initiators
}


Class HFAccount {
    [int]$Id
    [string]$Name
    [int]$WeeklyCapacity
    [HFColor[]]$Color
    [string]$HarvestSubdomain
    [string]$HarvestLink
    [string]$HarvestName
    [bool]$WeekendsEnabled
    [datetime]$CreatedAt

    $FullData

    #region Initiators
    ########################################################################

    # empty initiator
    HFAccount() {
    }

    ########################################################################
    #endregion Initiators
}
