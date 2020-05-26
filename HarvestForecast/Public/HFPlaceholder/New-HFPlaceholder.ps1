function New-HFPlaceholder {
    [CmdletBinding()]
    Param (
    )

    BEGIN {
        $VerbosePrefix = "New-HFPlaceholder:"
    }

    PROCESS {
        $ReturnObject = [HFPlaceholder]::new()
    }

    END {
        $ReturnObject
    }
}
