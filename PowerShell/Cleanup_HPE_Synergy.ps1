##############################################################################
# Cleanup_HPE_Syergy.ps1
#
# - Example script for de-configuring the HPE Synergy Appliance
#
#   VERSION 4.30
#
#   AUTHORS
#   Lionel Jullien - Inspired from daveolker/Populate-HPE-Synergy GitHub repository
#
# (C) Copyright 2019 Hewlett Packard Enterprise Development LP 
##############################################################################
<#
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
#>


function Remove_Logical_Enclosures {
    Write-Output "Removing all Logical Enclosures" | Timestamp
    Get-OVLogicalEnclosure | Remove-OVLogicalEnclosure -Force -Confirm:$false | Wait-OVTaskComplete
    Write-Output "All Logical Enclosures Removed" | Timestamp
}    


function Remove_Enclosure_Groups {
    Write-Output "Removing all Enclosure Groups" | Timestamp
    Get-OVEnclosureGroup | Remove-OVEnclosureGroup -Force -Confirm:$false
    Write-Output "All Enclosure Groups Removed" | Timestamp
}
    

function Remove_Logical_Interconnect_Groups {
    Write-Output "Removing all Logical Interconnect Groups" | Timestamp
    Get-OVLogicalInterconnectGroup | Remove-OVLogicalInterconnectGroup -Force -Confirm:$false | Wait-OVTaskComplete
    Write-Output "All Logical Interconnect Groups Removed" | Timestamp
}


function Remove_OS_Deployment_Servers {
    Write-Output "Removing all OS Deployment Servers" | Timestamp
    Get-OVOSDeploymentServer | Remove-OVOSDeploymentServer -Confirm:$false | Wait-OVTaskComplete
    #
    # Sleep for 400 seconds to allow the OS Deployment Cluster to Form
    #
    #Sleep -Seconds 400
    Write-Output "All OS Deployment Servers Removed" | Timestamp
}


function Remove_Server_Profile_Templates {
    Write-Output "Removing all Server Profile Templates" | Timestamp
    Get-OVServerProfileTemplate | Remove-OVServerProfileTemplate -Force -Confirm:$false | Wait-OVTaskComplete
    Write-Output "All Server Profile Templates Removed" | Timestamp
}


function Remove_Server_Profiles {
    Write-Output "Removing all Server Profiles" | Timestamp
    Get-OVServerProfile | Remove-OVserverProfile -Force -Confirm:$false | Wait-OVTaskComplete
    Write-Output "All Server Profiles Removed" | Timestamp
}


function Rename_Enclosures {
    Write-Output "Renaming Enclosures" | Timestamp
    $Enc = Get-OVEnclosure -Name Synergy-Encl-1 -ErrorAction SilentlyContinue
    Set-OVEnclosure -Name "0000A66101" -Enclosure $Enc | Wait-OVTaskComplete

    $Enc = Get-OVEnclosure -Name Synergy-Encl-2 -ErrorAction SilentlyContinue
    Set-OVEnclosure -Name "0000A66102" -Enclosure $Enc | Wait-OVTaskComplete

    $Enc = Get-OVEnclosure -Name Synergy-Encl-3 -ErrorAction SilentlyContinue
    Set-OVEnclosure -Name "0000A66103" -Enclosure $Enc | Wait-OVTaskComplete

    $Enc = Get-OVEnclosure -Name Synergy-Encl-4 -ErrorAction SilentlyContinue
    Set-OVEnclosure -Name "0000A66104" -Enclosure $Enc | Wait-OVTaskComplete

    $Enc = Get-OVEnclosure -Name Synergy-Encl-5 -ErrorAction SilentlyContinue
    Set-OVEnclosure -Name "0000A66105" -Enclosure $Enc | Wait-OVTaskComplete

    Write-Output "All Enclosures Renamed" | Timestamp
}


function Remove_Storage_Volume_Templates {
    Write-Output "Removing all Storage Volume Templates" | Timestamp
    Get-OVStorageVolumeTemplate | Remove-OVStorageVolumeTemplate -Force -Confirm:$false
    Write-Output "All Storage Volume Templates Removed" | Timestamp
}


function Remove_Storage_Volumes {
    Write-Output "Removing all Storage Volumes" | Timestamp
    Get-OVStorageVolume | Remove-OVStorageVolume -Confirm:$false | Wait-OVTaskComplete
    Write-Output "All Storage Volumes Removed" | Timestamp
}


function Remove_Storage_Pools {
    Write-Output "Removing all Storage Pools" | Timestamp
    Get-OVStoragePool | Remove-OVStoragePool -Force -Confirm:$false | Wait-OVTaskComplete
    Write-Output "All Storage Pools Removed" | Timestamp
}


