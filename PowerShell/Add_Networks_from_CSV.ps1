$csvfile = "networks_creation.csv"
 
$IP = "192.168.56.101" 
$username = "Administrator" 
$password = "password"

$LIG_UplinkSet = "Prod"
$networksetname = "Prod"
$LIGname = "LIG-FlexFabric"

$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
Connect-OVMgmt -Hostname $IP -Credential $credentials | Out-Null

$data = (Import-Csv $csvfile)

# Creating Networks and adding them to the LIG uplink Set       

$LIG = Get-OVLogicalInterconnectgroup -Name $LIGname

if (!(($LIG | Measure-Object).Count -eq 1 )) { Write-Host "Failed to filter down to one LIG" -ForegroundColor Red | Break }

ForEach ($VLAN In $data) {
    New-OVNetwork -Name $VLAN.NetName -Type Ethernet -VLANId $VLAN.VLAN_ID -SmartLink $True | out-Null
    Write-host "`nCreating Network: " -NoNewline
    Write-host -f Cyan ($VLAN.netName) -NoNewline

    (($LIG.uplinkSets | where-object name -eq $LIG_UplinkSet | Where-Object { $_.ethernetNetworkType -eq "Tagged" }).networkUris) += (Get-OVNetwork -Name $VLAN.NetName).uri #Add NewNetwork to the networkUris Array
    Write-host "`nAdding Network: " -NoNewline
    Write-host -f Cyan ($VLAN.netName) -NoNewline
    Write-host " to Uplink Set: " -NoNewline
    Write-host -f Cyan $LIG_UplinkSet

}

try {
    Set-OVResource $LIG -ErrorAction Stop | Wait-OVTaskComplete #| Out-Null
}
catch {
    Write-Output $_ #.Exception
}

# Updating LI from LIG                               

$LI = ((Get-OVLogicalInterconnect) | where-object logicalInterconnectGroupUri -eq $LIG.uri)


do {
    $Interconnectstate = (((Get-OVInterconnect) | where-object productname -match "Virtual Connect") | where-object logicalInterconnectUri -EQ $LI.uri).state 

    if ($Interconnectstate -notcontains "Configured") {

        Write-host "`nWaiting for the running Interconnect configuration task to finish, please wait...`n" 
    }

}

until ($Interconnectstate -notcontains "Adding" -and $Interconnectstate -notcontains "Imported" -and $Interconnectstate -notcontains "Configuring")

Write-host "`nUpdating all Logical Interconnects from the Logical Interconnect Group: " -NoNewline
Write-host -f Cyan $LIG.name
Write-host "`nPlease wait..." 

try {
    Get-OVLogicalInterconnect -Name $LI.name | Update-OVLogicalInterconnect -confirm:$false -ErrorAction Stop | Wait-OVTaskComplete | Out-Null
}
catch {
    Write-Output $_ #.Exception
}

# Adding Network to Network Set                           

ForEach ($VLAN In $data) {

    Write-host "`nAdding Network: " -NoNewline
    Write-host -f Cyan ($VLAN.netName) -NoNewline
    Write-host " to NetworkSet: " -NoNewline
    Write-host -f Cyan $networksetname
    
    $VLANuri = (Get-OVNetwork -Name $VLAN.NetName).uri
    $networkset = Get-OVNetworkSet -Name $networksetname
   
    $networkset.networkUris += (Get-OVNetwork -Name $VLAN.NetName).uri
  
    try {
        Set-OVNetworkSet $networkset -ErrorAction Stop | Wait-OVTaskComplete | Out-Null
    }
    catch {
        Write-Output $_
    }
 
    if ( (Get-OVNetworkSet -Name $NetworkSetname).networkUris -ccontains $VLANuri) {
        Write-host "`nThe network VLAN ID: " -NoNewline
        Write-host -f Cyan $VLAN.NetName -NoNewline
        Write-host " has been added successfully to all Server Profiles that are using the Network Set: " -NoNewline
        Write-host -f Cyan $networksetname 
    }
    else {
        Write-Warning "`nThe network VLAN ID: $($VLAN.VLAN_ID) has NOT been added successfully, check the status of your Logical Interconnect resource`n" 
    }

}
    
$ConnectedSessions | Disconnect-OVMgmt | Out-Null