function Get-HFClient {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$Name,

        [Parameter(Mandatory = $false)]
        [int]$Id
    )

    BEGIN {
        $VerbosePrefix = "Get-HFClient:"

        $ReturnObject = @()
    }

    PROCESS {
        $ApiParams = @{}
        $ApiParams.UriPath = 'clients'

        $Response = Invoke-HfApiQuery @ApiParams
        $Response = $Response.clients

        foreach ($r in $Response) {
            $ThisObject = New-HFClient
            $ThisObject.FullData = $r

            $ThisObject.Id = $r.id
            $ThisObject.Name = $r.name
            $ThisObject.HarvestId = $r.harvest_id
            $ThisObject.Archived = $r.archived
            $ThisObject.UpdatedAt = $r.updated_at
            $ThisObject.UpdatedById = $r.updated_by_id

            $ReturnObject += $ThisObject
        }
    }

    END {
        if ($Name) {
            $ReturnObject | Where-Object { $_.Name -eq $Name }
        } elseif ($Id) {
            $ReturnObject | Where-Object { $_.Id -eq $Id }
        } else {
            $ReturnObject
        }
    }
}
