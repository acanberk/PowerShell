<#
.SYNOPSIS
    Disable Inactive Active Directory Users.
.DESCRIPTION
    The Disable-InactiveADUsers script lists and disable Active Directory users who have not logged on last 180 days.
.EXAMPLE
    PS> ./Disable-InactiveADUsers.ps1
    John Freeman 		 Inactive since: 10/21/2021 13:44:10
    Peter Morgan 		 Inactive since: 10/25/2021 18:48:18
    Walter Hard 		 Inactive since: 10/27/2021 10:12:41
.LINK
    https://github.com/acanberk/PowerShell
.NOTES
    Author: Atıf Canberk Ezan
    Date: 2022/04/29
#>

$Date = (Get-Date).AddDays(-180)
$users = $null
$users = Get-ADUser -Filter {((Enabled -eq $true) -and (LastLogonDate -lt $date))} -Properties * | select * | Sort-Object LastLogonDate 

$user = $null
Foreach($user in $users){

   $strNewDescription = "Inactive since: " + $user.LastLogonDate
   Write-Host $user.name `t`t $strNewDescription
   Set-ADUser $user.SamAccountName -Description $strNewDescription
   Disable-ADAccount -Identity $user.SamAccountName
}