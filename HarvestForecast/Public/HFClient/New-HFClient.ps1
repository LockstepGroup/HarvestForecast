function New-HFClient {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$Name
    )

    BEGIN {
        $VerbosePrefix = "New-HFClient:"
    }

    PROCESS {
        $ReturnObject = [HFClient]::new()
        if ($Name) {
            $ReturnObject.Name = $Name
        }
    }

    END {
        $ReturnObject
    }
}
