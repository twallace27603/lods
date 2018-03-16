$username = "@lab.CloudPortalCredential(1).Username"
$password = "@lab.CloudPortalCredential(1).Password"
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr

Login-AzureRmAccount -Credential $cred -Debug -Force
$vm = (Get-AzureRmVM -ResourceGroupName 001LODS -name serviceHost)[0]
$nic = Get-AzureRmResource -ResourceId $vm.NetworkProfile.NetworkInterfaces[0].Id
$pip = Get-AzureRmResource -ResourceId $nic.Properties.ipConfigurations[0].properties.publicIPAddress.id
$ip = $pip.Properties.ipAddress
Start-Process -FilePath  "http://$($ip):8080/users"