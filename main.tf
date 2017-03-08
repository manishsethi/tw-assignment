

# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "tw-mediawiki"
  }
}


# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "default" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.subnet_cidr}"
  map_public_ip_on_launch = true
}





# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "tw_sg"
  description = "Security group for tw"
  vpc_id      = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Our default security group to access
# the instances over SSH and HTTP for mysql
resource "aws_security_group" "mysql" {
  name        = "tw_sg_mysql"
  description = "Security group for tw"
  vpc_id      = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }


  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Our default security group to access
# the instances over SSH and HTTP for mysql
resource "aws_security_group" "haproxy" {
  name        = "tw_sg_haproxy"
  description = "Security group for tw"
  vpc_id      = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Our default security group to access
# the instances over SSH and HTTP for mysql
resource "aws_security_group" "chef" {
  name        = "tw_sg_chef"
  description = "Security group for tw"
  vpc_id      = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}








resource "aws_instance" "mysql" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)

  connection {
   type = "ssh"
   private_key = "${file("/vagrant/tw_assignment/ms-manish.pem")}"
   user = "centos"
 }
  key_name="ms-manish.pem"
  # Tags for machine

  tags {Name = "tw-mysql"}
  instance_type = "t2.micro"
  # Number of EC2 to spin up
  count = "1"
  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair we created above.
  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.mysql.id}"]
  subnet_id = "${aws_subnet.default.id}"

  provisioner "remote-exec" {
        inline = [
        "sudo yum install vim git wget -y",
        "sudo yum install mysql-server mysql -y"
        ]
    }

}

resource "aws_instance" "web1" {
  # Tags for machine
  connection {
   type = "ssh"
   private_key = "${file("/vagrant/tw_assignment/ms-manish.pem")}"
   user = "centos"
   timeout = "10m"
  }
  tags {Name = "tw-mediawiki"}
  instance_type = "t2.micro"
  # Number of EC2 to spin up
  count = "2"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair we created above.
  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id = "${aws_subnet.default.id}"

  provisioner "remote-exec" {
        inline = [
        "sudo yum install vim git wget -y"
        ]
    }

}

resource "aws_instance" "haproxy" {
  # Tags for machine
  connection {
   type = "ssh"
   private_key = "${file("/vagrant/tw_assignment/ms-manish.pem")}"
   user = "centos"
  }
  tags {Name = "tw-haproxy"}
  instance_type = "t2.micro"
  # Number of EC2 to spin up
  count = "1"
  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair we created above.
  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.haproxy.id}"]
  subnet_id = "${aws_subnet.default.id}"


  provisioner "remote-exec" {
        inline = [
        "sudo yum install vim git wget -y"
        ]
    }
}

resource "aws_instance" "chef_server" {
  connection {
    type = "ssh"
    private_key = "${file("/vagrant/tw_assignment/ms-manish.pem")}"
    user = "centos"
  }
  # Tags for machine
  tags {Name = "tw-chefserver"}
  instance_type = "t2.micro"
  # Number of EC2 to spin up
  count = "1"
  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair we created above.
  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.chef.id}"]
  subnet_id = "${aws_subnet.default.id}"
  provisioner "remote-exec" {
        inline = [
        "sudo yum install vim git wget -y"
        ]
    }
}
