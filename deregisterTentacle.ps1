cd "C:\Program Files\Octopus Deploy\Tentacle"

.\Tentacle.exe deregister-from --instance "Tentacle" --server "https://octopus.server/" --apiKey "$Env:OAPI" --multiple --console
.\Tentacle.exe  delete-instance --console -instance "Tentacle"
netsh advfirewall firewall delete rule "name=Octopus Deploy Tentacle"