function New-HFAssignment {
    [CmdletBinding()]
    Param (
    )

    BEGIN {
        $VerbosePrefix = "New-HFAssignment:"
    }

    PROCESS {
        $ReturnObject = [HFAssignment]::new()
    }

    END {
        $ReturnObject
    }
}
