
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
if($null -eq $Script:ErrorAWSV[0]) {
    
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
}elseif($null -ne $Script:ErrorAWSV[0]) {

    # echo the message
    Write-Output "AWS PowerShell Module is not installed"
    
    # echo the message
    Write-Output "AWS PowerShell Module is installing..."

    # Install AWS Powershell Module 
    Install-Module -Name AWSPowerShell -MaximumVersion "4.1.13.0" -Scope "CurrentUser" -AllowClobber:$true -Confirm:$false -Force

    # echo the message
    Write-Output "AWS PowerShell Module is installed :)"

}
#EndRegion If module is not installed, install it 

#EndRegion Check if AWSPowerShell Module is installed 