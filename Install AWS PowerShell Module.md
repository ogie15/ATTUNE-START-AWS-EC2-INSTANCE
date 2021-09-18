# This step installs the AWS PowerShell Module

- *The script first gets the execution policy of the current PowerShell session.*
- *Then checks if the execution policy is set  to Unrestricted.*
- *If it's not, it then sets the execution policy to Unrestricted for the current session.*
- *Next, it checks if the AWS PowerShell module is installed.*
- *If it's not installed, it then goes ahead to install the module.*
