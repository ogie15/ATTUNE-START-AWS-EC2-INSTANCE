#Region FT
# check if AWSPowerShell is installed check 1
# Get-Module -All -Name AWSPowerShell
Get-InstalledModule -Name AWSPowerShell

# Update Installed Module
Update-Module -Name AWSPowerShell -Force

# Uninstall the previous version 
Uninstall-Module -Name AWSPowerShell -Force

# Import Module 
Import-Module -Name AWSPowerShell -Force

# Install AWSPowerShell Module 
# Link - https://www.powershellgallery.com/packages/AWSPowerShell/4.1.14.0
Install-Module -Name AWSPowerShell

# Get ExecutionPolicy
Get-ExecutionPolicy -List

# Set the ExecutionPolicy of the Process to Unrestricted
Set-ExecutionPolicy -Scope Process Unrestricted

# Get Commands
Get-Command -Name "*AWS*"
#EndRegion FT
# =======================================================================================


#Region Play===================================================================================
# Get AWSPowerShellVersion
Get-AWSPowerShellVersion 

# Get AWS Credentials
Get-AWSCredential -ListProfileDetail

Get-AWSCredential -ProfileName "default"

Get-AWSCredential

#Get Help of Set-Aws Cmdlet
Get-Help Set-AWSCredential -Full

#Get AWS default region 
Get-DefaultAWSRegion

#Stop the instance
Stop-EC2Instance -InstanceId "i-0fffdd7a07b129f58" -Region "eu-west-2" -ProfileName "DefaultSetKeys"

# TCP test connection 
Test-NetConnection -ComputerName "137.117.241.97" -Port 5986 -InformationLevel Detailed | Format-List

# Get instance You want to start
# Get-EC2Instance -InstanceId "i-0fffdd7a07b129f58" -Region "eu-west-2" -ProfileName "DefaultSetKeys"


# ------------------------------------------------------------------------------------------------------------------
# # Set AWS Credentials
# # Set-AWSCredential -AccessKey "AKIAUHIVJOQQN3YNLCUU" -SecretKey "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" -StoreAs "DefaultSetKeys"

# # Get EC2 instance
# # Get-EC2Instance -InstanceId "i-0fffdd7a07b129f58" -ProfileName "DefaultSetKeys" -Region "eu-west-2" | Format-List

# Write-Host {awsaccesskey.name}

# Write-Host {awssecretkey.name}

# Write-Host {awsregion.name}

# Set-AWSCredential -AccessKey {awsaccesskey.name} -SecretKey {awssecretkey.name} -StoreAs "DefaultSetKeys"

# Get-EC2Instance -InstanceId "i-0fffdd7a07b129f58" -ProfileName "DefaultSetKeys" -Region {awsregion.name}
# ------------------------------------------------------------------------------------------------------------------
# # Install AWSPowerShell Module 
# Install-Module -Name AWSPowerShell -Confirm:$false -Force

# #Unistall Test Module
# Uninstall-Module -Name AWSPowerShell -Confirm:$false -Force

Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy Undefined
#  Clear variable
Get-Variable | Remove-Variable

# Set AWS Credentials
Set-AWSCredential -AccessKey $AccessKeyValue -SecretKey $SecretKeyValue -StoreAs $ProfileNameVaule

# Get EC2 instance
Get-EC2Instance -InstanceId $InstanceIdVaule -ProfileName $ProfileNameVaule -Region $RegionVaule | Format-List

# Get EC2 instance
# Get-AWSCredential -ProfileName "DefaultSetKeys" | Remove-AWSCredentialProfile

# Remove Profile
# Remove-AWSCredentialProfile -ProfileName $ProfileNameVaule -Force
#EndRegion Play===================================================================================




#Region =============================== Main Work ====================================
# Import Module for AWS PowerShell
Import-Module -Name AWSPowerShell

# Save accesskey to this Variable
$Script:AccessKeyValue = "AKIAUHIVJOQQN3YNLCUU"

# Save secretkey to this variable
$Script:SecretKeyValue = "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"

# Set value to store profile 
$Script:ProfileNameVaule = "DefaultSetKeys"

# Hash Table of InstanceId with coressponding region pair
$Script:HashValue = @{ 
    "i-0886cdf673b05587d" = "eu-west-2";
    "i-0fffdd7a07b129f58" = "eu-west-2";
    "i-01109b6fb6b9d30dc" = "eu-west-2"
}

# Set AWS Credentials
Set-AWSCredential -AccessKey $Script:AccessKeyValue -SecretKey $Script:SecretKeyValue -StoreAs $Script:ProfileNameVaule

