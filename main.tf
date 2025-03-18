provider "aws" {
region = "us-east-1"
}

resource "aws_instance" "one" {
instance_type = "t2.micro"
ami = ""
tags = {
Name = "web-server"
}

