#IP address of OneView
$IP = "192.168.56.101" 

# OneView Credentials
$username = "Administrator" 
$password = "password"

$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
    
 
Connect-OVMgmt -appliance $IP -Credential $credentials 


$servers = Get-OVServer 

echo "Server Name; Rom Version;Component Name;Component FirmWare Version" > Server_FW_Report.txt 

foreach ($server in $servers) {

    $components = (Send-OVRequest -Uri ($server.uri + "/firmware")).components | % { $_.ComponentName }
    

    $name = (Get-OVServer -name $server.name ).name
    $romVersion = (Get-OVServer -name $server.name ).romVersion


    foreach ($component in $components) {

        $componentversion = (Send-OVRequest -Uri ($server.uri + "/firmware")).components | ? componentname -eq $component | select componentVersion | % { $_.componentVersion }
     
        "$name;$romVersion;$component;$componentversion" | Out-File Server_FW_Report.txt -Append
      
    }

}

import-csv Server_FW_Report.txt -delimiter ";" | export-csv Server_FW_Report.csv -NoTypeInformation
remove-item Server_FW_Report.txt -Confirm:$false

Disconnect-OVMgmt
