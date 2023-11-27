terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
  access_key = "AKIA2PQHCCMHLHDDN3L5"
  secret_key = "U9M6IuOYxKytXnUUj33x/QwPbGNpgS6LyW/HpMI+"
}
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # Set your desired CIDR block
  tags = {
    Name = "My-VPC"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"  # Set your desired CIDR block
  availability_zone       = "ap-south-1a"  # Set your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet"
  }
}
resource "aws_instance" "instance1" {
  ami = "ami-0287a05f0ef0e9d9a"
  count = 2
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name = "ubuntu-ajith"
  tags = {
    Name = "jenkins"
  }
}


