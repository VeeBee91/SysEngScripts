$extdomain = "mail" #enter subdomain
$intdomain = "mail" #enter subdomain
$domain = "domain.com" #enter domain
$servername = "exchangeserver" #enter server name

Get-ClientAccessServer -Identity $servername | Set-ClientAccessServer -AutoDiscoverServiceInternalUri "https://autodiscover.$domain/Autodiscover/Autodiscover.xml"
Get-EcpVirtualDirectory -Server $servername | Set-EcpVirtualDirectory -ExternalUrl "https://$extdomain.$domain/ecp" -InternalUrl "https://$intdomain.$domain/ecp"
Get-WebServicesVirtualDirectory -Server $servername | Set-WebServicesVirtualDirectory -ExternalUrl "https://$extdomain.$domain/EWS/Exchange.asmx" -InternalUrl "https://$intdomain.$domain/EWS/Exchange.asmx"
Get-MapiVirtualDirectory -Server $servername | Set-MapiVirtualDirectory -ExternalUrl "https://$extdomain.$domain/mapi" -InternalUrl "https://$intdomain.$domain/mapi"
Get-ActiveSyncVirtualDirectory -Server $servername | Set-ActiveSyncVirtualDirectory -ExternalUrl "https://$extdomain.$domain/Microsoft-Server-ActiveSync" -InternalUrl "https://$intdomain.$domain/Microsoft-Server-ActiveSync"
Get-OabVirtualDirectory -Server $servername | Set-OabVirtualDirectory -ExternalUrl "https://$extdomain.$domain/OAB" -InternalUrl "https://$intdomain.$domain/OAB"
Get-OwaVirtualDirectory -Server $servername | Set-OwaVirtualDirectory -ExternalUrl "https://$extdomain.$domain/owa" -InternalUrl "https://$intdomain.$domain/owa"
Get-PowerShellVirtualDirectory -Server $servername | Set-PowerShellVirtualDirectory -ExternalUrl "https://$extdomain.$domain/powershell" -InternalUrl "https://$intdomain.$domain/powershell"
Get-OutlookAnywhere -Server $servername | Set-OutlookAnywhere -ExternalHostname "$extdomain.$domain" -InternalHostname "$intdomain.$domain" -ExternalClientsRequireSsl $true -InternalClientsRequireSsl $true -DefaultAuthenticationMethod NTLM