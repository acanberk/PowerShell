<#
.SYNOPSIS
    Get the time of last successful Veeam backup.
.DESCRIPTION
    The Get-LastVeeamBackup function gives you the time of last successful Veeam Backup.
    Valid parameters are: hostname or "HostList.txt"
    If no parameter given, script will query localhost.
    Script must be run with priviliges on remote computers.
.PARAMETER hostname
    Specifies the computer name to query.
.EXAMPLE
    PS> ./Get-LastVeeamBackup APPSRV1
    Last successful Veeam backup on APPSRV1 was at 28.04.2022 20:06:17
.PARAMETER HostList.txt
    Specifies the computer name list to query. (parameter must be exactly "HostList.txt")
.EXAMPLE
    PS> ./Get-LastVeeamBackup hostlist.txt
    Last successful Veeam backup on APPSRV1 was at 28.04.2022 20:06:17
    Last successful Veeam backup on APPSRV2 was at 28.04.2022 18:42:34
    Last successful Veeam backup on SQLSRV was at 29.04.2022 00:33:48
.LINK
    https://github.com/acanberk/PowerShell
.NOTES
    Author: Atıf Canberk Ezan
    Date: 2022/04/29
#>

$computerList = $null
if($args[0]){
    if($args[0] -eq "HostList.txt"){
        $computerList = Get-Content $args[0]
    }
    else{
        $computerList = $args[0]
    }
}
else{
    $computerList = "LOCALHOST"
}

$computer = $null
foreach ($computer in $computerList) {
    $LogTime = $null
    $LogTime = (Get-WinEvent -ComputerName $Computer -FilterHashTable @{Logname='Veeam Agent';ID=190} -MaxEvents 1).timecreated
    if($LogTime){
        write-host "Last successful Veeam backup on" $Computer "was at" $LogTime
    }
    else{
        Write-Host "No successful Veeam backups found on" $Computer
    }
}