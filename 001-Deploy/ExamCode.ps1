$LabInstanceId = "6248046"
$rg = Get-AzureRmResourceGroup | ? {($_.Tags -ne $null) -and ($_.Tags["LabInstance"] -eq $LabInstanceId)}
$ns = Get-AzureRmRelayNamespace -ResourceGroupName $rg.ResourceGroupName
$hybrid = Get-AzureRmRelayHybridConnection -ResourceGroupName $rg.ResourceGroupName -Namespace $ns.Name -ErrorAction SilentlyContinue -ErrorVariable $e
$hybrid.ListenerCount -gt 0


