# Created by Michiel (Mitch) Verbruggen, Centorrino Technologies.
# Set variable rootPath!!!
# Files written in present directory (change if necessary).

$rootPath = "C:\ENTERYOURPATH"
$modifiedOutput = @()
$accessedOutput = @()
$files = Get-ChildItem -File -Path $rootPath -Recurse
Foreach ($file in $files) {
	if ($file.LastWriteTime -ge (Get-Date).AddDays(-30)) {
        $modifiedOutput += $file.FullName
        }
    if ($file.LastAccessTime -ge (Get-Date).AddDays(-30)) {
        $accessedOutput += $file.FullName
        }
}
$modifiedOutput | Export-Csv -NoTypeInformation -Path FilesModifiedInLast30Days.csv
$accessedOutput | Export-Csv -NoTypeInformation -Path FilesAccessedInLast30Days.csv

