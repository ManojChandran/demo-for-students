terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  ## Stores the state file back up in s3 bucket
  ## interpolations cannot be used becasue the actvity is done initial stage
  ## need to create s3 bucket and folder prior to using the backend
  #--------------------------------------------------------------------------
  #backend "s3" {
  #  bucket = "myterraformstatebackupfile2019"
  #  key    = "terraform/terraform.tfstate"
  #  region = "us-east-1"
  #}
}

provider "aws" {
  region = "${var.aws-region}"
}

resource "aws_instance" "web" {
  ami           = "${var.aws-ami}"
  security_groups = ["${aws_security_group.web-sg.name}"]
  instance_type = "${var.aws-instance-type}"
#  key_name 		= "demokey"
  
#  provisioner "remote-exec" {
#    inline = [
#      "sudo apt-get update",
#      "sudo apt-get install apache2 -y",
##      "sudo systemctl start apache2",
#    ]
#
#  }
#  connection {
#    type     = "ssh"
#    user     = "manojchandran"
#    private_key = file("demokey.pem")
#    host     = "${self.public_ip}"
#  }

#  tags = {
#    Name = "terraform Demo"
#  }
}  


resource "aws_security_group" "web-sg" {
  name        = "webserver-sg"
  description = "Security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}