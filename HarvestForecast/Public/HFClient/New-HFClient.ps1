function New-HFClient {
    [CmdletBinding()]
    Param (
    )

    BEGIN {
        $VerbosePrefix = "New-HFClient:"
    }

    PROCESS {
        $ReturnObject = [HFClient]::new()
    }

    END {
    }
}
