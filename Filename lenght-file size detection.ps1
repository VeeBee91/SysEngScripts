# Created by Michiel (Mitch) Verbruggen, Centorrino Technologies.
# Set variable rootPath!!!
# Files written in present directory (change if necessary).

$rootPath = "C:\ENTERYOURPATH"
$files = Get-ChildItem -File -Path $rootPath -Recurse
$output = @()

ForEach ($file in $files) {
    $lengthError = $false
    $sizeError = 0
    if ($file.FullName.Length -ge 240) {
        $lengthError = $true
    }
    if ($file.Length/1GB -ge 250){
        $sizeError = $file.Length/1GB
    }
    if ($lengthError -or $sizeError -gt 0 ) {
        $properties = [ordered]@{'File Name'=$file.FullName;'Length Issue'=$lengthError;'File Size'=$sizeError}
        $output += New-Object -TypeName PSObject -Property $properties
    }
}

$output | Export-Csv -NoTypeInformation -Path FileErrorList.csv