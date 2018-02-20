[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation

# Get inputs for the task
$connectedServiceNameSelector = Get-VstsInput -Name ConnectedServiceNameSelector -Require
$connectedServiceName = Get-VstsInput -Name ConnectedServiceName
$connectedServiceNameARM = Get-VstsInput -Name ConnectedServiceNameARM
$storageAccount = Get-VstsInput -Name StorageAccount
$storageAccountRM = Get-VstsInput -Name StorageAccountRM
$containerName = Get-VstsInput -Name ContainerName
$blobPrefix = Get-VstsInput -Name BlobPrefix
$environmentName = Get-VstsInput -Name EnvironmentName
$environmentNameRM = Get-VstsInput -Name EnvironmentNameRM
$resourceFilteringMethod = Get-VstsInput -Name ResourceFilteringMethod
$machineNames = Get-VstsInput -Name MachineNames
$vmsAdminUserName = Get-VstsInput -Name VmsAdminUsername
$vmsAdminPassword = Get-VstsInput -Name VmsAdminPassword
$targetPath = Get-VstsInput -Name TargetPath
$additionalArguments = Get-VstsInput -Name AdditionalArguments

if ($connectedServiceNameSelector -eq "ConnectedServiceNameARM")
{
    $connectedServiceName = $connectedServiceNameARM
    $storageAccount = $storageAccountRM
    $environmentName = $environmentNameRM
}

$ErrorActionPreference = 'Stop'


# Copying files to Azure VMs
try
{

}
catch
{
    Write-Verbose $_.Exception.ToString() -Verbose

    Write-Telemetry "Task_InternalError" $_.Exception.Message
    throw
}
finally
{
    Remove-AzureContainer -containerName $containerName -storageContext $storageContext
    Write-Verbose "Completed Azure File Copy Task for Azure VMs Destination" -Verbose
    Trace-VstsLeavingInvocation $MyInvocation
}
