# Terraform Basics
Repo dels with terraform basics, help you to install and use terraform.

## Installation
Follow the commands to complete Terraform installation for ubuntu:
```
$ sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
$ sudo apt-get update && sudo apt-get install terraform
```
Verify installation by version check:

```
$ terraform --version
Terraform v0.15.3
on linux_amd64
+ provider registry.terraform.io/hashicorp/aws v3.42.0
```

## Set AWS account
By default, Terraform can detects AWS credentials set in our environment and uses them to sign requests to AWS. That way we don't need to manage credentials in your applications. The set your credentials in the following environment variables:

AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY /AWS_SESSION_TOKEN (optional)

The following examples show how you configure the environment variables.

Linux or Unix

```
$ export AWS_ACCESS_KEY_ID="YOUR_AKID"
$ export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_KEY"
$ export AWS_SESSION_TOKEN="TOKEN"
$ export AWS_REGION="us-east-1"
```

Windows
```
C:\> set AWS_ACCESS_KEY_ID="YOUR_AKID"
C:\> set AWS_SECRET_ACCESS_KEY="YOUR_SECRET_KEY"
C:\> set AWS_SESSION_TOKEN="TOKEN"
C:\> set AWS_REGION="us-east-1"
```

## Main commands:
fmt - Reformat your configuration in the standard style
```
$ terraform fmt
```
init - Prepare your working directory for other commands 
```
terraform  init
```
validate - it’s check all the terraform files and confirm all files are proper, executable/deployable by terraform apply command.
```
terraform validate
```
plan - Show changes required by the current configuration
```
terraform plan
```
apply - Create or update infrastructure
```
terraform apply
```
destroy - Destroy previously-created infrastructure
```
terraform destroy
```

## State file
Backends define where Terraform's state snapshots are stored. Please find code to store the state file in AWS s3, 
assume bucket is created and have access.
```
  backend "s3" {
    bucket = "myterraformstatebackupfile2019"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
```
## Reference
Link 1 : https://learn.hashicorp.com/tutorials/terraform/install-cli
Link 2 : https://registry.terraform.io/browse/providers
Link 3 : https://registry.terraform.io/providers/hashicorp/aws/latest/docs
Link 4 : https://www.terraform.io/cloud-docs/run/install-software
Link 5 : https://www.youtube.com/watch?v=h970ZBgKINg&t=602s
