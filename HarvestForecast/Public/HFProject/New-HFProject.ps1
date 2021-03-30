function New-HFProject {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$Name,

        [Parameter(Mandatory = $false)]
        [string]$ClientId,

        [Parameter(Mandatory = $false)]
        [string]$Code,

        [Parameter(Mandatory = $false)]
        [string]$Color,

        [Parameter(Mandatory = $false)]
        [string]$Notes,

        [Parameter(Mandatory = $false)]
        [string[]]$Tag
    )

    BEGIN {
        $VerbosePrefix = "New-HFProject:"
    }

    PROCESS {
        $ReturnObject = [HFProject]::new()

        if ($Name) {
            $ReturnObject.Name = $Name
        }

        if ($ClientId) {
            $ReturnObject.ClientId = $ClientId
        }

        if ($Code) {
            $ReturnObject.Code = $Code
        }

        if ($Color) {
            $ReturnObject.Color = $Color
        }

        if ($Notes) {
            $ReturnObject.Notes = $Notes
        }

        if ($Tag) {
            $ReturnObject.Tag = $Tag
        }
    }

    END {
        $ReturnObject
    }
}
