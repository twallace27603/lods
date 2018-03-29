param($LabInstanceId)


#Variables
$hcCreated = $false
$hcm = $false
$evidenceHeading = "Hybrid Connection Manager"
$evidence = ""

#Get Resource Group
$rg = Get-AzureRmResourceGroup | ? {$_.Tags.Count -gt 0 -and $_.Tags['LabInstance'] -eq $LabInstanceId} 
#Retrieve hybrid connection
$relay = (Get-AzureRmRelayNamespace -ResourceGroupName $rg.ResourceGroupName)[0]
$hybrids = Get-AzureRmRelayHybridConnection -ResourceGroupName $rg.ResourceGroupName -Namespace $relay.Name  -ErrorAction SilentlyContinue -ErrorVariable $e
if ($hybrids -ne $null) {
    $hcCreated = $true
    $hybrid = $hybrids | ? {$_.Name -eq "serviceHost"} 
    if ($hybrid -ne $null) {
        $hcm = $hybrid.ListenerCount -eq 1
    }
}

#Set success criteria
$success = $hcCreated -and $hcm

#Set output
if($success) {
    $evidence = @"
You have correctly created a hybrid connection manager:
    Host: hcmHost
    Name: serviceHost
    EndPoint: serviceHost
    Port: 8080
"@
} else {
    if(-not $hcCreated) {
        $evidence = @"
You have not created a hybrid connection.
"@
    } else {
        $evidence = @"
You have created a hybrid connection, but have not configured a hybrid connection manager.

The hybrid connection manager should be installed on the hcmHost virtual machine and manage the serviceHost hybrid connection.
"@
    }
}

#Return output
@"
${evidenceHeading}
$('-' * $evidenceHeading.Length)

${evidence}
"@

#Return result
$success