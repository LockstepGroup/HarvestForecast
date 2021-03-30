function New-HFAccount {
    [CmdletBinding()]
    Param (
    )

    BEGIN {
        $VerbosePrefix = "New-HFAccount:"
    }

    PROCESS {
        $ReturnObject = [HFAccount]::new()
    }

    END {
        $ReturnObject
    }
}
