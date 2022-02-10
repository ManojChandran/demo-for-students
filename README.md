# Terraform
Terraform is an open-source infrastructure provisioning software tool, created by HashiCorp. 
* Terraform is written in Golang.
* Terraform exercises core principle of infrastructure mutation or Mutable infrastructure.
* Terraform uses HCL (Hashicorp configuration language) to provision infrastructure.
* Terraform is best suitable for Infrastructure Provisioning

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
## CLONE 

Below repo provides a practical AWS ec2 webserver implementation. Its created for learning purpose and cover all the basic steps needed to provision infrastruture in AWS.

clone the repo, using git command.
```
$ git clone https://github.com/ManojChandran/demo-for-students.git
```

## Set AWS account
As a pre-requisit for the learning, get a free tier AWS account. The AWS provider offers a flexible means of providing credentials for authentication, we have used `Environment variable` method.

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

## Provisioners

This project require provisioners to run linux commands inside the EC2 for building a WEB server. To enable terraform provisioners, we need to establish a SSH connection. If you refer the `main.tf`, you can see SSH port 22 enabled in security groups and connection block defined with private key. This key pair is generated from AWS EC2 UI option Key pair, which will allow you to create a key pair with a specific name(i have used demokey.pem). 

```go

resource "aws_instance" "web" {
  ami           = "ami-04505e74c0741db8d"
  security_groups = ["${aws_security_group.web-sg.name}"]
  instance_type = "t3.micro"
  key_name 		= "demokey"     // <- demokey referenced from AWS for Public key
.
.
.
 
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("demokey.pem")  // <- demokey.pem file stored in repo directory
    host     = "${self.public_ip}"
  }

```
## State file
State file management is an important piece in Terraform, It uses state file as reference for real world infrastructure and take decisions on provioning new. In this example we are trying to use remote backup of state file in AWS s3 bucket. Backends define where Terraform's state snapshots are stored and code below store the state file in AWS s3 bucket.

we assume bucket is created and have access.
```go
  backend "s3" {
    bucket = "myterraformstatebackupfile2019"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
```

## Main commands:
Navigate in to our project directory, follow the below basic commands.

init - Prepare your working directory for other commands 
```
terraform init
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
## Conclusion
We have learned basic terraform setup and basic operations with this exercise.

## Reference
Link 1 : https://learn.hashicorp.com/tutorials/terraform/install-cli </br>
Link 2 : https://registry.terraform.io/browse/providers </br>
Link 3 : https://registry.terraform.io/providers/hashicorp/aws/latest/docs </br>
Link 4 : https://www.terraform.io/cloud-docs/run/install-software  </br>
Link 5 : https://www.youtube.com/watch?v=h970ZBgKINg&t=602s  </br>
Link 6 : https://www.youtube.com/watch?v=3hCbOcCO0yk </br>
