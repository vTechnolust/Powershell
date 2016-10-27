
$DataPath = "c:\userMoveTemp.csv"
$mbxs = import-csv $DataPath

$dbs = "MBD-01","MBD-02","MBD-03","MBD-04","MBD-05","MBD-06","MBD-07","MBD-08"

foreach ($n in 0..($mbxs.count -1)){
#New-MoveRequest -identity $mbxs[$n].Alias -TargetDatabase "MBD-01" -AllowLargeItems -BadItemLimit 25

New-MoveRequest -identity $mbxs[$n].Alias -TargetDatabase $dbs[($n%8)] -AllowLargeItems -BadItemLimit 25
#write-host "users to move "$mbxs[$n].Alias "database to move " $dbs[($n%8)]
}
