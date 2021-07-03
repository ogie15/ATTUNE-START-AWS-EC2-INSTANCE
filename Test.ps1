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

# Remove Profile
Remove-AWSCredentialProfile -ProfileName OjTest -Force

#Get Help of Set-Aws Cmdlet
Get-Help Set-AWSCredential -Full

#Get AWS default region 
Get-DefaultAWSRegion
#EndRegion Play===================================================================================


#Region =============================== Main Work ====================================
Set-AWSCredential -AccessKey "AKIAUHIVJOQQN3YNLCUU" -SecretKey "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" -StoreAs "OjTest"

# Get EC2 instance
Get-EC2Instance -ProfileName "OjTest" | Format-List

# Get instance You want to start
Get-EC2Instance -InstanceId "i-0fffdd7a07b129f58" -ProfileName "OjTest"

#Start the instance 
Start-EC2Instance -InstanceId "i-0fffdd7a07b129f58" -ProfileName "OjTest"

#Stop the instance
Stop-EC2Instance -InstanceId "i-0fffdd7a07b129f58" -ProfileName "OjTest"

#  Clear variable
Get-Variable | Remove-Variable 
#EndRegion =============================== Main Work ====================================
# Next try to create a file that will be created and deleted after it runs   
# https://subscription.packtpub.com/book/networking_and_servers/9781785884078/6/ch06lvl1sec71/stopping-the-ec2-instance#:~:text=For%20stopping%20an%20EC2%20instance,passing%20the%20instance%20reservation%20ID.