function Remove_Storage_Systems {
    Write-Output "Removing all Storage Systems" | Timestamp
    Get-OVStorageSystem | Remove-OVStorageSystem -Force -Confirm:$false | Wait-OVTaskComplete
    Write-Output "All Storage Systems Removed" | Timestamp
}


function Remove_Network_Sets {
    Write-Output "Removing all Network Sets" | Timestamp
    Get-OVNetworkSet | Remove-OVNetworkSet -Confirm:$false | Wait-OVTaskComplete
    Write-Output "All Network Sets Removed" | Timestamp
}


function Remove_Networks {
    Write-Output "Removing all Networks" | Timestamp
    Get-OVNetwork | Remove-OVNetwork -Force -Confirm:$false | Wait-OVTaskComplete
    Write-Output "All Networks Removed" | Timestamp
}


function Remove_IPv4_Address_Pool_Ranges {
    Write-Output "Removing all IPv4 Address Pool Ranges" | Timestamp
    Get-OVAddressPoolRange | Remove-OVAddressPoolRange -Confirm:$false
    Write-Output "All IPv4 Address Pools Removed" | Timestamp
}


function Remove_IPv4_Subnets {
    Write-Output "Removing all IPv4 Subnets" | Timestamp
    Get-OVAddressPoolSubnet | Remove-OVAddressPoolSubnet -Confirm:$false
    Write-Output "All IPv4 Subnets Removed" | Timestamp
}


function Remove_SAN_Managers {
    Write-Output "Removing all SAN Managers" | Timestamp
    Get-OVSanManager | Remove-OVSanManager -Confirm:$false | Wait-OVTaskComplete
    Write-Output "All SAN Managers Removed" | Timestamp
}


function Remove_Licenses {
    Write-Output "Removing all Licenses" | Timestamp
    Get-OVLicense | Remove-OVLicense -Confirm:$false
    Write-Output "All Licenses Removed" | Timestamp
}


function Remove_Firmware_Bundles {
    Write-Output "Removing all Fimrware Bundles" | Timestamp
    Get-OVBaseline | Remove-OVBaseline -Confirm:$false | Wait-OVTaskComplete
    Write-Output "All Firmware Bundles Removed" | Timestamp
}


function Remove_New_Users {
    Write-Output "Removing all non-default Users" | Timestamp
    Get-OVUser -Name BackupAdmin | Remove-OVUser -Confirm:$false
    Get-OVUser -Name NetworkAdmin | Remove-OVUser -Confirm:$false
    Get-OVUser -Name ServerAdmin | Remove-OVUser -Confirm:$false
    Get-OVUser -Name StorageAdmin | Remove-OVUser -Confirm:$false
    Get-OVUser -Name SoftwareAdmin | Remove-OVUser -Confirm:$false
    Write-Output "All non-default Users Removed" | Timestamp
}


function Remove_Scopes {
    Write-Output "Removing all Scopes" | Timestamp
    Get-OVScope -Name FinanceScope | Remove-OVScope -Confirm:$false
    Write-Output "All Scopes Removed" | Timestamp
}


##############################################################################
#
# Main Program
#
##############################################################################

if (-not (get-module HPOneview.420)) {
    Import-Module HPOneView.420
}

if (-not $ConnectedSessions) {
    $Appliance = Read-Host 'ApplianceName'
    $Username = Read-Host 'Username'
    $Password = Read-Host 'Password' -AsSecureString

    Connect-OVMgmt -Hostname $Appliance -Username $Username -Password $Password
    
    if (-not $ConnectedSessions) {
        Write-Output "Login to Synergy Appliance failed.  Exiting."
        Exit
    } 
}

filter Timestamp { "$(Get-Date -Format G): $_" }

Write-Output "De-Configuring HPE Synergy Appliance" | Timestamp

Remove_Server_Profiles
Remove_Server_Profile_Templates
Remove_Logical_Enclosures
Remove_Enclosure_Groups
Remove_Logical_Interconnect_Groups
Rename_Enclosures
Remove_Storage_Volume_Templates
Remove_Storage_Volumes
Remove_Storage_Pools
Remove_Storage_Systems

#
#    Disabled the removal of OS Deployment Server since 
#    it causes the Deployment appliances to stop working
#
#Remove_OS_Deployment_Servers

Remove_Network_Sets
Remove_Networks
Remove_IPv4_Address_Pool_Ranges
Remove_IPv4_Subnets
Remove_SAN_Managers
Remove_Licenses
Remove_New_Users
Remove_Scopes
Remove_Firmware_Bundles

Write-Output "HPE Synergy Appliance De-configuration Complete" | Timestamp