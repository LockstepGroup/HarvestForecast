function New-HFPerson {
    [CmdletBinding()]
    Param (
    )

    BEGIN {
        $VerbosePrefix = "New-HFPerson:"
    }

    PROCESS {
        $ReturnObject = [HFPerson]::new()
    }

    END {
        $ReturnObject
    }
}
