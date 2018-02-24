$api = $Env:OAPI
$url = "https://octopus.server/api/environments/Environments-261/machines"
$response = Invoke-RestMethod -Method Get -Uri $url -Header @{ "X-Octopus-ApiKey" = $api }

foreach($item in $response.Items){
    if($item.HealthStatus -eq "HasWarnings"){
        Octo clean-environment --environment "HOP-AWS-INSTALL" --healthstatus HasWarnings --server "https://octopus.server/" --apikey "$api"
    }
    if($item.HealthStatus -eq "Unavailable"){
        Octo clean-environment --environment "HOP-AWS-INSTALL" --healthstatus Unavailable --server "https://octopus.server/" --apikey "$api"
    }
}
