# This step starts the AWS EC2 instance(s)

- *The script first gets the execution policy of the current PowerShell session.*
- *Then checks if the execution policy is set  to Unrestricted.*
- *If it's not, it then sets the execution policy to Unrestricted for the current session.*

---

First, the AWSPowerShell module is imported to the current session.

Then the values below are set:

1. AccessKeyValue: This is the AWS IAM User access key (DataType: String)
1. SecretKeyValue: This is the AWS IAM User secret key (DataType: String)
1. ProfileNameVaule: This holds the user-defined AWS credentials (DataType: String)
1. HashValue: This holds a hashtable containing the EC2 InstanceId and Region (DataType: Hashtable)

---

The HashValue is a Hashtable that holds the InstanceID with its corresponding Region.

*Hash Table Value Syntax:*

```powershell
@{"instanceid1"="region1";"instanceid2"="region2"}
```

```powershell
@{"i-0ffhdd7a07b129f59"="eu-west-2";"i-01109b6fb6b9d30fe"="eu-west-1"}
```

---

**NOTE**: *Ensure to edit the value of the parameters `AccessKey` and `SecretKey` in Attune to match the IAM AWS User Credential with the privilege to perform this operation.*

**NOTE**: *The `InstanceId` and `Region` should be edited as well to match the EC2 Instance(s).*