# Loop through has table of EC2 instances and their region
foreach ($item in $Script:HashValue.GetEnumerator()) {

    # echo the message
    Write-Output "EC2 instace with InstanceId $($item.Name) in $($item.Value) region is starting..." 

    # Get EC2 instance
    Get-EC2Instance -InstanceId $($item.Name) -ProfileName $Script:ProfileNameVaule -Region $($item.Value)

    #Start the instance
    # Start-EC2Instance -InstanceId $($item.Name) -Region $($item.Value) -ProfileName $Script:ProfileNameVaule

}
# Remove Profile
Remove-AWSCredentialProfile -ProfileName $Script:ProfileNameVaule -Force
#EndRegion =============================== Main Work ====================================

#Region for ExecutionPolicy 
# Get Execution Policy of the current process
$Script:ProcessEP = Get-ExecutionPolicy -Scope Process

#Get the value of the Execution Policy and save it in the Variable
$Script:ValueProcessEP = ($Script:ProcessEP).value__

# Check if the Execution Policy of the process is set to Unrestricted
if ($Script:ValueProcessEP -eq 0) {

    # echo the message
    Write-Output "Execution Policy is already set to Unrestricted for the Process"

}else{

    # Set the ExecutionPolicy of the Process to Unrestricted
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false

    # Checks if the Execution Policy has been set
    if ((Get-ExecutionPolicy -Scope Process).value__ -eq 0) {

        # echo the message
        Write-Output "Execution Policy is now set to Unrestricted for the Process"
    }
}
#EndRegion for ExecutionPolicy 



#Region Check if AWSPowerShell Module is installed 
# ===========================================================================
# Set Error Variable
$Script:ErrorAWSV = $null
# ===========================================================================
# Get-Module -All -Name AWSPowerShell
$Script:GetAWSModule = Get-InstalledModule -Name AWSPowerShelrl -ErrorVariable +ErrorAWSV -ErrorAction SilentlyContinue
# ===========================================================================
#Region if module is installed, update module if version is not up to Version "4.1.13.0"
# Check the error variable for the AWS PowerShell get installed module cmdlet is empty or not 
if($null -ne $Script:ErrorAWSV[0]) {
    
    # No errors the AWS Powershell Module is installled but might need to be updated
    # echo the message
    Write-Output "AWS PowerShell Module exists ... checking ..."

    # Gets the build number for the AWS Module 
    $Script:AWSModuleBuild = (($Script:GetAWSModule).Version).Build

    # Checks the build number to meet requirements 
    if($Script:AWSModuleBuild -lt 13) {

        # echo the message
        Write-Output "Updating the AWS PowerShell Module..."

        # Uppdates the AWSPoerShell Module to the latest version
        Update-Module -Name AWSPowerShell -Confirm:$false -Force 

        # echo the message
        Write-Output "AWS PowerShell Module is updated :)"

    # Check builld if the version greater 13
    }elseif ($Script:AWSModuleBuild -gt 13) {

        # Saves and converts Module version name to a variable
        $Script:OutVersion = ((($Script:GetAWSModule).Version)).tostring()

        # echo the message
        Write-Output "A higher version of AWSPowerShell Module Version ($Script:OutVersion) is installed and should meet requirement."
    
    # Check if the build version is on 13
    }elseif($Script:AWSModuleBuild -eq 13) {

        # echo the message
        Write-Output "AWSPowerShell Module Version $Script:OutVersion meets the minimum requirement."
    }

#EndRegion if module is installed, update module if version is not up to Version "4.1.13.0"
# ===========================================================================
#Region If module is not installed, install it 
}elseif($null -eq $Script:ErrorAWSV[0]) {

    # echo the message
    Write-Output "AWS PowerShell Module is not installed"
    
    # echo the message
    Write-Output "AWS PowerShell Module is installing..."

    # Install AWS Powershell Module 
    Install-Module -Name AWSPowerShell -MaximumVersion "4.1.13.0" -Scope "CurrentUser" -AllowClobber:$true -Confirm:$false -Force

    # echo the message
    Write-Output "AWS PowerShell Module is installed :)"

}


$Script:HashValue = @{"i-0fffdd7a07b129f58"="eu-west-2";"i-01109b6fb6b9d30dc"="eu-west-2"}

(Get-EC2Instance -InstanceId "i-01109b6fb6b9d30dc" -ProfileName "DefaultSetKeys" -Region "eu-west-2").Instances | Format-List

#EndRegion If module is not installed, install it 

#EndRegion Check if AWSPowerShell Module is installed 