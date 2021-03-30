function Get-HFAccount {
    [CmdletBinding()]
    Param (
    )

    BEGIN {
        $VerbosePrefix = "Get-HFAccount:"
        $ReturnObject = @()
    }

    PROCESS {
        $ApiParams = @{}
        $ApiParams.UriPath = 'accounts/' + $global:HFServer.AccountId

        $Response = Invoke-HfApiQuery @ApiParams
        $Response = $Response.account

        foreach ($r in $Response) {
            $ThisObject = New-HFAccount
            $ThisObject.FullData = $r

            $ThisObject.Id = $r.id
            $ThisObject.Name = $r.name
            $ThisObject.WeeklyCapacity = $r.weekly_capacity
            $ThisObject.HarvestSubdomain = $r.harvest_subdomain
            $ThisObject.HarvestLink = $r.harvest_link
            $ThisObject.HarvestName = $r.harvest_name
            $ThisObject.WeekendsEnabled = $r.weekends_enabled
            $ThisObject.CreatedAt = $r.created_at

            foreach ($color in $r.color_labels) {
                $NewColor = [HFColor]::new()
                $NewColor.Name = $color.name
                $NewColor.Label = $color.label
                $ThisObject.Color += $NewColor
            }

            $ReturnObject += $ThisObject
        }
    }

    END {
        $ReturnObject
    }
}
