#Variables for Processing

Import-Module Microsoft.Online.Sharepoint.PowerShell -DisableNameChecking -UseWindowsPowerShell

$AdminSiteURL = "https://obossverige-admin.sharepoint.com/"
$Credential = Get-credential
Connect-SPOService -url $AdminSiteURL
 
#sharepoint online list all site collections powershell
Get-SPOSite -Detailed | Format-Table Url, Template, StorageUsageCurrent, StorageQuota, LastContentModifiedDate -AutoSize
Get-SPOSite -Limit ALL | ft Owner, GroupId, URL, Status, SensitivityLabel, LastContentModifiedDate, 
$all = get-sposite | ft -Property * 
$all | ConvertTo-Csv | out-file -FilePath .\sharepointexport.csv

#sharepoint online get all site collections PowerShell
$SiteColl = Get-SPOSite
 
#sharepoint online PowerShell iterate through all site collections
ForEach($Site in $SiteColl)
{
    Write-host $Site.Url
}


get-sposite | ft