# Set your variables (dns server & output file).
$server = "<ENTERYOURSERVERNAME>"
$output = "<ENTER A VALID WRITEABLE LOCATION/FILENAME.>"

# Function to convert the recorddata object to text.
Function Get-DnsServerResourceRecordTextRepresentation {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [Microsoft.Management.Infrastructure.CimInstance] $ResourceRecord
    )
    if($ResourceRecord.RecordType -eq "A") { return [System.Convert]::ToString($ResourceRecord.RecordData.IPv4Address); }
    if($ResourceRecord.RecordType -eq "AAAA") { return [System.Convert]::ToString($ResourceRecord.RecordData.IPv6Address); }
    if($ResourceRecord.RecordType -eq "AFSDB") { return "[" + $ResourceRecord.RecordData.SubType + "][" + $ResourceRecord.RecordData.ServerName + "]"; }
    if($ResourceRecord.RecordType -eq "ATMA") { return "[" + $ResourceRecord.RecordData.AddressType + "][" + $ResourceRecord.RecordData.Address + "]"; }
    if($ResourceRecord.RecordType -eq "CNAME") { return $ResourceRecord.RecordData.HostNameAlias; }
    if($ResourceRecord.RecordType -eq "DHCID") { return $ResourceRecord.RecordData.DHCID; }
    if($ResourceRecord.RecordType -eq "DNAME") { return $ResourceRecord.RecordData.DomainNameAlias; }
    if($ResourceRecord.RecordType -eq "HINFO") { return "[" + $ResourceRecord.RecordData.Cpu + "][" + $ResourceRecord.RecordData.OperatingSystem + "]"; }
    if($ResourceRecord.RecordType -eq "ISDN") { return "[" + $ResourceRecord.RecordData.IsdnNumber + "][" + $ResourceRecord.RecordData.IsdnSubAddress + "]"; }
    if($ResourceRecord.RecordType -eq "MX") { return "[" + $ResourceRecord.RecordData.Preference + "][" + $ResourceRecord.RecordData.MailExchange + "]"; }
    if($ResourceRecord.RecordType -eq "NS") { return $ResourceRecord.RecordData.NameServer; }
    if($ResourceRecord.RecordType -eq "PTR") { return $ResourceRecord.RecordData.PtrDomainName; }
    if($ResourceRecord.RecordType -eq "RP") { return "[" + $ResourceRecord.RecordData.ResponsiblePerson + "][" + $ResourceRecord.RecordData.Description + "]"; }
    if($ResourceRecord.RecordType -eq "RT") { return "[" + $ResourceRecord.RecordData.Preference + "][" + $ResourceRecord.RecordData.IntermediateHost + "]"; }
    if($ResourceRecord.RecordType -eq "SOA") { return "[" + $ResourceRecord.RecordData.SerialNumber + "][" + $ResourceRecord.RecordData.PrimaryServer + "][" + $ResourceRecord.RecordData.ResponsiblePerson + "][" + $ResourceRecord.RecordData.ExpireLimit + "][" + $ResourceRecord.RecordData.MinimumTimetoLive + "][" + $ResourceRecord.RecordData.RefreshInterval + "][" + $ResourceRecord.RecordData.RetryDelay + "]"; }
    if($ResourceRecord.RecordType -eq "SRV") { return "[" + $ResourceRecord.RecordData.Priority + "][" + $ResourceRecord.RecordData.Weight + "][" + $ResourceRecord.RecordData.Port + "][" + $ResourceRecord.RecordData.DomainName + "]"; }
    if($ResourceRecord.RecordType -eq "TXT") { return $ResourceRecord.RecordData.DescriptiveText; }
    if($ResourceRecord.RecordType -eq "WINS") { return "[" + $ResourceRecord.RecordData.Replicate + "][" + $ResourceRecord.RecordData.LookupTimeout + "][" + $ResourceRecord.RecordData.CacheTimeout + "][" + $ResourceRecord.RecordData.WinsServers + "]"; }
    if($ResourceRecord.RecordType -eq "WINSR") { return "[" + $ResourceRecord.RecordData.Replicate + "][" + $ResourceRecord.RecordData.LookupTimeout + "][" + $ResourceRecord.RecordData.CacheTimeout + "][" + $ResourceRecord.RecordData.ResultDomain + "]"; }
    if($ResourceRecord.RecordType -eq "WKS") { return "[" + $ResourceRecord.RecordData.InternetProtocol + "][" + $ResourceRecord.RecordData.Service + "][" + $ResourceRecord.RecordData.InternetAddress + "]"; }
    if($ResourceRecord.RecordType -eq "X25") { return $ResourceRecord.RecordData.PSDNAddress; }
    if($ResourceRecord.RecordType -eq "DNSKEY" ) 
    { 
        if($ResourceRecord.RecordData.Revoked -eq $True) { $dnskeyData  = "[Revoked]"; }
        if($ResourceRecord.RecordData.SecureEntryPoint -eq $True) { $dnskeyData  += "[SEP]"; }
        if($ResourceRecord.RecordData.ZoneKey -eq $True) { $dnskeyData  += "[ZoneKey]"; }
        $dnskeyData += "[" + $ResourceRecord.RecordData.CryptoAlgorithm + "][" + $ResourceRecord.RecordData.KeyTag + "][" + $ResourceRecord.RecordData.KeyProtocol + "][" + $ResourceRecord.RecordData.Base64Data + "]"
        return $dnskeyData
    }
    if($ResourceRecord.RecordType -eq "DS") { return "[" + $ResourceRecord.RecordData.KeyTag + "][" + $ResourceRecord.RecordData.CryptoAlgorithm + "][" + $ResourceRecord.RecordData.DigestType + "][" + $ResourceRecord.RecordData.Digest + "]"; }
    if($ResourceRecord.RecordType -eq "NSEC" ) { return "[" + $ResourceRecord.RecordData.Name + "][" + $ResourceRecord.RecordData.CoveredRecordTypes + "]"; }
    if($ResourceRecord.RecordType -eq "NSEC3" ) { return "[" + $ResourceRecord.RecordData.HashAlgorithm + "][" + $ResourceRecord.RecordData.OptOut + "][" + $ResourceRecord.RecordData.Iterations + "][" + $ResourceRecord.RecordData.Salt + "][" + $ResourceRecord.RecordData.NextHashedOwnerName + "][" + $ResourceRecord.RecordData.CoveredRecordTypes + "]"; }
    if($ResourceRecord.RecordType -eq "NSEC3PARAM" ) { return "[" + $ResourceRecord.RecordData.HashAlgorithm + "][" + $ResourceRecord.RecordData.Iterations + "][" + $ResourceRecord.RecordData.Salt + "]"; }
    if($ResourceRecord.RecordType -eq "RRSIG" ) { return "[" + $ResourceRecord.RecordData.TypeCovered + "][" + $ResourceRecord.RecordData.CryptoAlgorithm + "][" + $ResourceRecord.RecordData.KeyTag + "]["+ $ResourceRecord.RecordData.LabelCount + "]["  + $ResourceRecord.RecordData.NameSigner + "][" + "SignatureInception: " + $ResourceRecord.RecordData.SignatureInception + "][" + "SignatureExpiration: " + $ResourceRecord.RecordData.SignatureExpiration + "][" + $ResourceRecord.RecordData.OriginalTtl + "][" + $ResourceRecord.RecordData.Signature + "]"; }
    if($ResourceRecord.RecordType -eq "UNKNOWN" ) { return $ResourceRecord.RecordData.Data; }
    if($ResourceRecord.RecordType -eq "TLSA" ) { return "[" + $ResourceRecord.RecordData.CertificateUsage + "][" + $ResourceRecord.RecordData.Selector + "][" + $ResourceRecord.RecordData.MatchingType + "][" + $ResourceRecord.RecordData.CertificateAssociationData + "]"; }
}

# Collect info from servers.
$results = Get-DnsServerZone -ComputerName $server | % {
    $zone = $_.zonename
    Get-DnsServerResourceRecord $zone -ComputerName $server | select @{n='ZoneName';e={$zone}}, HostName, RecordType, Timestamp, @{n='RecordData';e={Get-DnsServerResourceRecordTextRepresentation $_ }}
}

# Write result to disk.
$results | Export-Csv -NoTypeInformation $output -Append
