#IP address of OneView
$IP = "192.168.56.101" 

# OneView Credentials
$username = "Administrator" 
$password = "password"

$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
    
Connect-OVMgmt -appliance $IP -Credential $credentials 
