function New-HFAssignment {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [datetime]$StartDate = (Get-Date),

        [Parameter(Mandatory = $false)]
        [datetime]$EndDate = (Get-Date),

        [Parameter(Mandatory = $true, ParameterSetName = "PersonIdHours")]
        [Parameter(Mandatory = $true, ParameterSetName = "PlaceholderHours")]
        [Parameter(Mandatory = $true, ParameterSetName = "EveryoneHours")]
        [decimal]$AllocationInHours,

        [Parameter(Mandatory = $true, ParameterSetName = "PersonIdSeconds")]
        [Parameter(Mandatory = $true, ParameterSetName = "PlaceholderIdSeconds")]
        [Parameter(Mandatory = $true, ParameterSetName = "EveryoneSeconds")]
        [decimal]$AllocationInSeconds,

        [Parameter(Mandatory = $true)]
        [int]$ProjectId,

        [Parameter(Mandatory = $true, ParameterSetName = "PersonIdHours")]
        [Parameter(Mandatory = $true, ParameterSetName = "PersonIdSeconds")]
        [int]$PersonId,

        [Parameter(Mandatory = $true, ParameterSetName = "PlaceholderHours")]
        [Parameter(Mandatory = $true, ParameterSetName = "PlaceholderIdSeconds")]
        [int]$PlaceholderId,

        [Parameter(Mandatory = $true, ParameterSetName = "EveryoneSeconds")]
        [Parameter(Mandatory = $true, ParameterSetName = "EveryoneHours")]
        [switch]$Everyone
    )

    BEGIN {
        $VerbosePrefix = "New-HFAssignment:"
    }

    PROCESS {
        $ReturnObject = [HFAssignment]::new()

        $ReturnObject.StartDate = $StartDate
        $ReturnObject.EndDate = $EndDate
        $ReturnObject.ProjectId = $ProjectId

        if ($AllocationInHours) {
            $ReturnObject.Allocation = $AllocationInHours * 3600
        }

        if ($AllocationInSeconds) {
            $ReturnObject.Allocation = $AllocationInSeconds
        }

        if ($PersonId) {
            $ReturnObject.PersonId = $PersonId
        }

        if ($PlaceholderId) {
            $ReturnObject.PlaceholderId = $PlaceholderId
        }
    }

    END {
        $ReturnObject
    }
}