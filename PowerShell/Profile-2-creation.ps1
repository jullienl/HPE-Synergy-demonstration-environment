#IP address of OneView
$IP = "192.168.56.101" 

# OneView Credentials
$username = "Administrator" 
$password = "password"

$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
     
Connect-HPOVMgmt -appliance $IP -Credential $credentials

# -------------- Attributes for ServerProfile "Profile-2"
$name = "Profile-2"
$description = "Server Profile for HPE Synergy 480 Gen9 Compute Module with Local Boot for RHEL"
$server = Get-HPOVServer -Name "Synergy-Encl-2, bay 5"
$affinity = "Bay"
# -------------- Connections section
# -------------- Attributes for connection "1"
$connID = 1
$connName = "Mgmt-1"
$connType = "Ethernet"
$netName = "Mgmt"
$ThisNetwork = Get-HPOVNetwork -Type Ethernet -Name $netName
$portID = "Mezz 3:1-a"
$requestedMbps = 7500
$Conn1 = New-HPOVServerProfileConnection -ConnectionID $connID -Name $connName -ConnectionType $connType -Network $ThisNetwork -PortId $portID -RequestedBW $requestedMbps
# -------------- Attributes for connection "2"
$connID = 2
$connName = "Mgmt-2"
$connType = "Ethernet"
$netName = "Mgmt"
$ThisNetwork = Get-HPOVNetwork -Type Ethernet -Name $netName
$portID = "Mezz 3:2-a"
$requestedMbps = 7500
$Conn2 = New-HPOVServerProfileConnection -ConnectionID $connID -Name $connName -ConnectionType $connType -Network $ThisNetwork -PortId $portID -RequestedBW $requestedMbps
# -------------- Attributes for connection "3"
$connID = 3
$connName = "Prod-NetworkSet-1"
$connType = "Ethernet"
$netName = "Prod"
$ThisNetwork = Get-HPOVNetworkSet -Name $netName
$portID = "Mezz 3:1-c"
$requestedMbps = 2500
$Conn3 = New-HPOVServerProfileConnection -ConnectionID $connID -Name $connName -ConnectionType $connType -Network $ThisNetwork -PortId $portID -RequestedBW $requestedMbps
# -------------- Attributes for connection "4"
$connID = 4
$connName = "Prod-NetworkSet-2"
$connType = "Ethernet"
$netName = "Prod"
$ThisNetwork = Get-HPOVNetworkSet -Name $netName
$portID = "Mezz 3:2-c"
$requestedMbps = 2500
$Conn4 = New-HPOVServerProfileConnection -ConnectionID $connID -Name $connName -ConnectionType $connType -Network $ThisNetwork -PortId $portID -RequestedBW $requestedMbps
$connections = $Conn1, $Conn2, $Conn3, $Conn4
# -------------- Local Storage section
# -------------- Attributes for logical disk "SAS RAID1 SSD(RAID1)"
$ldName = "SAS RAID1 SSD"
$raidLevel = "RAID1"
$ldName = "SAS RAID1 SSD"
$raidLevel = "RAID1"
$numPhysDrives = 2
$driveTech = "SASSSD"
$LogicalDisk1 = New-HPOVServerProfileLogicalDisk -Name $ldName -Raid $raidLevel -NumberofDrives $numPhysDrives -DriveType $driveTech -Bootable $True
# -------------- Attributes for controller "Embedded" (RAID)
$deviceSlot = "Embedded"
$controllerMode = "RAID"
$LogicalDisks = $LogicalDisk1
$controller1 = New-HPOVServerProfileLogicalDiskController -ControllerID $deviceSlot -Mode $controllerMode -LogicalDisk $LogicalDisks
$controllers = $controller1
# -------------- Attributes for Boot Mode settings
$manageboot = $True
$biosBootMode = "BIOS"
$bmConsistency = ""
# -------------- Attributes for boot order settings
$bootOrder = "CD", "USB", "HardDisk", "PXE"
# -------------- Attributes for advanced settings
New-HPOVServerProfile -Name $name -Description $description -AssignmentType Server -Server $server -Affinity $affinity -Connections $connections -LocalStorage  -StorageController $controllers -ManageBoot:$manageboot -BootMode $biosBootMode -BootOrder $bootOrder -HideUnusedFlexNics $true

Disconnect-hpovmgmt