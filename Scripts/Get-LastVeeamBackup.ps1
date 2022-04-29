<#
.SYNOPSIS
	Get the time of last successful Veeam backup.
.DESCRIPTION
	The Get-LastVeeamBackup function gives you the time of last successful Veeam Backup.
.PARAMETER ComputerName
	Specifies the computer name to query.
.EXAMPLE
	PS> ./Get-LastVeeamBackup APPSRV1
	Last successful Veeam backup on APPSRV1 was at 28.04.2022 20:06:17
.LINK
	https://github.com/acanberk/PowerShell
.NOTES
	Author: Atıf Canberk Ezan
    Date: 2022/04/29
#>

if($args[0]){
    $ComputerName = $args[0]
}
else{
    $ComputerName = "LOCALHOST"
}

$LogTime = $null

$LogTime = (Get-WinEvent -ComputerName $ComputerName -FilterHashTable @{Logname='Veeam Agent';ID=190} -MaxEvents 1).timecreated
if($LogTime){
    write-host "Last successful Veeam backup on" $ComputerName "was at" $LogTime
}
else{
    Write-Host "No successful Veeam backups found on" $ComputerName
}