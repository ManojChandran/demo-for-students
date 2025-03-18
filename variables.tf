variable "aws-region" {
  description = "stored aws region data(N. Virginia)"
  default     = "ap-south-1"
}

variable "aws-ami" {
  description = "stored aws ami info"
  default     = "ami-05c179eced2eb9b5b"
}

variable "aws-instance-type" {
  description = "stored aws ami instance type"
  default     = "t2.micro"
}