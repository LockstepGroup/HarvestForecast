function Get-HFPerson {
    [CmdletBinding()]
    Param (
    )

    BEGIN {
        $VerbosePrefix = "Get-HFPerson:"

        $ReturnObject = @()
    }

    PROCESS {
        $ApiParams = @{}
        $ApiParams.UriPath = 'people'

        $Response = Invoke-HFApiQuery @ApiParams
        $Response = $Response.people

        foreach ($r in $Response) {
            $ThisObject = New-HFPerson
            $ThisObject.FullData = $r

            $ThisObject.Id = $r.id
            $ThisObject.FirstName = $r.first_name
            $ThisObject.LastName = $r.last_name
            $ThisObject.Email = $r.email
            $ThisObject.Login = $r.login
            $ThisObject.Admin = $r.admin
            $ThisObject.Archived = $r.archived
            $ThisObject.Subscribed = $r.subscribed
            $ThisObject.AvatarUrl = $r.avatar_url
            $ThisObject.Roles = $r.roles
            $ThisObject.UpdatedAt = $r.updated_at
            $ThisObject.UpdatedById = $r.updated_by_id
            $ThisObject.HarvestUserId = $r.harvest_user_id
            $ThisObject.WeeklyCapacity = $r.weekly_capacity
            $ThisObject.ColorBlind = $r.color_blind
            $ThisObject.PersonalFeedTokenId = $r.personal_feed_token_id

            # WorkingDays
            $DaysOfTheWeek = @(
                'monday'
                'tuesday'
                'wednesday'
                'thursday'
                'friday'
                'saturday'
                'sunday'
            )

            foreach ($day in $DaysOfTheWeek) {
                if ($r.working_days.$day) {
                    $ThisObject.WorkingDays += $day
                }
            }

            $ReturnObject += $ThisObject
        }
    }

    END {
        $ReturnObject
    }
}
