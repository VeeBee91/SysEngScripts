# Created by Michiel (Mitch) Verbruggen, Centorrino Technologies.

# Source csv should be two columns with header Name and Network. And Network should be using CIDR format.

# Please set your variables!!!
$networkList = Import-Csv -Path "C:\ENTERYOURPATH"
$dns1 = "x.x.x.x"
$dns2 = "x.x.x.x"
$guestDns = "8.8.8.8"
$dnssuffix = "xxxx.xxxx.com.au"

foreach ($network in $networkList) {
    $net = $network.Network.Substring(0, $network.Network.lastIndexOf('.'))
    [IPAddress] $subnet = 0;
    $subnet.Address = ([UInt32]::MaxValue) -shl (32 - [int]$network.Network.Split('/')[1]) -shr (32 - [int]$network.Network.Split('/')[1])
    Add-DhcpServerv4Scope -Name $network.Name -StartRange "$net.50" -EndRange "$net.249" -SubnetMask $subnet.IPAddressToString -State InActive -LeaseDuration 8.00:00:00
    if($network.Name -like "*guest*") {
        Set-DhcpServerv4OptionValue -ScopeId "$net.0" -OptionId 6 -Value $guestDns
    } else {       
        Set-DhcpServerv4OptionValue -ScopeId "$net.0" -OptionId 6 -Value $dns1,$dns2
    }
    Set-DhcpServerv4OptionValue -ScopeId "$net.0" -OptionId 3 -Value "$net.1"
    Set-DhcpServerv4OptionValue -ScopeId "$net.0" -OptionId 15 -Value $dnssuffix
}