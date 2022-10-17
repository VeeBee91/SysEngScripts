$server = <ENTERYOURSERVERNAME>
$results = Get-DnsServerZone -ComputerName $server | % {
    $zone = $_.zonename
    Get-DnsServerResourceRecord $zone -ComputerName $server | select @{n='ZoneName';e={$zone}}, HostName, RecordType, Timestamp, @{n='RecordData';e={if ($_.RecordData.IPv4Address.IPAddressToString) {$_.RecordData.IPv4Address.IPAddressToString} else {$_.RecordData.NameServer.ToUpper()}}}
}

$results | Export-Csv -NoTypeInformation c:\temp\DNSRecords.csv -Append
