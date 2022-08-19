# Created by Michiel (Mitch) Verbruggen, Centorrino Technologies.
# Set variable rootPath!!!
# Files written in present directory (change if necessary).

Get-SmbShare | Get-SmbShareAccess | Sort-Object Name,AccountName | Export-Csv -NoTypeInformation -Path SharePermissions.csv
$rootPath = "C:\ENTERYOURPATH"
$folderPath = Get-ChildItem -Directory -Path $rootPath -Recurse
$output = @()
$rootAcl = Get-Acl -Path $rootPath 
Foreach ($rootAccess in $rootAcl.Access) {
    $properties = [ordered]@{'Folder Name'=$rootPath;'Group/User'=$rootAccess.IdentityReference;'Type'=$rootAccess.AccessControlType;'Permissions'=$rootAccess.FileSystemRights;'InheritanceFlags'=$rootAccess.InheritanceFlags;'PropagationFlags'=$rootAccess.PropagationFlags}
    $output += New-Object -TypeName PSObject -Property $properties  
}
ForEach ($folder in $folderPath) {
    $acl = Get-Acl -Path $folder.FullName
    Foreach ($access in $acl.Access) {
        if ($access.IsInherited -eq $false) {
            $properties = [ordered]@{'Folder Name'=$folder.FullName;'Group/User'=$access.IdentityReference;'Type'=$access.AccessControlType;'Permissions'=$access.FileSystemRights;'InheritanceFlags'=$access.InheritanceFlags;'PropagationFlags'=$access.PropagationFlags}
            $output += New-Object -TypeName PSObject -Property $properties  
        }
    }
}
$output | Export-Csv -NoTypeInformation -Path NTFSPermissionList.csv