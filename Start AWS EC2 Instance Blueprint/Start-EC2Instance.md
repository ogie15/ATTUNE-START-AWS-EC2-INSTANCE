## **Start-EC2instance**
> #### **Region for ExecutionPolicy**
> - *The script above first gets the execution policy of the current PowerShell session.*
> 
> - *Then checks if it is set to Unrestricted.*
> 
> - *`If` it is set, then skips and echos a message to the screen.*
>
> - *`Else` it sets the execution policy to Unrestricted.*
> ---
> #### **Region for Start EC2 Instance**
> 
> - *First the AWSPowerShell Module is imported to the current session.*
> - *Then the values below are set:*
>
> > | Variable Name | Description | Value |
> > | :----: | :----: | :---: |
> > | AccessKeyValue | This is the AWS IAM User access key | {accesskey.value} |
> > | SecretKeyValue | This is the AWS IAM User secret key | {secretkey.value} |
> > | ProfileNameVaule | This holds the user defined AWS credentials | DefaultSetKeys |
> > | HashValue | This holds a hash table containing the EC2 InstanceId and Regoin | {hashvalue.value} |
> > > ---
> > > #### *Below is a table explaining how to create the variables on Attune with matching data types:*
> > > ---
> > > | Vaule in script | Value Location in Attune | Parameter location in Attune| Data Type | Example |
> > > | :----: | :---: | :---: | :---: | :---: |
> > > | {accesskey.value} | (value) Inputs->Text Vaules->Variable | (access) Inputs->Text Vaules->Name | String | HKOPUHIVJOQQN3YNLCIL |
> > > | {secretkey.value} | (value) Inputs->Text Vaules->Variable | (secretkey) Inputs->Text Parameter->Name | String | MJYj7oBcNMTe+R+TTIWdQqXLYcttQ8IOwh1O9zH5 | 
> > > | {hashvalue.value} | (value) Inputs->Text Vaules->Variable | (hashvalue) Inputs->Text Parameter->Name | Hash Table | @{"i-0ffhdd7a07b129f59"="eu-west-2";"i-01109b6fb6b9d30fe"="eu-west-1"} |
> > > > ---
> > > > The Hash Table holds the InstanceID with it's corresponding Region.
> > > > ##### *Hash Table Value Syntax:* 
> > > > ```powershell
> > > > @{"instanceid1"="region1";"instanceid2"="region2"}
> > > > ```
> > > > ```powershell
> > > > @{"i-0ffhdd7a07b129f59"="eu-west-2";"i-01109b6fb6b9d30fe"="eu-west-1"}
> > > > ```
> > > > ---
> > > ---
> - *Next the IAM AWS credentials are set using the `Set-AWSCredential` CMDLET*
> - *__NOTE__: Ensure to edit the values of the parameters `AccessKey` and `SecretKey` in Attune to match the IAM user credential with privileges to perform this operation*
> - *Next will be to loop through the values of the InstanceID and their corresponding Region and then Starts the EC2 instance using the `Start-EC2Instance` CMDLET*
> - *__NOTE__: The `InstanceId` and `Region` parameters are gotten from the Hash Table created in Attune*
> - *Finally a CMDLET `Remove-AWSCredentialProfile` is run to remove the credential profile created in the session from the local credential store*
> ---
[![SERVERTRIBE](https://www.servertribe.com/wp-content/themes/mars/assets/images/attune_logo.svg)](https://www.servertribe.com/)
***&copy;2021 Powered by ServerTribe***