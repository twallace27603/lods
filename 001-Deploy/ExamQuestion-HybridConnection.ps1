param($LabInstanceId)

#Variables
$hcCreated = $false
$hcNameCorrect = $false
$hcTargetCorrect = $false
$evidenceHeading = "Hybrid Connection"
$evidence = ""

#Get Resource Group
$rg = Get-AzureRmResourceGroup | ? {$_.Tags.Count -gt 0 -and $_.Tags['LabInstance'] -eq $LabInstanceId} 
#Retrieve hybrid connection
$relay = Get-AzureRmRelayNamespace -ResourceGroupName $rg.ResourceGroupName

#Handle the case where a student creates more than one connection
$hybrids = Get-AzureRmRelayHybridConnection -ResourceGroupName $rg.ResourceGroupName -Namespace $relay.Name  -ErrorAction SilentlyContinue -ErrorVariable $e
if ($hybrids -ne $null) {
    $hcCreated = $true
    $hybrid = $hybrids | ? {$_.Name -eq "serviceHost"} 
    if ($hybrid -ne $null) {
            $hcNameCorrect = $true
            $hcTargetCorrect = $hybrid.UserMetadata.ToLower().Contains('"value":"servicehost:8080"')
    }
}

#Set success criteria
$success = $hcCreated -and $hcNameCorrect -and $hcTargetCorrect

#Set output
if($success) {
    $evidence = @"
You have correctly created a hybrid connection:
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
You have created a hybrid connection, but it is not correct.
    Hybrid connection name: $($hybrid.Name) - This should be serviceHost
    Hybrid connection Host/Port: $($hybrid.UserMetadata) - This should be serviceHost:8080
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