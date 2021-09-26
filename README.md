# Using Attune to start AWS EC2 Instance

This Blueprint is used for starting single or multiple AWS EC2 Instances.

An EC2 instance is a virtual server in Amazon Web services. It stands for Elastic Compute Cloud.

It is a web service where an AWS user can provision a compute server in the AWS cloud.

## Pre-Blueprint Attune setup

1. On the Inputs tab, create a Windows Node for the host you wish to run the AWS EC2 shutdown script.
1. On the Inputs tab, create a Windows Credentials to connect to the host you wish to run the AWS EC2 shutdown script.
1. On the Inputs tab, create a Text value to store the values below:
    - AccessKey: This is the AWS IAM User access key (DataType: String).
    - SecretKey: This is the AWS IAM User secret key (DataType: String).
    - HashValue: This holds a hash table containing the EC2 InstanceId and Region (DataType: Hashtable).

---

*HashValue Syntax:*

```powershell
@{"instanceid1"="region1";"instanceid2"="region2"}
```

```powershell
@{"i-0ffhdd7a07b129f59"="eu-west-2";"i-01109b6fb6b9d30fe"="eu-west-1"}

```

**NOTE**: *Ensure to edit the value of the parameters `AccessKey` and `SecretKey` in Attune to match the AWS IAM User Credential with the privilege to perform this operation.*

**NOTE**: *The `InstanceId` and `Region` should be edited as well to match the EC2 Instance(s).*

---

## Blueprint Steps

1. Check and Install the AWS PowerShell Module
1. Start the AWS EC2 Instance(s)
