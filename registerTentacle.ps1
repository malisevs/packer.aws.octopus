cd "C:\Program Files\Octopus Deploy\Tentacle"

.\Tentacle.exe create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config" --console
.\Tentacle.exe import-certificate --instance "Tentacle" -f c:\cert.txt --console
.\Tentacle.exe configure --instance "Tentacle" --reset-trust --console
.\Tentacle.exe configure --instance "Tentacle" --home "C:\Octopus" --app "C:\Octopus\Applications" --port "10933" --console
.\Tentacle.exe configure --instance "Tentacle" --trust "{{thumbprint}}" --console
$webClient = New-Object System.Net.WebClient
$dns = $webClient.DownloadString('http://169.254.169.254/latest/meta-data/public-hostname')
.\Tentacle.exe register-with --instance "Tentacle" --server "https://octopus.server/" --apiKey="$Env:OAPI" --role "H2O" --environment "HOP-AWS-INSTALL" --publicHostname "$dns" --force --comms-style TentaclePassive --console
netsh advfirewall firewall add rule "name=Octopus Deploy Tentacle" dir=in action=allow protocol=TCP localport=10933
.\Tentacle.exe service --instance "Tentacle" --install --start --console