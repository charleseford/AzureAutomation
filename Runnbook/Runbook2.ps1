param(
[Parameter (Mandatory=$True)]
[String]$testparam
)
Write-output "Starting..."
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
$conn | fl *
Add-AzureRMAccount -ServicePrincipal -Tenant $conn.tenantid -applicationid $conn.applicationid -CertificateThumbprint $conn.CertificateThumbprint
#newer cmdlet
#Connect-AzureRmAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
$resourcegroups = Get-AzureRmResourcegroup
foreach ($resourcegroup in $resourcegroups)
{
    Write-Output $resourcegroup.resourcegroupname
    $resourcegroup | Set-AzureRmResourceGroup -Tag @{Name="TestTag";Value="$testparam-$(get-date)"}

}
write-output "Done"