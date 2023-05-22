# Step 1: Log in to Azure in the source tenant
Connect-AzAccount

# Step 2: Select security groups
$groups = Get-AzADGroup | Out-GridView -Title "Select Security Groups" -PassThru

# Step 3: Save groups and their members
$groupMembers = @{}
foreach ($group in $groups) {
    $members = Get-AzADGroupMember -ObjectId $group.Id | Where-Object { $_.OdataType -eq "#microsoft.graph.user" }
    $groupMembers[$group.DisplayName] = $members
}

# Step 4: Edit members' UPN
$editedMembers = @{}
foreach ($groupName in $groupMembers.Keys) {
    $editedMembers[$groupName] = @()
    foreach ($member in $groupMembers[$groupName]) {
        $getcurrentuser = Get-AzADUser -ObjectId $member.Id
        $editedUPN = $getcurrentuser.UserPrincipalName.Split("@")[0] + "@obosonline.onmicrosoft.com"
        $editedMembers[$groupName] += $editedUPN
    }
}
# Step 7: Disconnect from Azure
Disconnect-AzAccount

# Step 5: Log in to Azure in the destination tenant
Connect-AzAccount



# Step 6: Create groups and add members
foreach ($groupName in $editedMembers.Keys) {
    $group = Get-AzADGroup -DisplayName $groupName
    if (!$group) {
        Write-Host "Group with ID $groupName not found" -ForegroundColor Green
    $oldname = $groupName
    $newname = $oldname.Replace(" ", "-")
        
    $newGroup = New-AzADGroup -DisplayName $groupName -MailNickname $newname
    foreach ($memberUPN in $editedMembers[$groupName]) {
        $user = Get-AzADUser -UserPrincipalName $memberUPN
        try {
            Add-AzADGroupMember -MemberObjectId $user.Id -TargetGroupObjectId $newGroup.Id
        } catch {
            Write-Host "Failed to add user $memberUPN to group $groupName" -ForegroundColor Red
        }
    }
    
    } else {
        Write-Host "Group with ID $groupName already exists" -ForegroundColor Yellow

        foreach ($memberUPN in $editedMembers[$groupName]) {
            $user = Get-AzADUser -UserPrincipalName $memberUPN
            try {
                Add-AzADGroupMember -MemberObjectId $user.Id -TargetGroupObjectId $newGroup.Id
            } catch {
                Write-Host "Failed to add user $memberUPN to group $groupName" -ForegroundColor Red
            }
        }

    }
}

# Step 7: Disconnect from Azure
Disconnect-AzAccount
