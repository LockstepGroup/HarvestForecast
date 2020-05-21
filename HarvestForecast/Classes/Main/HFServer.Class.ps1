Class HFServer {
    [string]$BaseFqdn = 'api.forecastapp.com'
    [string]$UriPath
    [string]$ApiToken
    [string]$AccountId

    #region Tracking
    ########################################################################

    hidden [bool]$Connected
    [array]$UrlHistory
    [array]$RawQueryResultHistory
    [array]$ConditionHistory
    $LastError
    $LastResult

    # Generate Api URL
    [String] getApiUrl() {
        if ($this.BaseFqdn) {
            $url = "https://" + $this.BaseFqdn + '/' + $this.UriPath
            return $url
        } else {
            return $null
        }
    }



    #region processQueryResult
    ########################################################################

    [psobject] processQueryResult ($unprocessedResult) {
        return $unprocessedResult
    }

    ########################################################################
    #endregion processQueryResult

    #region invokeApiQuery
    ########################################################################

    [psobject] invokeApiQuery([hashtable]$body, [string]$method) {

        # Wrike uses the query string as a body attribute, keeping this function as is for now and just using an empty querystring
        $uri = $this.getApiUrl()

        # Populate Query/Url History
        $this.UrlHistory += $uri

        # try query
        try {
            $QueryParams = @{}
            $QueryParams.Uri = $uri
            $QueryParams.Method = $method
            $QueryParams.ContentType = 'application/json; charset=utf-8'
            $QueryParams.Headers = @{
                'authorization'       = "Bearer  $($this.ApiToken)"
                'forecast-account-id' = 519353
                'authority'           = 'api.forecastapp.com'
            }

            if ($body.GetEnumerator().Count -gt 0) {
                $QueryParams.Body = $body | ConvertTo-Json
            }

            $rawResult = Invoke-RestMethod @QueryParams
        } catch {
            Throw $_
        }

        $this.RawQueryResultHistory += $rawResult
        $this.LastResult = $rawResult

        $proccessedResult = $this.processQueryResult($rawResult)

        return $proccessedResult
    }

    # with just a method
    [psobject] invokeApiQuery([string]$method) {
        return $this.invokeApiQuery(@{}, $method)
    }

    #region Initiators
    ########################################################################

    # empty initiator
    HFServer() {
    }

    ########################################################################
    #endregion Initiators
}
