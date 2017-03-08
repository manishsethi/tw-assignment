
variable "key_name" {
  description = "Desired name of AWS key pair"
  default = "tw-key"
}



variable "key_file_path" {
  description = "Private Key Location"
  default = "/vagrant/tw_assignment/tw_key.pem"
}


variable "aws_region" {
  description = "AWS region to launch servers."
  default = "us-east-1"
}


# Centos 7 (x64)
variable "aws_amis" {
  default = {
    #eu-west-1 = "ami-b1cf19c6"
    us-east-1 = "ami-1c221e76"
    #us-east-1 = "ami-e881c6ff"
    #us-west-1 = "ami-3f75767a"
    #us-west-2 = "ami-21f78e11"
  }
}


variable "vpc_cidr"{
  default = "10.10.0.0/16"
}

variable "subnet_cidr"{
  default = "10.10.0.0/24"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
