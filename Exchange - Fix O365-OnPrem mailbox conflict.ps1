$formatenumerationlimit = -1
$mbxs = get-mailbox -Server ENTERYOURSERVERNAME

foreach ($mbx in $mbxs) {
    $mbxfile = $mbx.alias + ".txt"
    Get-Mailbox $mbx.UserPrincipalName | fl > $mbxfile
    $rrA = $mbx.alias + "@braemarviceduau.mail.onmicrosoft.com"
    $upn = $mbx.UserPrincipalName
    $legacyDN = $mbx.LegacyExchangeDN
    Disable-Mailbox $mbx.UserPrincipalName
    Enable-RemoteMailbox -Identity $upn –RemoteRoutingAddress $rrA 
    Set-RemoteMailbox -Identity $upn -EmailAddresses @{add="x500:$legacyDN"}
}