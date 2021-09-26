# This step starts the AWS EC2 instance(s)

The Blueprint first gets the Execution Policy of the current PowerShell session.

Then, checks if the Execution Policy is set to Unrestricted.

If it's not, it then sets the Execution Policy to Unrestricted for the current PowerShell session.

Next, the AWSPowerShell module is imported to the current session.

Then the values below are set:

1. AccessKeyValue: This is the AWS IAM User access key corresponding to the `AccessKey` set in the Inputs Tab.
1. SecretKeyValue: This is the AWS IAM User secret key corresponding to the `SecretKey` set in the Inputs Tab.
1. HashValue: This holds a hashtable containing the AWS EC2 InstanceId and Region corresponding to the `HashValue` set in the Inputs Tab.

Next, the AWS IAM User Credential is set and saved in the local credential store.

Then it loops through the values of the `InstanceID` and their corresponding `Region` and starts the EC2 instance(s).

Finally, the credential profile created in the session is removed from the local credential store.
