$DataPath = "c:\userMoveTemp.csv"
$DatabaseFilter = "NOR-MBD0*"
$OU_DisabledUsers = ""

$Results = @()
$MailboxUsers = get-mailbox -resultsize unlimited | where {$_.Database -like $DatabaseFilter -and $_.MailboxMoveStatus -eq "None" -and $_.HiddenFromAddressListsEnabled -ne "True" -and $_.OrganizationalUnit -ne $OU_DisabledUsers}
foreach($user in $mailboxusers)
{
$UPN = $user.userprincipalname
$MbxStats = Get-MailboxStatistics $UPN
      $Properties = @{
      Name = $user.name
      Alias = $user.alias
      UPN = $user.userprincipalname
      TotItemSize = $MbxStats.totalitemsize}

$Results += New-Object psobject -Property $properties}
$Results | Select-Object Name,Alias,UPN,TotItemSize| sort-object TotItemSize -Descending | Select-Object -First 256 | Export-Csv -notypeinformation -Path $DataPath
