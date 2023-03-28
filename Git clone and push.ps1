
#USAGE EXAMPLE
#.\generate-support-assets.ps1 -Customername $Customername Ptaken -SubscriptionId '09277bbe-69f1-4e20-87e2-1bcf288e3aa0' -ResourceGroup 'PointtakenOperations' $rootpath= 'C:\<GIT PROJECT PATH>\PointTaken.AzureCommandCenter\Azure_Monitor'  -Workspace "log-Ptaken-norwayeast-001" -Telefon '1233456778' -point_of_contact "ruben ochando" -Email "test@test.no"

# For Debuging purpose on local machine uncomment lines
#Create PAT in DEVOPS project and save in keyvault
Write-Host "################################Set variables###########################################"
$TenantID = (Get-AzTenant).Id
$Customername = "DINGDONGDONG"
$global:LASTEXITCODE = $null
$global:PWSH = 'true'

#Expirese after one year - check azure devops -security -personal access token
$PAT = 'l4roleujtryo62m3ueuq2fcwwazvio6l37kcom7vet2ib77uwblq'
$B64Pat = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("$PAT"))

Write-Host "################################ Get all the modules ###########################################"
#Get-module
Get-module -name VSTeam
Set-VSTeamAccount -Account https://dev.azure.com/pointtaken -PersonalAccessToken $B64Pat

#Get-VSTeamProject
$Project = "PointTaken.AzureCommandCenter"
Get-VSTeamReleaseDefinition -ProjectName $Project
"Set config"
git clone https://pointtaken@dev.azure.com/pointtaken/PointTaken.AzureCommandCenter/_git/PointTaken.AzureCommandCenter
cd PointTaken.AzureCommandCenter/
"pull"
git pull
git status
git branch -vv
git remote -v
$Azure_Monitor_folder = "$rootpath\PointTaken.AzureCommandCenter\Azure_Monitor"

try {
    New-Item -Path $Azure_Monitor_folder -name $Customername -ItemType Directory
}
catch { write-host "Error Item Directory" }
try {
    New-Item -Path "$Azure_Monitor_folder\$customername" -name "truse" -ItemType File
}
catch { write-host "Error Item Directory" }
"add"
git add --all
"commit"
git commit -m "noe"
"push"
git push 


#git pull
<#
git clone 

git branch -b "pipelinebranch"

#user must be an Pointaken axure devops user
git config --global user.email "azure_kontroll@pointtaken.no" # any values will do, if missing commit will fail
git config --global user.name "Azure Kontroll"

"status"
git status

"Change directory & delete git"
Set-Location -Path $rootpath
Get-ChildItem

try {
    New-Item -Path $Azure_Monitor_folder -name $Customername -ItemType Directory
}
catch { write-host "Error Item Directory" }

git status
"git add"
git add .
"Git inital comit"
git commit -m "Initial Commit"

git push origin master
#>

<#

"git add"
git pull
git add .
git commit -m "Automation"
git remote add origin https://pointtaken@dev.azure.com/pointtaken/PointTaken.AzureCommandCenter/_git/PointTaken.AzureCommandCenter 

"Checkout a branch"
git config --global --unset credential.helper
git config --global credential.helper store



"Push the change"
git push origin master
#>