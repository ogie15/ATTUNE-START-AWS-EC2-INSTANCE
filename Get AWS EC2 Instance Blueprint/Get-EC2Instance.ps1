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
# Check if the Execution Policy of the process is already set
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



#Region Start EC2 Instance
# ===========================================================================
# Import Module for AWS PowerShell
Import-Module -Name AWSPowerShell

# Save accesskey to this Variable
$Script:AccessKeyValue = "{accesskey.value}"

# Save secretkey to this variable
$Script:SecretKeyValue = "{secretkey.value}"

# Set value to store profile 
$Script:ProfileNameVaule = "DefaultSetKeys"

# Hash Table of InstanceId with coressponding region pair
$Script:HashValue = {hashvalue.value}

# Set AWS Credentials
Set-AWSCredential -AccessKey $Script:AccessKeyValue -SecretKey $Script:SecretKeyValue -StoreAs $Script:ProfileNameVaule

# Loop through has table of EC2 instances and their region
foreach ($item in $Script:HashValue.GetEnumerator()) {

    # echo the message
    Write-Output "Getting EC2 instance with InstanceId $($item.Name) in $($item.Value) region" 

    # Get EC2 instance
    Get-EC2Instance -InstanceId $($item.Name) -ProfileName $Script:ProfileNameVaule -Region $($item.Value)

}

# Remove Profile
Remove-AWSCredentialProfile -ProfileName $Script:ProfileNameVaule -Force

#EndRegion Start EC2 Instance
# ===========================================================================
#EndRegion =============================== START EC2 SCRIPT ====================================