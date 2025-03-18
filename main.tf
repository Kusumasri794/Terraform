terraform {
 required_providers {
  aws = {
    source = "hashicorp/aws"
    version = "5.73.0"
    }
  }
 } 


#configure the ws providers

provider "aws" {
region = "us-east-1"
}

resource "aws_instance" "webserver" {
instance_type = "t2.micro"
ami = "ami-0d5eff06f840b45e9"
vpc_security_group_ids = [aws_security_group.webserver-sg.id]
tags = {
Name = "web-server"
}

}


# Create Web Security Group
resource "aws_security_group" "webserver-sg" {
  name        = "webserver-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 tags = {
    Name = "Web-SG"
  }
}

# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "swiggy-VPC"
  }
}
