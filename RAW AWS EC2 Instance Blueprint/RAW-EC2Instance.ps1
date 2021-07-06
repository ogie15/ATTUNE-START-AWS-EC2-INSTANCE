#Region for ExecutionPolicy
# ===========================================================================
# Get Execution Policy of the current process
$Script:ProcessEP = Get-ExecutionPolicy -Scope Process

#Get the value of the Execution Policy and save it in the Variable
$Script:ValueProcessEP = ($Script:ProcessEP).value__

# Check if the Execution Policy of the process is set to Unrestricted
if ($Script:ValueProcessEP -eq 0) {

    # echo the message
    Write-Output "Execution Policy is already set to Unrestricted for the Process"
# Check if Execution Policy of the process is already set
}else{

    # Set the ExecutionPolicy of the Process to Unrestricted
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false

    # Checks if the Execution Policy has been set
    if ((Get-ExecutionPolicy -Scope Process).value__ -eq 0) {

        # echo the message
        Write-Output "Execution Policy is now set to Unrestricted for the Process"
    }
}
# ===========================================================================
#EndRegion for ExecutionPolicy 



#Region Check if AWSPowerShell Module is installed 
# ===========================================================================
#Region if module is installed, update module if version is not up to Version "4.1.13.0"
if($null -ne (Get-InstalledModule -Name AWSPowerShell -ErrorVariable +ErrorAWSV -ErrorAction SilentlyContinue)) {

    # Get the AWS module installed and save it in a variable
    $Script:GetAWSModule = Get-InstalledModule -Name AWSPowerShell -ErrorVariable +ErrorAWSV -ErrorAction SilentlyContinue

    # echo the message
    Write-Output "AWS PowerShell Module exists ... checking ..."

    # Gets the build number for the AWS Module 
    $Script:AWSModuleBuild = ($Script:GetAWSModule).Version

    # Checks the build number to meet requirements 
    if($Script:AWSModuleBuild -like "*4.1.14.0*") {

        # Saves and converts Module version name to a variable
        $Script:OutVersion = ((($Script:GetAWSModule).Version)).tostring()

        # echo the message
        Write-Output "AWSPowerShell Module Version $Script:OutVersion meets the minimum requirement."

    # Check if the build version is on 13
    }else{

        # echo the message
        Write-Output "Updating the AWS PowerShell Module..."

        # Uppdates the AWSPoerShell Module to the latest version
        Update-Module -Name AWSPowerShell -Confirm:$false -Force 

        # echo the message
        Write-Output "AWS PowerShell Module is updated :)"
    }
#EndRegion if module is installed, update module if version is not up to Version "4.1.13.0"
# ===========================================================================
#Region If module is not installed, install it 
}else{

    # echo the message
    Write-Output "AWS PowerShell Module is not installed"
    
    # echo the message
    Write-Output "AWS PowerShell Module is installing..."

    # Install AWS Powershell Module 
    Install-Module -Name AWSPowerShell -MaximumVersion "4.1.14.0" -Scope "CurrentUser" -AllowClobber:$true -Confirm:$false -Force

    # echo the message
    Write-Output "AWS PowerShell Module is installed :)"
}
#EndRegion If module is not installed, install it
# ===========================================================================
#EndRegion Check if AWSPowerShell Module is installed 




#Region Start EC2 Instance
# ===========================================================================
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

    # Start the instance
    # Start-EC2Instance -InstanceId $($item.Name) -Region $($item.Value) -ProfileName $Script:ProfileNameVaule

    # Stop the instance
    # Stop-EC2Instance -InstanceId $($item.Name) -Region $($item.Value) -ProfileName $Script:ProfileNameVaule

}

# Remove Profile
Remove-AWSCredentialProfile -ProfileName $Script:ProfileNameVaule -Force

#EndRegion Start EC2 Instance
# ===========================================================================
#EndRegion =============================== START EC2 SCRIPT ====================================
