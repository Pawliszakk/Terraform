variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "tags" {
  type = map(string)
  default = {
    ManagedBy = "terraform"
    Project   = "aws"
  }
}

variable "public_key" {
  type = string
}


variable "instance_count" {
  type    = number
  default = 16
}

locals {
  ec2_instances = {
    for i in range(1, var.instance_count + 1) :
    "ubuntu-${i}" => "t3.micro"
  }
}