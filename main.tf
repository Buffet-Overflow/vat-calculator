terraform {
    required_providers {
	aws = {
	    source = "hashicorp/aws"
	    version = "~> 5.0"
	}
    }
}
provider "aws" {
    shared_credential_files = [var.creds_file]
    region = "us-east-1"
}
resource "aws_instance" "docker_server" {
    ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
    instance_type = "t3.medium"
    subnet_id = "subnet-0d00f4795213f6ece"
    vpc_security_group_ids = ["vpc-0b9b69df51782d40d"]
    tags = {
	Name = "DockerServer"
    }
    user_data = "${file("init.sh")}"
}
