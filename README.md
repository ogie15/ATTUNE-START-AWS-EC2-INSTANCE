# Using Attune to start AWS EC2 Instance

This Blueprint is used for starting single or multiple AWS EC2 Instances.
An EC2 instance is a virtual server in Amazon Web services.
It stands for Elastic Compute Cloud.
It is a web service where an AWS user can provision a compute server in the AWS cloud.

## Pre-Blueprint Attune setup

1. On the Inputs tab, create a Windows Node for the host you wish to run this Blueprint.
1. On the Inputs tab, create a Windows Credentials to connect to the host you wish to run this Blueprint.
1. On the Inputs tab, create a Text value to store the values below:
    - AccessKeyValue: This is the AWS IAM User access key.
    - SecretKeyValue: This is the AWS IAM User secret key.
    - ProfileNameVaule: This holds the user-defined AWS credentials.
    - HashValue: This holds a hash table containing the EC2 InstanceId and Region.

## Blueprint Steps

1. Check and Install the AWS PowerShell Module
1. Start the AWS EC2 Instance(s)
