#Region for ExecutionPolicy
# Get Execution Policy of the current process
$Script:ProcessEP = Get-ExecutionPolicy -Scope Process

#Get the value of the Execution Policy and save it in the Variable
$Script:ValueProcessEP = ($Script:ProcessEP).value__

# Check if the Execution Policy of the process is set to Unrestricted
if ($Script:ValueProcessEP -eq 0) {

    # Write the message
    Write-Output "Execution Policy is already set to Unrestricted for the Process"
    # Check if the Execution Policy of the process is already set
}else{

    # Set the ExecutionPolicy of the Process to Unrestricted
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false

    # Checks if the Execution Policy has been set
    if ((Get-ExecutionPolicy -Scope Process).value__ -eq 0) {

        # Write the message
        Write-Output "Execution Policy is now set to Unrestricted for the Process"
    }
}
#EndRegion for ExecutionPolicy 


#Region to Check if AWSPowerShell Module is installed 
if ($null -ne (Get-InstalledModule -Name AWSPowerShell -MinimumVersion "4.1.13.0" -ErrorVariable +ErrorAWSV -ErrorAction SilentlyContinue)) {

    # Get the AWS module installed and save it in a variable
    $Script:GetAWSModule = Get-InstalledModule -Name AWSPowerShell -MinimumVersion "4.1.13.0" -ErrorVariable +ErrorAWSV -ErrorAction SilentlyContinue

    # echo the message
    Write-Output "AWS PowerShell Module exists ... checking ..."

    # Gets the build number for the AWS Module 
    $Script:AWSModuleBuild = ($Script:GetAWSModule).Version

    # Checks the build number to meet requirements 
    if ($Script:AWSModuleBuild -like "*4.1.13.0*") {

        # Saves and converts Module version name to a variable
        $Script:OutVersion = ((($Script:GetAWSModule).Version)).tostring()

        # echo the message
        Write-Output "AWSPowerShell Module Version $Script:OutVersion meets the minimum requirement."

        # Check if the build version is on 13
    }else{
        
        # echo the message
        Write-Output "AWS PowerShell Module is updated :)"
    }
}else{
    # echo the message
    Write-Output "AWS PowerShell Module is not installed"
    
    # echo the message
    Write-Output "AWS PowerShell Module is installing..."

    # Install AWS Powershell Module 
    Install-Module -Name AWSPowerShell -MaximumVersion "4.1.13.0" -Scope "CurrentUser" -AllowClobber:$true -Confirm:$false -Force

    # echo the message
    Write-Output "AWS PowerShell Module is installed :)"
}
#EndRegion Check if AWSPowerShell Module is installed